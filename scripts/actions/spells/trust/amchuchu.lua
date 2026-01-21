-----------------------------------
-- Trust: Amchuchu
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    -- converts 5% oh physical damage taken to MP
    mob:addMod(xi.mod.ABSORB_PHYSDMG_TO_MP, 5)

    -- cast flash on target
    mob:addGambit(
        ai.t.TARGET,
        { ai.c.NOT_STATUS, xi.effect.FLASH },
        { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH }
    )

    -- uses provoke on target
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_HAS_TOP_ENMITY, 0 },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE },
        30 -- use every 30 seconds
    )

    -- uses embolden on himself
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.EMBOLDEN },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.EMBOLDEN },
        600 -- use every 10 minutes
    )
    
    -- uses Battuta on himself
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.BATTUTA },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.BATTUTA },
        300 -- use every 5 minutes
    )

    -- uses berserk on himself
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.BERSERK },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.BERSERK },
        300 -- use every 5 minutes
    )

    -- uses swordplay on himself
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.SWORDPLAY },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.SWORDPLAY },
        300 -- use every 5 minutes
    )

    -- uses Vallation if target is casting magic
    -- TODO: check if magic is being cast on trust
    mob:addGambit(
        ai.t.TARGET,
        {
            { ai.c.CASTING_MA, 0 },
            { ai.c.SELF_NOT_STATUS, xi.effect.VALLATION },
        },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.VALLATION },
        180 -- use every 3 minutes
    )

    -- uses Valiance on target if target is casting magic
    mob:addGambit(
        ai.t.TARGET,
        {
            { ai.c.NOT_STATUS, xi.effect.VALIANCE },
            { ai.c.CASTING_MA, 0 },
        },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.VALIANCE },
        300 -- use every 5 minutes
    )

    -- uses Vivacious Pulse on himself
    mob:addGambit(
        ai.t.SELF,
        { ai.c.HPP_LT, 75 },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.VIVACIOUS_PULSE },
        60 -- use every 1 minutes
    )

    -- uses One For All if target is casting high tier magic (70+)
    mob:addGambit(
        ai.t.TARGET,
        { ai.c.CASTING_MA_LEVEL_GTE, 70 },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.ONE_FOR_ALL },
        300 -- use every 5 minutes
    )

    -- uses Lunge to magic burst
    mob:addGambit(
        ai.t.TARGET,
        { ai.c.MB_AVAILABLE, 0 },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.LUNGE },
        180 -- use every 3 minutes
    )

    -- cast protect on himself
    mob:addGambit(
        ai.t.SELF,
        { 
            ai.l.OR(
                {ai.c.NOT_STATUS, xi.effect.PROTECT },
                {ai.c.STATUS, xi.effect.EMBOLDEN }
            )
        },
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PROTECT },
    )

    -- cast shell on himself
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.SHELL },
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.SHELL }
    )

    -- cast phalanx on himself
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.PHALANX },
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PHALANX },
        10 -- use every 10 seconds
    )

    -- cast stoneskin on himself
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.STONESKIN },
        { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STONESKIN },
        30 -- use every 30 seconds
    )

    -- cast foil on himself
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.FOIL },
        { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FOIL }
    )

    -- cast refresh on himself
    mob:addGambit(
        ai.t.SELF,
        { 
            { ai.c.NOT_STATUS, xi.effect.REFRESH },
            { ai.c.MPP_LT, 75 } 
        },
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.REFRESH }
    )

    -- cast regen on himself
    mob:addGambit(
        ai.t.SELF,
        { 
            { ai.c.NOT_STATUS, xi.effect.REGEN },
            { ai.c.HPP_LT, 90 } 
        },
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.REGEN }
    )

    -- Handle reactive Bar-spells on magic damage
    mob:addListener('TAKE_DAMAGE', 'AMCHUCHU_TAKE_DAMAGE', function(mobArg, amount, attacker, attackType, damageType)
        if attackType ~= xi.attackType.MAGICAL then
            return;
        end

        local element = damageType
        local barSpellId = 0
        local barStatusId = 0
    
        if element == xi.element.FIRE then
            barSpellId = xi.magic.spell.BARFIRE
            barStatusId = xi.effect.BARFIRE
        elseif element == xi.element.ICE then
            barSpellId = xi.magic.spell.BARBLIZZARD
            barStatusId = xi.effect.BARBLIZZARD
        elseif element == xi.element.WIND then
            barSpellId = xi.magic.spell.BARAERO
            barStatusId = xi.effect.BARAERO
        elseif element == xi.element.EARTH then
            barSpellId = xi.magic.spell.BARSTONE
            barStatusId = xi.effect.BARSTONE
        elseif element == xi.element.THUNDER then
            barSpellId = xi.magic.spell.BARTHUNDER
            barStatusId = xi.effect.BARTHUNDER
        elseif element == xi.element.WATER then
            barSpellId = xi.magic.spell.BARWATER
            barStatusId = xi.effect.BARWATER
        end
    
        if barSpellId ~= 0 and not mobArg:hasStatusEffect(barStatusId) then
            mobArg:castSpell(barSpellId, mobArg)
        end
    end)

    -- hold TP to close skillchains up to 3000
    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 3000)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
