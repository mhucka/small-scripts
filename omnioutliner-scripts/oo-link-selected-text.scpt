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
--
-- The crucial bit of code to set the topic cell's link came from a
-- posting by user "Mockman" to the OmniGroup forums in May 2017:
-- https://discourse.omnigroup.com/t/selecting-text-and-adding-a-hyperlink/23673

tell application "OmniOutliner"
	display dialog "URL:" default answer ""
	set theURL to text returned of result
	tell selected row of document 1
		set topic cell's text's style's attribute "link"'s value to theURL
	end tell
end tell
