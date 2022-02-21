hook global WinSetOption filetype=rust %{
	set-option window tabstop 4
	set-option window indentwidth 4
	set-option window formatcmd 'sleep 0.2; rustfmt --emit files $kak_buffile'
	hook window -group format BufWritePre .* format
	hook -once window WinSetOption filetype=.* %{
		unset-option window formatcmd
	}
}

