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
  storyboard.showOverlay( "pause" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
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
    
    --lower rect
    --[[
    local levelDown = display.newRect(0, 0, 1200, 180)
    levelDown.x = 0
    levelDown.y = 800
    levelDown:setFillColor(0, 255, 255)
    sceneGroup:insert(levelDown)
    --]]
  --/lower rect
    
    local level1 = display.newText( "Level 2", 100, 100, native.systemFont, 55 )
    level1.x = display.contentCenterX
    level1.y = display.contentCenterY - 350
    --level1:setFillColor(69, 242, 245)
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
    
    grid[5]:setFillColor(1, 104/255, 1)
    grid[6]:setFillColor(1, 104/255, 1)
    grid[9]:setFillColor(1, 104/255, 1)
    
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
  pauseBtn.x = display.contentWidth - 150
  pauseBtn.y = display.contentHeight - 670
  pauseBtn.destination = "pause"
  pauseBtn:addEventListener("tap", pausebtnTap)
  sceneGroup:insert(pauseBtn)
  --/pause button
  
  --replay button
  local reloadBtn = widget.newButton{
    width = 70,
    height = 70,
    defaultFile = "images/reloadBtn.png"
  }
  reloadBtn.x = display.contentWidth - 50
  reloadBtn.y = display.contentHeight - 670
  reloadBtn.destination = "game2"
  reloadBtn:addEventListener("tap", reloadbtnTap)
  sceneGroup:insert(reloadBtn)
  --/replay button
  
    -- start draw circle
    local circle1 = display.newCircle(90, 255, 50)
    circle1:setFillColor(100, 0, 250) 
    
    local circle2 = display.newCircle(245, 255, 50)
    circle2:setFillColor(100, 0, 250) 
    
    local circle3 = display.newCircle(400, 255, 50)
    circle3:setFillColor(100, 0, 250)
    
    local group = display.newGroup()
    group:insert(circle1)
    group:insert(circle2)
    group:insert(circle3)
     --physics.addBody(group, {density=0, friction=0, bounce=0})
    group.numTouches = 0
    sceneGroup:insert( group)
    
    -- end circle
    
    --insert block 
    --block 1
    local block1 = display.newImage( "block_brick.png" )
    block1.x = 90; block1.y = 400
    block1:scale(0.6, 0.57)
    physics.addBody( block1, "static", { isSensor=true, friction=0, bounce=0 } )
    sceneGroup:insert(block1)
    --block 2
    local block2 = display.newImage( "block_brick.png" )
    block2.x = 245; block2.y = 550
    block2:scale(0.6, 0.57)
    physics.addBody( block2, "static", { isSensor=true, friction=0, bounce=0 } )
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
    sceneGroup:insert(gameTimer)
    
    local timeLimit = display.newText("Time Limit: 10 seconds", 100, 100, 'Marker Felt', 30)
    timeLimit.x = 170
    timeLimit.y = 670
    timeLimit:setTextColor(1,0,0)
    sceneGroup:insert(timeLimit)

    function displayTime(event)
      local params = event.source.params
      gameTimer.text = event.count
      if (circle1.x == 245 and circle2.x == 400 and circle3.x == 400) and (circle1.y == 400 and circle2.y == 400 and circle3.y == 550) then
        --determines the amount of star to be given
        if(event.count >= 0 and event.count <= 4) then
            mydata.settings.levels[2].stars = 3
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 5 and event.count <= 8) then
            mydata.settings.levels[2].stars = 2
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 9 and event.count <= 10) then
            mydata.settings.levels[2].stars = 1
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count > 10) then
            timer.cancel(event.source)
            storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        end
            
      elseif(circle1.x == x2 and circle2.x == x3 and circle3.x == x3) and (circle1.y == y2 and circle2.y == y3 and circle3.y == y2) then
        if(event.count >= 0 and event.count <= 4) then
            mydata.settings.levels[2].stars = 3
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 5 and event.count <= 8) then
            mydata.settings.levels[2].stars = 2
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 9 and event.count <= 10) then
            mydata.settings.levels[2].stars = 1
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count > 10) then
            timer.cancel(event.source)
            storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        end
      elseif(circle1.x == x3 and circle2.x == x3 and circle3.x == x2) and (circle1.y == y2 and circle2.y == y3 and circle3.y == y2) then
        if(event.count >= 0 and event.count <= 4) then
            mydata.settings.levels[2].stars = 3
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 5 and event.count <= 8) then
            mydata.settings.levels[2].stars = 2
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 9 and event.count <= 10) then
            mydata.settings.levels[2].stars = 1
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count > 10) then
            timer.cancel(event.source)
            storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        end
      elseif(circle1.x == x3 and circle2.x == x3 and circle3.x == x2) and (circle1.y == y3 and circle2.y == y2 and circle3.y == y2) then
        if(event.count >= 0 and event.count <= 4) then
            mydata.settings.levels[2].stars = 3
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 5 and event.count <= 8) then
            mydata.settings.levels[2].stars = 2
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 9 and event.count <= 10) then
            mydata.settings.levels[2].stars = 1
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count > 10) then
            timer.cancel(event.source)
            storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        end
      elseif(circle1.x == x3 and circle2.x == x2 and circle3.x == x3) and (circle1.y == y2 and circle2.y == y2 and circle3.y == y3) then
        if(event.count >= 0 and event.count <= 4) then
            mydata.settings.levels[2].stars = 3
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 5 and event.count <= 8) then
            mydata.settings.levels[2].stars = 2
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 9 and event.count <= 10) then
            mydata.settings.levels[2].stars = 1
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count > 10) then
            timer.cancel(event.source)
            storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        end
      elseif(circle1.x == x3 and circle2.x == x2 and circle3.x == x3) and (circle1.y == y3 and circle2.y == y2 and circle3.y == y2) then
        if(event.count >= 0 and event.count <= 4) then
            mydata.settings.levels[2].stars = 3
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 5 and event.count <= 8) then
            mydata.settings.levels[2].stars = 2
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count >= 9 and event.count <= 10) then
            mydata.settings.levels[2].stars = 1
            timer.cancel(event.source)
            mydata.settings.unlockedLevels = 3
            storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        elseif(event.count > 10) then
            mydata.settings.levels[2].stars = 0
            timer.cancel(event.source)
            storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  ,  params ={levelNum = "game2"}, isModal = true} )
        end
      end
    end
    
    local tmr = timer.performWithDelay(1000, displayTime, 0)

    -- end timer
    
    --physics part(checks left, right, up and down positions of every dot with respect to toher dots and to blocks)
  local function checkXLeftPosition(group, block1, block2, block3)
  for i=1, group.numChildren do
    if i == 1 then
      if(group[i].x == block1.x) then
          if(group[i].y == group[2].y and group[i].y == group[3].y) then
            print("Don't move!")
          elseif(group[i].y == group[2].y and group[2].x == group[3].x and group[3].y == block1.y) then
            print("Don't move")
          elseif(group[i].y == group[2].y and group[2].x ~= group[3].x and group[3].y == block1.y ) then
            group[i].x = x1
            group[2].x = x2
            group[3].x = x2
          elseif(group[i].y == group[2].y and group[2].x ~= group[3].x and group[3].y ~= block1.y) then
            group[i].x = x1
            group[2].x = x2
            group[3].x = x3
          elseif(group[i].y == group[3].y and group[3].x == group[2].x and group[2].y == block1.y) then
            group[i].x = x1
            group[2].x = x2
            group[3].x = x2
          elseif(group[i].y == group[3].y and group[3].x ~= group[2].x and group[2].y == block1.y) then
            group[i].x = x1
            group[2].x = x2
            group[3].x = x2
          elseif(group[i].y == group[3].y and group[3].x ~= group[2].x and group[2].y ~= block1.y) then
            group[i].x = x1
            group[2].x = x3
            group[3].x = x2
          elseif(group[i].y ~= group[2].y and group[i].y ~= group[3].y and group[2].y ~= group[3].y and group[2].y == block1.y) then
            group[i].x = x1
            group[2].x = x2
            group[3].x = x3
          elseif(group[i].x ~= group[2].x and group[i].x ~= group[3].x and group[2].y == group[3].y and group[2].y == block1.y) then
            group[i].x = x1
            group[2].x = x2
            group[3].x = x3
          end
          --feb 26
      elseif(group[i].x == x2 and group[i].y == y1) then
        if(group[i].y == group[2].y and group[2].x == group[3].x and group[3].y == block1.y and group[3].x ~= block1.x)then
          group[i].x = x1
          group[2].x = x2
          group[3].x = x2
        elseif(group[i].y == group[3].y and group[3].x == group[2].x and group[2].y == block1.y and group[2].x ~= block1.x) then
          group[i].x = x1
          group[2].x = x2
          group[3].x = x2
        elseif(group[i].y ~= group[2].y and group[i].x ~= group[2].x and group[2].x == group[3].x and group[2].x ~= block1.x and group[2].y == block1.y) then
          group[i].x = x1
          group[2].x = x2
          group[3].x = x3
          return true
        elseif(group[i].y ~= group[3].y and group[i].x ~= group[3].x and group[3].x == group[2].x and group[3].x ~= block1.x and group[3].y == block1.y) then
          group[i].x = x1
          group[2].x = x3
          group[3].x = x2 
        elseif(group[i].y ~= group[2].y and group[i].x == group[2].x and  group[i].x ~= group[3].x and group[2].y == group[3].y and group[3].x ~= block1.x) then
          group[i].x = x1
          group[2].x = x2
          group[3].x = x3 
        elseif(group[i].y ~= group[3].y and group[i].x == group[3].x and group[3].y == group[2].y and group[2].x ~= block1.x) then
          group[i].x = x1
          group[2].x = x3
          group[3].x = x2
          return true
        elseif(group[i].x == group[2].x and group[2].x ~= group[3].x and group[3].x ~= block1.x and group[3].y == block2.y) then
          group[i].x = x1
          group[2].x = x2
          group[3].x = x3 
        elseif(group[i].x == group[3].x and group[3].x ~= group[2].x and group[2].x ~= block1.x and group[2].y == block2.y) then
          group[i].x = x1
          group[2].x = x3
          group[3].x = x2 
        elseif(group[i].x == group[2].x and group[i].y == group[3].y and group[2].y == block1.y and group[2].x ~= group[3].x and group[3].x ~= block1.x) then
          group[i].x = x1
          group[2].x = x2
          group[3].x = x2 
        end
      elseif(group[i].x == x3 and group[i].y == y1) then
        if(group[i].x == group[2].x and group[i].x == group[3].x and group[2].y == block1.y ) then
          group[i].x = x2
          group[2].x = x2
          group[3].x = x3 
        elseif(group[i].x == group[3].x and group[i].x ~= group[2].x and group[2].y == group[3].y and group[2].y == block1.y) then
          group[i].x = x2
          group[2].x = x2
          group[3].x = x3 
        elseif(group[i].y == group[2].y and group[i].x  == group[3].x and group[3].y == block1.y) then
            group[i].x = x2
            group[2].x = x1
            group[3].x = x2 
        end 
      end

    elseif i == 2 then
      -- do
          if(group[i].y == group[1].y and group[i].y == group[3].y) then
            print("Don't move!")
          elseif(group[i].x == block1.x and group[i].y == group[1].y and group[1].x == group[3].x and group[3].y == block1.y) then
            print("Don't move")
          elseif(group[i].x == block1.x and group[i].y == group[1].y and group[1].x ~= group[3].x and group[3].y == block1.y ) then
            group[i].x = x1
            group[1].x = x2
            group[3].x = x2
          elseif(group[i].x == block1.x and group[i].y == group[1].y and group[1].x ~= group[3].x and group[3].y ~= block1.y) then
            group[i].x = x1
            group[1].x = x2
            group[3].x = x3
          elseif(group[i].x == block1.x and group[i].y == group[3].y and group[3].x == group[1].x and group[1].y == block1.y) then
            group[i].x = x1
            group[1].x = x2
            group[3].x = x2
          elseif(group[i].x == block1.x and group[i].y == group[3].y and group[3].x ~= group[1].x and group[1].y == block1.y) then
            group[i].x = x1
            group[1].x = x2
            group[3].x = x2
          elseif(group[i].x == block1.x and group[i].y == group[3].y and group[3].x ~= group[1].x and group[1].y ~= block1.y) then
            group[i].x = x1
            group[1].x = x3
            group[3].x = x2
          end

    elseif i == 3 then
      -- do
          if(group[i].x == block1.x) then
            if(group[i].y == group[1].y and group[i].y == group[2].y) then
              print ("Don't move")
            elseif(group[i].y == group[1].y and group[1].x == group[2].x and group[2].y == block1.y) then
              print("Don't move!")
            elseif(group[i].y == group[1].y and group[1].x ~= group[2].x and group[2].y == block1.y) then
              group[i].x = x1
              group[1].x = x2
              group[2].x = x2
            elseif(group[i].y == group[1].y and group[1].x ~= group[2].x and group[2].y ~= block1.y) then
              group[i].x = x1
              group[1].x = x2
              group[2].x = x3
            elseif(group[i].y == group[2].y and group[2].x == group[1].x and group[1].y == block1.y) then
              group[i].x = x1
              group[1].x = x2
              group[2].x = x2
            elseif(group[i].y == group[2].y and group[2].x ~= group[1].x and group[1].y == block1.y) then
              group[i].x = x1
              group[1].x = x2
              group[2].x = x2
            elseif(group[i].y == group[2].y and group[2].x ~= group[1].x and group[1].y ~= block1.y) then
              group[i].x = x1
              group[1].x = x3
              group[2].x = x2
            end
          end
    end
  end
end

local function checkXRightPosition(group, block1, block2, block3)
  for i=1, group.numChildren do
    if i == 1 then
      if (group[i].x == block1.x ) then
          if(group[i].y == group[2].y and group[i].y == group[3].y) then
            print("Don't move!")
          elseif(group[i].y == group[2].y and group[2].x == group[3].x and group[3].y == block1.y) then
            group[i].x = x2
            group[2].x = x3
            group[3].x = x3
          elseif(group[i].y == group[2].y and group[2].x ~= group[3].x and group[3].y == block1.y ) then
            group[i].x = x2
            group[2].x = x3
            group[3].x = x3
          elseif(group[i].y == group[2].y and group[2].x ~= group[3].x and group[3].y ~= block1.y) then
            group[i].x = x2
            group[2].x = x3
            group[3].x = x3
          elseif(group[i].y == group[3].y and group[3].x == group[2].x and group[2].y == block1.y) then
            group[i].x = x2
            group[2].x = x3
            group[3].x = x3
          elseif(group[i].y == group[3].y and group[3].x ~= group[2].x and group[2].y == block1.y) then
            group[i].x = x2
            group[2].x = x3
            group[3].x = x3
            return true
          elseif(group[i].y == group[3].y and group[3].x ~= group[2].x and group[2].y ~= block1.y) then
            group[i].x = x2
            group[2].x = x3
            group[3].x = x3
          elseif(group[i].y ~= group[2].y and group[i].y ~= group[3].y and group[2].y ~= group[3].y and group[2].y == block1.y) then
            group[i].x = x2
            group[2].x = x3
            group[3].x = x3
          elseif(group[i].x ~= group[2].x and group[i].x ~= group[3].x and group[2].y == group[3].y and group[2].y == block1.y) then
            group[i].x = x2
            group[2].x = x2
            group[3].x = x3
          end
      --feb 26
      elseif(group[i].x == x2 and group[i].y == y1) then
        if(group[i].y == group[2].y and group[2].x == group[3].x and group[3].y == block1.y and group[3].x ~= block1.x)then
          group[i].x = x2
          group[2].x = x3
          group[3].x = x3
        elseif(group[i].y == group[3].y and group[3].x == group[2].x and group[2].y == block1.y and group[2].x ~= block1.x) then
          group[i].x = x2
          group[2].x = x3
          group[3].x = x3
        elseif(group[i].y ~= group[2].y and group[i].x ~= group[2].x and group[2].x == group[3].x and group[2].x ~= block1.x and group[2].y == block1.y) then
          group[i].x = x3
          group[2].x = x3
          group[3].x = x3
        elseif(group[i].y ~= group[3].y and group[i].x ~= group[3].x and group[3].x == group[2].x and group[3].x ~= block1.x and group[3].y == block1.y) then
          group[i].x = x3
          group[2].x = x3
          group[3].x = x3
        elseif(group[i].y ~= group[2].y and group[i].x == group[2].x and group[2].y == group[3].y and group[3].x ~= block1.x) then
          group[i].x = x3
          group[2].x = x2
          group[3].x = x3
        elseif(group[i].y ~= group[3].y and group[i].x == group[3].x and group[3].y == group[2].y and group[2].x ~= block1.x) then
          group[i].x = x3
          group[2].x = x3
          group[3].x = x2
        elseif(group[i].x == group[2].x and group[2].x ~= group[3].x and group[3].x ~= block1.x and group[3].y == block2.y) then
          group[i].x = x3
          group[2].x = x3
          group[3].x = x3
        elseif(group[i].x == group[3].x and group[3].x ~= group[2].x and group[2].x ~= block1.x and group[2].y == block2.y) then
          group[i].x = x3
          group[2].x = x3
          group[3].x = x3
        elseif(group[i].x == group[2].x and group[i].y == group[3].y and group[2].y == block1.y and group[2].x ~= group[3].x and group[3].x ~= block1.x) then
          group[i].x = x2
          group[2].x = x3
          group[3].x = x3
        elseif(group[i].y == group[1].y and group[i].x ~= group[3].x and group[1].x == group[3].x and group[3].y == block1.y) then
            group[i].x = x3 
            group[2].x = x2
            group[3].x = x3
        end
      --elseif(group[i].x == x2 and group[i].y == y1) then
      elseif(group[i].x == x3 and group[i].y == y1) then
        if(group[i].x == group[2].x and group[i].x == group[3].x and group[2].y == block1.y ) then
          group[i].x = x3
          group[2].x = x3
          group[3].x = x3
        end
      end
    elseif i == 2 then
      -- do
      --if (group[i].x < 245) then
        if(group[i].x == block1.x) then
          if(group[i].y == group[1].y and group[i].y == group[3].y) then
            print("Don't move!")
          elseif(group[i].y == group[1].y and group[1].x == group[3].x and group[3].y == block1.y) then
            group[i].x = x2
            group[1].x = x3
            group[3].x = x3
          elseif(group[i].y == group[1].y and group[1].x ~= group[3].x and group[3].y == block1.y) then
            group[i].x = x2
            group[1].x = x3
            group[3].x = x3 --
          elseif(group[i].y == group[1].y and group[1].x ~= group[3].x and group[3].y ~= block1.y) then
            group[i].x = x2
            group[1].x = x3
            group[3].x = x3 --
          elseif(group[i].y == group[3].y and group[3].x == group[1].x and group[1].y == block1.y) then
            group[i].x = x2
            group[1].x = x3
            group[3].x = x3
          elseif(group[i].y == group[3].y and group[3].x ~= group[1].x and group[1].y == block1.y) then
            group[i].x = x2
            group[3].x = x3
            group[1].x = x3
          elseif(group[i].y == group[3].y and group[3].x ~= group[1].x and group[1].y ~= block1.y) then
            group[i].x = x2
            group[3].x = x3
            group[1].x = x3 --
          elseif(group[i].y == group[1].y and group[i].x ~= group[3].x and group[1].x == group[3].x and group[3].y == block1.y) then
            group[i].x = x2 
            group[1].x = x3
            group[3].x = x3
          end
        end
      --end
    elseif i == 3 then
      -- do
      --if (group[i].x < 245) then
        if(group[i].x == block1.x) then
          if(group[i].y == group[1].y and group[i].y == group[2].y) then
            print ("Don't move")
          elseif(group[i].y == group[1].y and group[1].x == group[2].x and group[2].y == block1.y) then
            group[i].x = x2
            group[1].x = x3
            group[2].x = x3
          elseif(group[i].y == group[1].y and group[1].x ~= group[2].x and group[2].y == block1.y) then
            group[i].x = x2
            group[1].x = x3
            group[2].x = x3
          elseif(group[i].y == group[1].y and group[1].x ~= group[2].x and group[2].y ~= block1.y) then
            group[i].x = x2
            group[1].x = x3
            group[2].x = x3
          elseif(group[i].y == group[2].y and group[2].x == group[1].x and group[1].y == block1.y) then
            group[i].x = x2
            group[1].x = x3
            group[2].x = x3
          elseif(group[i].y == group[2].y and group[2].x ~= group[1].x and group[1].y == block1.y) then
            group[i].x = x2
            group[1].x = x3
            group[2].x = x3
          elseif(group[i].y == group[2].y and group[2].x ~= group[1].x and group[1].y ~= block1.y) then
            group[i].x = x2
            group[1].x = x3
            group[2].x = x3
          end
        end
      --end
    end
  end
end

local function checkYUpPosition(group, block1, block2, block3)
  for i = 1, group.numChildren do
    if i == 1 then
      --do
      if(group[i].x == block1.x) then
          if(group[i].y == group[2].y and group[i].y == group[3].y) then
            print("Don't move!")
          elseif(group[i].y == group[2].y and group[2].x == group[3].x and group[3].y == block1.y) then
            print("Don't move")
          elseif(group[i].y == group[2].y and group[2].x ~= group[3].x and group[3].y == block1.y ) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y1
          elseif(group[i].y == group[2].y and group[2].x ~= group[3].x and group[3].y ~= block1.y) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y2
          elseif(group[i].y == group[3].y and group[3].x == group[2].x and group[2].y == block1.y) then
            print("Don't move!")
          elseif(group[i].y == group[3].y and group[3].x ~= group[2].x and group[2].y == block1.y) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y1
          elseif(group[i].y == group[3].y and group[3].x ~= group[2].x and group[2].y ~= block1.y) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y1
            --feb 26
          elseif(group[i].y ~= group[2].y and group[2].y == group[3].y and group[2].y == block1.y) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y1
          elseif(group[i].y ~= group[2].y and group[i].y ~= group[3].y and group[2].y ~= group[3].y and group[2].y == block1.y) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y2
          end
      elseif(group[i].x == x2 and group[i].y == y1) then
          if(group[i].y == group[2].y and group[2].x == group[3].x and group[3]. y == block1.y and group[3].x ~= block1.x) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y2
          elseif(group[i].y == group[3].y and group[3].x == group[2].x and group[2].y == block1.y and group[2].x ~= block1.x) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y1
          elseif(group[i].y ~= group[2].y and group[2].x == group[3].x and group[2].y == block1.y and group[2].x ~= block1.x) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y2
          elseif(group[i].y ~= group[3].y and group[3].x == group[2].x and group[3].y == block1.y and group[3].x ~= block1.x) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y1
          elseif(group[i].x == group[2].x and group[i].x ~= group[3].x and group[2].y == group[3].y and group[2].y == block1.y and group[2].x ~= block1.x) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y1--
            return true
          elseif(group[i].x == group[3].x and group[i].x ~= group[2].x and group[3].y == group[2].y and group[3].y == block1.y and group[3].x ~= block1.x) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y2
          elseif(group[i].x == group[2].x and group[i].x ~= group[3].x and group[i].y ~= group[3].y and group[2].y ~= group[3].y and group[2].y == block1.y) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y2
          elseif(group[i].x == group[3].x and group[i].x ~= group[2].x and group[i].y ~= group[2].y and group[3].y ~= group[2].y and group[3].y == block1.y) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y2
          end
      elseif(group[i].y == y2 and group[i].x == x2) then
        if(group[i].y == group[3].y and group[i].x ~= group[2].x and group[3].x == group[2].x) then
          group[i].y = y1
          group[2].y = y2
          group[3].y = y1
        end
      elseif(group[i].x == x3 and group[i].y == y1) then
        if(group[i].x == group[2].x and group[i].x == group[3].x and group[2].y == block1.y ) then
          group[i].y = y1
          group[2].y = y2
          group[3].y = y3
        elseif(group[i].x == group[3].x and group[i].x ~= group[2].x and group[2].y == group[3].y and group[2].y == block1.y) then
          group[i].y = y1
          group[2].y = y1
          group[3].y = y2
        elseif(group[i].y == group[2].y and group[i].x  == group[3].x and group[3].y == block1.y) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y2
        end
      elseif(group[i].x == x3 and group[i].y == y2) then
        if(group[i].y == group[2].y and group[i].x == group[3].x ) then
          group[i].y = y1
          group[2].y = y1
          group[3].y = y2
        end
      end
    elseif i == 2 then
      --do
        if(group[i].x == block1.x) then
          if(group[i].y == group[1].y and group[i].y == group[3].y) then
            print("Don't move!")
          elseif(group[i].y == group[1].y and group[1].x == group[3].x and group[3].y == block1.y) then
            print("Don't move!")
          elseif(group[i].y == group[1].y and group[1].x ~= group[3].x and group[3].y == block1.y) then
            group[i].y = y1
            group[1].y = y1
            group[3].y = y1 --
          elseif(group[i].y == group[1].y and group[1].x ~= group[3].x and group[3].y ~= block1.y) then
            group[i].y = y1
            group[1].y = y1
            group[3].y = y2 --
          elseif(group[i].y == group[3].y and group[3].x == group[1].x and group[1].y == block1.y) then
            print("Don't move!")
          elseif(group[i].y == group[3].y and group[3].x ~= group[1].x and group[1].y == block1.y) then
            group[i].y = y1
            group[3].y = y1
            group[1].y = y1
          elseif(group[i].y == group[3].y and group[3].x ~= group[1].x and group[1].y ~= block1.y) then
            group[i].y = y1
            group[3].y = y1
            group[1].y = y2
          end
        elseif(group[i].x == x3 and group[i].y == y2) then
          if(group[i].y == group[1].y and group[i].x == group[3].x) then
            group[i].y = y1
            group[1].y = y1
            group[3].y = y2
          end
        elseif(group[i].y == y2 and group[i].x == x2) then
          if(group[i].x == group[1].x and group[i].x ~= group[3].x and group[i].y ~= group[3].y and group[1].y ~= group[3].y) then
            group[i].y = y2
            group[1].y = y1
            group[3].y = y2
          elseif(group[i].x == group[1].x and group[i].x ~= group[3].x and group[i].y == group[3].y and group[1].y ~= group[3].y) then
            group[i].y = y2
            group[1].y = y1
            group[3].y = y1
          end
        end
    elseif i == 3 then 
      --do
      if(group[i].x == block1.x) then
          if(group[i].y == group[1].y and group[i].y == group[2].y) then
            print ("Don't move")
          elseif(group[i].y == group[1].y and group[1].x == group[2].x and group[2].y == block1.y) then
            print("Don't move!")
          elseif(group[i].y == group[1].y and group[1].x ~= group[2].x and group[2].y == block1.y) then
            group[i].y = y1
            group[1].y = y1
            group[2].y = y1
          elseif(group[i].y == group[1].y and group[1].x ~= group[2].x and group[2].y ~= block1.y) then
            group[i].y = y1
            group[1].y = y1
            group[2].y = y2
          elseif(group[i].y == group[2].y and group[2].x == group[1].x and group[1].y == block1.y) then
            print("Don't move!")
          elseif(group[i].y == group[2].y and group[2].x ~= group[1].x and group[1].y == block1.y) then
            group[i].y = y1
            group[1].y = y1
            group[2].y = y1
          elseif(group[i].y == group[2].y and group[2].x ~= group[1].x and group[1].y ~= block1.y) then
            group[i].y = y1
            group[1].y = y2
            group[2].y = y1
          end
      end
    end
  end 
end

local function checkYDownPosition(group, block1, block2, block3)
  for i = 1, group.numChildren do
      if i == 1 then
      --do
        if (group[i].y ~= block1.y and group[i].x == block1.x) then
          if(group[i].y == group[2].y and group[i].y == group[3].y) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y2
          elseif(group[2].x == group[3].x and group[3].y == block1.y) then
            print("Don't move")
          elseif(group[i].y == group[2].y and group[2].x ~= group[3].x and group[3].y == block1.y ) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y1
          elseif(group[i].y == group[2].y and group[2].x ~= group[3].x and group[3].y ~= block1.y) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y2
          elseif(group[i].y == group[3].y and group[3].x == group[2].x and group[2].y == block1.y) then
            print("Don't move!")
          elseif(group[i].y == group[3].y and group[3].x ~= group[2].x and group[2].y == block1.y) then
            group[i].y = y1
            group[2].y = y1
            group[3].y = y1
          elseif(group[i].y == group[3].y and group[3].x ~= group[2].x and group[2].y ~= block1.y) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y1
          elseif(group[i].y ~= group[2].y and group[2].y == group[3].y and group[2].y == block1.y) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y3
          elseif(group[i].y ~= group[2].y and group[i].y ~= group[3].y and group[2].y ~= group[3].y and group[2].y == block1.y) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y3
          end
        elseif(group[i].x == x2 and group[i].y == y1) then
          if(group[i].y == group[2].y and group[2].x == group[3].x and group[3]. y == block1.y and group[3].x ~= block1.x) then
            group[i].y = y2
            group[2].y = y2
            group[3].y = y3
          elseif(group[i].y == group[3].y and group[3].x == group[2].x and group[2].y == block1.y and group[2].x ~= block1.x) then
            group[i].y = y2
            group[2].y = y3
            group[3].y = y2
          elseif(group[i].y ~= group[2].y and group[2].x == group[3].x and group[2].y == block1.y and group[2].x ~= block1.x) then
            group[i].y = y2
            group[2].y = y2
            group[3].y = y3
          elseif(group[i].y ~= group[3].y and group[3].x == group[2].x and group[3].y == block1.y and group[3].x ~= block1.x) then
            group[i].y = y2
            group[2].y = y3
            group[3].y = y2
          elseif(group[i].x == group[2].x and group[i].x ~= group[3].x and group[2].y == group[3].y and group[2].y == block1.y and group[2].x ~= block1.x) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y3
          elseif(group[i].x == group[3].x and group[i].x ~= group[2].x and group[3].y == group[2].y and group[3].y == block1.y and group[3].x ~= block1.x) then
            group[i].y = y1
            group[2].y = y3
            group[3].y = y2
          elseif(group[i].x == group[2].x and group[i].x ~= group[3].x and group[i].y ~= group[3].y and group[2].y ~= group[3].y and group[2].y == block1.y) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y3
          elseif(group[i].x == group[3].x and group[i].x ~= group[2].x and group[i].y ~= group[2].y and group[3].y ~= group[2].y and group[3].y == block1.y) then
            group[i].y = y1
            group[2].y = y3
            group[3].y = y2
          elseif(group[i].x == group[2].x and group[i].y == group[3].y and group[2].y == block1.y and group[2].x ~= group[3].x and group[3].x ~= block1.x) then
          group[i].y = y1
          group[2].y = y2
          group[3].y = y2
          end
        elseif(group[i].x == x3 and group[i].y == y1) then
          if(group[i].x == group[2].x and group[i].x == group[3].x and group[2].y == block1.y ) then
            group[i].y = y1
            group[2].y = y2
            group[3].y = y3
          elseif(group[i].x == group[3].x and group[i].x ~= group[2].x and group[2].y == group[3].y and group[2].y == block1.y) then
            group[i].y = y2
            group[2].y = y2
            group[3].y = y3
          elseif(group[i].y == group[2].y and group[i].x  == group[3].x and group[3].y == block1.y) then
            group[i].y = y2
            group[2].y = y2
            group[3].y = y3
          end
        end
    elseif i == 2 then
      --do
        if(group[i].x == block1.x) then
          if(group[i].y == group[1].y and group[i].y == group[3].y) then
            print("Don't move!")
          elseif(group[i].y == group[1].y and group[1].x == group[3].x and group[3].y == block1.y) then
            print("Don't move!")
          elseif(group[i].y == group[1].y and group[1].x ~= group[3].x and group[3].y == block1.y) then
            group[i].y = y1
            group[1].y = y1
            group[3].y = y1 --
          elseif(group[i].y == group[1].y and group[1].x ~= group[3].x and group[3].y ~= block1.y) then
            group[i].y = y1
            group[1].y = y1
            group[3].y = y2 --
          elseif(group[i].y == group[3].y and group[3].x == group[1].x and group[1].y == block1.y) then
            print("Don't move!")
          elseif(group[i].y == group[3].y and group[3].x ~= group[1].x and group[1].y == block1.y) then
            group[i].y = y1
            group[3].y = y1
            group[1].y = y1
          elseif(group[i].y == group[3].y and group[3].x ~= group[1].x and group[1].y ~= block1.y) then
            group[i].y = y1
            group[3].y = y1
            group[1].y = y2
          end
        end
    elseif i == 3 then 
      --do
      if(group[i].x == block1.x) then
          if(group[i].y == group[1].y and group[i].y == group[2].y) then
            print ("Don't move")
          elseif(group[i].y == group[1].y and group[1].x == group[2].x and group[2].y == block1.y) then
            print("Don't move!")
          elseif(group[i].y == group[1].y and group[1].x ~= group[2].x and group[2].y == block1.y) then
            group[i].y = y1
            group[1].y = y2
            group[2].y = y3
          elseif(group[i].y == group[1].y and group[1].x ~= group[2].x and group[2].y ~= block1.y) then
            group[i].y = y1
            group[1].y = y2
            group[2].y = y3
          elseif(group[i].y == group[2].y and group[2].x == group[1].x and group[1].y == block1.y) then
            print("Don't move!")
          elseif(group[i].y == group[2].y and group[2].x ~= group[1].x and group[1].y == block1.y) then
            group[i].y = y1
            group[1].y = y3
            group[2].y = y2
          elseif(group[i].y == group[2].y and group[2].x ~= group[1].x and group[1].y ~= block1.y) then
            group[i].y = y1
            group[1].y = y3
            group[2].y = y2
          end
     -- elseif() then
      end
    end
  end
end

  local music1 = audio.loadStream("audio/button-3.wav")

  local function handleSwipeUp(event)
    audio.play(music1, {loops=0})
    audio.setVolume(0.2)
    checkYUpPosition(group, block1, block2)
    return true
  end

  local function handleSwipeDown(event)
    audio.play(music1, {loops=0})
    audio.setVolume(0.2)
    checkYDownPosition(group, block1, block2)
    return true
  end

  local function handleSwipeLeft(event)
    audio.play(music1, {loops=0})
    audio.setVolume(0.2)
    checkXLeftPosition(group, block1, block2)
    return true
  end

  local function handleSwipeRight(event)
    audio.play(music1, {loops=0})
    audio.setVolume(0.2)
    checkXRightPosition(group, block1, block2)
    return true
  end

  local upBtn = display.newText("UP", 100, 100, 'Marker Felt', 30)
  upBtn.x = 245
  upBtn.y = 720
  upBtn:setTextColor(0, 0, 0)
  sceneGroup:insert(upBtn)
  upBtn:addEventListener("tap", handleSwipeUp)

  local downBtn = display.newText("DOWN", 100, 100, 'Marker Felt', 30)
  downBtn.x = 245
  downBtn.y = 770
  downBtn:setTextColor(0, 0, 0)
  sceneGroup:insert(downBtn)
  downBtn:addEventListener("tap", handleSwipeDown)

  local leftBtn = display.newText("LEFT", 100, 100, 'Marker Felt', 30)
  leftBtn.x = 100
  leftBtn.y = 750
  leftBtn:setTextColor(0,0,0)
  sceneGroup:insert(leftBtn)
  leftBtn:addEventListener("tap", handleSwipeLeft)

  local rightBtn = display.newText("RIGHT", 100, 100, 'Marker Felt', 30)
  rightBtn.x = 400
  rightBtn.y = 750
  rightBtn:setTextColor(0,0,0)
  sceneGroup:insert(rightBtn)
  rightBtn:addEventListener("tap", handleSwipeRight) 

end

local function proceedToNextLevel(group)
  --insert code
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