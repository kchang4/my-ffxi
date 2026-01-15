-----------------------------------
-- Trust: Joachim
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Records of Eminence: Alter Ego: Joachim
    if caster:getEminenceProgress(937) then
        xi.roe.onRecordTrigger(caster, 937)
    end

    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    local function getEncodedTier(effect, tier)
        return bit.bor(bit.lshift(tier, 16), effect)
    end

    local MAX_SONG_COUNT = 2

    -- Priority 1: Healing (Cure IV)
    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 75 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })

    -- Priority 2: Status Removal
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.POISON }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.POISONA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.PARALYSIS }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PARALYNA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.BLINDNESS }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.BLINDNA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SILENCE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.SILENA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.PETRIFICATION }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STONA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.DISEASE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.VIRUNA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.CURSE_I }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURSNA })

    -- Priority 3: Songs
    -- joachim always waits till songs expire before casting new ones

    -- Paeon (cast highest tier paeon)
    -- joachim has less than 2 songs
    -- joachim's hp is less than 90%
    -- joachim can do double paeon
    mob:addGambit(
        ai.t.SELF, 
        { 
            { ai.c.HPP_LT, 90 },
            { ai.c.MY_SONG_COUNT_LT, MAX_SONG_COUNT }

        }, 
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.ARMYS_PAEON })

    -- Ballad (cast highest tier ballad)
    -- joachim has less than 2 songs
    -- joachim's mp is less than 75%
    -- joachim doesn't have ballad currently (prevents double ballad)
    mob:addGambit(
        ai.t.SELF, 
        { 
            { ai.c.MPP_LT, 75 },
            { ai.c.MY_SONG_COUNT_LT, MAX_SONG_COUNT },
            { ai.c.NOT_STATUS, xi.effect.BALLAD }
        }, 
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.MAGES_BALLAD })

    -- March (cast highest tier march)
    -- joachim has less than 2 songs
    -- joachim doesnt have march currently (prevents double march)
    mob:addGambit(
        ai.t.SELF, 
        { 
            { ai.c.MY_SONG_COUNT_LT, MAX_SONG_COUNT },
            { ai.c.NOT_STATUS, xi.effect.MARCH }
        }, 
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.MARCH })

    -- Blade Madrigal (cast highest tier madrigal)
    -- joachim has less than 2 songs
    -- joachim doesn't have madrigal currently (prevents double madrigal)
    mob:addGambit(
        ai.t.SELF, 
        { 
            { ai.c.NOT_STATUS, xi.effect.MADRIGAL },
            { ai.c.MY_SONG_COUNT_LT, MAX_SONG_COUNT }
        }, 
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.MADRIGAL })

    -- Minuet (cast highest tier minuet)
    -- joachim doesn't have minuet currently (prevents double minuet)
    -- joachim has less than 2 songs
    -- joachim has double march from another bard
    mob:addGambit(
        ai.t.SELF, 
        { 
            { ai.c.NOT_STATUS, xi.effect.MINUET },
            { ai.c.MY_SONG_COUNT_LT, MAX_SONG_COUNT },
            { ai.c.OTHER_STATUS_TIER, getEncodedTier(xi.effect.MARCH, 1) },
            { ai.c.OTHER_STATUS_TIER, getEncodedTier(xi.effect.MARCH, 2) }
        }, 
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.MINUET })

    -- Minne (cast highest tier minne)
    -- joachim doesn't have minne currently (prevents double minne)
    -- joachim has less than 2 songs
    -- joachim has double march from another bard
    -- joachim has double madrigal from another bard
    mob:addGambit(
        ai.t.SELF, 
        { 
            { ai.c.NOT_STATUS, xi.effect.MINNE },
            { ai.c.MY_SONG_COUNT_LT, MAX_SONG_COUNT },
            { ai.c.OTHER_STATUS_TIER, getEncodedTier(xi.effect.MARCH, 1) },
            { ai.c.OTHER_STATUS_TIER, getEncodedTier(xi.effect.MARCH, 2) },
            { ai.c.OTHER_STATUS_TIER, getEncodedTier(xi.effect.MADRIGAL, 1) },
            { ai.c.OTHER_STATUS_TIER, getEncodedTier(xi.effect.MADRIGAL, 2) }
        }, 
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.KNIGHTS_MINNE })

    -- Ranged Attack (Throwing)
    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.RATTACK, 0, 0 }, 60)

    mob:setAutoAttackEnabled(false)

    mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.MID_RANGE)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
