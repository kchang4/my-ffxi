# mob-data

## mob_pools columns
`poolid, name, packet_name, speciesid, modelid(blob), mJob, sJob, cmbSkill, cmbDelay, cmbDmgMult, behavior, aggro, true_detection, links, mobType, immunity, name_prefix, flag, entityFlags, animationsub, hasSpellScript, spellList, namevis, roamflag, skill_list_id, resist_id, modelSize, modelHitboxSize`

- `mJob` = col 6 (4=BLM, 6=THF, 8=DRK, 14=DRG)
- `skill_list_id` = col 25 (20th value after the hex blob)
- `packet_name` = col 3 — determines Lua script filename and in-game display name

## mob_spawn_points columns
`mobid, spawnslotid, mobname, polutils_name, groupid, minLevel, maxLevel, pos_x, pos_y, pos_z, pos_rot`

- `mobname` = `packet_name` from mob_pools (used for script lookup)
- `groupid` links to mob_groups → poolid

## Data relationships

```
mob_pools.skill_list_id → mob_skill_lists(list_id) → mob_skills(mobskillid)
mob_spawn_points.groupid ← mob_groups.groupid → mob_pools.poolid
```

## Finding a mob's skill list

1. Find pool row in mob_pools by `name` (pool name) or `packet_name` (display name) — read col 25 (`skill_list_id`)
2. `SELECT * FROM mob_skill_lists WHERE skill_list_id = <value>` → all `mob_skill_id` entries
3. `SELECT * FROM mob_skills WHERE mobskillid IN (...)` → names and animation IDs

Multiple job-variant pools (e.g. `Draugar_Servant_blm`, `Draugar_Servant_drg`) often share the same `skill_list_id` — adding a skill to the list affects all variants.
