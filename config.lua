-- list of all existing challenges with their functions and countdown

Challenges_list = {
    {
        ["name"] = "most_headshots",
        ["start"] = "StartHeadShotsChallenge",
        ["end"] = "EndHeadShotsChallenge",
        ["countdown"] = 180000
    },
    {
        ["name"] = "most_kills",
        ["start"] = "StartMostKillsChallenge",
        ["end"] = "EndMostKillsChallenge",
        ["countdown"] = 180000
    },
    {
        ["name"] = "longest_freefall_survived",
        ["start"] = "StartLongestFreefallSurvivedChallenge",
        ["end"] = "EndLongestFreefallSurvivedChallenge",
        ["countdown"] = 180000
    },
    {
        ["name"] = "longest_stoppie",
        ["start"] = "StartLongestStoppieChallenge",
        ["end"] = "EndLongestStoppieChallenge",
        ["countdown"] = 180000
    },
    {
        ["name"] = "longest_wheelie",
        ["start"] = "StartLongestWheelieChallenge",
        ["end"] = "EndLongestWheelieChallenge",
        ["countdown"] = 180000
    },
    {
        ["name"] = "inverted_flying",
        ["start"] = "StartInvertedFlyingChallenge",
        ["end"] = "EndInvertedFlyingChallenge",
        ["countdown"] = 180000
    },
    {
        ["name"] = "low_flying",
        ["start"] = "StartLowFlyingChallenge",
        ["end"] = "EndLowFlyingChallenge",
        ["countdown"] = 180000
    },
    {
        ["name"] = "chaos_challenge",
        ["start"] = "StartChaosChallenge",
        ["end"] = "EndChaosChallenge",
        ["countdown"] = 180000
    },
    {
        ["name"] = "farthest_jump",
        ["start"] = "StartFarthestJumpChallenge",
        ["end"] = "EndFarthestJumpChallenge",
        ["countdown"] = 180000
    },
    {
        ["name"] = "flying_under_bridges",
        ["start"] = "StartFlyingUnderBridgesChallenge",
        ["end"] = "EndFlyingUnderBridgesChallenge",
        ["countdown"] = 180000
    },
    -- {
    --     ["name"] = "near_miss",
    --     ["start"] = "StartNearMissChallenge",
    --     ["end"] = "EndNearMissChallenge",
    --     ["countdown"] = 180000
    -- },
    {
        ["name"] = "top_speed",
        ["start"] = "StartTopSpeedChallenge",
        ["end"] = "EndTopSpeedChallenge",
        ["countdown"] = 180000
    },
}

Config = {
    cooldown = 30000, -- time to wait before starting a new challenge when the previous one is over
}
