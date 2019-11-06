

-- File for gestion of map Ulysse.B



maps = {}
currentMap = {}

local numTypeFile = 2
local NameOfCurrentMap = ""
local PatchMapInfo = "map.info"
local mapDir = "map"

function getCurrentMap()
	return currentMap
end

function LoadAllMap()
	
	print("Start to load..")
	if(love.filesystem.exists(mapDir)) then
		
	else
	
		love.filesystem.createDirectory(mapDir)
	end
print(mapDir)
	cpt  = 1
	for line in love.filesystem.lines(PatchMapInfo) do
 		maps[cpt] = getMap(line)
 		cpt= cpt+1
	end

	currentMap = maps[1]
	print(#maps .. " num of map")
end



-- Create the Map when not exist (TheFile)
function createFileMap( nameMap )
	
	for i=1,numTypeFile do

		patch = getPatch(nameMap,i)


		f = love.filesystem.newFile(patch)
		f:open("w")

		tx = 50
		ty = 50
		case = "1"
	

		for y=1,ty do
			for x=1,tx do
			
			
		
   				f:write(case)
		
			
			end

			if(ty == y) then
			else
				f:write("\n")
			end
		
		end

		f:close()
	end
end

-- Load File of Map
function LoadMap( nameMap )
	newMap = {}
	for i=1,numTypeFile do
		
		newMap[i] = {}	
		lignes = love.filesystem.lines(getPatch(nameMap,i))
		cpt = 1
		for lignes in love.filesystem.lines(getPatch(nameMap,i)) do
			newMap[i][cpt] = lignes
			cpt = cpt + 1
		end

	end
	return newMap
end

-- Get Or Create Map
function getMap( nameMap )
	
	if(mapExists(nameMap)) then

		return LoadMap(nameMap)

	else

		createFileMap(nameMap)
		return nil
	end

end

-- type is integer and nameMap is the name / return the patch with type and name
function getPatch(nameMap,Type)

	patch = mapDir.."/" .. nameMap
	
	if(Type == 1) then

		patch = patch .. ".map"
	
	else
		if(Type == 2) then
			patch = patch .. ".col"
		else

		end	
	end
	return patch
end


function mapExists( nameMap )
	isExist = true
	
	-- Verif if different file of a map exist
	for i=1,numTypeFile do
		if(love.filesystem.exists( getPatch(nameMap,i) )) then
		else
			isExist = false
		end	
	end

	return isExist
	
end