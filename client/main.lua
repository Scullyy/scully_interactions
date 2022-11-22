local isInteractive, interactionActive, interactionPromptActive = false, false, false

local function IsAreaInteractive(playerCoords)
    local canDoInteraction = false
    if DoesScenarioExistInArea(playerCoords.x, playerCoords.y, playerCoords.z, Config.Radius, true) and not IsScenarioOccupied(playerCoords.x, playerCoords.y, playerCoords.z, Config.Radius, true) and not cache.vehicle then
        canDoInteraction = true
    end
    return canDoInteraction
end

CreateThread(function()
    while true do
        Wait(500)
        local playerCoords = GetEntityCoords(cache.ped)
        isInteractive = IsAreaInteractive(playerCoords)
        if isInteractive and not interactionPromptActive then
            lib.showTextUI(('%s - Start Interaction'):format(GetControlInstructionalButton(0, joaat('+interact') | 0x80000000, 1):sub(3)))
            interactionPromptActive = true
        elseif not isInteractive and (not interactionActive or not IsPedUsingAnyScenario(cache.ped)) and interactionPromptActive then
            lib.hideTextUI()
            interactionPromptActive = false
        end
    end
end)

lib.addKeybind({
    name = 'interact',
    description = 'Toggle interaction in area',
    defaultKey = Config.Keybind,
    onPressed = function() 
        if interactionActive then
            lib.hideTextUI()
            interactionActive = false
            interactionPromptActive = false
            ClearPedTasks(cache.ped)
            return
        end
        if isInteractive then
            lib.showTextUI(('%s - Cancel Interaction'):format(GetControlInstructionalButton(0, joaat('+interact') | 0x80000000, 1):sub(3)))
            interactionActive = true
            local playerCoords = GetEntityCoords(cache.ped)
            TaskUseNearestScenarioToCoordWarp(cache.ped, playerCoords.x, playerCoords.y, playerCoords.z, Config.Radius, true)
        end
    end
})