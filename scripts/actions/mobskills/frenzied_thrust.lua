-----------------------------------
-- Frenzied Thrust
-- 5-hit melee damage + Magic Defense Down.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local ftp = 1.5

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    -- Apply Magic Defense Down on hit
    if dmg > 0 then
        target:addStatusEffect(xi.effect.MAGIC_DEF_DOWN, 20, 0, 60)
    end

    skill:setMsg(xi.msg.basic.DAMAGE)

    return dmg
end

return mobskillObject


