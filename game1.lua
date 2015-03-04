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

local function btnTap(event)
    storyboard.gotoScene (  event.target.destination, {effect = "crossFade", time = 333} )
    return true
end

local function onComplete( event )
  if event.action == "clicked" then
      local i = event.index
      if i == 1 then
        -- back to main menu
        storyboard.gotoScene( "menu")
      elseif i == 2 then
        -- replay level
        storyboard.gotoScene( "game1", { effect = "crossFade", time = 333 })
      elseif i == 3 then
        storyboard.gotoScene("game2", {effect = "crossFade", time = 333})
      end
  end
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
    
    local level1 = display.newText( "Level 1", 100, 100, native.systemFont, 55 )
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
    
    grid[6]:setFillColor(1, 104/255, 1)
    grid[8]:setFillColor(1, 104/255, 1)
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
    pauseBtn.x = display.contentWidth -230
    pauseBtn.y = display.contentHeight - 40
    --pauseBtn.destination = "game_levels"
    pauseBtn:addEventListener("tap", btnTap)
    sceneGroup:insert(pauseBtn)
  --/pause button
  
  --next button
  local nextBtn = widget.newButton{
    width = 70,
    height = 70,
    defaultFile = "images/nextBtn.png"
    }
    nextBtn.x = display.contentWidth -420
    nextBtn.y = display.contentHeight - 40
    nextBtn.destination = "game_levels"
    nextBtn:addEventListener("tap", btnTap)
    sceneGroup:insert(nextBtn)
  --/next button
  
  --replay button
  local reloadBtn = widget.newButton{
    width = 70,
    height = 70,
    defaultFile = "images/reloadBtn.png"
    }
    reloadBtn.x = display.contentWidth -50
  reloadBtn.y = display.contentHeight - 40
    reloadBtn.destination = "game_levels"
    reloadBtn:addEventListener("tap", btnTap)
    sceneGroup:insert(reloadBtn)
  --/replay button
 
    
    -- If the level is locked, disable the button and fade it out.
    if ( mydata.settings.unlockedLevels == nil ) then
      mydata.settings.unlockedLevels = 1
    end
    if ( 2 < mydata.settings.unlockedLevels ) then
      nextBtn:setEnabled( true )
      nextBtn.alpha = 1
    else 
      nextBtn:setEnabled( false ) 
      nextBtn.alpha = 0.667
    end 
    
    -- start draw circle
    local circle1 = display.newCircle(90, 255, 50)
    circle1:setFillColor(100, 0, 250) 
    
    local circle2= display.newCircle(245, 255, 50)
    circle2:setFillColor(100, 0, 250) 
    
    local circle3= display.newCircle(245, 400, 50)
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

    local displayTimer = display.newText("0", 100, 100, native.systemFont, 40)
    displayTimer.x = 200
    displayTimer.y = 130
    displayTimer:setTextColor(1,0,0)
    sceneGroup:insert( displayTimer )

    function displayTime(event)
      local params = event.source.params
      displayTimer.text = event.count
      -- do
      if event.count < 20 then
        if (params[1].x == 165 and params[1].y == 150) and (circle1.x == 90 and circle1.y == 400) and (circle1.x ~= circle2.x and circle1.x ~= circle3) then
          timer.cancel(event.source)
          native.showAlert("Time's up.", "Congratulations you win the game.", {"Back To Main Menu", "Replay", "Next Level"}, onComplete)
        end
      elseif event.count == 20 then
        timer.cancel(event.source)
        if (params[1].x == 165 and params[1].y == 150) and (circle1.x == 90 and circle1.y == 400) and (circle1.x ~= circle2.x and circle1.x ~= circle3) then
          native.showAlert("Time's up.", "Congratulations you win the game.", {"Back To Main Menu", "Replay", "Next Level"}, onComplete)
        else 
          native.showAlert("I'm sorry", "You lose the game.", {"Back To Main Menu", "Replay"}, onComplete)
        end
        print("group x", params[1].x, "circle 1", circle1.x)
      end
    end
    local tmr = timer.performWithDelay(1000, displayTime, 0)
    tmr.params = {group}

    -- end timer


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
                print("1: ", group[1].x, group[1].y, " 2:", group[2].x, group[2].y, " 3:", group[3].x, group[3].y)
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
              print("1: ", group[1].x, group[1].y, " 2:", group[2].x, group[2].y, " 3:", group[3].x, group[3].y)
                local spot = LEFT
                if ( event.target.x == RIGHT ) then
                  spot = CENTERX - 10 
                elseif(event.target.x == LEFT) then
                  checkXLeftPosition(group)
                end
                transition.to( event.target, { time=500, x=spot } )
            end
            --y-axis(up and down movement) = 
            local dY = event.y - event.yStart
            if (dY > 10) then
              print("1: ", group[1].x, group[1].y, " 2:", group[2].x, group[2].y, " 3:", group[3].x, group[3].y)
              local spot = DOWN 
              if ( event.target.y == UP )  then
                  spot = CENTERY
              elseif( event.target.y == DOWN) then
                  checkYDownPosition(group)
              end
              transition.to( event.target, { time = 500, y = spot } )
              print("Please ", group.x, group.y, circle1.x)
            elseif ( dY < -10 ) then
              print("1: ", group[1].x, group[1].y, " 2:", group[2].x, group[2].y, " 3:", group[3].x, group[3].y)
              local spot = UP
              if ( event.target.y == DOWN) then
                  spot = CENTERY
              elseif(event.target.y == UP) then
                checkYUpPosition(group) 
                
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
