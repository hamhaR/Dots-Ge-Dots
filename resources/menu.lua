
-- Create scene
-- global variable menuScene which holds our menu scene
menuScene = director:createScene()

-- Create background
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/white.png") 
background.xAnchor = 0.5 
background.yAnchor = 0.5 

local gameTitle = director:createSprite(director.displayCenterX, 400, "gfx/DotsGeDots.png")
gameTitle.xAnchor = 0.5 
gameTitle.yAnchor = 0.5 
-- gameTitle.color = color.violet
 
-- Building the menu we need a scene changer
-- Switch to specific scene
function switchToScene(scene_name)
  
  if (scene_name == "game") then
    dofile("startgame.lua")
    director:moveToScene(gameScene)
  end
 
end

-- Adding play game button
local playButton = director:createSprite(director.displayCenterX, 300, "gfx/playgame.png")
playButton.xAnchor = 0.5 
playButton.yAnchor = 0.5

-- Adding settings button
local settingsButton = director:createSprite(director.displayCenterX, 250, "gfx/settings.png")
settingsButton.xAnchor = 0.5 
settingsButton.yAnchor = 0.5

-- Adding about button
local aboutButton = director:createSprite(director.displayCenterX, 200, "gfx/about.png")
aboutButton.xAnchor = 0.5 
aboutButton.yAnchor = 0.5

-- Adding exit button
local exitButton = director:createSprite(director.displayCenterX, 150, "gfx/exit.png")
exitButton.xAnchor = 0.5 
exitButton.yAnchor = 0.5

-- Adding a function to call a new game
function newGame(event)
  
  if event.phase == "ended" then
    -- Switch to game scene
    switchToScene("game")
  end
  
end

playButton:addEventListener("touch", newGame)
-- settingsButton:addEventListener("touch", newGame)
-- aboutButton:addEventListener("touch", newGame)
-- exitButton:addEventListener("touch", newGame)