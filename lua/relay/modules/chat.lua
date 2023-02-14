hook.Add("PlayerSay", "DS_Discord", function(ply, str)
    local co = coroutine_create(function() 
        Discord.send({
            ["username"] = ply:Nick(),
            ["avatar_url"] = getAvatar(ply:SteamID()),
            ["content"] = str,
            ["allowed_mentions"] = {
				["parse"] = {}
			},
        })
    end)

    createAvatar(ply.networkid, co)
end)