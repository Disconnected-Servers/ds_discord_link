hook.Add("InitPostEntity", "DS_Discord", function()
    Discord.send({
        ["username"] = Discord.name,
        ["avatar_url"] = Discord.avatar,
        ["embeds"] = {{
            ["title"] = "Server is now online!",
            ["description"] = "Map: " .. game.GetMap() .. "\nJoin now at steam://connect/" .. game.GetIPAddress(),
            ["color"] = Discord.color
        }}
    })
end)