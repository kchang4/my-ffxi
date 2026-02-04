-----------------------------------
-- Hyper Active
-----------------------------------
-- Log ID      : 1
-- Quest ID    : 80
-- Raibaht     : !pos -26 -10 -3 237
-- Cermet Door : !pos 500.87 19.34 91.98 184
-----------------------------------
local metalworksID    = zones[xi.zone.METALWORKS]
local lowerDelkfuttID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]
local lowerJeunoID    = zones[xi.zone.LOWER_JEUNO]
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.HYPER_ACTIVE)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.BASTOK,
    gil = 3000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.BASTOK) >= 4 and
                player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.TEAK_ME_TO_THE_STARS) and
                player:needToZone() == false
        end,

        [xi.zone.METALWORKS] =
        {
            ['Raibaht'] = quest:progressEvent(866, 0, xi.keyItem.HYPER_ALTIMETER, xi.keyItem.MOLYBDENUM_BOX),

            onEventFinish =
            {
                [866] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.keyItem.MOLYBDENUM_BOX)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_DELKFUTTS_TOWER] =
        {
            ['_543'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        -- Pop Orna
                        local orna = GetMobByID(lowerDelkfuttID.mob.ORNA)
                        if not orna:isSpawned() then
                            quest:messageSpecial(lowerDelkfuttID.text.BLOODTHIRSTY_MONSTER_APPEARED)
                            SpawnMob(lowerDelkfuttID.mob.ORNA):updateClaim(player)
                        end
                    end
                    -- keeps door shut
                    return quest:messageSpecial(lowerDelkfuttID.text.DOOR_FIRMLY_SHUT)
                end,
            },

            ['Orna'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                        return quest:progressEvent(26, 0, 0, xi.keyItem.MOLYBDENUM_BOX)
                    end
                end,
            },
            onEventFinish =
            {
                [26] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'Prog', 2)
                        -- pick a random lamp for the hyper altimeter
                        quest:setVar(player, 'LampID', math.random(0, 11))
                    end
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            -- streetlamps 0-11 configured in the loop below
        },

        [xi.zone.METALWORKS] =
        {
            ['Raibaht'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 and player:hasKeyItem(xi.keyItem.HYPER_ALTIMETER) then
                        return quest:progressEvent(867)
                    end
                end,
            },

            onEventFinish =
            {
                [867] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.keyItem.MOLYBDENUM_BOX)
                        player:delKeyItem(xi.keyItem.HYPER_ALTIMETER)   
                    end
                end,
            },
        },
    },
}

local streetLampTrigger = function(player, npc)
    if quest:getVar(player, 'Prog') == 2 then
        local correctLampOffset = quest:getVar(player, 'LampID')
        local currentLampOffset = npc:getID() - lowerJeunoID.npc.STREETLAMP_OFFSET

        if currentLampOffset == correctLampOffset then
            npcUtil.giveKeyItem(player, xi.keyItem.HYPER_ALTIMETER)
            quest:setVar(player, 'Prog', 3)
        end
    end
end

for i = 0, 11 do
    local npcName = string.format("_l%02d", i)
    quest.sections[2][xi.zone.LOWER_JEUNO][npcName] =
    {
        onTrigger = streetLampTrigger,
    }
end

return quest
