local storyboard = require("storyboard")
local scene = storyboard.newScene()

local widget = require( "widget" )

-- Button handler returns to the menu scene
local function handleCancelButtonEvent( event )
    if ( "ended" == event.phase ) then
        storyboard.gotoScene( "menu", { effect="crossFade", time=333 } )
    end
end

function scene:createScene(event)
  local sceneGroup = self.view
  
  -- Create background
    local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
    background:setFillColor( 1 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert( background )
    
    --YOUR CODE HERE!!!
    
    -- Create a button that returns to the menu scene.
    local backButton = widget.newButton({
        id = "button1",
        label = "Back To Menu",
        fontSize = 30,
        onEvent = handleCancelButtonEvent
    })
    backButton.x = display.contentCenterX
    backButton.y = display.contentHeight - 50
    sceneGroup:insert( backButton )
    
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