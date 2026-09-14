function to-html --wraps=pandoc --description 'Convert markdown to HTML'
    pandoc --template template -o "$argv[1].html" "$argv[1].md" $argv[2..]
end
