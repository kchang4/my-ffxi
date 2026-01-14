-----------------------------------
-- Trust: Lion II (Enhanced)
-----------------------------------
-- Module: trusts - Enhanced implementation with full traits and AI
-- Job: THF/NIN
-- Features: Treasure Hunter I, Triple Attack, Subtle Blow, Teamwork Messages
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.LION)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    -- Teamwork messages with II-series trusts
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.ZEID_II] = xi.trust.messageOffset.TEAMWORK_1,        -- Zeid, I'm pleased to see you again...but the struggle is far from over
        [xi.magic.spell.PRISHE_II] = xi.trust.messageOffset.TEAMWORK_2,      -- Prishe! Let me take the frontlines!
        [xi.magic.spell.NASHMEIRA_II] = xi.trust.messageOffset.TEAMWORK_3,   -- Aphmau, stay in the backlines!
        [xi.magic.spell.LILISETTE_II] = xi.trust.messageOffset.TEAMWORK_4,   -- Lilisette, are you ready?
        [xi.magic.spell.ARCIELA_II] = xi.trust.messageOffset.TEAMWORK_5,     -- Arciela, you know what to do!
        [xi.magic.spell.IROHA_II] = xi.trust.messageOffset.TEAMWORK_1,       -- Iroha, remember that the crystals are with us!
    })

    -- Special dialogue for Powder Keg WS
    mob:addListener('WEAPONSKILL_USE', 'LION_II_WEAPONSKILL_USE', function(mobArg, target, wsid, tp, action)
        if wsid == 3493 then -- Powder Keg
            -- "I won't sit by and let Vana'diel be engulfed!"
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
        end
    end)

    -- Job Traits: Treasure Hunter I
    mob:addMod(xi.mod.TREASURE_HUNTER, 1)

    -- Job Traits: Triple Attack (occasional)
    -- THF gets ~5% triple attack at higher levels
    mob:addMod(xi.mod.TRIPLE_ATTACK, 5)

    -- Job Traits: Strong Subtle Blow (reduces TP given to enemy)
    -- THF can get up to 50+ subtle blow, we'll give her a strong amount
    mob:addMod(xi.mod.SUBTLE_BLOW, 50)

    -- Thief stat bonuses: DEX and AGI focused
    local level = mob:getMainLvl()
    local power = math.floor(level / 5) -- Scales with level
    mob:addMod(xi.mod.DEX, power)
    mob:addMod(xi.mod.AGI, power)
    mob:addMod(xi.mod.ACC, power * 2)  -- Thieves need good accuracy
    mob:addMod(xi.mod.EVA, power)      -- Good evasion

    -- Critical hit rate bonus (THF specialty)
    mob:addMod(xi.mod.CRITHITRATE, 5)

    -- Utsusemi gambit (use shadows when not up)
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.COPY_IMAGE }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.UTSUSEMI })

    -- TP settings: Lion II waits for skillchains and uses WSs at 3000 TP
    -- Uses random selection between her unique weapon skills
    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.RANDOM, 3000)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
