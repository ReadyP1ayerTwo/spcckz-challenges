local farthestJumpDistance = 0.0

function StartFarthestJumpDistanceChallenge()
    inChallenge = true
    farthestJumpDistance = 0.0

    -- Remove player weapons at the start of the challenge
    RemoveAllPedWeapons(PlayerPedId(), true)

    -- Display the mission start screen
    startMissionScreen("Farthest Jump Distance Challenge", "Find a land vehicle and prepare for the challenge.")
    Wait(1000)
    while inScaleform do
        Wait(100)
    end
    startScoreboard()

    -- Thread to update the player's progress and send it to the server
    Citizen.CreateThread(function()
        TriggerServerEvent("mth-challenges:updateEvent", farthestJumpDistance)

        while inChallenge do
            local _, currentJumpDistance = StatGetFloat(GetHashKey("MP0_LONGEST_JUMP_DISTANCE"), -1)
            currentJumpDistance = math.round(currentJumpDistance, 2)
            if currentJumpDistance > farthestJumpDistance and isParticipating then
                farthestJumpDistance = currentJumpDistance
                TriggerServerEvent("mth-challenges:updateEvent", farthestJumpDistance)
            end
            Citizen.Wait(1000)
        end
    end)

    -- Thread to display challenge instructions during the event
    Citizen.CreateThread(function()
        while inChallenge do
            DrawInstruction("Find a land vehicle and achieve the farthest jump distance.")
            Citizen.Wait(500)
        end
    end)
end

function EndFarthestJumpDistanceChallenge()
    farthestJumpDistance = 0.0
    inChallenge = false
    -- Reset wanted level after challenge ends
    SetPlayerWantedLevel(PlayerId(), 0, false)
    SetPlayerWantedLevelNow(PlayerId(), false)
end

-- Registering events to start and end the challenge
RegisterNetEvent("StartFarthestJumpDistanceChallenge", StartFarthestJumpDistanceChallenge)
RegisterNetEvent("EndFarthestJumpDistanceChallenge", EndFarthestJumpDistanceChallenge)
