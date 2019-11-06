require('tools')
require('camera')
collision = {}

function LoadCollisionSystem( map,ratio )
	
	collision = convertTableStringToObject(map,ratio)
	for i=1,#collision do
		print("------------")

		print(collision[i].x)
		print(collision[i].y)
		print(collision[i].sizex)
		print(collision[i].sizey)

	end
	print("------------")
end


--Load the Map and tab is a table with String


-- The base is "x;y;sizex;sizey" only rectangle -- collision size with ratio and position with ratio

function convertTableStringToObject( tab, ratio )
	
	local tabObject = {}

	for i=1,#tab do

		local obj = convertStringToObject(tab[i],ratio)
		
		tabObject[#tabObject + 1] = obj


	end



	return tabObject


end

function CreateObjectCollision( x,y,sizex,sizey,ratio )
	
	local obj = {}




	obj.x = x * ratio.x
	obj.y = y * ratio.y
	obj.sizex = sizex * ratio.x
	obj.sizey = sizey * ratio.y

	return obj

end


-- convert a string like ("x;y;sizex;sizey") in a obj with paramater
function convertStringToObject( str , ratio )
	
	local sp = split(str,";")

	local x = tonumber(sp[1])
	local y = tonumber(sp[2])
	local sizex = tonumber(sp[3])
	local sizey = tonumber(sp[4])

	return CreateObjectCollision(x,y,sizex,sizey,ratio)


end












function verifPointCollision( p )
	for i=1,#collision do

		local x = collision[i].x
		local y = collision[i].y
		local sizex = collision[i].sizex
		local sizey = collision[i].sizey
		print("collision")
		print(x)
		print(y)
		print("point")
		print(p.x)
		print(p.y)
		if(x + sizex > p.x) then -- test if point is inside the collider rectangle in x
			--print("x1")
			if ( x < p.x) then
				--print("x2")
				if(y + sizey > p.y) then	-- test if point is inside the collider rectangle in y
				--	print("x3")
					if(y < p.y) then
						--print("x4")
						return true

					end

				end
			end

		end

	end
	return false
end

-- obj (x,y,sizex,sizey)
function collisionWithObject( obj)


	local p = {}
	local isCollide = false
	p.y = obj.y + obj.sizey-- collision is at the foot of the player so the bottom of the image
	for numPoint=0,1 do
		p.x = obj.x + (obj.sizex * numPoint)  -- numPoint when 0 no size so only corner left /  1 add the size in x so corner right

		if(verifPointCollision( p )) then -- Verif collision of player
			isCollide = true
			print("ok")

			break
		end

	end
	--print(tostring(isCollide) .. ": collision")
	return isCollide


end


