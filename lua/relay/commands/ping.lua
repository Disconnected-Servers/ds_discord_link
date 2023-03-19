Discord.commands['ping'] = function(data)
    Discord.send({
        ["username"] = Discord.name,
        ["avatar_url"] = Discord.avatar,
        ["embeds"] = {{
            ["title"] = ":ping_pong: pong",
            ["color"] = Discord.color,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ", os.time()), --ISO 8601
            ["footer"] = {
                ["text"] = data.author.username,
                ["icon_url"] = "https://cdn.discordapp.com/avatars/" .. data.author.id .. "/" .. data.author.avatar .. ".webp",
            }
        }}
    })
end

Discord.help['ping'] = "Pong!"