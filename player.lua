require('content')
require('tools')


-- Dev Ulysse.B
-- For animation idea of firstnumber = action & secondnumber = orientation



player = {}

player.img = {}
player.indexCurrentImage = 1
 --- Some variable for animation is need


player.speed = 360 -- pixel per second
player.acceleration = 250

player.position = {}
player.position.x = 1
player.position.y = 0

player.velocity = {}
player.velocity.x = 0
player.velocity.y = 0

player.friction = 0.1

player.vision = {}
player.vision.sens = 0 -- 0 bas , 1 gauche , 2 haut , 3 droite



-- Define Friction and get it
function getFriction( )
	return player.friction
end
function setFriction( coeffientFriction )
	player.friction = coeffientFriction
end

function LoadPlayer(  )
	player.img = loadImagePlayer()

	player.indexCurrentImage = 1

end

--get player
function getPlayer( )
	return player
end

function getPlayerObject(  )

	local objPlayer = {}
	objPlayer.x = player.position.x
	objPlayer.y = player.position.y
	objPlayer.img = player.img[player.indexCurrentImage]
	
	return objPlayer
	
end
-- Verif mouvement of player (input)
function controlPlayerMovement(deltaTime,ratio)



	local down = love.keyboard.isDown( 's' )
	local up = love.keyboard.isDown( 'z' )
	local left = love.keyboard.isDown( 'q' )
	local right = love.keyboard.isDown( 'd' )
	local temp = { up,down,left,right}
	
	local numOfKeyPressed = getNumOfTrue(temp)
	
	if(numOfKeyPressed == 1) then
		
		if(up) then
			player.velocity.y = player.velocity.y - player.acceleration * deltaTime * ratio.y
			player.velocity.x = 0
			if(player.velocity.y > 0) then player.velocity.y = (-player.acceleration) * deltaTime * ratio.y end
		end
		
		if(down) then
			player.velocity.y = player.velocity.y + player.acceleration * deltaTime * ratio.y
			player.velocity.x = 0
			if(player.velocity.y < 0) then player.velocity.y = (player.acceleration) * deltaTime * ratio.y end
		end
		
		if(right) then
			player.velocity.x = player.velocity.x + player.acceleration * deltaTime * ratio.x
			player.velocity.y = 0
			if(player.velocity.x < 0) then player.velocity.x = (player.acceleration) * deltaTime * ratio.x end
		end
		
		if(left) then
			player.velocity.x = player.velocity.x - player.acceleration * deltaTime * ratio.x
			player.velocity.y = 0 
			if(player.velocity.x > 0) then player.velocity.x = (-player.acceleration) * deltaTime * ratio.x end
		end

		normaliseVelocity(ratio)
		

	else

		slowDownPlayer()
	

	end


	movePlayer(deltaTime)

end


-- Change player.position with player.velocity (and deltatime is include)
function movePlayer(deltaTime)
	-- Translation x,y
	if(canWalk(player.position.x,player.position.y)) then
		player.position.x = player.position.x + player.velocity.x * deltaTime
		player.position.y = player.position.y + player.velocity.y * deltaTime 
	end

end

function canWalk( x,y )
	--collision test
	return true
end

-- slowdownPlayer
function slowDownPlayer(  )
	player.velocity.x = player.velocity.x * player.friction
	player.velocity.y = player.velocity.y * player.friction
end



-- Maximun of player.velocity is player.speed
function normaliseVelocity( ratio )

-- Positif

	if(player.velocity.x > player.speed * ratio.x) then
		player.velocity.x = player.speed * ratio.x
	end 

	if(player.velocity.y > player.speed * ratio.y) then
		player.velocity.y = player.speed * ratio.y
	end 

-- Negatif

	if(player.velocity.x < -player.speed * ratio.x) then 
		player.velocity.x = -player.speed * ratio.x
	end 

	if(player.velocity.y < -player.speed * ratio.y) then
		player.velocity.y = -player.speed * ratio.y
	end 

end





