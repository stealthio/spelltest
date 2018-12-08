minetest.register_craftitem("spelltest:spell_heal",{
	description = "Spell - Heal",
	inventory_image = "spelltest_spell_green.png",
	on_use = function(itemstack, user, pointed_thing)
		local mhp = tonumber(user:get_properties()['hp_max'])
		local healValue = 10
		if(user:get_hp() + healValue > mhp) then
			user:set_hp(mhp)
		else
			user:set_hp(user:get_hp() + healValue)
		end
		itemstack:take_item()
		return itemstack
	end
})

minetest.register_craftitem("spelltest:spell_light",{
	description = "Spell - Light",
	inventory_image = "spelltest_spell_white.png",
	on_use = function(item, placer, pos) --function(itemstack, user, pointed_thing)
		local dir = placer:get_look_dir();
		local playerpos = placer:getpos();
		local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "spelltest:light_projectile")
		obj:setvelocity({x=dir.x*7,y=dir.y*7,z=dir.z*7})
		local node = minetest.get_node(pos)
		item:take_item()
		return item
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

minetest.register_entity("spelltest:light_projectile",{
	textures = {"spelltest_light.png"},
	velocity = 0.1,
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



