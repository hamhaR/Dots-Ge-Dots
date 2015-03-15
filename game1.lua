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
  storyboard.showOverlay( "pause" ,{effect = "fade"  ,  params ={levelNum = "game1"}, isModal = true} )
  return true
end

local function reloadbtnTap(event)
  timer.cancel(gameTimer)
  storyboard.purgeScene(event.target.destination)
  storyboard.gotoScene (  event.target.destination, {effect = "crossFade", time = 333} )
  return true
end

 function catchBackgroundOverlay(event)
  return true 
end

local function checkXLeftPosition(group)
  for i=1, group.numChildren do
    if i == 1 then
      if (group[i].x > 90) then
        if(group[i].y == group[2].y or group[i].y == group[3].y) then
          print("Dont move")
        else
          group[i].x = 90
        end
      end
    elseif i == 2 then
      -- do
      if (group[i].x > 90) then
        if(group[i].y == group[1].y or group[i].y == group[3].y) then
          print("Dont move")
        else
          group[i].x = 90
        end
      end
    elseif i == 3 then
      -- do
      if (group[i].x > 90) then
        if(group[i].y == group[1].y or group[i].y == group[2].y) then
          print("Dont move")
        else
          group[i].x = 90
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
          group[i].x = 245
        end
      end
    elseif i == 2 then
      -- do
      if (group[i].x < 245) then
        if(group[i].y == group[1].y or group[i].y == group[3].y) then
          print("Dont move")
        else
          group[i].x = 245
        end
      end
    elseif i == 3 then
      -- do
      if (group[i].x < 245) then
        if(group[i].y == group[1].y or group[i].y == group[2].y) then
          print("Dont move")
        else
          group[i].x = 245
        end
      end
    end
  end
  return true
end

local function checkYUpPosition(group)
  for i = 1, group.numChildren do
    if i == 1 then
      --do
      if (group[i].y > 255) then
        if group[i].x == group[2].x or group[i].x == group[3].x then
          print ("Dont move")
        else
          group[i].y = 255
        end
      end
    elseif i == 2 then
      --do
      if (group[i].y > 255) then
        if group[i].x == group[1].x or group[i].x == group[3].x then
          print ("Dont move")
        else
          group[i].y = 255
        end
      end
    elseif i == 3 then 
      --do
      if (group[i].y > 255) then
        if group[i].x == group[2].x or group[i].x == group[1].x then
          print ("Dont move")
        else
          group[i].y = 255
        end
      end
    end
  end 
end

local function checkYDownPosition(group)
  for i = 1, group.numChildren do
    if i == 1 then
      --do
      if (group[i].y < 400) then
        if group[i].x == group[2].x or group[i].x == group[3].x then
          print ("Dont move")
        else
          group[i].y = 400
        end
      end
    elseif i == 2 then
      --do
      if (group[i].y < 400) then
        if group[i].x == group[1].x or group[i].x == group[3].x then
          print ("Dont move")
        else
          group[i].y = 400
        end
      end
    elseif i == 3 then 
      --do
      if (group[i].y < 400) then
        if group[i].x == group[2].x or group[i].x == group[1].x then
          print ("Dont move")
        else
          group[i].y = 400
        end
      end
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
    background:setFillColor(244, 164, 96)
    sceneGroup:insert(background)
    -- end background
    
    local levelUp = display.newRect(0, 0, 1200, 180)
    levelUp.x = 0
    levelUp.y = 0
    levelUp:setFillColor(0, 255, 255)
    sceneGroup:insert(levelUp)
    
    --lower rect
    local levelDown = display.newRect(0, 0, 1200, 180)
    levelDown.x = 0
    levelDown.y = 800
    levelDown:setFillColor(0, 255, 255)
    sceneGroup:insert(levelDown)
  --/lower rect
    
    local level1 = display.newText( "Level 1", 100, 100, native.systemFont, 55 )
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
    
    grid[3]:setFillColor(1, 104/255, 1)
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
  pauseBtn.x = display.contentWidth - 340
  pauseBtn.y = display.contentHeight - 40
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
  reloadBtn.x = display.contentWidth - 140
  reloadBtn.y = display.contentHeight - 40
  reloadBtn.destination = "game1"
  reloadBtn:addEventListener("tap", reloadbtnTap)
  sceneGroup:insert(reloadBtn)
  --/replay button
  
    -- start draw circle
    local circle1 = display.newCircle(90, 255, 50)
    circle1:setFillColor(100, 0, 250) 
    
    local circle2= display.newCircle(90, 400, 50)
    circle2:setFillColor(100, 0, 250) 
    
    local circle3= display.newCircle(90, 550, 50)
    circle3:setFillColor(100, 0, 250)
    
    local group = display.newGroup()
    group:insert(circle1)
    group:insert(circle2)
    group:insert(circle3)
    sceneGroup:insert( group)
    
    -- end circle
    
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
    
    local timeLimit = display.newText("Time Limit: 3 seconds", 100, 100, 'Marker Felt', 30)
    timeLimit.x = 170
    timeLimit.y = 670
    timeLimit:setTextColor(1,0,0)
    sceneGroup:insert(timeLimit)

    function displayTime(event)
      local params = event.source.params
      gameTimer.text = event.count
      -- do
      if event.count < 3 then
        if group[1].x == 305 then
          timer.cancel(event.source)
          mydata.settings.unlockedLevels = 2
          print("You solved level 1!!")
          storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game1"}, isModal = true} )
        end
      elseif event.count == 3 then
        timer.cancel(event.source)
        if params[1].x == 305 then
          mydata.settings.unlockedLevels = 2
          storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game1"}, isModal = true} )
        else 
          storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  ,  params ={levelNum = "game1"}, isModal = true} )
        end
      end
    end
    
    local tmr = timer.performWithDelay(1000, displayTime, 0)
    tmr.params = {group}

    -- end timer
    
    local CENTERX = display.contentWidth - 450
    local CENTERY = display.contentHeight - 640
    local LEFT = 9
    local RIGHT = 160
    local UP = -17
    local DOWN = 150
    local dX = 0
    local dY = 0
    
    local function handleSwipe( event )
      if ( event.phase == "moved" ) then
        dX = event.x - event.xStart
        if ( dX > 0) then
          --swipe right
          local spot = RIGHT
          if event.target.x == RIGHT then
            spot = 305
          elseif event.target.x == LEFT then
            spot = RIGHT
          end
          transition.to( event.target, { time=500, x=spot } )
          return true
        elseif ( dX  < 0) then
          --swipe left
          local spot = LEFT
          if event.target.x == LEFT then
            spot = RIGHT
          end
          transition.to( event.target, { time=500, x=spot } )
          return true
        end
      end
      return true
    end

      group:addEventListener("touch", handleSwipe)  
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
