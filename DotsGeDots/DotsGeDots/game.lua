local storyboard = require("storyboard")
local scene = storyboard.newScene()

local widget = require( "widget" )
--local utility = require( "utility" )
local myData = require( "mydata" )

local starVertices = { 0,-11, 2.7,-3.5, 10.5,-3.5, 4.3,1.6, 6.5,9.0, 0,4.5, -6.5,9.0, -4.3,1.5, -10.5,-3.5, -2.7,-3.5, }

local params

local function handleCancelButtonEvent( event )

    if ( "ended" == event.phase ) then
        storyboard.removeScene( "game_levels", false )
        storyboard.gotoScene( "game_levels", { effect = "crossFade", time = 333 } )
    end
end

-- Start the storyboard event handlers
--
function scene:createScene( event )
    local sceneGroup = self.view

    params = event.params
        
    --
    -- setup a page background, really not that important though storyboard
    -- crashes out if there isn't a display object in the view.
    --
    local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert(background)
    
    --local displayTimer = display.newText("0", 0, 0, native.systemFont,32)
    --displayTimer:setTextColor(black)
    --timer:setReferencePoint(display.CenterReferencePoint)
    --displayTimer.x = display.contentCenterX
    --displayTimer.y = display.contentHeight - 80
    
    

    local doneButton = widget.newButton({
        id = "button1",
        label = "Go To Level Select",
        fontSize = 30,
        onEvent = handleCancelButtonEvent
    })
    doneButton.x = display.contentCenterX
    doneButton.y = display.contentHeight - 50
    sceneGroup:insert( doneButton )
end

function scene:showScene( event )
    local sceneGroup = self.view

    params = event.params

    if event.phase == "did" then
    end
end

function scene:hideScene( event )
    local sceneGroup = self.view
    
    if event.phase == "will" then
    end

end

function scene:destroyScene( event )
    local sceneGroup = self.view
    
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "showScene", scene )
scene:addEventListener( "hideScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
