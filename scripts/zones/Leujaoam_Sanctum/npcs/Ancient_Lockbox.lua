-----------------------------------
-- Area: Leujaoam Sanctum
-- Ancient Lockbox
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_RING, weight = 700 },
                { itemid = xi.item.UNAPPRAISED_BOX,  weight = 300 },
            },
        },

        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_NECKLACE, weight = 300 },
                { itemid = xi.item.UNAPPRAISED_BOX,      weight = 400 },
                { itemid = xi.item.UNAPPRAISED_GLOVES,   weight = 300 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            {
                { itemid = xi.item.HI_POTION_P3, weight = 1000 },
            },

            {
                { itemid = xi.item.HI_POTION_P3, weight = 100 },
                { itemid = 0,                    weight = 900 },
            },

            {
                { itemid = xi.item.REMEDY, weight = 530 },
                { itemid = 0,              weight = 470 },
            },
        },

        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            {
                { itemid = xi.item.HI_POTION_P3, weight = 1000 },
            },

            {
                { itemid = xi.item.REMEDY, weight = 530 },
                { itemid = 0,              weight = 470 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
