local storyboard = require("storyboard")
local scene = storyboard.newScene()

local widget = require( "widget" )

-- Button handler returns to the menu scene
local function handleCancelButtonEvent( event )
    if ( "ended" == event.phase ) then
        storyboard.gotoScene( "menu", { effect="crossFade", time=333 } )
    end
end

local function btnTap(event)
	storyboard.gotoScene (  event.target.destination, { time=333, effect = "fade"} )
	return true
end

function scene:createScene(event)
  local sceneGroup = self.view
  
 local backgroundOverlay = display.newImage ("images/instructionsBackground.jpg")
        backgroundOverlay:scale(1.2, 2.1)
        backgroundOverlay.x = 0
        backgroundOverlay.y = 0
				backgroundOverlay.isHitTestable = true
				backgroundOverlay:addEventListener ("tap", catchBackgroundOverlay)
				backgroundOverlay:addEventListener ("touch", catchBackgroundOverlay)
        sceneGroup:insert (backgroundOverlay)
    
    --YOUR CODE HERE!!!
    
    -- Create a button that returns to the menu scene.
    local mainMenu = display.newImageRect ("images/mainMenu.png" ,260, 50)
				mainMenu.x = 250 
				mainMenu.y = 770
				params = event.params
				mainMenu.destination = "menu"
				mainMenu:addEventListener ("tap", btnTap)
				sceneGroup:insert (mainMenu)
    
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