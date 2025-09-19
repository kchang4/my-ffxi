-----------------------------------
-- Area: Periqia
-- Ancient Lockbox
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOX,     weight = 400 },
                { itemid = xi.item.UNAPPRAISED_SWORD,   weight = 200 },
                { itemid = xi.item.UNAPPRAISED_POLEARM, weight = 200 },
                { itemid = xi.item.UNAPPRAISED_GLOVES,  weight = 200 },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOX,     weight = 400 },
                { itemid = xi.item.UNAPPRAISED_GLOVES,  weight = 200 },
                { itemid = xi.item.UNAPPRAISED_POLEARM, weight = 200 },
                { itemid = xi.item.UNAPPRAISED_AXE,     weight = 200 },
            },
        },

        [xi.assault.mission.SHOOTING_DOWN_THE_BARON] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOW,   weight = 600 },
                { itemid = xi.item.UNAPPRAISED_BOX,   weight = 400 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            {
                { itemid = xi.item.HI_RERAISER,       weight = 700 },
                { itemid = 0,                         weight = 300 },
            },

            {
                { itemid = xi.item.HI_POTION_TANK,    weight = 100 },
                { itemid = xi.item.HI_ETHER_TANK,     weight = 100 },
                { itemid = 0,                         weight = 800 },
            },

            {
                { itemid = xi.item.HI_POTION_P3,      weight = 530 },
                { itemid = 0,                         weight = 470 },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            {
                { itemid = xi.item.HI_POTION_P3,      weight = 500 },
                { itemid = 0,                         weight = 500 },
            },

            {
                { itemid = xi.item.HI_ETHER_TANK,     weight = 100 },
                { itemid = 0,                         weight = 900 },
            },

            {
                { itemid = xi.item.HI_RERAISER,       weight = 500 },
                { itemid = 0,                         weight = 500 },
            },
        },

        [xi.assault.mission.SHOOTING_DOWN_THE_BARON] =
        {
            {
                { itemid = xi.item.HI_POTION_P2,      weight = 850 },
                { itemid = 0,                         weight = 150 },
            },
            {
                { itemid = xi.item.HI_POTION_P3,      weight = 50 },
                { itemid = 0,                         weight = 950 },
            },
            {
                { itemid = xi.item.HI_POTION_TANK,    weight = 400 },
                { itemid = 0,                         weight = 600 },
            },
            {
                { itemid = xi.item.HI_RERAISER,       weight = 200 },
                { itemid = 0,                         weight = 800 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
