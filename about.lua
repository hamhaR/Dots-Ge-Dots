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
    
  -- Display information about the game
    local aboutText = display.newText(
        "DGD is a brain puzzle game\n, in which all the dots move together.\n The dots always move unless they are blocked,\n to solve the puzzle,\n move all the dots onto the colored squares.\n Player can only proceed to the next level\n only if all dots are placed on the colored squares\n and does not exceed to the limit number of moves.\n", display.contentCenterX, 200, native.systemFont,20, center  )
    aboutText:setFillColor(0,0,0)
    sceneGroup:insert(aboutText)
  
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