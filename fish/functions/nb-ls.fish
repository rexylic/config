function nb-ls -d 'Write installed formulae and casks to config manifest'
    nb list | sort -o ~/.config/manifest $argv
end
