minetest.register_craft({
	output = "spelltest:spellbook",
	recipe = {
		{"default:book", "default:diamond", "default:book"},
		{"default:book", "default:book", "default:book"}
	}
})

minetest.register_craft({
	output = "spelltest:researcher",
	recipe = {
		{"default:bookshelf", "default:diamond", "default:bookshelf"},
		{"default:bookshelf", "default:bookshelf", "default:bookshelf"},
	}
})

minetest.register_craft({
	output = "spelltest:spell_custom",
	type = "shapeless",
	recipe = {
		"spelltest:spell_custom", "default:diamond"
	}
})
minetest.register_craft({
	output = "spelltest:spell_custom",
	type = "shapeless",
	recipe = {
		"spelltest:spell_custom", "default:gold_ingot"
	}
})
minetest.register_craft({
	output = "spelltest:spell_custom",
	type = "shapeless",
	recipe = {
		"spelltest:spell_custom", "default:coal_lump"
	}
})

minetest.register_craft_predict(function(itemstack, player, old_craft_grid, craft_inv)
	if itemstack:get_name() == "spelltest:spell_custom" then
		local prev_spell = nil
		local resource = nil
		for i=1, #old_craft_grid do
			if old_craft_grid[i]:get_name() == "spelltest:spell_custom" then
				prev_spell = old_craft_grid[i]
			elseif old_craft_grid[i]:get_name() ~= "" then
				resource = old_craft_grid[i]
			end
		end
		local prev_meta = prev_spell:get_meta()
		local description = prev_meta:get_string("description")
		local spell_description = prev_meta:get_string("spell_description")
		local spell_uses = prev_meta:get_int("spell_uses")
		local spell_wear = prev_spell:get_wear()
		local spell_params = prev_meta:get_string("spell")
		
		if not prev_spell or not prev_meta or not spell_params or not spell_uses then
			return
		end
		
		local block_value = value_map[resource:get_name()].value
		local new_wear = math.ceil(spell_wear - ((65535) * 0.5 * block_value / ( math.max( ( (str_to_table(spell_params).parameters.value) / 100 + ( str_to_table(spell_params).parameters.length / 50 ) / 2), 0.05) * 100) ) )
		if new_wear < 0 then
			new_wear = 0
		end
		local meta = itemstack:get_meta()
		meta:set_string("description", spell_description .. " | " .. tostring(round(((65535 - new_wear) / 65535) * spell_uses + 1)) .. " uses")
	end
end)

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	if itemstack:get_name() == "spelltest:spell_custom" then
		local prev_spell = nil
		local resource = nil
		for i=1, #old_craft_grid do
			if old_craft_grid[i]:get_name() == "spelltest:spell_custom" then
				prev_spell = old_craft_grid[i]
			elseif old_craft_grid[i]:get_name() ~= "" then
				resource = old_craft_grid[i]
			end
		end

		local prev_meta = prev_spell:get_meta()
		local description = prev_meta:get_string("description")
		local spell_description = prev_meta:get_string("spell_description")
		local spell_uses = prev_meta:get_int("spell_uses")
		local spell_wear = prev_spell:get_wear()
		local spell_params = prev_meta:get_string("spell")
		
		if not prev_spell or not prev_meta or not spell_params or not spell_uses then
			return
		end
		
		local block_value = value_map[resource:get_name()].value
		local new_wear = math.ceil(spell_wear - ((65535) * 0.5 * block_value / ( math.max( ( (str_to_table(spell_params).parameters.value) / 100 + ( str_to_table(spell_params).parameters.length / 50 ) / 2), 0.05) * 100) ) )
		if new_wear < 0 then
			new_wear = 0
		end
		itemstack:set_wear(new_wear)
		local meta = itemstack:get_meta()
		meta:set_string("description", spell_description .. " | " .. tostring(round(((65535 - itemstack:get_wear()) / 65535) * spell_uses + 1)) .. " uses")
		meta:set_string("spell_description", spell_description)
		meta:set_string("spell_uses", spell_uses)
		meta:set_string("spell", spell_params)
	end
end)