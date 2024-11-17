local underBridgeLocations = {
    {x = 1083.0, y = -231.0, z = 60.0, visited = false},
    {x = 1024.0, y = -325.0, z = 60.0, visited = false},
    {x = 910.0, y = -401.0, z = 43.0, visited = false},
    {x = 721.0, y = -457.0, z = 26.0, visited = false},
    {x = 643.0, y = -579.0, z = 26.0, visited = false},
    {x = 590.0, y = -851.0, z = 26.0, visited = false},
    {x = 590.0, y = -1023.0, z = 16.0, visited = false},
    {x = 582.0, y = -1205.0, z = 24.0, visited = false},
    {x = 608.0, y = -1335.0, z = 16.0, visited = false},
    {x = 640.0, y = -1434.0, z = 16.0, visited = false},
    {x = 671.0, y = -1742.0, z = 20.0, visited = false},
    {x = 651.0, y = -2046.0, z = 16.0, visited = false},
    {x = 603.0, y = -2505.0, z = 9.0, visited = false},
    {x = 673.0, y = -2582.0, z = 4.0, visited = false},
    {x = 728.0, y = -2594.0, z = 10.0, visited = false},
    {x = 794.0, y = -2624.0, z = 27.0, visited = false},
    {x = -2663.0, y = 2594.0, z = 7.5, visited = false},
    {x = -1902.0, y = 4617.0, z = 30.0, visited = false},
    {x = -513.0, y = 4427.0, z = 40.0, visited = false},
    {x = 126.0, y = 3366.0, z = 40.0, visited = false},
    {x = 143.0, y = 3418.0, z = 36.0, visited = false},
    {x = 2822.0, y = 4978.0, z = 40.0, visited = false},
    {x = -162.0, y = 4249.0, z = 40.0, visited = false},
    {x = -408.0, y = 2964.0, z = 20.0, visited = false},
    {x = -181.0, y = 2862.0, z = 38.0, visited = false},
    {x = 2558.0, y = 2201.0, z = 24.0, visited = false},
    {x = 2950.0, y = 803.0, z = 8.0, visited = false},
    {x = 2369.0, y = -409.0, z = 80.0, visited = false},
    {x = 1906.0, y = -755.0, z = 84.0, visited = false},
    {x = -403.0, y = -2333.0, z = 40.0, visited = false},
    {x = -1429.0, y = 2649.0, z = 10.0, visited = false},
    {x = 219.0, y = -2315.0, z = 5.0, visited = false},
    {x = 350.0, y = -2315.0, z = 5.0, visited = false},
    {x = -1848.0, y = -333.0, z = 75.0, visited = false},
    {x = -693.0, y = -608.0, z = 69.0, visited = false},
    {x = -1461.0, y = -582.0, z = 53.0, visited = false},
    {x = -1553.0, y = -546.0, z = 59.0, visited = false},
    {x = 338.0, y = -2758.0, z = 23.0, visited = false},
    {x = 1985.0, y = 6201.0, z = 53.0, visited = false},
    {x = -713.0, y = -1538.0, z = 13.0, visited = false},
    {x = -659.0, y = -1518.0, z = 13.0, visited = false},
    {x = -620.0, y = -1502.0, z = 16.0, visited = false},
    {x = -445.0, y = -1575.0, z = 26.0, visited = false},
    {x = -373.0, y = -1680.0, z = 19.0, visited = false},
    {x = -212.0, y = -1805.0, z = 29.0, visited = false},
    {x = 47.0, y = -2040.0, z = 18.0, visited = false},
    {x = -3080.0, y = 766.0, z = 25.0, visited = false},
    {x = -1478.0, y = 2400.0, z = 20.0, visited = false},
    {x = 2308.0, y = 1124.0, z = 78.0, visited = false},
    {x = 2349.0, y = 1174.0, z = 79.0, visited = false},
    {x = -1186.0, y = -365.0, z = 46.0, visited = false},
    {x = -916.0, y = -407.0, z = 93.0, visited = false},
    {x = -726.0, y = 235.0, z = 105.0, visited = false},
    {x = -774.0, y = 286.0, z = 112.0, visited = false},
    {x = 271.0, y = 134.0, z = 125.0, visited = false},
    {x = 377.0, y = -28.0, z = 125.0, visited = false},
    {x = 121.0, y = -703.0, z = 150.0, visited = false},
    {x = -204.0, y = -784.0, z = 74.0, visited = false},
    {x = -287.0, y = -774.0, z = 72.0, visited = false},
    {x = -272.0, y = -824.0, z = 71.0, visited = false},
    {x = -230.0, y = -723.0, z = 80.0, visited = false},
    {x = 1822.0, y = 2044.0, z = 62.0, visited = false},
    {x = 2410.0, y = 2907.0, z = 44.0, visited = false},
    {x = 2686.0, y = 4858.0, z = 36.0, visited = false},
    {x = -1046.0, y = 4751.0, z = 244.0, visited = false},
    {x = -213.0, y = -2463.0, z = 38.0, visited = false},
    {x = -597.0, y = -2192.0, z = 38.0, visited = false},
    {x = 1036.0, y = -980.0, z = 41.0, visited = false},
    {x = 980.0, y = -837.0, z = 42.0, visited = false},
    {x = 1208.0, y = -1173.0, z = 38.0, visited = false}
}

local vehicleSpawnLocations = {
    {x = -1158.893, y = -1738.877, z = 4.055, heading = 215.483, model = "buzzard"},
    {x = -1168.874, y = -1746.419, z = 3.998, heading = 124.725, model = "buzzard"},
    {x = -1603.944, y = -2794.439, z = 13.971, heading = 240.045, model = "lazer"},
    {x = -978.337, y = -3349.99, z = 13.944, heading = 58.062, model = "stunt"},
    {x = 449.143, y = -981.273, z = 43.692, heading = 90.059, model = "buzzard"},
    {x = 699.427, y = -491.963, z = 15.881, heading = 176.157, model = "buzzard2"},
    {x = 1264.816, y = 188.245, z = 81.863, heading = 146.089, model = "stunt"},
    {x = 1053.443, y = 3081.934, z = 41.469, heading = 241.713, model = "lazer"},
    {x = 1769.635, y = 3239.461, z = 42.125, heading = 280.808, model = "buzzard"},
    {x = 2208.907, y = 4651.732, z = 31.229, heading = 164.052, model = "dodo"},
    {x = 2131.084, y = 4803.199, z = 41.046, heading = 118.359, model = "stunt"},
    {x = -745.328, y = -1468.634, z = 5.001, heading = 142.71, model = "buzzard"},
    {x = 568.12, y = -739.669, z = 11.996, heading = 174.5, model = "lazer"},
    {x = -1706.891, y = -815.918, z = 9.427, heading = 45.216, model = "stunt"},
    {x = 1491.408, y = -1973.71, z = 70.816, heading = 339.805, model = "stunt"},
    {x = -252.804, y = -2537.156, z = 6.004, heading = 158.885, model = "buzzard"},
    {x = 313.394, y = -1465.316, z = 46.509, heading = 43.926, model = "buzzard"},
    {x = 1175.107, y = 278.744, z = 81.871, heading = 120.01, model = "buzzard"},
    {x = 478.547, y = -3370.131, z = 6.07, heading = 355.228, model = "buzzard"},
    {x = -1268.469, y = -3375.488, z = 13.94, heading = 326.586, model = "lazer"},
    {x = -1253.342, y = -3385.56, z = 13.94, heading = 330.219, model = "lazer"},
    {x = -1052.381, y = -3493.217, z = 14.143, heading = 29.211, model = "buzzard"},
    {x = -1231.069, y = -2879.385, z = 13.945, heading = 148.996, model = "lazer"},
    {x = -1340.997, y = -2218.804, z = 13.945, heading = 146.772, model = "lazer"},
    {x = -981.205, y = -2990.385, z = 13.945, heading = 58.785, model = "stunt"},
    {x = -321.589, y = -2548.515, z = 6.001, heading = 50.188, model = "stunt"},
    {x = 1401.903, y = 2998.903, z = 40.553, heading = 315.416, model = "lazer"},
    {x = 1077.437, y = 3011.685, z = 41.354, heading = 285.25, model = "lazer"},
    {x = 1732.836, y = 3305.026, z = 41.224, heading = 195.137, model = "stunt"}
}
local activeBlips = {}
local spawnedAircraft = {}

function StartFlyingUnderBridgesChallenge()
    InChallenge = true
    ResetBridgeData()
    StatSetInt("mp0_fly_under_bridges", 0, true)

    StartMissionScreen("Flying Under Bridges Challenge", "Find an air vehicle and fly under bridges.")

    Citizen.CreateThread(function()
        NotifyPlayer("Air vehicles have been spotted all around Los Santos! Many ready for take-off at LSIA.")
        SpawnEventVehicles()

        -- Create blips for all bridge locations
        for _, bridge in pairs(underBridgeLocations) do
            local blip = AddBlipForCoord(bridge.x, bridge.y, bridge.z)
            SetBlipSprite(blip, 1)  -- Standard blip icon
            SetBlipColour(blip, 66) -- Yellow color
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Bridge")
            EndTextCommandSetBlipName(blip)
            table.insert(activeBlips, blip)
        end
    end)

    Citizen.CreateThread(function()
        while InChallenge do
            if IsPedInAnyPlane(PlayerPedId()) or IsPedInAnyHeli(PlayerPedId()) then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                local playerPos = GetEntityCoords(vehicle)

                for _, bridge in pairs(underBridgeLocations) do
                    if not bridge.visited then
                        local distSquared = #(vector3(bridge.x, bridge.y, bridge.z) - playerPos) ^ 2

                        if distSquared < 90000 then
                            DrawMarker(28, bridge.x, bridge.y, bridge.z - 1.0, 0, 0, 0, 0, 0, 0, 22.0, 22.0, 1.0, 240, 200, 80, 150, false, true, 2, false, nil, nil, false)
                            DrawMarker(2, bridge.x, bridge.y, bridge.z + 10.0, 0, 0, 0, 0, 0, 0, 11.0, 11.0, 11.0, 93, 182, 229, 110, false, true, 2, false, nil, nil, false)

                            if distSquared < 225 then
                                bridge.visited = true
                                IncrementStat("mp0_fly_under_bridges", 1)

                                RemoveBlipFromBridge(bridge)

                                PlaySoundFrontend(-1, distSquared < 25 and "CHECKPOINT_PERFECT" or "CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", true)
                            end
                        end
                    end
                end
            end
            Citizen.Wait(0)
        end
    end)

    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Fly under bridges to score points. Points will not be awarded twice for the same bridge.")
            TriggerServerEvent("mth-challenges:updateEvent", StatGetInt(`mp0_fly_under_bridges`, -1))
            Citizen.Wait(500)
        end
    end)
end

function EndFlyingUnderBridgesChallenge()
    InChallenge = false
    ClearActiveBlips()

    Citizen.CreateThread(function()
        -- Play warning sounds and self-destruct aircraft
        for _, vehicle in ipairs(spawnedAircraft) do
            if DoesEntityExist(vehicle) then
                Citizen.CreateThread(function()
                    local warningTime = 15000 -- 15 seconds before explosion
                    local startTime = GetGameTimer()

                    while GetGameTimer() - startTime < warningTime do
                        local playerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                        if playerVehicle == vehicle then
                            PlaySoundFrontend(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", true)
                        end
                        Citizen.Wait(2000) -- Repeat sound every 2 seconds
                    end

                    -- Explode and delete the aircraft
                    AddExplosion(GetEntityCoords(vehicle), 2, 1.0, true, false, 1.0)
                    DeleteEntity(vehicle)
                end)
            end
        end
        spawnedAircraft = {} -- Clear spawned aircraft table
    end)
end

function ResetBridgeData()
    for _, bridge in pairs(underBridgeLocations) do
        bridge.visited = false
    end
end

function SpawnEventVehicles()
    for _, loc in pairs(vehicleSpawnLocations) do
        RequestModel(GetHashKey(loc.model))
        while not HasModelLoaded(GetHashKey(loc.model)) do
            Citizen.Wait(0)
        end
        local vehicle = CreateVehicle(GetHashKey(loc.model), loc.x, loc.y, loc.z, loc.heading, true, false)
        SetVehicleOnGroundProperly(vehicle)
        table.insert(spawnedAircraft, vehicle) -- Track the spawned vehicle
    end
end

function RemoveBlipFromBridge(bridge)
    for i, blip in pairs(activeBlips) do
        local blipPos = GetBlipCoords(blip)
        if #(vector3(blipPos.x, blipPos.y, blipPos.z) - vector3(bridge.x, bridge.y, bridge.z)) < 5.0 then
            RemoveBlip(blip)
            table.remove(activeBlips, i)
            break
        end
    end
end

function ClearActiveBlips()
    for _, blip in pairs(activeBlips) do
        RemoveBlip(blip)
    end
    activeBlips = {}
end

function NotifyPlayer(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(true, true)
end

function IncrementStat(stat, value)
    local hash = GetHashKey(stat)
    StatSetInt(hash, StatGetInt(hash, -1) + value, true)
end

RegisterNetEvent("StartFlyingUnderBridgesChallenge", StartFlyingUnderBridgesChallenge)
RegisterNetEvent("EndFlyingUnderBridgesChallenge", EndFlyingUnderBridgesChallenge)
