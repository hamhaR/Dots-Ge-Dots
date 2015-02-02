gameScene = director:createScene()

local background = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/white.png")
background.xAnchor = 0.5 
background.yAnchor = 0.5 
background.rotation = 180

-- Adding arrow back button
local arrow_back = director:createSprite(45, 435, "gfx/arrow_back.png")
arrow_back.xAnchor = 0.5 
arrow_back.yAnchor = 0.5

-- When click arrow back
-- Back to the main menu
function backToMainMenu(event)
  
  if event.phase == "ended" then
    -- Switch to game scene
    dofile("displayLevels.lua")
    director:moveToScene(levelScene)
  end
  
end

arrow_back:addEventListener("touch", backToMainMenu)

-- display 3x3 table
local arrow_back = director:createSprite(2, 90, "gfx/3x3table.png")
-- arrow_back.xAnchor = 0.5 
-- arrow_back.yAnchor = 0.5

