hook global WinSetOption filetype=scheme %{
	set-option window tabstop 2
	set-option window indentwidth 2
	rainbow-enable-window
}

hook global BufCreate (.*/)?(.*\.(rkt|rktd)) %{
	set-option buffer files scheme
}
