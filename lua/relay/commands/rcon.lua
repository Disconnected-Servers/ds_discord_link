Discord.commands['rcon'] = function(data)
    if table.KeyFromValue(data.member.roles, Discord.SuperAdminRole) == nil then return end

    local args = string.Explode(' ', data.content)
    args[1] = ""

    if #args == 0 then
        Discord.send({
            ["username"] = Discord.name,
            ["avatar_url"] = Discord.avatar,
            ["embeds"] = {{
                ["title"] = ":x: Error",
                ["description"] = "You need to specify a command to run.",
                ["color"] = Discord.color,
                ["footer"] = {
                    ["text"] = data.author.username,
                    ["icon_url"] = "https://cdn.discordapp.com/avatars/" .. data.author.id .. "/" .. data.author.avatar .. ".webp",
                }
            }}
        })

        return
    end

    local command = table.concat(args, ' ')
    game.ConsoleCommand(command)

    Discord.send({
        ["username"] = Discord.name,
        ["avatar_url"] = Discord.avatar,
        ["embeds"] = {{
            ["title"] = ":white_check_mark: RCON Command Executed",
            ["description"] = "```" .. command .. "```",
            ["color"] = Discord.color,
            ["footer"] = {
                ["text"] = data.author.username,
                ["icon_url"] = "https://cdn.discordapp.com/avatars/" .. data.author.id .. "/" .. data.author.avatar .. ".webp",
            }
        }}
    })
end