local isActive = false
local isStarted = false
local longestStoppieDistance = 0.0

function StartLongestStoppieChallenge()
    isActive = true
    isStarted = false
    longestStoppieDistance = 0.0
    TriggerEvent("chat:addMessage", {args = {"^2Event", "Find a motorcycle and prepare for the Longest Stoppie Challenge. Perform the longest stoppie!"}})
    Citizen.CreateThread(OnTick)
end

function EndLongestStoppieChallenge()
    isActive = false
    isStarted = false
    longestStoppieDistance = 0.0
    TriggerEvent("chat:addMessage", {args = {"^1Event", "Longest Stoppie Challenge has ended."}})
end

function OnTick()
    while isActive do
        Citizen.Wait(50)
        if not isStarted then
            DrawSubtitle("Find a motorcycle and prepare for the Longest Stoppie Challenge. Perform the longest stoppie!")
        else
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if IsPedInAnyVehicle(playerPed, false) and GetEntityModel(vehicle) == GetHashKey("motorcycle") then
                local isPerformingStoppie = GetEntityPitch(vehicle) < -10.0
                if isPerformingStoppie then
                    longestStoppieDistance = longestStoppieDistance + 1.0
                    DrawSubtitle("Perform the longest stoppie!")
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
RegisterNetEvent("StartLongestStoppieChallenge", StartLongestStoppieChallenge)
RegisterNetEvent("EndLongestStoppieChallenge", EndLongestStoppieChallenge)
