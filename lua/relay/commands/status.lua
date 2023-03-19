Discord.commands['status'] = function(data)
    local staffOnline = 0

    for _, ply in ipairs(player.GetAll()) do
        if not ply:IsAdmin() and not Discord.staffRanks[ply:GetUserGroup()] then continue end

        staffOnline = staffOnline + 1
    end

    Discord.send({
        ["username"] = Discord.name,
        ["avatar_url"] = Discord.avatar,
        ["embeds"] = {{
            ["title"] = GetHostName(),
            ["fields"] = {
                {
                    ["name"] = "IP Adress",
                    ["value"] = game.GetIPAddress(),
                    ["inline"] = true,
                },
                {
                    ["name"] = "Gamemode",
                    ["value"] = gmod.GetGamemode().Name,
                    ["inline"] = true,
                },
                {
                    ["name"] = "Map",
                    ["value"] = game.GetMap(),
                    ["inline"] = true,
                },
                {
                    ["name"] = "Players",
                    ["value"] = player.GetCount() .. '/' .. game.MaxPlayers(),
                    ["inline"] = true,
                },
                {
                    ["name"] = "Staff Online",
                    ["value"] = tostring(staffOnline),
                    ["inline"] = true,
                },
                {
                    ["name"] = "** **",
                    ["value"] = "** **",
                    ["inline"] = true,
                }
            },
            ["color"] = Discord.color,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ", os.time()), --ISO 8601
            ["footer"] = {
                ["text"] = data.author.username,
                ["icon_url"] = "https://cdn.discordapp.com/avatars/" .. data.author.id .. "/" .. data.author.avatar .. ".webp",
            }
        }}
    })
end

Discord.help['status'] = "Shows the server status."