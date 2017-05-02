-- =============================================================================
-- @file    oo-link-selected-text.scpt
-- @brief   Make the currently selected text into a link
-- @author  Michael Hucka <mhucka@caltech.edu>
-- @license Please see the file LICENSE.html in the parent directory
-- =============================================================================
--
-- Usage: select some text and invoke this script
--
-- This will prompt for a URL and then set the text into a link.
-- I bind this to a keystroke using KeyboardMaestro for fast access.

tell application "OmniOutliner"
	display dialog "URL:" default answer ""
	set theURL to text returned of result
	set theRow to selected row of front document
	set value of attribute "link" of style of text of cell "Topic" of selected row of front document to theURL
end tell
