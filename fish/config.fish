# Config brew
eval (brew shellenv)

# Interactive session only
if status is-interactive
    # Fuzzy finder binding
    fzf_configure_bindings --directory=ctrl-f

    # Set prompt icon
    set tide_character_icon '$'
end
