-----------------------------------
-- Trust: AAEV
-- Job: PLD / WHM
-----------------------------------
require('scripts/globals/magic')
require('scripts/globals/trust')
-----------------------------------
---@type TSpellTrust
local spellObject = {}

local function initWhmJobTraits(mob)
    -- WHM Subjob Traits (conditional on subjob level)
    local subLvl = mob:getSubLvl()

    -- Magic Defense Bonus I (Lv 10) - Total: 10 MDEF
    if subLvl >= 10 then
        mob:addMod(xi.mod.MDEF, 10)
    end

    -- Clear Mind I (Lv 20) - Total: 3 ticks
    if subLvl >= 20 then
        mob:addMod(xi.mod.CLEAR_MIND, 3)
    end

    -- Tranquil Heart (Lv 21) - Reduces enmity from healing magic
    if subLvl >= 21 then
        mob:addListener('MAGIC_START', 'AAEV_TQ_START', function(mobArg, spell, action)
            if spell:getSkillType() == xi.skill.HEALING_MAGIC then
                mobArg:addMod(xi.mod.ENMITY, -10)
                mobArg:setLocalVar('TranquilHeartActive', 1)
            end
        end)

        local function cleanupEnmity(mobArg)
            if mobArg:getLocalVar('TranquilHeartActive') == 1 then
                mobArg:addMod(xi.mod.ENMITY, 10)
                mobArg:setLocalVar('TranquilHeartActive', 0)
            end
        end

        mob:addListener('MAGIC_USE', 'AAEV_TQ_USE', function(mobArg, target, spell, action)
            cleanupEnmity(mobArg)
        end)

        mob:addListener('MAGIC_INTERRUPTED', 'AAEV_TQ_INTERRUPT', function(mobArg, target, spell, action)
            cleanupEnmity(mobArg)
        end)
    end

    -- Auto Regen (Lv 25) - +1 HP/tick
    if subLvl >= 25 then
        mob:addMod(xi.mod.REGEN, 1)
    end

    -- Magic Defense Bonus II (Lv 30) - Total: 12 MDEF (+2 from previous)
    if subLvl >= 30 then
        mob:addMod(xi.mod.MDEF, 2)
    end

    -- Clear Mind II (Lv 40) - Total: 6 ticks (+3 from previous)
    if subLvl >= 40 then
        mob:addMod(xi.mod.CLEAR_MIND, 3)
    end
end

local function initPldJobTraits(mob)
    -- Standard PLD Job Traits
    local pldLvl = mob:getMainLvl()

    -- Undead Killer (Lv 5)
    if pldLvl >= 86 then
        mob:addMod(xi.mod.UNDEAD_KILLER, 10)
    elseif pldLvl >= 5 then
        mob:addMod(xi.mod.UNDEAD_KILLER, 8)
    end

    -- DEF (Lv 10, 30, 50, 70, 91)
    if pldLvl >= 91 then
        mob:addMod(xi.mod.DEF, 72)
    elseif pldLvl >= 76 then
        mob:addMod(xi.mod.DEF, 60)
    elseif pldLvl >= 70 then
        mob:addMod(xi.mod.DEF, 48)
    elseif pldLvl >= 50 then
        mob:addMod(xi.mod.DEF, 35)
    elseif pldLvl >= 30 then
        mob:addMod(xi.mod.DEF, 22)
    elseif pldLvl >= 10 then
        mob:addMod(xi.mod.DEF, 10)
    end

    -- Sleep Resistance (Lv 20, 40, 60, 81)
    if pldLvl >= 81 then
        mob:addMod(xi.mod.SLEEPRES, 30)
    elseif pldLvl >= 75 then
        mob:addMod(xi.mod.SLEEPRES, 25)
    elseif pldLvl >= 60 then
        mob:addMod(xi.mod.SLEEPRES, 20)
    elseif pldLvl >= 40 then
        mob:addMod(xi.mod.SLEEPRES, 15)
    elseif pldLvl >= 20 then
        mob:addMod(xi.mod.SLEEPRES, 10)
    end

    -- Shield Mastery (Lv 25, 50, 75, 96)
    if pldLvl >= 96 then
        mob:addMod(xi.mod.SHIELD_MASTERY_TP, 40)
    elseif pldLvl >= 75 then
        mob:addMod(xi.mod.SHIELD_MASTERY_TP, 30)
    elseif pldLvl >= 50 then
        mob:addMod(xi.mod.SHIELD_MASTERY_TP, 20)
    elseif pldLvl >= 25 then
        mob:addMod(xi.mod.SHIELD_MASTERY_TP, 10)
    end

    -- Auto Refresh (Lv 35)
    if pldLvl >= 35 then
        mob:addMod(xi.mod.REFRESH, 1)
    end

    -- Max HP Boost
    if pldLvl >= 85 then
        mob:addMod(xi.mod.HP, 60)
    elseif pldLvl >= 45 then
        mob:addMod(xi.mod.HP, 30)
    end

    -- Trust cannot use shield barrier

    -- Shield Defense Bonus (Lv 77, 82, 88, 93)
    if pldLvl >= 93 then
        mob:addMod(xi.mod.SHIELD_DEF_BONUS, 8)
    elseif pldLvl >= 88 then
        mob:addMod(xi.mod.SHIELD_DEF_BONUS, 6)
    elseif pldLvl >= 82 then
        mob:addMod(xi.mod.SHIELD_DEF_BONUS, 4)
    elseif pldLvl >= 77 then
        mob:addMod(xi.mod.SHIELD_DEF_BONUS, 2)
    end

    -- Crit. Def. Bonus
    if pldLvl >= 96 then
        mob:addMod(xi.mod.CRIT_DEF_BONUS, 14)
    elseif pldLvl >= 91 then
        mob:addMod(xi.mod.CRIT_DEF_BONUS, 11)
    elseif pldLvl >= 85 then
        mob:addMod(xi.mod.CRIT_DEF_BONUS, 8)
    elseif pldLvl >= 79 then
        mob:addMod(xi.mod.CRIT_DEF_BONUS, 3)
    end

    -- Inquartata (Lv 87, 97)
    if pldLvl >= 97 then
        mob:addMod(xi.mod.INQUARTATA, 10)
    elseif pldLvl >= 87 then
        mob:addMod(xi.mod.INQUARTATA, 5)
    end

    -- Shield Barrier (Job Trait)
    mob:addMod(xi.mod.SHIELD_BARRIER, 1)
end

local function initGamibits(mob)
    local pldLvl = mob:getMainLvl()

    -- Divine Emblem
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.DIVINE_EMBLEM },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.DIVINE_EMBLEM },
        180 -- 3 minutes
    )

    -- Sentinel
    mob:addGambit(
        ai.t.SELF,
        { ai.c.NOT_STATUS, xi.effect.SENTINEL },
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL },
        180 -- 3 minutes
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
        300 -- 5 minutes
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
        { ai.r.JA, ai.s.SPECIFIC, xi.ja.RAMPART }
    )

    -- Stuns high tier spells (Level 70+) with Shield Strike (MS ID 3714)
    mob:addGambit(
        ai.t.TARGET, 
        { ai.c.CASTING_MA_LEVEL_GTE, 70 }, 
        { ai.r.MS, ai.s.SPECIFIC, 3714 },
        60
    )

    -- Cure
    mob:addGambit(
        ai.t.PARTY,
        { ai.c.HPP_LT, 70 },
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE },
        20
    )

    -- Holy
    mob:addGambit(
        ai.t.TARGET,
        { ai.c.SELF_NOT_STATUS, xi.effect.DIVINE_EMBLEM },
        { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.HOLY },
        120 -- 2 minutes
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

    initPldJobTraits(mob)
    initWhmJobTraits(mob)
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
