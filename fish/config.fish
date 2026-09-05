# Add path
fish_add_path /opt/homebrew/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin

# Setup mise
mise activate fish | source

# Interactive session only
if status is-interactive
    # Fuzzy finder binding
    fzf_configure_bindings --directory=ctrl-f

    # Set prompt icon
    set tide_character_icon '$'
end
