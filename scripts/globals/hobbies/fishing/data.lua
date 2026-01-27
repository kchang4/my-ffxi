-----------------------------------
-- Fishing Data
-----------------------------------
xi = xi or {}
xi.fishing = xi.fishing or {}
-----------------------------------

-- TODO: Remove unnecesary data. For instance, if brokenRodId is 0, then the rod is obviously unbreakable.
xi.fishing.rodData =
{
    -- [rod Id] = { material, size, flags, minRank, maxRank, attack, bonusAttack, recovery, time, timeBonus, delay, move, delay2, move2, isBreakable, brokenRodId, isMMM, isLegendary, rating }
    [xi.item.BAMBOO_FISHING_ROD      ] = { 0, 0, 0,  1,  8, 140,   0,  60, 30,  0, 2, 1, 1,  0, 2, true,  xi.item.BROKEN_BAMBOO_FISHING_ROD,       false, false,  3 },
    [xi.item.CARBON_FISHING_ROD      ] = { 1, 0, 0,  1, 13, 100,   0,  75, 43,  0, 2, 1, 1,  0, 4, true,  xi.item.BROKEN_CARBON_FISHING_ROD,       false, false,  7 },
    [xi.item.CLOTHESPOLE             ] = { 0, 1, 1, 12, 16, 170,   0,  50, 30,  0, 0, 0, 1,  0, 3, true,  xi.item.BROKEN_CLOTHESPOLE,              false, false, 10 },
    [xi.item.COMPOSITE_FISHING_ROD   ] = { 1, 1, 1, 11, 24, 100,   0,  70, 43,  0, 0, 0, 1,  0, 2, true,  xi.item.BROKEN_COMPOSITE_FISHING_ROD,    false, false, 13 },
    [xi.item.EBISU_FISHING_ROD       ] = { 1, 0, 4,  1, 30, 100,  50,  50, 30, 10, 2, 1, 1,  0, 3, false, xi.item.NONE,                            false, true,  15 },
    [xi.item.EBISU_FISHING_ROD_P1    ] = { 1, 0, 4,  1, 30, 100,  50,  50, 40, 10, 2, 1, 1,  0, 3, false, xi.item.NONE,                            false, true,  15 },
    [xi.item.FASTWATER_FISHING_ROD   ] = { 0, 0, 0,  1,  7, 135,   0,  65, 30,  0, 2, 1, 1,  0, 2, true,  xi.item.BROKEN_FASTWATER_FISHING_ROD,    false, false,  4 },
    [xi.item.GLASS_FIBER_FISHING_ROD ] = { 1, 0, 0,  1, 12, 100,   0,  80, 45,  0, 2, 1, 1,  0, 4, true,  xi.item.BROKEN_GLASS_FIBER_FISHING_ROD,  false, false,  8 },
    [xi.item.GOLDFISH_BASKET         ] = { 0, 0, 8,  1,  5, 100,   0,  50, 20,  0, 0, 0, 0,  0, 0, false, xi.item.NONE,                            false, false,  0 },
    [xi.item.HALCYON_FISHING_ROD     ] = { 1, 0, 2,  1, 18, 100,   0,  70, 41,  0, 2, 1, 0,  2, 3, true,  xi.item.BROKEN_HALCYON_FISHING_ROD,      false, false,  9 },
    [xi.item.HUME_FISHING_ROD        ] = { 0, 0, 2,  1, 10, 125,   0,  65, 30,  0, 2, 1, 0,  2, 3, true,  xi.item.BROKEN_HUME_FISHING_ROD,         false, false,  6 },
    [xi.item.JUDGES_ROD              ] = { 1, 0, 0,  1, 40, 200, 100, 100, 60, 30, 2, 1, 1,  0, 5, false, xi.item.NONE,                            false, true,  16 },
    [xi.item.LU_SHANGS_FISHING_ROD   ] = { 0, 0, 0,  1, 28, 110,  20, 100, 40, 10, 2, 1, 1,  0, 2, true,  xi.item.BROKEN_LU_SHANGS_FISHING_ROD,    false, true,  14 },
    [xi.item.LU_SHANGS_FISHING_ROD_P1] = { 0, 0, 0,  1, 28, 110,  20, 100, 50, 10, 2, 1, 1,  0, 2, true,  xi.item.BROKEN_LU_SHANGS_FISHING_ROD_P1, false, true,  14 },
    [xi.item.MAZE_MONGER_FISHING_ROD ] = { 1, 0, 0,  1, 25, 100,   0, 100, 30,  0, 2, 1, 1, 10, 2, true,  xi.item.BROKEN_MMM_FISHING_ROD,          true,  false,  0 },
    [xi.item.MITHRAN_FISHING_ROD     ] = { 0, 1, 1,  8, 18, 130,   0,  65, 30,  0, 0, 0, 1,  0, 3, true,  xi.item.BROKEN_MITHRAN_FISHING_ROD,      false, false, 12 },
    [xi.item.SINGLE_HOOK_FISHING_ROD ] = { 1, 1, 1, 14, 22, 100,   0,  80, 45,  0, 0, 0, 1,  0, 3, true,  xi.item.BROKEN_SINGLE_HOOK_FISHING_ROD,  false, false, 11 },
    [xi.item.TARUTARU_FISHING_ROD    ] = { 0, 0, 0,  1,  9, 130,   0,  70, 30,  0, 2, 1, 1,  0, 4, true,  xi.item.BROKEN_TARUTARU_FISHING_ROD,     false, false,  5 },
    [xi.item.WILLOW_FISHING_ROD      ] = { 0, 0, 0,  1,  5, 150,   0,  50, 30,  0, 2, 1, 1,  0, 2, true,  xi.item.BROKEN_WILLOW_FISHING_ROD,       false, false,  1 },
    [xi.item.YEW_FISHING_ROD         ] = { 0, 0, 0,  1,  6, 145,   0,  55, 30,  0, 2, 1, 1,  0, 2, true,  xi.item.BROKEN_YEW_FISHING_ROD,          false, false,  2 },
}

xi.fishing.baitData =
{
    -- [bait Id] = { isConsumable, maxHook, isLosable, flags, isMMM, rankMod }
    [xi.item.BALL_OF_CRAYFISH_PASTE  ] = { 0, 1, true,   0, false, 0 },
    [xi.item.BALL_OF_INSECT_PASTE    ] = { 0, 1, true,   0, false, 0 },
    [xi.item.BALL_OF_SARDINE_PASTE   ] = { 0, 1, true,   0, false, 0 },
    [xi.item.BALL_OF_TROUT_PASTE     ] = { 0, 1, true,   0, false, 0 },
    [xi.item.DRIED_SQUID             ] = { 2, 1, true,   0, false, 0 },
    [xi.item.DRILL_CALAMARY          ] = { 0, 1, true,   0, false, 0 },
    [xi.item.DWARF_PUGIL             ] = { 0, 1, true,   0, false, 0 },
    [xi.item.FLY_LURE                ] = { 1, 1, true,  16, false, 0 },
    [xi.item.FROG_LURE               ] = { 1, 1, true,   0, false, 0 },
    [xi.item.GIANT_SHELL_BUG         ] = { 0, 1, true,   0, false, 0 },
    [xi.item.GOLIATH_WORM            ] = { 0, 1, true,   0, false, 0 },
    [xi.item.JUDGE_FLY               ] = { 1, 1, false,  0, false, 0 },
    [xi.item.JUDGE_MINNOW            ] = { 1, 1, false,  0, false, 0 },
    [xi.item.JUDGES_LURE             ] = { 1, 1, false,  0, false, 0 },
    [xi.item.LARGE_MAZE_MONGER_BALL  ] = { 1, 1, true,   0, true,  0 },
    [xi.item.LITTLE_WORM             ] = { 0, 1, true,   0, false, 0 },
    [xi.item.LIZARD_LURE             ] = { 1, 1, true,   0, false, 0 },
    [xi.item.LUFAISE_FLY             ] = { 0, 1, true,   0, false, 0 },
    [xi.item.LUGWORM                 ] = { 0, 1, true,   0, false, 0 },
    [xi.item.MAZE_MONGER_MINNOW      ] = { 2, 1, true,   0, true,  0 },
    [xi.item.MEATBALL                ] = { 0, 1, true,   0, false, 0 },
    [xi.item.MINNOW                  ] = { 1, 1, true,   0, false, 0 },
    [xi.item.PEELED_CRAYFISH         ] = { 0, 1, true,   0, false, 0 },
    [xi.item.PEELED_LOBSTER          ] = { 0, 1, true,   0, false, 0 },
    [xi.item.PIECE_OF_ROTTEN_MEAT    ] = { 0, 1, true,   0, false, 0 },
    [xi.item.REGULAR_MAZE_MONGER_BALL] = { 1, 1, true,   0, true,  0 },
    [xi.item.ROBBER_RIG              ] = { 1, 1, true,  72, false, 0 },
    [xi.item.ROGUE_RIG               ] = { 1, 1, true,  72, false, 0 },
    [xi.item.SABIKI_RIG              ] = { 1, 3, true,   0, false, 0 },
    [xi.item.SEA_DRAGON_LIVER        ] = { 0, 1, true,   0, false, 0 },
    [xi.item.SHELL_BUG               ] = { 0, 1, true,   0, false, 0 },
    [xi.item.SHRIMP_LURE             ] = { 1, 1, true,   0, false, 0 },
    [xi.item.SINKING_MINNOW          ] = { 1, 1, true,   1, false, 0 },
    [xi.item.SLICE_OF_BLUETAIL       ] = { 0, 1, true,   0, false, 0 },
    [xi.item.SLICE_OF_COD            ] = { 0, 1, true,   0, false, 0 },
    [xi.item.SLICE_OF_MOAT_CARP      ] = { 0, 1, true,   0, false, 0 },
    [xi.item.SLICE_OF_SARDINE        ] = { 0, 1, true,   0, false, 0 },
    [xi.item.SUPER_SCOOP             ] = { 0, 3, true,  32, false, 0 },
    [xi.item.WORM_LURE               ] = { 1, 1, true,   0, false, 0 },
}
