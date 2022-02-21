hook global WinSetOption filetype=scss %{
	set-option window formatcmd 'sleep 0.2; prettier --stdin-filepath=$kak_buffile'
	hook window -group format BufWritePre .* format
	hook -once window WinSetOption filetype=.* %{
		unset-option window formatcmd
	}
}

