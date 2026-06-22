function normalize-audio-volume
    if test (count $argv) -lt 1
        echo "Usage: normalize_audio.fish <input> [output] [target_lufs]"
        exit 1
    end

    set input $argv[1]
    set target_lufs (test (count $argv) -ge 3; and echo $argv[3]; or echo "-14")

    if test (count $argv) -ge 2
        set output $argv[2]
    else
        set ext (string match -r '[^.]+$' -- $input)
        set base (string replace -r '\.[^.]+$' '' -- $input)
        set output {$base}_normalized.$ext
    end

    echo "Pass 1: measuring loudness..."

    set json (ffmpeg -i $input \
        -af 'loudnorm=I='"$target_lufs"':TP=-1:LRA=11:print_format=json' \
        -f null - 2>&1 | grep -A 20 '{' | grep -B 20 '}' | head -21)

    set measured_i (echo $json | grep -o '"input_i" : "[^"]*"' | grep -o '[-0-9.]*')
    set measured_tp (echo $json | grep -o '"input_tp" : "[^"]*"' | grep -o '[-0-9.]*')
    set measured_lra (echo $json | grep -o '"input_lra" : "[^"]*"' | grep -o '[-0-9.]*')
    set measured_thresh (echo $json | grep -o '"input_thresh" : "[^"]*"' | grep -o '[-0-9.]*')

    echo "  input_i      = $measured_i LUFS"
    echo "  input_tp     = $measured_tp dBTP"
    echo "  input_lra    = $measured_lra LU"
    echo "  input_thresh = $measured_thresh LUFS"

    echo "Pass 2: applying normalization -> $output"

    ffmpeg -i $input \
        -af 'loudnorm=I='"$target_lufs"':TP=-1:LRA=11:measured_I='"$measured_i"':measured_TP='"$measured_tp"':measured_LRA='"$measured_lra"':measured_thresh='"$measured_thresh"':linear=true' \
        -c:v copy \
        $output

    echo "Done! Normalized to $target_lufs LUFS: $output"
end
