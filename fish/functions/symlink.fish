function symlink --wraps='ln -s' --description 'alias symlink ln -s'
    ln -s $argv
end
