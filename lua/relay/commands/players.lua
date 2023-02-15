Discord.commands['players'] = function(data)
    local players = {}
    local numberOfPlayers = 0

    local text = "No players connected. ¯\\_(ツ)_/¯"

    for _, ply in ipairs(player.GetAll()) do
        numberOfPlayers = numberOfPlayers + 1

        //1:14:41
        local timeConnected = "0:00:00"

        if not ply:IsBot() then
            timeConnected = math.floor(ply:TimeConnected())

            local minutes = math.floor(timeConnected / 60)
            if minutes > 60 then
                minutes = minutes - 60
            end

            local seconds = math.floor(timeConnected % 60)
            if seconds < 10 then
                seconds = "0" .. seconds
            elseif seconds == 0 then
                seconds = "00"
            end

            timeConnected = math.floor(timeConnected / 3600) .. ':' .. minutes .. ':' .. seconds
        end

        local playerStatus = "Connected"
        if ply:IsTimingOut() then
            playerStatus = "Timing out"
        end

        local team = "Team: " .. team.GetName(ply:Team()) .. " "
        if team == "Team: Unassigned " then
            team = ""
        end

        table.insert( players, numberOfPlayers .. ". [" .. ply:Name() .. '](' .. ply:SteamID() .. ') ' .. team)
        table.insert( players, "[" .. playerStatus .. "](" .. timeConnected .. ")" .. " Kills: " .. ply:Frags() .. " Deaths: " .. ply:Deaths() .. " Ping: " .. ply:Ping() .. "\n")
    end

    if numberOfPlayers > 0 then
        text = table.concat(players, '\n')
    end

    Discord.send({
        ["username"] = Discord.name,
        ["avatar_url"] = Discord.avatar,
        ["embeds"] = {{
            ["title"] = numberOfPlayers .. "/" .. game.MaxPlayers() .. " Players Connected",
            ["url"] = "steam://connect/" .. game.GetIPAddress(),
            ["description"] = "```md\n".. text .."```",
            ["color"] = Discord.color,
            ["footer"] = {
                ["text"] = data.author.username,
                ["icon_url"] = "https://cdn.discordapp.com/avatars/" .. data.author.id .. "/" .. data.author.avatar .. ".webp",
            }
        }},
    })
end

Discord.help['players'] = "Get A List Of Players Connected To The Server."