function va --description 'Activate venv'
    for dir in .venv ~/.venv
        if test -f $dir/bin/activate.fish
            source $dir/bin/activate.fish
            return 0
        end
    end
    echo "va: no .venv found in current directory or home" >&2
    return 1
end
