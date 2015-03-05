local storyboard = require("storyboard")
local scene = storyboard.newScene()

local widget = require( "widget" )
local mydata = require( "mydata" )
local physics = require("physics")
physics.start()

require("timer2")

--fix positions of dots in every grid (x and y coordinates)
local x1 = 90
local x2 = 245
local x3 = 400
local y1 = 255
local y2 = 400
local y3 = 550

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
  storyboard.showOverlay( "pause" ,{effect = "fade"  ,  params ={levelNum = "game5"}, isModal = true} )
  return true
end

local function reloadbtnTap(event)
  timer.cancel(gameTimer)
  time = 0
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
    --reloadBtn.destination = "game_levels"
    reloadBtn:addEventListener("tap", reloadbtnTap)
    sceneGroup:insert(reloadBtn)
  --/replay button
   
    -- start draw circle
    local circle1 = display.newCircle(400, 255, 50)
    circle1:setFillColor(100, 0, 250) 
    
    local circle2 = display.newCircle(400, 400, 50)
    circle2:setFillColor(100, 0, 250) 
    
    local circle3 = display.newCircle(400, 550, 50)
    circle3:setFillColor(100, 0, 250)
    
    local group = display.newGroup()
    group:insert(circle1)
    group:insert(circle2)
    group:insert(circle3)
    sceneGroup:insert( group)
    -- end circle
    
    --insert block 
    local block1 = display.newImage( "block_brick.png" )
    local block2 = display.newImage( "block_brick.png" )
    block1.x = 90; block1.y = 400
    block2.x = 245; block2.y = 400
    --scale the block
    block1:scale(0.59, 0.57)
    block2:scale(0.58, 0.57)
    physics.addBody( block1, "static", { isSensor=true, friction=0, bounce=0 } )
    physics.addBody( block2, "static", { isSensor=true, friction=0, bounce=0 } )
    sceneGroup:insert(block1)
    sceneGroup:insert(block2)
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
    
    local timeLimit = display.newText("Time Limit: 5 seconds", 100, 100, 'Marker Felt', 30)
    timeLimit.x = 170
    timeLimit.y = 670
    timeLimit:setTextColor(1,0,0)
    sceneGroup:insert(timeLimit)

    function displayTime(event)
      local params = event.source.params
      gameTimer.text = event.count
      if event.count < 5 then
        if (circle1.x == 90 and circle2.x == 245 and circle3.x == 90) and (circle1.y == 255 and circle2.y == 550 and circle3.y == 550) then
          timer.cancel(event.source)
          storyboard.showOverlay( "gameFinished" ,{effect = "fade", params ={levelNum = "game5"}, isModal = true} )
        end
      elseif event.count == 5 then
        timer.cancel(event.source)
        if (circle1.x == 90 and circle2.x == 245 and circle3.x == 90) and (circle1.y == 255 and circle2.y == 550 and circle3.y == 550) then
          storyboard.showOverlay( "gameFinished" ,{effect = "fade"  , params ={levelNum = "game5"}, isModal = true} )
        else 
          storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  , params ={levelNum = "game5"}, isModal = true} )
        end
      end
    end

    local tmr = timer.performWithDelay(1000, displayTime, 0)
    -- end timer
    
  local function checkXLeftPosition(group, block1, block2)
    for i=1, group.numChildren do
      if i == 1 then
        if(group[i].x == x3 and group[i].y == y2) then
          if(group[i].x == group[2].x and group[3].x == x2 and group[2].y == y3) then
            print("char")
            group[i].x = x3
            group[2].x = x2
            group[3].x = x1
          end
        end
      elseif i == 2 then
        if(group[i].x ~= block2.x and group[i].y == block2.y) then
          if(group[i].x == group[1].x) then
            if(group[i].x == group[3].x) then
              print("move left1")
              group[i].x = x3
              group[1].x = x2
              group[3].x = x2
            elseif(group[i].x ~= group[3].x) then
              print("move left2") 
              group[i].x = x3
              group[1].x = x2
              group[3].x = x1
            end
          elseif(group[i].x == group[3].x) then
            if(group[1].x == x2 and group[3].y == y3) then
              print("move left3")
              group[i].x = x3
              group[1].x = x1
              group[3].x = x2
            end
          elseif(group[i].x ~= group[1].x and group[i].x ~= group[3].x and group[1].x == group[3].x and group[1].x == x2) then
            print("left")
            group[i].x = x3
            group[1].x = x1
            group[3].x = x1
          elseif(group[i].x ~= group[1].x and group[i].x ~= group[3].x and group[1].x == group[3].x and group[1].x == x1) then
            print("move left4")
            group[i].x = x3
            group[1].x = x1
            group[3].x = x1
          elseif(group[1].x == x2 and group[3].x == x1) then--
            print("move left5")
            group[i].x = x3
            group[1].x = x1
            group[3].x = x1
          elseif(group[1].x == x1 and group[3].x == x2) then
            print("move left6")
            group[i].x = x3
            group[1].x = x1
            group[3].x = x1
            
          end
        elseif(group[i].x == x2 and group[i].y == y1) then
          if(group[i].y == group[1].y) then
            if(group[1].x == x1 and group[i].x == group[3].x) then
              print("move left7")
              group[i].x = x2
              group[1].x = x1
              group[3].x = x1
            end
          end
        elseif(group[i].x == x3 and group[i].y == y3) then
          if(group[1].x == group[3].x and group[1].x == x2 and group[1].y == y1) then
            print("Move lefttt")
            group[i].x = x2
            group[1].x = x1
            group[3].x = x1
          elseif(group[1].x == x3 and group[1].y == y1) then
            if(group[1].y == y1 and group[1].x == x3) then
              print("move left over")
              group[i].x = x2
              group[1].x = x2
              group[3].x = x1
            elseif(group[1].y == y2 and group[1].x == x3) then
              print("move left8")
              print("ok")
              group[i].x = x2
              group[1].x = x3
              group[3].x = x1
            end
          elseif(group[1].x == x3 and group[1].y == y2 and group[3].x == x1 and group[3].y == y3) then
              print("oks")
              group[i].x = x2
              group[1].x = x3
              group[3].x = x1 
          elseif(group[1].x == x1 and group[3].x == x2) then
            print("move left9")
            group[i].x = x2
            group[1].x = x1
            group[3].x = x1
          elseif(group[1].x == group[3].x and group[1].x == x1) then
            print("move left")
            group[i].x = x2
            group[1].x = x1
            group[3].x = x1
          end
        elseif(group[i].x == x3 and group[i].y == y1) then
          if(group[i].y == group[1].y and group[1].x == x2) then
            if(group[i].x == group[3].x and group[3].y == y2)then
              print("move left0")
              group[i].x = x2
              group[1].x = x1
              group[3].x = x3            
            end
          elseif(group[1].x == group[3].x and group[1].x == x1) then
            print("move left")
            group[i].x = x2
            group[1].x = x1
            group[3].x = x1
          end
        elseif(group[i].x == x2 and group[i].y == y3) then
          if(group[i].y == group[3].y) then
            if(group[1].x == x1) then
              print("don't move")
            elseif(group[1].x == x2 and group[1].y == y1) then
              print("move left11")
              group[i].x = x2
              group[1].x = x1
              group[3].x = x1
            elseif(group[1].x == x3 and group[1].y == y1) then
              print("move left12")
              group[i].x = x2
              group[1].x = x2
              group[3].x = x1
            end
          elseif(group[1].x == x3 and group[1].y == y2 and group[3].x == x1 and grou[3].y == y3) then
            print("don't move13")
            group[i].x = x2
            group[1].x = x3
            group[3].x = x1
          end
        end
      elseif i == 3 then
         
      end
    end
    return true
  end

  local function checkXRightPosition(group, block1, block2)
    for i=1, group.numChildren do
      if i ==1 then
      elseif i == 2 then
        if(group[i].x ~= block2.x and group[i].y == block2.y) then
          if(group[i].x == group[1].x) then
            if(group[i].x == group[3].x) then
              print("dont move")
            elseif(group[3].x == x2) then
              print("move right") 
              group[i].x = x3
              group[1].x = x3
              group[3].x = x3
            elseif(group[3].x == x1) then
              print("move right") 
              group[i].x = x3
              group[1].x = x3
              group[3].x = x2
            end
          elseif(group[i].x == group[3].x) then
            if(group[1].x == x2 and group[3].y == y3) then
              print("move right")
              group[i].x = x3
              group[1].x = x3
              group[3].x = x3
            end
          elseif(group[i].x ~= group[1].x and group[i].x ~= group[3].x and group[1].x == group[3].x and group[1].x == x2) then
            print("Move right")
            group[i].x = x3
            group[1].x = x3
            group[3].x = x3
          elseif(group[i].x ~= group[1].x and group[i].x ~= group[3].x and group[1].x == group[3].x and group[1].x == x1) then
            print("move right")
            group[i].x = x3
            group[1].x = x2
            group[3].x = x2
          elseif(group[1].x == x2 and group[3].x == x1) then
            print("move right")
            group[i].x = x3
            group[1].x = x3
            group[3].x = x2
          elseif(group[1].x == x1 and group[3].x == x2) then
            print("move right")
            group[i].x = x3
            group[1].x = x2
            group[3].x = x3
          end
        elseif(group[i].x == x2 and group[i].y == y1) then
          if(group[i].y == group[1].y) then
            if(group[1].x == x1 and group[i].x == group[3].x) then
              print("move right")
              group[i].x = x3
              group[1].x = x2
              group[3].x = x3
            elseif(group[1].x == x1 and group[1].x == group[3].x) then
              print("move right")
              group[i].x = x3
              group[1].x = x2
              group[3].x = x2
            end
          end
        elseif(group[i].x == x3 and group[i].y == y3) then
          if(group[i].y == group[3].y ) then
            if(group[1].x == x1) then
              print("Move right")
              group[i].x = x3
              group[1].x = x2
              group[3].x = x2
            elseif(group[1].x == x2) then
              print("Move right")
              group[i].x = x3
              group[1].x = x3
              group[3].x = x2
            end
          elseif(group[1].x == group[3].x and group[1].x == x1) then
            print("move right")
            group[i].x = x3
            group[1].x = x2
            group[3].x = x2
          end
        elseif(group[i].x == x3 and group[i].y == y1) then
          if(group[1].x == group[3].x and group[1].x == x2) then
            print("move right")
            group[i].x = x3
            group[1].x = x2
            group[3].x = x3
          elseif(group[1].x == x1 and group[3].x == x2) then
            print("move right")
            group[i].x = x3
            group[1].x = x2
            group[3].x = x3
          elseif(group[1].x == group[3].x and group[1].x == x1) then
            print("move right")
            group[i].x = x3
            group[1].x = x2
            group[3].x = x2
          end
        elseif(group[i].x == x2 and group[i].y == y3) then
          if(group[i].y == group[3].y) then
            if(group[1].x == x1) then
              print("move right")
              group[i].x = x3
              group[1].x = x2
              group[3].x = x2
            elseif(group[1].x == x2) then
              print("move right")
              group[i].x = x3
              group[1].x = x3
              group[3].x = x2
            elseif(group[1].x == x3) then
              print("move right")
              group[i].x = x3
              group[1].x = x3
              group[3].x = x2
            end
          end
        end
      elseif i == 3 then
      end
    end
    return true
  end

  local function checkYUpPosition(group, block1, block2)
    for i = 1, group.numChildren do
      if i ==1 then
      elseif i == 2 then
        if(group[i].x ~= block2.x and group[i].y == block2.y) then
          if(group[i].x == group[1].x and group[i].x == group[3].x) then
            print("Don't move")
          elseif(group[i].x ~= group[1].x and group[i].x ~= group[3].x and group[1].x == group[3].x and group[1].x == x2) then
            print("Move up")
            group[i].y = y1
            group[1].y = y1
            group[3].y = y3
          elseif(group[i].x ~= group[1].x and group[i].x ~= group[3].x and group[1].x == group[3].x and group[1].x == x1) then
            print("Move up")
            group[i].y = y1
            group[1].y = y1
            group[3].y = y3
          elseif(group[1].x == x2 and group[3].x == x1) then
            print("move up")
            group[i].y = y1
            group[1].y = y1
            group[3].y = y3
          elseif(group[i].x == group[3].x) then
            if(group[1].x == x2 and group[3].y == y3) then
              print("move up")
              group[i].y = y1
              group[1].y = y1
              group[3].y = y2
            end
          elseif(group[1].x == x1 and group[3].x == x2) then
            print("move up")
            group[i].y = y1
            group[1].y = y1
            group[3].y = y3
          end
        elseif(group[i].x == x3 and group[i].y == y1) then
          if(group[i].y == group[1].y) then
            if(group[3].x == x3) then
              print("move up")
              group[i].y = y1
              group[1].y = y1
              group[3].y = y2
            end
          end
        elseif(group[i].x == x3 and group[i].y == y3) then
          if(group[1].x == group[3].x and group[1].x == x2) then
            print("Move up")
            group[i].y = y2
            group[1].y = y1
            group[3].y = y3
          elseif(group[i].x == group[1].x ) then
            if(group[1].y == y1) then
              print("move up")
              group[i].y = y2
              group[1].y = y1
              group[3].y = y3
            elseif(group[1].y == y2) then
              print("move up")
              group[i].y = y2
              group[1].y = y1
              group[3].y = y3
            end
          elseif(group[1].x == group[3].x and group[1].x == x1) then
            print("move up")
            group[i].y = y2
            group[1].y = y1
            group[3].y = y3
          elseif(group[1].x == x1 and group[3].x == x2) then
            print("move up")
            group[i].y = y2
            group[1].y = y1
            group[3].y = y3
          end
        elseif(group[i].x == x2 and group[i].y == y3) then
          if(group[i].y == group[3].y and group[1].y == y2) then
            print("move up")
            group[i].y = y3
            group[1].y = y1
            group[3].y = y3
          elseif(group[i].y == group[1].y and group[i].y == group[3].y) then
            print("move up")
            group[i].y = y3
            group[1].y = y2
            group[3].y = y3
          end
        end
      elseif i == 3 then
      end
    end 
    return true
  end

  local function checkYDownPosition(group, block1, block2)
    for i = 1, group.numChildren do
      if i ==1 then
      elseif i == 2 then
        if(group[i].x ~= block2.x and group[i].y == block2.y) then
          if(group[i].x == group[1].x) then
            if(group[i].x == group[3].x) then
              print("dont move")
            elseif(group[i].x ~= group[3].x) then
              print("move down") 
              group[i].y = y3
              group[1].y = y2
              group[3].y = y3
            end
          elseif(group[i].x ~= group[1].x and group[i].x ~= group[3].x and group[1].x == group[3].x and group[1].x == x2) then
            print("Move down")
            group[i].y = y3
            group[1].y = y1
            group[3].y = y3
          elseif(group[i].x ~= group[1].x and group[i].x ~= group[3].x and group[1].x == group[3].x and group[1].x == x1) then
            print("Move down")
            group[i].y = y3
            group[1].y = y1
            group[3].y = y3
          elseif(group[1].x == x2 and group[3].x == x1) then
            print("move down")
            group[i].y = y3
            group[1].y = y1
            group[3].y = y3
          elseif(group[1].x == x1 and group[3].x == x2) then
            print("move down")
            group[i].y = y3
            group[1].y = y1
            group[3].y = y3
          end
        elseif(group[i].x == x3 and group[i].y == y1) then
          if(group[i].y == group[1].y) then
            if(group[3].x == x3) then
              print("move down")
              group[i].y = y2
              group[1].y = y1
              group[3].y = y3
            elseif(group[1].x == x1 and group[3].x == x2) then
              print("move down")
              group[i].y = y2
              group[1].y = y1
              group[3].y = y3
            elseif(group[1].x == x2 and group[3].x == x2) then
              print("move down")
              group[i].y = y2
              group[1].y = y1
              group[3].y = y3
            elseif(group[1].x == group[3].x and group[1].x == x1) then
              print("move down")
              group[i].y = y2
              group[1].y = y1
              group[3].y = y3
            end
          end
        elseif(group[i].x == x3 and group[i].y == y3) then
          if(group[i].x == group[1].x ) then
            if(group[1].y == y1) then
              print("move down")
              group[i].y = y3
              group[1].y = y2
              group[3].y = y3
            end
          end
        elseif(group[i].x == x3 and group[i].y == y1) then
          if(group[1].x == group[3].x and group[1].x == x2) then
            print("move down")
            group[i].y = y2
            group[1].y = y1
            group[3].y = y3
          elseif(group[1].x == x2 and group[3].x == x2) then
            print("move down")
            group[i].y = y2
            group[1].y = y1
            group[3].y = y3
          end
        elseif(group[i].x == x2 and group[i].y == y3) then
          if(group[i].y == group[3].y and group[1].y == y2) then
            print("move down")
            group[i].y = y3
            group[1].y = y3
            group[3].y = y3
          end
        end
      elseif i == 3 then
      end
    end
    return true
  end
    
    --move dots
    local CENTERX = display.contentWidth - 450
    local CENTERY = display.contentHeight - 700
    local LEFT = 9
    local RIGHT = 150
    local UP = 50
    local DOWN = 150
    

    local function handleSwipe( event )
        if ( event.phase == "moved" ) then
            local dX = event.x - event.xStart
            --print( event.x, event.xStart, dX )
            if ( dX > 5 ) then
                --swipe right
                --local spot = RIGHT
                checkXRightPosition(group, block1, block2)
                if ( event.target.x == LEFT ) then
                    spot = CENTERX 
                elseif(event.target.x == RIGHT) then
                  checkXRightPosition(group, block1, block2)
                  --spot = RIGHT
                end
                transition.to( event.target, { time=2500, x=spot } )
            elseif ( dX  < -20 ) then
                --swipe left
                --local spot = LEFT
                checkXLeftPosition(group, block1, block2)
                if ( event.target.x == RIGHT ) then
                  spot = CENTERX 
                elseif(event.target.x == LEFT) then
                  checkXLeftPosition(group, block1, block2)
                end
                transition.to( event.target, { time=2500, x=spot } )
            end
            --y-axis(up and down movement) = 
            local dY = event.y - event.yStart
            if (dY > 10) then
              --local spot = DOWN 
              checkYDownPosition(group, block1, block2)
              if ( event.target.y == UP )  then
                  spot = CENTERY
              elseif( event.target.y == DOWN) then
                  checkYDownPosition(group, block1, block2)
                  print(group.x )
                  print(group.y)
              end
              transition.to( event.target, { time = 2500, y = spot } )
            elseif ( dY < -10 ) then
              --local spot = UP
              checkYUpPosition(group, block1, block2)
              if ( event.target.y == DOWN) then
                  spot = CENTERY
              elseif(event.target.y == UP) then
                checkYUpPosition(group, block1, block2) 
                
              end
              transition.to( event.target, { time = 2500, y = spot } )
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
