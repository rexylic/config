function squarify
    set margin 128

    for in in $argv
        set ext (string split -r -m1 . -- $in)[2]
        set base (string split -r -m1 . -- $in)[1]
        set out "$base.squared.$ext"

        set wh (magick identify -format "%w %h" $in | string split " ")
        set w $wh[1]
        set h $wh[2]

        if test $w -gt $h
            set max_dim $w
        else
            set max_dim $h
        end

        set scale (math "2560 / $max_dim")
        set nw (math --scale=0 "round($w * $scale)")
        set nh (math --scale=0 "round($h * $scale)")

        if test $nw -gt $nh
            set side_base $nw
        else
            set side_base $nh
        end
        set side (math "$side_base + 2 * $margin")

        magick $in -resize "2560x2560>" -gravity center -background white -extent "$side"x"$side" $out
        echo "✓ $in → $out (•‿•)"
    end
end
