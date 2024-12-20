---@diagnostic disable: missing-parameter
IsParticipating = true
InChallenge = false
local showScoreboard = false
local percentage = 1
local current_cooldown = 0

-- FORMATTING STUFF
local ScreenCoords = {
    baseX = 0.918,
    baseY = 0.984,
    titleOffsetX = 0.012,
    titleOffsetY = -0.009,
    valueOffsetX = 0.0785,
    valueOffsetY = -0.0165,
    pbarOffsetX = 0.005,
    pbarOffsetY = 0.0015
}

local Sizes = {
    timerBarWidth = 0.165,
    timerBarHeight = 0.035,
    timerBarMargin = 0.038,
    pbarWidth = 0.1616,
    pbarHeight = 0.0205
}

-- Colors for player text
local players = {
    player1 = { r = 227, g = 209, b = 96, a = 255 }, -- Player 1 text color
    player2 = { r = 164, g = 164, b = 160, a = 255 }, -- Player 2 text color
    player3 = { r = 219, g = 142, b = 91, a = 255 }  -- Player 3 text color
}

-- Sprite background for name
local sprite = {
    solidColor = { r = 10, g = 10, b = 10, a = 50 }, -- Left side solid color
    fadeColor = { r = 10, g = 10, b = 10, a = 225 }, -- Right side faded color
    fadeSteps = 60 -- Number of gradient steps (higher = smoother)
}

-- Progress bar colors
local progressBar = {
    background = { r = 10, g = 10, b = 10, a = 175 }, -- Background color
    foreground = { r = 93, g = 182, b = 229, a = 255 } -- Foreground (progress) color
}

local scoreboard = {
    { name = "Player 1", score = 0 },
    { name = "Player 2", score = 0 },
    { name = "Player 3", score = 0 },
}

RegisterCommand("toggle_challenges", function()
    IsParticipating = not IsParticipating
    if IsParticipating then
        TriggerEvent("chat:addMessage", { args = { "~r~[mth-challenges]", "You will enter the next challenge!" } })
    else
        TriggerEvent("chat:addMessage", { args = { "~r~[mth-challenges]", "You are no longer participating in challenges" } })
        showScoreboard = false
        InChallenge = false
    end
end, false)

local function showResults(bestPlayer)
    ClearPrints()

    local begin = GetGameTimer()

    local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieMethodParameterString("~r~Challenge Results")
    PushScaleformMovieMethodParameterString("~w~" .. bestPlayer[1].name .. " won the challenge with a score of ~g~" .. bestPlayer[1].score .. "~w~!")
    EndScaleformMovieMethod()

    PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true)
    while GetGameTimer() - begin < 5000 do
        Citizen.Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
    end
end

local function displayScoreboard()
    local safeZone = GetSafeZoneSize()
    local safeZoneX = (1.0 - safeZone) * 0.5
    local safeZoneY = (1.0 - safeZone) * 0.5

    local drawY1 = (ScreenCoords.baseY - safeZoneY) - (3 * Sizes.timerBarMargin)
    local drawY2 = (ScreenCoords.baseY - safeZoneY) - (2 * Sizes.timerBarMargin)
    local drawY3 = (ScreenCoords.baseY - safeZoneY) - (1 * Sizes.timerBarMargin)

-- Function to draw a gradient background
local function DrawGradientBackground(x, y, width, height, solidColor, fadeColor, steps)
    local stepWidth = width / steps
    for i = 0, steps - 1 do
        -- Interpolate alpha for fading effect
        local alpha = fadeColor.a + ((solidColor.a - fadeColor.a) / steps) * i
        -- Use solid color for RGB (change if needed for RGB interpolation)
        local color = {
            r = solidColor.r,
            g = solidColor.g,
            b = solidColor.b,
            a = math.floor(alpha) -- Ensure alpha is an integer
        }
        -- Calculate position for each gradient step
        local stepX = x + (width / 2) - (i * stepWidth) - (stepWidth / 2)
        -- Draw the rectangle for this gradient step
        DrawRect(stepX, y, stepWidth, height, color.r, color.g, color.b, color.a)
    end
end

-- Replace the DrawSprite calls with this gradient background
DrawGradientBackground(ScreenCoords.baseX - safeZoneX + 0.005, drawY1, Sizes.timerBarWidth, Sizes.timerBarHeight, sprite.solidColor, sprite.fadeColor, sprite.fadeSteps)
DrawGradientBackground(ScreenCoords.baseX - safeZoneX + 0.005, drawY2, Sizes.timerBarWidth, Sizes.timerBarHeight, sprite.solidColor, sprite.fadeColor, sprite.fadeSteps)
DrawGradientBackground(ScreenCoords.baseX - safeZoneX + 0.005, drawY3, Sizes.timerBarWidth, Sizes.timerBarHeight, sprite.solidColor, sprite.fadeColor, sprite.fadeSteps)

    -- Player 1
    if scoreboard[1] then
        local p1Color = players.player1
        AddTextEntry("player1", (scoreboard[1].name or "Player 1") .. " - " .. (scoreboard[1].score or 0))
        SetTextScale(1.0, 0.45)
        SetTextColour(p1Color.r, p1Color.g, p1Color.b, p1Color.a)
        SetTextCentre(true)
        BeginTextCommandDisplayText("player1")
        EndTextCommandDisplayText((ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY1 + ScreenCoords.valueOffsetY)
    end

    -- Player 2
    if scoreboard[2] then
        local p2Color = players.player2
        AddTextEntry("player2", (scoreboard[2].name or "Player 2") .. " - " .. (scoreboard[2].score or 0))
        SetTextScale(1.0, 0.45)
        SetTextColour(p2Color.r, p2Color.g, p2Color.b, p2Color.a)
        SetTextCentre(true)
        BeginTextCommandDisplayText("player2")
        EndTextCommandDisplayText((ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY2 + ScreenCoords.valueOffsetY)
    end

    -- Player 3
    if scoreboard[3] then
        local p3Color = players.player3
        AddTextEntry("player3", (scoreboard[3].name or "Player 3") .. " - " .. (scoreboard[3].score or 0))
        SetTextScale(1.0, 0.45)
        SetTextColour(p3Color.r, p3Color.g, p3Color.b, p3Color.a)
        SetTextCentre(true)
        BeginTextCommandDisplayText("player3")
        EndTextCommandDisplayText((ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY3 + ScreenCoords.valueOffsetY)
    end

    -- Progress Bar
    local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX
    local pbarY = (ScreenCoords.baseY - safeZoneY) + ScreenCoords.pbarOffsetY
    local width = Sizes.pbarWidth * percentage

    local bgColor = progressBar.background
    local fgColor = progressBar.foreground

    -- Background
    DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, bgColor.r, bgColor.g, bgColor.b, bgColor.a)
    -- Foreground
    DrawRect((pbarX - Sizes.pbarWidth / 2) + width / 2, pbarY, width, Sizes.pbarHeight, fgColor.r, fgColor.g, fgColor.b, fgColor.a)
end

local function startScoreboard()
    showScoreboard = true

    if not IsParticipating then
        return
    end

    Citizen.CreateThread(function()
        while showScoreboard do
            Citizen.Wait(0)
            displayScoreboard()
        end
    end)
    -- Timer countdown
    Citizen.CreateThread(function()
        while showScoreboard do
            Citizen.Wait(current_cooldown / 100)
            if percentage > 0 then
                percentage = percentage - 0.01
            end
        end
    end)
end

function DrawInstruction(instruction)
    AddTextEntry('mth-challenges:Subtitle', instruction)
    BeginTextCommandPrint('mth-challenges:Subtitle')
    AddTextComponentSubstringPlayerName(instruction)
    EndTextCommandPrint(500, true)
end

function StartMissionScreen(title, instructions)
    PlaySoundFrontend(-1, "FLIGHT_SCHOOL_LESSON_PASSED", "HUD_AWARDS")
    local begin = GetGameTimer()
    local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    while GetGameTimer() - begin < 5000 do
        Citizen.Wait(0)
        BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
        ScaleformMovieMethodAddParamTextureNameString(title)
        ScaleformMovieMethodAddParamTextureNameString(instructions)
        EndScaleformMovieMethod()
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
    end
    Wait(1000)
    startScoreboard()
end

RegisterNetEvent("mth-challenges:endEvent", function(event, bestPlayer)
    if IsParticipating and InChallenge then
        showScoreboard = false
        percentage = 1
        if bestPlayer ~= nil and bestPlayer[1].score ~= 0 then
            showResults(bestPlayer)
        end
        TriggerEvent(event)
    end
end)

RegisterNetEvent("mth-challenges:startEvent", function(event, cooldown)
    if IsParticipating then
        TriggerEvent(event)
        current_cooldown = cooldown
    end
end)

RegisterNetEvent("mth-challenges:updateScoreboard", function(data, percentage_remaining)
    if IsParticipating and InChallenge then
        scoreboard = data
    end
end)

RegisterNetEvent("mth-challenges:updateTimer", function(percentage_remaining)
    if IsParticipating and InChallenge then
        percentage = percentage_remaining / 100
    end
end)


AddEventHandler('playerSpawned', function()
    if not IsParticipating then
        return
    end
    Wait(5000)
    local player = GetPlayerServerId(PlayerId())
    TriggerServerEvent('mth-challenges:playerConnected', player)
end)
