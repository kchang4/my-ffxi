-----------------------------------
-- Trust: Teodor
-- Job: BLM / DRK
-- Family: Vampyr (Undead traits handled by Family ID 309)
-----------------------------------
require('scripts/globals/trust')
require('scripts/globals/magic')
-----------------------------------

local spellObject = {}

-----------------------------------
-- Constants
-----------------------------------
local SKILL_START_FROM_SCRATCH = 3375
local SKILL_FRENZIED_THRUST    = 3376
local SKILL_RAVENOUS_ASSAULT   = 3379
local SKILL_HEMOCLADIS         = 3380

-----------------------------------
-- Spell Casting & Spawn Logic
-----------------------------------

spellObject.onMagicCastingCheck = function(caster, target, spell)
    -- Assuming Spell ID 986 (Teodor) exists.
    return xi.trust.canCast(caster, spell, 986)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

-----------------------------------
-- Mob Behavior Logic
-----------------------------------

spellObject.onMobSpawn = function(mob)
    -- HP/MP Mods (User Request: High HP/MP)
    mob:setMobMod(xi.mobMod.HP_STAND, 135) -- +35% Base HP
    mob:setMobMod(xi.mobMod.MP_STAND, 150) -- +50% Base MP
    mob:addMod(xi.mod.HPHEAL, 10)          -- Auto Regen (+10 HP/tick)

    -- Disable Skillchain Behavior (User Request: Random usage)
    -- Default to Ravenous Assault as the "Random" filler.
    -- Special skills (Start from Scratch, Hemocladis) are handled exclusively via Gambits.
    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
    
    -- Add Gambits
    -- 1. Start from Scratch: Use when HP < 50%, TP >= 1000, and NOT in Dark Aura (No Regain)
    mob:addGambit(ai.t.SELF, 
        { 
            ai.c.HPP_LT, 50,
            ai.c.NOT_STATUS, xi.effect.REGAIN 
        },
        { 
            ai.r.WS, ai.s.SPECIFIC, SKILL_START_FROM_SCRATCH 
        }
    )

    -- 2. Hemocladis: Use when TP >= 2000 AND Has Dark Aura (Regain)
    mob:addGambit(ai.t.TARGET, 
        { 
            ai.c.TP_GTE, 2000,
            ai.c.STATUS, xi.effect.REGAIN 
        },
        { 
            ai.r.WS, ai.s.SPECIFIC, SKILL_HEMOCLADIS 
        }
    )
    
    -- 3. Frenzied Thrust: Mix in randomly (30% chance) when TP >= 1000
    mob:addGambit(ai.t.TARGET,
        {
            ai.c.TP_GTE, 1000,
            ai.c.RANDOM, 30
        },
        {
            ai.r.WS, ai.s.SPECIFIC, SKILL_FRENZIED_THRUST
        }
    )
    
    -- 4. Magic Bursting: Use best element from available list
    -- Teodor now possesses a full suite of Elemental Magic (Tier V, AMII, -ja).
    -- ai.s.MB_ELEMENT primarily prioritizes high-damage spells matching the skillchain window.
    -- This ensures he typically selects Elemental Magic for bursting, satisfying the user constraint.
    mob:addGambit(ai.t.TARGET,
        {
            ai.c.MB_AVAILABLE, 0
        },
        {
             ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE
        }
    )
end

spellObject.onMobFight = function(mob, target)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

-- Custom Mob Skill Triggers (Reacting to own skill usage)
spellObject.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()

    if skillId == SKILL_START_FROM_SCRATCH then
        -- Apply Dark Aura (Teodor-specific: Represented by Regain)
        mob:addStatusEffect(xi.effect.REGAIN, 50, 0, 9999)
        
        -- Enter "Dark Aura Phase": Hold TP until Hemocladis.
        mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.SPECIFIC, SKILL_HEMOCLADIS, 3000)
        
    elseif skillId == SKILL_HEMOCLADIS then
        -- Remove Dark Aura (Teodor-specific)
        mob:delStatusEffect(xi.effect.REGAIN)
        
        -- Revert to "Normal Phase": Random WS usage.
        mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
    end
end

return spellObject
