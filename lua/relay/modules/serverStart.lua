local initalip = game.GetIPAddress()
local title = string.find( initalip, "0.0.0.0" ) and "The server has started or restarted!" or "The server has changed levels!"

local function sendWebhook()
    if string.find( game.GetIPAddress(), "0.0.0.0" ) then
        timer.Simple( 0.1, function()
            return sendWebhook()
        end )
    end

    Discord.send({
        ["username"] = Discord.name,
        ["avatar_url"] = Discord.avatar,
        ["embeds"] = {{
            ["title"] = title,
            ["thumbnail"] = {
				["url"] = "https://cdn.dservers.xyz/images/map-icons/" .. game.GetMap() .. ".png",
			},
            ["description"] = "Map: " .. game.GetMap() .. "\nJoin now at steam://connect/" .. game.GetIPAddress(),
            ["color"] = Discord.color,
        }}
    })
end

hook.Add("InitPostEntity", "DS_Discord", sendWebhook)