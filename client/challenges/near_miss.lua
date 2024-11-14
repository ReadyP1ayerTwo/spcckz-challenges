local isActive = false
local isStarted = false

function StartNumberOfNearMissesChallenge()
    isActive = true
    isStarted = false
    TriggerEvent("chat:addMessage", {args = {"^2Event", "Find a land vehicle and prepare for the Number of Near Misses Challenge."}})
    Citizen.CreateThread(OnTick)
end

function EndNumberOfNearMissesChallenge()
    isActive = false
    isStarted = false
    TriggerEvent("chat:addMessage", {args = {"^1Event", "Number of Near Misses Challenge has ended."}})
end

-- Main tick function to display instructions and update player actions
function OnTick()
    while isActive do
        Citizen.Wait(50)
        if not isStarted then
            DrawSubtitle("Find a land vehicle and prepare for the Number of Near Misses Challenge.")
        else
            DrawSubtitle("Perform the most near misses with other vehicles in a land vehicle.")
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
RegisterNetEvent("StartNumberOfNearMissesChallenge", StartNumberOfNearMissesChallenge)
RegisterNetEvent("EndNumberOfNearMissesChallenge", EndNumberOfNearMissesChallenge)
