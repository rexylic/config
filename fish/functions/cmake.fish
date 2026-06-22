function cmake
    if not contains -- --prefix $argv; and not string match -q -- '*CMAKE_INSTALL_PREFIX*' $argv
        command cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local $argv
    else
        command cmake $argv
    end
end
