-----------------------------------
-- Area: Arrapago Reef
--  Mob: Reserve Draugar
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Draugars_Wyvern')
end

entity.onMobSpawn = function(mob)
    if mob:getPet() ~= nil then
        mob:setTP(1000)
    end
end

return entity
