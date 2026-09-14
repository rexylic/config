# Add nanobrew paths
fish_add_path /opt/nanobrew/prefix/bin
fish_add_path /opt/nanobrew/prefix/lib/ruby/gems/4.0.0/bin

# Add local paths
fish_add_path ~/.local/bin
fish_add_path ~/.local/share/gem/ruby/4.0.0/bin

# Add cargos
fish_add_path ~/.cargo/bin

# Interactive session only
if status is-interactive
    # Fuzzy finder binding
    fzf_configure_bindings --directory=ctrl-f

    # Set prompt icon
    set tide_character_icon '$'
end
