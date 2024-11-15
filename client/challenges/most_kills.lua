local killCount = 0

function StartMostKillsChallenge()
    killCount = 0
    inChallenge = true

    local _, startingKillCount = StatGetInt(`MP0_KILLS`, -1)

    startMissionScreen("Most Kills Challenge", "Get the most kills")

    Citizen.CreateThread(function()
        while inChallenge do
            local _, currentKillCount = StatGetInt(`MP0_KILLS`, -1)
            if currentKillCount - startingKillCount > killCount and isParticipating then
                killCount = currentKillCount - startingKillCount
            end
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while inChallenge do
            DrawInstruction("Your objective is to get the most kills")
            TriggerServerEvent("mth-challenges:updateEvent", killCount)
            Citizen.Wait(500)
        end
    end)
end

function EndMostKillsChallenge()
    killCount = 0
    inChallenge = false
end

RegisterNetEvent("StartMostKillsChallenge", StartMostKillsChallenge)
RegisterNetEvent("EndMostKillsChallenge", EndMostKillsChallenge)