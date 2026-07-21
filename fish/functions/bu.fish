function bu -d "Backup source to destination, merging paths" -w rsync
    rsync -ahLPx $argv
end
