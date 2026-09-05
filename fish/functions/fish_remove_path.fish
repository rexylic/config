function remove_path
    if set -l index (contins -i "$argv" $fish_user_paths)
        set -e fish_user_paths[$index]
        echo "Removed $argv from path"
    end
end
