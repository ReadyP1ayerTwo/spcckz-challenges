local fastestSpeedInCar = 0.0

function StartFastestSpeedInCarChallenge()
    inChallenge = true
    fastestSpeedInCar = 0.0
    FirstStartedTick = true

    -- Display the mission start screen
    startMissionScreen("Fastest Speed in Car Challenge", "Acquire a road vehicle and achieve the highest speed.")
    Wait(1000)
    while inScaleform do
        Wait(100)
    end
    startScoreboard()

    -- Thread to update player's speed in real-time and send it to the server
    Citizen.CreateThread(function()
        TriggerServerEvent("mth-challenges:updateEvent", fastestSpeedInCar)

        while inChallenge do
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if GetVehicleClass(vehicle) == 0 or GetVehicleClass(vehicle) == 1 then  -- Class 0: Compacts, Class 1: Sedans, etc.
                    local currentSpeed = GetEntitySpeed(vehicle) * 3.6  -- Convert from m/s to km/h
                    currentSpeed = math.round(currentSpeed, 2)
                    if currentSpeed > fastestSpeedInCar and isParticipating then
                        fastestSpeedInCar = currentSpeed
                        TriggerServerEvent("mth-challenges:updateEvent", fastestSpeedInCar)
                    end
                end
            end
            Citizen.Wait(1000)
        end
    end)

    -- Thread to display challenge instructions during the event
    Citizen.CreateThread(function()
        while inChallenge do
            DrawInstruction("Achieve the highest speed in a road vehicle.")
            Citizen.Wait(500)
        end
    end)
end

function EndFastestSpeedInCarChallenge()
    fastestSpeedInCar = 0.0
    inChallenge = false
end

-- Registering events to start and end the challenge
RegisterNetEvent("StartFastestSpeedInCarChallenge", StartFastestSpeedInCarChallenge)
RegisterNetEvent("EndFastestSpeedInCarChallenge", EndFastestSpeedInCarChallenge)
