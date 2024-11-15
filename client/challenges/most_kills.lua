local killCount = 0

function StartMostKillsChallenge()
    killCount = 0
    InChallenge = true

    local _, startingKillCount = StatGetInt(`MP0_KILLS`, -1)

    StartMissionScreen("Most Kills Challenge", "Get the most kills")

    Citizen.CreateThread(function()
        while InChallenge do
            local _, currentKillCount = StatGetInt(`MP0_KILLS`, -1)
            if currentKillCount - startingKillCount > killCount and IsParticipating then
                killCount = currentKillCount - startingKillCount
            end
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Your objective is to get the most kills")
            TriggerServerEvent("mth-challenges:updateEvent", killCount)
            Citizen.Wait(500)
        end
    end)
end

function EndMostKillsChallenge()
    killCount = 0
    InChallenge = false
end

RegisterNetEvent("StartMostKillsChallenge", StartMostKillsChallenge)
RegisterNetEvent("EndMostKillsChallenge", EndMostKillsChallenge)