local fastestSpeedInCar = 0.0

function StartFastestSpeedInCarChallenge()
    InChallenge = true
    fastestSpeedInCar = 0.0
    FirstStartedTick = true

    StartMissionScreen("Fastest Speed in Car Challenge", "Acquire a road vehicle and achieve the highest speed.")

    Citizen.CreateThread(function()

        while InChallenge do
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if GetVehicleClass(vehicle) == 0 or GetVehicleClass(vehicle) == 1 then  -- Class 0: Compacts, Class 1: Sedans, etc.
                    local currentSpeed = GetEntitySpeed(vehicle) * 3.6  -- Convert from m/s to km/h
                    currentSpeed = math.round(currentSpeed, 2)
                    if currentSpeed > fastestSpeedInCar and IsParticipating then
                        fastestSpeedInCar = currentSpeed
                    end
                end
            end
            Citizen.Wait(1000)
        end
    end)

    -- Thread to display challenge instructions during the event
    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Achieve the highest speed in a road vehicle.")
            TriggerServerEvent("mth-challenges:updateEvent", fastestSpeedInCar)
            Citizen.Wait(500)
        end
    end)
end

function EndFastestSpeedInCarChallenge()
    fastestSpeedInCar = 0.0
    InChallenge = false
end

RegisterNetEvent("StartFastestSpeedInCarChallenge", StartFastestSpeedInCarChallenge)
RegisterNetEvent("EndFastestSpeedInCarChallenge", EndFastestSpeedInCarChallenge)
