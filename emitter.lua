module(..., package.seeall)

math.randomseed(os.time())

function createEmitter(radiusRange,thickness, particleDuration,  initAlpha, endAlpha)

	local customEmitter = {}
	
	customEmitter.radiusRange = radiusRange

	customEmitter.thickness = thickness
	customEmitter.particleDuration = particleDuration
	
	customEmitter.initAlpha = initAlpha
	customEmitter.endAlpha = endAlpha
	
	customEmitter.colorR = nil
	customEmitter.colorG = nil
	customEmitter.colorB = nil
	
	return customEmitter

end

function setColor(customEmitter, red, green, blue)
   	
	if(red~=nil) then
		customEmitter.colorR = red
   	end
   	
	if(green~=nil) then
		customEmitter.colorG = green
	end
	
	if(blue~=nil) then
	   	customEmitter.colorB = blue
   	end
end

function emit(customEmitter, group, ex, ey)

	    local rx = math.random(ex - (customEmitter.radiusRange/15), ex + (customEmitter.radiusRange/15))
		local ry = math.random(ey - (customEmitter.radiusRange/15), ey + (customEmitter.radiusRange/15))
		
		local dx = math.random( ex - customEmitter.radiusRange, ex + customEmitter.radiusRange)
		local ranSign = math.random(2)
		
		if( ranSign == 2) then ranSign = -1 end 
		
		local dy = (ranSign*math.sqrt((customEmitter.radiusRange*customEmitter.radiusRange) - ((dx - ex)*(dx - ex)))) + ey

		
		local particle = display.newRect( group, rx - customEmitter.thickness/2, ry - customEmitter.thickness/2, customEmitter.thickness, customEmitter.thickness)
        particle.alpha = customEmitter.initAlpha
		
		if( customEmitter.colorR ~= nil) then
			if(customEmitter.colorR == -1) then
			    particle:setFillColor( math.random(0,255), math.random(0,255), math.random(0,255))
			else
				particle:setFillColor( customEmitter.colorR, customEmitter.colorG, customEmitter.colorB)
			end		
		end
		

		local transC = transition.to(particle, {time = customEmitter.particleDuration, x = dx, y = dy, alpha = customEmitter.endAlpha, transition = easing.outQuad, onComplete = function(event)
		particle:removeSelf()
		
	customEmitter = nil
	group = nil
	ex = nil
	ey = nil
		rx = nil
		ry = nil
		dx = nil
		dy = nil
		ranSign = nil
		transC = nil
		
		end})
end