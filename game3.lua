local storyboard = require("storyboard")
local scene = storyboard.newScene()

local widget = require( "widget" )
local mydata = require( "mydata" )
local physics = require("physics")
physics.start()

require("timer2")
local params

local function handleCancelButtonEvent( event )

    if ( "ended" == event.phase ) then
        storyboard.removeScene( "game_levels", false )
        storyboard.gotoScene( "game_levels", { effect = "crossFade", time = 333 } )
    end
end

local function btnTap(event)
  timer.cancel(gameTimer)
    storyboard.gotoScene (  event.target.destination, {effect = "crossFade", time = 333} )
    return true
end

local function pausebtnTap(event)
    event.target.xScale = 0.95
    event.target.yScale = 0.95
  timer.pause(gameTimer)
    --
    storyboard.showOverlay( "pause" ,{effect = "fade"  ,  params ={levelNum = "game3"}, isModal = true} )
    return true
end

local function reloadbtnTap(event)
    timer.cancel(gameTimer)
    storyboard.purgeScene(event.target.destination)
    storyboard.gotoScene (  event.target.destination, {effect = "crossFade", time = 333} )
    return true
end

-- Start the storyboard event handlers
function scene:createScene( event )
    local sceneGroup = self.view

    params = event.params
        
    -- start background
    local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background:setFillColor(244, 164, 96)
    sceneGroup:insert(background)
    -- end background

    local levelUp = display.newRect(0, 0, 1200, 180)
    levelUp.x = 0
    levelUp.y = 0
    levelUp:setFillColor(0, 255, 255)
    sceneGroup:insert(levelUp)

    local levelDown = display.newRect(0, 0, 1200, 180)
    levelDown.x = 0
    levelDown.y = 800
    levelDown:setFillColor(0, 255, 255)
    sceneGroup:insert(levelDown)
    
    local level1 = display.newText( "Level 3", 100, 100, native.systemFont, 55 )
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
    
    grid[2]:setFillColor(215/255, 112/255, 203/255)
    grid[3]:setFillColor(215/255, 112/255, 203/255)
    grid[6]:setFillColor(215/255, 112/255, 203/255)
    
    -- end of grid
 
  
    
    --back button
    local backBtn = widget.newButton{
    width = 70,
    height = 70,
    defaultFile = "images/back.png"
    }
    backBtn.x = display.contentWidth - 420
    backBtn.y = display.contentHeight - 750
    backBtn.destination = "game_levels"
    backBtn:addEventListener("tap", btnTap)
    sceneGroup:insert(backBtn)
    --/back button]]--
    
  --pause button
  local pauseBtn = widget.newButton{
    width = 70,
    height = 70,
    defaultFile = "images/pauseBtn.png"
    }
    pauseBtn.x = display.contentWidth - 340
    pauseBtn.y = display.contentHeight - 40
    --pauseBtn.destination = "game_levels"
    pauseBtn:addEventListener("tap", pausebtnTap)
    sceneGroup:insert(pauseBtn)
  --/pause button
  
--replay button
  local reloadBtn = widget.newButton{
    width = 70,
    height = 70,
    defaultFile = "images/reloadBtn.png"
  }
  reloadBtn.x = display.contentWidth - 140
  reloadBtn.y = display.contentHeight - 40
  reloadBtn.destination = "game3"
  reloadBtn:addEventListener("tap", reloadbtnTap)
  sceneGroup:insert(reloadBtn)
  --/replay button
   
    -- start draw circle
    local circle1 = display.newCircle(245, 255, 50)
    circle1:setFillColor(174/255, 87/255, 163/255) 
    
    local circle2= display.newCircle(90, 400, 50)
    circle2:setFillColor(174/255, 87/255, 163/255) 
    
    local circle3= display.newCircle(245, 400, 50)
    circle3:setFillColor(174/255, 87/255, 163/255)
    
    local group = display.newGroup()
    group:insert(circle1)
    group:insert(circle2)
    group:insert(circle3)
    sceneGroup:insert( group)
    -- end circle
    
    --insert block 
    local block1 = display.newImage( "block_brick.png" )
    block1.x = 90
    block1.y = 250
    block1:scale(-0.57, -0.57)
    --sceneGroup:insert(block1)

    local block2 = display.newImage("block_brick.png")
    block2.x = 90
    block2.y = 550
    block2:scale(-0.57, -0.57)
    --sceneGroup:insert(block2)

    local block3 = display.newImage("block_brick.png")
    block3.x = 245
    block3.y = 550
    block3:scale(-0.57, -0.57)
    --sceneGroup:insert(block3)

    local block = display.newGroup()
    block:insert(block1)
    block:insert(block2)
    block:insert(block3)
    sceneGroup:insert(block)
    --end sa block
    
    -- start timer
    local displayTimeUsed = display.newText("Time Used: ", 100, 100, 'Marker Felt', 30)
    displayTimeUsed.x = 100
    displayTimeUsed.y = 130
    displayTimeUsed:setTextColor(1,0,0)
    sceneGroup:insert(displayTimeUsed)

    local gameTimer = display.newText("0", 100, 100, native.systemFont, 40)
    gameTimer.x = 200
    gameTimer.y = 130
    gameTimer:setTextColor(1,0,0)
    sceneGroup:insert( gameTimer )
    
    local timeLimit = display.newText("Time Limit: 10 seconds", 100, 100, 'Marker Felt', 30)
    timeLimit.x = 170
    timeLimit.y = 670
    timeLimit:setTextColor(1,0,0)
    sceneGroup:insert(timeLimit)

  function displayTime(event)
      local params = event.source.params
      gameTimer.text = event.count
      if (circle1.x == 400 and circle1.y == 255) and (circle2.x == 245 and circle2.y == 255) and (circle3.x == 400 and circle3.y == 400) then
        if(event.count > 0 and event.count <= 4) then
            mydata.settings.levels[3].stars = 3
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 4
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game3"}, isModal = true} )
        elseif(event.count >= 5 and event.count <= 8) then
            mydata.settings.levels[3].stars = 2
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 4
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game3"}, isModal = true} )
        elseif(event.count >= 9 and event.count <= 10) then
            mydata.settings.levels[3].stars = 1
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 4
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game3"}, isModal = true} )
        elseif(event.count > 10) then
            timer.cancel(event.source)
            storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  ,  params ={levelNum = "game3"}, isModal = true} )
        end
      end
    end

    local tmr = timer.performWithDelay(1000, displayTime, 0)    tmr.params = group

    -- end timer

    --move dots
    local CENTERX = display.contentCenterX
    local CENTERY = display.contentCenterY
    local LEFT = -150
    local RIGHT = 140
    local UP = -20
    local DOWN = 150
    
    local function checkYUpPosition(group)
      if(group[1].x == 245 and group[1].y == 255) then
        if(group[2].x == 90 and group[2].y == 400 and group[3].x == 245 and group[3].y == 400) then
          print("don't move")
        end
      elseif(group[1].x == 400 and group[1].y == 255) then
        if(group[2].x == 245 and group[2].y == 400 and group[3].x == 400 and group[3].y == 400) then
          print("move up")
          group[2].y = 255
        end
      elseif(group[1].x == 400 and group[1].y == 400) then
        if(group[2].x == 245 and group[2].y == 400 and group[3].x == 400 and group[3].y == 550) then
          print("move up2")
          group[1].y = 255
          group[2].y = 255
          group[3].y = 400
        end
      end
      return true
    end

    local function checkYDownPosition(group)
      if(group[1].x == 245 and group[1].y == 255) then
        if(group[2].x == 90 and group[2].y == 400 and group[3].x == 245 and group[3].y == 400) then
          print("don't move")
        end
       elseif(group[1].x == 400 and group[1].y == 255) then
        if(group[2].x == 245 and group[2].y == 400 and group[3].x == 400 and group[3].y == 400) then
          print("move down")
          group[1].y = 400
          group[3].y = 550
        end
      elseif(group[1].x == 400 and group[1].y == 400) then
        if(group[2].x == 245 and group[2].y == 400 and group[3].x == 400 and group[3].y == 550) then
          print("don't move")
        end
      end
      return true
    end

    local function checkXLeftPosition(group)
      if(group[1].x == 245 and group[1].y == 255) then
        if(group[2].x == 90 and group[2].y == 400 and group[3].x == 245 and group[3].y == 400) then
          print("don't move")
        end
       elseif(group[1].x == 400 and group[1].y == 255) then
        if(group[2].x == 245 and group[2].y == 400 and group[3].x == 400 and group[3].y == 400) then
          print("move left")
          group[1].x = 245
          group[2].x = 90
          group[3].x = 245
        end
      elseif(group[1].x == 400 and group[1].y == 400) then
        if(group[2].x == 245 and group[2].y == 400 and group[3].x == 400 and group[3].y == 550) then
          print("move left2")
          group[1].x = 245
          group[2].x = 90
        end
      end
      return true
    end

    local function checkXRightPosition(group)
      if(group[1].x == 245 and group[1].y == 255) then
        if(group[2].x == 90 and group[2].y == 400 and group[3].x == 245 and group[3].y == 400) then
          print(" move right1")
          group[1].x = 400
          group[2].x = 245
          group[3].x = 400
        end
       elseif(group[1].x == 400 and group[1].y == 255) then
        if(group[2].x == 245 and group[2].y == 400 and group[3].x == 400 and group[3].y == 400) then
          print("don't move")
        end
      elseif(group[1].x == 400 and group[1].y == 400) then
        if(group[2].x == 245 and group[2].y == 400 and group[3].x == 400 and group[3].y == 550) then
          print("don't move")
        end
      end
      return true
    end

    local dX = 0
    local dY = 0

    local function handleSwipe( event )
        if ( event.phase == "moved" ) then
            dX = event.x - event.xStart
            dY = event.y - event.yStart
            print("End of story.\n", dX, dY)
            return false
        end
          if dX > 20 and dX > dY  then
              print("move right")
              local spot = "right"
              checkXRightPosition(group)
              transition.to( event.target, { time=333} )
              if event.target.param == "right" then
                -- right
                checkXRightPosition(group)
                transition.to( event.target, { time=333} )
              elseif event.target.param == "left" then
                -- left
                checkXLeftPosition(group)
                transition.to( event.target, { time=333} )
              end
              transition.to( event.target, { time=333 } )
              return true
          elseif dX < -20 and dY > dX then
              print("move left")
              checkXLeftPosition(group)
              transition.to( event.target, { time=100} )
              return true
          elseif dY < -20 then
              print("move up")
              checkYUpPosition(group)
              transition.to( event.target, { time=100} )
              return true
          elseif dY > 20 then
              print("move down")
              checkYDownPosition(group)
              transition.to( event.target, { time=333} )
              return true
          end
        --end
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
