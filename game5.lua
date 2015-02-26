local storyboard = require("storyboard")
local scene = storyboard.newScene()

local widget = require( "widget" )
local mydata = require( "mydata" )
local physics = require("physics")
physics.start()

local params

local function handleCancelButtonEvent( event )

    if ( "ended" == event.phase ) then
        storyboard.removeScene( "game_levels", false )
        storyboard.gotoScene( "game_levels", { effect = "crossFade", time = 333 } )
    end
end


    

local function checkXLeftPosition(group, block)
  for i=1, group.numChildren do
    if i == 1 then
      if (group[i].x > 90) then
        if(group[i].y == group[2].y or group[i].y == group[3].y) then
          print("Dont move")
        else
          local circle_new = display.newCircle(90, group[i].y, 50)
          circle_new:setFillColor(100, 0, 250)
          group[i]:removeSelf()
          group:insert(circle_new)
        end
      end
    elseif i == 2 then
      -- do
      if (group[i].x > 90) then
        if(group[i].x == group[1].x or group[i].x == group[3].x) then
          if((group[i].x-145 >= 90 and group[i].x-145 <= 100)  and group[i].y == block.y) then
          print("Dont move")--dili mo move si dot 2
           --move left si dot 3
           local circle_new = display.newCircle(90, group[i].y+145, 50)
           circle_new:setFillColor(100, 0, 250)
           group[3]:removeSelf()
           group:insert(circle_new)
          --end
          else
            local circle_new = display.newCircle(90, group[i].y, 50)
            circle_new:setFillColor(100, 0, 250)
            group[i]:removeSelf()
            group:insert(circle_new)
          end
        end
      end
    elseif i == 3 then
      -- do
      if (group[i].x > 90) then
        if(group[i].y == group[1].y or group[i].y == group[2].y) then
          print("Dont move")
        else
          local circle_new = display.newCircle(90, group[i].y, 50)
          circle_new:setFillColor(100, 0, 250)
          group[i]:removeSelf()
          group:insert(circle_new)
        end
      end
    end
  end
  return true
end

local function checkXRightPosition(group)
  for i=1, group.numChildren do
    if i == 1 then
      if (group[i].x < 245) then
        if(group[i].y == group[2].y or group[i].y == group[3].y) then
          print("Dont move")
        else
          local circle_new = display.newCircle(245, group[i].y, 50)
          circle_new:setFillColor(100, 0, 250)
          group[i]:removeSelf()
          group:insert(circle_new)
        end
      end
    elseif i == 2 then
      -- do
      if (group[i].x < 245) then
        if(group[i].y == group[1].y or group[i].y == group[3].y) then
          print("Dont move")
        else
          local circle_new = display.newCircle(245, group[i].y, 50)
          circle_new:setFillColor(100, 0, 250)
          group[i]:removeSelf()
          group:insert(circle_new)
        end
      end
    elseif i == 3 then
      -- do
      if (group[i].x < 245) then
        if(group[i].y == group[1].y or group[i].y == group[2].y) then
          print("Dont move")
        else
          local circle_new = display.newCircle(245, group[i].y, 50)
          circle_new:setFillColor(100, 0, 250)
          group[i]:removeSelf()
          group:insert(circle_new)
        end
      end
    end
  end
  return true
end

local function checkYUpPosition(group, block)
  for i = 1, group.numChildren do
    if i == 1 then
      --do
      if (group[i].y > 255) then
        
      end
    elseif i == 2 then
      --do
      if (group[i].y > 255) then
        if (group[i].x == group[1].x or group[i].x == group[3].x) then
          if (group[i].x == group[3].x and group[i].y ~= group[3].y and group[i].x ~= group[1].x and group[i].y ~= group[1].y) then
            local circle_new = display.newCircle(group[i].x, 255, 50)
            circle_new:setFillColor(100, 0, 250)
            group[i]:removeSelf()
            group:insert(circle_new)
            local circle_new2 = display.newCircle(group[i].x, 400, 50)
            circle_new2:setFillColor(100, 0, 250)
            group[i]:removeSelf()
            group:insert(circle_new2)
          end
        else
          local circle_new = display.newCircle(group[i].x, 255, 50)
          circle_new:setFillColor(100, 0, 250)
          group[i]:removeSelf()
          group:insert(circle_new)
        end
      end
    elseif i == 3 then 
      --do
      if (group[i].y > 255) then
        if group[i].x == group[2].x or group[i].x == group[1].x then
          if (group[i].x == group[2].x and group[i].y ~= group[2].y and group[i].x ~= group[1].x and group[i].y ~= group[1].y) then
            local circle_new = display.newCircle(group[i].x, 400, 50)
            circle_new:setFillColor(100, 0, 250)
            group[i]:removeSelf()
            group:insert(circle_new)
            local circle_new2 = display.newCircle(group[2].x, 255, 50)
            circle_new2:setFillColor(100, 0, 250)
            group[2]:removeSelf()
            group:insert(circle_new2)
          else
            local circle_new = display.newCircle(group[i].x, 400, 50)
            circle_new:setFillColor(100, 0, 250)
            group[i]:removeSelf()
            group:insert(circle_new)
          end
        end
      end
    end
  end 
end

local function checkYDownPosition(group, block)
  for i = 1, group.numChildren do
      if i == 1 then
        --do
        if (group[i].y < 400) then
          if (group[i].x == block.x and group[i].y ~= block.y) then
            if (group[i].y == group[2].y or group[i].y == group[3].y) then
              print("Don't move dot1")
              --bring down dot2 and dot3
              local circle_new = display.newCircle(group[2].x, 400, 50)
              circle_new:setFillColor(100, 0, 250)
              group[2]:removeSelf()
              group:insert(circle_new)
              local circle_new2 = display.newCircle(group[3].x, 550, 50)
              circle_new2:setFillColor(100, 0, 250)
              group[2]:removeSelf()
              group:insert(circle_new2)
            end
          else --kung walay block ubos sa dot
            local circle_new = display.newCircle(group[i].x, 400, 50)
            circle_new:setFillColor(100, 0, 250)
            group[i]:removeSelf()
            group:insert(circle_new)
            
          end
        end
      --elseif i == 2 then
        --do
       --[[ if (group[i].y < 400) then
          if (group[i].x == block.x and group[i].y ~= block.y) then
            if (group[i].y == group[2].y or group[i].y == group[3].y) then
              if (group[2].x == group[3].x and group[2].x ~= block.x) then
                if (group[3].y == block.x) then
                  
                end
              end
            end
          end
        end ]]--
      --elseif i == 3 then 
        --do
        --[[if (group[i].y < 400) then
          if (group[i].x == block.x and group[i].y ~= block.y) then
            if (group[i].y == group[2].y or group[i].y == group[3].y) then
              if (group[2].x == group[3].x and group[2].x ~= block.x) then
                if (group[3].y == block.x) then
                  
                end
              end
            end
          end
        end
        else]]--
      end 
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
    
    grid[1]:setFillColor(1, 104/255, 1)
    grid[7]:setFillColor(1, 104/255, 1)
    grid[8]:setFillColor(1, 104/255, 1)
    
    -- end of grid
     

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
    local circle1 = display.newCircle(380, 255, 50)
    circle1:setFillColor(100, 0, 250) 
    
    local circle2= display.newCircle(380, 400, 50)
    circle2:setFillColor(100, 0, 250) 
    
    local circle3= display.newCircle(380, 550, 50)
    circle3:setFillColor(100, 0, 250)
    
    local group = display.newGroup()
    group:insert(circle1)
    group:insert(circle2)
    group:insert(circle3)
    sceneGroup:insert( group)
    -- end circle
    
    --pause button     

    
    
    --insert block 
    local block1 = display.newImage( "block_brick.png" )
    local block2 = display.newImage( "block_brick.png" )
    block1.x = 90; block1.y = 400
    block2.x = 235; block2.y = 400
    --scale the block
    block1:scale(0.6, 0.65)
    block2:scale(0.6, 0.65)
    physics.addBody( block1, "static", { isSensor=true, friction=0, bounce=0 } )
    physics.addBody( block2, "static", { isSensor=true, friction=0, bounce=0 } )
    sceneGroup:insert(block1)
    sceneGroup:insert(block2)
    --end sa block
    
    --move dots
    local CENTERX = display.contentWidth - 450
    local CENTERY = display.contentHeight - 640
    local LEFT = 9
    local RIGHT = 165
    local UP = -17
    local DOWN = 150
    

    local function handleSwipe( event )
        if ( event.phase == "moved" ) then
            local dX = event.x - event.xStart
            --print( event.x, event.xStart, dX )
            if ( dX > 5 ) then
                --swipe right
                local spot = RIGHT
                if ( event.target.x == LEFT ) then
                    spot = CENTERX - 10
                elseif(event.target.x == RIGHT) then
                  checkXRightPosition(group)
                  --spot = RIGHT
                end
                transition.to( event.target, { time=500, x=spot } )
            elseif ( dX  < -20 ) then
                --swipe left
                --local spot = LEFT
                checkXLeftPosition(group, block)
                if ( event.target.x == RIGHT ) then
                  spot = CENTERX -10
                elseif(event.target.x == LEFT) then
                  checkXLeftPosition(group, block)
                end
                transition.to( event.target, { time=500, x=spot } )
            end
            --y-axis(up and down movement) = 
            local dY = event.y - event.yStart
            if (dY > 10) then
              --local spot = DOWN 
              checkYDownPosition(group, block)
              if ( event.target.y == UP )  then
                  spot = CENTERY
              elseif( event.target.y == DOWN) then
                  checkYDownPosition(group, block)
                  print(group.x )
                  print(group.y)
              end
              transition.to( event.target, { time = 500, y = spot } )
            elseif ( dY < -10 ) then
              --local spot = UP
              checkYUpPosition(group, block)
              if ( event.target.y == DOWN) then
                  spot = CENTERY
              elseif(event.target.y == UP) then
                checkYUpPosition(group, block) 
                
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
