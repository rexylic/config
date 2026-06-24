function lc -d 'List and change directory'
    if test (count $argv) -gt 0
        if test $argv[1] -eq 0
            cd (fd --type d | fzf)
        else
            cd (fd --type d --max-depth $argv[1] | fzf)
        end
    else
        cd (fd --type d --max-depth 1 | fzf)
    end
end
