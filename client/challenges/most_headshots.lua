local headshotsCount = 0

function StartHeadShotsChallenge()
    -- This function is called when the challenge is started.
    -- We want to set the headshot count to 0 if it's not already 0.
    headshotsCount = 0
    InChallenge = true
    -- Initialize the starting headshot count.
    local _, startingHeadshotsCount = StatGetInt(`mp0_headshots`, -1)

    StartMissionScreen("Headshots Challenge", "Get the most headshots")

    Citizen.CreateThread(function()
        while InChallenge do
            local _, currentHeadshotsCount = StatGetInt(`mp0_headshots`, -1)
            if currentHeadshotsCount - startingHeadshotsCount > headshotsCount and IsParticipating then
                headshotsCount = currentHeadshotsCount - startingHeadshotsCount
            end
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Your objective is to get the most headshots")
            TriggerServerEvent("mth-challenges:updateEvent", headshotsCount)
            Citizen.Wait(500)
        end
    end)
end

function EndHeadShotsChallenge()
    headshotsCount = 0
    InChallenge = false
end

RegisterNetEvent("StartHeadShotsChallenge", StartHeadShotsChallenge)
RegisterNetEvent("EndHeadShotsChallenge", EndHeadShotsChallenge)