tell application "System Events"
	tell application process "Music"
		set frontmost to true
	end tell
end tell

tell application "Music"
	set currentVolume to sound volume
	if currentVolume ≥ 1 then
		set sound volume to currentVolume - 1
	end if
end tell
