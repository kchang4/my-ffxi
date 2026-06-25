# CLAUDE.md

LandSandBoat/server fork — FFXI private server (C++ engine + Lua scripts + SQL data).

```
src/map/                              C++ engine (entities, AI, combat, zone loading)
src/map/lua/luautils.cpp              Lua dispatch (OnEntityLoad, OnMobInitialize, OnMobSkillCheck, OnMobWeaponSkill)
scripts/zones/<Zone>/mobs/<Name>.lua  mob scripts, keyed by packet_name
scripts/globals/pets.lua              setMobPet, onMobSkillCheck, spawnPet
scripts/globals/mobs.lua              job 2-hour handlers
scripts/enum/mob_skill.lua            mob skill ID enum
scripts/actions/mobskills/<name>.lua  per-skill handlers
sql/                                  mob_pools, mob_spawn_points, mob_skill_lists, mob_skills, mob_groups
```

**Script resolution:** `packet_name` from mob_pools → `scripts/zones/<Zone>/mobs/<packet_name>.lua`. All job variants sharing a `packet_name` load one script.
**Hook order:** `onMobInitialize` → `onMobSpawn` → `onMobFight` → `onMobDeath` / `onMobDespawn`

**Reference:** `.ai/reference/` — SQL schemas, pet/wyvern patterns, adding mob skills. Feature spec template: `.ai/features/_template.md`.
