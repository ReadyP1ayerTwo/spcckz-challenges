local npcCarDamage = 0.0

function StartChaosChallenge()
    inChallenge = true
    npcCarDamage = 0.0
    TriggerEvent("chat:addMessage", {args = {"^2Event", "Cause chaos and damage NPC vehicles in the Chaos Challenge!"}})
    Citizen.CreateThread(OnTick)
    Citizen.CreateThread(function()
        while inChallenge do
            DrawInstruction("Your objective is to cause as much damage to NPC vehicles as possible")
            TriggerServerEvent("mth-challenges:updateEvent", npcCarDamage)
            Citizen.Wait(500)
        end
    end)
end

function EndChaosChallenge()
    inChallenge = false
    npcCarDamage = 0.0
end

function OnTick()
    while inChallenge do
        Citizen.Wait(50)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, false) then
            local currentHealth = GetEntityHealth(vehicle)
            local maxHealth = GetEntityMaxHealth(vehicle)
            local damageDealt = maxHealth - currentHealth
            npcCarDamage = npcCarDamage + damageDealt
            SetEntityHealth(vehicle, maxHealth)
        end
    end
end

RegisterNetEvent("StartChaosChallenge", StartChaosChallenge)
RegisterNetEvent("EndChaosChallenge", EndChaosChallenge)
