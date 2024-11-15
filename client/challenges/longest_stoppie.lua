local longestStoppieDistance = 0.0

function StartLongestStoppieChallenge()
    inChallenge = true
    longestStoppieDistance = 0.0
    Citizen.CreateThread(OnTick)
    Citizen.CreateThread(function()
        while inChallenge do
            DrawInstruction("Your objective is to perform the longest stoppie!")
            TriggerServerEvent("mth-challenges:updateEvent", longestStoppieDistance)
            Citizen.Wait(500)
        end
    end)
end

function EndLongestStoppieChallenge()
    inChallenge = false
    longestStoppieDistance = 0.0
end

function OnTick()
    while inChallenge do
        Citizen.Wait(50)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, false) and GetVehicleClass(vehicle) == 8 then
            local isPerformingStoppie = GetEntityPitch(vehicle) < -10.0
            if isPerformingStoppie then
                longestStoppieDistance = longestStoppieDistance + 1.0
            end
        end
    end
end

RegisterNetEvent("StartLongestStoppieChallenge", StartLongestStoppieChallenge)
RegisterNetEvent("EndLongestStoppieChallenge", EndLongestStoppieChallenge)
