hs.hotkey.bind({ "Alt" }, "x", function()
	toggleApp("Wezterm")
end)

hs.hotkey.bind({ "Alt" }, "t", function()
	toggleApp("Telegram", 1)
end)

hs.hotkey.bind({ "Alt" }, "s", function()
	toggleApp("Slack", 1)
end)

hs.hotkey.bind({ "Alt" }, "w", function()
	toggleApp("WhatsApp", 1)
end)

hs.hotkey.bind({ "Alt" }, "z", function()
	toggleApp("Zed", 1)
end)

hs.hotkey.bind({ "Alt" }, "c", function()
	toggleApp("Chrome", 1)
end)

function toggleApp(appName, height)
	app = hs.application.find(appName)
	if app then
		if app:isFrontmost() then
			app:hide()
		else
			local nowspace = hs.spaces.focusedSpace()
			local screen = hs.screen.mainScreen()
			app_window = app:mainWindow()
			hs.spaces.moveWindowToSpace(app_window, nowspace)
			local max = screen:fullFrame()
			local f = app_window:frame()
			f.x = max.x
			f.y = max.y
			f.w = max.w
			f.h = max.h * (height or 0.75)
			hs.timer.doAfter(0.2, function()
				app_window:setFrame(f)
			end)
			app_window:focus()
		end
	end
end	
