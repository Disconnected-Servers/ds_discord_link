require("gwsockets")
util.AddNetworkString("DS_Discord")


Discord.isSocketReloaded = false

if Discord.socket ~= nil then Discord.isSocketReloaded = true; Discord.socket:closeNow(); end

Discord.socket = Discord.socket or GWSockets.createWebSocket("wss://gateway.discord.gg/?encoding=json", false)
local socket = Discord.socket

local function broadcastMsg(msg)
    print('[Discord] ' .. msg.author..': '.. msg.content)

    net.Start("DS_Discord")
        net.WriteTable(msg)
    net.Broadcast()
end

local function heartbeat()
    socket:write([[
      {
        "op": 1,
        "d": 251
      }      
    ]])
end

local function createHeartbeat()
    timer.Create('DS_Discord', 30, 0, function()
        heartbeat()
    end)
end

function socket:onMessage(txt)
    local resp = util.JSONToTable(txt)
    if not resp then return end

    if Discord.debug then
        print("[Discord] Received: ")
        PrintTable(resp)
    end

    if resp.op == 10 and resp.t == nil then createHeartbeat() end
    if resp.op == 1 then heartbeat() end
    if resp.d then
        if resp.t == "MESSAGE_CREATE" and resp.d.channel_id == Discord.readChannelID and resp.d.content ~= '' then
            if resp.d.author.bot == true then return end
            local args = string.Explode(" ", resp.d.content)
            if string.sub(args[1], 0, 1) == Discord.botPrefix then
              command = string.sub(args[1], 2)

              if Discord.commands[command] then Discord.commands[command](resp.d) end

              return
            end

            broadcastMsg({
                ['author'] = resp.d.author.global_name .. " (" .. resp.d.author.username .. ")",
                ['content'] = resp.d.content
            })
        end
    end
end

function socket:onError(txt)
    print("[Discord] Error: ", txt)
end

function socket:onConnected()
	print("[Discord] connected to Discord server")
  local req = [[
    {
      "op": 2,
      "d": {
        "token": "]] .. Discord.botToken .. [[",
        "compress": true,
        "intents": 512,
        "properties": {
          "os": "linux",
          "browser": "gmod",
          "device": "pc"
        }
      }
    }
    ]]

    /*
        local req = [[
    {
      "op": 2,
      "d": {
        "token": "]]..Discord.botToken..[[",
        "compress": true,
        "intents": 512,
        "properties": {
          "os": "linux",
          "browser": "gmod",
          "device": "pc"
        },
        "presence": {
          "activities": [{
            "name": "Garry's Mod",
            "type": 0
          }]
        }
      }
    }
    ]]
    */

    heartbeat()
    timer.Simple(3, function() socket:write(req) end)
end

function socket:onDisconnected()
    print("[Discord] WebSocket disconnected")
    timer.Remove('DS_Discord')

    if Discord.isSocketReloaded ~= true then
        print('[Discord] WebSocket reload in 5 sec...')
        timer.Simple(5, function() socket:open() end)
    end
end

print('[Discord] Socket init...')
timer.Simple(3, function()
    socket:open()
    Discord.isSocketReloaded = false
end)
