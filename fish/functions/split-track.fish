function split-track --description 'Split an audio file into tracks based on a timestamp file'
    if test (count $argv) -lt 2
        echo "Usage: split-track <audio-file> <timestamps-file> [output-dir]"
        return 1
    end

    set -l audio_file $argv[1]
    set -l timestamps_file $argv[2]
    set -l output_dir (test (count $argv) -ge 3; and echo $argv[3]; or echo "tracks")

    if not test -f $audio_file
        echo "Error: audio file '$audio_file' not found"
        return 1
    end

    if not test -f $timestamps_file
        echo "Error: timestamps file '$timestamps_file' not found"
        return 1
    end

    mkdir -p $output_dir

    set -l extension (string split -r -m1 . $audio_file)[2]

    # Read all lines into arrays
    set -l starts
    set -l titles
    while read -l line
        # Skip empty lines
        test -z (string trim $line); and continue

        set -l ts (string match -r '^\S+' $line)
        set -l raw_title (string trim (string replace -r '^\S+\s*' '' $line))

        # Strip leading track-number prefixes like "01 - ", "01. ", "01) ", "01 "
        set -l clean_title (string replace -r '^\d+\s*[-.\)]?\s*' '' $raw_title)

        set -a starts $ts
        set -a titles $clean_title
    end <$timestamps_file

    set -l count (count $starts)
    if test $count -eq 0
        echo "Error: no timestamps found in '$timestamps_file'"
        return 1
    end

    for i in (seq $count)
        set -l start $starts[$i]
        set -l title $titles[$i]
        set -l index (printf "%02d" $i)

        # Sanitize title for filename
        set -l safe_title (string replace -ra '[/\\\\:*?"<>|]' '_' $title)
        set -l output_file "$output_dir/$index - $safe_title.$extension"

        set -l next (math $i + 1)
        if test $next -le $count
            set -l end $starts[$next]
            echo "Extracting [$index] $title ($start -> $end)"
            ffmpeg -hide_banner -loglevel error -y -i $audio_file \
                -ss $start -to $end \
                -c copy \
                -metadata title=$title \
                -metadata track=$i/$count \
                $output_file
        else
            echo "Extracting [$index] $title ($start -> end)"
            ffmpeg -hide_banner -loglevel error -y -i $audio_file \
                -ss $start \
                -c copy \
                -metadata title=$title \
                -metadata track=$i/$count \
                $output_file
        end
    end

    echo "Done. Tracks written to '$output_dir/'"
end
