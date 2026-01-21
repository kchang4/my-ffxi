-----------------------------------
-- Trust: AAEV
-- Job: PLD / WHM
-----------------------------------
require('scripts/globals/magic')
require('scripts/globals/trust')
-----------------------------------
---@type TSpellTrust
local spellObject = {}

local function initGamibits(mob)
    local pldLvl = mob:getMainLvl()

    -- Divine Emblem
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.DIVINE_EMBLEM },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.DIVINE_EMBLEM },
        180 -- divine emblem every 3 minutes
    )

    -- Sentinel
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.SENTINEL },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL },
        180 -- sentinel every 3 minutes
    )

    -- Flash 
    mob:addGambit(
        ai.t.TARGET, 
        { 
            ai.l.OR(
                { ai.c.NOT_STATUS, xi.effect.FLASH }, 
                { ai.c.SELF_STATUS, xi.effect.DIVINE_EMBLEM }
            )
        },
        { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH }
    )

    -- Reprisal
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.REPRISAL },
        { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.REPRISAL }
    )

    -- Palisade
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.PALISADE },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.PALISADE },
        300 -- palisade every 5 minutes
    )

    -- Enlight
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.ENLIGHT },
        { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ENLIGHT }
    )

    -- Phalanx
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.PHALANX },
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PHALANX }
    )

    -- Rampart - Use when battle target has Manafont, Chainspell, or Astral Flow
    mob:addGambit(ai.t.SELF,
        {
            { ai.c.NOT_STATUS, xi.effect.RAMPART },
            ai.l.OR(
                { ai.c.BT_STATUS, xi.effect.CHAINSPELL },
                { ai.c.BT_STATUS, xi.effect.MANAFONT },
                { ai.c.BT_STATUS, xi.effect.ASTRAL_FLOW }
            )
        },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.RAMPART },
        180 -- rampart every 3 minutes
    )

    -- Stuns high tier spells (Level 70+) with Shield Strike (MS ID 3714)
    mob:addGambit(
        ai.t.TARGET, 
        { ai.c.CASTING_MA_LEVEL_GTE, 70 }, 
        { ai.r.MS, ai.s.SPECIFIC, 3714 },
        60 -- stun every 60 seconds
    )

    -- Cure
    mob:addGambit(
        ai.t.PARTY,
        { ai.c.HPP_LT, 70 },
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE },
        20 -- cast every 20 seconds
    )

    -- Holy
    mob:addGambit(
        ai.t.TARGET,
        { ai.c.SELF_NOT_STATUS, xi.effect.DIVINE_EMBLEM },
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.HOLY },
        120 --  cast every 2 minutes
    )
end

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    -- Core AAEV Unique Traits
    mob:addMod(xi.mod.FASTCAST, 25)
    mob:addMod(xi.mod.CURE_POTENCY, 50)
    mob:addMod(xi.mod.DMG, -1000)
    mob:addMod(xi.mod.SHIELDBLOCKRATE, 10)
    mob:addMod(xi.mod.ABSORB_DMG_TO_MP, 5)

    -- Dynamic HP/MP Calculation
    local baseHP = mob:getMaxHP()
    local baseMP = mob:getMaxMP()
    mob:addMod(xi.mod.HP, math.floor(baseHP * 0.2))
    mob:addMod(xi.mod.MP, math.floor(baseMP * 0.5))

    initGamibits(mob)

    -- Holds TP until 2000 to close a SC
    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.RANDOM, 2000)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
