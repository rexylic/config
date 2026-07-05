function peek --wraps='tee /dev/stderr' --description 'alias peek tee /dev/stderr'
    tee /dev/stderr $argv
end
