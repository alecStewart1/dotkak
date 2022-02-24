# ====# Keys #====
#


# --- Remappings ---
#

map global normal /       '/(?i)'
map global normal <a-/>   '<a-/>(?i)'
map global normal ?       '?(?i)'
map global normal <a-?>   '<a-?>(?i)'
map global normal -docstring 'save selection to register' z Z
map global normal -docstring 'restore selection(s) from register' Z z


# --- Cutting, Yanking, Pasting ---
#
# This is the most universal and sane option.
# So why I don't use a separate user-mode for this?
# Because neither does Vim or Emacs.
# Get over it, nerd.

map global normal d      '<a-|>xsel -i -b<ret>d'
map global normal D      '<a-l><a-|>xsel -i -b<ret>d'
map global normal c      '<a-|>xsel -i -b<ret>c'

map global normal y '<a-|>xsel -i -b<ret>'
map global normal Y 'X<a-|>xsel -i -b<ret><a-;>;' # Yea this is ugly. Sue me.

map global normal p '!xsel -o -b<ret>'
map global normal P '<a-!>xsel -o -b<ret>'


# --- Space is my leader (uh well user-mode) ---
#

map global normal <space>   ,        
map global normal ,         <space>  
map global normal <a-,>     <a-space>


# ~~~ Quit ~~~
#

declare-user-mode quitin

map global user 'q' ': enter-user-mode quitin<ret>' -docstring "quiting, saving, and such"

map global quitin 'q' ': quit!<ret>'           -docstring "try to quit Kakoune"
map global quitin 'w' ': write!<ret>'          -docstring "write"
map global quitin 'W' ': write-quit!<ret>'     -docstring "write and quit"
map global quitin 'a' ': write-all-quit!<ret>' -docstring "write and quit everything"


# ~~~ FZF ~~~
# TODO add more

declare-user-mode fuzzy

map global user 'f' ': enter-user-mode fuzzy<ret>' -docstring "fuzzy"

map global fuzzy 'f' ':connect popup kcr fzf files<ret>' -docstring "find file"
map global fuzzy 'b' ':connect popup kcr fzf buffers<ret>' -docstring "pick buffer"
map global fuzzy 'g' ':connect popup kcr fzf grep<ret>' -docstring "grep picker"


# ~~~ Buffers ~~~
#

declare-user-mode buffers

map global user 'b' ': enter-user-mode buffers<ret>' -docstring "buffers"

map global buffers 'd' ': delete-buffer!<ret>'           -docstring "delete current buffer"
map global buffers 'n' ': buffer-next<ret>'              -docstring "next buffer"
map global buffers 'j' ': buffer-next<ret>'              -docstring "next buffer"
map global buffers 'p' ': buffer-previous<ret>'          -docstring "prev buffer"
map global buffers 'k' ': buffer-previous<ret>'          -docstring "prev buffer"
map global buffers 'f' ': format-buffer<ret>'            -docstring "format buffer"
map global buffers 'l' ': lint-buffer<ret>'              -docstring "lint buffer"


# ~~~ "Windows" ~~~
#

declare-user-mode windows

map global user 'w' ': enter-user-mode windows<ret>' -docstring "windowing"

map global windows 's' ': kitty-terminal --location=hsplit<ret>' -docstring "split the 'window' horizontally"
map global windows 'v' ': kitty-terminal --location=vsplit<ret>' -docstring "split the 'window' vertically"
# TODO map global windows 't' ': kitty-terminal-tab kcr edit ${kak_buffile}' -docstring "open a terminal tab"


# --- Normal Keys ---
#


# --- Insert Keys ---
#

# ~~~ Some keys like Emacs has ~~~
# ~~~ someone is gonna be mad at me for these ~~~

map global insert <c-p> <up>
map global insert <c-n> <down>

map global insert <c-a> <home>
map global insert <c-e> <end>

map global insert <c-f> '<a-;>l'
map global insert <c-b> '<a-;>h'
map global insert <a-f> '<a-;>w'
map global insert <a-b> '<a-;>b'

 
# ~~~ jk for escpae ~~~
#

hook global InsertChar k %{
	try %{
		exec -draft hH <a-k>jk<ret> d
		exec <esc>
	}
}


# ~~~ Tab for complete ~~~
#

hook global InsertCompletionShow .* %{
	try %{
		execute-keys -draft 'h<a-K>\h<ret>'
		map window insert <tab>   <c-n>
		map window insert <s-tab> <c-p>
	}
}

hook global InsertCompletionHide .* %{
	unmap window insert <tab> <c-n>
	unmap window insert <s-tab> <c-p>
}


# ~~~ emmet for HTML ~~~

map global insert <a-e> "<esc>x:<space>emmet<ret>"

