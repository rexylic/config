eval "$(/opt/homebrew/bin/brew shellenv)"
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/conda/bin

if status is-interactive
    # Autoswitch light and dark mode
    set ALAC_CFG ~/.config/alacritty/alacritty.toml
    set HX_CFG ~/.config/helix/config.toml
    set BG (dark-notify -e)
    if [ $BG = dark ]
        sed -i 1 s/light/dark/ $ALAC_CFG $HX_CFG
    else
        sed -i 1 s/dark/light/ $ALAC_CFG $HX_CFG
    end
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/rfang/.local/conda/bin/conda
    eval /Users/rfang/.local/conda/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/Users/rfang/.local/conda/etc/fish/conf.d/conda.fish"
        . "/Users/rfang/.local/conda/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/rfang/.local/conda/bin" $PATH
    end
end
# <<< conda initialize <<<
