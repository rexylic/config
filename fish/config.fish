# Brew shellenv
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add path
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/conda/bin

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

    # Autoswitch light and dark mode
    set ALAC_CFG ~/.config/alacritty/alacritty.toml
    set HX_CFG ~/.config/helix/config.toml
    set BG (dark-notify -e)
    if [ $BG = dark ]
        sed -i 1 s/light/dark/ $HX_CFG $ALAC_CFG
    else
        sed -i 1 s/dark/light/ $HX_CFG $ALAC_CFG
    end
end
