local longestWheelieDistance = 0.0

local function OnTick()
    while InChallenge do
        Citizen.Wait(50)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, false) and GetVehicleClass(vehicle) == 8 then
            local isPerformingWheelie = GetEntityPitch(vehicle) > 10.0
            if isPerformingWheelie then
                longestWheelieDistance = longestWheelieDistance + 1.0
            end
        end
    end
end

function StartLongestWheelieChallenge()
    InChallenge = true
    longestWheelieDistance = 0.0
    StartMissionScreen("Longest Wheelie Challenge", "Perform the longest wheelie!")
    Citizen.CreateThread(OnTick)
    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Your objective is to perform the longest wheelie!")
            TriggerServerEvent("mth-challenges:updateEvent", longestWheelieDistance)
            Citizen.Wait(500)
        end
    end)
end

function EndLongestWheelieChallenge()
    InChallenge = false
    longestWheelieDistance = 0.0
end

RegisterNetEvent("StartLongestWheelieChallenge", StartLongestWheelieChallenge)
RegisterNetEvent("EndLongestWheelieChallenge", EndLongestWheelieChallenge)
