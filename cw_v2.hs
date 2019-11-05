module CW where

import Animation

pic :: Animation
pic = withPaint (always gray)
    (rect (always 800) (always 600))
    `plus`
    translate (always (400, 285))
        (rect (always 5) (always 40)) 
    `plus`
    translate (always (385, 300))
        (rect (always 35) (always 5))
    -- `plus`

save :: IO()
save = writeFile "lilac.svg" (svg 800 600 pic)