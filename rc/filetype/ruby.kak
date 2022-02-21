hook global WinSetOption filetype=ruby %{
	set-option window tabstop 2
	set-option window indentwidth 2
	set-option window formatcmd 'sleep 0.2; bundle exec rufo $kak_buffile'
	hook window -group format BufWritePre .* format
	hook -once window WinSetOption filetype=.* %{
		unset-option window formatcmd
	}
}

