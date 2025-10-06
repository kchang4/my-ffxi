-----------------------------------
-- ID: 15326
-- Item: Gargoyle Boots
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local pet = caster:getPet()

    -- No obvious range limit, observed working at 30' (max engaged range)
    if not pet or (pet and pet:getPetID() ~= xi.petId.WYVERN) then
        return xi.msg.basic.ITEM_NO_TARGET
    end

    return 0
end

itemObject.onItemUse = function(target)
    -- 60 second 200 dmg stoneskin
    target:addStatusEffect(xi.effect.STONESKIN, 200, 0, 60)
end

return itemObject
