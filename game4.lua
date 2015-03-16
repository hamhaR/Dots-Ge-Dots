local storyboard = require("storyboard")
local scene = storyboard.newScene()

local widget = require( "widget" )
local mydata = require( "mydata" )
local physics = require("physics")
physics.start()

require("timer2")

--fix positions of dots in every grid (x and y coordinates)
local x1 = 95
local x2 = 245
local x3 = 400
local y1 = 250
local y2 = 400
local y3 = 550

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
    storyboard.showOverlay( "pause" ,{effect = "fade"  ,  params ={levelNum = "game4"}, isModal = true} )
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


    local level1 = display.newText( "Level 4", 100, 100, native.systemFont, 55 )
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
    
    grid[6]:setFillColor(215/255, 112/255, 203/255)
    grid[8]:setFillColor(215/255, 112/255, 203/255)
    grid[9]:setFillColor(215/255, 112/255, 203/255)
    
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
    reloadBtn.destination = "game4"
    reloadBtn:addEventListener("tap", reloadbtnTap)
    sceneGroup:insert(reloadBtn)
  --/replay button
 
    -- start draw circle
    local circle1 = display.newCircle(95, 550, 50)
    circle1:setFillColor(174/255, 87/255, 163/255) 
    
    local circle2= display.newCircle(245, 250, 50)
    circle2:setFillColor(174/255, 87/255, 163/255) 
    
    local circle3= display.newCircle(400, 250, 50)
    circle3:setFillColor(174/255, 87/255, 163/255)
    
    local group = display.newGroup()
    group:insert(circle1)
    group:insert(circle2)
    group:insert(circle3)
     --physics.addBody(group, {density=0, friction=0, bounce=0})
    sceneGroup:insert( group)
    
    -- end circle
    
    --insert block 
    local block1 = display.newImage( "block_brick.png" )
    block1.x = 95
    block1.y = 250
    block1:scale(-0.57, -0.57)
    sceneGroup:insert(block1)

    local block2 = display.newImage("block_brick.png")
    block2.x = 95
    block2.y = 400
    block2:scale(-0.57, -0.57)
    sceneGroup:insert(block2)

    local block3 = display.newImage("block_brick.png")
    block3.x = 245
    block3.y = 400
    block3:scale(-0.57, -0.57)
    sceneGroup:insert(block3)

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
        if event.count < 10 then
            if ((circle1.x == 250 or circle1.x == 245) and circle1.y == 550) and (circle2.x == 400 and circle2.y == 400) and (circle3.x == 400 and circle3.y == 550) then
                timer.cancel(event.source)
                mydata.settings.unlockedLevels = 5
                storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game4"}, isModal = true} )
            end
        elseif event.count == 10 then
            timer.cancel(event.source)
            if (circle1.x == 250 and circle1.y == 550) and (circle2.x == 400 and circle2.y == 400) and (circle3.x == 400 and circle3.y == 550) then
                mydata.settings.unlockedLevels = 5
                storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game4"}, isModal = true} )
            else
                storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  ,  params ={levelNum = "game4"}, isModal = true} )
            end
        end
    end

    local tmr = timer.performWithDelay(1000, displayTime, 0)
    tmr.params = {myParam1 = group}

    -- end timer

    --move dots

    local function checkYUpPosition(group, block)
      if(group[1].x == x1 and group[1].y == y3) then
        if(group[2].x == x2 and group[2].y == y1 and group[3].x == x3 and group[3].y == y2) then
          print("move up1")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y1
        elseif(group[2].x == x2 and group[2].y == y1 and group[3].x == x3 and group[3].y == group[1].y) then
          print("move up2")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y2
        elseif(group[2].x == x3 and group[2].y == y2 and group[3].x == x2 and group[3].y == group[1].y) then
          print("move up8")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y3
        elseif(group[2].y == group[1].y and group[3].y == group[1].y) then
          print("move up11")
          group[2].y = y2
        end
      elseif(group[1].x == x2 and group[1].y == y3) then
        if(group[2].x == group[1].x and group[2].y == y1 and group[3].x == x3 and group[3].y == y2) then
          print("move up3")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y1
        elseif(group[2].x == group[1].x and group[2].y == y1 and group[3].x == x3 and group[3].y == group[1].y) then
          print("move up4")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y2
        elseif(group[2].x == x3 and group[2].y == y1 and group[3].x == group[2].x and group[3].y == group[1].y) then
          print("move up5")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y2
        elseif(group[2].x == x3 and group[2].y == y2 and group[3].x == group[2].x and group[3].y == group[1].y) then
          print("move up7")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y2
        end
      elseif(group[1].x == x3 and group[1].y == y3) then
        if(group[1].x == group[3].x and group[3].y == y1 and group[3]. y == group[2].y) then
          print("move up2")
          group[1].y = y2
          group[2].y = y1
          group[3].y = y1
        elseif(group[2].x == x2 and group[2].y == y1 and group[3].x == group[1].x and group[3].y == y2) then
          print("move up13")
          group[1].y = y2
          group[3].y = y1
        end
      end
    end
    
    local function checkYDownPosition(group, block)
      if(group[1].x == x1 and group[1].y == y3) then
        if(group[2].x == x2 and group[3].x == x3 and group[2].y == y1 and group[2].y == group[3].y) then
          print("move down1")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y2
        elseif(group[2].x == x2 and group[2].y == y1 and group[3].x == x3 and group[3].y == y2) then
          print("move down2")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y3
        elseif(group[2].x == x3 and group[2].y == y2 and group[3].x == x2 and group[3].y == group[1].y) then
          print("move down10")
          group[1].y = y3
          group[2].y = y3
          group[3].y = y3
        elseif(group[2].x == x3 and group[2].y == y1 and group[3].x == x2 and group[3].y == group[1].y) then
          print("move down11")
          group[2].y = y2
        end
      elseif(group[1].x == x2 and group[1].y == y3) then
        if(group[1].x == group[2].x and group[2].y == y1 and group[3].x == x3 and group[3].y == group[2].y) then
          print("move down3")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y2
        elseif(group[2].x == group[1].x and group[2].y == y1 and group[3].x == x3 and group[3].y == y2) then
          print("move down5")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y3
        elseif(group[2].x == x3 and group[2].y == y1 and group[3].x == group[2].x and group[3].y == group[1].y) then
          print("move down7")
          group[1].y = y3
          group[2].y = y2
          group[3].y = y3
        elseif(group[2].x == x3 and group[2].y == y1 and group[3].x == group[2].x and group[3].y == y2) then
          print("move down9")
          group[1].y = y3
          group[2].y = y2
          group[3].y = y3
        end
      elseif(group[1].x == x3 and group[1].y == y3) then
        if(group[1].x == group[3].x and group[3].y == y1 and group[3]. y == group[2].y) then
          print("move down4")
          group[1].y = y3
          group[2].y = y1
          group[3].y = y2
        end
      elseif(group[1].x == x3 and group[1].y == y2) then
        if(group[2].x == x2 and group[2].y == y1 and group[3].x == group[1].x and group[3].y == group[2].y) then
          print("move down14")
          group[1].y = y3
          group[3].y = y2
        end
      end
    end
    
    local function checkXLeftPosition(group, block)
      if(group[1].x == x1 and group[1].y == y3) then
        if(group[2].x == x2 and group[2].y == y1 and group[3].x == x3 and group[3].y == group[1].y) then
          print("move left")
          group[1].x = x1
          group[2].x = x2
          group[3].x = x2
        elseif(group[2].x == x3 and group[2].y == y1 and group[3].x == x2 and group[3].y == group[1].y) then
          print("move left11")
          group[2].x = x2
        end
      elseif(group[1].x == x2 and group[1].y == y3) then
        if(group[1].x == group[2].x and group[2].y == y1 and group[3].x == x3 and group[3].y == group[2].y) then
          print("move left1")
          group[1].x = x1
          group[2].x = x2
          group[3].x = x3
        elseif(group[2].x == group[1].x and group[2].y == y1 and group[3].x == x3 and group[3].y == y2) then
          print("move up3")
          group[1].x = x1
          group[2].x = x2
          group[3].x = x3
        elseif(group[2].x == group[1].x and group[2].y == y1 and group[3].x == x3 and group[3].y == group[1].y) then
          print("move left4")
          group[1].x = x1
          group[2].x = x2
          group[3].x = x2
        elseif(group[2].x == x3 and group[2].y == y1 and group[3].x == group[2].x and group[3].y == group[1].y) then
          print("move left7")
          group[1].x = x1
          group[2].x = x2
          group[3].x = x2
        elseif(group[2].x == x3 and group[2].y == y2 and group[3].x == group[2].x and group[3].y == group[1].y) then
          print("move left8")
          group[1].x = x1
          group[2].x = x3
          group[3].x = x2
        elseif(group[2].x == x3 and group[2].y == y1 and group[3].x == group[2].x and group[3].y == y2) then
          print("move left9")
          group[1].x = x1
          group[2].x = x2
          group[3].x = x3
        end
      elseif(group[1].x == x3 and group[1].y == y3) then
        if(group[1].x == group[3].x and group[3].y == y1 and group[3]. y == group[2].y) then
          print("move left2")
          group[1].x = x2
          group[2].x = x2
          group[3].x = x3
        elseif(group[2].x == x2 and group[2].y == y1 and group[3].x == group[1].x and group[3].y == y2) then
          print("move left13")
          group[1].x = x2
        elseif(group[2].x == group[1].x and group[3].x == group[1].x) then
          print("move left14")
          group[1].x = x2
          group[2].x = x2
        end
      end
    end
    
    local function checkXRightPosition(group, block)
      if(group[1].x == x1 and group[1].y == y3) then
        if(group[2].x == x2 and group[3].x == x3 and group[2].y == y1 and group[2].y == group[3].y) then
          print("move right1")
          group[1].x = x2
          group[2].x = x2
          group[3].x = x3
        elseif(group[2].x == x2 and group[2].y == y1 and group[3].x == x3 and group[3].y == y2) then
          print("move right2")
          group[1].x = x2
          group[2].x = x3
          group[3].x = x3
        elseif(group[2].x == x2 and group[2].y == y1 and group[3].x == x3 and group[3].y == group[1].y) then
          print("move right4")
          group[1].x = x2
          group[2].x = x3
          group[3].x = x3
        elseif(group[2].x == x2 and group[2].y == y1 and group[3].x == x2 and group[3].y == group[1].y) then
          print("move right5")
          group[1].x = x2
          group[2].x = x3
          group[3].x = x3
        elseif(group[2].x == x3 and group[2].y == y2 and group[3].x == x2 and group[3].y == group[1].y) then
          print("move right9")
          group[1].x = x2
          group[2].x = x3
          group[3].x = x3
        elseif(group[2].x == x3 and group[2].y == y1 and group[3].x == x2 and group[3].y == group[1].y) then
          print("move right12")
          group[1].x = x2
          group[3].x = x3
        end
      elseif(group[1].x == x2 and group[1].y == y3) then
        if(group[1].x == group[2].x and group[2].y == y1 and group[3].x == x3 and group[3].y == group[2].y) then
          print("move right3")
          group[1].x = x3
          group[2].x = x2
          group[3].x = x3
        elseif(group[2].x == group[1].x and group[2].y == y1 and group[3].x == x3 and group[3].y == y2) then
          print("move right4")
          group[1].x = x3
          group[2].x = x3
          group[3].x = x3
        elseif(group[2].x == group[1].x and group[2].y == y1 and group[3].x == x3 and group[3].y == group[1].y) then
          print("move right6")
          group[1].x = x2
          group[2].x = x3
          group[3].x = x3
        elseif(group[2].x == x3 and group[2].y == y1 and group[3].x == group[2].x and group[3].y == y2) then
          print("move right7")
          group[1].x = x3
          group[2].x = x3
          group[3].x = x3
        end
      elseif(group[1].x == x3 and group[1].y == y3) then
        if(group[2].x == x2 and group[2].y == y1 and group[3].x == group[1].x and group[3].y == y2) then
          print("move right13")
          group[2].x = x3
        end
      end
    end


    local dX = 0
    local dY = 0
    local count = 0

    local function handleSwipe( event )
        count = count + 1
        if event.phase == "moved" then 
          dX = event.x - event.xStart
          dY = event.y - event.yStart
          print("Start for loop")
          
          for i= 1, 1 do
            if count == 1 then
              if dX > 0 and dX > dY  then
                  print("move right")
                  checkXRightPosition(group, block)
                  return true
              elseif dX < 0 and dY > dX then
                  print("move left")
                  checkXLeftPosition(group, block)
                  return true
              elseif dY < 0 then
                  print("move up")
                  checkYUpPosition(group, block)
                  return true
              elseif dY > 0 then
                  print("move down")
                  checkYDownPosition(group, block)
                  return true
              end
            end
            print("End for loop")
            
          end
          
          print("Touches",count)
          return true  
        end
        print("Current count")
        count = 0
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