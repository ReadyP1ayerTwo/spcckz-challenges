local isActive = false
local isStarted = false
local lowFlyingDistance = 0.0

function StartLowFlyingChallenge()
    isActive = true
    isStarted = false
    lowFlyingDistance = 0.0
    
    -- Start mission screen and sound
    startMissionScreen("Low Flying Challenge", "Find an aircraft and fly low to the ground!")
    PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)

    -- Start the scoreboard
    startScoreboard()

    -- Begin monitoring for challenge progress
    Citizen.CreateThread(OnTick)
end

function EndLowFlyingChallenge()
    isActive = false
    isStarted = false
    
    -- Reset distance and show scoreboard results
    showResults({
        {name = GetPlayerName(PlayerId()), score = lowFlyingDistance}
    })
    
    -- Clear low flying distance
    lowFlyingDistance = 0.0
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

                -- Track low flying distance when altitude is below 50.0
                if altitude < 50.0 then
                    lowFlyingDistance = lowFlyingDistance + 1.0
                    DrawSubtitle("Fly low and maintain altitude!")
                    
                    -- Update the event on the server for scoreboard
                    TriggerServerEvent("mth-challenges:updateEvent", lowFlyingDistance)
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

-- Function to show the mission screen at the start
function startMissionScreen(title, instructions)
    local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieMethodParameterString("~r~" .. title)
    PushScaleformMovieMethodParameterString("~w~" .. instructions)
    EndScaleformMovieMethod()

    Citizen.CreateThread(function()
        local startTime = GetGameTimer()
        while GetGameTimer() - startTime < 5000 do
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end
    end)
end

-- Function to start the scoreboard
function startScoreboard()
    showScoreboard = true
    Citizen.CreateThread(function()
        while showScoreboard do
            Citizen.Wait(0)
            displayScoreboard()
        end
    end)
end

-- Function to show the scoreboard results at the end
function showResults(bestPlayer)
    ClearPrints()
    local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieMethodParameterString("~r~Challenge Results")
    PushScaleformMovieMethodParameterString("~w~" .. bestPlayer[1].name .. " scored ~g~" .. bestPlayer[1].score .. "~w~!")
    EndScaleformMovieMethod()

    Citizen.CreateThread(function()
        local startTime = GetGameTimer()
        while GetGameTimer() - startTime < 5000 do
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end
    end)
end

-- Event registration for starting and ending the challenge
RegisterNetEvent("StartLowFlyingChallenge", StartLowFlyingChallenge)
RegisterNetEvent("EndLowFlyingChallenge", EndLowFlyingChallenge)
