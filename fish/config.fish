# Brew shellenv
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add path
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin

if status is-interactive
    # Brew autocompletion
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end
    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end

    # Fuzzy finder binding
    fzf_configure_bindings --directory=ctrl-f

    # Set prompt icon
    set tide_character_icon '$'
end
