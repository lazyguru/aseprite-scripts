------------------------------------------------
-- Made by Joe Constant with <3               --
--                                            --
-- For AdamCYounis, a really awesome streamer --
-- and gamedev on Twitch, go check him out:   --
-- https://twitch.com/adamcyounis             --
------------------------------------------------

--[[
    License: (CC0 1.0 Universal)
    You're free to use this script in any project, personal or commercial.
    There's no need to ask permission before using these. Giving attribution
    is not required, but is greatly appreciated!

    This script will generate a PNG file from each undo level of a sprite.

    Unfortunately, there is no way to programatically get the undo count from Aseprite
    via scripting (LUA). So we have ot prompt the user.  If the user enters an undo count
    too high, that last X files generated will all be the same (so not really a huge issue)
]]
-- Ensure we can use UI stuff
if not app.isUIAvailable then
  return
end

-- Ensure a sprite is loaded
if app.activeSprite == nil then
  app.alert("You must open a sprite first to use this script!")
  return
end

local spr = app.activeSprite

-- Prepare the dialog
local dlg = Dialog()

-- Main inputs
dlg:entry{ id="undo_count", label="Undo count", undo_count="10" }

-- Buttons
dlg:button{ id="ok", text="Export" }
dlg:button{ id="cancel", text="Cancel" }

-- Show the dialog
dlg:show()

-- Get dialog data
local data = dlg.data
local undo_count = data.undo_count

-- Stop on cancel
if data.cancel then
  return
end

app.transaction(
  function()
    -- There really should be a better way than this,
    -- but I haven't found it
    for count=1, undo_count, 1 do
        -- reset to the beginning
        app.command.Undo()
    end
    for count=1, undo_count, 1 do
        newsuffix = string.format("-step_%04d.png", count)
        filename = string.gsub(spr.filename, ".aseprite", newsuffix)
        spr:saveCopyAs(filename)
        app.command.Redo()
    end
end)
