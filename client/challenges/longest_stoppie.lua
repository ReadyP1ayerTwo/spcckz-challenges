local longestStoppieDistance = 0.0

local function OnTick()
    while InChallenge do
        Citizen.Wait(50)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, false) and GetVehicleClass(vehicle) == 8 then -- Only motorcycles
            local isPerformingStoppie = GetEntityPitch(vehicle) < -10.0 -- Check if the vehicle is pitching down

            -- Check if front wheel(s) are touching the ground
            local frontLeftWheel = GetEntityBoneIndexByName(vehicle, "wheel_lf")
            local frontRightWheel = GetEntityBoneIndexByName(vehicle, "wheel_rf")
            local frontLeftTouching = IsEntityInAir(vehicle) == false and frontLeftWheel ~= -1
            local frontRightTouching = IsEntityInAir(vehicle) == false and frontRightWheel ~= -1

            if isPerformingStoppie and (frontLeftTouching or frontRightTouching) then
                longestStoppieDistance = longestStoppieDistance + 1.0
            end
        end
    end
end

function StartLongestStoppieChallenge()
    InChallenge = true
    longestStoppieDistance = 0.0
    StartMissionScreen("Longest Stoppie Challenge", "Perform the longest stoppie!")
    Citizen.CreateThread(OnTick)
    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Your objective is to perform the longest stoppie!")
            TriggerServerEvent("mth-challenges:updateEvent", longestStoppieDistance)
            Citizen.Wait(500)
        end
    end)
end

function EndLongestStoppieChallenge()
    InChallenge = false
    longestStoppieDistance = 0.0
end

RegisterNetEvent("StartLongestStoppieChallenge", StartLongestStoppieChallenge)
RegisterNetEvent("EndLongestStoppieChallenge", EndLongestStoppieChallenge)
