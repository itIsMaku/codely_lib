PossibleMySQLScripts = {
    ['oxmysql'] = true,
    ['ghattimysql'] = true,
    ['mysql-async'] = true
}

function LoadDatabase()
    if not PossibleMySQLScripts[MySQLScript] then
        CoreLogger.Error('MySQL script ' .. MySQLScript .. ' is not supported. Use oxmysql, ghattimysql or mysql-async.')
    else
        CoreLogger.Info('Successfuly registered ' .. MySQLScript .. ' as MySQL script.')
    end
    return PossibleMySQLScripts[MySQLScript]
end

Loader.RegisterLoader('core:server:database', LoadDatabase)
