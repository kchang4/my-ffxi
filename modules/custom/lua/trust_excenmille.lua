-----------------------------------
-- Custom Trust Override: Excenmille
-- 
-- Override mainly to implement smart healing logic (prioritize healing if no WHM).
-- Also ensures standard gambits are applied.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/trust')
-----------------------------------
local m = Module:new('trust_excenmille')

local trustName = 'excenmille'

m:addOverride(string.format('xi.actions.spells.trust.%s.onMobSpawn', trustName), function(mob)
    -- Original Teamwork Message
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.RAHAL] = xi.trust.messageOffset.TEAMWORK_1,
    })

    -- Original Gambits (Sentinel, Flash)
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH })

    -- Smart Healing Logic
    -- Default threshold: 50% (Orange HP)
    local cureThreshold = 50 
    local party = mob:getParty()
    local whmPresent = false

    -- Check for WHM in party to adjust threshold
    -- Trusts usually check Main Job for simplicity
    for _, member in pairs(party) do
        if member:getMainJob() == xi.job.WHM then
            whmPresent = true
            break
        end
    end

    -- If no WHM, prioritize healing by raising threshold to 75%
    if not whmPresent then
        cureThreshold = 75
    end

    -- Add Cure Gambit with dynamic threshold
    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, cureThreshold }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })

    -- Original Mod
    mob:addMod(xi.mod.STORETP, 25)

    -- Undead Killer Trait (Simulated via Mod)
    -- Excenmille (PLD) should have Undead Killer. ID 231 = UNDEAD_KILLER. Value is percentage.
    mob:addMod(xi.mod.UNDEAD_KILLER, 10)
end)

return m
