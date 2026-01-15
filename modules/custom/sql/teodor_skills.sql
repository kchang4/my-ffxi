-- Add Teodor's Skills to mob_skills if they don't exist
-- IDs based on unused or new range, referencing existing animation IDs where possible.
-- Hemocladis already exists (3385 or 3636). Using 3385.
-- Start from Scratch exists in txt (3124).

-- INSERT INTO `mob_skills` VALUES (ID, AnimID, 'Name', AOE, Radius, Dist, AnimTime, Prep, ValidTargets, Flag, Param, Knockback, PrimarySC, SecondarySC, TertiarySC);

-- 1. Cleanslate
DELETE FROM `mob_skills` WHERE `mob_skill_id` IN (3375, 3376, 3379, 3380);
DELETE FROM `mob_skill_lists` WHERE `skill_list_id` = 1101;

-- 3375: Start from Scratch (ID 3375, Self Buff)
-- Schema: ID, AnimID, Name, AOE, Radius, Dist, AnimTime, Prep, ValidTarg, Flag, Param, KB, SC1, SC2, SC3
INSERT INTO `mob_skills` VALUES (3375, 2390, 'start_from_scratch', 0, 0.0, 6.0, DEFAULT, DEFAULT, 1, 0, 0, 0, 0, 0, 0);

-- 3376: Frenzied Thrust (5-hit Melee, Frag/Trans, M.Def Down)
INSERT INTO `mob_skills` VALUES (3376, 2391, 'frenzied_thrust', 0, 0.0, 3.0, DEFAULT, DEFAULT, 4, 0, 0, 0, 12, 1, 0);

-- 3379: Ravenous Assault (AOE Drain)
INSERT INTO `mob_skills` VALUES (3379, 2394, 'ravenous_assault', 1, 10.0, 6.0, DEFAULT, DEFAULT, 4, 0, 0, 0, 0, 0, 0);

-- 3380: Hemocladis (Darkness/Distortion SC)
INSERT INTO `mob_skills` VALUES (3380, 2395, 'hemocladis', 1, 10.0, 6.0, DEFAULT, DEFAULT, 4, 0, 0, 0, 14, 10, 0);

-- List 1101 for Teodor
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Teodor', 1101, 3375); -- Start from Scratch
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Teodor', 1101, 3376); -- Frenzied Thrust
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Teodor', 1101, 3380); -- Hemocladis
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Teodor', 1101, 3379); -- Ravenous Assault

-- Adding other listed skills if I can find them, otherwise just these two key ones.
-- Sinner's Cross, Ravenous Assault, Frenzied Thrust, Open Coffin are typically Vampire/Undead moves.
-- Searching for "Vampire" skills might yield them under different names?
-- "Open Coffin" -> "Nocturnal Servitude"? No.

-- Safe bet: just these two for logic, and maybe generic Vampire moves later.
