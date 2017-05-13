-- =============================================================================
-- @file    oo-make-file-read-only.scpt
-- @brief   Make the current OO file be read only
-- @author  Michael Hucka <mhucka@caltech.edu>
-- @license Please see the file LICENSE.html in the parent directory
-- =============================================================================
--
-- Usage: run while an OO document is open and in the front window

tell application "OmniOutliner"
	set docFile to file of front document
	set filename to POSIX path of file docFile
	do shell script ("chmod a-w " & quoted form of filename)
end tell


