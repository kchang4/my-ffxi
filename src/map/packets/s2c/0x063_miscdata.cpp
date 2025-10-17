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

#include "0x063_miscdata.h"

#include "common/timer.h"
#include "entities/charentity.h"
#include "enums/key_items.h"
#include "job_points.h"
#include "merit.h"
#include "status_effect_container.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_MISCDATA::MERITS::MERITS(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = pkt_type::merits;
    packet.unknown06 = sizeof(PacketData) - 8;

    packet.limitPoints = PChar->PMeritPoints->GetLimitPoints();
    packet.meritPoints = PChar->PMeritPoints->GetMeritPoints();
    packet.bluBonus    = 0;

    // Add BLU spell point bonus
    if (PChar->GetMJob() == JOB_BLU)
    {
        uint8 bluePointBonus = 0;

        if (PChar->GetMLevel() >= 75)
        {
            bluePointBonus += PChar->PMeritPoints->GetMeritValue(MERIT_ASSIMILATION, PChar);
        }

        if (PChar->GetMLevel() >= 99)
        {
            bluePointBonus += PChar->PJobPoints->GetJobPointValue(JP_BLUE_MAGIC_POINT_BONUS);
        }

        packet.bluBonus = bluePointBonus;
    }

    const bool atMaxLevelLimit = PChar->jobs.job[PChar->GetMJob()] >= PChar->jobs.genkai;
    const bool hasCappedXp     = PChar->jobs.exp[PChar->GetMJob()] == (charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]) - 1);

    packet.canUseMeritMode     = PChar->jobs.job[PChar->GetMJob()] >= 75 && charutils::hasKeyItem(PChar, KeyItem::LIMIT_BREAKER);
    packet.xpCappedOrMeritMode = (atMaxLevelLimit && hasCappedXp) || PChar->MeritMode;
    packet.meritModeEnabled    = packet.canUseMeritMode && PChar->MeritMode;
    packet.maxMeritPoints      = settings::get<uint8>("map.MAX_MERIT_POINTS") + PChar->PMeritPoints->GetMeritValue(MERIT_MAX_MERIT, PChar);
}

GP_SERV_COMMAND_MISCDATA::MONSTROSITY1::MONSTROSITY1(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = pkt_type::monstrosity1;
    packet.unknown06 = sizeof(PacketData) - 8;
}

GP_SERV_COMMAND_MISCDATA::MONSTROSITY2::MONSTROSITY2(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = pkt_type::monstrosity2;
    packet.unknown06 = sizeof(PacketData) - 8;

    // TODO: Populate data.Monstrosity2 fields
}

GP_SERV_COMMAND_MISCDATA::JOBPOINTS::JOBPOINTS(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = pkt_type::job_points;
    packet.unknown06 = sizeof(PacketData) - 8;
}

GP_SERV_COMMAND_MISCDATA::HOMEPOINTS::HOMEPOINTS(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = pkt_type::homepoints;
    packet.unknown06 = sizeof(PacketData) - 8;

    // Copy teleport masks directly
    std::memcpy(packet.homePoint, PChar->teleport.homepoint.access, sizeof(packet.homePoint));
    std::memcpy(packet.survivalGuide, PChar->teleport.survival.access, sizeof(packet.survivalGuide));
    std::memcpy(packet.waypoint, PChar->teleport.waypoints.access, sizeof(packet.waypoint));

    // Everything below is untested/unimplemented
    // packet.atmos        = PChar->teleport.pastMaw;
    // packet.eschanPortal = PChar->teleport.eschanPortal;
    // packet.telepoint = PChar->teleport.telepoint;
    // packet.unknown00 = PChar->teleport.unknown00;
}

GP_SERV_COMMAND_MISCDATA::UNITY::UNITY(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = pkt_type::unity;
    packet.unknown06 = sizeof(PacketData) - 8;
}

GP_SERV_COMMAND_MISCDATA::STATUS_ICONS::STATUS_ICONS(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = pkt_type::status_icons;
    packet.unknown06 = sizeof(PacketData) - 8;

    // Initialize all icons to 0xFF (no icon)
    std::ranges::fill(packet.icons, 0x00FF);

    int i = 0;
    // clang-format off
    PChar->StatusEffectContainer->ForEachEffect([&packet, &i](CStatusEffect* PEffect)
    {
        if (PEffect->GetIcon() != 0)
        {
            auto durationRemaining = 0x7FFFFFFF;
            if (PEffect->GetDuration() > 0s && !PEffect->HasEffectFlag(EFFECTFLAG_HIDE_TIMER))
            {
                // this value overflows, but the client expects the overflowed timestamp and corrects it
                durationRemaining = timer::count_seconds(PEffect->GetStartTime() - timer::now() + PEffect->GetDuration());
                durationRemaining += earth_time::vanadiel_timestamp();
                durationRemaining *= 60;
            }
            packet.icons[i]      = PEffect->GetIcon();
            packet.timestamps[i] = durationRemaining;
            ++i;
        }
    });
    // clang-format on
}
