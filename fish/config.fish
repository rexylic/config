# Config brew
eval (brew shellenv)

# Add local paths
fish_add_path ~/.local/bin

# Add cargos
fish_add_path ~/.cargo/bin

# Interactive session only
if status is-interactive
    # Fuzzy finder binding
    fzf_configure_bindings --directory=ctrl-f

    # Set prompt icon
    set tide_character_icon '$'
end
