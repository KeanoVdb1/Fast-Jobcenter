local ESX = exports["es_extended"]:getSharedObject()

local function Notify(source, msg)
    if Config.NotificationSystem == 'ox_lib' then
        TriggerClientEvent('ox_lib:notify', source, {
            title = Config.Notifications.Title,
            description = msg,
            type = Config.Notifications.Type
        })
    elseif Config.NotificationSystem == 'esx' then
        TriggerClientEvent('esx:showNotification', source, msg)
    elseif Config.NotificationSystem == 'custom' then
        Config.CustomNotify(source, msg)
    else
        print("Ongeldige notificatie systeem gespecificeerd in config")
    end
end

RegisterServerEvent('fast-jobcenter:checkJob')
AddEventHandler('fast-jobcenter:checkJob', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer then
        print(Config.DebugMessages.PlayerInteraction)
        TriggerClientEvent('fast-jobcenter:openNUI', _source)
    end
end)

RegisterServerEvent('fast-jobcenter:setJob')
AddEventHandler('fast-jobcenter:setJob', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer then
        print(Config.DebugMessages.AttemptingSetJob:format(job))

        -- Controleer of de job bestaat
        if ESX.DoesJobExist(job, 0) then
            -- Verander de job van de speler
            xPlayer.setJob(job, 0)
            
            -- Stuur een notificatie naar de speler
            Notify(_source, Config.Notifications.JobSet:format(job))
        else
            -- Als de job niet bestaat, stuur een foutmelding
            Notify(_source, Config.Notifications.JobNotExist)
        end
    else
        print(Config.DebugMessages.PlayerNotFound)
        -- Optioneel: stuur een notificatie naar de client
        Notify(_source, Config.Notifications.PlayerNotFound)
    end
end)