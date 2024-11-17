local Config = {
    MinSpeedForScore = 10.0, -- Minimum speed (m/s) to count distance for scoring
    UpdateInterval = 100,    -- Time (ms) between distance checks
    CrashDetectionInterval = 100, -- Time (ms) to check for crashes
}

local currentScore = 0
local lastCoords = nil

function StartNoCrashChallenge()
    print("No Crash Challenge started!") -- Debug

    InChallenge = true
    currentScore = 0
    lastCoords = nil

    -- Show the mission start screen
    StartMissionScreen("No Crash Challenge", "Drive carefully to rack up distance without crashing!")

    -- Notify players about the challenge
    NotifyPlayer("Drive a land vehicle and accumulate distance. Crashing will reset your score!")

    -- Distance tracking loop
    Citizen.CreateThread(function()
        while InChallenge do
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if IsPedInAnyVehicle(playerPed, false) and GetVehicleClass(vehicle) < 13 then -- Only land vehicles
                local playerCoords = GetEntityCoords(vehicle)
                local playerSpeed = GetEntitySpeed(vehicle)

                if lastCoords and playerSpeed >= Config.MinSpeedForScore then
                    -- Calculate distance traveled and update score
                    local distance = #(playerCoords - lastCoords)
                    currentScore = currentScore + distance
                    lastCoords = playerCoords

                    print("Current distance traveled:", currentScore) -- Debug

                    -- Update server with the current score
                    TriggerServerEvent("mth-challenges:updateEvent", math.floor(currentScore))
                elseif not lastCoords then
                    lastCoords = playerCoords
                end
            else
                lastCoords = nil
            end

            Citizen.Wait(Config.UpdateInterval)
        end
    end)

    -- Crash detection loop
    Citizen.CreateThread(function()
        while InChallenge do
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if IsPedInAnyVehicle(playerPed, false) and HasEntityCollidedWithAnything(vehicle) then
                -- Reset score on collision
                currentScore = 0
                NotifyPlayer("~r~You crashed! Score reset.")
                print("Crash detected. Score reset.") -- Debug
                TriggerServerEvent("mth-challenges:updateEvent", 0) -- Notify server of reset score
            end

            Citizen.Wait(Config.CrashDetectionInterval)
        end
    end)

    -- Server sync loop
    Citizen.CreateThread(function()
        while InChallenge do
            Citizen.Wait(5000) -- Sync every 5 seconds
            TriggerServerEvent("mth-challenges:updateEvent", math.floor(currentScore))
        end
    end)
end

function EndNoCrashChallenge()
    print("No Crash Challenge ended!") -- Debug

    InChallenge = false
    NotifyPlayer("Challenge ended! Your total distance: " .. math.floor(currentScore) .. " meters")
end

-- Utility: Notify player with a message
function NotifyPlayer(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(true, true)
end

-- Debugging the events
RegisterNetEvent("StartNoCrashChallenge")
AddEventHandler("StartNoCrashChallenge", StartNoCrashChallenge)

RegisterNetEvent("EndNoCrashChallenge")
AddEventHandler("EndNoCrashChallenge", EndNoCrashChallenge)
