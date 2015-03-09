
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

--proceed to next level
local function nextBtnTap(event)
	if params.levelNum == "game1" then
		storyboard.gotoScene("game2", {time=333, effect="crossFade"})
	elseif params.levelNum == "game2" then
		storyboard.gotoScene("game3", {time=333, effect="crossFade"})
	elseif params.levelNum == "game3" then
		storyboard.gotoScene("game4", {time=333, effect="crossFade"})
	elseif params.levelNum == "game4" then
		storyboard.gotoScene("game5", {time=333, effect="crossFade"})
  elseif params.levelNum == "game5" then
		storyboard.gotoScene("gameFinished", {time=333, effect="crossFade"})
	end
	return true
end

--reload level
local function reloadBtnTap(event)
	storyboard.purgeScene(params.levelNum)
	if params.levelNum == "game1" then
		storyboard.gotoScene("game1", {time=333, effect="crossFade"})
	elseif params.levelNum == "game2" then
		storyboard.gotoScene("game2", {time=333, effect="crossFade"})
	elseif params.levelNum == "game3" then
		storyboard.gotoScene("game3", {time=333, effect="crossFade"})
	elseif params.levelNum == "game4" then
		storyboard.gotoScene("game4", {time=333, effect="crossFade"})
  elseif params.levelNum == "game5" then
		storyboard.gotoScene("game5", {time=333, effect="crossFade"})
	end
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
local message = display.newImageRect ("images/levelCompleted.png", 420, 150)
				message.x = 250
				message.y = 270
				--message:addEventListener ("tap", nextBtnTap)
				group:insert(message)
-- change resume button to next level button
local nextlevelBtn = display.newImageRect ("images/nextlevelBtn.png", 250, 50)
				nextlevelBtn.x = 250
				nextlevelBtn.y = 420
				nextlevelBtn:addEventListener ("tap", nextBtnTap)
				group:insert(nextlevelBtn)
-- change reload button to replay button
local reloadBtn = display.newImageRect ("images/reload.png" ,300, 50)
				reloadBtn.x = 250 
				reloadBtn.y = 490
				params = event.params
				--reloadBtn.destination = "game2"
				reloadBtn:addEventListener ("tap", reloadBtnTap)
				group:insert (reloadBtn)
        
local mainMenu = display.newImageRect ("images/mainMenu.png" ,250, 50)
				mainMenu.x = 250 
				mainMenu.y = 560
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