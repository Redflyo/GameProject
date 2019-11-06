
require('content')

cam = {}

-- dev: Ulysse.B

object = {}

cam.x = 0
cam.y = 0

cam.screenX = 0
cam.screenY = 0

function getCam()
	return cam
end

function getObject()
	return object
end

--	obj contains (x ,y ,img) and follow him in interval of "borderX,borderY"
function focusObject( obj)

	local borderX = cam.screenX / 4
	local borderY = cam.screenY / 4

	local sizex = getSizeXOfImage(obj.img)
	local sizey = getSizeYOfImage(obj.img)



	local difx = (obj.x + cam.x) - cam.screenX / 2
	local dify = (obj.y + cam.y) - cam.screenY / 2

	--print(tostring(obj.y + cam.y) .. " / " .. tostring(cam.screenX / 2))

	if(difx < 0)then
		if(difx < -borderX) then
		
			cam.x =  (cam.screenX / 2 - borderX)  - obj.x -- find fonction
		end
	end
	if(dify < 0)then
		if(dify < -borderY) then
		
			cam.y =  (cam.screenY / 2 - borderY)  - obj.y -- find fonction
		end
	end
	if(difx > 0)then
		if(difx+sizex > borderX) then
		
			cam.x = (cam.screenX / 2 + borderX) - (obj.x + sizex)   -- find fonction
		end
	end
	if(dify> 0)then
		
		-- when object is below the screen
		if(dify+sizey > borderY) then
		
			cam.y = (cam.screenY / 2 + borderY) - (obj.y + sizey)   -- find fonction
		end

	end
end

function getRatio( sizex,sizey ) -- return obj .x = ratio x and .y ratio y
	local ratio = {}
	
	ratio.x = cam.screenX / sizex
	ratio.y = cam.screenY / sizey

	return ratio
end

function CreateScreen( screenx , screeny )
	
	cam.screenX = screenx
	cam.screenY = screeny

end


function loadMapInObject( currentmap ,ratio)
	
-- 1 is map with texture ; but 2 is collision
	for ind=1,1 do
		for y=1,#currentmap[ind] do
			for x = 1, #currentmap[ind][y] do

   			 local c = currentmap[ind][y]:sub(x,x) -- get the letter of the texture
    		 

    		 local img = getImage(c) -- Get the image of the texture

    		 local ix = (x-1) * (getSizeXOfImage(img)* ratio.x)  -- Because array start at one
    		 local iy = (y-1) * (getSizeYOfImage(img)* ratio.y)
    		
    		 loadObject(img,ix,iy)

			end
		end
	end
end


function loadObject( img , x , y  )

	obj = {}
	obj.img = img
	obj.sizeX = getSizeXOfImage(img)
	obj.sizeY = getSizeYOfImage(img)
	obj.x = x
	obj.y = y

	table.insert(object,obj)
end

function toDrawChoice( obj,ratio )
	toLoad = {}
	for i=1,#obj do

		local ok = Inside(obj[i].x,obj[i].y,obj[i].sizeX,obj[i].sizeY,ratio)
		
		if(ok) then

			toLoad[#toLoad + 1 ] = obj[i]
		
		end

	end
	return toLoad
end

function Inside( x,y, sizex, sizey,ratio )
	
	local inside = true

	if(x + (sizex * ratio.x) < 0 ) then
	
		inside = false
	end
	if(x > cam.screenX ) then
	
		inside = false
	end


	if(y + (sizey * ratio.y) < 0 ) then
	
		inside = false
	end
	if(y > cam.screenY ) then
	
		inside = false
	end

	return inside

end