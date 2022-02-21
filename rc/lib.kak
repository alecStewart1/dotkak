# ====# Utilities for Kakoune #====
#

# Some of this is taken from:
# https://github.com/alexherbo2/lib.kak


# --- Move lines ---
# Reference: https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
define-command -override move-lines-down -docstring 'move line down' %{
  execute-keys -draft '<a-x><a-_><a-:>Z;ezj<a-x>dzP'
}

define-command -override move-lines-up -docstring 'move line up' %{
  execute-keys -draft '<a-x><a-_><a-:><a-;>Z;bzk<a-x>dzp'
}


# --- More Vim-like ---
#

define-command mkdir -docstring "UNIX mkdir command" -params 1 %{
    nop %sh{
    	mkdir -p "$1"
    }
}

define-command chmod -docstring "UNIX chmod command" -params .. -file-completion %{
    echo %sh{
    	chmod "$@" "$kak_buffile"
    }
}

define-command read -docstring %{
	TODO Fix!
	Like Vim's `:read`: Insert
	contents of <filename> 
	below the cursor's position.
} -params 1 -file-completion \
%{
	# Execute the commands in a temporary context,
	# where the registers will be restored.
	evaluate-commands -save-regs 'a|' %{
		# Store arguments into the `a` register.
		set-register a %arg{@}

		# Set the shell command to concatenate the files.
		set-register | %{
		  # Set the arg-list with the `a` register.
		  eval "set -- $kak_quoted_reg_a"

		  # Concatenate the files.
		  cat "$@"
		}
	}
}


# --- Find command ---
#

declare-option -docstring 'find command' str find_command 'fd --type file'

define-command -override find -menu -params 1 -shell-script-candidates %opt{find_command} -docstring 'open file' %{
  edit %arg{1}
}

alias global f find


# --- Automatically change directory ---
#

define-command autocd -docstring %{
    Command to change the directory to the
    location of the currently opened file.
} \
%{
    cd %sh{dirname $kak_buffile}
}

hook global BufOpenFile .* autocd
hook global WinCreate .* autocd
hook global WinDisplay .* autocd
hook global FocusIn .* autocd


# --- (Un)Tabify ---
#

define-command tabify -docstring "Convert all leading spaces to tabs" %{
    execute-keys -draft %{%s^\h+<ret><a-@>}
}

define-command untabify -docstring "Convert all leading tabs to spaces" %{
    execute-keys -draft %{%s^\h+<ret>@}
}


# --- (Un)Comment Selection ---
#

define-command comment-sel -docstring "Comment out a selection" %{
    execute-keys -draft %{s^<ret>i#<esc>,}
}

define-command uncomment-sel -docstring "Uncomment a selection" %{
    execute-keys -draft %{s^<ret>d,}
}


# --- REPL ---
#

# TODO maybe make better?

define-command repl -params .. -shell-completion \
-docstring %{
    repl <shell-command> <args>:
    Spawn a REPL for any shell command that supports it.
    Takes any arguments you pass.
    Makes use of `rlwrap`.
} \
%{
    evaluate-commands %sh {
        cmd="$1" 
        # unfortunately we have to use shift to get
        # the rest arguments, because POSIX shell
        # doesn't have arrays like Bash does.
        # So variable/string substitutions aren't possible.
        shift 
        rest_args="$@"
        printf %s "autocd"
        printf %s 'kitty-repl rlwrap "$cmd" "$rest_args"'
    }
}


# --- FileType Commands ---
# TODO


# --- X11 stuff ---
#

require-module x11


# --- More IDE-esque ---
#

define-command ide -docstring "Create clients for tools and docs." %{
    rename-client main
    set global jumpclient main

    new rename-client tools
    set global toolsclient tools

    new rename-client docs
    set global docsclient docs
}


# --- Aliases ---
#

alias global popup x11-terminal
alias global h doc
alias global bd delete-buffer
alias global qa quit
alias global qa! quit!
alias global wqa write-all-quit
alias global wqa! write-all-quit
alias global wq write-quit
alias global wq! write-quit!

