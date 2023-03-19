Discord.commands['lua'] = function(data)
    if table.KeyFromValue(data.member.roles, Discord.SuperAdminRole) == nil then return end

    local args = string.Explode(' ', data.content)
    args[1] = ""
    local command = table.concat(args, ' ')

    if string.len(command) == 0 then
        Discord.send({
            ["username"] = Discord.name,
            ["avatar_url"] = Discord.avatar,
            ["embeds"] = {{
                ["title"] = ":x: Error",
                ["description"] = "You need to specify code to run.",
                ["color"] = Discord.color,
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ", os.time()), --ISO 8601
                ["footer"] = {
                    ["text"] = data.author.username,
                    ["icon_url"] = "https://cdn.discordapp.com/avatars/" .. data.author.id .. "/" .. data.author.avatar .. ".webp",
                }
            }}
        })

        return
    end

    local func = CompileString(command, 'DiscordLuaRun', false)
    local result = ":white_check_mark: Script Executed!"

    if type(func) == 'function' then
        func()
    else
        result = ":x: Error Compiling Script!"
    end

    Discord.send({
        ["username"] = Discord.name,
        ["avatar_url"] = Discord.avatar,
        ["embeds"] = {{
            ["title"] = result,
            ["description"] = "```lua\n" .. command .. "```",
            ["color"] = Discord.color,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ", os.time()), --ISO 8601
            ["footer"] = {
                ["text"] = data.author.username,
                ["icon_url"] = "https://cdn.discordapp.com/avatars/" .. data.author.id .. "/" .. data.author.avatar .. ".webp",
            }
        }}
    })
end

Discord.help['lua'] = "Run Lua code on the server."