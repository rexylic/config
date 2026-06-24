function up
    if test (count $argv) -eq 0
        cd ..
        return
    end
    set -l n $argv[1]
    if test $n -eq 0
        return
    end
    set -l path ""
    for i in (seq $n)
        set path $path"../"
    end
    cd $path
end
