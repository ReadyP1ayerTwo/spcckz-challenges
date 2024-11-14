local isActive = false
local isStarted = false
local npcCarDamage = 0.0

function StartChaosChallenge()
    isActive = true
    isStarted = false
    npcCarDamage = 0.0
    TriggerEvent("chat:addMessage", {args = {"^2Event", "Cause chaos and damage NPC vehicles in the Chaos Challenge!"}})
    Citizen.CreateThread(OnTick)
end

function EndChaosChallenge()
    isActive = false
    isStarted = false
    npcCarDamage = 0.0
    TriggerEvent("chat:addMessage", {args = {"^1Event", "Chaos Challenge has ended."}})
end

function OnTick()
    while isActive do
        Citizen.Wait(50)
        if not isStarted then
            DrawSubtitle("Cause chaos and damage NPC vehicles in the Chaos Challenge!")
        else
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if IsPedInAnyVehicle(playerPed, false) then
                local currentHealth = GetEntityHealth(vehicle)
                local damageDealt = 1000 - currentHealth  -- Assuming 1000 is max health
                npcCarDamage = npcCarDamage + damageDealt
                SetEntityHealth(vehicle, 1000)  -- Reset vehicle health to measure future damage dealt
                DrawSubtitle("Cause as much chaos as possible! Damage NPC vehicles!")
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
RegisterNetEvent("StartChaosChallenge", StartChaosChallenge)
RegisterNetEvent("EndChaosChallenge", EndChaosChallenge)
