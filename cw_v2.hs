module CW where

import Animation

save :: IO()
save = writeFile "lilac.svg" (svg 800 600 pic)