function decrypt -d 'Decrypt using age' -w age
    age -d -o $argv[2] $argv[1]
end
