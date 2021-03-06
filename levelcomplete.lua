-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require("physics")
local game1 = require("game1")
local game2 = require("game2")
local game3 = require("game3")
local game4 = require("game4")
local game5 = require("game5")
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
	

local overlay = display.newImage ("images/overlayv2.png", 400 , 500)
				overlay.x = 300
				overlay.y = 400
				group:insert (overlay)

local resumeBtn = display.newImageRect ("images/resumeBtn.png", 230, 50)
				resumeBtn.x = 250
				resumeBtn.y = 350
				local function hideOverlay(event)
					storyboard.hideOverlay("fade", 800)
				end 
        
				resumeBtn:addEventListener ("tap", hideOverlay)
				group:insert(resumeBtn)

local reloadBtn = display.newImageRect ("images/reload.png" ,250, 50)
				reloadBtn.x = 250 
				reloadBtn.y = 420
				params = event.params
				reloadBtn.destination = "game2"
				reloadBtn:addEventListener ("tap", btnTap)
				group:insert (reloadBtn)
        
local mainMenu = display.newImageRect ("images/mainMenu.png" ,250, 50)
				mainMenu.x = 250 
				mainMenu.y = 510
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