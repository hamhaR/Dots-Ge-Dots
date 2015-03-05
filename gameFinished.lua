
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require("physics")
local game2 = require("game2")
local params

local centerX = display.contentCenterX 
local centerY = display.contentCenterY

-- local forward references should go here --

local function btnTap(event)
	event.target.xScale = 0.95
	event.target.yScale = 0.95
	storyboard.gotoScene (  event.target.destination, { params ={levelNum = params.levelNum}, time=333, effect = "fade"} )
	return true
end

 function catchBackgroundOverlay(event)
	return true 
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

local backgroundOverlay = display.newRect (group, 0, 0, 1200, 1700)
				backgroundOverlay:setFillColor( black )
				backgroundOverlay.alpha = 0.6
				backgroundOverlay.isHitTestable = true
				backgroundOverlay:addEventListener ("tap", catchBackgroundOverlay)
				backgroundOverlay:addEventListener ("touch", catchBackgroundOverlay)
	
-- change pause to Congratulations
--if params.levelNum ~= "game5" then
	local overlay = display.newImage ("images/popupOverlay.png", 400 , 500)
					overlay.x = 300
					overlay.y = 400
					group:insert (overlay)
--end
local message = display.newImageRect ("images/success.png", 420, 150)
				message.x = 250
				message.y = 250
				--message:addEventListener ("tap", nextBtnTap)
				group:insert(message)

local message2 = display.newImageRect ("images/message2.png", 350, 180)
				message2.x = 250
				message2.y = 440
				--message:addEventListener ("tap", nextBtnTap)
				group:insert(message2)
        
local mainMenu = display.newImageRect ("images/mainMenu.png" ,250, 50)
				mainMenu.x = 250 
				mainMenu.y = 580
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
  timer.resume(gameTimer)

	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

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