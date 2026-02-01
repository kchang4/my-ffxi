-----------------------------------
-- Area: Ship bound for Selbina Pirates
--  Mob: Blackbeard
--  NM: Spawns only if middle pirate has Vermillion Cloak
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
