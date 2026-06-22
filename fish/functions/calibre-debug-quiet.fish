function calibre-debug-quiet
    calibre-debug -g 2>&1 | rg -v 'SyntaxWarning|invalid escape sequence'
end
