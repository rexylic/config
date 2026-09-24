function fish_right_prompt
    set -l last_status $status
    if test $last_status -ne 0
        set_color red
    else
        set_color green
    end
    echo $last_status
    set_color --reset
end
