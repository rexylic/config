function bu --description "Backup source to destination, merging paths"
    rsync \
        --archive \
        --human-readable \
        --partial \
        --progress \
        --one-file-system \
        $argv
end
