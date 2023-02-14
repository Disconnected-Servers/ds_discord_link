Discord.commands['status'] = function()
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
                    ["value"] = (function()
                        local a = 0

                        for _, ply in ipairs(player.GetAll()) do
                            if not ply:IsAdmin() and not staffRank[ply:GetUserGroup()] then continue end

                            a = a + 1
                        end

                        return a
                    end)(),
                    ["inline"] = true,
                },
                {
                    ["name"] = "** **",
                    ["value"] = "** **",
                    ["inline"] = true,
                }
            },
            ["color"] = Discord.color
        }}
    }) 
end