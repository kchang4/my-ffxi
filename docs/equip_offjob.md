# EQUIP_OFFJOB

`xi.mod.EQUIP_OFFJOB` (id 1215) lets a worn item unlock other armor for the wearer regardless of that armor's job list.
The unlocked armor still obeys level, Superior Level and race limits, and weapons can never be unlocked.

## Value

The value is a bitmask of equip slots, `1 << (slot - 4)`:

| Slot  | Value | Slot  | Value |
|-------|------:|-------|------:|
| Head  |     1 | Waist |    64 |
| Body  |     2 | Ear1  |   128 |
| Hands |     4 | Ear2  |   256 |
| Legs  |     8 | Ring1 |   512 |
| Feet  |    16 | Ring2 |  1024 |
| Neck  |    32 | Back  |  2048 |

Add values together to unlock several slots (head + hands = 5). Any armor item may carry the mod.

Give an item the mod in `item_mods` (example: an item that unlocks head gear):

```sql
INSERT INTO `item_mods` (`itemId`, `modId`, `value`) VALUES (<itemId>, 1215, 1);
```

The item's client description (DAT) should say what it does, e.g. "Can equip level permitted head gear".

## Rules

* Only an item the character can wear normally (job, level, Superior Level, race) unlocks anything. An item that is itself
  unlocked by another item never unlocks anything, so unlocks cannot chain.
* The unlock set is recomputed from what is worn at the moment of each check. It never depends on the order things were equipped in.
* When an unlocking item comes off, or stops being wearable (level sync, job change), everything it unlocked comes off too.

## Where it is enforced (src/map/utils/charutils.cpp)

| Path | Behavior |
|------|----------|
| `EquipArmor` | job check also accepts an unlocked slot; the item in the target slot is ignored as an unlocker because it is being replaced |
| `EquipItem` (end) | `StripInvalidOffJobGear` removes anything left without its unlocker (ring replaced by one that doesn't unlock, displaced by a body piece, etc.) |
| `UnequipItem` | removing an unlocking item (explicit unequip, Recalculate::Yes) strips what it unlocked |
| `CheckValidEquipment` | job change, level change/delevel, merit/party sync: job check accepts unlocked slots, recomputed per slot |
| `RemoveAllEquipment` | goes through `UnequipItem` |
| `LoadEquip` (login) | unlocking items are equipped first, then the rest |
| `LoadJobChangeGear` | unlocking items are equipped first, then the rest |
| Equipset packet (0x051) | unlocking items are applied first, then the rest |

Not changed on purpose: `player:canEquipItem()` (Lua helper, answers "can this job wear it" for quest scripts) and lockstyle.

## Client display

The client greys armor its job can't wear. The Ashita plugin needs to flip the job mask of matching inventory records
while an unlocking item is worn (see the OffJobTest plugin and findings notes). The server is authoritative either way.
