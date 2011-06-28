

local emitter = require("emitter")
local mainGroup = display.newGroup()
local emit1
local i
local mem = display.newText("Memory :"..tostring(collectgarbage("count")), 0, 0, nil, 20)



local function init()

emit1 = emitter.createEmitter(300,  50,  1500, 0.1, 0)
emitter.setColor(emit1,235,200,0)

end


local function burst(event)

    for i = 1,10 do
		emitter.emit(emit1, mainGroup, event.x, event.y)   
		
	end	
	
	mem.text = "Memory :"..tostring(collectgarbage("count"))
	
end

Runtime:addEventListener("touch", burst)

init()