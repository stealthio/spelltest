function register_spell(p_name, p_description, p_image, p_parameters, p_spell_effect, p_uses)
	minetest.register_craftitem("spelltest:" .. p_name,{
		description = p_description,
		inventory_image = p_image,
		on_use = function(itemstack, user, pointed_thing)
			itemstack:set_wear(itemstack:get_wear() + 65535 / (p_uses - 1))
			p_spell_effect(itemstack, user, pointed_thing, p_parameters, p_uses, p_description)
			local meta = itemstack:get_meta()
			if meta then
				meta:set_string("description", p_description .. " | " .. tostring(round(((65535 - itemstack:get_wear()) / 65535) * p_uses + 1)) .. " uses")
			end
			return itemstack
		end
	})
end

function projectile_create(itemstack, user, pointed_thing, p_parameters, uses, description, projectile_params)
	local velocity = 7
	local dir = user:get_look_dir()
	local playerpos = user:getpos()
	
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, p_parameters.entity)
	obj:setvelocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
	local node = minetest.get_node(pointed_thing)
	return itemstack
end

function register_projectile_spell(name, description, image, uses, texture, velocity, duration, on_collision_parameter_list, on_collision)
	register_projectile(name .. "_projectile", texture, velocity, duration, on_collision_parameter_list, on_collision)
	register_spell(name, description, image, {entity ="spelltest:" .. name .. "_projectile"}, projectile_create, uses)
end

function register_projectile(p_name, p_texture, p_velocity, p_duration, p_parameters, p_on_collision, p_collide_with_entities)
	minetest.register_entity("spelltest:" .. p_name,{
		textures = {p_texture},
		velocity = p_velocity,
		collisionbox = {0,0,0,0,0,0},
		prev_pos = {x= 0,y = 0 ,z = 0},
		on_step = function(self, obj, pos)
			p_collide_with_entities = p_collide_with_entities or true
			local remove = minetest.after(p_duration, function()
				self.object:remove()
			end)
			local pos = self.object:getpos()
			local n = minetest.get_node(pos).name
			if n ~= "spelltest:" .. p_name and n ~= "air" and prev_pos then
				p_parameters.self = self.object
				p_on_collision(prev_pos, curr_pos, p_parameters)
				--self.object:remove()
			end
			if p_collide_with_entities then
				local objs = minetest.get_objects_inside_radius({x=pos.x, y=pos.y, z=pos.z}, 1)
				for k, obj in pairs(objs) do
					if obj:get_luaentity().name ~= "spelltest:" .. p_name and obj:get_luaentity().name ~= "__builtin:item" then
						p_parameters.self = self.object
						p_on_collision(prev_pos, curr_pos, p_parameters)
					end
				end
			end
			prev_pos = {x=pos.x, y = pos.y, z = pos.z}
		end
	})
end

--- SPELL EFFECTS ---

-- parameters: height, block
function spell_effect_pillar(itemstack, user, pointed_thing, p_parameters, uses, description)
	local height = p_parameters.height
	local block = p_parameters.block
	local pos = minetest.get_pointed_thing_position(pointed_thing, true)
	for i=1, height do
		minetest.set_node(pos, {name = block})
		pos.y = pos.y + 1
	end
	return itemstack
end

-- parameters: value
function spell_effect_heal(itemstack, user, pointed_thing, p_parameters, uses, description)
		local max_uses = uses
		local healValue = p_parameters.value
		local mhp = tonumber(user:get_properties()['hp_max'])
		if(user:get_hp() + healValue > mhp) then
			user:set_hp(mhp)
		else
			user:set_hp(user:get_hp() + healValue)
		end
		return itemstack
end

-- parameters: value, duration
function spell_effect_low_gravity(itemstack, user, pointed_thing, p_parameters, uses, description)
	local gravity_value = p_parameters.value
	local default_gravity_value = 1
	local duration = p_parameters.duration
	
	user:set_physics_override({
		gravity = gravity_value,
	})
	minetest.after(duration, function()
		user:set_physics_override({
			gravity = default_gravity_value,
		})
	end)
	return itemstack
end

-- parameters: value
function spell_effect_set_time(itemstack, user, pointed_thing, p_parameters, uses, description)
	minetest.set_timeofday(p_parameters.value)
	return itemstack
end

-- parameters: block
function spell_effect_place_block(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos = minetest.get_pointed_thing_position(pointed_thing, true)
	if not pos then
		return itemstack
	end
	minetest.set_node(pos, {name = p_parameters.block})
	
	return itemstack
end

-- parameters: length, block
function spell_effect_place_row(itemstack, user, pointed_thing, p_parameters, uses, description)
	local length = p_parameters.length
	local block = p_parameters.block
	
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
	return itemstack
	
end

-- parameters: height, width, block
function spell_effect_place_wall(itemstack, user, pointed_thing, p_parameters, uses, description)
	local height = p_parameters.height
	local width = p_parameters.width
	local block = p_parameters.block

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
	return itemstack
end

--- SPELL REGISTRATION ---

-- (p_name, p_description, p_image, p_parameters, p_spell_effect, p_uses)
register_spell("spell_dirt_pillar", "Dirt Pillar", "spelltest_spell_red.png", {height = 10, block = "default:dirt"}, spell_effect_pillar, 7)
register_spell("spell_stone_pillar", "Stone Pillar", "spelltest_spell_red.png", {height = 7, block = "default:stone"}, spell_effect_pillar, 5)
register_spell("spell_fountain", "Fountain", "spelltest_spell_blue.png", {height = 7, block = "default:water_source"}, spell_effect_pillar, 5)
register_spell("spell_heal_weak", "Weak Heal", "spelltest_spell_green.png", {value = 3}, spell_effect_heal, 5)
register_spell("spell_heal_medium", "Medium Heal", "spelltest_spell_green.png", {value = 6}, spell_effect_heal, 5)
register_spell("spell_heal_strong", "Strong Heal", "spelltest_spell_green.png", {value = 10}, spell_effect_heal, 5)
register_spell("spell_low_gravity", "Low Gravity", "spelltest_spell_yellow.png", {value = 0.1, duration = 15}, spell_effect_low_gravity, 10)
register_spell("spell_zero_gravity", "Zero Gravity", "spelltest_spell_yellow.png", {value = 0, duration = 10}, spell_effect_low_gravity, 5)
register_spell("spell_night", "Night", "spelltest_spell_black.png", {value = 0}, spell_effect_set_time, 3)
register_spell("spell_day", "Day", "spelltest_spell_white.png", {value = 0.4}, spell_effect_set_time, 3)
register_spell("spell_water", "Water", "spelltest_spell_blue.png", {block = "default:water_source"}, spell_effect_place_block, 10)
register_spell("spell_flood", "Flood", "spelltest_spell_blue.png", {block = "default:river_water_source", length = 5 }, spell_effect_place_row, 5)
register_spell("spell_wall_stone", "Stonewall", "spelltest_spell_red.png", {block = "default:stone", height = 3, width = 7}, spell_effect_place_wall, 4)
register_spell("spell_wall_of_china", "Wall of China", "spelltest_spell_red.png", {block = "default:stone", height = 7, width = 70}, spell_effect_place_wall, 1)

-- (name, description, image, uses, texture, velocity, duration, on_collision_parameter_list, on_collision)
register_projectile_spell("spell_light", "Light", "spelltest_spell_white.png", 5,
						  "spelltest_light.png", 0.3, 2, {block = "spelltest:light"}, function(prev_pos, pos, parameter)
		minetest.set_node(prev_pos, {name = parameter.block})
		parameter.self:remove()
	end)

register_projectile_spell("spell_waterball", "Waterball", "spelltest_spell_blue.png", 5,
						  "spelltest_light.png", 0.5, 2, {block = "default:water_source"}, function(prev_pos, pos, parameter)
		minetest.set_node(prev_pos, {name = parameter.block})
		parameter.self:remove()
	end)
	
register_projectile_spell("spell_fireball", "Fireball", "spelltest_spell_red.png", 5,
						  "spelltest_light.png", 0.5, 2, {}, function(prev_pos, pos, parameter)
		pos = parameter.self:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x, y=pos.y, z=pos.z},2)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "spelltest:spell_fireball" and obj:get_luaentity().name ~= "__builtin:item" then
					obj:punch(parameter.self, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=8},
					}, nil)
				end
			end
		end
		parameter.self:remove()
	end)



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