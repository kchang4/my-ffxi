-----------------------------------
-- Area: Lower Delkfutt's Tower
-- Mob: Orna
-----------------------------------
require('scripts/globals/interaction/interaction_global')
-----------------------------------
local zone = zones[xi.zone.LOWER_DELKFUTTS_TOWER]
local entity = {}

entity.onMobSpawn = function(mob)
    local spear1 = GetMobByID(zone.mob.FOMORIAN_SPEAR_OFFSET + 0)
    local spear2 = GetMobByID(zone.mob.FOMORIAN_SPEAR_OFFSET + 1)
    
    if spear1 and not spear1:isSpawned() then
        spear1:spawn()
    end
    
    if spear2 and not spear2:isSpawned() then
        spear2:spawn()
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Despawn Fomorian Spears on Orna death
    local spear1 = GetMobByID(zone.mob.FOMORIAN_SPEAR_OFFSET + 0)
    local spear2 = GetMobByID(zone.mob.FOMORIAN_SPEAR_OFFSET + 1)
    
    if spear1 and spear1:isSpawned() then
        DespawnMob(zone.mob.FOMORIAN_SPEAR_OFFSET + 0)
    end
    
    if spear2 and spear2:isSpawned() then
        DespawnMob(zone.mob.FOMORIAN_SPEAR_OFFSET + 1)
    end
end

return entity
