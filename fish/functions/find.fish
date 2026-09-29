function find --wraps='rg -.l 2>/dev/null' --description 'alias find rg -.l 2>/dev/null'
    rg -.l 2>/dev/null $argv
end
