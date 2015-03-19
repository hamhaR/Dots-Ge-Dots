local storyboard = require("storyboard")
local scene = storyboard.newScene()
require("timer2")
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

function catchBackgroundOverlay(event)
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
  
  --upper background color
  local levelUp = display.newRect(0, 0, 1200, 180)
  levelUp.x = 0
  levelUp.y = 0
  levelUp:setFillColor(0, 255, 255)
  sceneGroup:insert(levelUp)
  
  --level name
  local level1 = display.newText( "Level 1", 100, 100, native.systemFont, 55 )
  level1.x = display.contentCenterX
  level1.y = display.contentCenterY - 350
  level1:setTextColor(black)
  sceneGroup:insert( level1 )

  --start grid
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

  -- start draw circle
  local circle1 = display.newCircle(90, 255, 50)
  circle1:setFillColor(100, 0, 250) 
    
  local circle2= display.newCircle(90, 400, 50)
  circle2:setFillColor(100, 0, 250) 
    
  local circle3= display.newCircle(90, 550, 50)
  circle3:setFillColor(100, 0, 250)
    
  local  group = display.newGroup()
  group:insert(circle1)
  group:insert(circle2)
  group:insert(circle3)
  sceneGroup:insert( group)
  -- end circle
    
  -- start timer
  local displayTimeUsed = display.newText("Time:", 100, 100, 'Marker Felt', 30)
  displayTimeUsed.x = 50
  displayTimeUsed.y = 130
  displayTimeUsed:setTextColor(1,0,0)
  sceneGroup:insert(displayTimeUsed)

  local gameTimer = display.newText("0", 100, 100, native.systemFont, 30)
  gameTimer.x = 110
  gameTimer.y = 130
  gameTimer:setTextColor(1,0,0)
  sceneGroup:insert(gameTimer)
    
  local timeLimit = display.newText("Limit: 5 sec", 100, 100, 'Marker Felt', 30)
  timeLimit.x = 370
  timeLimit.y = 130
  timeLimit:setTextColor(1,0,0)
  sceneGroup:insert(timeLimit) 

  function displayTime(event)
    gameTimer.text = event.count
    if group.x == 320 then
      if(event.count >= 0 and event.count <= 2) then
        print("solved1")
        mydata.settings.levels[1].stars = 3
        timer.cancel(event.source)
        if(mydata.settings.unlockedLevels <= 1) then
          mydata.settings.unlockedLevels = 2
        end
        storyboard.showOverlay( "popupalert_success" ,{effect = "fade", time = 500, params ={levelNum = "game1"}, isModal = true} )
      elseif(event.count >= 3 and event.count <= 4) then
        print("solved2")
        mydata.settings.levels[1].stars = 2
        timer.cancel(event.source)
        if(mydata.settings.unlockedLevels <= 1) then
          mydata.settings.unlockedLevels = 2
        end
        storyboard.showOverlay( "popupalert_success" ,{effect = "fade", time = 500  ,  params ={levelNum = "game1"}, isModal = true} )
      elseif(event.count == 5) then
        print("solved3")
        mydata.settings.levels[1].stars = 1
        timer.cancel(event.source)
        if(mydata.settings.unlockedLevels <= 1) then
          mydata.settings.unlockedLevels = 2
        end
        storyboard.showOverlay( "popupalert_success" ,{effect = "fade", time = 500  ,  params ={levelNum = "game1"}, isModal = true} )
      elseif(event.count > 5) then
        print(" not solved")
        timer.cancel(event.source)
        mydata.settings.levels[1].stars = 0
        storyboard.showOverlay( "popupalert_fail" ,{effect = "fade", time = 500  ,  params ={levelNum = "game1"}, isModal = true} )
        end
      end
    end
    local tmr = timer.performWithDelay(1000, displayTime, 0)
    local music1 = audio.loadStream("audio/button-3.wav")
  --end sa timer
  
  --dot movements
  local function tapLeft(event)
    if group.x > 0 then
      audio.play(music1, {loops=0})
      audio.setVolume(5)
      group.x = group.x - 160
      print("Move to the left.")
      return true
    end
  end

  local function tapRight(event)
    if group.x < 300 then
      audio.play(music1, {loops=0})
      audio.setVolume(5)
      group.x = group.x + 160
      print("Move to the right.", group.x)
      return true
    end
  end
  --end sa dot movements
  
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
    reloadBtn.destination = "game1"
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
  reloadBtn.destination = "game1"
  reloadBtn:addEventListener("tap", reloadbtnTap)
  sceneGroup:insert(reloadBtn)
  

  local upBtn = display.newImageRect ("images/up.png" ,70, 70)
  upBtn.x = 240 
	upBtn.y = 670
	sceneGroup:insert (upBtn)
  
  local downBtn = display.newImageRect ("images/down.jpg" ,70, 70)
  downBtn.x = 240 
	downBtn.y = 760
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
--end sa sceneGroup

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



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "showScene", scene )
scene:addEventListener( "hideScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
