local lowFlyingDistance = 0.0

function StartLowFlyingChallenge()
    InChallenge = true
    lowFlyingDistance = 0.0

    StartMissionScreen("Low Flying Challenge", "Find an aircraft and fly low to the ground!")

    Citizen.CreateThread(OnTick)
    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Your objective is to fly low and maintain altitude!")
            TriggerServerEvent("mth-challenges:updateEvent", lowFlyingDistance)
            Citizen.Wait(500)
        end
    end)
end

function EndLowFlyingChallenge()
    InChallenge = false
    lowFlyingDistance = 0.0
end

function OnTick()
    while InChallenge do
        Citizen.Wait(50)

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, false) and IsThisModelAPlane(GetEntityModel(vehicle)) then
            local altitude = GetEntityHeightAboveGround(vehicle)

            if altitude < 50.0 then
                lowFlyingDistance = lowFlyingDistance + 1.0
            end
        end
    end
end

RegisterNetEvent("StartLowFlyingChallenge", StartLowFlyingChallenge)
RegisterNetEvent("EndLowFlyingChallenge", EndLowFlyingChallenge)
