# Feature: <name>

## Summary
One-line description of what this implements or fixes.

## Affected pools
| Pool name | mJob | packet_name | skill_list_id |
|-----------|------|-------------|---------------|
| Pool_Name | 14   | Packet_Name | 89            |

## Skill lists
| list_id | list_name | Job variants sharing this list |
|---------|-----------|-------------------------------|
| 89      | Draugar   | BLM (4), DRK (8), THF (6)     |

## Zone script paths
- `scripts/zones/<Zone>/mobs/<packet_name>.lua`

## SQL tables touched
- `sql/mob_skill_lists.sql`
- `sql/mob_skills.sql` (if new skill)
- `sql/mob_spawn_points.sql` (if spawn data changes)

## Retail reference
Observed retail behavior or source.

## Implementation notes
Edge cases, ordering dependencies, or non-obvious constraints.
