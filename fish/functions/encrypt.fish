function encrypt -d 'Encrypt using age' -w age
    age -p -o $argv[2] $argv[1]
end
