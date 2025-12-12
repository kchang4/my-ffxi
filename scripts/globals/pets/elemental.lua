-----------------------------------
-- PET: Elemental
-----------------------------------
xi = xi or {}
xi.elemental_pet = xi.elemental_pet or {}

-----------------------------------
-- Element Types
-----------------------------------
xi.elemental_pet.type =
{
    WIND    = 1,
    EARTH   = 2,
    ICE     = 3,
    WATER   = 4,
    THUNDER = 5,
    FIRE    = 6,
    DARK    = 7,
    LIGHT   = 8,
}

-----------------------------------
-- Elemental Data Table
-----------------------------------
xi.elemental_pet.data =
{
    [xi.elemental_pet.type.EARTH] =
    {
        spellListId = 13,
        model       = 11,
        mods =
        {
            { xi.mod.EARTH_RES_RANK,   11 },
            { xi.mod.FIRE_RES_RANK,     1 },
            { xi.mod.ICE_RES_RANK,      1 },
            { xi.mod.THUNDER_RES_RANK, 11 },
            { xi.mod.WATER_RES_RANK,    1 },
            { xi.mod.WIND_RES_RANK,    -3 },
            { xi.mod.DARK_RES_RANK,     1 },
            { xi.mod.LIGHT_RES_RANK,    1 },
        },
    },

    [xi.elemental_pet.type.FIRE] =
    {
        spellListId = 17,
        model       = 8,
        mods =
        {
            { xi.mod.EARTH_RES_RANK,    1 },
            { xi.mod.FIRE_RES_RANK,    11 },
            { xi.mod.ICE_RES_RANK,     11 },
            { xi.mod.THUNDER_RES_RANK,  1 },
            { xi.mod.WATER_RES_RANK,   -3 },
            { xi.mod.WIND_RES_RANK,     1 },
            { xi.mod.DARK_RES_RANK,     1 },
            { xi.mod.LIGHT_RES_RANK,    1 },
        },
    },

    [xi.elemental_pet.type.ICE] =
    {
        spellListId = 14,
        model       = 9,
        mods =
        {
            { xi.mod.EARTH_RES_RANK,    1 },
            { xi.mod.FIRE_RES_RANK,    -3 },
            { xi.mod.ICE_RES_RANK,     11 },
            { xi.mod.THUNDER_RES_RANK,  1 },
            { xi.mod.WATER_RES_RANK,    1 },
            { xi.mod.WIND_RES_RANK,    11 },
            { xi.mod.DARK_RES_RANK,     1 },
            { xi.mod.LIGHT_RES_RANK,    1 },
        },
    },

    [xi.elemental_pet.type.THUNDER] =
    {
        spellListId = 16,
        model       = 13,
        mods =
        {
            { xi.mod.EARTH_RES_RANK,   -3 },
            { xi.mod.FIRE_RES_RANK,     1 },
            { xi.mod.ICE_RES_RANK,      1 },
            { xi.mod.THUNDER_RES_RANK, 11 },
            { xi.mod.WATER_RES_RANK,   11 },
            { xi.mod.WIND_RES_RANK,     1 },
            { xi.mod.DARK_RES_RANK,     1 },
            { xi.mod.LIGHT_RES_RANK,    1 },
        },
    },

    [xi.elemental_pet.type.WATER] =
    {
        spellListId = 15,
        model       = 12,
        mods =
        {
            { xi.mod.EARTH_RES_RANK,    1 },
            { xi.mod.FIRE_RES_RANK,    11 },
            { xi.mod.ICE_RES_RANK,      1 },
            { xi.mod.THUNDER_RES_RANK, -3 },
            { xi.mod.WATER_RES_RANK,   11 },
            { xi.mod.WIND_RES_RANK,     1 },
            { xi.mod.DARK_RES_RANK,     1 },
            { xi.mod.LIGHT_RES_RANK,    1 },
        },
    },

    [xi.elemental_pet.type.WIND] =
    {
        spellListId = 12,
        model       = 10,
        mods =
        {
            { xi.mod.EARTH_RES_RANK,   11 },
            { xi.mod.FIRE_RES_RANK,     1 },
            { xi.mod.ICE_RES_RANK,     -3 },
            { xi.mod.THUNDER_RES_RANK,  1 },
            { xi.mod.WATER_RES_RANK,   -3 },
            { xi.mod.WIND_RES_RANK,    11 },
            { xi.mod.DARK_RES_RANK,     1 },
            { xi.mod.LIGHT_RES_RANK,    1 },
        },
    },

    [xi.elemental_pet.type.DARK] =
    {
        spellListId = 18,
        model       = 15,
        mods =
        {
            { xi.mod.EARTH_RES_RANK,    1 },
            { xi.mod.FIRE_RES_RANK,     1 },
            { xi.mod.ICE_RES_RANK,      1 },
            { xi.mod.THUNDER_RES_RANK,  1 },
            { xi.mod.WATER_RES_RANK,    1 },
            { xi.mod.WIND_RES_RANK,     1 },
            { xi.mod.DARK_RES_RANK,    11 },
            { xi.mod.LIGHT_RES_RANK,   -3 },
        },
    },

    [xi.elemental_pet.type.LIGHT] =
    {
        spellListId = 19,
        model       = 14,
        mods =
        {
            { xi.mod.EARTH_RES_RANK,    1 },
            { xi.mod.FIRE_RES_RANK,     1 },
            { xi.mod.ICE_RES_RANK,      1 },
            { xi.mod.THUNDER_RES_RANK,  1 },
            { xi.mod.WATER_RES_RANK,    1 },
            { xi.mod.WIND_RES_RANK,     1 },
            { xi.mod.DARK_RES_RANK,    -3 },
            { xi.mod.LIGHT_RES_RANK,   11 },
        },
    },
}

-----------------------------------
-- Allowed Elements
-----------------------------------
xi.elemental_pet.mobElements = xi.elemental_pet.mobElements or {}
