function compress-image -d "Compress image to at most 1000 pixels tall/wide"
    mogrify -resize 1000x1000\> **/*.jpg **/*.jpeg **/*.png
end
