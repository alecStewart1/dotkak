hook global WinSetOption filetype=fish %{
	set-option window tabstop 4
	set-option window indentwidth 4
	set-option window formatcmd 'sleep 0.2; fish_indent -w $kak_buffile'
	hook window -group format BufWritePre .* format
	hook -once window WinSetOption filetype=.* %{
		unset-option window formatcmd
	}
	rainbow-enable-window
}

