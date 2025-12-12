-----------------------------------
-- Area: Sacrificial Chamber
-- Name: Tonberrys Elemental
-----------------------------------
mixins = { require('scripts/mixins/families/elemental_pet') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.elemental_pet.mobElements[mob:getID()] =
    {
        xi.elemental_pet.type.WATER,
        xi.elemental_pet.type.LIGHT,
        xi.elemental_pet.type.FIRE,
    }
end

return entity
