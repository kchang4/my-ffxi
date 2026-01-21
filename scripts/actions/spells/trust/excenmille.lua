-----------------------------------
-- Trust: Excenmille
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.EXCENMILLE_S)
end

spellObject.onSpellCast = function(caster, target, spell)
    local sandoriaFirstTrust = caster:getCharVar('SandoriaFirstTrust')
    local zone = caster:getZoneID()

    if
        sandoriaFirstTrust == 1 and
        (zone == xi.zone.WEST_RONFAURE or zone == xi.zone.EAST_RONFAURE)
    then
        caster:setCharVar('SandoriaFirstTrust', 2)
    end

    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.RAHAL] = xi.trust.messageOffset.TEAMWORK_1,
    })

    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })

    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH })

    -- Dynamic cure threshold based on party composition
    -- Start with 75% threshold (no WHM in party)
    mob:setLocalVar('CureThreshold', 75)
    local cureGambitId = mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 75 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })

    -- Monitor party composition on each combat tick
    mob:addListener('COMBAT_TICK', 'EXCENMILLE_CURE_CHECK', function(mobArg)
        local master = mobArg:getMaster()
        if not master then
            return
        end

        local newCureThreshold = 75
        local party = master:getPartyWithTrusts()
        for _, member in pairs(party) do
            if member:getMainJob() == xi.job.WHM then
                -- there is a whm, excenmille is backup healer now, curing at 50%
                newCureThreshold = 50
                break
            end
        end

        -- Update cure threshold based on WHM presence
        if newCureThreshold ~= mobArg:getLocalVar('CureThreshold') then
            mobArg:setLocalVar('CureThreshold', newCureThreshold)
            -- Remove existing cure gambit and add new one with updated threshold
            mobArg:removeGambit(cureGambitId)
            cureGambitId = mobArg:addGambit(ai.t.PARTY, { ai.c.HPP_LT, newCureThreshold }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
        end
    end)

    mob:addMod(xi.mod.STORETP, 25)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
