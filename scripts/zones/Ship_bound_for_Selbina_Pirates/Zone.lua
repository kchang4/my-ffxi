-----------------------------------
-- Zone: Ship bound for Selbina Pirates (227)
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1
    local ninMob = GetMobByID(ID.mob.ENAGAKURE)
    local hour = VanadielHour()

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end

    -- Enagakure failsafe in case of player logging mid-boat transport
    if not ninMob then
        return cs
    end

    local mobDespawn = ninMob:getLocalVar('closed')

    if VanadielUniqueDay() > mobDespawn then
        if
            player:hasKeyItem(xi.ki.SEANCE_STAFF) and
            player:getCharVar('Enagakure_Killed') == 0 and
            hour < 4 and
            hour >= 20 and
            not ninMob:isSpawned()
        then
            SpawnMob(ID.mob.ENAGAKURE)
        end
    end

    return cs
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    -- don't take action on pirate ship transport departure
    if prevZoneId > 0 then
        player:startEvent(255)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 255 then
        player:setPos(0, 0, 0, 0, xi.zone.SELBINA)
    end
end

zoneObject.onGameHour = function(zone)
    local hour = VanadielHour()
    local ninMob = GetMobByID(ID.mob.ENAGAKURE)

    if not ninMob then
        return
    end

    local mobDespawn = ninMob:getLocalVar('closed')

    -- Check for Enagakure
    if VanadielUniqueDay() > mobDespawn then
        if hour >= 20 or hour < 4 then
            local players = zone:getPlayers()
            for _, player in pairs(players) do
                if
                    player:hasKeyItem(xi.ki.SEANCE_STAFF) and
                    player:getCharVar('Enagakure_Killed') == 0 and
                    not ninMob:isSpawned()
                then
                    SpawnMob(ID.mob.ENAGAKURE)
                end
            end
        else
            if
                ninMob:isSpawned() and
                not ninMob:isEngaged()
            then
                DespawnMob(ID.mob.ENAGAKURE)
            end
        end
    end
end

return zoneObject
