AddEventHandler('onResourceStop', function(resourceName)
    TriggerEvent(string.format('%s:resourceStopped', resourceName))
end)
