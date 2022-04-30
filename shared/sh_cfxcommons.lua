function IsCfxServer()
    return IsDuplicityVersion()
end

function GetNetworkSide()
    if IsCfxServer() then return 'server' end
    return 'client'
end
