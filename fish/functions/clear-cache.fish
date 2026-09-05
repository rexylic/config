function clear-cache --wraps='rm -rf ~/.cache' --description 'alias clear-cache rm -rf ~/.cache'
    rm -rf ~/.cache $argv
end
