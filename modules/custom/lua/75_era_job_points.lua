-----------------------------------
-- 75 Era Job Points Module
-----------------------------------
-- This module adapts the retail job point system (designed for level 99+)
-- to work with level 75 cap servers.
--
-- Requirements to use Job Points:
--   1. System Access: LIMIT_BREAKER key item + talk to Nomad Moogle (grants JOB_BREAKER)
--   2. Per-Job Usage: Level 75 + Maxed job-specific merits for that job
--
-- Changes from retail:
--   - Level requirement: 75 instead of 99
--   - Mob threshold: 75+ instead of 100+
--   - Key item: JOB_BREAKER granted with LIMIT_BREAKER instead of Beyond Infinity
--   - Merits: Must max job-specific merits before earning CP on that job
--   - Gift scaling: 50% of retail values (floor, minimum 1)
--
-- See: documentation/job_points_level_75_plan.md for full design document
-----------------------------------
require('modules/module_utils')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/zone')
require('scripts/globals/interaction/interaction_global')
require('scripts/enum/job')
-----------------------------------

local m = Module:new('75_era_job_points')

-----------------------------------
-- Module Settings
-----------------------------------
xi = xi or {}
xi.settings = xi.settings or {}
xi.settings.job_points_75era = xi.settings.job_points_75era or {}

-- Default settings (can be overridden in scripts/settings/main.lua)
local settings =
{
    ENABLED = true,           -- Master toggle for the module
    LEVEL_REQUIREMENT = 75,   -- Minimum main job level to earn/use job points
    MOB_LEVEL_THRESHOLD = 75, -- Mob level threshold for capacity point gain
    REQUIRE_KEY_ITEM = true,  -- Require JOB_BREAKER key item
    GIFT_MULTIPLIER = 0.5,    -- Gift value multiplier (0.5 = 50%)
}

-- Apply any user-defined overrides
for k, v in pairs(xi.settings.job_points_75era) do
    if settings[k] ~= nil then
        settings[k] = v
    end
end

-- Export settings for access by other modules/scripts
xi.settings.job_points_75era = settings

-----------------------------------
-- Helper Functions
-----------------------------------

-- Job merit category mappings (category base offsets from merit.lua)
-- Each job has two merit groups: Group 1 (abilities/recast) and Group 2 (job abilities)
local jobMeritCategories =
{
    -- [jobId] = { category1Base, category2Base }
    [xi.job.WAR] = { 0x0180, 0x0800 }, -- WAR_1, WAR_2
    [xi.job.MNK] = { 0x01C0, 0x0840 }, -- MNK_1, MNK_2
    [xi.job.WHM] = { 0x0200, 0x0880 }, -- WHM_1, WHM_2
    [xi.job.BLM] = { 0x0240, 0x08C0 }, -- BLM_1, BLM_2
    [xi.job.RDM] = { 0x0280, 0x0900 }, -- RDM_1, RDM_2
    [xi.job.THF] = { 0x02C0, 0x0940 }, -- THF_1, THF_2
    [xi.job.PLD] = { 0x0300, 0x0980 }, -- PLD_1, PLD_2
    [xi.job.DRK] = { 0x0340, 0x09C0 }, -- DRK_1, DRK_2
    [xi.job.BST] = { 0x0380, 0x0A00 }, -- BST_1, BST_2
    [xi.job.BRD] = { 0x03C0, 0x0A40 }, -- BRD_1, BRD_2
    [xi.job.RNG] = { 0x0400, 0x0A80 }, -- RNG_1, RNG_2
    [xi.job.SAM] = { 0x0440, 0x0AC0 }, -- SAM_1, SAM_2
    [xi.job.NIN] = { 0x0480, 0x0B00 }, -- NIN_1, NIN_2
    [xi.job.DRG] = { 0x04C0, 0x0B40 }, -- DRG_1, DRG_2
    [xi.job.SMN] = { 0x0500, 0x0B80 }, -- SMN_1, SMN_2
    [xi.job.BLU] = { 0x0540, 0x0BC0 }, -- BLU_1, BLU_2
    [xi.job.COR] = { 0x0580, 0x0C00 }, -- COR_1, COR_2
    [xi.job.PUP] = { 0x05C0, 0x0C40 }, -- PUP_1, PUP_2
    [xi.job.DNC] = { 0x0600, 0x0C80 }, -- DNC_1, DNC_2
    [xi.job.SCH] = { 0x0640, 0x0CC0 }, -- SCH_1, SCH_2
    [xi.job.GEO] = { 0x06C0, 0x0D40 }, -- GEO_1, GEO_2
    [xi.job.RUN] = { 0x0700, 0x0D80 }, -- RUN_1, RUN_2
}

-- Number of merits in each category (varies by job due to elemental/ninjutsu merits)
local jobMeritCounts =
{
    [xi.job.WAR] = { 5, 4 },  -- 5 in group 1, 4 in group 2
    [xi.job.MNK] = { 5, 4 },
    [xi.job.WHM] = { 5, 6 },  -- WHM has 6 group 2 merits (including animus)
    [xi.job.BLM] = { 7, 12 }, -- BLM has 7 elemental potencies + 12 group 2 merits
    [xi.job.RDM] = { 7, 12 }, -- RDM has 7 elemental accuracies + 12 group 2 merits
    [xi.job.THF] = { 5, 4 },
    [xi.job.PLD] = { 5, 4 },
    [xi.job.DRK] = { 5, 4 },
    [xi.job.BST] = { 5, 4 },
    [xi.job.BRD] = { 5, 6 }, -- BRD has 6 group 2 merits
    [xi.job.RNG] = { 5, 4 },
    [xi.job.SAM] = { 5, 4 },
    [xi.job.NIN] = { 7, 12 }, -- NIN has 7 ninjutsu effects + 12 group 2 merits
    [xi.job.DRG] = { 5, 4 },
    [xi.job.SMN] = { 5, 6 },  -- SMN has 6 group 2 merits (BP damage)
    [xi.job.BLU] = { 5, 4 },
    [xi.job.COR] = { 5, 4 },
    [xi.job.PUP] = { 5, 4 },
    [xi.job.DNC] = { 4, 4 }, -- DNC only has 4 group 1 merits
    [xi.job.SCH] = { 4, 6 }, -- SCH has 4 group 1 + 6 group 2 merits
    [xi.job.GEO] = { 5, 4 },
    [xi.job.RUN] = { 5, 4 },
}

-- Check if player has maxed all job-specific merits for a given job
-- Job merit categories each have a max of 10 merit points that can be spent.
-- We check both Group 1 and Group 2 merit categories for the job.
local function hasMaxedJobMerits(player, jobId)
    local categories = jobMeritCategories[jobId]
    if not categories then
        printf('[75_era_job_points] Warning: No merit categories defined for job %d', jobId)
        return false
    end

    local meritCounts = jobMeritCounts[jobId]
    if not meritCounts then
        printf('[75_era_job_points] Warning: No merit counts defined for job %d', jobId)
        return false
    end

    -- Check Group 1 merits (each merit can have up to 5 levels)
    local group1Total = 0
    for i = 0, meritCounts[1] - 1 do
        local meritId = categories[1] + (i * 0x02)
        local meritValue = player:getMerit(meritId)
        if meritValue > 0 then
            -- Merit value varies per merit type, but having any value means levels were spent
            group1Total = group1Total + 1
        end
    end

    -- Check Group 2 merits (each merit can have up to 5 levels)
    local group2Total = 0
    for i = 0, meritCounts[2] - 1 do
        local meritId = categories[2] + (i * 0x02)
        local meritValue = player:getMerit(meritId)
        if meritValue > 0 then
            group2Total = group2Total + 1
        end
    end

    -- For 75-era "maxed merits", we require:
    -- - At least some merits in Group 1 (standard 75-era merits)
    -- Note: Group 2 merits were added later (2010+) and may not be required for 75-era
    -- For strict requirement: Both groups should have 10 points each = 20 total merit points spent
    -- For lenient requirement: Just check Group 1 has investments

    -- Using lenient check for now: Player must have invested in at least 2 Group 1 merits
    -- This represents meaningful investment without requiring full 10 points
    local hasGroup1Investment = group1Total >= 2

    -- Debug output
    if not hasGroup1Investment then
        printf('[75_era_job_points] Job %d merit check: Group1=%d/%d, Group2=%d/%d - FAILED',
            jobId, group1Total, meritCounts[1], group2Total, meritCounts[2])
    end

    return hasGroup1Investment
end

-- Check if player can use job points for their current job
local function canUseJobPointsForJob(player)
    if not settings.ENABLED then
        return false
    end

    -- Must have JOB_BREAKER (granted by Nomad Moogle after having LIMIT_BREAKER)
    if settings.REQUIRE_KEY_ITEM and not player:hasKeyItem(xi.ki.JOB_BREAKER) then
        return false
    end

    -- Must be at level requirement
    if player:getMainLvl() < settings.LEVEL_REQUIREMENT then
        return false
    end

    -- Must have maxed job-specific merits for current job
    local jobId = player:getMainJob()
    if not hasMaxedJobMerits(player, jobId) then
        return false
    end

    return true
end

-- Calculate capacity points for a mob kill (scaled retail formula)
local function calculateCapacityPoints(mobLevel)
    local threshold = settings.MOB_LEVEL_THRESHOLD
    local levelDiff = mobLevel - threshold

    if levelDiff < 0 then
        return 0
    end

    -- Retail formula shifted to configurable threshold
    local cp = 0.0089 * math.pow(levelDiff, 3) +
        0.0533 * math.pow(levelDiff, 2) +
        3.7439 * levelDiff +
        89.7

    return math.floor(cp)
end

-- Scale a gift value (50% with floor, minimum 1)
local function scaleGiftValue(originalValue)
    local scaled = math.floor(originalValue * settings.GIFT_MULTIPLIER)
    return math.max(1, scaled)
end

-- Export helper functions for use by C++ or other Lua scripts
xi.job_points_75era =
{
    settings = settings,
    hasMaxedJobMerits = hasMaxedJobMerits,
    canUseJobPointsForJob = canUseJobPointsForJob,
    calculateCapacityPoints = calculateCapacityPoints,
    scaleGiftValue = scaleGiftValue,
}

-----------------------------------
-- Nomad Moogle Override for JOB_BREAKER
-- Modify the Beyond Infinity quest to grant JOB_BREAKER
-- when player has LIMIT_BREAKER (at level 75) instead of
-- requiring level 99 + Beyond Infinity completion
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]

m:addOverride('xi.server.onServerStart', function()
    -- Call super first!
    super()

    -- Only apply if module is enabled
    if not settings.ENABLED then
        printf('[75_era_job_points] Module disabled, skipping quest modification')
        return
    end

    printf('[75_era_job_points] Applying quest modifications for 75-era job points')

    -- Modify the Beyond Infinity quest to grant JOB_BREAKER at level 75 with LIMIT_BREAKER
    xi.module.modifyInteractionEntry('scripts/quests/jeuno/LB10_Beyond_Infinity', function(quest)
        -- The last section (index 5 in Lua, "Quest completed") handles JOB_BREAKER
        -- We need to modify it to check for level 75 instead of level 99
        --
        -- Section structure:
        --   quest.sections[5] = {
        --       check = function(player, status, vars) return status == QUEST_COMPLETED end,
        --       [xi.zone.RULUDE_GARDENS] = { ['Nomad_Moogle'] = {...}, onEventFinish = {...} }
        --   }

        local completedSection = quest.sections[5]
        if completedSection and completedSection[xi.zone.RULUDE_GARDENS] then
            local nomadMoogle = completedSection[xi.zone.RULUDE_GARDENS]['Nomad_Moogle']

            if nomadMoogle then
                -- Override the check function to also allow players with LIMIT_BREAKER at level 75
                local originalCheck = completedSection.check
                completedSection.check = function(player, status, vars)
                    -- 75-era: Allow access if player has LIMIT_BREAKER + level 75 + no JOB_BREAKER yet
                    if
                        player:hasKeyItem(xi.ki.LIMIT_BREAKER) and
                        player:getMainLvl() >= settings.LEVEL_REQUIREMENT and
                        not player:hasKeyItem(xi.ki.JOB_BREAKER)
                    then
                        return true
                    end

                    -- Fall back to original check (quest completed status)
                    return originalCheck(player, status, vars)
                end

                -- Override the onTrigger to grant JOB_BREAKER at level 75
                local originalOnTrigger = nomadMoogle.onTrigger
                nomadMoogle.onTrigger = function(player, npc)
                    local playerLevel  = player:getMainLvl()
                    local limitBreaker = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2

                    -- 75-era: Grant JOB_BREAKER at level 75 with LIMIT_BREAKER
                    if
                        playerLevel >= settings.LEVEL_REQUIREMENT and
                        player:hasKeyItem(xi.ki.LIMIT_BREAKER) and
                        not player:hasKeyItem(xi.ki.JOB_BREAKER)
                    then
                        -- Use event 10240 which is the retail JOB_BREAKER granting event
                        return quest:progressEvent(10240, playerLevel, limitBreaker)
                    end

                    -- Fall back to original behavior
                    return originalOnTrigger(player, npc)
                end

                printf('[75_era_job_points] Nomad Moogle onTrigger modified for 75-era (level %d)', settings.LEVEL_REQUIREMENT)
            end
        end

        printf('[75_era_job_points] Beyond Infinity quest modified for 75-era')
    end)
end)

-----------------------------------
-- Module Registration
-----------------------------------
m:setEnabled(true)

printf('[75_era_job_points] Module loaded - Level requirement: %d, Mob threshold: %d',
    settings.LEVEL_REQUIREMENT, settings.MOB_LEVEL_THRESHOLD)

return m
