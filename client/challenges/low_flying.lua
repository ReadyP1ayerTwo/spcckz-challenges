local isActive = false
local isStarted = false
local lowFlyingDistance = 0.0

function StartLowFlyingChallenge()
    isActive = true
    isStarted = false
    lowFlyingDistance = 0.0
    TriggerEvent("chat:addMessage", {args = {"^2Event", "Find an aircraft and prepare for the Low Flying Challenge. Fly low to the ground!"}})
    Citizen.CreateThread(OnTick)
end

function EndLowFlyingChallenge()
    isActive = false
    isStarted = false
    lowFlyingDistance = 0.0
    TriggerEvent("chat:addMessage", {args = {"^1Event", "Low Flying Challenge has ended."}})
end

function OnTick()
    while isActive do
        Citizen.Wait(50)
        if not isStarted then
            DrawSubtitle("Find an aircraft and prepare for the Low Flying Challenge. Fly low to the ground!")
        else
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if IsPedInAnyVehicle(playerPed, false) and IsThisModelAPlane(GetEntityModel(vehicle)) then
                local altitude = GetEntityHeightAboveGround(vehicle)

                if altitude < 50.0 then
                    lowFlyingDistance = lowFlyingDistance + 1.0
                    DrawSubtitle("Fly low and maintain altitude!")
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
RegisterNetEvent("StartLowFlyingChallenge", StartLowFlyingChallenge)
RegisterNetEvent("EndLowFlyingChallenge", EndLowFlyingChallenge)
