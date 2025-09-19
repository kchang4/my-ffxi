-----------------------------------
-- Area: Lebros Cavern
-- Ancient Lockbox
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.EXCAVATION_DUTY] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOX,     weight = 300 },
                { itemid = xi.item.UNAPPRAISED_EARRING, weight = 700 },
            },
        },

        [xi.assault.mission.LEBROS_SUPPLIES] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOX,  weight = 300 },
                { itemid = xi.item.UNAPPRAISED_CAPE, weight = 700 },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_AXE,       weight = 300 },
                { itemid = xi.item.UNAPPRAISED_POLEARM,   weight = 200 },
                { itemid = xi.item.UNAPPRAISED_HEADPIECE, weight = 100 },
                { itemid = xi.item.UNAPPRAISED_BOX,       weight = 400 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.EXCAVATION_DUTY] =
        {
            {
                { itemid = xi.item.REMEDY, weight = 900 },
                { itemid = 0,              weight = 100 },
            },

            {
                { itemid = xi.item.REMEDY, weight = 200 },
                { itemid = 0,              weight = 800 },
            },

            {
                { itemid = xi.item.HI_POTION_P3, weight = 400 },
                { itemid = 0,                    weight = 600 },
            },

            {
                { itemid = xi.item.HI_POTION_P3, weight = 200 },
                { itemid = 0,                    weight = 800 },
            },
        },

        [xi.assault.mission.LEBROS_SUPPLIES] =
        {
            {
                { itemid = xi.item.REMEDY, weight = 800 },
                { itemid = 0,              weight = 200 },
            },

            {
                { itemid = xi.item.RERAISER, weight = 200 },
                { itemid = 0,                weight = 800 },
            },

            {
                { itemid = xi.item.HI_POTION_TANK, weight = 100 },
                { itemid = 0,                      weight = 900 },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            {
                { itemid = xi.item.HI_POTION_P3, weight = 800 },
                { itemid = 0,                    weight = 200 },
            },

            {
                { itemid = xi.item.RERAISER, weight = 200 },
                { itemid = 0,                weight = 800 },
            },

            {
                { itemid = xi.item.HI_POTION_TANK, weight = 100 },
                { itemid = 0,                      weight = 900 },
            },

            {
                { itemid = xi.item.HI_ETHER_TANK, weight = 100 },
                { itemid = 0,                     weight = 900 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
