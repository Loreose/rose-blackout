local currentZone = nil

CreateThread(function()
    while true do
        Wait(1000)
        local coords = GetEntityCoords(PlayerPedId())

        for _, zoneData in pairs(Config.BlackoutZones) do
            local zone = Zones[zoneData.name]
            if zone and zone:isPointInside(coords) then
                if zoneData.active and currentZone ~= zoneData.name then
                    currentZone = zoneData.name
                    TriggerEvent("rose-blackout:enable")
                    if Config.Debug then print("[rose-blackout] Girdin: " .. zoneData.label) end
                elseif not zoneData.active and currentZone == zoneData.name then
                    currentZone = nil
                    TriggerEvent("rose-blackout:disable")
                    if Config.Debug then print("[rose-blackout] Çıktın: " .. zoneData.label) end
                end
                break
            elseif currentZone == zoneData.name then
                currentZone = nil
                TriggerEvent("rose-blackout:disable")
                if Config.Debug then print("[rose-blackout] Çıktın: " .. zoneData.label) end
            end
        end
    end
end)

RegisterNetEvent("rose-blackout:enable", function()
    SetArtificialLightsState(true)
    SetArtificialLightsStateAffectsVehicles(false)
    SetArtificialLightsStateAffectsPedLights(false)
end)

RegisterNetEvent("rose-blackout:disable", function()
    SetArtificialLightsState(false)
end)

RegisterNetEvent("rose-blackout:updateZoneState", function(zoneName, state)
    for i, zoneData in pairs(Config.BlackoutZones) do
        if zoneData.name == zoneName then
            zoneData.active = state
            if Config.Debug then
                print(("[rose-blackout] '%s' durumu güncellendi: %s"):format(zoneName, tostring(state)))
            end
        end
    end
end)

RegisterCommand("blackout", function(_, args)
    local zone = args[1]
    local state = args[2]

    if not zone or not state then
        print("[rose-blackout] Kullanım: /blackout <zone> <on|off>")
        return
    end

    TriggerServerEvent("rose-blackout:setZoneState", zone, state)
end, false)
