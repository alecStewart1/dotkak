hook global WinSetOption filetype=rst ${
	set-option window lintcmd 'sleep 0.2; proselint --compact $kak_buffile'
	hook window -group lint BufWritePost .* lint
	hook -once window WinSetOption filetype=.* %{
		unset-option window lintcmd
	}
}


