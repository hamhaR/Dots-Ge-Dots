

function scene:createScene( event )
  local group = self.view
 
  local loadButton = display.newText( "Load Level 1", 0, 0, native.systemFont, 18 )
  loadButton.x = display.contentCenterX
  loadButton.y = display.contentCenterY
 
--[[
  local function onTap( event )
    storyboard.gotoScene( "game" )
  end
  loadButton:addEventListener( "tap", onTap )
 
  group:insert( loadButton )
--]]
end
