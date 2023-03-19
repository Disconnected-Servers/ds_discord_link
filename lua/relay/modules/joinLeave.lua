local coroutine_resume = coroutine.resume
local coroutine_create = coroutine.create
local players = {}

--player connected
gameevent.Listen( "player_connect" )
hook.Add("player_connect", "DS_Discord", function(data)
    if data.bot ~= 1 then
        players[data.networkid] = data.name
    else
        players[data.name] = data.name
    end

    local co = coroutine_create(function() 
        Discord.send({
            ["username"] = data.name,
            ["avatar_url"] = getAvatar(data.networkid),
            ["embeds"] = {{
                ["url"] = "https://steamid.io/lookup/" .. util.SteamIDTo64(data.networkid),
                ["title"] = "Has Connected To The Server " .. table.Count(players) .. "/" .. game.MaxPlayers(),
                ["color"] = Discord.color,
            }}
        })
    end)

    createAvatar(data.networkid, co)
end)

--player spawned
hook.Add("PlayerInitialSpawn", "DS_Discord", function(ply)
    if not ply:IsBot() then
        players[ply:SteamID()] = ply:Nick()
    else
        players[ply:Nick()] = ply:Nick()
    end

    local co = coroutine_create(function() 
        Discord.send({
            ["username"] = ply:Nick(),
            ["avatar_url"] = getAvatar(ply:SteamID()),
            ["embeds"] = {{
                ["url"] = "https://steamid.io/lookup/" .. ply:SteamID64(),
                ["title"] = "Spawned in the server " .. table.Count(players) .. "/" .. game.MaxPlayers(),
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

        if data.bot ~= 1 then
            players[data.networkid] = nil
        else
            players[data.name] = nil
        end

        Discord.send({
            ["username"] = data.name,
            ["avatar_url"] = avatar,
            ["embeds"] = {{
                ["url"] = "https://steamid.io/lookup/" .. util.SteamIDTo64(data.networkid),
                ["title"] = "Disconnected from the server " .. table.Count(players) .. "/" .. game.MaxPlayers(),
                ["description"] = "```" .. data.reason .. "```",
                ["color"] = Discord.color,
            }}
        })
    end)

    createAvatar(data.networkid, co)
end)

concommand.Add("discord_link_players", function(ply)
    if IsValid(ply) then
        if not ply:IsSuperAdmin() then
            return
        end
    end

    PrintTable(players)
end)