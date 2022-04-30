PossibleFrameWorks = {
    ['esx'] = true,
    ['qb-core'] = true,
    ['custom'] = true
}

FrameWorkFunctions = {}

function LoadFrameWorks()
    if not PossibleFrameWorks[FrameWork] then
        CoreLogger.Error('Framework ' .. FrameWork .. ' is not supported. Use esx, qb-core or custom.')
        return false
    else
        local allImplemented = true
        for k, v in pairs(FrameWorkFunctions) do
            if v and type(v) ~= "table" then
                if v() == 'not_implemented' then
                    CoreLogger.Error('Function ' .. k .. ' in framework ' .. FrameWork .. ' is not implemented. Check your framework file.')
                    allImplemented = false
                end
            end
        end
        if not allImplemented then
            return false
        end
        CoreLogger.Info('Successfuly registered ' .. FrameWork .. ' as your framework.')
        return true
    end
end

Loader.RegisterLoader('core:client:framework', LoadFrameWorks)
