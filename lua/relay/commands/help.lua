Discord.commands['help'] = function(data)
    local fields = {}
    for name, desc in pairs(Discord.help) do
        fields[#fields + 1] = {
            ["name"] = name,
            ["value"] = desc,
            ["inline"] = true
        }
    end

    local embed = {
        ["username"] = Discord.name,
        ["avatar_url"] = Discord.avatar,
        ["embeds"] = {{
            ["title"] = "Server Relay Help | Prefix: " .. Discord.botPrefix,
            ["fields"] = fields,
            ["color"] = Discord.color,
            ["footer"] = {
                ["text"] = data.author.username,
                ["icon_url"] = "https://cdn.discordapp.com/avatars/" .. data.author.id .. "/" .. data.author.avatar .. ".webp",
            }
        }}
    }

    Discord.send(embed)
end

Discord.help["help"] = "Displays this help message or help for a specific command."