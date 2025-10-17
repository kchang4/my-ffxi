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

class CCharEntity;
enum class pkt_type : uint16_t
{
    merits       = 0x02,
    monstrosity1 = 0x03,
    monstrosity2 = 0x04,
    job_points   = 0x05,
    homepoints   = 0x06,
    unity        = 0x07,
    status_icons = 0x09,
    unknown_0A   = 0x0A,
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0063
// This packet is sent by the server to inform the client of multiple different kinds of information.
namespace GP_SERV_COMMAND_MISCDATA
{
    // Type 0x02: Merit/Limit Points (data: 8 bytes, total: 16 bytes)
    class MERITS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, MERITS>
    {
    public:
        struct PacketData
        {
            pkt_type type;                    // PS2: type
            uint16_t unknown06;               // PS2: (New; did not exist.)
            uint16_t limitPoints;             // Limit points available
            uint16_t meritPoints : 7;         // Merit points value (0-127)
            uint16_t bluBonus : 6;            // BLU spell point bonus (0-63)
            uint16_t canUseMeritMode : 1;     // Level >= 75 and has Limit Breaker KI
            uint16_t xpCappedOrMeritMode : 1; // XP is capped or player is in merit mode
            uint16_t meritModeEnabled : 1;    // Merit mode enabled and current job is eligible
            uint8_t  maxMeritPoints;          // Maximum merit points
            uint8_t  padding[3];
        };

        MERITS(CCharEntity* PChar);
    };

    // Type 0x03: Monstrosity Info Part 1 (data: 212 bytes, total: 220 bytes)
    class MONSTROSITY1 final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, MONSTROSITY1>
    {
    public:
        struct PacketData
        {
            pkt_type type;          // PS2: type
            uint16_t unknown06;     // PS2: (New; did not exist.)
            uint16_t species;       // Current monstrosity species
            uint16_t flags;         // Monstrosity flags
            uint8_t  rank;          // Monstrosity rank (0=Mon, 1=NM, 2=HNM)
            uint8_t  padding1[3];   // Padding
            uint8_t  unknown1[2];   // Unknown bytes at 0x08-0x09
            uint16_t infamy;        // Infamy points
            uint8_t  unknown2;      // Unknown byte at 0x0C
            uint8_t  padding2[3];   // Padding
            uint8_t  instincts[64]; // Instinct bitfield (2-bit values packed)
            uint8_t  levels[128];   // Monster level data
        };

        MONSTROSITY1(CCharEntity* PChar);
    };

    // Type 0x04: Monstrosity Info Part 2 (data: 172 bytes, total: 180 bytes)
    class MONSTROSITY2 final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, MONSTROSITY2>
    {
    public:
        struct PacketData
        {
            pkt_type type;          // PS2: type
            uint16_t unknown06;     // PS2: (New; did not exist.)
            uint8_t  unknown[126];  // Unknown/unused data
            uint8_t  slimeLevel;    // Slime level (added after initial release) - offset 0x7E from data start
            uint8_t  sprigganLevel; // Spriggan level (added after initial release) - offset 0x7F
            uint8_t  instincts2[4]; // Additional instinct bitfield - offset 0x80
            uint8_t  padding[12];   // Padding before variants - offset 0x84
            uint8_t  variants[32];  // Variant ownership bitfield - offset 0x8C
        };

        MONSTROSITY2(CCharEntity* PChar);
    };

    // Type 0x05: Job Points (data: 148 bytes, total: 156 bytes)
    class JOBPOINTS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, JOBPOINTS>
    {
    public:
        struct PacketData
        {
            pkt_type type;      // PS2: type
            uint16_t unknown06; // PS2: (New; did not exist.)
            uint8_t  access;    // Access flag (0=no access, 1=access)
            uint8_t  padding1;
            uint8_t  padding2[2];
            struct JobPointData
            {
                uint16_t capacityPoints; // Capacity points for this job
                uint16_t currentJp;      // Current unspent job points
                uint16_t totalJpSpent;   // Total job points spent
            } jobs[24];                  // One entry per job (starting from index 1, job 0 unused)
        };

        JOBPOINTS(const CCharEntity* PChar);
    };

    // Type 0x06: Homepoint Masks (data: 64 bytes, total: 72 bytes)
    class HOMEPOINTS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, HOMEPOINTS>
    {
    public:
        struct PacketData
        {
            pkt_type type;               // PS2: type
            uint16_t unknown06;          // PS2: (New; did not exist.)
            uint32_t homePoint[4];       // Homepoint teleport access masks (16 bytes)
            uint32_t survivalGuide[4];   // Survival guide access masks (16 bytes)
            uint32_t waypoint[4];        // Waypoint/Abyssea Maw access masks (16 bytes)
            uint32_t telepoint;          // Telepoint access mask (4 bytes)
            uint32_t atmos;              // Atmacite teleport mask (4 bytes)
            uint32_t eschanPortal;       // Eschan portal mask (4 bytes)
            uint32_t unknown00;          // Unknown mask (4 bytes)
        };

        HOMEPOINTS(const CCharEntity* PChar);
    };

    // Type 0x07: Unity Info (data: 132 bytes, total: 140 bytes)
    class UNITY final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, UNITY>
    {
    public:
        struct PacketData
        {
            pkt_type type;        // PS2: type
            uint16_t unknown06;   // PS2: (New; did not exist.)
            uint8_t  subTypeHigh; // High byte of subtype
            uint8_t  subTypeLow;  // Low byte of subtype (0x00-0x02 for results, 0x100-0x102 for partial)
            uint8_t  padding[6];

            union
            {
                struct
                {
                    uint32_t members[11]; // Total contributing members per unity
                    uint8_t  padding[88];
                } MemberData; // Subtypes 0x01, 0x0101

                struct
                {
                    uint32_t points[11]; // Total points per unity
                    uint8_t  padding[88];
                } PointData; // Subtypes 0x02, 0x0102

                struct
                {
                    uint8_t data[132]; // Generic data for other subtypes
                } RawData;             // Subtypes 0x00, 0x03-0x1F, 0x0100, etc.
            };
        };

        UNITY(CCharEntity* PChar);
    };

    // Type 0x09: Status Effect Icons (data: 192 bytes, total: 200 bytes)
    class STATUS_ICONS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, STATUS_ICONS>
    {
    public:
        struct PacketData
        {
            pkt_type type;           // PS2: type
            uint16_t unknown06;      // PS2: (New; did not exist.)
            uint16_t icons[32];      // Status effect icon IDs (64 bytes)
            uint32_t timestamps[32]; // Status effect expiration timestamps (Vanadiel time) (128 bytes)
        };

        STATUS_ICONS(const CCharEntity* PChar);
    };

    // Type 0x0A: Unknown (data: 32 bytes, total: 40 bytes)
    class UNKNOWN final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, UNKNOWN>
    {
    public:
        struct PacketData
        {
            pkt_type type;      // PS2: type
            uint16_t unknown06; // PS2: (New; did not exist.)
            uint8_t  data[32];
        };

        UNKNOWN(CCharEntity* PChar);
    };

} // namespace GP_SERV_COMMAND_MISCDATA
