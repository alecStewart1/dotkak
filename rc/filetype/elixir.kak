hook global WinSetOption filetype=elixir %{
	set-option window formatcmd 'sleep 0.2; mix fmt'
	hook window -group format BufWritePre .* format
	set-option window lintcmd 'sleep 0.2; mix credo'
	hook window -group lint BufWritePost .* lint
	hook -once window WinSetOption filetype=.* %{
		unset-option window lintcmd
		unset-option window formatcmd
	}
}

