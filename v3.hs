-----------------------------------------------------------------------------
-- 
-- Name     :  Coursework for Functional Programming
-- Authors  :  Kavishan Prabarajah - kavishn.prabarajah@city.ac.uk
--             Gianfranco Ripepi -
--
-----------------------------------------------------------------------------
module CW where

import Animation

-- Cross width and height
cWidth = 5
cHeight = 40
-- circleRadius
cRadius = 40
-- display region
xSize = 800
ySize = 600
-- distance from non true origin (400,300)
dist = 250
-- maxCircles
maxCircles = 12
-- so the circles would be 30 degrees apart from each other

-- circle disappearnce time 
-- https://en.wikipedia.org/wiki/Lilac_chaser
disappear = 0.1

-- !todo calculate the centre coordinates 
-- trueMidPoint = cHeight/2 - 0.5


pic :: Animation
pic = 
    -- background
    withPaint (always gray) 
        (rect (always xSize) (always ySize))
    `plus`
    -- translate to centre (400, 300)
    translate (always (xSize/2, ySize/2))
    -- cross
    (translate (always (-cHeight/2 , -cWidth/2))
        (withPaint (always black)
            (rect (always cHeight) (always cWidth)))
    `plus`
    translate (always (-cWidth/2 , -cHeight/2))
    (withPaint (always black)
        (rect (always cWidth) (always cHeight)))
    `plus`
    -- circles
    -- withGenPaint (always magenta) (always 0.75) 
        (combine
        -- x = radius of bigger circle * Cos theta
        -- y = radius of bigger circle * Sin theta
            [translate (always (dist* cos((pi*i)/6), dist*sin((pi*i)/6)))
                (combine 
                    [withGenPaint (always magenta) (always a)
                        (circle (always (cRadius * (1-a))))
                    | a <- [0.1,0.2..1.0]])
            | i<- [1..maxCircles]])
    `plus`
    -- invisible circle
    translate (cycleSteps disappear
        [(dist* cos((pi*i)/6), dist*sin((pi*i)/6)) | i<- [1..maxCircles]])
            (withPaint (always gray) (circle (always cRadius)))
        )


        
gen :: IO()
gen = writeFile "output.svg" (svg xSize ySize pic)