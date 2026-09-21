function mkcd -d "Make and enter new directory"
    mkdir -p $argv[1] && cd $argv[1]
end
