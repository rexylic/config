function nb-ls --wraps='nb list | sort -o ~/.config/nanobrew/bundle' --description 'alias nb-ls nb list | sort -o ~/.config/manifest'
    nb list | sort -o ~/.config/manifest $argv
end
