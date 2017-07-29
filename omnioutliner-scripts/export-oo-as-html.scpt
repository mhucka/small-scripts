-- =============================================================================
-- @file    export-oo-as-html
-- @brief   Export OmniOutliner documents in a directory WITHOUT a .html extension
-- @author  Michael Hucka <mhucka@caltech.edu>
-- @license Please see the file LICENSE.html in the parent directory
-- =============================================================================

-- The sole reason for this script is that OmniOutliner refuses to export to
-- HTML to a directory name that does not end in ".html".  I find this
-- annoying and confusing.  Thankfully, it turns out that when the export
-- command is invoked via AppleScript, it is possible to specify a
-- destination folder/directory without ending it with the suffix ".html".

-- This script can be invoked from a shell and passing it a destination path
-- like this:
--    osascript export-oo-as-html.scpt /some/path/to/a/directory

on run argv
	if (count of argv) > 0 then
		set destpath to POSIX file (first item of argv) as alias
	else
		set dest to choose folder with prompt "Destination folder:"
		set destpath to POSIX path of dest
	end if

	tell application "OmniOutliner"
		tell front document
			export to POSIX file destpath as "com.omnigroup.OmniOutliner.HTMLExport.HTMLDynamic"
		end tell
		try
			export front document to POSIX file destpath
		on error
			-- It always produces the following error:
			-- "OmniOutliner got an error: “dyn.age8u” is not a writable file type." number 6
			-- However, it writes the output anyway...
		end try
	end tell

end run
