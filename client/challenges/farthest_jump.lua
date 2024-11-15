local farthestJumpDistance = 0.0

function StartFarthestJumpDistanceChallenge()
    InChallenge = true
    farthestJumpDistance = 0.0

    RemoveAllPedWeapons(PlayerPedId(), true)

    StartMissionScreen("Farthest Jump Distance Challenge", "Find a land vehicle and prepare for the challenge.")

    Citizen.CreateThread(function()

        while InChallenge do
            local _, currentJumpDistance = StatGetFloat(`MP0_LONGEST_JUMP_DISTANCE`, -1)
            currentJumpDistance = math.round(currentJumpDistance, 2)
            if currentJumpDistance > farthestJumpDistance and IsParticipating then
                farthestJumpDistance = currentJumpDistance
            end
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Find a land vehicle and achieve the farthest jump distance.")
            TriggerServerEvent("mth-challenges:updateEvent", farthestJumpDistance)
            Citizen.Wait(500)
        end
    end)
end

function EndFarthestJumpDistanceChallenge()
    farthestJumpDistance = 0.0
    InChallenge = false
    SetPlayerWantedLevel(PlayerId(), 0, false)
    SetPlayerWantedLevelNow(PlayerId(), false)
end

-- Registering events to start and end the challenge
RegisterNetEvent("StartFarthestJumpDistanceChallenge", StartFarthestJumpDistanceChallenge)
RegisterNetEvent("EndFarthestJumpDistanceChallenge", EndFarthestJumpDistanceChallenge)
