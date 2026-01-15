-----------------------------------
-- Mob Skill: Hemocladis
-- AOE Dark Damage + Plague + Full Heal
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Only use when Dark Aura (Regain) is active
    if not mob:hasStatusEffect(xi.effect.REGAIN) then
        return 1
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp = 2.5 -- Strong finisher

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.DARK, info.hitslanded)

    -- Additional Effect: Plague (75% chance)
    if dmg > 0 and math.random(1, 100) <= 75 then
        target:addStatusEffect(xi.effect.PLAGUE, 5, 0, 60)
    end

    -- Heal Teodor to Full Health
    mob:addHP(mob:getMaxHP())

    -- Dark Aura (Regain) removal is handled by teodor.lua Trust AI, not here

    skill:setMsg(xi.msg.basic.DAMAGE)

    return dmg
end

return mobskillObject


