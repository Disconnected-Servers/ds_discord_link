local chat_AddText = chat.AddText

net.Receive("DS_Discord", function()
	local msg = net.ReadTable()

	chat_AddText( Discord.prefixClr, "["..Discord.prefix.."] ", color_white, msg.author..": ", msg.content)
end)