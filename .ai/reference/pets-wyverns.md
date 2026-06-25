# pets-wyverns

## setMobPet — scripts/globals/pets.lua L195

```lua
xi.pet.setMobPet(mob, offset, petName)
```

Guard chain (exits before any state mutation on failure):
1. `mob` nil or not TYPE_MOB → return
2. `GetMobByID(mob:getID() + offset)` nil → return
3. `pet:getName() ~= petName` → return
4. `pet:getMaster()` or `mob:getPet()` already set → return
5. Proceeds: `DisallowRespawn`, optional `DespawnMob`, `mob:setPet(pet)`

## Double-offset pattern

When spawn table row order is inconsistent (wyvern may be at +1 or -1 relative to its master):
```lua
xi.pet.setMobPet(mob,  1, 'Draugars_Wyvern')
xi.pet.setMobPet(mob, -1, 'Draugars_Wyvern')
```
Exactly one call succeeds per mob; the wrong-offset call hits guard #3 and exits cleanly.

## onMobSkillCheck — pets.lua L46

Returns 1 (block) if `mob:getPet() == nil` or pet already active (`mob:hasPet()`).  
Safe to add call_wyvern to skill lists shared with non-DRG job variants — petless mobs never fire the skill.

## spawnPet — pets.lua L88

Called from `call_wyvern.lua:onMobWeaponSkill` as `xi.pet.spawnPet(mob, nil, skill)`.  
`nil` petID = spawn the pet already linked via `setMobPet`.

## Skill IDs

- `CALL_WYVERN_1 = 732` — universal mob call_wyvern (scripts/enum/mob_skill.lua L465)
- `CALL_WYVERN_MAAT = 1022` — Maat-specific variant, Chamber of Oracles only

## Standard wyvern flow

```lua
entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Wyvern_Name')
end
entity.onMobSpawn = function(mob)
    mob:useMobAbility(xi.mobSkill.CALL_WYVERN_1)
end
```
