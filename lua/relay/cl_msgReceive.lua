local chat_AddText = chat.AddText

net.Receive("DS_Discord", function()
	local msg = net.ReadTable()

	chat_AddText( Discord.prefixClr, "["..Discord.prefix.."] ", Color(255, 255, 255), msg.author..": ", msg.content)
end)