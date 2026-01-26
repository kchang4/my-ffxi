------------------------------------
-- Abyssea Job SQL Adjustments
-- This module reverts relevant SQL tables for jobs to their pre-Abyssea values
------------------------------------
-- Source : https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
------------------------------------

------------------------------------
-- Warrior
------------------------------------

-- Reverts Warrior's Charge cooldown to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'warriors_charge';

-- Change merit value to represent recast reduction per upgrade (150 seconds = 2.5 minutes)
-- First merit unlocks ability, upgrades 2-5 each reduce recast by 2.5 min down to 5 min minimum
UPDATE merits SET value = 150 WHERE name = 'warriors_charge';
