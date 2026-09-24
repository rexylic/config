# Brew
eval (brew shellenv)

# Paths
fish_add_path "$(gem env gemdir)/bin"
fish_add_path /opt/homebrew/opt/lldb/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin

# Variables
set EDITOR hx
set PAGER moor --no-linenumbers --tab-size=2 --wrap
set XDG_CONFIG_HOME ~/.config

# Interactive session only
if status is-interactive
    set VIRTUAL_ENV_DISABLE_PROMPT 1
end
