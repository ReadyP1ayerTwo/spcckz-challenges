local npcCarDamage = 0.0

local function OnTick()
    while InChallenge do
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

function StartChaosChallenge()
    InChallenge = true
    npcCarDamage = 0.0
    Citizen.CreateThread(OnTick)
    Citizen.CreateThread(function()
        while InChallenge do
            DrawInstruction("Your objective is to cause as much damage to NPC vehicles as possible")
            TriggerServerEvent("mth-challenges:updateEvent", npcCarDamage)
            Citizen.Wait(500)
        end
    end)
end

function EndChaosChallenge()
    InChallenge = false
    npcCarDamage = 0.0
end

RegisterNetEvent("StartChaosChallenge", StartChaosChallenge)
RegisterNetEvent("EndChaosChallenge", EndChaosChallenge)
