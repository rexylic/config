function g --description 'github shorthand'
    argparse p/push a/amend -- $argv
    or return

    set -l msg $argv[1]
    set -l files $argv[2..-1]

    git add $files

    if set -q _flag_amend
        git commit --amend -m $msg
    else
        git commit -m $msg
    end

    if set -q _flag_push
        git push
    end
end
