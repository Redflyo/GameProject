
-- Gestion of contents Ulysse.B

local numberImage = 2
local img = {}

function loadContent(  )

	ok = true;
	ok = loadImage()

return ok
end



function getImage( id )


	return img[tonumber(id)]
end

function loadImagePlayer( )
	print("Player image load...")
	player_img = {}
	directory = "image/"

	player_img[#player_img + 1] = love.graphics.newImage(directory .. "perso01.png")
	
	print("Player image is load")
	
	return player_img
end
--Load every picture for the game
function loadImage()

	print("Load Content...")
	
	for i=1,numberImage do
		patch = "image/" .. tostring(i) .. ".png"
		

		-- si patch exist
		if(love.filesystem.exists( patch )) then

			img[i] = love.graphics.newImage(patch)
			print(patch .. " be load")
		
		else
			print(patch.. " not exist")
		end
	end

	return true

end


function getSizeXOfImage( image )
	
	return image:getWidth()
end
function getSizeYOfImage( img )
	return img:getHeight()
end