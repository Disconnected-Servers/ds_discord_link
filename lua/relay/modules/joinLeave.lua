local coroutine_resume = coroutine.resume
local coroutine_create = coroutine.create
local joiningplayers = {}

--player connected
gameevent.Listen( "player_connect" )
hook.Add("player_connect", "DS_Discord", function(data)
    joiningplayers[#joiningplayers + 1] = {data.networkid, data.name}

    local co = coroutine_create(function() 
        Discord.send({
            ["username"] = data.name,
            ["avatar_url"] = getAvatar(data.networkid),
            ["embeds"] = {{
                ["url"] = "https://steamid.io/lookup/" .. util.SteamIDTo64(data.networkid),
                ["title"] = "Has Connected To The Server " .. #joiningplayers .. "/" .. game.MaxPlayers(),
                ["color"] = Discord.color,
            }}
        })
    end)

    createAvatar(data.networkid, co)
end)

--player spawned
hook.Add("PlayerInitialSpawn", "DS_Discord", function(ply)
    local co = coroutine_create(function() 
        Discord.send({
            ["username"] = ply:Nick(),
            ["avatar_url"] = getAvatar(ply:SteamID()),
            ["embeds"] = {{
                ["url"] = "https://steamid.io/lookup/" .. ply:SteamID64(),
                ["title"] = "Spawned in the server " .. #joiningplayers .. "/" .. game.MaxPlayers(),
                ["color"] = Discord.color,
            }}
        })
    end)

    createAvatar(ply:SteamID(), co)
end)

--player disconnected
gameevent.Listen( "player_disconnect" )
hook.Add("player_disconnect", "DS_Discord", function(data)
    local co = coroutine_create(function() 
        local avatar = getAvatar(data.networkid)
        removeAvatar(data.networkid)

        for position, tableData in pairs(joiningplayers) do
            if tableData == {data.networkid, data.name} then
                joiningplayers[position] = nil
            end
        end

        Discord.send({
            ["username"] = data.name,
            ["avatar_url"] = avatar,
            ["embeds"] = {{
                ["url"] = "https://steamid.io/lookup/" .. util.SteamIDTo64(data.networkid),
                ["title"] = "Disconnected from the server " .. #joiningplayers .. "/" .. game.MaxPlayers(),
                ["description"] = "```" .. data.reason .. "```",
                ["color"] = Discord.color,
            }}
        })
    end)

    createAvatar(data.networkid, co)
end)