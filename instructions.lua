
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require("physics")
local game1 = require("game1")
local game2 = require("game2")
local game3 = require("game3")
local game4 = require("game4")
local game5 = require("game5")
local params

-- local forward references should go here --

local function btnTap(event)
	--event.target.xScale = 0.95
	--event.target.yScale = 0.95
	storyboard.gotoScene (  event.target.destination, { time=333, effect = "fade"} )
	return true
end



 function catchBackgroundOverlay(event)
	return true 
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
  
  local backgroundOverlay = display.newImage ("images/instructionsBackground.jpg")
        backgroundOverlay:scale(1.2, 1.2)
        backgroundOverlay.x = 180
        backgroundOverlay.y = 300
				backgroundOverlay.isHitTestable = true
				backgroundOverlay:addEventListener ("tap", catchBackgroundOverlay)
				backgroundOverlay:addEventListener ("touch", catchBackgroundOverlay)
        group:insert (backgroundOverlay)
        
  --[[local instructions = display.newImageRect ("images/mechanics.png" ,400, 350)
				instructions.x = 250 
				instructions.y = 350
				params = event.params
				--instructions.destination = "menu"
				--instructions:addEventListener ("tap", btnTap)
				group:insert (instructions)
        ]]--
  local box = display.newRect(250, 350, 350, 320)
  box:setFillColor( black )
  group:insert(box)
  local instructions = display.newText(
    "       Move all the dots \n to the colored grid within \n      the given time limit. \n      Failure to do so \n    will make you lose \n            the game.. \n           Good luck!!!", display.contentCenterX, 200, "starcraft.ttf",30, center)
  instructions.x = 250
  instructions.y = 350
  instructions:setFillColor(1)
  group:insert(instructions)
        
  local mainMenu = display.newImageRect ("images/mainMenu.png" ,260, 50)
				mainMenu.x = 250 
				mainMenu.y = 770
				params = event.params
				mainMenu.destination = "menu"
				mainMenu:addEventListener ("tap", btnTap)
				group:insert (mainMenu)
        
   
end



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
--timer.resume(gameTimer)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	-- stop time here
	-- Remove listeners attached to the Runtime, timers, transitions

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
  --timer.resume(gameTimer)

end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )


---------------------------------------------------------------------------------

return scene