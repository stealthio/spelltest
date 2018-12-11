local value_map = {
	["default:stone"] = { value = 1, special = {"building"}},
	["default:cobble"] = { value = 1, special = {"building"}},
	["default:stonebrick"] = { value = 2, special = {"building"}},
	["default:stone_block"] = { value = 2, special = {"building"}},
	["default:mossycobble"] = { value = 2, special = {"building","plant"}},
	["default:desert_stone"] = { value = 1, special = {"building","fire"}},
	["default:desert_cobble"] = { value = 1, special = {"building","fire"}},
	["default:desert_stonebrick"] = { value = 2, special = {"building","fire"}},
	["default:desert_stone_block"] = { value = 2, special = {"building","fire"}},
	["default:sandstone"] = { value = 1, special = {"building","fire"}},
	["default:sandstonebrick"] = { value = 1, special = {"building","fire"}},
	["default:sandstone_block"] = { value = 1, special = {"building","fire"}},
	["default:desert_sandstone"] = { value = 1, special = {"building","fire"}},
	["default:desert_sandstone_brick"] = { value = 2, special = {"building","fire"}},
	["default:desert_sandstone_block"] = { value = 1, special = {"building","fire"}},
	["default:silver_sandstone"] = { value = 1, special = {"building","fire"}},
	["default:silver_sandstone_brick"] = { value = 2, special = {"building","fire"}},
	["default:silver_sandstone_block"] = { value = 1, special = {"building","fire"}},
	["default:obsidian"] = { value = 5, special = {"building","tough"}},
	["default:obsidianbrick"] = { value = 7, special = {"building","tough"}},
	["default:obsidian_block"] = { value = 5, special = {"building","tough"}},
	["default:dirt"] = { value = 1, special = {}},
	["default:dirt_with_grass"] = { value = 1, special = {}},
	["default:dirt_with_grass_footsteps"] = { value = 1, special = {}},
	["default:dirt_with_dry_grass"] = { value = 1, special = {}},
	["default:dirt_with_snow"] = { value = 1, special = {"ice"}},
	["default:dirt_with_rainforest_litter"] = { value = 1, special = {}},
	["default:dirt_with_coniferous_litter"] = { value = 1, special = {}},
	["default:permafrost"] = { value = 3, special = {"ice"}},
	["default:permafrost_with_stones"] = { value = 3, special = {"ice"}},
	["default:permafrost_with_moss"] = { value = 3, special = {"ice"}},
	["default:sand"] = { value = 1, special = {"fire"}},
	["default:desert_sand"] = { value = 1, special = {"fire"}},
	["default:silver_sand"] = { value = 2, special = {}},
	["default:gravel"] = { value = 1, special = {}},
	["default:clay"] = { value = 2, special = {}},
	["default:snow"] = { value = 1, special = {"ice"}},
	["default:snowblock"] = { value = 2, special = {"ice"}},
	["default:ice"] = { value = 4, special = {"ice"}},
	["default:cave_ice"] = { value = 4, special = {"ice"}},
	["default:tree"] = { value = 3, special = {"building"}},
	["default:wood"] = { value = 2, special = {"building"}},
	["default:leaves"] = { value = 1, special = {"plant"}},
	["default:sapling"] = { value = 1, special = {"plant"}},
	["default:apple"] = { value = 1, special = {"plant"}},
	["default:jungletree"] = { value = 3, special = {"building"}},
	["default:junglewood"] = { value = 2, special = {"building"}},
	["default:jungleleaves"] = { value = 1, special = {"plant"}},
	["default:junglesapling"] = { value = 1, special = {"plant"}},
	["default:pine_tree"] = { value = 3, special = {"building"}},
	["default:pine_wood"] = { value = 2, special = {"building"}},
	["default:pine_needles"] = { value = 1, special = {"plant"}},
	["default:pine_sapling"] = { value = 1, special = {"plant"}},
	["default:acacia_tree"] = { value = 3, special = {"building"}},
	["default:acacia_wood"] = { value = 2, special = {"building"}},
	["default:acacia_leaves"] = { value = 1, special = {"plant"}},
	["default:acacia_sapling"] = { value = 1, special = {"plant"}},
	["default:aspen_tree"] = { value = 3, special = {"building"}},
	["default:aspen_wood"] = { value = 2, special = {"building"}},
	["default:aspen_leaves"] = { value = 1, special = {"plant"}},
	["default:aspen_sapling"] = { value = 1, special = {"plant"}},
	["default:coalblock"] = { value = 20, special = {"fire"}},
	["default:steelblock"] = { value = 30, special = {"building","tough"}},
	["default:copperblock"] = { value = 30, special = {"building","tough"}},
	["default:tinblock"] = { value = 30, special = {"building","tough"}},
	["default:bronzeblock"] = { value = 35, special = {"building","tough"}},
	["default:goldblock"] = { value = 50, special = {}},
	["default:mese"] = { value = 50, special = {"mese"}},
	["default:diamondblock"] = { value = 60, special = {"diamond"}},
	["default:cactus"] = { value = 2, special = {"plant"}},
	["default:papyrus"] = { value = 1, special = {"plant"}},
	["default:bookshelf"] = { value = 7, special = {}},
	["default:glass"] = { value = 5, special = {}},
	["default:obsidian_glass"] = { value = 15, special = {"tough"}},
	["default:brick"] = { value = 8, special = {"building","tough"}},
	["default:meselamp"] = { value = 40, special = {"mese","light"}},
	["default:mese_post_light"] = { value = 50, special = {"mese","light"}}
}

local special_map = {
	{special = "building", effects = {"spell_effect_pillar", "spell_effect_place_wall", "spell_effect_place_block", "spell_effect_place_row"}},
	{special = "fire", effects = {"spell_effect_place_block"}},
	{special = "plant", effects = {"spell_effect_heal"}},
	{special = "tough", effects = {"spell_effect_pillar", "spell_effect_place_wall", "spell_effect_place_block", "spell_effect_place_row"}},
	{special = "diamond", effects = {"spell_effect_low_gravity"}},
	{special = "mese", effects = {"spell_effect_low_gravity"}},
	{special = "light", effects = {"spell_effect_heal", "spell_effect_set_time"}},
	{special = "ice", effects = {"spell_effect_pillar", "spell_effect_place_wall", "spell_effect_place_block", "spell_effect_place_row"}}
}


local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "paper" then
		if (stack:get_name() == "default:paper") then
			return stack:get_count()
		else
			return 0
		end
	end
	return stack:get_count()
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


local function pick_special(specials)
	while true do
		for i=1,#specials do
			if math.random(0,100) <= specials[i].value then
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

local bool_to_number = {
	[true] = 1,
	[false] = 0
}
minetest.register_node("spelltest:researcher",{
	description = "Researcher",
	can_dig = true,
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
			"size[9,12]" ..
			"list[context;size;1,0.5;1,1;]" ..
			"list[context;block;4,0;1,1;]" ..
			"list[context;req_item;7,0.5;1,1;]" ..
			"list[context;paper;4,2.5;1,1;]" ..
			"list[context;value;1,4.5;1,1;]" ..
			"list[context;uses;4,5;1,1;]" ..
			"list[context;req_item_cnt;7,4.5;1,1;]" ..
			"list[current_player;main;0.5,7.5;8,1;]"..
			"list[current_player;main;0.5,8.5;8,3;8]"..
			"button[3,6;3,1;confirm;Create Spell]"
		)
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
		if(fields.confirm) then 
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if inv:is_empty("paper") then
				minetest.chat_send_player(player:get_player_name(), "Researcher requires paper to work")
				return
			end
			if (inv:is_empty("size")) or (inv:is_empty("block")) or (inv:is_empty("req_item")) or (inv:is_empty("value")) or (inv:is_empty("uses")) or (inv:is_empty("req_item_cnt")) then
				minetest.chat_send_player(player:get_player_name(), "Fill all slots of the Reasearcher for it to operate")
				return
			end
			local item_size = inv:get_stack("size", 1)
			local item_block = inv:get_stack("block", 1)
			local item_req_item = inv:get_stack("req_item", 1)
			local item_value = inv:get_stack("value", 1)
			local item_uses = inv:get_stack("uses", 1)
			local item_req_item_cnt = inv:get_stack("req_item_cnt", 1)
			
			local mods = {
				size_mod = value_map[item_size:get_name()],
				block_mod = value_map[item_block:get_name()],
				req_item_mod = value_map[item_req_item:get_name()],
				value_mod = value_map[item_value:get_name()],
				uses_mod = value_map[item_uses:get_name()],
				req_item_cnt_mod = value_map[item_req_item_cnt:get_name()]
			}
			if not mods.size_mod then
				mods.size_mod = { value = 1, special = {}}
			end
			if not mods.block_mod then
				mods.block_mod = { value = 1, special = {}}
			end
			if not mods.req_item_mod then
				mods.req_item_mod = { value = 1, special = {}}
			end
			if not mods.value_mod then
				mods.value_mod = { value = 1, special = {}}
			end
			if not mods.uses_mod then
				mods.uses_mod = { value = 1, special = {}}
			end
			if not mods.req_item_cnt_mod then
				mods.req_item_cnt_mod = { value = 1, special = {}}
			end
			
			local specials = {
				{special = "building", value = 0},
				{special = "fire", value = 0},
				{special = "plant", value = 0},
				{special = "tough", value = 0},
				{special = "diamond", value = 0},
				{special = "mese", value = 0},
				{special = "light", value = 0},
				{special = "ice", value = 0}
			}
			local sum = 0
			for j= 1, #specials do
				for ke, va in pairs(mods) do
					for i = 1, #va.special do
						if va.special[i] == specials[j].special then
							specials[j].value = specials[j].value + 1
						end
					end
				end
				sum = sum + specials[j].value
			end
			mods.specials = specials
			mods.sum = sum
			
			for k, v in pairs(mods.specials) do
				minetest.chat_send_player(player:get_player_name(), v.value .. "x " .. v.special)
			end
			minetest.chat_send_player(player:get_player_name(), "Sum of item values: " .. mods.sum)
			
			local spellstack = {
				name = "spelltest:spell_custom",
				count = 1
			}
			spellstack = ItemStack(spellstack)
			local spell = {
				spell_effect = pick_special(mods.specials),
				parameters = {
					length = math.floor(mods.size_mod.value * (mods.sum / 10) + math.random(0,2)),
					height = math.floor(mods.size_mod.value * (mods.sum / 10) + math.random(0,2)),
					width = math.floor(mods.size_mod.value * (mods.sum / 10) + math.random(0,2)),
					duration = math.floor(mods.value_mod.value * (mods.sum / 10) + math.random(0,2)),
					value = math.floor(mods.value_mod.value * (mods.sum / 10) + math.random(0,2)),
					block = item_block:get_name()
				}
			}
			local spell_as_string = table_to_str(spell)
			local meta = spellstack:get_meta()
			meta:set_string("description", spell.spell_effect)
			meta:set_string("spell_description", spell.spell_effect)
			meta:set_int("spell_uses", mods.uses_mod.value)
			meta:set_string("spell", spell_as_string)
			minetest.chat_send_player(player:get_player_name(), spell_as_string)
			inv:set_stack("paper", 1, spellstack)
		end
    end,
	
	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take
})
