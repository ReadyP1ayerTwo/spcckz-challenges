local farthestJumpDistance = 0.0
local currentJumpDistance = 0.0
local isJumping = false
local jumpStartCoords = nil

function StartFarthestJumpDistanceChallenge()
    InChallenge = true
    farthestJumpDistance = 0.0
    currentJumpDistance = 0.0
    isJumping = false
    jumpStartCoords = nil

    RemoveAllPedWeapons(PlayerPedId(), true)

    StartMissionScreen("Farthest Jump Distance Challenge", "Find a land vehicle and prepare for the challenge.")

    Citizen.CreateThread(function()
        while InChallenge do
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if vehicle ~= 0 and IsVehicleOnAllWheels(vehicle) == false then
                -- The player is in the air
                if not isJumping then
                    isJumping = true
                    jumpStartCoords = GetEntityCoords(vehicle)
                else
                    -- Calculate current jump distance
                    local currentCoords = GetEntityCoords(vehicle)
                    currentJumpDistance = #(currentCoords - jumpStartCoords)
                end
            else
                -- The player has landed
                if isJumping then
                    isJumping = false
                    if currentJumpDistance > farthestJumpDistance then
                        farthestJumpDistance = currentJumpDistance
                    end
                    currentJumpDistance = 0.0 -- Reset for the next jump
                end
            end
            Citizen.Wait(100) -- Check every 100ms
        end
    end)

    Citizen.CreateThread(function()
        while InChallenge do
            -- Display instructions to the player
            DrawInstruction("Find a land vehicle and achieve the farthest jump distance.")

            -- Report rounded farthest jump distance to the server
            local roundedDistance = math.floor(farthestJumpDistance * 100) / 100 -- Round to 2 decimal places
            TriggerServerEvent("mth-challenges:updateEvent", roundedDistance)

            Citizen.Wait(500) -- Update every 500ms
        end
    end)
end

function EndFarthestJumpDistanceChallenge()
    farthestJumpDistance = 0.0
    currentJumpDistance = 0.0
    isJumping = false
    jumpStartCoords = nil
    InChallenge = false

    SetPlayerWantedLevel(PlayerId(), 0, false)
    SetPlayerWantedLevelNow(PlayerId(), false)
end

-- Registering events to start and end the challenge
RegisterNetEvent("StartFarthestJumpDistanceChallenge", StartFarthestJumpDistanceChallenge)
RegisterNetEvent("EndFarthestJumpDistanceChallenge", EndFarthestJumpDistanceChallenge)
