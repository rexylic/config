function unzip-pp
    set archive $argv[1]
    unzip -d (basename $archive .zip) $archive
end
