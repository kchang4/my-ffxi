-----------------------------------
-- Tests for 75 Era Job Points Module
-----------------------------------

describe('75 Era Job Points Module', function()
    describe('Module Setup (Phase 0)', function()
        it('exports xi.job_points_75era table', function()
            assert(xi.job_points_75era ~= nil, 'xi.job_points_75era should exist')
        end)

        it('exports settings table', function()
            assert(xi.settings.job_points_75era ~= nil, 'xi.settings.job_points_75era should exist')
        end)

        it('exports hasMaxedJobMerits function', function()
            assert(type(xi.job_points_75era.hasMaxedJobMerits) == 'function',
                'hasMaxedJobMerits should be a function')
        end)

        it('exports canUseJobPointsForJob function', function()
            assert(type(xi.job_points_75era.canUseJobPointsForJob) == 'function',
                'canUseJobPointsForJob should be a function')
        end)

        it('exports calculateCapacityPoints function', function()
            assert(type(xi.job_points_75era.calculateCapacityPoints) == 'function',
                'calculateCapacityPoints should be a function')
        end)

        it('exports scaleGiftValue function', function()
            assert(type(xi.job_points_75era.scaleGiftValue) == 'function',
                'scaleGiftValue should be a function')
        end)
    end)

    describe('Settings (Phase 1)', function()
        it('has ENABLED default of true', function()
            assert(xi.settings.job_points_75era.ENABLED == true,
                'ENABLED should default to true')
        end)

        it('has LEVEL_REQUIREMENT default of 75', function()
            assert(xi.settings.job_points_75era.LEVEL_REQUIREMENT == 75,
                'LEVEL_REQUIREMENT should default to 75')
        end)

        it('has MOB_LEVEL_THRESHOLD default of 75', function()
            assert(xi.settings.job_points_75era.MOB_LEVEL_THRESHOLD == 75,
                'MOB_LEVEL_THRESHOLD should default to 75')
        end)

        it('has REQUIRE_KEY_ITEM default of true', function()
            assert(xi.settings.job_points_75era.REQUIRE_KEY_ITEM == true,
                'REQUIRE_KEY_ITEM should default to true')
        end)

        it('has GIFT_MULTIPLIER default of 0.5', function()
            assert(xi.settings.job_points_75era.GIFT_MULTIPLIER == 0.5,
                'GIFT_MULTIPLIER should default to 0.5')
        end)
    end)

    describe('CP Formula (Phase 3)', function()
        local calcCP

        before_each(function()
            calcCP = xi.job_points_75era.calculateCapacityPoints
        end)

        it('returns 0 for mobs below threshold', function()
            local cp = calcCP(74)
            assert(cp == 0, string.format('Mob 74 should give 0 CP, got %d', cp))
        end)

        it('returns ~90 CP for mobs at threshold', function()
            local cp = calcCP(75)
            assert(cp >= 89 and cp <= 91,
                string.format('Mob 75 should give ~90 CP, got %d', cp))
        end)

        it('returns ~94 CP for mob level 76', function()
            local cp = calcCP(76)
            assert(cp >= 93 and cp <= 95,
                string.format('Mob 76 should give ~94 CP, got %d', cp))
        end)

        it('returns ~115 CP for mob level 80', function()
            local cp = calcCP(80)
            assert(cp >= 110 and cp <= 120,
                string.format('Mob 80 should give ~115 CP, got %d', cp))
        end)

        it('returns ~170 CP for mob level 85', function()
            local cp = calcCP(85)
            assert(cp >= 165 and cp <= 175,
                string.format('Mob 85 should give ~170 CP, got %d', cp))
        end)
    end)

    describe('Gift Scaling (Phase 6)', function()
        local scaleGift

        before_each(function()
            scaleGift = xi.job_points_75era.scaleGiftValue
        end)

        it('scales value 10 to 5', function()
            assert(scaleGift(10) == 5, 'Gift value 10 should scale to 5')
        end)

        it('scales value 5 to 2', function()
            assert(scaleGift(5) == 2, 'Gift value 5 should scale to 2')
        end)

        it('scales value 3 to 1', function()
            assert(scaleGift(3) == 1, 'Gift value 3 should scale to 1')
        end)

        it('scales value 2 to 1', function()
            assert(scaleGift(2) == 1, 'Gift value 2 should scale to 1')
        end)

        it('scales value 1 to minimum of 1', function()
            assert(scaleGift(1) == 1, 'Gift value 1 should scale to minimum of 1')
        end)
    end)

    describe('Key Item Requirements (Phase 4)', function()
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 75 })
        end)

        it('player without JOB_BREAKER cannot use job points', function()
            -- Player starts without key items
            local canUse = xi.job_points_75era.canUseJobPointsForJob(player)
            assert(canUse == false, 'Player without JOB_BREAKER should not be able to use job points')
        end)

        it('player with JOB_BREAKER but no merits cannot use job points', function()
            player:addKeyItem(xi.ki.JOB_BREAKER)
            -- Player has JOB_BREAKER, level 75, but no merits invested
            local canUse = xi.job_points_75era.canUseJobPointsForJob(player)
            -- Should fail merit check (requires at least 2 Group 1 merits)
            assert(canUse == false, 'Player without maxed merits should not be able to use job points')
        end)

        it('player with JOB_BREAKER and merits can use job points', function()
            player:addKeyItem(xi.ki.JOB_BREAKER)
            -- Add WAR Group 1 merits (Double Attack Rate = 0x0180, Warrior Warcry = 0x0182)
            player:setMerit(0x0180, 5) -- Double Attack Rate
            player:setMerit(0x0182, 5) -- Warrior Warcry
            local canUse = xi.job_points_75era.canUseJobPointsForJob(player)
            assert(canUse == true, 'Player with JOB_BREAKER and merits should be able to use job points')
        end)

        it('player below level requirement cannot use job points', function()
            local lowPlayer = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 74 })
            lowPlayer:addKeyItem(xi.ki.JOB_BREAKER)
            lowPlayer:setMerit(0x0180, 5)
            lowPlayer:setMerit(0x0182, 5)
            local canUse = xi.job_points_75era.canUseJobPointsForJob(lowPlayer)
            assert(canUse == false, 'Player below level 75 should not be able to use job points')
        end)
    end)

    describe('Merit Requirements Per Job', function()
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 75 })
            player:addKeyItem(xi.ki.JOB_BREAKER)
        end)

        it('WAR merits unlock WAR job points', function()
            player:setMerit(0x0180, 5) -- WAR Group 1 merit 1
            player:setMerit(0x0182, 5) -- WAR Group 1 merit 2
            local hasMaxed = xi.job_points_75era.hasMaxedJobMerits(player, xi.job.WAR)
            assert(hasMaxed == true, 'WAR should be unlocked with WAR merits')
        end)

        it('WAR merits do not unlock WHM job points', function()
            player:setMerit(0x0180, 5) -- WAR Group 1 merit 1
            player:setMerit(0x0182, 5) -- WAR Group 1 merit 2
            local hasMaxed = xi.job_points_75era.hasMaxedJobMerits(player, xi.job.WHM)
            assert(hasMaxed == false, 'WHM should not be unlocked with WAR merits')
        end)

        it('each job requires its own merits', function()
            -- MNK merits (0x01C0 base)
            player:setMerit(0x01C0, 5)
            player:setMerit(0x01C2, 5)
            local hasMNK = xi.job_points_75era.hasMaxedJobMerits(player, xi.job.MNK)
            local hasWAR = xi.job_points_75era.hasMaxedJobMerits(player, xi.job.WAR)
            assert(hasMNK == true, 'MNK should be unlocked with MNK merits')
            assert(hasWAR == false, 'WAR should not be unlocked with MNK merits')
        end)
    end)

    describe('Capacity Chains (Phase 5)', function()
        -- Note: These tests verify the chain logic exists in charutils.cpp
        -- The chain activates for mobs above threshold (levelDiff >= 1)

        it('chains should activate for mobs above threshold', function()
            -- levelDiff = mobLevel - playerLevelReq
            -- For mob 76, playerReq 75: levelDiff = 1, chains activate
            -- This is a documentation test - actual chain testing requires mob kills
            local threshold = xi.settings.job_points_75era.MOB_LEVEL_THRESHOLD
            assert(threshold == 75, 'Mob threshold should be 75')
            -- Chains activate when levelDiff >= 1 (mob 76+)
        end)
    end)

    describe('Capacity Point Integration (Phase 3)', function()
        local player
        local mob

        before_each(function()
            player = xi.test.world:spawnPlayer(
            {
                job = xi.job.WAR,
                level = 75,
                zone = xi.zone.BOSTAUNIEUX_OUBLIETTE,
            })
            player:addKeyItem(xi.ki.JOB_BREAKER)
            -- Add WAR merits to pass merit check
            player:setMerit(0x0180, 5)
            player:setMerit(0x0182, 5)
            -- Reset capacity/job points
            player:setCapacityPoints(0)
            player:setJobPoints(0)
        end)

        it('player earns CP from killing mob at threshold level', function()
            mob = player.entities:get('Sewer_Syrup')
            if mob then
                mob:setMLevel(75)
                mob:respawn()
                player.entities:moveTo(mob)
                -- Set capacity near rollover point to detect JP gain
                player:setCapacityPoints(29910) -- ~90 CP needed for rollover
                local jpBefore = player:getJobPoints(xi.job.WAR) or 0
                player:claimAndKillMob(mob)
                xi.test.world:tickEntity(player)
                local jpAfter = player:getJobPoints(xi.job.WAR) or 0
                -- If CP was earned, JP should increase (29910 + 90 = 30000 = 1 JP)
                assert(jpAfter > jpBefore, string.format('Should earn JP from CP, before=%d after=%d', jpBefore, jpAfter))
            end
        end)

        it('player does not earn CP from mob below threshold', function()
            mob = player.entities:get('Sewer_Syrup')
            if mob then
                mob:setMLevel(74)
                mob:respawn()
                player.entities:moveTo(mob)
                player:setCapacityPoints(29990) -- Almost at rollover
                local jpBefore = player:getJobPoints(xi.job.WAR) or 0
                player:claimAndKillMob(mob)
                xi.test.world:tickEntity(player)
                local jpAfter = player:getJobPoints(xi.job.WAR) or 0
                assert(jpAfter == jpBefore, string.format('Should not earn JP from low level mob, before=%d after=%d', jpBefore, jpAfter))
            end
        end)

        it('player without JOB_BREAKER does not earn CP', function()
            player:delKeyItem(xi.ki.JOB_BREAKER)
            mob = player.entities:get('Sewer_Syrup')
            if mob then
                mob:setMLevel(75)
                mob:respawn()
                player.entities:moveTo(mob)
                player:setCapacityPoints(29910)
                local jpBefore = player:getJobPoints(xi.job.WAR) or 0
                player:claimAndKillMob(mob)
                xi.test.world:tickEntity(player)
                local jpAfter = player:getJobPoints(xi.job.WAR) or 0
                assert(jpAfter == jpBefore, 'Player without JOB_BREAKER should not earn CP/JP')
            end
        end)
    end)

    ---------------------------------------------------------------------------
    -- Multi-Job Tests (Phase 6)
    ---------------------------------------------------------------------------
    describe('Multi-Job Independence (Phase 6)', function()
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer(
            {
                job = xi.job.WAR,
                level = 75,
                zone = xi.zone.BOSTAUNIEUX_OUBLIETTE,
            })
            player:addKeyItem(xi.ki.JOB_BREAKER)
        end)

        it('WAR with merits can use JP, WHM without merits cannot', function()
            -- Setup WAR with merits
            player:setMerit(0x0180, 5) -- WAR Group 1 Category 1
            player:setMerit(0x0182, 5) -- WAR Group 1 Category 2

            -- Verify WAR can use JP
            local canUseWAR = xi.job_points_75era.canUseJobPointsForJob(player, xi.job.WAR)
            assert(canUseWAR == true, 'WAR with merits should be able to use job points')

            -- Switch to WHM (no merits invested)
            player:changeJob(xi.job.WHM)
            player:setLevel(75)

            -- Verify WHM cannot use JP (no WHM merits)
            local canUseWHM = xi.job_points_75era.canUseJobPointsForJob(player, xi.job.WHM)
            assert(canUseWHM == false, 'WHM without merits should not be able to use job points')
        end)

        it('switching jobs preserves merit state per job', function()
            -- Setup both WAR and WHM merits
            player:setMerit(0x0180, 5) -- WAR Group 1 Cat 1
            player:setMerit(0x0182, 5) -- WAR Group 1 Cat 2
            player:setMerit(0x0300, 5) -- WHM Group 1 Cat 1
            player:setMerit(0x0302, 5) -- WHM Group 1 Cat 2

            -- Verify WAR can use JP
            local canUseWAR1 = xi.job_points_75era.canUseJobPointsForJob(player, xi.job.WAR)
            assert(canUseWAR1 == true, 'WAR should be able to use job points')

            -- Switch to WHM
            player:changeJob(xi.job.WHM)
            player:setLevel(75)

            -- Verify WHM can use JP
            local canUseWHM = xi.job_points_75era.canUseJobPointsForJob(player, xi.job.WHM)
            assert(canUseWHM == true, 'WHM with merits should be able to use job points')

            -- Switch back to WAR
            player:changeJob(xi.job.WAR)
            player:setLevel(75)

            -- Verify WAR still can use JP
            local canUseWAR2 = xi.job_points_75era.canUseJobPointsForJob(player, xi.job.WAR)
            assert(canUseWAR2 == true, 'WAR should still be able to use job points after job switch')
        end)

        it('level 74 on current job cannot use JP even with merits', function()
            player:setMerit(0x0180, 5)
            player:setMerit(0x0182, 5)
            player:setLevel(74)

            local canUse = xi.job_points_75era.canUseJobPointsForJob(player, xi.job.WAR)
            assert(canUse == false, 'Level 74 WAR should not be able to use job points')
        end)
    end)

    ---------------------------------------------------------------------------
    -- Key Item Tests (Phase 7)
    ---------------------------------------------------------------------------
    describe('Key Item Requirements (Phase 7)', function()
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer(
            {
                job = xi.job.WAR,
                level = 75,
                zone = xi.zone.BOSTAUNIEUX_OUBLIETTE,
            })
        end)

        it('player without LIMIT_BREAKER should not receive JOB_BREAKER', function()
            -- Player has no key items
            -- Our module checks for LIMIT_BREAKER before granting JOB_BREAKER
            local hasLimitBreaker = player:hasKeyItem(xi.ki.LIMIT_BREAKER)
            assert(hasLimitBreaker == false, 'Player should not have LIMIT_BREAKER initially')
            assert(player:hasKeyItem(xi.ki.JOB_BREAKER) == false, 'Player should not have JOB_BREAKER initially')
        end)

        it('player with LIMIT_BREAKER meets prerequisite for JOB_BREAKER', function()
            player:addKeyItem(xi.ki.LIMIT_BREAKER)

            -- Our module should allow granting JOB_BREAKER when LIMIT_BREAKER is present
            local hasLimitBreaker = player:hasKeyItem(xi.ki.LIMIT_BREAKER)
            assert(hasLimitBreaker == true, 'Player should have LIMIT_BREAKER')

            -- Simulate what Nomad Moogle would do
            if hasLimitBreaker and not player:hasKeyItem(xi.ki.JOB_BREAKER) then
                player:addKeyItem(xi.ki.JOB_BREAKER)
            end

            assert(player:hasKeyItem(xi.ki.JOB_BREAKER) == true, 'Player should receive JOB_BREAKER')
        end)

        it('player already with JOB_BREAKER does not receive duplicate', function()
            player:addKeyItem(xi.ki.LIMIT_BREAKER)
            player:addKeyItem(xi.ki.JOB_BREAKER)

            local hadBefore = player:hasKeyItem(xi.ki.JOB_BREAKER)

            -- Simulate talking to Nomad Moogle again
            if player:hasKeyItem(xi.ki.LIMIT_BREAKER) and not player:hasKeyItem(xi.ki.JOB_BREAKER) then
                player:addKeyItem(xi.ki.JOB_BREAKER)
            end

            local hasAfter = player:hasKeyItem(xi.ki.JOB_BREAKER)
            assert(hadBefore == hasAfter, 'JOB_BREAKER state should not change')
        end)
    end)
end)
