module CW where

import Animation

pic :: Animation
pic = translate (always (400, 300)
    (withPaint (always gray)
        (rect (always 800) (always 600))
    `plus`
    translate (always (0, -17.5))
        (rect (always 4) (always 35)) 
    `plus`
    translate (always (-17.5, 0))
        (rect (always 35) (always 4))
    `plus`
    rotate (spinner 36)
        (translate (always (250, 0))
            (withPaint (always fuchsia) (circle (always 20))))

save :: IO()
save = writeFile "lilac.svg" (svg 800 600 pic)