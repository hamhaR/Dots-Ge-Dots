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
    --reloadBtn.destination = "game_levels"
    reloadBtn:addEventListener("tap", reloadbtnTap)
    sceneGroup:insert(reloadBtn)
  --/replay button
   
    -- start draw circle
    local circle1 = display.newCircle(245, 255, 50)
    circle1:setFillColor(174/255, 87/255, 163/255) 
    
    local circle2= display.newCircle(95, 400, 50)
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
    block1.x = 95
    block1.y = 250
    block1:scale(-0.57, -0.57)
    --sceneGroup:insert(block1)

    local block2 = display.newImage("block_brick.png")
    block2.x = 95
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
    
    local timeLimit = display.newText("Time Limit: 5 seconds", 100, 100, 'Marker Felt', 30)
    timeLimit.x = 170
    timeLimit.y = 670
    timeLimit:setTextColor(1,0,0)
    sceneGroup:insert(timeLimit)

    function displayTime(event)
      local params = event.source.params
      gameTimer.text = event.count
        if event.count < 5 then
            if (circle1.x == 400 and circle1.y == 255) and (circle2.x == 245 and circle2.y == 255) and (circle3.x == 400 and circle3.y == 400) then
                timer.cancel(event.source)
                mydata.settings.unlockedLevels = 4
                storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game3"}, isModal = true} )
            end
        elseif event.count == 5 then
            timer.cancel(event.source)
            if (circle1.x == 400 and circle1.y == 255) and (circle2.x == 245 and circle2.y == 255) and (circle3.x == 400 and circle3.y == 400) then
                mydata.settings.unlockedLevels = 4
                storyboard.showOverlay( "popupalert_success" ,{effect = "fade"  ,  params ={levelNum = "game3"}, isModal = true} )
            else
                storyboard.showOverlay( "popupalert_fail" ,{effect = "fade"  ,  params ={levelNum = "game3"}, isModal = true} )
            end
        end
    end

    local tmr = timer.performWithDelay(1000, displayTime, 0)
    --tmr.params = group

    -- end timer

    --move dots
    local CENTERX = display.contentCenterX
    local CENTERY = display.contentCenterY
    local LEFT = -150
    local RIGHT = 140
    local UP = -20
    local DOWN = 150
    
    local function checkYUpPosition(group, block)
        if group[1].y > 255 then
            if (group[1].y-145 ~= group[2].y and group[1].x ~= group[2].x) or (group[1].y-145 ~= group[3].y and group[1].x ~= group[3].x) then
                if (group[1].x == block[1].x) and (group[1].y-150 == block[1].y) then
                    print("dots don't move, 1")
                elseif group[2].x == block[1].x and group[2].y - 150 == block[1].y then
                    print("pikachu")
                    group[1].y = 255
                    group[3].y = group[3].y - 150
                else
                    print("anne")
                    group[1].y = 255
                    group[2].y = 255
                    group[3].y = group[3].y - 150
                end
            end
        elseif group[2].y > 255 then
            if (group[2].y-145 ~= group[3].y and group[2].x ~= group[3].x) or (group[1].y-145 ~= group[2].y and group[2].x ~= group[1].x) then
                if (group[2].x == block[1].x) and (group[2].y-150 == block[1].y) then
                    print("dots dont move, 2", group[3].y)
                    if group[3].y ~= 255 and group[1].x ~= group[3].x then
                        group[3].y = 255
                    end
                else
                    group[2].y = 255
                end
            end
        elseif group[3].y > 255 then
            if (group[3].y-145 ~= group[1].y and group[3].y ~= group[2].y)  then
                if (group[3].x == block[1].x) and (group[3].y-150 == block[1].y) then
                    print("dots dont move, 3")
                else
                    print("na unsa ka?")
                    group[3].y = group[3].y - 150
                end
            else
                print("no up")
            end
        end
        --]]
    end

    local function checkYDownPosition(group, block)
        if group[1].y == 400 then
            group[3].y = 550
            print("statement 1")
        elseif group[2].y == 400 then
            if (group[2].y+150 == block[2].y and group[2].x == block[2].x) and (group[3].y+150 == block[3].y and group[3].x == block[3].x) then
                print("statement 2, block")
            elseif (group[2].y+150 == block[3].y and group[2].x == block[3].x) then
                group[1].y = 400
                group[2].y = 400
                group[3].y = 550
                print("srsly?")
            else
                if group[3].y == 400 then
                    group[1].y = 400
                    group[3].y = 550
                elseif group[3].y == 255 then
                    group[1].y = 400
                    group[3].y = 400
                end
                print("condition not satisfy")
            end
        elseif group[3].y == 400 and group[1].y < 400 and group[2].y < 400 then
            group[1].y = 400
            group[2].y = 400
            group[3].y = 400
            print("statement 3")
        else
            group[1].y = 400
            group[2].y = 400
            group[3].y = 550
            print("ambot")
        end
    end

    local function checkXLeftPosition(group, block)
        if group[1].x == 95 or group[2].x == 95 or group[3].x == 95 then
            print("left dont move")
        elseif group[1].x > 95 and group[2].x > 95 and (group[3].x > 95 and (group[3].x-155 ~= block[3].x and group[3].y == block[3].y)) then
            group[1].x = 245
            group[2].x = 95
            group[3].x = 245

        elseif group[2].x-150 == block[1].x and group[2].y-5 == block[1].y and group[3].x >190 then
            group[3].x = group[3].x - 150
            print(group[3].x)
        elseif group[3].x - 155 == block[3].x and group[3].y == block[3].y then
            group[1].x = 245
            group[2].x = 95
            
        else
            print("asa", group[3].x, block[3].y)
        end
    end

    local function checkXRightPosition(group, block)
        print("echos", group[1].x, group[2].x, group[3].x)
        if group[2].x - 150 == block[1].x and group[2].y-5 == block[1].y and group[1].x-155 == group[2].x and group[3].x < 400 then
            group[3].x = group[3].x + 150
        elseif group[2].x == 95 and group[1].x == 245 and group[3].x == 400 and group[1].y == 400 and group[2].y == 400 and group[3].y == 400 then
            print("stay dude!")
        else
            group[1].x = 400
            group[2].x = 245
            group[3].x = 400
            print(group[1].x, group[2].x) 
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
                print("up", group[1].x, group[1].y)
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
