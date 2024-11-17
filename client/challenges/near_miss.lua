local Config = {
    NearMissMinSpeed = 32.0, -- Minimum speed (m/s) the player must be traveling to count a near miss
    NearMissDistance = 3.0,  -- Maximum distance (meters) for a near miss to count
    NearMissCooldown = 500,  -- Cooldown time (ms) between near misses
}

local nearMissCount = 0
local visitedVehicles = {} -- Tracks vehicles already near-missed
local lastNearMissTime = 0

function StartNearMissChallenge()
    InChallenge = true
    nearMissCount = 0
    visitedVehicles = {} -- Reset visited vehicles for a new challenge

    -- Show the mission start screen
    StartMissionScreen("Near Miss Challenge", "Perform the most near misses!")

    -- Notify players about the challenge and instructions
    NotifyPlayer("Find a land vehicle and perform near misses with other vehicles to score points!")

    -- Main loop to detect near misses
    Citizen.CreateThread(function()
        while InChallenge do
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if IsPedInAnyVehicle(playerPed, false) and GetVehicleClass(vehicle) < 13 then -- Only land vehicles
                local playerCoords = GetEntityCoords(vehicle)
                local playerSpeed = GetEntitySpeed(vehicle)

                if playerSpeed >= Config.NearMissMinSpeed then
                    local vehicles = GetGamePool("CVehicle")

                    for _, otherVehicle in ipairs(vehicles) do
                        if otherVehicle ~= vehicle and not visitedVehicles[otherVehicle] then
                            local otherCoords = GetEntityCoords(otherVehicle)
                            local dist = #(playerCoords - otherCoords)

                            if dist < Config.NearMissDistance then
                                local currentTime = GetGameTimer()

                                if currentTime - lastNearMissTime > Config.NearMissCooldown then
                                    if not HasEntityCollidedWithAnything(vehicle) then
                                        lastNearMissTime = currentTime
                                        visitedVehicles[otherVehicle] = true
                                        nearMissCount = nearMissCount + 1

                                        -- Play a sound for feedback
                                        PlaySoundFrontend(-1, "CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", true)

                                        -- Update the player's score
                                        TriggerServerEvent("mth-challenges:updateEvent", nearMissCount)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            Citizen.Wait(0)
        end
    end)

    -- Server sync loop
    Citizen.CreateThread(function()
        while InChallenge do
            Citizen.Wait(5000) -- Sync every 5 seconds
            TriggerServerEvent("mth-challenges:updateEvent", nearMissCount)
        end
    end)
end

function EndNearMissChallenge()
    InChallenge = false
    NotifyPlayer("Challenge ended! Your total near misses: " .. nearMissCount)
end

-- Utility: Notify player with a message
function NotifyPlayer(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(true, true)
end

RegisterNetEvent("StartNearMissChallenge", StartNearMissChallenge)
RegisterNetEvent("EndNearMissChallenge", EndNearMissChallenge)
