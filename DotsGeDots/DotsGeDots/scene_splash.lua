local storyboard = require("storyboard")
local scene = storyboard.createScene()

function scene:createScene( event )
  local group = self.view
 
  local gameTitle = display.newText( "My Game", 100, 100, native.systemFontBold, 36 )
  gameTitle.x = display.contentCenterX
  gameTitle.y = display.contentCenterY - 20
 
  group:insert( gameTitle )
 
  local startButton = display.newText( "Start", 0, 0, native.systemFont, 18 )
  startButton.x = display.contentCenterX
  startButton.y = display.contentCenterY + 80
 
  local function onTap( event )
    --storyboard.gotoScene( "scene_menu" )
  end
  startButton:addEventListener( "tap", onTap )
 
  group:insert( startButton )
 
end