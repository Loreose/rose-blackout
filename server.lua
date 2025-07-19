local zoneStates = {}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        CreateThread(function()
            Wait(0) -- config.lua tam yüklensin
            for _, zone in pairs(Config.BlackoutZones) do
                zoneStates[zone.name] = zone.active
            end
        end)
    end
end)

CreateThread(function()
    Wait(1000)
    print("=== Blackout Zones ===")
    for k, v in pairs(Config.BlackoutZones) do
        print("ZONE:", v.name, "ACTIVE:", tostring(v.active))
    end
end)


RegisterNetEvent("rose-blackout:setZoneState", function(zoneName, action)
    local src = source
    local name = GetPlayerName(src)

    if not zoneStates[zoneName] then
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            args = {"[rose-blackout]", "Böyle bir bölge yok: " .. zoneName}
        })
        return
    end

    local state = action == "on"
    zoneStates[zoneName] = state

    print(("[rose-blackout] %s adlı oyuncu '%s' bölgesini %s yaptı."):format(name, zoneName, action))
    TriggerClientEvent("rose-blackout:updateZoneState", -1, zoneName, state)

    -- Oyuncuya bilgi gönder
    TriggerClientEvent('chat:addMessage', src, {
        color = {0, 255, 0},
        args = {"[rose-blackout]", ("%s bölgesi artık %s."):format(zoneName, action)}
    })
end)
