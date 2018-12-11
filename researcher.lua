local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "wisdom" then
		if (stack:get_name() == "default:book") or
			(stack:get_name() == "default:bookshelf") then
			if inv:is_empty("src") then
				meta:set_string("infotext", "Researcher is empty")
			end
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

local function on_item_input(pos)
	local meta = minetest.get_meta(pos)
	local wisdom = 0
	local wisdom_required = 0
	
	local inv = meta:get_inventory()
	local srclist = inv:get_list("src")
	local wisdomlist = inv:get_list("wisdom")
end

minetest.register_node("spelltest:researcher",{
	description = "Researcher",
	can_dig = true,
	on_timer = reseacher_node_timer,
	tiles = {
		"researcher_top_empty.png",
		"researcher.png",
		"researcher.png",
		"researcher.png",
		"researcher.png",
		"researcher_front.png"
	},
	groups = {shoppy=3, snappy = 1},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
			"size[8,8]"..
			"list[context;src;2.75,1;1,1;]"..
			"list[context;wisdom;2.75,2;1,1;]"..
			"list[context;dst;4.75,1.5;1,1;]"..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"listring[context;dst]"..
			"listring[current_player;main]"..
			"listring[context;src]"..
			"listring[current_player;main]"..
			"listring[context;wisdom]"..
			"listring[current_player;main]"
		)
		meta:set_float("progress", 0)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
		inv:set_size('wisdom', 1)
		inv:set_size('dst', 1)
	end,
	
	on_metadata_inventory_move = function(pos)
		on_item_input(pos)
	end,
	on_metadata_inventory_put = function(pos)
		on_item_input(pos)
	end,
	
	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take
})