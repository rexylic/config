function ll --wraps=ls --wraps='eza --long --all --group --git --icons --time-style=relative --group-directories-first' --description 'alias ll eza --long --all --group --git --icons --time-style=relative --group-directories-first'
    eza --long --all --group --git --icons --time-style=relative --group-directories-first $argv
end
