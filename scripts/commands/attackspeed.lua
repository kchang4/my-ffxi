-----------------------------------
-- func: attackspeed
-- desc: Displays detailed attack speed/delay information including haste breakdown
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = '',
}

commandObj.onTrigger = function(player)
    local target = player:getCursorTarget()
    if target == nil then
        target = player -- Default to self if no target
    end

    local targetType = target:getObjType()
    if targetType == xi.objType.NPC then
        player:printToPlayer('Target something other than an NPC!', xi.msg.channel.SYSTEM_3)
        return
    end

    local name = target:getName()

    -- Get base delay (weapon delay without modifications)
    local baseDelay = target:getBaseDelay()

    -- Get haste values (stored as 1/10000ths, so 2500 = 25%)
    local hasteGear = target:getMod(xi.mod.HASTE_GEAR) / 10000
    local hasteMagic = target:getMod(xi.mod.HASTE_MAGIC) / 10000
    local hasteAbility = target:getMod(xi.mod.HASTE_ABILITY) / 10000

    -- Check for two-handed haste (Hasso uses this)
    local twohandHaste = target:getMod(xi.mod.TWOHAND_HASTE_ABILITY) / 10000
    hasteAbility = hasteAbility + twohandHaste

    -- Apply caps
    local hasteGearCapped = math.max(-0.25, math.min(hasteGear, 0.25))       -- 25% cap
    local hasteMagicCapped = math.max(-1.0, math.min(hasteMagic, 0.4375))    -- 43.75% cap
    local hasteAbilityCapped = math.max(-0.25, math.min(hasteAbility, 0.25)) -- 25% cap

    -- Total haste multiplier (1.0 = no haste, 0.2 = max haste cap 80%)
    local hasteMultiplier = math.max(0.2, math.min(2.0, 1.0 - hasteGearCapped - hasteMagicCapped - hasteAbilityCapped))
    local totalHastePercent = (1.0 - hasteMultiplier) * 100

    -- Get dual wield
    local dualWield = target:getMod(xi.mod.DUAL_WIELD) / 100
    local dualWieldMultiplier = 1.0 - dualWield

    -- Get martial arts for H2H
    local martialArts = target:getMod(xi.mod.MARTIAL_ARTS) * 1000 / 60

    -- Delay% modifier
    local delayPercent = target:getMod(xi.mod.DELAYP) / 100
    local delayPercentMultiplier = 1.0 + delayPercent

    -- Calculate final delay (matching C++ GetWeaponDelay logic)
    local finalDelay = baseDelay - martialArts
    finalDelay = finalDelay * dualWieldMultiplier
    finalDelay = finalDelay * hasteMultiplier
    finalDelay = finalDelay * delayPercentMultiplier

    -- Clamp to valid range
    local minDelay = baseDelay * 0.2
    local maxDelay = baseDelay * 2
    finalDelay = math.max(minDelay, math.min(maxDelay, finalDelay))

    -- Convert to seconds (delay is in 60ths of a second)
    local delaySeconds = finalDelay / 60

    -- Attacks per second
    local attacksPerSecond = 1 / delaySeconds

    -- Print header
    player:printToPlayer('=== Attack Speed for ' .. name .. ' ===', xi.msg.channel.SYSTEM_3)

    -- Base stats
    player:printToPlayer(string.format('Base Weapon Delay: %d', baseDelay), xi.msg.channel.SYSTEM_3)

    -- Haste breakdown
    player:printToPlayer(string.format('Haste Gear:    %.1f%% (cap 25%%)', hasteGearCapped * 100), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Haste Magic:   %.1f%% (cap 43.75%%)', hasteMagicCapped * 100), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Haste JA:      %.1f%% (cap 25%%)', hasteAbilityCapped * 100), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total Haste:   %.1f%% (cap 80%%)', totalHastePercent), xi.msg.channel.SYSTEM_3)

    -- Other modifiers
    if dualWield > 0 then
        player:printToPlayer(string.format('Dual Wield:    %d%%', dualWield * 100), xi.msg.channel.SYSTEM_3)
    end

    if martialArts > 0 then
        player:printToPlayer(string.format('Martial Arts:  -%d delay', martialArts), xi.msg.channel.SYSTEM_3)
    end

    if delayPercent ~= 0 then
        player:printToPlayer(string.format('Delay%%:        %+.1f%%', delayPercent * 100), xi.msg.channel.SYSTEM_3)
    end

    -- Final results
    player:printToPlayer('--- Results ---', xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Final Delay:   %.0f (%.2f seconds)', finalDelay, delaySeconds), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Attacks/Sec:   %.2f', attacksPerSecond), xi.msg.channel.SYSTEM_3)

    -- Check for Hundred Fists
    if target:hasStatusEffect(xi.effect.HUNDRED_FISTS) then
        local hfDelay = math.max(1600, math.min(8000, baseDelay - martialArts)) * 0.25
        local hfSeconds = hfDelay / 60
        player:printToPlayer(string.format('[HUNDRED FISTS ACTIVE] Delay: %.0f (%.2f seconds)', hfDelay, hfSeconds), xi.msg.channel.SYSTEM_3)
    end
end

return commandObj
