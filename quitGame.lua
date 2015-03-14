
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

local function quitGameTap(event)
  --os.exit() wala pa nahuman
end
timer.performWithDelay(1000,quitGameTap)

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
	

local overlay = display.newImage ("images/popupOverlay.png", 400 , 250)
				overlay.x = 300
				overlay.y = 400
				group:insert (overlay)
        
local header = display.newImageRect ("images/quitHeader.png", 400, 150)
				header.x = 230
				header.y = 250
				--message:addEventListener ("tap", nextBtnTap)
				group:insert(header)
local header2 = display.newImageRect ("images/sadEmoticon.png", 50, 50)
				header2.x = 100
				header2.y = 450
				--message:addEventListener ("tap", nextBtnTap)
				group:insert(header2)


local quitMessage = display.newImage("images/quitMessage.png", 700, 500)
        quitMessage.x = 250
        quitMessage.y = 400
        group:insert(quitMessage)

local quitGame = display.newImage("images/quitGame.png", 200, 150)
        quitGame.x = 100
        quitGame.y = 540
        quitGame:addEventListener("tap", quitGameTap)
        group:insert(quitGame)

local cancelBtn = display.newImageRect ("images/cancel.png", 230, 50)
				cancelBtn.x = 350
				cancelBtn.y = 540
				local function hideOverlay(event)
					storyboard.hideOverlay("fade", 800)
				end 
				cancelBtn:addEventListener ("tap", hideOverlay)
				group:insert(cancelBtn)
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