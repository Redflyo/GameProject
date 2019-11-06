require('content')
require('tools')
require('map')
require('camera')
require('player')
require('collision')
-- The main class for the game Ulysse.B

playerControl = true
local todraw = {}
local option = false

TMap = {}
ratio = 1
screenRefx = 1920
screenRefy = 1080

function love.load()

--success = love.window.setFullscreen( true )

love.window.setMode(1366,768)




 print("Game Start")
 
  if(loadContent()) then
  	print("Content is load")
  end

  LoadAllMap()
  print("Maps are load")


  print ("Loading Camera")
  CreateScreen(love.graphics.getWidth(),love.graphics.getHeight())
 

  print("Get ratio")
  ratio = getRatio( screenRefx,screenRefy )


  print ("Loading Objects of the map")
  TMap = getCurrentMap()


  print("Loading Map like in object")
  loadMapInObject(TMap,ratio)

  print("Loading Player")
  LoadPlayer(ratio)

  print("Loading Collision System")
  

  LoadCollisionSystem(TMap[2],ratio) -- Collision is the number 2

end


function love.draw()
	camera = getCam()
	for i=1,#todraw do
		
		love.graphics.draw(todraw[i].img,todraw[i].x + camera.x,todraw[i].y + camera.y,0,ratio.x,ratio.y)
	end


	if (option == false) then
		--Load Point of collision
		local obj = getPointCollision(ratio)


		love.graphics.print(tostring(#todraw).. "  " .. love.timer.getFPS() .. "   Collision point: X/Y : " .. tostring(obj.x) .. ";" .. tostring(obj.y)  ,0,0)
	end

end


function love.update(dt)

	todraw = {}
	
	local obj = getObject()
	local beload = toDrawChoice(obj,ratio)

	--draw map
	for i=1,#beload do
		addToDraw(beload[i])
	end

	if(playerControl) then

		controlPlayerMovement(dt,ratio)

		-- add to draw Player
		objPlayer = getPlayerObject()
		addToDraw(objPlayer)
		focusObject(objPlayer)
	end

end

-- object with  x , y , img   and after add scale inside the image for animation
function addToDraw( obj )

	local index = #todraw + 1

	todraw[index] = {}
	todraw[index].x = obj.x -- Initialise bedraw for add to "todraw"
	todraw[index].y = obj.y
	todraw[index].img = obj.img
	
end
function love.keypressed(key)  
  if key == "escape" then
    love.event.quit()
  end

  if key=="f1" then
  	-- Show and remove fps ect...
   		option = inverseBool(option)
  end

end