-----------------------------------
-- func: unlockjobpoints <jobid or all> (player)
-- desc: Unlocks Job Points menu for a specific job or all jobs by setting job_points_spent to 1
--       This makes the job appear as "enabled" in the Job Points menu
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss',
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!unlockjobpoints <jobid or jobname or all> (player)')
end

-- Job name to ID mapping
local jobNames =
{
    war = 1,
    mnk = 2,
    whm = 3,
    blm = 4,
    rdm = 5,
    thf = 6,
    pld = 7,
    drk = 8,
    bst = 9,
    brd = 10,
    rng = 11,
    sam = 12,
    nin = 13,
    drg = 14,
    smn = 15,
    blu = 16,
    cor = 17,
    pup = 18,
    dnc = 19,
    sch = 20,
    geo = 21,
    run = 22,
}

local jobIdToName =
{
    [1] = 'WAR',
    [2] = 'MNK',
    [3] = 'WHM',
    [4] = 'BLM',
    [5] = 'RDM',
    [6] = 'THF',
    [7] = 'PLD',
    [8] = 'DRK',
    [9] = 'BST',
    [10] = 'BRD',
    [11] = 'RNG',
    [12] = 'SAM',
    [13] = 'NIN',
    [14] = 'DRG',
    [15] = 'SMN',
    [16] = 'BLU',
    [17] = 'COR',
    [18] = 'PUP',
    [19] = 'DNC',
    [20] = 'SCH',
    [21] = 'GEO',
    [22] = 'RUN',
}

local function unlockJobForPlayer(player, targ, jobId)
    -- Insert/update job_points_spent to 1 for this job
    -- This makes the client show the job as "enabled" in the Job Points menu
    local query = string.format(
        'INSERT INTO char_job_points (charid, jobid, job_points_spent) VALUES (%d, %d, 1) ' ..
        'ON DUPLICATE KEY UPDATE job_points_spent = GREATEST(job_points_spent, 1)',
        targ:getID(), jobId
    )

    -- Execute the query
    local success = sql:query(query)

    if success then
        player:printToPlayer(string.format('Unlocked Job Points for %s on %s', targ:getName(), jobIdToName[jobId] or jobId))
        return true
    else
        player:printToPlayer(string.format('Failed to unlock Job Points for %s on %s', targ:getName(), jobIdToName[jobId] or jobId))
        return false
    end
end

commandObj.onTrigger = function(player, jobArg, target)
    -- validate job argument
    if jobArg == nil then
        error(player, 'Please specify a job ID, job name, or "all"')
        return
    end

    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    local lowerJob = string.lower(jobArg)

    if lowerJob == 'all' then
        -- Unlock all jobs
        local count = 0
        for jobId = 1, 22 do
            if unlockJobForPlayer(player, targ, jobId) then
                count = count + 1
            end
        end

        player:printToPlayer(string.format('Unlocked Job Points for %d jobs on %s', count, targ:getName()))
        player:printToPlayer('Zone or relog to see changes in the Job Points menu.')
    else
        -- Parse job argument
        local jobId = jobNames[lowerJob]
        if not jobId then
            jobId = tonumber(jobArg)
        end

        if not jobId or jobId < 1 or jobId > 22 then
            error(player, string.format('Invalid job: %s', jobArg))
            return
        end

        unlockJobForPlayer(player, targ, jobId)
        player:printToPlayer('Zone or relog to see changes in the Job Points menu.')
    end
end

return commandObj
