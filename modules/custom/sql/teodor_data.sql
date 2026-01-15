-- Teodor Trust Data
-- Pool ID: 5986 (From trust.lua offset 5986->Teodor)
-- Family: 309 (Vampyr) -> Grants Undead traits (Cure Damage, etc.)
-- Model: Placeholder (Adam) -> Hume Male Appearance
-- Skill List: 1101 (Teodor Custom Skills)
-- Spell List: 1001 (Teodor Custom Spells - Dark/Earth/Ice/Water only)

-- 1. Mob Pool Entry
DELETE FROM `mob_pools` WHERE `poolid` = 5986;
INSERT INTO `mob_pools` VALUES (
    5986,                               -- poolid
    'Teodor',                           -- name
    'Teodor',                           -- packet_name
    309,                                -- familyid (Vampyr for Undead traits)
    0x00001F0C00000000000000000000000000000000, -- modelid (3103: Teodor's Unique Model)
    4,                                  -- mJob (BLM)
    8,                                  -- sJob (DRK)
    1,                                  -- cmbSkill
    240,                                -- cmbDelay
    100,                                -- cmbDmgMult
    0,                                  -- behavior
    0,                                  -- aggro
    0,                                  -- true_detection
    0,                                  -- links
    0,                                  -- mobType
    0,                                  -- immunity
    0,                                  -- name_prefix
    0,                                  -- flag
    0,                                  -- entityFlags
    0,                                  -- animationsub
    0,                                  -- hasSpellScript
    1001,                               -- spellList (Custom Teodor List)
    1,                                  -- namevis
    0,                                  -- roamflag
    1101,                               -- skill_list_id (Teodor Custom Skills)
    0,                                  -- resist_id
    0,                                  -- modelSize
    0                                   -- modelHitboxSize
);

-- 2. Spell List (Custom List 1001)
-- Dark, Earth, Ice, Water Spells Only (For Dark Logic Magic Bursts)
DELETE FROM `mob_spell_lists` WHERE `spell_list_id` = 1001;

-- Dark Magic (DRK/BLM)
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 219, 1, 99); -- Bio III
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 248, 1, 99); -- Drain II
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 249, 1, 99); -- Aspir II
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 252, 1, 99); -- Stun
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 277, 1, 99); -- Dread Spikes
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 856, 1, 99); -- Endark II
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 503, 1, 99); -- Impact

-- Enfeebling (BLM)
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 253, 1, 99); -- Sleep
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 259, 1, 99); -- Sleep II
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 273, 1, 99); -- Sleepga
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 274, 1, 99); -- Sleepga II
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 258, 1, 99); -- Bind
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 254, 1, 99); -- Blind
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 276, 1, 99); -- Blind II
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 260, 1, 99); -- Dispel
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 255, 1, 99); -- Break

-- Absorbs (DRK)
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 266, 1, 99); -- Absorb-STR
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 267, 1, 99); -- Absorb-DEX
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 268, 1, 99); -- Absorb-VIT
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 269, 1, 99); -- Absorb-AGI
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 270, 1, 99); -- Absorb-INT
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 271, 1, 99); -- Absorb-MND
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 272, 1, 99); -- Absorb-CHR
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 285, 1, 99); -- Absorb-TP

-- Elemental Magic (Tier V, -ja, AMII)
-- Fire
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 148, 1, 99); -- Fire V
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 496, 1, 99); -- Firaja
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 205, 1, 99); -- Flare II

-- Ice
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 153, 1, 99); -- Blizzard V
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 497, 1, 99); -- Blizzaja
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 207, 1, 99); -- Freeze II

-- Wind
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 158, 1, 99); -- Aero V
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 498, 1, 99); -- Aeroja
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 209, 1, 99); -- Tornado II

-- Earth
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 163, 1, 99); -- Stone V
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 499, 1, 99); -- Stoneja
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 211, 1, 99); -- Quake II

-- Thunder
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 168, 1, 99); -- Thunder V
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 500, 1, 99); -- Thundaja
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 213, 1, 99); -- Burst II

-- Water
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 173, 1, 99); -- Water V
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 501, 1, 99); -- Waterja
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 215, 1, 99); -- Flood II

-- Special
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Teodor', 1001, 218, 1, 99); -- Meteor

-- Note: Having these spells available allows Teodor to Magic Burst on any element if the gambit permits.
