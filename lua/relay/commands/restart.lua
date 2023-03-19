local hasRestartDll = false 

//load server restart dll
if file.Find("lua/bin/gmsv_antifreeze_*.dll", "GAME")[1] ~= nil then
    require("antifreeze")
    antifreeze.SetTimeout(30)

    hasRestartDll = true
end


Discord.commands['restart'] = function(data)
    if table.KeyFromValue(data.member.roles, Discord.SuperAdminRole) == nil then return end

    Discord.send({
        ["username"] = Discord.name,
        ["avatar_url"] = Discord.avatar,
        ["embeds"] = {{
            ["title"] = "Restarting the server...",
            ["color"] = Discord.color,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ", os.time()), --ISO 8601
            ["footer"] = {
                ["text"] = data.author.username,
                ["icon_url"] = "https://cdn.discordapp.com/avatars/" .. data.author.id .. "/" .. data.author.avatar .. ".webp",
            }
        }}
    })

    if hasRestartDll then
        antifreeze.RestartServer()
    else
        RunConsoleCommand("_restart")
    end
end

Discord.help['restart'] = "Restarts the server."