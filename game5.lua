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

    params = event.params
        
    -- start background
    local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert(background)
    -- end background
    
    local level1 = display.newText( "Level 5", 100, 100, native.systemFont, 55 )
    level1.x = display.contentCenterX
    level1.y = display.contentCenterY - 350
    level1:setTextColor(black)
    sceneGroup:insert( level1 )
    
    -- start grid
    local xOffset = 94
    local yOffset = 250
    local cellCount = 1

    -- Define the array to hold the buttons
    local grid = {}

    -- Read 'maxLevels' from the 'mydata' table. Loop over them and generating one grid for each.
    for i = 1, mydata.settings.easy do
        -- Create a grid
        grid[i] = display.newRect(100,200,150,150)
        grid[i]:setFillColor(255,255,255)
        grid[i].strokeWidth = 4
        grid[i]:setStrokeColor(0,0,0)
        grid[i].x = xOffset 
        grid[i].y = yOffset
        
        sceneGroup:insert( grid[i] )

        xOffset = xOffset + 150
        cellCount = cellCount + 1
        if ( cellCount > 3 ) then
            cellCount = 1
            xOffset = 94
            yOffset = yOffset + 150
        end
    end
    
    grid[1]:setFillColor(215/255, 112/255, 203/255)
    grid[2]:setFillColor(215/255, 112/255, 203/255)
    grid[4]:setFillColor(215/255, 112/255, 203/255)
    --blocks at grid 16 and 8
    --dots at 1, 4, 5
  
    -- end of grid
    
    --insert block 
    --grid 1, 7, 8
   -- local myImage = display.newImage( "images.block_brick.png" )

    -- position the image
    --myImage:translate( 100, 100 )
    --end sa block
    

    -- start back button
    local backButton = widget.newButton({
        id = "button",
        label = "<",
        font = native.systemFontBold,
        fontSize = 100,
        onEvent = handleCancelButtonEvent
    })
    backButton.x = display.contentWidth - 420
    backButton.y = display.contentHeight - 750
    sceneGroup:insert( backButton )
    -- end back button
    
    -- start next button
    local nextButton = widget.newButton{
        id = "button",
        label = "Next Level Button",
        shape = "rect",
        width = 235,
        height = 80,
        fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 0.1, 0.7, 0.4 } },
        strokeColor = { default={ 0.300, 0.667, 1, 1 }, over={ 1, 1, 1, 1 } },
        strokeWidth = 6,
        font = native.systemFontBold,
        fontSize = 25,
        --onEvent = handleCancelButtonEvent
    }
    nextButton.x = display.contentWidth - 120
    nextButton.y = display.contentHeight - 43
    sceneGroup:insert( nextButton )
    
    -- If the level is locked, disable the button and fade it out.
    if ( mydata.settings.unlockedLevels == nil ) then
      mydata.settings.unlockedLevels = 1
    end
    if ( 2 < mydata.settings.unlockedLevels ) then
      nextButton:setEnabled( true )
      nextButton.alpha = 1
    else 
      nextButton:setEnabled( false ) 
      nextButton.alpha = 0.667
    end 
    -- end next button
    
    -- start replay button
    local replayButton = widget.newButton{
        label = "Replay Button",
        fontSize = 30,
        shape = "rect",
        width = 235,
        height = 80,
        defaultFile = "refresh.png",
        overFile = "refresh.png",
        strokeColor = { default={ 0.300, 0.667, 1, 1 }, over={ 1, 1, 1, 1 } },
        strokeWidth = 6
        --onEvent = handleCancelButtonEvent
    }
    replayButton.x = display.contentWidth - 360
    replayButton.y = display.contentHeight - 43
    sceneGroup:insert( replayButton )
    --end replay button
    
    -- start timer
    local displayTimer = display.newText("0", 100, 100, native.systemFont, 40)
    displayTimer.x = display.contentCenterX
    displayTimer.y = display.contentCenterY + 270
    displayTimer:setTextColor(1,0,0)
    sceneGroup:insert( displayTimer )
    -- end timer
    
    -- start draw circle
    local circle1 = display.newCircle(90, 255, 50)
    circle1:setFillColor(174/255, 87/255, 163/255) 
    
    local circle2= display.newCircle(245, 255, 50)
    circle2:setFillColor(174/255, 87/255, 163/255) 
    
    local circle3= display.newCircle(400, 255, 50)
    circle3:setFillColor(174/255, 87/255, 163/255)
    
    local group = display.newGroup()
    group:insert(circle1)
    group:insert(circle2)
    group:insert(circle3)
    sceneGroup:insert( group)
    
    -- end circle
    
    --move dots
    local CENTERX = display.contentCenterX
    local CENTERY = display.contentCenterY
    local LEFT = 10
    local RIGHT = 140
    local UP = -20
    local DOWN = 150
    

    local function handleSwipe( event )
        if ( event.phase == "moved" ) then
            local dX = event.x - event.xStart
            print( event.x, event.xStart, dX )
            if ( dX > 5 ) then
                --swipe right
                local spot = RIGHT
                if ( event.target.x == LEFT ) then
                    spot = CENTERX
                end
                transition.to( event.target, { time=500, x=spot } )
            elseif ( dX  < -10 ) then
                --swipe left
                local spot = LEFT
                if ( event.target.x == RIGHT ) then
                    spot = CENTERX
                end
                transition.to( event.target, { time=500, x=spot } )
            end
            --y-axis(up and down movement) = 
            local dY = event.y - event.yStart
            if (dY > 10) then
              local spot = DOWN 
              if ( event.target.y == UP )  then
                  spot = CENTERY
              end
              transition.to( event.target, { time = 500, y = spot } )
            elseif ( dY < -10 ) then
              local spot = UP
              if ( event.target.y == DOWN) then
                  spot = CENTERY
              end
              transition.to( event.target, { time = 500, y = spot } )
            end
            --end sa y
        end
        return true
    end
      
      
      group:addEventListener("touch", handleSwipe)  
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
