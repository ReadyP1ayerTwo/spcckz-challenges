local currentEvent = nil
local inEvent = false
local currentEventId = -1
local percentage_remaining = 100
local PlayerData = {}

local function getFirst3Players(eventId)
    local data = PlayerData[eventId] or {}
    local players = {}

    for k, v in pairs(data) do
        table.insert(players, {name = GetPlayerName(k), score = v})
    end

    table.sort(players, function(a, b)
        return a.score > b.score
    end)

    return {
        players[1] or {name = "Player 1", score = 0},
        players[2] or {name = "Player 2", score = 0},
        players[3] or {name = "Player 3", score = 0}
    }
end

local function stopEvent()
    if not inEvent or currentEvent == nil then return end

    local bestPlayers = getFirst3Players(currentEventId)
    TriggerClientEvent("mth-challenges:endEvent", -1, currentEvent["end"], bestPlayers)
    PlayerData[currentEventId] = {}
    inEvent = false
end

local function startEvent()
    if inEvent then return end

    local nextEventId = math.random(#Challenges_list)
    while nextEventId == currentEventId do
        nextEventId = math.random(#Challenges_list)
    end
    currentEventId = nextEventId

    currentEvent = Challenges_list[currentEventId]
    print("Starting event: " .. currentEvent["name"])
    percentage_remaining = 100
    PlayerData = {}
    TriggerClientEvent("mth-challenges:startEvent", -1, currentEvent["start"], currentEvent["countdown"])
    Wait(5000)
    inEvent = true
    Citizen.CreateThread(function()
        Citizen.Wait(currentEvent["countdown"])
        stopEvent()
        Wait(Config["cooldown"])
        startEvent()
    end)

    Citizen.CreateThread(function()
        while inEvent do
            Citizen.Wait(currentEvent["countdown"] / 100)
            percentage_remaining = percentage_remaining - 1
            if percentage_remaining % 10 == 0 then
                TriggerClientEvent("mth-challenges:updateTimer", -1, percentage_remaining, currentEvent["countdown"])
            end
        end
    end)
end

RegisterNetEvent("mth-challenges:updateEvent", function (data)
    if currentEvent == nil then
        return
    end
    local score = data
    local player = source
    PlayerData[currentEventId] = PlayerData[currentEventId] or {}
    PlayerData[currentEventId][player] = math.max(PlayerData[currentEventId][player] or 0, score)

    local bestPlayers = getFirst3Players(currentEventId)
    TriggerClientEvent("mth-challenges:updateScoreboard", -1, bestPlayers)
end)

RegisterNetEvent("mth-challenges:playerConnected", function()
    if currentEvent then
        TriggerClientEvent("mth-challenges:startEvent", source, currentEvent["start"], currentEvent["countdown"])
    end
end)

AddEventHandler("onResourceStart", function (resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Wait(5000)
    startEvent()
end)