function radix --description 'Convert number between bases'
    set -l from $argv[1]
    set -l to $argv[2]
    set -l num (string upper $argv[3])
    echo "obase=$to; ibase=$from; $num" | bc
end
