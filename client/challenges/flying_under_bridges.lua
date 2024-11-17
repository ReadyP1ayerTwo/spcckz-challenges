-- Player's score variable
local playerScore = 0

-- Define zones with bottom-left and top-right corners for each case
local underBridgeZones = {
    {bl = vector3(1063.774, -248.593, 56.13), tr = vector3(1093.589, -214.848, 66.68)}, -- Case 0
    {bl = vector3(1007.983, -337.421, 48.45), tr = vector3(1044.182, -307.738, 64.81)}, -- Case 1
    {bl = vector3(910.379, -420.516, 35.38), tr = vector3(916.599, -383.883, 47.54)}, -- Case 2
    {bl = vector3(696.594, -480.737, 19.07), tr = vector3(757.719, -420.211, 37.03)}, -- Case 3
    {bl = vector3(599.810, -610.536, 13.85), tr = vector3(680.368, -528.306, 33.41)}, -- Case 4
    {bl = vector3(526.861, -859.388, 12.37), tr = vector3(644.250, -845.252, 36.33)}, -- Case 5
    {bl = vector3(539.650, -1029.123, 10.62), tr = vector3(634.972, -1011.640, 35.96)}, -- Case 6
    {bl = vector3(521.938, -1228.966, 10.45), tr = vector3(645.722, -1191.215, 39.61)}, -- Case 7
    {bl = vector3(568.170, -1378.644, 9.01), tr = vector3(642.122, -1295.730, 20.36)}, -- Case 8
    {bl = vector3(598.933, -1444.710, 9.07), tr = vector3(686.568, -1429.872, 25.69)}, -- Case 9
    {bl = vector3(614.218, -1748.646, 9.36), tr = vector3(718.762, -1725.897, 27.55)}, -- Case 10
    {bl = vector3(607.594, -2063.225, 0.01), tr = vector3(694.316, -2040.014, 26.92)}, -- Case 11
    {bl = vector3(570.181, -2522.975, 0.47), tr = vector3(642.667, -2494.551, 11.79)}, -- Case 12
    {bl = vector3(645.886, -2601.972, 0.35), tr = vector3(691.824, -2558.219, 9.90)}, -- Case 13
    {bl = vector3(720.752, -2619.770, 0.26), tr = vector3(735.765, -2561.935, 15.79)}, -- Case 14
    {bl = vector3(704.493, -2647.696, 0.00), tr = vector3(893.258, -2603.120, 45.00)}, -- Case 15
    {bl = vector3(-2687.606, 2491.960, 2.04), tr = vector3(-2617.765, 2846.875, 14.16)}, -- Case 16
    {bl = vector3(-1995.668, 4521.799, 0.00), tr = vector3(-1809.903, 4708.395, 53.51)}, -- Case 17
    {bl = vector3(-526.027, 4335.725, 0.00), tr = vector3(-505.571, 4476.346, 86.71)}, -- Case 18
    {bl = vector3(95.572, 3380.091, 30.43), tr = vector3(152.680, 3384.489, 45.45)}, -- Case 19
    {bl = vector3(126.133, 3415.391, 30.03), tr = vector3(151.870, 3425.417, 38.06)}, -- Case 20
    {bl = vector3(2814.216, 4964.185, 34.11), tr = vector3(2830.972, 4992.298, 51.29)}, -- Case 21
    {bl = vector3(-193.196, 4222.076, 31.05), tr = vector3(-151.576, 4264.417, 43.95)}, -- Case 22
    {bl = vector3(-425.028, 2959.278, 14.85), tr = vector3(-396.230, 2967.861, 24.38)}, -- Case 23
    {bl = vector3(-170.151, 2863.838, 29.99), tr = vector3(-192.013, 2871.603, 44.03)}, -- Case 24
    {bl = vector3(2539.185, 2169.401, 18.33), tr = vector3(2578.079, 2231.402, 27.26)}, -- Case 25
    {bl = vector3(2933.189, 786.782, 0.54), tr = vector3(2966.123, 815.721, 12.98)}, -- Case 26
    {bl = vector3(2324.752, -459.665, 70.25), tr = vector3(2407.409, -361.219, 91.78)}, -- Case 27
    {bl = vector3(1850.364, -765.181, 80.32), tr = vector3(1943.429, -753.251, 93.03)}, -- Case 28
    {bl = vector3(-672.221, -2493.724, -0.34), tr = vector3(-146.028, -2138.094, 54.72)}, -- Case 29
    {bl = vector3(-1483.000, 2600.769, -10.00), tr = vector3(-1378.503, 2696.688, 15.61)}, -- Case 30
    {bl = vector3(216.959, -2343.487, 0.04), tr = vector3(222.685, -2295.445, 7.42)}, -- Case 31
    {bl = vector3(346.462, -2390.258, 0.16), tr = vector3(359.609, -2244.468, 7.85)}, -- Case 32
    {bl = vector3(-1860.270, -339.223, 56.16), tr = vector3(-1837.271, -322.636, 96.12)}, -- Case 33
    {bl = vector3(-706.662, -618.366, 30.48), tr = vector3(-680.264, -600.752, 69.28)}, -- Case 34
    {bl = vector3(-1474.903, -591.122, 67.08), tr = vector3(-1457.173, -573.452, 29.44)}, -- Case 35
    {bl = vector3(-1564.616, -555.868, 32.86), tr = vector3(-1544.958, -537.147, 72.44)}, -- Case 36
    {bl = vector3(333.211, -2791.609, 20.24), tr = vector3(343.113, -2727.236, 41.99)}, -- Case 37
    {bl = vector3(1928.071, 6167.398, 43.37), tr = vector3(2039.882, 6235.634, 55.46)}, -- Case 38
    {bl = vector3(-736.431, -1590.921, 10.81), tr = vector3(-700.020, -1516.350, -0.34)}, -- Case 39
    {bl = vector3(-686.378, -1548.553, 9.19), tr = vector3(-645.995, -1500.219, -2.41)}, -- Case 40
    {bl = vector3(-624.234, -1537.045, 12.60), tr = vector3(-619.739, -1472.937, -0.24)}, -- Case 41
    {bl = vector3(-492.506, -1636.095, 24.33), tr = vector3(-398.765, -1487.452, 0.00)}, -- Case 42
    {bl = vector3(-378.152, -1705.660, 12.47), tr = vector3(-348.959, -1654.411, 0.19)}, -- Case 43
    {bl = vector3(-243.444, -1822.094, 25.87), tr = vector3(-175.510, -1780.645, -0.51)}, -- Case 44
    {bl = vector3(17.908, -2046.159, 12.63), tr = vector3(84.555, -2034.184, 0.05)}, -- Case 45
    {bl = vector3(-3092.175, 754.916, 18.67), tr = vector3(-3064.973, 780.168, 29.20)}, -- Case 46
    {bl = vector3(-1489.422, 2400.668, 2.60), tr = vector3(-1468.889, 2406.815, 21.77)}, -- Case 47
    {bl = vector3(2297.846, 1096.031, 58.84), tr = vector3(2334.453, 1136.131, 76.31)}, -- Case 48
    {bl = vector3(2320.895, 1150.776, 58.83), tr = vector3(2379.442, 1212.366, 72.83)}, -- Case 49
    {bl = vector3(-1178.385, -357.836, 35.36), tr = vector3(-1198.064, -355.255, 56.53)}, -- Case 50
    {bl = vector3(-921.385, -429.229, 36.70), tr = vector3(-912.432, -384.940, 137.08)}, -- Case 51
    {bl = vector3(-740.256, 201.004, 80.96), tr = vector3(-726.643, 253.068, 132.33)}, -- Case 52
    {bl = vector3(-778.342, 253.068, 84.27), tr = vector3(-771.207, 313.115, 137.42)}, -- Case 53
    {bl = vector3(259.221, 128.138, 100.82), tr = vector3(281.720, 142.968, 136.71)}, -- Case 54
    {bl = vector3(369.962, -36.089, 88.36), tr = vector3(393.548, -23.885, 152.78)}, -- Case 55
    {bl = vector3(124.847, -737.427, 39.35), tr = vector3(131.078, -646.658, 261.85)}, -- Case 56
    {bl = vector3(-225.397, -823.844, 126.08), tr = vector3(-193.224, -758.257, 27.48)}, -- Case 57
    {bl = vector3(-305.460, -802.082, 95.48), tr = vector3(-278.135, -745.096, 50.40)}, -- Case 58
    {bl = vector3(-292.303, -835.563, 27.98), tr = vector3(-258.599, -814.022, 95.38)}, -- Case 59
    {bl = vector3(-253.772, -730.532, 32.22), tr = vector3(-210.059, -705.663, 110.17)}, -- Case 60
    {bl = vector3(1802.786, 1949.246, 71.74), tr = vector3(1837.906, 2127.283, 52.84)}, -- Case 61
    {bl = vector3(2388.733, 2883.066, 36.22), tr = vector3(2430.333, 2934.867, 46.63)}, -- Case 62
    {bl = vector3(2672.812, 4821.653, 31.13), tr = vector3(2700.056, 4893.380, 42.18)}, -- Case 63
    {bl = vector3(-1053.446, 4737.157, 204.49), tr = vector3(-1037.954, 4767.193, 234.43)}, -- Case 64
    {bl = vector3(1001.145, -987.114, 28.88), tr = vector3(1080.484, -963.744, 42.63)}, -- Case 67
    {bl = vector3(945.549, -847.662, 29.72), tr = vector3(1021.093, -835.978, 43.16)}, -- Case 68
    {bl = vector3(1206.010, -1183.013, 32.43), tr = vector3(1267.189, -1157.063, 47.94)}, -- Case 69}
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
    playerScore = 0 -- Initialize player's score
    InChallenge = true
    ResetBridgeData()
    StatSetInt("mp0_fly_under_bridges", 0, true)

    StartMissionScreen("Flying Under Bridges Challenge", "Fly under bridges with an aircraft or Oppressor Mk2!")

    Citizen.CreateThread(function()
        -- Notify and create blips
        NotifyPlayer("Aircrafts are ready! Check LSIA for available vehicles.")
        SpawnEventVehicles()
        for _, zone in pairs(underBridgeZones) do
            local center = CalculateZoneCenter(zone.bl, zone.tr)
            local blip = AddBlipForCoord(center.x, center.y, center.z)
            SetBlipSprite(blip, 1)
            SetBlipColour(blip, 66)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Bridge")
            EndTextCommandSetBlipName(blip)
            table.insert(activeBlips, blip)
        end
    end)

    Citizen.CreateThread(function()
        while InChallenge do
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if IsPedInAnyPlane(PlayerPedId()) or IsPedInAnyHeli(PlayerPedId()) or IsVehicleModel(vehicle, GetHashKey("oppressor2")) then
                local playerPos = GetEntityCoords(vehicle)

                for _, zone in pairs(underBridgeZones) do
                    if not zone.visited and IsPlayerInZone(playerPos, zone) then
                        zone.visited = true
                        playerScore = playerScore + 1 -- Increment player's score
                        IncrementStat("mp0_fly_under_bridges", 1)

                        RemoveBlipFromZone(zone)
                        PlaySoundFrontend(-1, "CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", true)
                    end
                end
            end
            Citizen.Wait(0)
        end
    end)

    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Fly under bridges to score points. Points will not be awarded twice for the same bridge.")
            TriggerServerEvent("mth-challenges:updateEvent", playerScore) -- Send player's score to the server
            Citizen.Wait(500)
        end
    end)
end

function EndFlyingUnderBridgesChallenge()
    InChallenge = false
    ClearActiveBlips()

    Citizen.CreateThread(function()
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

                    local coords = GetEntityCoords(vehicle)
                    AddExplosion(coords.x, coords.y, coords.z, 2, 1.0, true, false, 1.0)
                    DeleteEntity(vehicle)
                end)
            end
        end
        spawnedAircraft = {} -- Clear spawned aircraft table
    end)
end

function ResetBridgeData()
    for _, zone in pairs(underBridgeZones) do
        zone.visited = false
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

function RemoveBlipFromZone(zone)
    for i, blip in pairs(activeBlips) do
        local blipPos = GetBlipCoords(blip)
        local center = CalculateZoneCenter(zone.bl, zone.tr)
        if #(vector3(blipPos.x, blipPos.y, blipPos.z) - center) < 10.0 then
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

function IsPlayerInZone(pos, zone)
    return pos.x >= zone.bl.x and pos.x <= zone.tr.x and
           pos.y >= zone.bl.y and pos.y <= zone.tr.y and
           pos.z >= zone.bl.z and pos.z <= zone.tr.z
end

function CalculateZoneCenter(bl, tr)
    return vector3((bl.x + tr.x) / 2, (bl.y + tr.y) / 2, (bl.z + tr.z) / 2)
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
