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

#include "0x08d_job_points.h"

#include <cstring>

#include "entities/charentity.h"
#include "job_points.h"

// Constructor for full job point details
GP_SERV_COMMAND_JOB_POINTS::GP_SERV_COMMAND_JOB_POINTS(CCharEntity* PChar)
{
    auto& packet = this->data();

    const JobPoints_t* PJobPoints = PChar->PJobPoints->GetAllJobPoints();
    if (!PJobPoints)
    {
        return;
    }

    uint8 pointIndex = 0;

    // Start at 1 for WAR
    for (uint8 i = 1; i < MAX_JOBTYPE; i++)
    {
        const JobPoints_t current_job = PJobPoints[i];

        for (uint8 j = 0; j < JOBPOINTS_JPTYPE_PER_CATEGORY; j++)
        {
            JobPointType_t current_type = current_job.job_point_types[j];
            if (current_type.id != 0 && pointIndex < 64)
            {
                // Map the LSB data to XiPackets format
                packet.points[pointIndex].job_no = current_type.id;
                packet.points[pointIndex].level  = JobPointValueFormat(current_type.value);
                packet.points[pointIndex].next   = JobPointCost(current_type.value);
                packet.points[pointIndex].index  = j;
                pointIndex++;
            }
        }

        // Send a packet every 2 jobs (40 entries)
        if (i % 2 == 1 && pointIndex > 0)
        {
            PChar->pushPacket(this->copy());

            // Reset for next packet
            std::memset(&packet, 0, sizeof(packet));
            pointIndex = 0;
        }
    }
}

// Constructor for single job point update
GP_SERV_COMMAND_JOB_POINTS::GP_SERV_COMMAND_JOB_POINTS(const CCharEntity* PChar, const JOBPOINT_TYPE jpType)
{
    auto& packet = this->data();

    const JobPointType_t* PJobPoint = PChar->PJobPoints->GetJobPointType(jpType);

    // Put the update in the first slot
    packet.points[0].job_no = PJobPoint->id;
    packet.points[0].level  = JobPointValueFormat(PJobPoint->value);
    packet.points[0].next   = JobPointCost(PJobPoint->value);
    packet.points[0].index  = 0;
}
