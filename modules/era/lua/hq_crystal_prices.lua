-----------------------------------
-- Guild Point Shop Modifications
-----------------------------------
--
-- Emblems were added on 12/07/2010
-- Patch Notes: The rate at which guild points can be exchange for the following items has been adjusted.
--              Aurora Crystal       -     500 -> 200
--              Twilights Crystal    -     500 -> 200
-- Patch Notes Link: https://forum.square-enix.com/ffxi/threads/52095

-----------------------------------
require('scripts/globals/hobbies/crafting/guild_points')
-----------------------------------
local m = Module:new('hq_crystal_prices')

-----------------------------------
-- HQ Crystals - Set Auraora and Twilight to 500 GP
-----------------------------------

xi.crafting.hqCrystals[7].cost = 500 -- Aurora Crystal
xi.crafting.hqCrystals[8].cost = 500 -- Twilight Crystal

return m
