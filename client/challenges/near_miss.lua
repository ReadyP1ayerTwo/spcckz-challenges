function StartNumberOfNearMissesChallenge()
    inChallenge = true
    TriggerEvent("chat:addMessage", {args = {"^2Event", "Find a land vehicle and prepare for the Number of Near Misses Challenge."}})
    Citizen.CreateThread(OnTick)
end

function EndNumberOfNearMissesChallenge()
    inChallenge = false
end

-- TODO
function OnTick()
    while inChallenge do
        Citizen.Wait(50)
        if not inChallenge then
            DrawInstruction("Find a land vehicle and prepare for the Number of Near Misses Challenge.")
        else
            DrawInstruction("Perform the most near misses with other vehicles in a land vehicle.")
        end
    end
end

-- Event registration for starting and ending the challenge
RegisterNetEvent("StartNumberOfNearMissesChallenge", StartNumberOfNearMissesChallenge)
RegisterNetEvent("EndNumberOfNearMissesChallenge", EndNumberOfNearMissesChallenge)
