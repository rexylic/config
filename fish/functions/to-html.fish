function to-html -w pandoc -d 'Convert markdown to HTML'
    pandoc --template template -o "$argv[1].html" "$argv[1].md" $argv[2..]
end
