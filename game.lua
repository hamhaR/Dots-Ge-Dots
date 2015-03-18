local storyboard = require("storyboard")
local scene = storyboard.newScene()

local widget = require( "widget" )
local mydata = require( "mydata" )

local params

local function handleCancelButtonEvent( event )

    if ( "ended" == event.phase ) then
        storyboard.removeScene( "game_levels", false )
        storyboard.gotoScene( "game_levels", { effect = "crossFade", time = 333 } )
    end
end

-- Start the storyboard event handlers
function scene:createScene( event )
    local sceneGroup = self.view

    local params = event.params
        
    -- start background
    local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert(background)
    -- end background
    
    if(params.buttonID == 1) then
     -- storyboard.purgeScene("game1")
    print("purged1")
    storyboard.purgeScene("game1")
      storyboard.gotoScene( "game1", { effect = "crossFade", time = 333 } )
    elseif(params.buttonID == 2) then
      storyboard.purgeScene("game2")
    print("purged2")
      storyboard.gotoScene( "game2", { effect = "crossFade", time = 333 } )
    elseif(params.buttonID == 3) then
      storyboard.gotoScene( "game3", { effect = "crossFade", time = 333 } )
    elseif(params.buttonID == 4) then
      storyboard.gotoScene( "game4", { effect = "crossFade", time = 333 } )
    elseif(params.buttonID == 5) then
      storyboard.gotoScene( "game5", { effect = "crossFade", time = 333 } )
    elseif(params.buttonID == 6) then
      storyboard.gotoScene( "game6", { effect = "crossFade", time = 333 } )
    end
    
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

--end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "showScene", scene )
scene:addEventListener( "hideScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
