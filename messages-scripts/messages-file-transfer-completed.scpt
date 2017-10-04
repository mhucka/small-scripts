tell application "Finder"
	do shell script "/opt/local/bin/terminal-notifier -sender com.apple.iChat -title 'Messages' -message 'File transfer completed'"
end tell

