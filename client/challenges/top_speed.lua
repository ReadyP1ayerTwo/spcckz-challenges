local fastestSpeedInCar = 0.0

function StartFastestSpeedInCarChallenge()
    InChallenge = true
    fastestSpeedInCar = 0.0

    StartMissionScreen("Fastest Speed in Car Challenge", "Acquire a road vehicle and achieve the highest speed.")

    -- Thread to track top speed
    Citizen.CreateThread(function()
        while InChallenge do
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                local vehicleClass = GetVehicleClass(vehicle)
                -- Check for road vehicles (e.g., Class 0: Compacts, Class 1: Sedans, etc.)
                if vehicleClass >= 0 and vehicleClass <= 7 then
                    local currentSpeed = GetEntitySpeed(vehicle) * 3.6 -- Convert from m/s to km/h
                    currentSpeed = math.floor(currentSpeed + 0.5) -- Round to the nearest whole number
                    if currentSpeed > fastestSpeedInCar then
                        fastestSpeedInCar = currentSpeed
                    end
                end
            end
            Citizen.Wait(500) -- Update frequency for smoother experience
        end
    end)

    -- Thread to display instructions and send data to the scoreboard
    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Achieve the highest speed in a road vehicle.")
            TriggerServerEvent("mth-challenges:updateEvent", math.floor(fastestSpeedInCar + 0.5)) -- Send rounded value to the scoreboard
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
