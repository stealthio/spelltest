local value_map_nodes = {
	-- NODES
	["default:stone"] = { value = 5, special = {"building"}},
	["default:cobble"] = { value = 5, special = {"building"}},
	["default:stonebrick"] = { value = 5, special = {"building"}},
	["default:stone_block"] = { value = 5, special = {"building"}},
	["default:mossycobble"] = { value = 10, special = {"building","plant"}},
	["default:desert_stone"] = { value = 3, special = {"building","fire"}},
	["default:desert_cobble"] = { value = 3, special = {"building","fire"}},
	["default:desert_stonebrick"] = { value = 4, special = {"building","fire"}},
	["default:desert_stone_block"] = { value = 4, special = {"building","fire"}},
	["default:sandstone"] = { value = 2, special = {"building","fire"}},
	["default:sandstonebrick"] = { value = 3, special = {"building","fire"}},
	["default:sandstone_block"] = { value = 2, special = {"building","fire"}},
	["default:desert_sandstone"] = { value = 2, special = {"building","fire"}},
	["default:desert_sandstone_brick"] = { value = 3, special = {"building","fire"}},
	["default:desert_sandstone_block"] = { value = 2, special = {"building","fire"}},
	["default:silver_sandstone"] = { value = 2, special = {"building","fire"}},
	["default:silver_sandstone_brick"] = { value = 3, special = {"building","fire"}},
	["default:silver_sandstone_block"] = { value = 2, special = {"building","fire"}},
	["default:obsidian"] = { value = 20, special = {"building","tough"}},
	["default:obsidianbrick"] = { value = 25, special = {"building","tough"}},
	["default:obsidian_block"] = { value = 20, special = {"building","tough"}},
	["default:dirt"] = { value = 1, special = {}},
	["default:dirt_with_grass"] = { value = 2, special = {}},
	["default:dirt_with_grass_footsteps"] = { value = 2, special = {}},
	["default:dirt_with_dry_grass"] = { value = 2, special = {}},
	["default:dirt_with_snow"] = { value = 2, special = {"ice"}},
	["default:dirt_with_rainforest_litter"] = { value = 2, special = {}},
	["default:dirt_with_coniferous_litter"] = { value = 2, special = {}},
	["default:permafrost"] = { value = 4, special = {"ice"}},
	["default:permafrost_with_stones"] = { value = 4, special = {"ice"}},
	["default:permafrost_with_moss"] = { value = 4, special = {"ice"}},
	["default:sand"] = { value = 1, special = {"fire"}},
	["default:desert_sand"] = { value = 1, special = {"fire"}},
	["default:silver_sand"] = { value = 2, special = {}},
	["default:gravel"] = { value = 2, special = {}},
	["default:clay"] = { value = 5, special = {"building"}},
	["default:snow"] = { value = 3, special = {"ice"}},
	["default:snowblock"] = { value = 3, special = {"ice"}},
	["default:ice"] = { value = 5, special = {"ice"}},
	["default:cave_ice"] = { value = 5, special = {"ice"}},
	["default:tree"] = { value = 5, special = {"building","plant"}},
	["default:wood"] = { value = 3, special = {"building","plant"}},
	["default:leaves"] = { value = 2, special = {"plant"}},
	["default:sapling"] = { value = 1, special = {"plant"}},
	["default:apple"] = { value = 2, special = {"plant"}},
	["default:jungletree"] = { value = 5, special = {"building","plant"}},
	["default:junglewood"] = { value = 3, special = {"building","plant"}},
	["default:jungleleaves"] = { value = 2, special = {"plant"}},
	["default:junglesapling"] = { value = 1, special = {"plant"}},
	["default:pine_tree"] = { value = 5, special = {"building","plant"}},
	["default:pine_wood"] = { value = 3, special = {"building","plant"}},
	["default:pine_needles"] = { value = 2, special = {"plant"}},
	["default:pine_sapling"] = { value = 1, special = {"plant"}},
	["default:acacia_tree"] = { value = 5, special = {"building","plant"}},
	["default:acacia_wood"] = { value = 3, special = {"building","plant"}},
	["default:acacia_leaves"] = { value = 2, special = {"plant"}},
	["default:acacia_sapling"] = { value = 1, special = {"plant"}},
	["default:aspen_tree"] = { value = 5, special = {"building","plant"}},
	["default:aspen_wood"] = { value = 3, special = {"building","plant"}},
	["default:aspen_leaves"] = { value = 2, special = {"plant"}},
	["default:aspen_sapling"] = { value = 1, special = {"plant"}},
	["default:coalblock"] = { value = 30, special = {"fire"}},
	["default:steelblock"] = { value = 50, special = {"building","tough"}},
	["default:copperblock"] = { value = 50, special = {"building","tough"}},
	["default:tinblock"] = { value = 50, special = {"building","tough"}},
	["default:bronzeblock"] = { value = 55, special = {"building","tough"}},
	["default:goldblock"] = { value = 70, special = {}},
	["default:mese"] = { value = 90, special = {"mese"}},
	["default:diamondblock"] = { value = 100, special = {"diamond"}},
	["default:cactus"] = { value = 5, special = {"plant"}},
	["default:papyrus"] = { value = 3, special = {"plant"}},
	["default:bookshelf"] = { value = 15, special = {}},
	["default:glass"] = { value = 12, special = {}},
	["default:obsidian_glass"] = { value = 30, special = {"tough"}},
	["default:brick"] = { value = 8, special = {"building","tough"}},
	["default:meselamp"] = { value = 40, special = {"mese","light"}},
	["default:mese_post_light"] = { value = 50, special = {"mese","light"}},
}

value_map_craftitems = {
	["default:stick"] = { value = 1, special = {}},
	["default:paper"] = { value = 2, special = {}},
	["default:book"] = { value = 5, special = {}},
	["default:book_written"] = { value = 5, special = {}},
	["default:skeleton_key"] = { value = 20, special = {}},
	["default:coal_lump"] = { value = 5, special = {"fire"}},
	["default:iron_lump"] = { value = 7, special = {"tough"}},
	["default:copper_lump"] = { value = 7, special = {"tough"}},
	["default:tin_lump"] = { value = 7, special = {"tough"}},
	["default:gold_lump"] = { value = 10, special = {}},
	["default:mese_crystal"] = { value = 25, special = {"mese"}},
	["default:mese_crystal_fragment"] = { value = 10, special = {"mese"}},
	["default:diamond"] = { value = 30, special = {"diamond"}},
	["default:clay_lump"] = { value = 5, special = {"building"}},
	["default:clay_brick"] = { value = 8, special = {"building"}},
	["default:obsidian_shard"] = { value = 8, special = {"building", "tough"}},
	["default:flint"] = { value = 4, special = {"fire"}},
	["default:blueberries"] = { value = 3, special = {"plant"}},
	["default:steel_ingot"] = { value = 15, special = {"tough"}},
	["default:copper_ingot"] = { value = 15, special = {"tough"}},
	["default:tin_ingot"] = { value = 15, special = {"tough"}},
	["default:bronze_ingot"] = { value = 15, special = {"tough"}},
	["default:gold_ingot"] = { value = 18, special = {"tough"}}
}

value_map_tools = {
	["default:pick_wood"] = { value = 3, special = {"tool"}},
	["default:pick_stone"] = { value = 6, special = {"tool"}},
	["default:pick_bronze"] = { value = 12, special = {"tool"}},
	["default:pick_steel"] = { value = 12, special = {"tool"}},
	["default:pick_mese"] = { value = 24, special = {"tool", "mese"}},
	["default:pick_diamond"] = { value = 24, special = {"tool", "diamond"}},
	
	["default:shovel_wood"] = { value = 3, special = {"tool"}},
	["default:shovel_stone"] = { value = 6, special = {"tool"}},
	["default:shovel_bronze"] = { value = 12, special = {"tool"}},
	["default:shovel_steel"] = { value = 12, special = {"tool"}},
	["default:shovel_mese"] = { value = 24, special = {"tool", "mese"}},
	["default:shovel_diamond"] = { value = 24, special = {"tool", "diamond"}},
	
	["default:axe_wood"] = { value = 3, special = {"tool"}},
	["default:axe_stone"] = { value = 6, special = {"tool"}},
	["default:axe_bronze"] = { value = 12, special = {"tool"}},
	["default:axe_steel"] = { value = 12, special = {"tool"}},
	["default:axe_mese"] = { value = 24, special = {"tool", "mese"}},
	["default:axe_diamond"] = { value = 24, special = {"tool", "diamond"}},
	
	["default:sword_wood"] = { value = 3, special = {"tool"}},
	["default:sword_stone"] = { value = 6, special = {"tool"}},
	["default:sword_bronze"] = { value = 12, special = {"tool"}},
	["default:sword_steel"] = { value = 12, special = {"tool"}},
	["default:sword_mese"] = { value = 24, special = {"tool", "mese"}},
	["default:sword_diamond"] = { value = 24, special = {"tool", "diamond"}},
}

value_map = {}

for k,v in pairs(value_map_nodes) do value_map[k] = v end
for k,v in pairs(value_map_craftitems) do value_map[k] = v end
for k,v in pairs(value_map_tools) do value_map[k] = v end

local special_map = {
	{special = "building", effects = {"spell_effect_make_sphere","spell_effect_spawn_house", "spell_effect_pillar", "spell_effect_place_wall", "spell_effect_place_block", "spell_effect_place_row", "spell_effect_dig_block"}},
	{special = "fire", effects = {"spell_effect_place_block","spell_effect_dig_block"}},
	{special = "plant", effects = {"spell_effect_heal", "spell_effect_dig_block", "spell_effect_tree"}},
	{special = "tough", effects = {"spell_effect_pillar", "spell_effect_place_wall", "spell_effect_place_row", "spell_effect_dig_block", "spell_effect_tunnel"}},
	{special = "diamond", effects = {"spell_effect_make_sphere","spell_effect_spawn_house","spell_effect_waypoint_teleport", "spell_effect_excavate","spell_effect_tree","spell_effect_low_gravity" , "spell_effect_tunnel", "spell_effect_place_wall"}},
	{special = "mese", effects = {"spell_effect_waypoint_teleport","spell_effect_low_gravity", "spell_effect_excavate", "spell_effect_set_time"}},
	{special = "light", effects = {"spell_effect_heal", "spell_effect_set_time"}},
	{special = "ice", effects = {"spell_effect_pillar", "spell_effect_place_wall", "spell_effect_place_block", "spell_effect_place_row"}},
	{special = "tool", effects = {"spell_effect_excavate","spell_effect_tunnel","spell_effect_pillar","spell_effect_place_wall", "spell_effect_place_block", "spell_effect_place_row", "spell_effect_dig_block"}}
}

local effect_display_name_map = {
	["spell_effect_pillar"] = "Summon Pillar",
	["spell_effect_place_wall"] = "Summon Wall",
	["spell_effect_place_block"] = "Place Block",
	["spell_effect_place_row"] = "Row",
	["spell_effect_dig_block"] = "Dig",
	["spell_effect_heal"] = "Heal",
	["spell_effect_tree"] = "Grow Tree",
	["spell_effect_tunnel"] = "Dig Tunnel",
	["spell_effect_excavate"] = "Excavate",
	["spell_effect_waypoint_teleport"] = "Teleportation (Waypoint)",
	["spell_effect_low_gravity"] = "Manipulate Gravity",
	["spell_effect_set_time"] = "Manipulate Daytime",
	["spell_effect_spawn_house"] = "Summon House",
	["spell_effect_make_sphere"] = "Summon Sphere"
}

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "paper" then
		if (stack:get_name() == "default:paper") and not inv:contains_item(listname, "default:paper") then
			return 1
		else
			return 0
		end
	end
	if not inv:contains_item(listname, stack:get_name()) then
		return 1
	else
		return 0
	end
	
end

local function pick_lesser_block(origin_block_name)
	local block = nil
	for k, v in pairs(value_map) do
		if k == origin_block_name then
			block = v
			break
		end
	end
	if not block then
		return "default:dirt"
	end
	local lower_border = block.value / 2
	local upper_border = block.value
	while true do
		for k, v in pairs(value_map_nodes) do
			if v.value < upper_border and v.value >= lower_border and math.random(100) < 50 then
				return k
			end
		end
		upper_border = upper_border + math.random(-1, 1)
		lower_border = lower_border + math.random(-1, 0)
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

local function get_researcher_inventory(inv)
	local item_size = inv:get_stack("size", 1)
	local item_block = inv:get_stack("block", 1)
	local item_req_item = inv:get_stack("req_item", 1)
	local item_value = inv:get_stack("value", 1)
	local item_uses = inv:get_stack("uses", 1)
	local item_req_item_cnt = inv:get_stack("req_item_cnt", 1)
	
	local f = {
		size_mod = {value = value_map[item_size:get_name()].value, special = value_map[item_size:get_name()].special},
		block_mod = {value = value_map[item_block:get_name()].value, special = value_map[item_block:get_name()].special},
		req_item_mod = {value = value_map[item_req_item:get_name()].value, special = value_map[item_req_item:get_name()].special},
		value_mod = {value = value_map[item_value:get_name()].value, special = value_map[item_value:get_name()].special},
		uses_mod = {value = value_map[item_uses:get_name()].value, special = value_map[item_uses:get_name()].special},
		req_item_cnt_mod = {value = value_map[item_req_item_cnt:get_name()].value, special = value_map[item_req_item_cnt:get_name()].special}
	}
	if not f.size_mod then
		f.size_mod = { value = 1, special = {}}
	end
	if not f.block_mod then
		f.block_mod = { value = 1, special = {}}
	end
	if not f.req_item_mod then
		f.req_item_mod = { value = 1, special = {}}
	end
	if not f.value_mod then
		f.value_mod = { value = 1, special = {}}
	end
	if not f.uses_mod then
		f.uses_mod = { value = 1, special = {}}
	end
	if not f.req_item_cnt_mod then
		f.req_item_cnt_mod = { value = 1, special = {}}
	end
	return f
end

local function get_specials_from_table(t)
	local specials = {
		{special = "building", value = 0},
		{special = "fire", value = 0},
		{special = "plant", value = 0},
		{special = "tough", value = 0},
		{special = "diamond", value = 0},
		{special = "mese", value = 0},
		{special = "light", value = 0},
		{special = "ice", value = 0},
		{special = "tool", value = 0}
	}

	for j= 1, #specials do
		for ke, va in pairs(t) do
			if type(va) ~= "number" then
				for i = 1, #va.special do
					if va.special[i] == specials[j].special then
						specials[j].value = specials[j].value + 1
					end
				end
			end
		end
	end
	return specials
end

local function pick_special(specials)
	while true do
		for i=1,#specials do
			if math.random(1,6) <= specials[i].value then
				for j = 1,#special_map do
					if special_map[j].special == specials[i].special then
						do return special_map[j].effects[math.random(#special_map[j].effects)] end
					end
				end
			end
			specials[i].value = specials[i].value + 1
		end
	end
end

local function refresh_list(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if (inv:is_empty("size")) or (inv:is_empty("block")) or (inv:is_empty("req_item")) or (inv:is_empty("value")) or (inv:is_empty("uses")) or (inv:is_empty("req_item_cnt")) then
		meta:set_string("formspec", meta:get_string("default_formspec"))
		return
	end
	
	local mods = get_researcher_inventory(inv)
	mods.specials = get_specials_from_table(mods)
	
	specials = {}
	for i=1, 5 do
		specials[pick_special(mods.specials)] = true
	end
	local possible_effects = ""
	local a = {}
	for k in pairs(specials) do
		local display_name = effect_display_name_map[k]
		if not display_name then display_name = k end
		possible_effects = possible_effects .. display_name .. ","
		table.insert(a, k)
	end
	meta:set_string("effect_choices", minetest.serialize(a))
	possible_effects = possible_effects:sub(1, -2)
	meta:set_string("formspec", meta:get_string("default_formspec") .. "textlist[3.5,6.15;4.8,1.5;possible_effects;" .. possible_effects .. "]")
end

local bool_to_number = {
	[true] = 1,
	[false] = 0
}
minetest.register_node("spelltest:researcher",{
	description = "Researcher",
	can_dig = true,
	light_source = 8,
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
		meta:set_string("default_formspec",
			"size[9,12]" ..
			"image[1,-0.7;8.5,8.5;researcher_bg.png]"..
			"list[context;size;1,0.5;1,1;]" ..
			"list[context;block;4,0;1,1;]" ..
			"list[context;req_item;7,0.5;1,1;]" ..
			"list[context;paper;4,2.5;1,1;]" ..
			"list[context;value;1,4.5;1,1;]" ..
			"list[context;uses;4,5;1,1;]" ..
			"list[context;req_item_cnt;7,4.5;1,1;]" ..
			"list[current_player;main;0.5,8;8,1;]"..
			"list[current_player;main;0.5,9;8,3;8]"..
			"button[0.5,6;3,1;confirm;Create Spell]" ..
			"field[0.79,6.75;3,2;spell_name;;Spell Name]"
		)
		meta:set_string("formspec", meta:get_string("default_formspec"))
		local inv = meta:get_inventory()
		inv:set_size('size', 1)
		inv:set_size('block', 1)
		inv:set_size('req_item', 1)
		inv:set_size('paper', 1)
		inv:set_size('value', 1)
		inv:set_size('uses', 1)
		inv:set_size('req_item_cnt', 1)
	end,
	
	on_receive_fields = function(pos, formname, fields, player)
	local meta = minetest.get_meta(pos)
		if(fields.possible_effects) then
			local event = minetest.explode_textlist_event(fields.possible_effects)
			if event.type == "CHG" then
				meta:set_int("researcher_selected_idx", event.index)
			end
		elseif(fields.confirm) then 

			local inv = meta:get_inventory()
			if inv:is_empty("paper") then
				minetest.chat_send_player(player:get_player_name(), "Researcher requires paper to work")
				return
			end
			if (inv:is_empty("size")) or (inv:is_empty("block")) or (inv:is_empty("req_item")) or (inv:is_empty("value")) or (inv:is_empty("uses")) or (inv:is_empty("req_item_cnt")) then
				minetest.chat_send_player(player:get_player_name(), "Fill all slots of the Reasearcher for it to operate")
				return
			end
			local idx = meta:get_int("researcher_selected_idx")
			if not idx or idx == -1 then
				minetest.chat_send_player(player:get_player_name(), "You must select a spell effect to create the spell")
				return
			end
			local effects = minetest.deserialize(meta:get_string("effect_choices"))
			local effect = effects[idx]
			
			local item_size = inv:get_stack("size", 1)
			local item_block = inv:get_stack("block", 1)
			local item_req_item = inv:get_stack("req_item", 1)
			local item_value = inv:get_stack("value", 1)
			local item_uses = inv:get_stack("uses", 1)
			local item_req_item_cnt = inv:get_stack("req_item_cnt", 1)
			
			local mods = get_researcher_inventory(inv)
			
			local sum = 0
			for k,v in pairs(mods) do
				sum = sum + v.value
			end
			mods.sum = sum
			mods.specials = get_specials_from_table(mods)
			
			-- Thanks @kevin.fiegenbaum [https://gitlab.com/kevin.fiegenbaum] for helping with various calculations!
			local max_single_block_value = 60
			local max_length = 50
			local max_width = 50
			local max_height = 50
			local max_uses = 50
			local max_duration = 120
			local max_value = 100
			local max_ph1 = 100
			local max_ph2 = 100
			
			local factor_length = math.random(0.5, 1)
			local factor_width = math.random(0.5, 1)
			local factor_height = math.random(0.5, 1)
			local mean_sum = mods.sum / 6
			
			local factor_size = math.min(mods.size_mod.value, mean_sum) / mean_sum
			local factor_value = math.min(mods.value_mod.value, mean_sum) / mean_sum
			local factor_uses = math.min(mods.uses_mod.value, mean_sum) / mean_sum
			local factor_ph1 = math.min(mods.req_item_mod.value, mean_sum) / mean_sum
			local factor_ph2 = math.min(mods.req_item_cnt_mod.value, mean_sum) / mean_sum
			
			mods.size_mod.value = (mods.size_mod.value / max_single_block_value) * factor_size
			mods.value_mod.value = (mods.value_mod.value / max_single_block_value) * factor_size
			
			local llength = math.ceil(mods.size_mod.value * factor_length * max_length)
			local lheight = math.ceil(mods.size_mod.value * factor_height * max_height)
			local lwidth = math.ceil(mods.size_mod.value * factor_width * max_width)
			local lduration = math.ceil(mods.value_mod.value * max_duration)
			local lvalue = math.ceil(mods.value_mod.value * max_value)
			local luses = math.ceil((mods.uses_mod.value / max_single_block_value) * factor_uses * max_uses)
			local lph1 = (mods.req_item_mod.value / max_single_block_value) * factor_ph1 * max_ph1
			local lph2 = (mods.req_item_cnt_mod.value / max_single_block_value) * factor_ph2 * max_ph2
			local lstr = ""
			
			-- fix parameters in case of certain effects
			if effect == "spell_effect_set_time" then -- limited to value 0 - 1
				lvalue = lvalue / 100
				if lvalue < 0 or lvalue > 1 then
					lvalue = 0
				end
			elseif effect == "spell_effect_low_gravity" then -- should be lower the higher the value
				lvalue = (max_single_block_value - lvalue) / max_single_block_value
			end
			
			local houses = {
				["plain"] = {"House_Plain_1", "House_Plain_2"},
				["simple"] = {"House_Simple_1", "House_Simple_2"},
				["advanced"] = {"House_Advanced_1"},
				["luxury"] = {"House_Advanced_1"}
			}
			
			if effect == "spell_effect_spawn_house" then
				luses = math.ceil(luses / 3)
				if lvalue < 10 then
					lstr = houses["plain"][math.random(#houses["plain"])]
				elseif lvalue < 30 then
					lstr = houses["simple"][math.random(#houses["simple"])]
				elseif lvalue < 70 then
					lstr = houses["advanced"][math.random(#houses["advanced"])]
				else
					lstr = houses["luxury"][math.random(#houses["luxury"])]
				end
			end
			-- --
			local spellstack = {
				name = "spelltest:spell_custom",
				count = 1
			}
			spellstack = ItemStack(spellstack)
			local spell = {
				spell_effect = effect,
				parameters = {
					length = llength,
					height = lheight,
					width = lwidth,
					duration = lduration,
					value = lvalue,
					block = pick_lesser_block(item_block:get_name()),
					str = lstr
				}
			}
			local spell_as_string = table_to_str(spell)
			local meta = spellstack:get_meta()
			local spell_name = spell.spell_effect
			if fields.spell_name then
				spell_name = fields.spell_name
			end
			meta:set_string("description", spell_name)
			meta:set_string("spell_description", spell_name)
			meta:set_int("spell_uses", luses)
			meta:set_string("spell", spell_as_string)
			inv:set_stack("paper", 1, spellstack)
			
			inv:set_stack('size', 1, nil)
			inv:set_stack('block', 1, nil)
			inv:set_stack('req_item', 1, nil)
			inv:set_stack('value', 1, nil)
			inv:set_stack('uses', 1, nil)
			inv:set_stack('req_item_cnt', 1, nil)
		end
    end,
	
	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
	
	on_metadata_inventory_put = refresh_list,
	on_metadata_inventory_move = refresh_list,
	on_metadata_inventory_take = refresh_list
	
})
