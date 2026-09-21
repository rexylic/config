function peek -w 'tee /dev/stderr' -d 'alias peek tee /dev/stderr'
    tee /dev/stderr $argv
end
