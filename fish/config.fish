eval "$(/opt/homebrew/bin/brew shellenv)"

fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/conda/bin

source ~/.venv/bin/activate.fish

fzf_configure_bindings --directory=ctrl-f

if status is-interactive
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
