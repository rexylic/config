# Brew
eval (brew shellenv)

# Paths
fish_add_path /opt/homebrew/opt/lldb/bin
fish_add_path /opt/homebrew/lib/ruby/gems/4.0.0/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin

# Variables
set -x EDITOR hx
set -x MOOR --no-linenumbers --no-statusbar --reformat --tab-size=2 --wrap
set -x PAGER moor
set -x XDG_CONFIG_HOME ~/.config

# Interactive session only
if status is-interactive
    # Brew completion
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end
    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end

    # Disable python virtual env display in prompt
    set VIRTUAL_ENV_DISABLE_PROMPT 1
end
