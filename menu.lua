local storyboard = require("storyboard")
local scene = storyboard.newScene()

local function startButtonHit(event)
  storyboard.gotoScene("game_levels", {effect="slideLeft"})
  return true
end

local function settingsButtonHit(event)
  storyboard.gotoScene("settings", {effect="slideUp"})
  return true
end

local function instructionButtonHit(event)
  storyboard.gotoScene("instructions", {effect="slideRight"})
  return true
end

local function exitButtonHit(event)
  storyboard.showOverlay( "quitGame" ,{effect = "fade"  ,  params ={levelNum = "menu"}, isModal = true} )
  return true
end

-- called when the scene's view does not exist
function scene:createScene(event)
  local group = self.view
 
  
  local gameTitle = display.newText( "Dots Ge Dots", 100, 100, "Helvetica", 65 )
  gameTitle.x = display.contentCenterX
  gameTitle.y = display.contentCenterY - 200
  group:insert( gameTitle )
 
  local startButton = display.newText( "Play Game", 0, 0, native.systemFont, 50 )
  startButton.x = display.contentCenterX
  startButton.y = display.contentCenterY - 65
  --startButton.goto("game_levels")
  startButton:addEventListener( "tap", startButtonHit )
  group:insert( startButton )
  
  local settingsButton = display.newText( "Settings", 0, 0, native.systemFont, 50 )
  settingsButton.x = display.contentCenterX
  settingsButton.y = display.contentCenterY - 5
  --settingsButton.goto("settings")
  settingsButton:addEventListener( "tap", settingsButtonHit )
  group:insert( settingsButton )
  
  local aboutButton = display.newText( "Instructions", 0, 0, native.systemFont, 50 )
  aboutButton.x = display.contentCenterX
  aboutButton.y = display.contentCenterY + 55
  --aboutButton.goto("about")
  aboutButton:addEventListener( "tap", instructionButtonHit )
  group:insert( aboutButton )
  
  local exitButton = display.newText( "Exit", 0, 0, native.systemFont, 50 )
  exitButton.x = display.contentCenterX
  exitButton.y = display.contentCenterY + 115
  exitButton:addEventListener("tap", exitButtonHit)
  group:insert( exitButton )
  
end

function scene:enterScene(event)
  local group = self.view
end

function scene:exitScene(event)
  local group = self.view
end

function scene:destroyScene( event )

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene