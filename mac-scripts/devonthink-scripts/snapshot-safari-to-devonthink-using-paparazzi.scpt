tell application "Safari"
	set theTitle to get name of the current tab of the front window
	set theURL to get URL of the current tab of the front window
end tell

set destinationFile to "/tmp/paparazzi.pdf"

tell application "Paparazzi!"
	activate
	capture theURL

	set toggleVisibility to true
	repeat while busy
		-- Wait until Paparazzi! finishes capturing the page.
		-- NB: if I put this visibility code outside the loop, Paparazzi doesn't hide.
		if toggleVisibility then
			tell application "System Events"
				set visible of application process "Paparazzi!" to false
			end tell
			set toggleVisibility to false
		end if
	end repeat

	save as PDF in destinationFile
	close front window
end tell

tell application "DEVONthink Pro"
	activate
	set theRecord to import destinationFile name theTitle
	-- this fails with a finder error and I can't figure out why. leaving it for now. 2017-04-29.
	-- if exists theRecord then tell application "Finder" to delete file destinationFile
end tell
