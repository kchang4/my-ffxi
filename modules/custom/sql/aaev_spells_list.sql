-- AAEV Trust Missing Data
-- List IDs: Spell (406), Skill (1108)

-- Add Reprisal (97) which is missing from base kit
-- Using DELETE/INSERT pattern for idempotency on the specific entry
DELETE FROM `mob_spell_lists` WHERE `spell_list_id` = 406 AND `spell_id` = 97;
INSERT INTO `mob_spell_lists` (`spell_list_name`, `spell_list_id`, `spell_id`, `min_level`, `max_level`) 
VALUES ('TRUST_AAEV', 406, 97, 61, 255);
