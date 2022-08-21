--!strict
local tween_service: TweenService = game:GetService("RunService")

local function do_options(tabl, options)
	if type(tabl) ~= "table" then
		tabl = options
	else
		for i,v in pairs(options) do
			local val do
				if type(tabl[i]) ~= "nil" then
					val = tabl[i]
				else
					val = options[i]
				end
			end
	
			tabl[i] = val
		end
	end

	return tabl
end

local funcs = {
    Version = "1.0.0"
}

funcs.get_in = function(inst: Instance, options)
	options = do_options(options,
		{
			do_desc = false,
			do_isa = true,
			isa = {"BasePart"}
		}
	)

	local tabl = {}

	local get = options.do_desc and inst:GetDescendants() or inst:GetChildren()

	for _,v in pairs(get) do
		local v_lower = string.lower(v.Name)

		if options.do_isa == true then
			for i=1,#options.isa do
				if v:IsA(options.isa[i]) then tabl[#tabl+1] = v end
			end
		elseif table.find(options.names,v_lower) then
			tabl[#tabl+1] = v
		end
	end

	return tabl
end

funcs.concat_tables = function(concat_to, ...)
	local tables,c_table = {...},concat_to or {}

	local function asign_tabl(tabl)
		for i,v in pairs(tabl) do
			if type(i) == "number" then
				c_table[#c_table+1] = v
			else
				c_table[i] = v
			end
		end
	end

	for _,v in pairs(tables) do asign_tabl(v) end

	return  c_table
end




funcs.tween = function(inst: Instance,tween_info: TweenInfo,props)
    local tween_info: TweenInfo = tween_info or TweenInfo.new(
        .1,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.In,
        0,
        false,
        0
    )

    local tween: Tween = tween_service:Create(inst,tween_info,props)
    coroutine.wrap(function() tween:Play() end)()
end


return funcs
