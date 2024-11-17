local vehiclesDestroyed = 0

function StartChaosChallenge()
    InChallenge = true
    vehiclesDestroyed = 0

    StartMissionScreen("Chaos Challenge", "Destroy as many vehicles as possible!")

    -- Thread to track destroyed vehicles
    Citizen.CreateThread(function()
        while InChallenge do
            Citizen.Wait(100)
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local radius = 50.0 -- Check within a 50-meter radius
            local vehicles = GetVehiclesAroundPlayer(coords, radius)

            for _, vehicle in ipairs(vehicles) do
                if DoesEntityExist(vehicle) and IsVehicleDestroyed(vehicle) then
                    -- Check if the vehicle is out of player's view
                    if not IsEntityOnScreen(vehicle) then
                        -- Mark the vehicle as "processed"
                        SetEntityAsMissionEntity(vehicle, true, true)
                        DeleteEntity(vehicle)
                    end

                    -- Increment the destroyed vehicle count
                    vehiclesDestroyed = vehiclesDestroyed + 1
                end
            end
        end
    end)

    -- Thread to display instructions and update the leaderboard
    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Destroy as many vehicles as possible!")
            TriggerServerEvent("mth-challenges:updateEvent", vehiclesDestroyed)
            Citizen.Wait(500)
        end
    end)
end

function EndChaosChallenge()
    InChallenge = false
    vehiclesDestroyed = 0
end

-- Utility function to get nearby vehicles
function GetVehiclesAroundPlayer(coords, radius)
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        local distance = #(coords - GetEntityCoords(vehicle))
        if distance <= radius then
            table.insert(vehicles, vehicle)
        end
    end
    return vehicles
end

-- Utility function to check if a vehicle is destroyed
function IsVehicleDestroyed(vehicle)
    return GetEntityHealth(vehicle) <= 0
end

-- Utility function for vehicle enumeration
function EnumerateVehicles()
    local handle, entity = FindFirstVehicle()
    if not handle or not entity then return function() return nil end end

    local iter = {handle = handle, entity = entity}
    return function()
        local nextEntity = iter.entity
        if nextEntity then
            local success
            success, iter.entity = FindNextVehicle(iter.handle)
            if not success then
                EndFindVehicle(iter.handle)
                return nil
            end
        end
        return nextEntity
    end
end

RegisterNetEvent("StartChaosChallenge", StartChaosChallenge)
RegisterNetEvent("EndChaosChallenge", EndChaosChallenge)
