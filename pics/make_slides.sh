#!/bin/bash

convert -crop 484x301+0+0 background.png bg_cropped.png
convert -resize x240 bg_cropped.png bg_scaled.png
convert -crop 320x240+0+0 bg_scaled.png bg_320x240.png

for F in d*.png
do
    convert $F -fuzz 75% -transparent white trans_$F
done

let I=0
for F in $(ls d* |LANG=C sort)
do
   let I=I+1
   II=$(printf "%02d" $I)
   convert -size 320x240 \
       -page +0+0  bg_320x240.png -page +0+0 trans_$F \
       -layers flatten ${II}_${F}
done

