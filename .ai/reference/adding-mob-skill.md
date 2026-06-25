# adding-mob-skill

## 1. Define the skill — `sql/mob_skills.sql`

Only needed for a new skill. Relevant columns: `mobskillid, animationId, name, aoe, distance, valid_targets`.

```sql
INSERT INTO `mob_skills` VALUES (id, animId, 'skill_name', 0, 0.0, 7.0, 2000, 0, 1, 2, 0, 0, 0, 0, 0);
```

## 2. Add to a skill list — `sql/mob_skill_lists.sql`

```sql
INSERT INTO `mob_skill_lists` VALUES ('ListName', list_id, mob_skill_id);
```

Check which other pool job variants share `list_id` before adding — it affects all of them. Non-DRG variants are safe to include if `onMobSkillCheck` guards on `getPet() == nil`.

## 3. Implement the handler — `scripts/actions/mobskills/<skill_name>.lua`

```lua
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0  -- 0 = allow, 1 = block
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    -- skill logic; return damage or 0
    return 0
end

return mobskillObject
```

For pet summons, delegate to `xi.pet.onMobSkillCheck` / `xi.pet.spawnPet` (see pets-wyverns.md).

## 4. Trigger from mob script — `scripts/zones/<Zone>/mobs/<Name>.lua` (if active trigger needed)

```lua
entity.onMobSpawn = function(mob)
    mob:useMobAbility(xi.mobSkill.SKILL_NAME)
end
```

Skill enum constant must be added to `scripts/enum/mob_skill.lua` if referencing by name.
