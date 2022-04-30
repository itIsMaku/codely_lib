if MySQLScript == 'ghattimysql' then
    MySQL = {}

    MySQL.Sync = {}

    MySQL.Async = {}

    MySQL.Async.fetchAll = function(sqlQuery, table, callback)
        return exports['ghmattimysql']
            :execute(
                sqlQuery,
                table,
                callback
            )
    end

    MySQL.Sync.fetchAll = function(sqlQuery, table, callback)
        return exports['ghmattimysql']
            :executeSync(
                sqlQuery,
                table,
                callback
            )
    end

    MySQL.Async.execute = function(sqlQuery, table, callback)
        return exports['ghmattimysql']
            :execute(
                sqlQuery,
                table,
                callback
            )
    end

    MySQL.Sync.execute = function(sqlQuery, table, callback)
        return exports['ghmattimysql']
            :executeSync(
                sqlQuery,
                table,
                callback
            )
    end

    MySQl.Async.fetchScalar = function(sqlQuery, table, callback)
        return exports['ghmattimysql']
            :scalar(sqlQuery,
                table,
                callback
            )
    end
end
