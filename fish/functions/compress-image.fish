function compress-image
    mogrify -resize 1000x1000\> **/*.jpg **/*.jpeg **/*.png
end
