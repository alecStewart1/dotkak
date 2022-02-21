# ====# Plugins #====
#


# --- Installation of plugin manager ---
#

evaluate-commands %sh{
	plugins="$XDG_CONFIG_HOME/kak/plugins"
	mkdir -p "$plugins"
	[ ! -e "$plugins" ] && \
		git clone -q https://github.com/andreyorst/plug.kak "$plugins/plug.kak"
	printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}


# --- Enchancements ---
#

plug-chain "andreyorst/plug.kak" noload config %{
	set-option global plug_max_active_downloads 16
	set-option global plug_always_ensure true
} plug "gustavo-hms/luar" %{
	set-option global luar_interpreter luajit
	plug "gustavo-hms/peneira" %{
		require-module peneira
	}
} plug "Screwtapello/kakoune-state-save" domain "gitlab.com" config %{
	hook global KakBegin .* %{
		state-save-reg-load colon
		state-save-reg-load pipe
		state-save-reg-load slash
	}

	hook global KakEnd .* %{
		state-save-reg-save colon
		state-save-reg-save pipe
		state-save-reg-save slash
	}

	hook global FocusOut .* %{ state-save-reg-save dquote }
	hook global FocusIn  .* %{ state-save-reg-load dquote }
} plug "https://gitlab.com/kstr0k/mru-files.kak.git" domain "gitlab.com" demand mru-files %{
	set-option global mru_files_history %sh{ echo "$HOME/.local/share/kak/mru.txt" }
} config %{
	require-module kakhist; kakhist-init 
	map global goto ':' '<esc>: kakhist-buf-show<ret>' -docstring "show command history"
	map global fuzzy 'r' '<esc>: mru-files<ret>' -docstring "recent files"
} 


# --- Moving ---
#

plug-chain "occivink/kakoune-vertical-selection" config %{
	declare-user-mode vertical

	map global user 'v' ': enter-user-mode vertical<ret>' -docstring "vertical selection"

	map global vertical 'j' ': vertical-selection-down<ret>'        -docstring "down"
	map global vertical 'k' ': vertical-selection-up<ret>'          -docstring "up"
	map global vertical 'V' ': vertical-selection-up-and-down<ret>' -docstring "up and down"
} plug "danr/kakoune-easymotion" config %{
	declare-user-mode ez

	map global user 'g' ': enter-user-mode ez<ret>' -docstring "easymotion"

	map global ez 'l' ': easy-motion-line<ret>'  -docstring "goto line"
	map global ez 'w' ': easy-motion-w<ret>'     -docstring "forward word"
	map global ez 'W' ': easy-motion-W<ret>'     -docstring "forward WORD"
	map global ez 'b' ': easy-motion-b<ret>'     -docstring "backward word"
	map global ez 'B' ': easy-motion-B<ret>'     -docstring "backward WORD "
	map global ez 'f' ': easy-motion-f<ret>'     -docstring "forward char"
	map global ez 'F' ': easy-motion-alt-f<ret>' -docstring "forward CHAR"
} 


# --- Editing ---
#

plug-chain "delapouite/kakoune-text-objects" \
plug "occivink/kakoune-sudo-write" \
plug "listentolist/kakoune-table" domain "gitlab.com" \
plug "Screwtapello/kakoune-inc-dec" domain "gitlab.com" config %{
	map -docstring "decrement selection" global normal <c-c> \
	': inc-dec-modify-numbers + %val{count}<ret>'

	map -docstring "increment selection" global normal <c-x> \
	': inc-dec-modify-numbers - %val{count}<ret>'
} 


# --- Coding ---
#

plug-chain "ul/kak-tree" do %{
	cargo install --force --path . --features "bash c cpp c_sharp css html javascript json julia python ruby rust typescript"
} %{
	declare-user-mode tree
	
	map global user 't' ': enter-user-mode tree<ret>' -docstring "tree-sitter"
	map global tree h ': tree-select-previous-node<ret>' -docstring 'select previous'
	map global tree l ': tree-select-next-node<ret>' -docstring 'select next'
	map global tree k ': tree-select-parent-node<ret>' -docstring 'select parent'
	map global tree j ': tree-select-children<ret>' -docstring 'select children'
	map global tree f ': tree-select-first-child<ret>' -docstring 'select first child'
	map global tree s ': tree-node-sexp<ret>' -docstring 'show info'
	map global user t ': enter-user-mode tree<ret>' -docstring 'tree mode'
	map global normal þ ': enter-user-mode -lock tree<ret>' -docstring 'tree mode lock'
} plug "ul/kak-lsp" do %{
    cargo build --release --locked
    cargo install --force --path . --locked
    cargo clean
} config %{
	
    set-option global lsp_cmd "kak-lsp -vvv -c $HOME/.config/kak-lsp/kak-lsp.toml -s %val{session} --log $HOME/.config/kak-lsp/kak-lsp.log"

    set-option global lsp_completion_trigger "execute-keys 'h<a-h><a-k>\S[^\s,=;*(){}\[\]]\z<ret>'"
    set-option global lsp_diagnostic_line_error_sign "!"
    set-option global lsp_diagnostic_line_warning_sign "?"
    hook global WinSetOption filetype=(c|cpp|objc|nim|crystal|python|latex|javascript|typescript) %{

    	echo -debug "Enabling LSP for filtetype %opt{filetype}"
    	lsp-enable-window
    	
		lsp-auto-hover-enable
    	lsp-auto-hover-insert-mode-disable

        lsp-inlay-diagnostics-enable window
        hook window -group inlay-diagnostics ModeChange (push|pop):.*:insert %{
            lsp-inlay-diagnostics-disable window
        }
        hook window -group inlay-diagnostics ModeChange (push|pop):insert:.* %{
            lsp-inlay-diagnostics-enable window
        }

       	set-option global lsp_auto_highlight_references true
    	set-option global lsp_hover_anchor true
    	
        # Semantic highlighting
    	# TODO maybe there's more servers that support this 
        hook -once global WinSetOption filetype=rust %{ 

            hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
        	hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
        	hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens

        	hook -once -always window WinSetOption filetype=.* %{
        		 remove-hooks window semantic-tokens
        	}
        }
    	
    	# Other things
    	#hook window BufWritePre .* lsp-formatting-sync # this breaks shit
    	hook window BufWritePost .* lsp-diagnostics
    	hook -always global KakEnd .* lsp-exit
        hook global WinSetOption filetype=rust %{
            set-option window lsp_server_configuration rust.clippy_preference="on"
        }
    }
} plug 'jjk96/kakoune-rainbow' \  
plug "JJK96/kakoune-emmet" defer emmet \

