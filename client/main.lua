local ESX = exports["es_extended"]:getSharedObject()

local npc = nil
local isNuiOpen = false

CreateThread(function()
    local model = GetHashKey(Config.NPC.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end

    npc = CreatePed(4, model, Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z, Config.NPC.coords.w, false, true)
    SetEntityHeading(npc, Config.NPC.coords.w)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    if Config.NPC.scenario then
        TaskStartScenarioInPlace(npc, Config.NPC.scenario, 0, true)
    end

    exports.ox_target:addLocalEntity(npc, {
        {
            name = 'talk_to_npc',
            icon = 'fas fa-comments',
            label = Config.Lang.interact,
            onSelect = function()
                print("NPC interaction triggered") -- Debug print
                TriggerServerEvent('fast-jobcenter:checkJob')
            end
        }
    })
end)

RegisterNetEvent('fast-jobcenter:openNUI')
AddEventHandler('fast-jobcenter:openNUI', function()
    print("Attempting to open NUI") 
    if not isNuiOpen then
        isNuiOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "openNUI",
            jobs = Config.AllowedJobs
        })
        print("NUI should be open now")
    end
end)

RegisterNUICallback('closeNUI', function(data, cb)
    print("Closing NUI")
    isNuiOpen = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('selectJob', function(data, cb)
    print("Job selected: " .. data.job)
    TriggerServerEvent('fast-jobcenter:setJob', data.job)
    isNuiOpen = false
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Notification functie
function Notify(msg)
    if Config.NotificationSystem == 'ox_lib' then
        exports.ox_lib:notify({
            title = Config.Notifications.Title,
            description = msg,
            type = Config.Notifications.Type
        })
    elseif Config.NotificationSystem == 'esx' then
        ESX.ShowNotification(msg)
    elseif Config.NotificationSystem == 'custom' then
        Config.CustomNotify(msg)
    else
        print("Ongeldige notificatie systeem gespecificeerd in config")
    end
end