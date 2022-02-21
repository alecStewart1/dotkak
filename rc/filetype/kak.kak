hook global WinSetOption filetype=kak %{
	rainbow-enable-window
}

hook global BufCreate (.*/)?(\.kakrc) %{
    set-option buffer filetype kak
}
