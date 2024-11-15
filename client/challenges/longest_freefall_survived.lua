local longestFreefallSurvived = 0.0

function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function StartLongestFreefallSurvivedChallenge()
    InChallenge = true
    -- reset stat to 0
    StatSetFloat(`MP0_LONGEST_SURVIVED_FREEFALL`, 0.0, true)

    StartMissionScreen("Longest Freefall Survived Challenge", "Survive to the longest freefall")

    Citizen.CreateThread(function()
        TriggerServerEvent("mth-challenges:updateEvent", longestFreefallSurvived)

        while InChallenge do
            local _, currentFreefall = StatGetFloat(`MP0_LONGEST_SURVIVED_FREEFALL`, -1)
            currentFreefall = math.round(currentFreefall, 2)
            if currentFreefall > longestFreefallSurvived then
                longestFreefallSurvived = currentFreefall
                TriggerServerEvent("mth-challenges:updateEvent", longestFreefallSurvived)
            end
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Your objective is to survive to the longest freefall")
            Citizen.Wait(500)
        end
    end)
end

function EndLongestFreefallSurvivedChallenge()
    longestFreefallSurvived = 0
    InChallenge = false
end

RegisterNetEvent("StartLongestFreefallSurvivedChallenge", StartLongestFreefallSurvivedChallenge)
RegisterNetEvent("EndLongestFreefallSurvivedChallenge", EndLongestFreefallSurvivedChallenge)