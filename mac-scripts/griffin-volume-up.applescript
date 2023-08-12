tell application "System Events"
	tell application process "Music"
		set frontmost to true
	end tell
end tell

tell application "Music"
	set currentVolume to sound volume
	-- I have no idea why I had to make a special case like
	-- the following, but if I don't do this, then sound volume
	-- value remains 0 even when you set the value to 1. The
	-- result was that the volume would stuck at 0 if you turn
	-- the knob down. This special case solved it.
	if currentVolume ≤ 0 then
		set sound volume to 2
	else if currentVolume < 100 then
		set sound volume to currentVolume + 1
	end if
end tell
