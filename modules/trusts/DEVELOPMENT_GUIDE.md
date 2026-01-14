# Trust Implementation Checklist

This document outlines all the information needed to properly implement a new trust in the game.

## 📋 **Phase 1: Character Design & Concept**

### 1.1 Basic Character Information
- [ ] **Character Name**: Official name as it appears in FFXI
- [ ] **Trust Type**: Regular, Unity Concord (UC), or "II" version
- [ ] **Source Material**: Which expansion/storyline (NULL, COP, TOAU, WOTG, SOA, ROV, etc.)
- [ ] **Character Description**: Who is this character in FFXI lore?
- [ ] **Visual Appearance**: Character model ID (if creating from existing NPC)

### 1.2 Combat Role Classification
Choose the primary role:
- [ ] **Tank** (Paladin, Warrior)
- [ ] **Healer** (White Mage, Scholar)
- [ ] **Melee DPS** (Samurai, Monk, Dragoon, Thief)
- [ ] **Ranged DPS** (Ranger, Corsair)
- [ ] **Magic DPS** (Black Mage, Summoner, Blue Mage)
- [ ] **Support** (Bard, Red Mage, Geomancer, Dancer)
- [ ] **Hybrid** (Dark Knight, Ninja, etc.)

### 1.3 Job & Stats
- [ ] **Main Job** (e.g., WAR, WHM, BLM, SAM)
- [ ] **Sub Job** (if any)
- [ ] **Level Range**: Min/Max (usually 1-99 or matches player)
- [ ] **Primary Stats**: Which stats should be emphasized (STR, DEX, INT, etc.)

---

## 📊 **Phase 2: Database Configuration**

### 2.1 Spell Entry (`spell_list.sql`)
Create the trust spell that players cast:

```sql
INSERT INTO `spell_list` VALUES (
    SPELL_ID,                                      -- Unique spell ID (e.g., 1010 for Zeid II)
    'character_name',                              -- Spell name (lowercase with underscores)
    0x01010101010101010101010101010101010101010101, -- Job bitmap (all 1s = all jobs can cast)
    8,                                             -- Magic type (8 = Trust)
    0,                                             -- Sub-type
    @ELEMENT_LIGHT,                                -- Element (always LIGHT for trusts)
    0,                                             -- Validation flags
    1,                                             -- Target type (1 = self)
    @SKILL_NONE,                                   -- Skill type (NONE for trusts)
    0,                                             -- MP cost (0 for trusts)
    2000,                                          -- Cast time (ms)
    240000,                                        -- Recast (240s standard)
    0,                                             -- Status effect
    0,                                             -- Status effect 2
    939,                                           -- Animation ID (939 = trust spawn)
    1500,                                          -- Animation time
    0,                                             -- Message offset
    0,                                             -- AOE radius
    1.00,                                          -- Cast time multiplier
    0,                                             -- Flags
    0,                                             -- Flags 2
    0,                                             -- Flags 3
    0,                                             -- Flags 4
    NULL                                           -- Requirement (expansion)
);
```

**Required Info:**
- [ ] Spell ID (check next available ID in spell_list table)
- [ ] Spell name (lowercase, underscores)
- [ ] Expansion requirement (NULL, COP, TOAU, WOTG, SOA, ROV)

### 2.2 Mob Pool Entry (`mob_pools.sql`)
Define the trust's mob pool (usually matches character model from NPC):

```sql
INSERT INTO `mob_pools` VALUES (
    POOL_ID,                    -- Unique pool ID
    'TRUST_CharacterName',      -- Pool name
    MOB_MODEL_ID,              -- Model ID (from existing NPC or custom)
    JOB_MAIN,                  -- Main job
    JOB_SUB,                   -- Sub job (0 for none)
    FLAGS,                     -- Mob flags
    TRUE_DETECTION,            -- True detection range
    LINK_RADIUS,               -- Link radius (0 for trusts)
    ELEMENT,                   -- Elemental affinity
    LEVEL_MIN,                 -- Minimum level
    LEVEL_MAX                  -- Maximum level
);
```

**Required Info:**
- [ ] Pool ID
- [ ] Character model ID (can reuse NPC model)
- [ ] Main job ID (see job constants)
- [ ] Sub job ID
- [ ] Level range

### 2.3 Mob Spell List (`mob_spell_lists.sql`)
Define what magic spells the trust can cast:

```sql
-- Example: Zeid II spell list (ID 419)
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Zeid_II',419,243,91,255);  -- absorb-attri (levels 91-255)
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Zeid_II',419,252,37,255);  -- stun (levels 37-255)
```

**Required Info:**
- [ ] List of spells by spell ID
- [ ] Level requirements for each spell (min/max)

### 2.4 Mob Skill List (`mob_skill_lists.sql`)
Define weapon skills the trust can use:

```sql
-- Example: Zeid II can use Ground Strike
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Zeid_II',1125,56); -- 1125=list ID, 56=Ground Strike
```

**Required Info:**
- [ ] List of weapon skills by ID
- [ ] Weapon skill IDs (check weapon_skills table)

### 2.5 Mob Resistances (`mob_resistances.sql`)
Set elemental resistances (usually 0 for trusts):

```sql
INSERT INTO `mob_resistances` VALUES (
    POOL_ID,
    'CharacterName',
    0,0,0,0,0,0,0,0,  -- Fire,Ice,Wind,Earth,Thunder,Water,Light,Dark
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  -- Status effects
);
```

**Required Info:**
- [ ] Any special resistances or immunities

---

## 🎮 **Phase 3: AI Behavior (Lua Script)**

### 3.1 Create Trust Lua File
Location: `scripts/actions/spells/trust/character_name.lua`

**Template Structure:**
```lua
-----------------------------------
-- Trust: Character Name
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    -- Check if trust can be cast (incompatible trusts)
    return xi.trust.canCast(caster, spell)
    -- Or: return xi.trust.canCast(caster, spell, xi.magic.spell.OTHER_TRUST_ID)
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Spawn the trust
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    -- Set teamwork messages
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.OTHER_TRUST_ID] = xi.trust.messageOffset.TEAMWORK_1,
    })

    -- Add gambits (AI behavior) here
    
    -- Add stat modifiers
    
    -- Configure movement and behavior
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
```

### 3.2 Gambit Design
Define the AI decision tree (evaluated top to bottom, first match wins):

**Healer Gambits Example:**
```lua
-- Emergency healing (highest priority)
mob:addGambit(ai.t.PARTY, {ai.c.HPP_LT, 25}, {ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE})

-- Status removal
mob:addGambit(ai.t.PARTY, {ai.c.STATUS, xi.effect.PARALYSIS}, {ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PARALYNA})

-- Buffs
mob:addGambit(ai.t.PARTY, {ai.c.NOT_STATUS, xi.effect.Pro TECT}, {ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PROTECTRA})
```

**Melee DPS Gambits Example:**
```lua
-- Use job abilities
mob:addGambit(ai.t.SELF, {ai.c.ALWAYS, 0}, {ai.r.JA, ai.s.SPECIFIC, xi.ja.HASSO})
mob:addGambit(ai.t.SELF, {ai.c.ALWAYS, 0}, {ai.r.JA, ai.s.SPECIFIC, xi.ja.MEDITATE})

-- Weapon skills at 1000+ TP
mob:setTrustTPSkillSettings(ai.tp.CLOSER, ai.s.HIGHEST, 1000)
```

**Magic DPS Gambits Example:**
```lua
-- Magic burst priority
mob:addGambit(ai.t.TARGET, {ai.c.MB_AVAILABLE, 0}, {ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE})

-- Regular nuking
mob:addGambit(ai.t.TARGET, {ai.c.NOT_SC_AVAILABLE, 0}, {ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE}, 60)
```

**Required Info:**
- [ ] Priority list of actions (what should the trust do first, second, third, etc.)
- [ ] Healing thresholds (if healer)
- [ ] Buff priorities
- [ ] Combat abilities/spells
- [ ] TP usage settings (for melee)

### 3.3 Stat Modifications
Add permanent stat bonuses:

```lua
-- Example: Increase magic attack/accuracy by 10% of level
local power = mob:getMainLvl() / 10
mob:addMod(xi.mod.MATT, power)
mob:addMod(xi.mod.MACC, power)
mob:addMod(xi.mod.HASTE_MAGIC, 1000) -- 10% haste (1000 = 10%)
```

**Common Mods:**
- `xi.mod.MATT` - Magic Attack
- `xi.mod.MACC` - Magic Accuracy
- `xi.mod.ATT` - Attack
- `xi.mod.ACC` - Accuracy
- `xi.mod.DEF` - Defense
- `xi.mod.HASTE_MAGIC` - Magic Haste (1000 = 10%)
- `xi.mod.REGEN` - HP Regen
- `xi.mod.REFRESH` - MP Refresh

**Required Info:**
- [ ] Which stats to boost
- [ ] By how much (usually scales with level)

### 3.4 Movement Configuration
Set combat positioning:

```lua
-- No movement (casters)
mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.NO_MOVE)

-- Melee range (default)
mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.MELEE)

-- Mid-range (6 yalms)
mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.MID_RANGE)

-- Long-range (12 yalms)
mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.LONG_RANGE)

-- Custom distance
mob:setMobMod(xi.mobMod.TRUST_DISTANCE, 15) -- 15 yalms
```

**Required Info:**
- [ ] Preferred combat distance

### 3.5 Special Features (Optional)

**Auto-attack toggle:**
```lua
mob:setAutoAttackEnabled(false) -- For pure casters
```

**Event listeners** (for special messages/abilities):
```lua
mob:addListener('WEAPONSKILL_USE', 'TRUST_NAME_WS_USE', function(mobArg, target, wsid, tp, action)
    if wsid == 56 then -- Ground Strike
        xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
    end
end)
```

**TP Skill Settings:**
```lua
mob:setTrustTPSkillSettings(
    ai.tp.CLOSER_UNTIL_TP,     -- When to use (ASAP, CLOSER, CLOSER_UNTIL_TP)
    ai.s.RANDOM,               -- Selection (HIGHEST, RANDOM, SPECIFIC)
    3000                       -- TP threshold
)
```

**Required Info:**
- [ ] Should auto-attack be enabled?
- [ ] Any special dialogue triggers?
- [ ] TP usage strategy?

### 3.6 Teamwork Messages
Define special dialogue when summoned with specific other trusts:

```lua
xi.trust.teamworkMessage(mob, {
    [xi.magic.spell.SHANTOTTO] = xi.trust.messageOffset.TEAMWORK_1,
    [xi.magic.spell.AJIDO_MARUJIDO] = xi.trust.messageOffset.TEAMWORK_2,
})
```

**Required Info:**
- [ ] List of trusts that trigger special dialogue
- [ ] Which message offset to use (TEAMWORK_1 through TEAMWORK_5)

---

## 🗂️ **Phase 4: Equipment & Appearance (Optional)**

### 4.1 Equipment Sets
Define what equipment the trust has equipped (affects appearance and stats):

**Location:** Mob pool data or custom Lua initialization

**Required Info:**
- [ ] Weapon(s)
- [ ] Armor sets
- [ ] Accessories

### 4.2 Custom Animations
If using custom abilities or special moves:

**Required Info:**
- [ ] Animation IDs for special abilities
- [ ] Trigger conditions

---

## ✅ **Phase 5: Quest Implementation (Optional)**

If the trust requires a quest to obtain:

### 5.1 Quest File
**Location:** `scripts/quests/category/Trust_CharacterName.lua`

**Required Info:**
- [ ] Quest name
- [ ] Prerequisites
- [ ] NPCs involved
- [ ] Completion conditions
- [ ] Reward (the trust spell)

### 5.2 Cipher Item
If using a consumable cipher:

**Required Info:**
- [ ] Cipher item ID
- [ ] Cipher name
- [ ] How players obtain it

---

## 🧪 **Phase 6: Testing Checklist**

### 6.1 Basic Functionality
- [ ] Trust can be summoned
- [ ] Trust appears with correct model
- [ ] Trust despawns when dismissed or on death
- [ ] Trust follows the player
- [ ] Trust engages in combat

### 6.2 Combat Behavior
- [ ] Gambits execute in correct priority order
- [ ] Spells/abilities are used appropriately
- [ ] Trust positions itself correctly (melee/range/caster)
- [ ] TP skills are used at correct threshold
- [ ] Auto-attack works (if enabled)

### 6.3 Special Features
- [ ] Teamwork messages appear with correct trusts
- [ ] Event listeners trigger properly
- [ ] Stat bonuses apply correctly
- [ ] No errors in server log

### 6.4 Edge Cases
- [ ] Trust doesn't despawn incorrectly
- [ ] Works in different zones (if allowed)
- [ ] Works with other trusts (no conflicts)
- [ ] Respects trust count limits
- [ ] Cannot be summoned when not allowed (alliance, enmity, etc.)

---

## 📝 **Summary: Minimum Required Information**

To implement a basic trust, you **MUST** have:

1. **Character Name** and **Job**
2. **Spell ID** (next available in spell_list)
3. **Pool ID** (mob pool entry)
4. **Combat Role** (healer/DPS/tank/support)
5. **At least 3-5 gambits** for basic AI behavior
6. **Movement type** (melee/range/caster positioning)
7. **Spell/ability list** (what can they cast/use)
8. **Model ID** (appearance)

Optional but recommended:
- Stat modifiers
- Teamwork messages
- Special event triggers
- TP skill settings
- Equipment loadout

---

## 🔧 **Development Workflow**

1. **Design Phase**
   - Define character concept
   - Choose combat role
   - List abilities/spells
   - Design gambit priority

2. **Database Phase**
   - Add spell_list entry
   - Add mob_pools entry
   - Add mob_spell_lists entry
   - Add mob_skill_lists entry
   - Add mob_resistances entry

3. **Scripting Phase**
   - Create trust Lua file
   - Implement onMobSpawn() gambits
   - Add stat modifiers
   - Configure movement
   - Add special features (optional)

4. **Testing Phase**
   - Summon and test basic functionality
   - Test combat behavior
   - Verify gambits execute correctly
   - Check for errors in log
   - Refine AI as needed

5. **Polish Phase**
   - Add teamwork messages
   - Fine-tune stats
   - Optimize gambit priorities
   - Add quest (if needed)

---

## 📚 **Reference Files**

When implementing, refer to these existing files:
- `scripts/actions/spells/trust/shantotto.lua` - Simple BLM caster
- `scripts/actions/spells/trust/kupipi.lua` - WHM healer with status removal
- `scripts/actions/spells/trust/zeid_ii.lua` - Melee DPS with stun gambits
- `scripts/actions/spells/trust/kupipi.lua` - Complex healing priorities
- `scripts/globals/trust.lua` - Trust utility functions
- `sql/mob_pools.sql` - Mob pool examples
- `sql/spell_list.sql` - Trust spell examples

---

## 🎯 **Quick Start Template**

For a basic trust, fill in these blanks:

```
Character Name: _______________
Job: _______________
Combat Role: _______________
Spell ID: _______________
Pool ID: _______________
Model ID: _______________

Top 3 Priorities:
1. _______________
2. _______________
3. _______________

Spells/Abilities:
- _______________
- _______________
- _______________

Movement Type: _______________ (melee/caster/mid-range/long-range)
```

Once you have this information, you can implement the trust!
