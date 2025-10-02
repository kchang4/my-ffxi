/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#pragma once

#include "base.h"

class CBaseEntity;
struct TreasurePoolItem;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00D2
// This packet is sent by the server when an item has been found and would be added to the treasure pool or be split amongst the party.
class GP_SERV_COMMAND_TROPHY_LIST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_TROPHY_LIST, GP_SERV_COMMAND_TROPHY_LIST>
{
public:
    struct PacketData
    {
        uint32_t TrophyItemNum;   // PS2: TrophyItemNum
        uint32_t TargetUniqueNo;  // PS2: TargetUniqueNo
        uint16_t Gold;            // PS2: Gold
        uint16_t padding00;       // PS2: (New; did not exist)
        uint16_t TrophyItemNo;    // PS2: TrophyItemNo
        uint16_t TargetActIndex;  // PS2: TargetActIndex
        uint8_t  TrophyItemIndex; // PS2: TrophyItemIndex
        uint8_t  Entry;           // PS2: Entry
        uint8_t  IsContainer;     // PS2: IsContainer
        uint8_t  padding01;       // PS2: (New; did not exist)
        uint32_t StartTime;       // PS2: StartTime
        uint16_t IsLocallyLotted; // PS2: IsLocallyLotted
        uint16_t Point;           // PS2: Point
        uint32_t LootUniqueNo;    // PS2: LootUniqueNo
        uint16_t LootActIndex;    // PS2: LootActIndex
        uint16_t LootPoint;       // PS2: LootPoint
        uint8_t  LootActName[16]; // PS2: LootActName
        uint8_t  Flags;           // PS2: NamedFlag, SingleFlag, Flags_2, Flags_4 (bitfield)
    };

    GP_SERV_COMMAND_TROPHY_LIST(TreasurePoolItem* PItem, CBaseEntity* PEntity, bool isOldItem);
};
