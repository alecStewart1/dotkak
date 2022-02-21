hook global WinSetOption filetype=lua %{
	set-option window tabstop 2
	set-option window indentwidth 2
	set-option window formatcmd 'sleep 0.2; stylua -'
	set-option window lintcmd 'sleep 0.2; luacheck'
	rainbow-enable-window
}

