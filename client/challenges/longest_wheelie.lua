local isActive = false
local isStarted = false
local longestWheelieDistance = 0.0

function StartLongestWheelieChallenge()
    isActive = true
    isStarted = false
    longestWheelieDistance = 0.0
    TriggerEvent("chat:addMessage", {args = {"^2Event", "Find a motorcycle and prepare for the Longest Wheelie Challenge. Perform the longest wheelie!"}})
    Citizen.CreateThread(OnTick)
end

function EndLongestWheelieChallenge()
    isActive = false
    isStarted = false
    longestWheelieDistance = 0.0
    TriggerEvent("chat:addMessage", {args = {"^1Event", "Longest Wheelie Challenge has ended."}})
end

function OnTick()
    while isActive do
        Citizen.Wait(50)
        if not isStarted then
            DrawSubtitle("Find a motorcycle and prepare for the Longest Wheelie Challenge. Perform the longest wheelie!")
        else
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if IsPedInAnyVehicle(playerPed, false) and GetEntityModel(vehicle) == GetHashKey("motorcycle") then
                local isPerformingWheelie = GetEntityPitch(vehicle) > 10.0
                if isPerformingWheelie then
                    longestWheelieDistance = longestWheelieDistance + 1.0
                    DrawSubtitle("Perform the longest wheelie!")
                end
            end
        end
    end
end

-- Function to display subtitles on screen
function DrawSubtitle(text)
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(50, 1)
end

-- Event registration for starting and ending the challenge
RegisterNetEvent("StartLongestWheelieChallenge", StartLongestWheelieChallenge)
RegisterNetEvent("EndLongestWheelieChallenge", EndLongestWheelieChallenge)
