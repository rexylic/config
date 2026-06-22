function split --description 'Split an audio file into multiple files given time points and names'
    argparse 'r=' 'l=' 'f=' -- $argv
    or begin
        echo "Usage: split [-r artist] [-l album] [-f tracklist] <input.m4a> [<time1> <name1> ...]"
        echo "  Example: split -r 'John Doe' -l 'My Album' bigmusic.m4a 0:00 'first' 2:47 'second one' 8:56 'third one'"
        echo "  Example: split -r 'John Doe' -l 'My Album' -f tracks.txt bigmusic.m4a"
        return 1
    end

    set input $argv[1]

    if not test -f "$input"
        echo "Error: file '$input' not found."
        return 1
    end

    set ext (string split -r -m1 . $input)[2]
    set basename (string split -r -m1 . (path basename $input))[1]
    set outdir $basename
    mkdir -p $outdir

    set times
    set names

    if set -q _flag_f
        if not test -f "$_flag_f"
            echo "Error: tracklist file '$_flag_f' not found."
            return 1
        end
        while read -la line
            set timestamp (string split -m1 ' ' $line)[1]
            set title (string trim -r (string split -m1 ' ' $line)[2])
            set -a times $timestamp
            set -a names $title
        end <$_flag_f
    else
        set rest $argv[2..]
        if test (count $argv) -lt 3
            echo "Error: not enough arguments."
            return 1
        end
        if test (math (count $rest) % 2) -ne 0
            echo "Error: time/name arguments must come in pairs."
            return 1
        end
        set i 1
        while test $i -le (count $rest)
            set -a times $rest[$i]
            set -a names $rest[(math $i + 1)]
            set i (math $i + 2)
        end
    end

    set n (count $times)

    set cover /tmp/_split_cover.jpg
    ffmpeg -hide_banner -loglevel error -i $input -an -vcodec copy $cover 2>/dev/null

    for i in (seq 1 $n)
        set start $times[$i]
        set name $names[$i]
        set out "$outdir/$name.$ext"

        set meta -metadata track="$i/$n"
        set -q _flag_r; and set -a meta -metadata artist="$_flag_r"
        set -q _flag_l; and set -a meta -metadata album="$_flag_l"

        if test $i -lt $n
            set end $times[(math $i + 1)]
            echo "[$i/$n] '$out'  ($start → $end)"
            if test -f $cover
                ffmpeg -hide_banner -loglevel error \
                    -i $input -i $cover \
                    -ss $start -to $end \
                    -map 0:a -map 1:v \
                    -c copy \
                    -disposition:v:0 attached_pic \
                    $meta \
                    $out
            else
                ffmpeg -hide_banner -loglevel error \
                    -i $input \
                    -ss $start -to $end \
                    -map 0:a \
                    -c copy \
                    $meta \
                    $out
            end
        else
            echo "[$i/$n] '$out'  ($start → end)"
            if test -f $cover
                ffmpeg -hide_banner -loglevel error \
                    -i $input -i $cover \
                    -ss $start \
                    -map 0:a -map 1:v \
                    -c copy \
                    -disposition:v:0 attached_pic \
                    $meta \
                    $out
            else
                ffmpeg -hide_banner -loglevel error \
                    -i $input \
                    -ss $start \
                    -map 0:a \
                    -c copy \
                    $meta \
                    $out
            end
        end
    end

    test -f $cover; and rm $cover
    echo "Done. $n file(s) written to '$outdir/'."
end
