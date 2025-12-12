-----------------------------------
-- Elemental Pet Mixin
-- How it works : On spawn, the mob picks one of its allowed elements at random.
-- It then changes its model, spell list, and elemental resistance ranks accordingly.
-----------------------------------
--mixins = { require('scripts/mixins/families/elemental_pet')
-----------------------------------
--entity.onMobInitialize = function(mob)
--    xi.elemental_pet.mobElements[mob:getID()] =
--    ({
--        xi.elemental_pet.type.WATER,
--        xi.elemental_pet.type.LIGHT,
--        xi.elemental_pet.type.FIRE,
--    })
--end
-----------------------------------
require('scripts/globals/pets/elemental')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.elemental_pet = function(mob)
    mob:addListener('SPAWN', 'ELEMENTAL_PET_SPAWN', function(mobArg)
        -- Fetches the possible elements for this mob
        local possibleElements = xi.elemental_pet.mobElements[mobArg:getID()]
        if not possibleElements or #possibleElements == 0 then
            return
        end

        -- Pick a random element
        local chosenElement = possibleElements[math.random(#possibleElements)]

        local data = xi.elemental_pet.data[chosenElement]
        if not data then
            return
        end

        -- Sets the spell list and model
        mobArg:setSpellList(data.spellListId)
        mobArg:setModelId(data.model)

        -- Apply resistance ranks
        for _, modPair in ipairs(data.mods) do
            mobArg:setMod(modPair[1], modPair[2])
        end
    end)
end

return g_mixins.families.elemental_pet
