hook global WinSetOption filetype=json %{
	set-option window tabstop 0
	set-option window indentwidth 2
	set-option window formatcmd 'sleep 0.2; prettier --stdin-filepath=$kak_buffile'
	hook window -group format BufWritePre .* format
	hook -once window WinSetOption filetype=.* %{
		unset-option window formatcmd
	}
	rainbow-enable-window
}

