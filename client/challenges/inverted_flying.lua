local isActive = false
local isStarted = false
local invertedFlyingDistance = 0.0

function StartInvertedFlyingChallenge()
    isActive = true
    isStarted = false
    invertedFlyingDistance = 0.0
    TriggerEvent("chat:addMessage", {args = {"^2Event", "Find an aircraft and prepare for the Inverted Flying Challenge. Fly inverted!"}})
    Citizen.CreateThread(OnTick)
end

function EndInvertedFlyingChallenge()
    isActive = false
    isStarted = false
    invertedFlyingDistance = 0.0
    TriggerEvent("chat:addMessage", {args = {"^1Event", "Inverted Flying Challenge has ended."}})
end

function OnTick()
    while isActive do
        Citizen.Wait(50)
        if not isStarted then
            DrawSubtitle("Find an aircraft and prepare for the Inverted Flying Challenge. Fly inverted!")
        else
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if IsPedInAnyVehicle(playerPed, false) and IsThisModelAPlane(GetEntityModel(vehicle)) then
                local altitude = GetEntityHeightAboveGround(vehicle)
                local roll = GetEntityRoll(vehicle)
                local isUpsideDown = roll > 90.0 or roll < -90.0

                if altitude < 100.0 and isUpsideDown then
                    invertedFlyingDistance = invertedFlyingDistance + 1.0
                    DrawSubtitle("Fly inverted and stay low!")
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
RegisterNetEvent("StartInvertedFlyingChallenge", StartInvertedFlyingChallenge)
RegisterNetEvent("EndInvertedFlyingChallenge", EndInvertedFlyingChallenge)
