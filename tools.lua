
-- File of tools for project Ulysse.B

-- Like !boolean in C#
function inverseBool( bool )
	if(bool) then
		return false
	else
		return true
	end
end

-- Input is Table of boolean  and return number of variable on true
function getNumOfTrue( b )
	local cpt = 0
	for i=1,#b do
		if(b[i]) then 
			cpt = cpt +1
		end
	end
	return cpt
end

-- convert position pixel to case
function getPosition( obj , sizex , sizey )
	local obj = {}
	obj.x = obj.x / sizex
	obj.y = obj.y / sizey
	return obj
end




function round(num)
    under = math.floor(num)
    upper = math.floor(num) + 1
    underV = -(under - num)
    upperV = upper - num
    if (upperV > underV) then
        return under
    else
        return upper
    end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end