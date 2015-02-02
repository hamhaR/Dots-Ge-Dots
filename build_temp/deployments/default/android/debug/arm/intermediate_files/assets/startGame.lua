gameScene = director:createScene()

local background = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/white.png")
background.xAnchor = 0.5 
background.yAnchor = 0.5 
background.rotation = 180

-- display 3x3 table
local arrow_back = director:createSprite(2, 100, "gfx/3x3table.png")
-- arrow_back.xAnchor = 0.5 
-- arrow_back.yAnchor = 0.5