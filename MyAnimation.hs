-----------------------------------------------------------------------------
-- 
-- Name     :  Coursework for Functional Programming
-- Authors  :  Kavishan Prabarajah - acnj785 (kavishan.prabarajah@city.ac.uk)
--             Gianfranco Ripepi - acsc363 (gianfranco.ripepi@city.ac.uk )
--
-----------------------------------------------------------------------------
module MyAnimation where

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

-- x to cartesian function
xToCartesian :: Double -> Double -> Double -> Double
xToCartesian dist i n = dist*cos((pi*i)/n)

-- y to cartesian
yToCartesian :: Double -> Double -> Double -> Double
yToCartesian dist i n = dist*sin((pi*i)/n)

-- draw background
drawBG:: Animation
drawBG = withPaint (always gray) (rect (always xSize) (always ySize))

-- draw Cross at the origin
drawCross :: Animation
drawCross = 
    translate (always (-cHeight/2 , -cWidth/2))
        (withPaint (always black)
         (rect (always cHeight) (always cWidth)))
    `plus`
    translate (always (-cWidth/2 , -cHeight/2))
        (withPaint (always black)
         (rect (always cWidth) (always cHeight)))

-- Draw circles around the origin
drawCircles :: Animation
drawCircles = (combine
        -- x = radius of bigger circle * Cos theta
        -- y = radius of bigger circle * Sin theta
            [translate (always ((xToCartesian dist i 6), (yToCartesian dist i 6)))
                (combine 
                    [withGenPaint (always magenta) (always (a*0.25))
                        (circle (always (cRadius * (1-a))))
                    | a <- [0.1,0.2..1.0]])
            | i<- [1..maxCircles]])

-- draw invisible circle
drawInvisibleCircle :: Animation
drawInvisibleCircle = 
    (translate (cycleSteps disappear
        [((xToCartesian dist i 6), (yToCartesian dist i 6)) | i<-[1..maxCircles]])
            (withPaint (always gray) (circle (always cRadius))))

-- Animation to generate final picture
picture :: Animation
picture = 
    drawBG
    `plus`
    -- translate to centre (400, 300)
    translate (always (xSize/2, ySize/2))
    (translate (always (-cHeight/2 , -cWidth/2))
        drawCross
    `plus`
        drawCircles    
    `plus`
        drawInvisibleCircle
    )
        
test :: IO()
test = writeFile "test.svg" (svg xSize ySize picture)