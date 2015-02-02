local storyboard = require("storyboard")
local scene = storyboard.newScene()

local widget = require( "widget" )
--local utility = require( "utility" )
local myData = require( "mydata" )

--[[
-- include the jumper library
local Grid = require ("Jumper.Jumper.grid")
local Pathfinder = require ("Jumper.Jumper.pathfinder")
local walkable = 0 -- used by Jumper to mark obstacles
--]]
--local starVertices = { 0,-11, 2.7,-3.5, 10.5,-3.5, 4.3,1.6, 6.5,9.0, 0,4.5, -6.5,9.0, -4.3,1.5, -10.5,-3.5, -2.7,-3.5, }

local params

local function handleCancelButtonEvent( event )

    if ( "ended" == event.phase ) then
        storyboard.removeScene( "game_levels", false )
        storyboard.gotoScene( "game_levels", { effect = "crossFade", time = 333 } )
    end
end

-- Start the storyboard event handlers
--
function scene:createScene( event )
    local sceneGroup = self.view

    params = event.params
        
    --
    -- setup a page background, really not that important though storyboard
    -- crashes out if there isn't a display object in the view.
    --
    local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert(background)
    
    --local displayTimer = display.newText("0", 0, 0, native.systemFont,32)
    --displayTimer:setTextColor(black)
    --timer:setReferencePoint(display.CenterReferencePoint)
    --displayTimer.x = display.contentCenterX
    --displayTimer.y = display.contentHeight - 80
    
    --[[
    --game grid
    --start

 
local map = {}   -- table representing each grid position
local startX = 1 -- start x grid (cartesian) coordinate
local startY = 1 -- start y grid (cartesian) coordinate
local endX = 3   -- end x grid (cartesian) coordinate
local endY = 3   -- end y grid (cartesian) coordinate
 
local tileWidth = 10
local tileHeight = 10
 
local bg = display.newRect( display.screenOriginX,
                            display.screenOriginY, 
                            display.actualContentWidth, 
                            display.actualContentHeight)
 
bg.x = display.contentCenterX
bg.y = display.contentCenterY
bg:setFillColor( 000/255, 168/255, 254/255 )
 
-- display group that will hold grid
group = display.newGroup( )
group.x = display.contentCenterX -- center the grid on the screen

-- draw a tile map to the screen
-- populate the tile map
function drawGrid()
   for row = 0, 3 do
      local gridRow = {}
      
      for col = 0, 3 do
        -- draw a diamond shaped tile
        --local nameofrectangle = display.newRect(left-x-coordinate,top-y-coordinate,width,height)
        local vertices = { 0, 10, 50, 50 }
        local tile = display.newPolygon(group, 10, 10, vertices )
 
        -- outline the tile and make it transparent
	tile.strokeWidth = 1
	tile:setStrokeColor( 0, 1, 1 )
        tile.alpha = .25
 
        -- set the tile's x and y coordinates
        local x = col * tileHeight
        local y = row * tileHeight
 
        tile.x = x - y
        -- the first part of this equation is to move the y coordinate down 32 pixels (tileHeight/2)
        tile.y = (tileHeight/2) + ((x + y)/2) 
        
        -- make a tile walkable
        gridRow[col] = 0
      end
      -- add gridRow table to the map table
      map[row] = gridRow
   end
end


-- get start position based off of startX and startY grid (cartesian) coordinates
function drawStart()
  local x = (display.contentWidth * 0.5 + ((startX - startY) * tileHeight)) 
  local y = (((startX + startY)/2) * tileHeight) - (tileHeight/2)
  local myText = display.newText( "A", x, y, native.systemFont, 34 )
end
 
-- get end position based off of endX and endY grid (cartesian) coordinates
function drawEnd()
  local x = (display.contentWidth * 0.5 + ((endX - endY) * tileHeight)) 
  local y = (((endX + endY)/2) * tileHeight) - (tileHeight/2)
  local myText = display.newText( "B", x, y, native.systemFont, 34 )
end



    --end
    
    --]]
    
    -- 'xOffset', 'yOffset' and 'cellCount' are used to position the buttons in the grid.
    local xOffset = 94
    local yOffset = 250
    local cellCount = 2

    -- Define the array to hold the buttons
    local grid = {}

    -- Read 'maxLevels' from the 'myData' table. Loop over them and generating one button for each.
    for i = 1, 10 do
        -- Create a grid
        grid[i] = display.newRect(100,200,150,150)
        grid[i]:setFillColor(255,255,255)
        grid[i].strokeWidth = 5
        grid[i]:setStrokeColor(0,0,0)
        -- Position the button in the grid and add it to the scrollView
        grid[i].x = xOffset
        grid[i].y = yOffset
        --levelSelectGroup:insert( grid[i] )

        -- Check to see if the player has achieved (completed) this level.
        -- The '.unlockedLevels' value tracks the maximum unlocked level.
        -- First, however, check to make sure that this value has been set.
        -- If not set (new user), this value should be 1.

        -- If the level is locked, disable the button and fade it out.
        --[[
        if ( myData.settings.unlockedLevels == nil ) then
            myData.settings.unlockedLevels = 1
        end
        if ( i <= myData.settings.unlockedLevels ) then
            buttons[i]:setEnabled( true )
            buttons[i].alpha = 1.0
        else 
            buttons[i]:setEnabled( false ) 
            buttons[i].alpha = 0.5 
        end 
        --]]

        -- Compute the position of the grid button.
        -- This tutorial draws 5 buttons across.
        -- It also spaces based on the button width and height + initial offset from the left.
        xOffset = xOffset + 90
        cellCount = cellCount + 1
        if ( cellCount > 4 ) then
            cellCount = 1
            xOffset = 94
            yOffset = yOffset + 150
        end
    end

    -- Place the scrollView into the scene and center it.
    --sceneGroup:insert( levelSelectGroup )
    --levelSelectGroup.x = display.contentCenterX
    --levelSelectGroup.y = display.contentCenterY

    local doneButton = widget.newButton({
        id = "button1",
        label = "Go To Level Select",
        fontSize = 30,
        onEvent = handleCancelButtonEvent
    })
    doneButton.x = display.contentCenterX
    doneButton.y = display.contentHeight - 50
    sceneGroup:insert( doneButton )
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

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "showScene", scene )
scene:addEventListener( "hideScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
