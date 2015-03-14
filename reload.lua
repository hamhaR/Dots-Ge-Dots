
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

--message
local message = display.newImageRect ("images/message3.png", 400, 150)
				message.x = 250
				message.y = 280
				--message:addEventListener ("tap", nextBtnTap)
				group:insert(message)

-- play again
local tryAgainBtn = display.newImageRect ("images/reload.png" ,250, 50)
        tryAgainBtn.x = 250 
        tryAgainBtn.y = 450
        params = event.params
        --reloadBtn.destination = "game2"
        tryAgainBtn:addEventListener ("tap", reloadBtnTap)
        group:insert (tryAgainBtn)
        
local cancelBtn = display.newImageRect ("images/cancel.png", 250, 50)
				cancelBtn.x = 250
				cancelBtn.y = 510
				local function hideOverlay(event)
					storyboard.hideOverlay("fade", 333)
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