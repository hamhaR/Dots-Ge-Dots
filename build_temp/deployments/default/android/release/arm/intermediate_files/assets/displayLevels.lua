levelScene = director:createScene()

-- local label = director:createLabel(0, 0, 'Display game levels')

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
    dofile("menu.lua")
    director:moveToScene(menuScene)
  end
  
end

arrow_back:addEventListener("touch", backToMainMenu)

-- Adding next button button
local next_button = director:createSprite(270, 435, "gfx/arrow_next.png")
next_button.xAnchor = 0.5 
next_button.yAnchor = 0.5

function startGame(event)
  
  if event.phase == "ended" then
    -- Switch to game scene
    dofile("startgame.lua")
    director:moveToScene(gameScene)
  end
  
end

next_button:addEventListener("touch", startGame)