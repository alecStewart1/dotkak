# ====# My Kakoune Config #====

# --- Activate kakoune.cr and kak-lsp ---

try %sh{
	kcr init kakoune
	kak-lsp --kakoune --session "$kak_session"
}

# --- Source other configurations ---

evaluate-commands %sh{
	config_files="
		lib.kak
		settings.kak
		keys.kak        
		plugins.kak
	"
	for f in $config_files; do
		printf "%s" "
			try %{
				source %{$kak_config/rc/$f}
			} catch %{
				echo -debug %val{error}
			}
		"
	done
}
