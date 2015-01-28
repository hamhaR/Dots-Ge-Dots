gameScene = director:createScene()

local label = director:createLabel(0, 0, 'Display game levels')

local background = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/white.png")
background.xAnchor = 0.5 
background.yAnchor = 0.5 
background.rotation = 180

-- Adding start button
local arrow_back = director:createSprite(45, 430, "gfx/arrow_back.png")
arrow_back.xAnchor = 0.5 
arrow_back.yAnchor = 0.5

-- When click arrow back
-- Back to the main menu
function backToMainMenu(event)
  
  if event.phase == "ended" then
    -- Switch to game scene
    dofile("menu.lua")
    director:moveToScene(menuScene)
  end
  
end


arrow_back:addEventListener("touch", backToMainMenu)