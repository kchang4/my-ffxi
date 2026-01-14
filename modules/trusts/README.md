# Enhanced Trusts Module

This module contains enhanced trust implementations with improved AI, traits, and features.

## Purpose

This module overrides core trust scripts to provide:
- **Job-specific traits** (Treasure Hunter, Triple Attack, Subtle Blow, etc.)
- **Stat modifiers** that scale with level
- **Complete teamwork messages** with related trusts
- **Role-appropriate AI gambits** (healers, tanks, DPS, support)
- **Special dialogue** for signature abilities

## Structure

```
modules/trusts/
├── README.md           # This file
├── QUICKSTART.md       # Quick start guide
├── DEVELOPMENT_LOG.md  # Enhancement tracking
└── lua/                # Enhanced trust Lua scripts
    ├── lion_ii.lua     # Enhanced Lion II (THF/NIN)
    └── ...             # More trusts as we enhance them
```

## Installation

Add to `modules/init.txt`:
```
trusts/
```

The module system will automatically load all Lua files and override core trust scripts with the same filename.

## Enhanced Trusts

### Completed
- ✅ **Lion II** - THF/NIN with Treasure Hunter I, Triple Attack, Subtle Blow

### Planned
- ⏳ **Apururu (UC)** - Enhanced WHM healing priorities
- ⏳ **Qultada** - COR with proper phantom roll logic
- ⏳ **Joachim** - BRD with song rotation
- ⏳ **Sylvie (UC)** - GEO with geomancy bubbles
- ⏳ **Ygnas** - Monster healer

## Development

When adding new enhanced trusts:
1. Copy the trust script name from `scripts/actions/spells/trust/`
2. Place enhanced version in `modules/trusts/lua/`
3. Module system will auto-load the override
4. Test thoroughly before committing

## Notes

- This module only overrides specific trusts we've enhanced
- Non-overridden trusts use core implementations
- All enhancements are based on retail FFXI behavior
- Scripts are compatible with LandSandBoat updates
