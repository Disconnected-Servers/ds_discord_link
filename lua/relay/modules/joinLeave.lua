local coroutine_resume = coroutine.resume
local coroutine_create = coroutine.create
local players = {}

--player connected
gameevent.Listen( "player_connect" )
hook.Add("player_connect", "DS_Discord", function(ply)
    players[ply.networkid] = ply.name

    local co = coroutine_create(function() 
        Discord.send({
            ["username"] = ply.name,
            ["avatar_url"] = getAvatar(ply.networkid),
            ["embeds"] = {{
                ["url"] = "https://steamid.io/lookup/" .. util.SteamIDTo64(ply.networkid),
                ["title"] = "Has Connected To The Server " .. #players .. "/" .. game.MaxPlayers(),
                ["color"] = Discord.color,
            }}
        })
    end)

    createAvatar(ply.networkid, co)
end)

--player spawned
hook.Add("PlayerInitialSpawn", "DS_Discord", function(ply)
    local co = coroutine_create(function() 
        Discord.send({
            ["username"] = ply.name,
            ["avatar_url"] = getAvatar(ply:SteamID()),
            ["embeds"] = {{
                ["url"] = "https://steamid.io/lookup/" .. util.SteamIDTo64(ply.networkid),
                ["title"] = "Spawned in the server " .. #players .. "/" .. game.MaxPlayers(),
                ["color"] = Discord.color,
            }}
        })
    end)

    createAvatar(ply:SteamID(), co)
end)

--player disconnected
gameevent.Listen( "player_disconnect" )
hook.Add("player_disconnect", "DS_Discord", function(ply)
    local co = coroutine_create(function() 
        local avatar = getAvatar(ply.networkid)
        removeAvatar(ply.networkid)
        players[ply.networkid] = nil

        Discord.send({
            ["username"] = ply.name,
            ["avatar_url"] = GetPfp(util.SteamIDTo64(ply.networkid)),
            ["embeds"] = {{
                ["url"] = "https://steamid.io/lookup/" .. util.SteamIDTo64(ply.networkid),
                ["title"] = "Disconnected from the server " .. #players .. "/" .. game.MaxPlayers() .. "```" .. ply.reason .. "```",
                ["color"] = Discord.color,
            }}
        })
    end)

    createAvatar(ply.networkid, co)
end)