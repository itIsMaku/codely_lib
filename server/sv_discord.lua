function SendWebhook(url, username, color, title, message, footer)
    local content = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] = message,
            ["footer"] = {
                ["text"] = footer,
            }
        }
    }
    PerformHttpRequest(
        url,
        function(err, text, headers)
        end,
        'POST',
        json.encode(
            {
            username = username,
            embeds = content
        }
        ),
        {
        ['Content-Type'] = 'application/json'
    }
    )
end

exports('SendWebhook', SendWebhook)
