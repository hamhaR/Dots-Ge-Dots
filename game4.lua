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
        storyboard.gotoScene( "game3", { effect = "crossFade", time = 333 })
      elseif i == 3 then
        mydata.settings.unlockedLevels = 4
        storyboard.gotoScene("game5", {effect = "crossFade", time = 333})
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

    local displayTimer = display.newText("0", 100, 100, native.systemFont, 40)
    displayTimer.x = 200
    displayTimer.y = 130
    displayTimer:setTextColor(1,0,0)
    sceneGroup:insert( displayTimer )

    function displayTime(event)
      --  local params = event.source.params
      displayTimer.text = event.count
        if event.count < 20 then
            if (circle1.x == 245 and circle1.y == 550) and (circle2.x == 400 and circle2.y == 400) and (circle3.x == 400 and circle3.y == 550) then
                timer.cancel(event.source)
                native.showAlert("Congratulations", "You win the game.", {"Main Menu", "Replay", "Next Level"}, onComplete)
            end
        elseif event.count == 20 then
            timer.cancel(event.source)
            if (circle1.x == 245 and circle1.y == 550) and (circle2.x == 400 and circle2.y == 400) and (circle3.x == 400 and circle3.y == 550) then
                native.showAlert("Congratulations", "You win the game.", {"Main Menu", "Replay", "Next Level"}, onComplete)
            else
                native.showAlert("Time's up.", "Better luck next time.", {"Main Menu", "Replay"}, onComplete2)
            end
        end
    end

    local tmr = timer.performWithDelay(1000, displayTime, 0)
    tmr.params = {myParam1 = group}

    -- end timer

    --move dots
    
    local function checkYUpPosition(group, block)
        if group[2].x == group[3].x and group[3].y > group[2].y and group[2].y > 300 then
            group[2].y = group[2].y - 150
            group[3].y = group[3].y - 150
        elseif group[3].x ~= group[2].x and group[3].y > 300 then
            group[3].y = group[3].y - 150
        end
    end

    local function checkYDownPosition(group, block)
        
        if group[3].x ~= group[1].x and group[3].x ~= group[2].x and group[3].y < 500   then
            group[3].y = group[3].y + 150
            print("nega")
        elseif group[2].x ~= block[3].x and group[2].y + 150 ~= group[3].y then
            group[2].y = group[2].y + 150
            print("anne")
        elseif group[2].x == group[3].x and group[3].y > group[2].y and group[3].y < 500 and group[3].x ~= group[1].x then
            if group[3].y + 150 == group[1].y and group[1].x-5 == group[3].x then
                
                print("wae")
            else
                group[2].y = group[2].y + 150
                group[3].y = group[3].y + 150
                print("waeyo?")
            end
        end
        print("x: ", group[1].x, group[2].x, group[3].x, "\ny: ", group[1].y, group[2].y, group[3].y)
    end

    local function checkXLeftPosition(group, block)
        
        if group[3].x - 155 == block[3].x and group[3].y == block[3].y then
            if group[2].x - 150 == block[1].x and group[1].x > 100 then
                group[1].x = 95
                print("pretty")
            elseif group[2].x - 150 ~= block[1].x then
                group[1].x = group[1].x - 155
                group[2].x = group[2].x - 155
                print("sus oy")
            end
            print("woah")
        elseif group[1].x > 240 and group[3].y ~= block[3].y then
                group[1].x = group[1].x - 155   
                group[3].x = group[3].x - 155
                print("handsome")
        end 
    end

    local function checkXRightPosition(group, block)
        if group[1].x >= 95 and group[2].x+150 ~= group[3].x and group[2].y == group[3].y and group[1].x<300 then
            group[1].x = group[1].x + 155
            print("asdf")
        elseif group[2].x < 300 and group[2].y ~= group[3].y  then
            if group[2].x < group[3].x then
                group[2].x = group[2].x + 155
            else
                print("jkl", group[1].x, group[2].x)
                group[1].x = group[1].x + 155
                group[2].x = group[2].x + 155
                print("jkl", group[1].x, group[2].x)
            end
        elseif group[1].y == group[3].y and group[1].x < 300 then
            group[1].x = 245
            group[3].x = 400
            print("mnop")
        elseif group[1].y ~= group[3].y and group[1].x < 300 then
            group[1].x = group[1].x + 155
            print("qrst")
        end
    end

    local function handleSwipe( event )
        if ( event.phase == "moved" ) then
            local dX = event.x - event.xStart
            --print( event.x, event.xStart, dX )
            if ( dX > 5 ) then
                --swipe right
                --local spot = RIGHT
                print("right")
                checkXRightPosition(group, block)
                transition.to( event.target, { time=500, x=spot } )
            elseif ( dX  < -10 ) then
                --swipe left
                checkXLeftPosition(group, block)
                transition.to( event.target, { time=500, x=spot } )
            end
            --y-axis(up and down movement) = 
            local dY = event.y - event.yStart
            if (dY > 10) then
                print("down")
              --local spot = DOWN 
              checkYDownPosition(group, block)
              transition.to( event.target, { time = 500, y = spot } )
            elseif ( dY < -10 ) then
                print("up", group[1].y, group[2].y, group[3].y)
                checkYUpPosition(group, block)
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
