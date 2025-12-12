-----------------------------------
-- func: checkmerits <jobid>
-- desc: Checks merit values for a specific job's Group 1 merits
-- auth: GM command for debugging 75-era job points module
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'si',
}

local function showError(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!checkmerits <jobid or jobname> (player)')
end

-- Job merit category base offsets (Group 1 only)
local jobMeritCategories =
{
    [1]  = 0x0180, -- WAR
    [2]  = 0x01C0, -- MNK
    [3]  = 0x0200, -- WHM
    [4]  = 0x0240, -- BLM
    [5]  = 0x0280, -- RDM
    [6]  = 0x02C0, -- THF
    [7]  = 0x0300, -- PLD
    [8]  = 0x0340, -- DRK
    [9]  = 0x0380, -- BST
    [10] = 0x03C0, -- BRD
    [11] = 0x0400, -- RNG
    [12] = 0x0440, -- SAM
    [13] = 0x0480, -- NIN
    [14] = 0x04C0, -- DRG
    [15] = 0x0500, -- SMN
    [16] = 0x0540, -- BLU
    [17] = 0x0580, -- COR
    [18] = 0x05C0, -- PUP
    [19] = 0x0600, -- DNC
    [20] = 0x0640, -- SCH
    [21] = 0x06C0, -- GEO
    [22] = 0x0700, -- RUN
}

-- Number of merits in Group 1 for each job
local jobMeritCounts =
{
    [1]  = 5, -- WAR
    [2]  = 5, -- MNK
    [3]  = 5, -- WHM
    [4]  = 7, -- BLM
    [5]  = 7, -- RDM
    [6]  = 5, -- THF
    [7]  = 5, -- PLD
    [8]  = 5, -- DRK
    [9]  = 5, -- BST
    [10] = 5, -- BRD
    [11] = 5, -- RNG
    [12] = 5, -- SAM
    [13] = 7, -- NIN
    [14] = 5, -- DRG
    [15] = 5, -- SMN
    [16] = 5, -- BLU
    [17] = 5, -- COR
    [18] = 5, -- PUP
    [19] = 4, -- DNC
    [20] = 4, -- SCH
    [21] = 5, -- GEO
    [22] = 5, -- RUN
}

-- Job name to ID mapping
local jobNames =
{
    war = 1,
    mnk = 2,
    whm = 3,
    blm = 4,
    rdm = 5,
    thf = 6,
    pld = 7,
    drk = 8,
    bst = 9,
    brd = 10,
    rng = 11,
    sam = 12,
    nin = 13,
    drg = 14,
    smn = 15,
    blu = 16,
    cor = 17,
    pup = 18,
    dnc = 19,
    sch = 20,
    geo = 21,
    run = 22,
}

commandObj.onTrigger = function(player, jobArg, target)
    -- Parse target
    local targ = player
    if target then
        targ = GetPlayerByName(target)
        if targ == nil then
            showError(player, string.format('Player %s not found!', target))
            return
        end
    end

    -- Parse job argument
    local jobId
    if type(jobArg) == 'number' then
        jobId = jobArg
    elseif type(jobArg) == 'string' then
        local lowerJob = string.lower(jobArg)
        jobId = jobNames[lowerJob]
        if not jobId then
            -- Try parsing as number
            jobId = tonumber(jobArg)
        end
    end

    if not jobId then
        -- Default to current main job
        jobId = targ:getMainJob()
    end

    if not jobMeritCategories[jobId] then
        showError(player, string.format('Invalid job ID: %d', jobId or -1))
        return
    end

    local categoryBase = jobMeritCategories[jobId]
    local meritCount = jobMeritCounts[jobId]
    local currentJob = targ:getMainJob()

    player:printToPlayer(string.format('--- Merit Check for Job %d (current job: %d) ---', jobId, currentJob))
    player:printToPlayer(string.format('Category Base: 0x%04X, Merits in category: %d', categoryBase, meritCount))
    player:printToPlayer(string.format('Target: %s, Level: %d', targ:getName(), targ:getMainLvl()))

    local totalValue = 0
    local meritsWithPoints = 0

    for i = 0, meritCount - 1 do
        local meritId = categoryBase + (i * 0x02)
        local meritValue = targ:getMerit(meritId)
        totalValue = totalValue + meritValue
        if meritValue > 0 then
            meritsWithPoints = meritsWithPoints + 1
        end

        player:printToPlayer(string.format('  Merit[%d] ID 0x%04X (%d): value = %d', i, meritId, meritId, meritValue))
    end

    player:printToPlayer(string.format('Total value: %d, Merits with points: %d/%d', totalValue, meritsWithPoints, meritCount))

    -- Check if job matches
    if currentJob == jobId then
        player:printToPlayer('Job match: YES (should return correct values)')
    else
        player:printToPlayer(string.format('Job match: NO (job %d != %d, values may be 0)', currentJob, jobId))
    end

    -- Check JOB_BREAKER
    if targ:hasKeyItem(xi.ki.JOB_BREAKER) then
        player:printToPlayer('JOB_BREAKER: YES')
    else
        player:printToPlayer('JOB_BREAKER: NO')
    end
end

return commandObj
