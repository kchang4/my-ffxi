-----------------------------------
-- Mob Skill: Start from Scratch
-- Clears negative status effects, heals, and grants Dark Aura (Regain).
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

local removables =
{
    xi.effect.FLASH,              xi.effect.BLINDNESS,      xi.effect.MAX_HP_DOWN,    xi.effect.MAX_MP_DOWN,
    xi.effect.PARALYSIS,          xi.effect.POISON,         xi.effect.CURSE_I,        xi.effect.CURSE_II,
    xi.effect.DISEASE,            xi.effect.PLAGUE,         xi.effect.WEIGHT,         xi.effect.BIND,
    xi.effect.BIO,                xi.effect.DIA,            xi.effect.BURN,           xi.effect.FROST,
    xi.effect.CHOKE,              xi.effect.RASP,           xi.effect.SHOCK,          xi.effect.DROWN,
    xi.effect.STR_DOWN,           xi.effect.DEX_DOWN,       xi.effect.VIT_DOWN,       xi.effect.AGI_DOWN,
    xi.effect.INT_DOWN,           xi.effect.MND_DOWN,       xi.effect.CHR_DOWN,       xi.effect.ADDLE,
    xi.effect.SLOW,               xi.effect.HELIX,          xi.effect.ACCURACY_DOWN,  xi.effect.ATTACK_DOWN,
    xi.effect.EVASION_DOWN,       xi.effect.DEFENSE_DOWN,   xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN,
    xi.effect.MAGIC_EVASION_DOWN, xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN,    xi.effect.SILENCE,
    xi.effect.PETRIFICATION
}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Only use when HP < 50% and not already in Dark Aura
    if mob:getHPP() > 50 or mob:hasStatusEffect(xi.effect.REGAIN) then
        return 1
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Remove negative effects from self (mob)
    for _, effect in ipairs(removables) do
        if mob:hasStatusEffect(effect) then
            mob:delStatusEffect(effect)
        end
    end

    -- Apply Regen
    mob:addStatusEffect(xi.effect.REGEN, 30, 3, 180) -- 30 HP/tick for 3 minutes

    -- Apply 3 Shadows (like Utsusemi: Ni)
    mob:addStatusEffect(xi.effect.COPY_IMAGE, 3, 0, 300)

    -- Dark Aura (Regain) is applied by teodor.lua Trust AI, not here

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.COPY_IMAGE
end

return mobskillObject

