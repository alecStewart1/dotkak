hook global WinSetOption filetype=markdown ${
	set-option window lintcmd 'sleep 0.2; proselint --compact $kak_buffile'
	hook window -group lint BufWritePost .* lint
	hook -once window WinSetOption filetype=.* %{
		unset-option window lintcmd
	}
	set-option window formatcmd 'sleep 0.2; prettier --stdin-filepath=$kak_buffile'
	hook window -group format BufWritePre .* format
	hook -once window WinSetOption filetype=.* %{
		unset-option window formatcmd
	}
}

