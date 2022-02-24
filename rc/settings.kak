# ====# Basic settings #====
#


# --- Kakoune specific settings ---
#


# ~~~ UI ~~~
#

set-option -add global ui_options terminal_set_title=no terminal_synchronized=yes terminal_change_colors=true terminal_assistant=cat terminal_enable_mouse=no
set-option -add global ui_options ncurses_set_title=false ncurses_wheel_done_button=0 ncurses_change_colors=true

# TODO make the modeline prettier
set-option global modelinefmt '{{mode_info}} / %val{bufname} [ %opt{filetype} ] / %val{cursor_line}:%val{cursor_char_column} {{context_info}} / %val{client}'

hook global BufOpenFile .* %{ modeline-parse }

colorscheme tron-legacy

hook global WinCreate .* %{ 
	try %{
		add-highlighter window/numbers number-lines -relative -hlcursor -separator '  '
		add-highlighter window/matching show-matching
		add-highlighter window/ranges show_matching_range
		add-highlighter window/search dynregex '%reg{/}' 0:search
		add-highlighter window/wrap wrap -word -indent
    	add-highlighter window/todo  regex \b(TODO|FIXME|HACK|PROJ|NOTE|IDEA)\b 0:default+rb
	}
}

set-option global matching_pairs ( ) [ ] { }


# ~~~ UX (I guess) ~~~
#

set-option global autoreload  yes

hook global WinCreate .* %{
    set-option window tabstop     4
    set-option window indentwidth 4
	set-option window aligntab false
}

hook global BufCreate .* %{ try %{ editorconfig-load } }

set-option global scrolloff   2,2

set-option global autoinfo command|onkey

set-option global disabled_hooks '(?!auto)(?!detect)\K(.+)-(trim-indent|insert|indent)'

set-option global writemethod replace


# ~~~ Completion ~~~
#

set-option global completers filename word=buffer


# ~~~ Commands ~~~
#

set-option global grepcmd 'rg -0 . --hidden --follow --no-heading --column --color=auto --smart-case'
set-option global makecmd 'make -j4'

