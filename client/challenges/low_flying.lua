local lowFlyingDistance = 0.0

local function OnTick()
    while InChallenge do
        Citizen.Wait(50)

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, false) and IsThisModelAPlane(GetEntityModel(vehicle)) then
            local altitude = GetEntityHeightAboveGround(vehicle)
            local isAnyWheelTouchingGround = IsEntityInAir(vehicle) == false

            -- Accumulate points only if flying low, at least 5.0 above ground, and no wheels are touching
            if altitude >= 5.0 and altitude < 50.0 and not isAnyWheelTouchingGround then
                lowFlyingDistance = lowFlyingDistance + 5.0
            end
        end
    end
end

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

RegisterNetEvent("StartLowFlyingChallenge", StartLowFlyingChallenge)
RegisterNetEvent("EndLowFlyingChallenge", EndLowFlyingChallenge)
