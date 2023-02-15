function Discord.findPlayer(name)
    name = string.lower(name)

    for _, ply in ipairs(player.GetAll()) do
        if string.find(string.lower(ply:Nick()), name, 1, true) or string.find(string.lower(ply:Name()), name, 1, true) or name == ply:SteamID() or name == ply:SteamID64() then
            return ply
        end
    end

    return nil
end

function ColorToDecimal(color)
    local rgb = (color.r * 0x10000) + (color.g * 0x100) + color.b
    return string.format("%x", rgb)
end