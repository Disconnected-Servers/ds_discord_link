local coroutine_resume = coroutine.resume
local coroutine_create = coroutine.create

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

    createAvatar(ply:SteamID(), co)
end)