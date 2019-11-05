module CW where

import Animation

pic :: Animation
pic = 
    -- background
    withPaint (always gray)
    (rect (always 800) (always 600))
    `plus`
    translate (always (425, 250))
        (rect (always 5) (always 35)) 
    `plus`
    translate (always (410, 265))
        (rect (always 35) (always 5))
    `plus`
    translate (always (425, 275))
        (combine 
            [translate (always (200*sin((pi / 3.0) * (i / 2.0)), 200*cos((pi / 3.0) * (i / 2.0))))
                (withPaint (always fuchsia) ((circle (always 20))))
            | i <- [1..12]])
    `plus`
    translate (always (425, 275))
        (translate (cycleSmooth 0.5
            [(200*sin((pi / 3.0) * (i / 2.0)), 200*cos((pi / 3.0) * (i / 2.0))) | i <- [1..12]])
        (withPaint (always gray) (circle (always 20))))

save :: IO()
save = writeFile "lilac.svg" (svg 800 600 pic)