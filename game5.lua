local storyboard = require("storyboard")
local scene = storyboard.newScene()
require("timer2")
local widget = require( "widget" )
local mydata = require( "mydata" )
local physics = require("physics")
physics.start()

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
  timer.cancel()
  storyboard.gotoScene (  event.target.destination, {effect = "crossFade", time = 333} )
  return true
end

local function reloadbtnTap(event)
  timer.cancel()
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

  local level5 = display.newText( "Level 5", 100, 100, native.systemFont, 55 )
  level5.x = display.contentCenterX
  level5.y = display.contentCenterY - 350
  level5:setTextColor(black)
  sceneGroup:insert( level5 )
    
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
  local displayTimeUsed = display.newText("Time: ", 100, 100, 'Marker Felt', 30)
  displayTimeUsed.x = 50
  displayTimeUsed.y = 130
  displayTimeUsed:setTextColor(1,0,0)
  sceneGroup:insert(displayTimeUsed)

  local gameTimer = display.newText("0", 100, 100, native.systemFont, 30)
  gameTimer.x = 110
  gameTimer.y = 130
  gameTimer:setTextColor(1,0,0)
  sceneGroup:insert( gameTimer )
    
  local timeLimit = display.newText("Limit: 10 sec", 100, 100, 'Marker Felt', 30)
  timeLimit.x = 370
  timeLimit.y = 130
  timeLimit:setTextColor(1,0,0)
  sceneGroup:insert(timeLimit)

  function displayTime(event)
    local params = event.source.params
    gameTimer.text = event.count
    if (circle1.x == 90 and circle2.x == 245 and circle3.x == 90) and (circle1.y == 255 and circle2.y == 550 and circle3.y == 550) then
      if(event.count >= 0 and event.count <= 4) then
        mydata.settings.levels[5].stars = 3
        timer.cancel(event.source)
        mydata.settings.unlockedLevels = 5
        storyboard.showOverlay( "gameFinished" ,{effect = "fade", time = 500  ,  params ={levelNum = "game5"}, isModal = true} )
      elseif(event.count >= 5 and event.count <= 8) then
        mydata.settings.levels[5].stars = 2
        timer.cancel(event.source)
        mydata.settings.unlockedLevels = 5
        storyboard.showOverlay( "gameFinished" ,{effect = "fade", time = 500  ,  params ={levelNum = "game5"}, isModal = true} )
      elseif(event.count >= 9 and event.count <= 10) then
        mydata.settings.levels[5].stars = 1
        timer.cancel(event.source)
        mydata.settings.unlockedLevels = 5
        storyboard.showOverlay( "gameFinished" ,{effect = "fade", time = 500  ,  params ={levelNum = "game5"}, isModal = true} )
      elseif(event.count > 10) then
        mydata.settings.levels[5].stars = 0
        timer.cancel(event.source)
        storyboard.showOverlay( "popupalert_fail" ,{effect = "fade", time = 500  ,  params ={levelNum = "game5"}, isModal = true} )
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
  
  --dot movements(checking)
  local function tapUp(event)
    checkYUpPosition(group, block1, block2)
    return true
  end

  local function tapDown(event)
    checkYDownPosition(group, block1, block2)
    return true
  end

  local function tapLeft(event)
    checkXLeftPosition(group, block1, block2)
    return true
  end

  local function tapRight(event)
    checkXRightPosition(group, block1, block2)
    return true
  end
--
   --pauseBtn na event , apil ang overlay modal
  local function pausebtnTap(event)
    event.target.xScale = 0.95
    event.target.yScale = 0.95
    timer.pause(tmr)
    
    --modal
    local backgroundOverlay = display.newRect (sceneGroup, 0, 0, 1200, 1700)
		backgroundOverlay:setFillColor( black )
		backgroundOverlay.alpha = 0.6
		backgroundOverlay.isHitTestable = true
		backgroundOverlay:addEventListener ("tap", catchBackgroundOverlay)
		backgroundOverlay:addEventListener ("touch", catchBackgroundOverlay)
    sceneGroup:insert (backgroundOverlay)

    local overlay = display.newImage ("images/popupOverlay.png", 400 , 500)
		overlay.x = 300
		overlay.y = 400
		sceneGroup:insert (overlay)
        
    local message = display.newImageRect ("images/gamePaused.png", 420, 150)
		message.x = 250
		message.y = 250
		sceneGroup:insert(message)

    local reloadBtn = display.newImageRect ("images/reload.png" ,280, 50)
		reloadBtn.x = 250 
		reloadBtn.y = 480
		params = event.params
    reloadBtn.destination = "game2"
		reloadBtn:addEventListener ("tap", reloadbtnTap)
		sceneGroup:insert (reloadBtn)
        
    local mainMenu = display.newImageRect ("images/mainMenu.png" ,260, 50)
		mainMenu.x = 250 
		mainMenu.y = 550
		params = event.params
		mainMenu.destination = "menu"
		mainMenu:addEventListener ("tap", btnTap)
		sceneGroup:insert (mainMenu)
    print("paused")
    
    
    local resumeBtn = display.newImageRect ("images/resumeBtn.png", 230, 50)
		resumeBtn.x = 250
		resumeBtn.y = 410
		local function hideOverlay(event)
      timer.resume(tmr)
      storyboard.hideOverlay("fade", 333)
      overlay:removeSelf()
      backgroundOverlay:removeSelf()
      message:removeSelf()
      resumeBtn:removeSelf()
      reloadBtn:removeSelf()
      mainMenu:removeSelf()
		end           
		resumeBtn:addEventListener ("tap", hideOverlay)
    sceneGroup:insert(resumeBtn)
    return true
    --and sa modal
  end
  --end sa pauseBtn na event
  
  --buttons
  local pauseBtn = widget.newButton{
    width = 70,
    height = 70,
    defaultFile = "images/pauseBtn.png"
  }
  pauseBtn.x = display.contentWidth - 430
  pauseBtn.y = 710
  pauseBtn:addEventListener("tap", pausebtnTap)
  sceneGroup:insert(pauseBtn)
  
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
  
  local reloadBtn = widget.newButton{
    width = 70,
    height = 70,
    defaultFile = "images/reloadBtn.png"
  }
  reloadBtn.x = display.contentWidth - 50
  reloadBtn.y = 710
  reloadBtn.destination = "game5"
  reloadBtn:addEventListener("tap", reloadbtnTap)
  sceneGroup:insert(reloadBtn)
  
  local upBtn = display.newImageRect ("images/up.png" ,70, 70)
  upBtn.x = 240 
	upBtn.y = 670
  upBtn:addEventListener("tap", tapUp)
	sceneGroup:insert (upBtn)
  
  local downBtn = display.newImageRect ("images/down.jpg" ,70, 70)
  downBtn.x = 240 
	downBtn.y = 760
  downBtn:addEventListener("tap", tapDown)
	sceneGroup:insert (downBtn)
  
  local leftBtn = display.newImageRect ("images/left.png" ,70, 70)
  leftBtn.x = 150 
	leftBtn.y = 710
  leftBtn:addEventListener("tap", tapLeft)
	sceneGroup:insert (leftBtn)
  
  local rightBtn = display.newImageRect ("images/right.png" ,70, 70)
  rightBtn.x = 330 
	rightBtn.y = 710
  rightBtn:addEventListener("tap", tapRight)
	sceneGroup:insert (rightBtn)

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