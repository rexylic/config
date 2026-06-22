function norm-audio
    if test (count $argv) -lt 1
        echo "Usage: norm-audio <input> [output] [target_lufs]"
        return 1
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

    echo "  input_i = $measured_i LUFS"
    echo "  target  = $target_lufs LUFS"

    set gain (math "$target_lufs - $measured_i")
    echo "  gain    = $gain dB"

    echo "Pass 2: applying gain -> $output"

    ffmpeg -i $input \
        -af 'volume='"$gain"'dB' \
        -c:v copy \
        $output

    echo "Done! Normalized to $target_lufs LUFS: $output"
end
