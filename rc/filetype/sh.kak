hook global WinSetOption filetype=sh %{

	# --- Lint --- 
	evaluate-commands %sh{
		shell_flag=""
		case "$(basename "$kak_buffile")" in
			*.zsh|.zshrc|.zprofile|.zlogin)
				shell_flag="--shell=bash"
				;;
		esac
		printf "%s\n" \
		"set-option window lintcmd 'sleep 0.2; shellcheck $shell_flag --color=auto --format=gcc --norc'"
	}
	hook window -group lint BufWritePost .* lint
	hook -once window WinSetOption filetype=.* %{
		unset-option window lintcmd
	}

	# --- Format --- 
	set-option window formatcmd 'sleep 0.2; shfmt -i 4 -s'
	hook window -group format BufWritePre .* format
	hook -once window WinSetOption filetype=.* %{
		unset-option window formatcmd
	}

	rainbow-enable-window

}


