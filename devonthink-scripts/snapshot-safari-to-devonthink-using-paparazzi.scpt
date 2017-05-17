-- =============================================================================
-- @file    snapshot-safari-to-devonthink-using-paparazzi.scpt
-- @brief   Import a full-page PDF version of a web page to DEVONthink
-- @author  Michael Hucka <mhucka@caltech.edu>
-- @license Please see the file LICENSE.html in the parent directory
-- =============================================================================
--
-- DEVONthink has a web import facility that is already able to create full-page
-- snapshots of web pages in PDF format.  However, in my experience, it often
-- fails to work for long pages (in which case, it produces a blank PDF).  I've
-- found Paparazzi! to be more reliable.
--
-- Unfortunately, the use of DEVONthink's import command via AppleScript loses
-- some of the nice features of its native web clipper facility, such as the
-- list of recently used Groups.  It's a tradeoff.

global theTitle
global theURL
global destinationFile

on devonthink_import()
	tell application id "DNtp"
		activate
		set theRecord to import destinationFile name theTitle
		-- this fails with a finder error and I can't figure out why. leaving it for now. 2017-04-29.
		-- if exists theRecord then tell application "Finder" to delete file destinationFile
	end tell
end devonthink_import


tell application "Safari"
	set theTitle to get name of the current tab of the front window
	set theURL to get URL of the current tab of the front window
end tell

set destinationFile to "/tmp/_paparazzi.pdf"

tell application "System Events"
	if exists file destinationFile then
		tell application "Finder" to delete destinationFile as POSIX file
	end if
end tell

tell application "Paparazzi!"
	activate
	capture theURL delay 20

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

tell application "System Events"
	if exists file destinationFile then
		my devonthink_import()
	else
		display alert "Paparazzi failed to save the file"
		activate application "Paparazzi!"
	end if
end tell


