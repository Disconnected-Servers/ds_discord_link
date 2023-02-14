require("chttp")

Avatars = {}

local IsValid = IsValid
local util_TableToJSON = util.TableToJSON
local http_Fetch = http.Fetch
local coroutine_resume = coroutine.resume
local coroutine_create = coroutine.create

function Discord.send(form) 
	if type(form) ~= "table" then Error("[Discord] invalid type!") return end

	local json = util_TableToJSON(form)

	print(json)

	CHTTP({
		["failed"] = function(msg)
			print("[Discord] " .. msg)
		end,
		["method"] = "POST",
		["url"] = Discord.webhook,
		["body"] = json,
		["type"] = "application/json"
	})
end

local function steamid(id)
	local id32
	if string.find(id, "STEAM") then
		id32 = id
		id = util.SteamIDTo64(id)
	else
		id32 = util.SteamIDFrom64(id)
	end

	return id, id32
end

function createAvatar(sid, co)
	local id, id32 = steamid(sid)

	if getAvatar(id) then
		coroutine_resume(co)
		return
	end

	http_Fetch("https://steamcommunity.com/profiles/"..id.."?xml=1", function(body)
		local _, _, url = string.find(body, '<avatarFull>.*.(https://.*)]].*\n.*<vac')
		Avatars[id] = url

		coroutine_resume(co)
	end, function (msg)
		ErrorNoHalt("[Discord] error getting avatar ("..msg..")")
	end)
end

function getAvatar(id)
	local id, id32 = steamid(id)

	return Avatars[id]
end

function removeAvatar(id)
	local id, id32 = steamid(id)

	Avatars[id] = nil
end

function ColorToDecimal(color)
    local rgb = (color.r * 0x10000) + (color.g * 0x100) + color.b
    return string.format("%x", rgb)
end