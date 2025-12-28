-----------------------------------
-- Spell: Arise
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if
        target:isAlive() or          -- Can't cast on alive targets.
        target:hasRaiseTractorMenu() -- Raise and tractor menus both block the casting.
    then
        return xi.msg.basic.MAGIC_CANNOT_BE_CAST
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:isPC() then
        target:sendRaise(4)
    else
        -- CoP 8-4 Prishe
        if target:getPool() == xi.mobPools.PRISHE then
            target:addHP(target:getMaxHP())
            target:addMP(target:getMaxMP())
            target:setLocalVar('raise', 1)
        end
    end

    spell:setMsg(xi.msg.basic.MAGIC_CASTS_ON)

    return 4
end

return spellObject
