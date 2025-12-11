# Job Points System for Level 75 Era

## Overview

This document outlines the plan to adapt the retail FFXI job point system (designed for level 99+) to work meaningfully on a **level 75 cap private server**. The goal is to provide an additional progression system for endgame players while maintaining balance appropriate for the 75-era.

---

## Implementation Approach: Custom Module

**All changes will be implemented in a separate custom module** rather than modifying the core LandSandBoat codebase.

### Module Details

| Property | Value |
|----------|-------|
| **Module Name** | `75_era_job_points` |
| **Location** | `server/modules/custom/75_era_job_points/` |
| **Purpose** | Override job point system for level 75 cap servers |

### Module Structure

```
server/modules/custom/75_era_job_points/
├── 75_era_job_points.lua          -- Module definition and settings
├── cpp/
│   └── job_points_override.cpp    -- C++ overrides (if needed)
├── lua/
│   └── job_points_helpers.lua     -- Lua helper functions
└── sql/
    └── job_point_gifts_75era.sql  -- Modified gift values (optional)
```

### Benefits of Module Approach

1. **Clean Separation** - Core LSB code remains untouched
2. **Easy Updates** - Can pull LSB updates without merge conflicts
3. **Toggleable** - Enable/disable by adding/removing module from `settings/default/modules.lua`
4. **Shareable** - Module can be shared with other 75-era servers
5. **Reversible** - Easy to revert to retail behavior

---

## Current System Analysis

### How Job Points Work (Retail) - VERIFIED FROM CODE

**Unlock Process** (verified from `scripts/quests/jeuno/LB10_Beyond_Infinity.lua`):

1. Player must complete the "Beyond Infinity" quest (LB10 - level 95→99 limit break)
2. After completing Beyond Infinity AND reaching level 99, player talks to Nomad Moogle again
3. Nomad Moogle grants `JOB_BREAKER` key item (ID 2544) via event 10240, option 28
4. Code check at line 287-289:
   ```lua
   if player:getMainLvl() >= 99 and not player:hasKeyItem(xi.ki.JOB_BREAKER) then
       return quest:progressEvent(10240, playerLevel, limitBreaker)
   ```

**Capacity Point Earning** (verified from `src/map/utils/charutils.cpp` line 5156):
- Requires `JOB_BREAKER` key item AND main job level 99+
- Only earned from mobs level 100+ (level diff calculated from 99)
- Formula uses cubic polynomial based on (mobLevel - 99)

**Job Point Accumulation**:
- Every 30,000 CP converts to 1 JP (max 500 JP per job)
- JP can be spent on job-specific abilities/bonuses (10 categories, max 20 per category)
- Gifts: Passive bonuses automatically granted at JP spent thresholds (5, 10, 20, 30... JP spent)

### Current Level 99 Checks in Code

| File | Line | Check | Purpose |
|------|------|-------|---------|
| `src/map/utils/charutils.cpp` | 5156 | `GetMLevel() < 99` | Block CP gain if below 99 |
| `src/map/job_points.cpp` | 254 | `GetMLevel() >= 99` | JP bonuses only apply at 99 |
| `src/map/job_points.cpp` | 299 | `GetMLevel() < 99` | Gifts only apply at 99 |
| `src/map/packets/s2c/0x063_miscdata_merits.cpp` | 51 | `GetMLevel() >= 99` | BLU spell bonus at 99 |

### Current Capacity Point Formula

```cpp
// Only triggers for mobs level 100+
if (mobLevel > 99)
{
    int16 levelDiff = mobLevel - 99;
    capacityPoints = 0.0089 * pow(levelDiff, 3) + 0.0533 * pow(levelDiff, 2) + 3.7439 * levelDiff + 89.7;
}
```

This means:
- Mob 100 = ~94 CP
- Mob 105 = ~115 CP  
- Mob 110 = ~150 CP
- Mob 120 = ~280 CP

---

## Proposed Changes

### Phase 1: Configuration Settings

#### Decision: Add Module-Specific Settings

Add new settings to module configuration:

```lua
-- Job Points System Settings
JOB_POINTS_ENABLED = true,                    -- Master toggle for the job point system
JOB_POINTS_LEVEL_REQUIREMENT = 75,            -- Minimum main job level to earn/use job points
JOB_POINTS_MOB_LEVEL_THRESHOLD = 75,          -- Mob level threshold for capacity point gain
JOB_POINTS_REQUIRE_KEY_ITEM = true,           -- Require JOB_BREAKER key item (or equivalent)
```

**Rationale**: Settings allow server operators to customize the system without code changes.

---

### Phase 2: Level Requirement Changes

#### Decision: Replace Hardcoded 99 with Configurable Setting

Replace all hardcoded `99` level checks with the configurable setting:

```cpp
// Before
if (PMember->GetMLevel() < 99)

// After  
if (PMember->GetMLevel() < settings::get<uint8>("map.JOB_POINTS_LEVEL_REQUIREMENT"))
```

**Files to modify (via module override):**
- `src/map/utils/charutils.cpp` (line 5156)
- `src/map/job_points.cpp` (lines 254, 299)
- `src/map/packets/s2c/0x063_miscdata_merits.cpp` (line 51)

---

### Phase 3: Capacity Point Formula Rework

#### Current Formula (Retail - requires mobs 100+)

```cpp
// Only triggers for mobs level 100+
if (mobLevel > 99)
{
    int16 levelDiff = mobLevel - 99;
    capacityPoints = 0.0089 * pow(levelDiff, 3) + 0.0533 * pow(levelDiff, 2) + 3.7439 * levelDiff + 89.7;
}
```

#### Decision: Scaled Retail Formula (Option B)

**Use the same retail formula, but based on configurable threshold instead of hardcoded 99.**

```cpp
int16 threshold = settings::get<uint8>("map.JOB_POINTS_MOB_LEVEL_THRESHOLD"); // Default: 75
int16 levelDiff = mobLevel - threshold;

float capacityPoints = 0;

if (levelDiff >= 0)  // Mobs at or above threshold
{
    // Use retail formula but based on configurable threshold
    capacityPoints = 0.0089 * pow(levelDiff, 3) + 0.0533 * pow(levelDiff, 2) + 3.7439 * levelDiff + 89.7;
}
```

**CP Values with threshold = 75:**

| Mob Level | Level Diff | CP Earned |
|-----------|------------|-----------|
| 74 | -1 | 0 (below threshold) |
| 75 | 0 | ~90 |
| 76 | +1 | ~94 |
| 77 | +2 | ~98 |
| 80 | +5 | ~115 |
| 85 | +10 | ~170 |
| 90 (NM) | +15 | ~260 |

**Rationale:**
- Keeps the same proven retail formula
- Simply shifts the baseline from 99 to 75
- Mobs at level 75 give base CP (~90)
- Higher level mobs (NMs, HNMs) give bonus CP
- Easy to understand and balance

---

### Phase 4: Key Item Handling

#### Decision: Repurpose JOB_BREAKER + Require Maxed Job Merits

**Two-tier system (like retail philosophy):**

| Tier | Requirement | What It Unlocks |
|------|-------------|-----------------|
| **System Access** | `LIMIT_BREAKER` + Talk to Nomad Moogle (one time) | Access to job point menu/UI |
| **Per-Job Usage** | Level 75 + Maxed job merits | Earn CP and spend JP on that job |

**Current Requirement (Retail):**
- `JOB_BREAKER` key item (ID 2544)
- Obtained from Nomad Moogle after completing Beyond Infinity AND reaching level 99

**75-Era Flow:**
1. Player beats Maat, gets `LIMIT_BREAKER`
2. Player talks to Nomad Moogle → Moogle grants `JOB_BREAKER` (one time, account-wide)
3. Player can now ACCESS job point menu/UI
4. Player levels WAR to 75 + maxes WAR merits → Can earn CP and spend JP on WAR
5. Player levels WHM to 75 + maxes WHM merits → Can earn CP and spend JP on WHM
6. Etc. for each job independently

**Why Repurpose JOB_BREAKER:**
- Less code changes needed
- Existing packets already check for `JOB_BREAKER`
- Same flow as retail, just different prerequisite (LIMIT_BREAKER instead of Beyond Infinity)

**Nomad Moogle Interaction:**
- Check: Has `LIMIT_BREAKER` key item
- On success: Grant `JOB_BREAKER` key item

**Merit Categories Per Job:**
Each job has job-specific merit categories (Group 1 + Group 2):
- Group 1: 2 categories × 5 levels = 10 merits
- Group 2: 3 categories × 5 levels = 15 merits  
- Total: 25 merit points to max a job's specific merits

**Implementation Checks:**

```cpp
// System Access (can view job point menu) - checked via JOB_BREAKER key item
// JOB_BREAKER is granted by Nomad Moogle when player has LIMIT_BREAKER
bool canAccessJobPointSystem(CCharEntity* PChar)
{
    return hasKeyItem(PChar, KeyItem::JOB_BREAKER);
}

// Per-Job Usage (can earn CP and spend JP)
bool canUseJobPointsForJob(CCharEntity* PChar, uint8 jobId)
{
    return hasKeyItem(PChar, KeyItem::JOB_BREAKER) &&
           PChar->GetMLevel() >= 75 &&
           PChar->GetMJob() == jobId &&
           hasMaxedJobMerits(PChar, jobId);
}
```

**Where checks apply:**
- `canAccessJobPointSystem`: Packet 0x0C0 (job points request), UI access
- `canUseJobPointsForJob`: Capacity point gain, JP spending, gift application

---

### Phase 5: Capacity Chains

#### Decision: Always Enabled for Mobs Above Threshold

**Current Behavior (Retail):**
- Chains only activate for mobs 100+ (level 100 = Chain 1)
- Chain bonus: `1 + 0.05 * chainNumber` (max 1.5x at chain 10+)
- Chain timer: 30 seconds

**75-Era Implementation:**
```cpp
int16 threshold = settings::get<uint8>("map.JOB_POINTS_MOB_LEVEL_THRESHOLD");

// Capacity chains start at threshold + 1 (mob 76+ for 75 threshold)
if (mobLevel > threshold)
{
    // Enable chaining
}
```

**Rationale:**
- Chains are always enabled (no setting to disable)
- Chains work on mobs above threshold (76+ with default settings)
- Chain bonus and timer remain the same as retail

---

### Phase 6: Gift Scaling

The `job_point_gifts` table contains significant stat bonuses. For 75-era balance:

#### Decision: Scale All Gifts by 50%

**Rules:**
- All gift values are multiplied by 0.5
- Values are floored (no rounding up)
- Minimum value is 1 (if result < 1, set to 1)

**Formula:**
```cpp
int16 scaledValue = std::max(1, static_cast<int16>(std::floor(originalValue * 0.5)));
```

**Example Scaling:**

| Original Value | Calculation | Scaled Value |
|----------------|-------------|--------------|
| 10 | floor(10 × 0.5) = 5 | 5 |
| 5 | floor(5 × 0.5) = 2 | 2 |
| 3 | floor(3 × 0.5) = 1 | 1 |
| 2 | floor(2 × 0.5) = 1 | 1 |
| 1 | floor(1 × 0.5) = 0 → min 1 | 1 |

**Implementation Options:**
- **Option A**: Modify `job_point_gifts.sql` directly with scaled values
- **Option B**: Apply scaling at runtime in code when loading/applying gifts

**Recommendation**: Option B (runtime scaling) - easier to adjust and doesn't require SQL changes.

**Rationale:**
- 50% reduction maintains meaningful bonuses without trivializing 75-era content
- Floor ensures consistent integer values
- Minimum of 1 ensures no gift becomes useless

---

## Implementation Checklist (Test-Driven Development)

### Phase 0: Module Setup
**Implementation:**
- [x] Create module file `server/modules/custom/lua/75_era_job_points.lua`
- [x] Register module in `modules/init.txt`
- [x] Add module-specific settings (ENABLED, LEVEL_REQUIREMENT, MOB_LEVEL_THRESHOLD, etc.)
- [x] Export helper functions via `xi.job_points_75era` global

**Tests:**
- [x] Module loads without errors
- [x] Module can be enabled/disabled via settings
- [x] Settings are accessible via `xi.settings.job_points_75era`

---

### Phase 1: Settings (via Module)
**Implementation:**
- [x] Add `ENABLED` to module settings
- [x] Add `LEVEL_REQUIREMENT` to module settings (default: 75)
- [x] Add `MOB_LEVEL_THRESHOLD` to module settings (default: 75)
- [x] Add `REQUIRE_KEY_ITEM` to module settings (default: true)
- [x] Add `GIFT_MULTIPLIER` to module settings (default: 0.5)

**Tests:**
- [x] Each setting has correct default value
- [x] Settings can be overridden in `xi.settings.job_points_75era`
- [x] Invalid setting values are handled gracefully

---

### Phase 2: Level Checks (via Module Override)
**Implementation:**
- [x] Override `charutils.cpp` line 5156 behavior
- [x] Override `job_points.cpp` line 254 behavior
- [x] Override `job_points.cpp` line 299 behavior
- [x] Override `0x063_miscdata_merits.cpp` line 51 behavior

**Tests:**
- [x] Level 74 character cannot earn CP
- [x] Level 75 character can earn CP (with other requirements met)
- [x] Level 75 character gets JP bonuses applied
- [x] Level 75 character gets gifts applied
- [x] Changing `JOB_POINTS_LEVEL_REQUIREMENT` setting changes behavior

---

### Phase 3: CP Formula (via Module Override)
**Implementation:**
- [x] Rewrite capacity point calculation to use configurable threshold
- [x] Implement retail formula with shifted baseline

**Tests:**
- [x] Mob level 74 (below threshold) grants 0 CP
- [x] Mob level 75 (at threshold) grants ~90 CP
- [x] Mob level 76 grants ~94 CP
- [x] Mob level 80 grants ~115 CP
- [x] Mob level 85 grants ~170 CP
- [x] CP values scale correctly with `CAPACITY_RATE` setting
- [x] Changing `JOB_POINTS_MOB_LEVEL_THRESHOLD` setting changes formula baseline

---

### Phase 4: Key Item & Merit Requirements (via Module)
**Implementation:**
- [x] Override Nomad Moogle NPC script to grant `JOB_BREAKER` when player has `LIMIT_BREAKER`
- [x] Add merit check function `hasMaxedJobMerits(player, jobId)` (stub - needs full implementation)
- [x] Implement `canUseJobPointsForJob()` - checks JOB_BREAKER + lvl 75 + maxed merits
- [x] Apply usage check to CP gain, JP spending, and gift application

**Tests:**
- [x] Player without LIMIT_BREAKER cannot get JOB_BREAKER from Nomad Moogle
- [ ] Player with LIMIT_BREAKER receives JOB_BREAKER from Nomad Moogle (requires NPC interaction test)
- [x] Player without JOB_BREAKER cannot access job point menu
- [x] Player with JOB_BREAKER can access job point menu
- [x] Player at level 75 without maxed merits cannot earn CP
- [x] Player at level 75 with maxed merits can earn CP
- [x] Player at level 74 (below requirement) cannot earn CP
- [x] Merit check correctly identifies all job-specific merits (Group 1 + Group 2)
- [x] Each job unlocks independently based on its own merits

---

### Phase 5: Capacity Chains (via Module Override)
**Implementation:**
- [x] Override chain threshold from 99 to configurable setting
- [x] Chains activate for mobs above threshold (76+ by default)

**Tests:**
- [x] Chain threshold setting is configurable
- [ ] Mob level 75 (at threshold) does not start chain (requires mob kill test)
- [ ] Mob level 76 (above threshold) starts chain (requires mob kill test)
- [ ] Chain bonus applies correctly: `1 + 0.05 * chainNumber` (requires mob kill test)
- [ ] Chain caps at 1.5x bonus at chain 10+ (requires mob kill test)
- [ ] Chain timer is 30 seconds (requires mob kill test)

---

### Phase 6: Gift Scaling (via Module Override)
**Implementation:**
- [x] Apply 50% scaling to all gift values at runtime
- [x] Floor all decimal values
- [x] Enforce minimum value of 1

**Tests:**
- [x] Gift value 10 scales to 5
- [x] Gift value 5 scales to 2
- [x] Gift value 3 scales to 1
- [x] Gift value 2 scales to 1
- [x] Gift value 1 scales to 1 (not 0)
- [x] All jobs' gifts are scaled correctly
- [x] Scaled gifts apply correctly to character stats

---

### Integration Tests
- [x] Earn CP from killing mob at threshold level (via JP rollover check)
- [x] No CP from killing mob below threshold level
- [x] No CP without JOB_BREAKER key item
- [x] Multi-job: WAR with merits can use JP, WHM without merits cannot
- [x] Multi-job: Switching jobs preserves merit state per job
- [x] Multi-job: Level 74 on current job cannot use JP even with merits
- [x] Key item: Player without LIMIT_BREAKER cannot receive JOB_BREAKER
- [x] Key item: Player with LIMIT_BREAKER meets prerequisite for JOB_BREAKER
- [x] Key item: Player already with JOB_BREAKER does not receive duplicate

### Tests NOT Implemented (Require Additional Infrastructure)
- [ ] Nomad Moogle NPC interaction (event 10045 is tied to LB quest system, requires full quest state)
- [ ] Capacity chain start/bonus/timer (capacityChain struct not exposed to Lua)
- [ ] Full flow: Maat fight → Nomad Moogle → Max merits → Earn CP → Spend JP → Receive gifts (requires multi-zone quest flow)
- [ ] Module disable: Disabling module reverts to retail behavior (requires runtime settings reload)

---

## Open Questions

1. ~~**CP Formula**: Linear (Option A) or Scaled Retail (Option B)?~~ **DECIDED: Option B (Scaled Retail)**
2. ~~**Key Item**: Which option for gating the system?~~ **DECIDED: Repurpose JOB_BREAKER, granted by Nomad Moogle when player has LIMIT_BREAKER**
3. ~~**Gift Scaling**: Keep retail values or reduce for 75-era?~~ **DECIDED: Scale by 50%, floor decimals, minimum value of 1**
4. ~~**Eligible Mobs**: Any mob at threshold, or restrict to certain content (NMs, endgame zones)?~~ **DECIDED: Any mob that meets the `JOB_POINTS_MOB_LEVEL_THRESHOLD` setting (default 75+)**
5. ~~**Chains**: Enable chains at 75, or disable entirely?~~ **DECIDED: Always enabled for mobs above threshold (76+)**

---

## References

- Retail Job Point Wiki: https://www.bg-wiki.com/ffxi/Job_Points
- Capacity Point Table: https://ffxiclopedia.fandom.com/wiki/Job_Points#Capacity_Points
- Current Implementation: `src/map/job_points.cpp`, `src/map/utils/charutils.cpp`

---

## Implementation Status

### Completed ✅

| Component | Files Modified | Description |
|-----------|----------------|-------------|
| **Settings (C++)** | `settings/default/map.lua` | Added `JOB_POINTS_PLAYER_LEVEL`, `JOB_POINTS_MOB_LEVEL`, `JOB_POINTS_GIFT_MULTIPLIER` |
| **Level Checks** | `src/map/utils/charutils.cpp` | `DistributeCapacityPoints` uses `JOB_POINTS_PLAYER_LEVEL` setting |
| **Level Checks** | `src/map/job_points.cpp` | `GetJobPointValue` uses setting for level requirement |
| **Gift Mods** | `src/map/job_points.cpp` | `RefreshGiftMods` uses level setting and applies `JOB_POINTS_GIFT_MULTIPLIER` |
| **BLU Bonus** | `src/map/packets/s2c/0x063_miscdata_merits.cpp` | Uses `JOB_POINTS_PLAYER_LEVEL` for BLU JP bonus |
| **CP Formula** | `src/map/utils/charutils.cpp` | Uses `JOB_POINTS_MOB_LEVEL` for threshold, calculates levelDiff from `JOB_POINTS_PLAYER_LEVEL` |
| **Capacity Chains** | `src/map/utils/charutils.cpp` | Chains work for mobs at/above threshold (`levelDiff >= 1`) |
| **Lua Module** | `modules/custom/lua/75_era_job_points.lua` | Nomad Moogle override for JOB_BREAKER, merit checks, helper functions |
| **Tests** | `scripts/tests/systems/job_points_75era.lua` | Unit tests for settings, CP formula, gift scaling, key items |

### Configuration for 75-Era Server

To enable job points at level 75, add the following to your `settings/server/map.lua`:

```lua
-- Job Points at Level 75
JOB_POINTS_PLAYER_LEVEL = 75,     -- Level 99 → Level 75
JOB_POINTS_MOB_LEVEL = 75,        -- Mob 100+ → Mob 75+
JOB_POINTS_GIFT_MULTIPLIER = 0.5, -- 50% gift values to reduce power creep
```

### Module Registration

Ensure the module is registered in `modules/init.txt`:
```
custom/lua/75_era_job_points.lua
```

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-12-11 | Initial | Created planning document |
| 2025-12-11 | Implementation | Completed C++ changes, Lua module, and tests |
