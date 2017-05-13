-- [2009-03-07 <mhucka@caltech.edu>] Obtained original from the following page:
-- http://fall-line.com/2007/07/change-keyboard-modifier-keys-automatically-on-osx-with-applescript/
-- Original authorship attributed to Joe Thomas, who modified a script by Lance Ball
-- Comments from the original script follow:
--
-- Utility script to switch keyboard mapping for Command and Option keys.
-- Useful when you have a PC external keyboard that you use in one location, but
-- at other times you are using the builtin laptop keyboard or an Apple keyboard.
-- Author:  Lance Ball (lanceball - at - mac - dot - com)
--
-- Edit history:
-- [2009-03-07] Didn't work for me straight off.  Needed to change the numbers
-- of the menus by -1 (e.g., commandKey to value of pop up button 2 instead of
-- the original 3).  Also needed a delay after selecting the final pop-up and
-- before returning.

-- Open System Preferences

tell application "System Preferences"
	activate
	set current pane to pane "com.apple.preference.keyboard"
end tell

tell application "System Events"
	-- If we don't have UI Elements enabled, then nothing is really going to work.
	if UI elements enabled then
		tell application process "System Preferences"
			get properties

			-- Open up the Modifier Keys sheet
			click button "Modifier Keys…" of tab group 1 of window "Keyboard & Mouse"
			tell sheet 1 of window "Keyboard & Mouse"
				-- get the text of the 3rd pop up button
				set commandKey to value of pop up button 2
				-- looks like we're in default mode.  Swap the keys
				if commandKey ends with "Option" then
					click pop up button 2
					click menu item 4 of menu 1 of pop up button 2
					delay 1
					click pop up button 1
					click menu item 3 of menu 1 of pop up button 1
					delay 1
				else
					-- We're in PC keyboard mode.  Swap back to the defaults
					click button "Restore Defaults"
				end if
				-- close the sheet
				click button "OK"
			end tell
		end tell
		tell application "System Preferences" to quit
	else
		-- UI elements not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preference.universalaccess"
			display dialog "UI element scripting is not enabled.
              	Check \"Enable access for assistive devices\""
		end tell
	end if
end tell

