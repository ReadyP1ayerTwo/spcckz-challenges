local invertedFlyingDistance = 0.0

local function OnTick()
    while InChallenge do
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, false) and IsThisModelAPlane(GetEntityModel(vehicle)) then
            local altitude = GetEntityHeightAboveGround(vehicle)
            local roll = GetEntityRoll(vehicle)
            local isUpsideDown = roll > 90.0 or roll < -90.0

            if altitude < 100.0 and isUpsideDown then
                invertedFlyingDistance = invertedFlyingDistance + 1.0
            end
        end
        Citizen.Wait(50)
    end
end

function StartInvertedFlyingChallenge()
    InChallenge = true
    invertedFlyingDistance = 0.0
    StartMissionScreen("Inverted Flying Challenge", "Find an aircraft and fly inverted!")

    Citizen.CreateThread(OnTick)
    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Your objective is to fly inverted for as long as possible")
            TriggerServerEvent("mth-challenges:updateEvent", invertedFlyingDistance)
            Citizen.Wait(500)
        end
    end)
end

function EndInvertedFlyingChallenge()
    invertedFlyingDistance = 0.0
    InChallenge = false
end

-- Event registration for starting and ending the challenge
RegisterNetEvent("StartInvertedFlyingChallenge", StartInvertedFlyingChallenge)
RegisterNetEvent("EndInvertedFlyingChallenge", EndInvertedFlyingChallenge)
