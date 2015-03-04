local storyboard = require("storyboard")
local scene = storyboard.newScene()
local physics = require("physics")
local level01 = require("level01")

local function btnTap(event)
  event.target.xScale = 0.95
  event.target.yScale = 0.95
  storyboard.gotoScene(event.target.destination, {effect = "fade"})
  return true
end

function catchBackgroundOverlay(event)
  return true
end

function scene:createScene(event)
  local sceneGroup = self.view
  
  local background = display.newRect(sceneGroup, leftScrn-1000, topScrn-1000, widthScrn+1000, heightScrn+1000)
  background:setFillColor(0, 0, 0)
  background.alpha = 0.6
  background.isHitTestable = true
  background:addEventListener("tap", catchBackgroundOverlay)
  background:addEventListener("touch", catchBackgroundOverlay)