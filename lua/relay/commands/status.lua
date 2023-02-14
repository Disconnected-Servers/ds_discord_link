Discord.commands['status'] = function(data)
    local staffOnline = 0

    for _, ply in ipairs(player.GetAll()) do
        if not ply:IsAdmin() and not Discord.staffRanks[ply:GetUserGroup()] then continue end

        staffOnline = staffOnline + 1
    end

    local hostname = string.Replace(GetHostName(), "🌌", "")

    Discord.send({
        ["username"] = Discord.name,
        ["avatar_url"] = Discord.avatar,
        ["embeds"] = {{
            ["title"] = hostname,
            ["url"] = "steam://connect/" .. game.GetIPAddress(),
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
                }
            },
            ["color"] = Discord.color,
            ["footer"] = {
                ["text"] = Discord.name,
                ["icon_url"] = Discord.avatar,
            }
        }}
    }) 

    Discord.send({
        ["content"] = "test",
    })
end