minetest.register_craftitem("spelltest:spell_heal",{
	description = "Spell - Heal",
	inventory_image = "spelltest_spell_green.png",
	on_use = function(itemstack, user, pointed_thing)
		-- Spell parameters
		local max_uses = 5
		local healValue = 10
		local mhp = tonumber(user:get_properties()['hp_max'])
		
		itemstack:set_wear(itemstack:get_wear() + 65535 / (max_uses - 1))
		if(user:get_hp() + healValue > mhp) then
			user:set_hp(mhp)
		else
			user:set_hp(user:get_hp() + healValue)
		end
		local meta = itemstack:get_meta()
		if meta then
			meta:set_string("description", "Spell - Heal | " .. tostring(round(((65535 - itemstack:get_wear()) / 65535) * max_uses + 1)) .. " uses")
		end
		return itemstack
	end
})

minetest.register_craftitem("spelltest:spell_low_gravity",{
	description = "Spell - Low Gravity",
	inventory_image = "spelltest_spell_yellow.png",
	on_use = function(itemstack, user, pointed_thing)
		-- Spell parameters
		local max_uses = 5
		local gravity_value = 0.1
		local default_gravity_value = 1
		local duration = 15
		
		itemstack:set_wear(itemstack:get_wear() + 65535 / (max_uses - 1))
		
		user:set_physics_override({
			gravity = gravity_value,
		})
		minetest.after(duration, function()
			user:set_physics_override({
				gravity = default_gravity_value,
			})
		end)
		local meta = itemstack:get_meta()
		if meta then
			meta:set_string("description", "Spell - Low Gravity | " .. tostring(round(((65535 - itemstack:get_wear()) / 65535) * max_uses + 1)) .. " uses")
		end
		return itemstack
	end
})

minetest.register_craftitem("spelltest:spell_light",{
	description = "Spell - Light",
	inventory_image = "spelltest_spell_white.png",
	on_use = function(itemstack, placer, pos)
		-- Spell parameters
		local max_uses = 10
		local velocity = 10
		
		itemstack:set_wear(itemstack:get_wear() + 65535 / (max_uses - 1))
		local dir = placer:get_look_dir()
		local playerpos = placer:getpos()
		local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "spelltest:light_projectile")
		obj:setvelocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
		local node = minetest.get_node(pos)
		local meta = itemstack:get_meta()
		if meta then
			meta:set_string("description", "Spell - Light | " .. tostring(round(((65535 - itemstack:get_wear()) / 65535) * max_uses + 1)) .. " uses")
		end
		return itemstack
	end
})

minetest.register_craftitem("spelltest:spell_night",{
	description = "Spell - Night",
	inventory_image = "spelltest_spell_black.png",
	on_use = function(itemstack, user, pointed_thing)
		minetest.set_timeofday(0)
		itemstack:take_item()
		return itemstack
	end
})

minetest.register_craftitem("spelltest:spell_day",{
	description = "Spell - Day",
	inventory_image = "spelltest_spell_white.png",
	on_use = function(itemstack, user, pointed_thing)
		minetest.set_timeofday(0.4)
		itemstack:take_item()
		return itemstack
	end
})

minetest.register_craftitem("spelltest:spell_pillar_stone",{
	description = "Spell - Stonepillar",
	inventory_image = "spelltest_spell_red.png",
	on_use = function(itemstack, user, pointed_thing)
		-- Spell parameters
		local max_uses = 10
		local height = 5
		local block = "default:stone"
		itemstack:set_wear(itemstack:get_wear() + 65535 / (max_uses - 1))
		
		local pos = minetest.get_pointed_thing_position(pointed_thing, true)
		for i=1, height do
			minetest.set_node(pos, {name = block})
			pos.y = pos.y + 1
		end
		
		local meta = itemstack:get_meta()
		if meta then
			meta:set_string("description", "Spell - Stonepillar | " .. tostring(round(((65535 - itemstack:get_wear()) / 65535) * max_uses + 1)) .. " uses")
		end
		return itemstack
	end
})

minetest.register_craftitem("spelltest:spell_water",{
	description = "Spell - Water",
	inventory_image = "spelltest_spell_blue.png",
	on_use = function(itemstack, user, pointed_thing)
		-- Spell parameters
		local max_uses = 10
		local block = "default:water_source"
		
		itemstack:set_wear(itemstack:get_wear() + 65535 / (max_uses - 1))
		
		local pos = minetest.get_pointed_thing_position(pointed_thing, true)
		if not pos then
			return itemstack
		end
		minetest.set_node(pos, {name = block})
		
		local meta = itemstack:get_meta()
		if meta then
			meta:set_string("description", "Spell - Water | " .. tostring(round(((65535 - itemstack:get_wear()) / 65535) * max_uses + 1)) .. " uses")
		end
		return itemstack
	end
})

minetest.register_craftitem("spelltest:spell_flood",{
	description = "Spell - Flood",
	inventory_image = "spelltest_spell_blue.png",
	on_use = function(itemstack, user, pointed_thing)
		-- Spell parameters
		local max_uses = 5
		local length = 5
		local block = "default:river_water_source"
		itemstack:set_wear(itemstack:get_wear() + 65535 / (max_uses - 1))
		
		local pos = minetest.get_pointed_thing_position(pointed_thing, true)
		if not pos then
			return itemstack
		end
		
		local player_pos = user:get_pos()
		
		local xdif = pos.x - player_pos.x
		local zdif = pos.z - player_pos.z
		local dir = 1
		if math.abs(xdif) > math.abs(zdif) then
			dir = 0
		end

		for i=1, length do
			minetest.set_node(pos, {name = block})
			if (dir == 0) then
				pos.x = pos.x + 1
			else
				pos.z = pos.z + 1
			end
		end
		
		local meta = itemstack:get_meta()
		if meta then
			meta:set_string("description", "Spell - Flood | " .. tostring(round(((65535 - itemstack:get_wear()) / 65535) * max_uses + 1)) .. " uses")
		end
		return itemstack
	end
})

minetest.register_craftitem("spelltest:spell_wall_stone",{
	description = "Spell - Stonewall",
	inventory_image = "spelltest_spell_red.png",
	on_use = function(itemstack, user, pointed_thing)
		-- Spell parameters
		local max_uses = 10
		local height = 3
		local width = 7
		local block = "default:stone"
		
		itemstack:set_wear(itemstack:get_wear() + 65535 / (max_uses - 1))
		local pos = minetest.get_pointed_thing_position(pointed_thing, true)
		if not pos then
			return itemstack
		end
		local player_pos = user:get_pos()
		
		local xdif = pos.x - player_pos.x
		local zdif = pos.z - player_pos.z
		local dir = 0
		if math.abs(xdif) > math.abs(zdif) then
			dir = 1
			pos.z = pos.z - round(width / 2)
		else
			pos.x = pos.x - round(width / 2)
		end
		
		for j=1, width do
			for i=1, height do
				minetest.set_node({x = pos.x, y= pos.y + i - 1, z = pos.z}, {name = block})
			end
			if (dir == 0) then
				pos.x = pos.x + 1
			else
				pos.z = pos.z + 1
			end
		end
		
		local meta = itemstack:get_meta()
		if meta then
			meta:set_string("description", "Spell - Stonewall | " .. tostring(round(((65535 - itemstack:get_wear()) / 65535) * max_uses + 1)) .. " uses")
		end
		return itemstack
	end
})

minetest.register_entity("spelltest:light_projectile",{
	textures = {"spelltest_light.png"},
	velocity = 0.3,
	collisionbox = {0,0,0,0,0,0},
	previous_pos = {x= 0,y = 0 ,z = 0},
	on_step = function(self, obj, pos)
		local remove = minetest.after(2, function()
			self.object:remove()
		end)
		local pos = self.object:getpos()
		local n = minetest.get_node(pos).name
		if n ~= "spelltest:light_projectile" and n ~= "air" and previous_pos then
			minetest.set_node(previous_pos, {name = "spelltest:light"})
			self.object:remove()
		end
		
		previous_pos = {x=pos.x, y = pos.y, z = pos.z}
	end
})

minetest.register_node("spelltest:light",{
	drawtype = "plantlike",
	tiles = {"spelltest_light.png"},
	paramtype = "light",
	light_source = 10,
	walkable = true,
	drop = "",
	groups = {dig_immediate = 2}
})


function round(n)
	return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

function sign(n)
	if n < 0 then
		return -1
	elseif n > 0 then
		return 1
	else
		return 0
	end
end