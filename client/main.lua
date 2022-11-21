local function IsAreaInteractive(playerCoords)
    local isInteractive = false
    if DoesScenarioExistInArea(playerCoords.x, playerCoords.y, playerCoords.z, Config.Radius, true) and not IsScenarioOccupied(playerCoords.x, playerCoords.y, playerCoords.z, Config.Radius, true) and not cache.vehicle then
        isInteractive = true
    end
    return isInteractive
end

lib.addKeybind({
    name = 'interact',
    description = 'Toggle interaction in area',
    defaultKey = Config.Keybind,
    onPressed = function()
        if IsPedUsingAnyScenario(cache.ped) then
            lib.hideTextUI()
            ClearPedTasks(cache.ped)
            return
        end
        local playerCoords = GetEntityCoords(cache.ped)
        local isInteractive = IsAreaInteractive(playerCoords)
        if isInteractive then
            lib.showTextUI(('%s - Cancel Interaction'):format(GetControlInstructionalButton(0, joaat('+interact') | 0x80000000, 1):sub(3)))
            TaskUseNearestScenarioToCoordWarp(cache.ped, playerCoords.x, playerCoords.y, playerCoords.z, Config.Radius, true)
        end
    end
})