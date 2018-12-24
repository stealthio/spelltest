function register_spell(p_name, p_description, p_image, p_parameters, p_spell_effect, p_uses)
	minetest.register_craftitem("spelltest:" .. p_name,{
		description = p_description,
		inventory_image = p_image,
		stack_max = 1,
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

function register_projectile(p_name, p_texture, p_velocity, p_duration, p_parameters, p_on_collision)
	minetest.register_entity("spelltest:" .. p_name,{
		textures = {p_texture},
		velocity = p_velocity,
		collisionbox = {0,0,0,0,0,0},
		prev_pos = {x= 0,y = 0 ,z = 0},
		on_step = function(self, obj, pos)
			local remove = minetest.after(p_duration, function()
				self.object:remove()
			end)
			local pos = self.object:getpos()
			local n = minetest.get_node(pos).name
			if n ~= "spelltest:" .. p_name and n ~= "air" and prev_pos then
				p_parameters.self = self.object
				p_on_collision(prev_pos, curr_pos, p_parameters)
				self.object:remove()
			end
			prev_pos = {x=pos.x, y = pos.y, z = pos.z}
		end
	})
end

local custom_projectile = {
	initial_properties = {
		collide_with_objects = true,
		textures = {"spelltest_light.png"},
		velocity = 0,
		collisionbox = {0,0,0,0,0,0}
	},
	velocity = 0,
	callstring = "",
	on_collision_parameters = {},
	duration = 0,
	prev_pos = nil,
	values_set = false,
}

function custom_projectile:set_parameters(p_self,p_velocity, p_duration, p_callstring, p_on_collision_parameters)
	p_self:set_properties({
		velocity = p_velocity
	})
	self.on_collision_parameters = p_on_collision_parameters
	self.callstring = p_callstring
	local remove = minetest.after(p_duration, function()
		self.object:remove()
	end)
	self.values_set = true
end

function custom_projectile:on_activate(staticdata, dtime_s)
	local remove = minetest.after(10, function()
		self.object:remove()
	end)
end

function custom_projectile:on_step(dtime)
	if self.values_set then
		local pos = self.object:get_pos()
		local n = minetest.get_node(pos).name
		if self.prev_pos and pos then
			if n ~= "spelltest:custom_projectile" and n ~= "air" then
				local dir = vector.direction(self.prev_pos,pos)
				local raycast = minetest.raycast(self.prev_pos, vector.add(self.prev_pos, vector.multiply(dir,2)), false)			
				local pointed_thing = raycast:next()
				if pointed_thing then
					local call = cust_load_string(self.callstring)
					call({i = self.on_collision_parameters.i,
						  u = self.on_collision_parameters.u,
						  p = pointed_thing,
						  s = self.on_collision_parameters.s,
						  us = self.on_collision_parameters.us,
						  d = self.on_collision_parameters.d})
					self.object:remove()
				end
			end
			local objs = minetest.get_objects_inside_radius(pos,2)
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "spelltest:custom_projectile" and obj:get_luaentity().name ~= "__builtin:item" then
						local dir = vector.direction(self.prev_pos,pos)
						local raycast = minetest.raycast(self.prev_pos, vector.add(self.prev_pos, vector.multiply(dir,2)), true)			
						local pointed_thing = raycast:next()					
						local call = cust_load_string(self.callstring)
						call({i = self.on_collision_parameters.i,
							  u = obj,
							  p = pointed_thing,
							  s = self.on_collision_parameters.s,
							  us = self.on_collision_parameters.us,
							  d = self.on_collision_parameters.d})
						self.object:remove()
					end
				end
			end
		end
		self.prev_pos = {x=pos.x, y = pos.y, z = pos.z}
	end
end

minetest.register_entity("spelltest:custom_projectile", custom_projectile)

local function get_direction_object(pointed_thing)
	local pos1 = pointed_thing.above
	local pos2 = pointed_thing.under
	local x_mod = pos1.x - pos2.x
	local y_mod = pos1.y - pos2.y
	local z_mod = pos1.z - pos2.z
	local dir_obj = {x_mod = x_mod, y_mod = y_mod, z_mod = z_mod, x = 0, y = 0, z = 0, pos2 = {x = pos2.x, y = pos2.y, z = pos2.z}}
	return dir_obj
end

-- helper method that places a given blocktype relative to a pointer position if the player got building priviliges
local function checked_set_node (central_pointer, x_offset, y_offset, z_offset, block, user)
	if not minetest.is_protected({x = central_pointer.x + x_offset, y= central_pointer.y + y_offset, z = central_pointer.z + z_offset}, user:get_player_name()) then
		minetest.set_node({x = central_pointer.x + x_offset, y= central_pointer.y + y_offset, z = central_pointer.z + z_offset}, {name = block})
	end
end

-- a,b,c are x,y,z coordinates of the square oriented, relative to the central_pointer
-- x_mod, y_mod, z_mod the direction of "up"
-- half_square_side_length
-- central_pointer, the central point to evolve the square around
-- height_offset relative to the central_pointer
local function draw_square(dir_obj, i, half_square_side_length, height_offset, central_pointer, user, block)
  pointer = {x = 0, y = 0, z = 0}
  local x = dir_obj.x
  local y = dir_obj.y
  local z = dir_obj.z
  local curr_height = height_offset
  local base_edge = half_square_side_length
--use symmetry and calculate only one half of one side
  if math.abs(dir_obj.y_mod) == 1 then
    x = base_edge
    y = dir_obj.y_mod * curr_height
    z = i

    -- first two sides
		checked_set_node (central_pointer, x, y, z, block, user)
		checked_set_node (central_pointer, -x, y, z, block , user)
		checked_set_node (central_pointer, x, y, -z, block , user)
		checked_set_node (central_pointer, -x, y, -z, block , user)

		-- other two sides
		checked_set_node (central_pointer, z, y, x, block , user)
		checked_set_node (central_pointer, z, y, -x, block , user)
		checked_set_node (central_pointer, -z, y, x, block , user)
		checked_set_node (central_pointer, -z, y, -x, block , user)

  elseif math.abs(dir_obj.x_mod) == 1 then
    x = dir_obj.x_mod * curr_height
    y = base_edge
    z = i

		checked_set_node (central_pointer, x, y, z, block , user)
		checked_set_node (central_pointer, x, -y, z, block , user)
		checked_set_node (central_pointer, x, y, -z, block , user)
		checked_set_node (central_pointer, x, -y, -z, block , user)
    -- other two sides

		checked_set_node (central_pointer, x, z, y, block , user)
		checked_set_node (central_pointer, x, z, -y, block , user)
		checked_set_node (central_pointer, x, -z, y, block , user)
		checked_set_node (central_pointer, x, -z, -y, block , user)

  else
    x = base_edge
    y = i
    z = dir_obj.z_mod * curr_height

    -- first two sides
		checked_set_node (central_pointer, x, y, z, block , user)
		checked_set_node (central_pointer, x, -y, z, block , user)
		checked_set_node (central_pointer, -x, y, z, block , user)
		checked_set_node (central_pointer, -x, -y, z, block , user)

    -- other two sides
		checked_set_node (central_pointer, y, x, z, block , user)
		checked_set_node (central_pointer, -y, x, z, block , user)
		checked_set_node (central_pointer, y, -x, z, block , user)
		checked_set_node (central_pointer, -y, -x, z, block , user)
  end
end

--- SPELL EFFECTS ---
-- parameters: str(schematic)
function spell_effect_spawn_house(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos = pointed_thing.above
	if minetest.is_protected(pos, user:get_player_name()) then	
		return itemstack
	end
	if minetest.is_protected({x = pos.x - 10, y = pos.y, z = pos.z - 10}, user:get_player_name()) then	
		return itemstack
	end
	if minetest.is_protected({x = pos.x + 10, y = pos.y, z = pos.z + 10}, user:get_player_name()) then	
		return itemstack
	end
	if minetest.is_protected({x = pos.x - 10, y = pos.y + 10, z = pos.z - 10}, user:get_player_name()) then	
		return itemstack
	end
	if minetest.is_protected({x = pos.x + 10, y = pos.y + 10, z = pos.z + 10}, user:get_player_name()) then	
		return itemstack
	end
	if not pointed_thing.above then
		return itemstack
	end
	local path = minetest.get_modpath("spelltest") .. "/schematics/".. p_parameters.str .. ".mts"
	minetest.place_schematic({x= pos.x - 5, y = pos.y, z = pos.z - 5}, path, "random", {["wool:red"] = "default:wood", ["wool:green"] = "default:tree"}, true)
	return itemstack
end

-- params: height, pointed_thing
function spell_effect_make_pyramid(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos1 = pointed_thing.above
		if not pos1 then
	return itemstack
	end
	local node = nil
	local dir_obj = get_direction_object(pointed_thing)
	local block = p_parameters.block
	local height = 40 -- math.floor(p_parameters.height)
	local curr_height = 0
	local i = 0
	local base_edge = 0.5 * math.sqrt(3 * height)
	local central_pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
	local pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
	repeat
		i = 0
		-- repeat for every height
		repeat
			draw_square(dir_obj, i, base_edge, curr_height, central_pointer, user, block)
			i = i + 1
		until ( i > base_edge )
		curr_height = curr_height + 1
		base_edge = base_edge-1
	until ( base_edge  < 0)
	return itemstack
end

function spell_effect_make_tent(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos1 = pointed_thing.above
	if not pos1 then
		return itemstack
	end
	local node = nil
	local dir_obj = get_direction_object(pointed_thing)

	local block = p_parameters.block

	local height = 40 --  math.floor(p_parameters.height / 4)
	local i = 0
	local base_edge
	local central_pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
	local pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
	repeat
		base_edge = 0.5 * math.sqrt(3 * height)
		-- repeat for every height
		repeat
			draw_square(dir_obj, i, base_edge, height, central_pointer, user, block)
			i = i + 1
		until ( i > base_edge +1 )
		height = height -1
	until (height < 5)
	return itemstack
end

-- params: height, pointed_thing
function spell_effect_make_skyscraper(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos1 = pointed_thing.above
	if not pos1 then
		return itemstack
	end
	local node = nil
	local dir_obj = get_direction_object(pointed_thing)

	local block = p_parameters.block

	local height = math.floor(p_parameters.height)
	local curr_height = 0
	local i = 0
	local base_edge
	local central_pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
	local pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
	base_edge = 0.5 * math.sqrt(3 * height)
	repeat
		i = 0
		-- repeat for every height
		repeat
			draw_square(dir_obj, i, base_edge, curr_height, central_pointer, user, block)
			i = i + 1
		until ( i > base_edge + 1 )
		curr_height = curr_height + 1
		base_edge = 0.5 * math.sqrt(3 * (height - curr_height) )
		base_edge = base_edge-1
	until (height < curr_height + 1)

	return itemstack
end

-- params: height, pointed_thing
function spell_effect_make_cube(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos1 = pointed_thing.above
	if not pos1 then
		return itemstack
	end
	local node = nil
	local pos2 = pointed_thing.under
	local x_mod = pos1.x - pos2.x
	local y_mod = pos1.y - pos2.y
	local z_mod = pos1.z - pos2.z

	local block = p_parameters.block

	p_parameters.height = math.floor(p_parameters.height / 4)

	local central_pointer = {x = pos2.x , y = pos2.y, z = pos2.z }
	return itemstack
end

-- params: height, pointed_thing
function spell_effect_make_sphere(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos1 = pointed_thing.above
	if not pos1 then
		return itemstack
	end
	local node = nil
	local pos2 = pointed_thing.under
	local x_mod = pos1.x - pos2.x
	local y_mod = pos1.y - pos2.y
	local z_mod = pos1.z - pos2.z

	local block = p_parameters.block

	p_parameters.height = math.floor(p_parameters.height / 4)

	local radius = p_parameters.height
	local x = -radius
	local z = 0
	local err = 2 - 2 * radius        -- II. Quadrant

	local outer_radius = p_parameters.height
	local outer_x = -outer_radius
	local outer_y = 0
	local outer_err = 2 - 2 * outer_radius


	local central_pointer = {x = pos2.x , y = pos2.y, z = pos2.z }

	repeat
	  -- x_outer abs als höhe. Berechne den Radius über sin / cos
		radius = math.floor(math.cos(math.asin(math.abs(outer_x) / p_parameters.height)) * p_parameters.height)
		x = -radius
		z = 0
		err = 2 - 2 * radius        -- II. Quadrant
		repeat
		  --lower half
			checked_set_node (central_pointer, -x, outer_x, z, block , user) -- I
			checked_set_node (central_pointer, -outer_x, x, z, block , user) -- I
			checked_set_node (central_pointer, -z, outer_x, -x, block , user) -- II
			checked_set_node (central_pointer, -z, x, -outer_x, block , user) -- II

			checked_set_node (central_pointer, x, outer_x, -z, block , user) -- III
			checked_set_node (central_pointer, outer_x, x, -z, block , user) -- III
			checked_set_node (central_pointer, z, outer_x, x, block , user) -- IV
			checked_set_node (central_pointer, z, x, outer_x, block , user) -- IV ?

			-- upper half
			checked_set_node (central_pointer, -x, -outer_x, z, block , user) -- I
			checked_set_node (central_pointer, -outer_x, -x, z, block , user) -- I
			checked_set_node (central_pointer, -z, -outer_x, -x, block , user) -- II
			checked_set_node (central_pointer, -z, -x, -outer_x, block , user) -- II

			checked_set_node (central_pointer, x, -outer_x, -z, block , user) -- III
			checked_set_node (central_pointer, outer_x, -x, -z, block , user) -- III
			checked_set_node (central_pointer, z, -outer_x, x, block , user) -- IV
			checked_set_node (central_pointer, z, -x, outer_x, block , user) -- IV ?

			radius = err
			if radius <= z then
				z = z + 1
				err = err + z * 2 + 1
			end
			if radius > x or err > z then
				x = x + 1
				err = err + x * 2+1
			end
		until (x >= 0)

		if outer_radius <= z then
			outer_y = outer_y + 1
			outer_err = outer_err + outer_y * 2 + 1
		end
		if outer_radius > outer_x or outer_err > outer_y then
			outer_x = outer_x + 1
			outer_err = outer_err + outer_x * 2+1
		end
	until (outer_x > 0)

	return itemstack
end

-- parameters: height, block
function spell_effect_pillar(itemstack, user, pointed_thing, p_parameters, uses, description)
	local height = math.ceil(p_parameters.height * (p_parameters.value / 50))
	local block = p_parameters.block
	local pos = minetest.get_pointed_thing_position(pointed_thing, true)
	if not pos then
		return itemstack
	end
	for i=1, height do
		checked_set_node (pos, 0, 0, 0, block , user)
		pos.y = pos.y + 1
	end
	return itemstack
end

-- parameters: value
function spell_effect_heal(itemstack, user, pointed_thing, p_parameters, uses, description)
	local healValue = p_parameters.value
	user:set_hp(user:get_hp() + healValue)
	user:punch(user, 1.0, {
		full_punch_interval=1.0,
		damage_groups={fleshy=3},
	}, nil)
	return itemstack
end

-- parameters: value, duration
function spell_effect_low_gravity(itemstack, user, pointed_thing, p_parameters, uses, description)
	local gravity_value = p_parameters.value
	gravity_value = (60 - gravity_value) / 60
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
	local value = p_parameters.value
	value = value / 100
	if value < 0 or value > 1 then
		value = 0
	end
	minetest.set_timeofday(value)
	return itemstack
end

-- parameters: block
function spell_effect_place_block(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos = minetest.get_pointed_thing_position(pointed_thing, true)
	if not pos then
		return itemstack
	end
	checked_set_node(pos, 0, 0, 0, p_parameters.block , user)
	return itemstack
end

-- parameters: length, block
function spell_effect_place_row(itemstack, user, pointed_thing, p_parameters, uses, description)
	local length = math.ceil(p_parameters.length * (p_parameters.value / 50))
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
		checked_set_node (pos, 0, 0, 0, block , user)
		if (dir == 0) then
			pos.x = pos.x + 1
		else
			pos.z = pos.z + 1
		end
	end
	return itemstack
	
end

-- parameters: length, value
function spell_effect_tunnel(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos1 = pointed_thing.above
	if not pos1 then
		return itemstack
	end
	local pos2 = pointed_thing.under
	local x_mod = pos1.x - pos2.x
	local y_mod = pos1.y - pos2.y
	local z_mod = pos1.z - pos2.z
	local pointer = {x = pos2.x, y = pos2.y, z = pos2.z}
	local length = p_parameters.length
	
	for i=1, length do
		minetest.dig_node(pointer)--minetest.node_dig(pointer, minetest.get_node(pointer), user)
		pointer.x = pointer.x - x_mod
		pointer.y = pointer.y - y_mod
		pointer.z = pointer.z - z_mod
	end
	return itemstack
end

function spell_effect_waypoint_teleport(itemstack, user, pointed_thing, p_parameters, uses, description)
	if p_parameters.projectile then
		user:set_pos(pointed_thing.above)
	else
		local control = user:get_player_control()
		local meta = itemstack:get_meta()
		if control.sneak then
			local waypoint_string = minetest.serialize({x = user:get_pos().x,y = user:get_pos().y,z = user:get_pos().z})
			meta:set_string("waypoint", waypoint_string)
			minetest.chat_send_player(user:get_player_name(), "Waypoint set to: " .. waypoint_string)
			return itemstack
		else
			local waypoint_string = meta:get_string("waypoint")
			local waypoint = nil
			if waypoint_string then
				waypoint = minetest.deserialize(waypoint_string)
			else
				minetest.chat_send_player(user:get_player_name(), "Sneak use this item to set a waypoint")
				return itemstack
			end
			if waypoint then
				user:set_pos(waypoint)
			else
				minetest.chat_send_player(user:get_player_name(), "Sneak use this item to set a waypoint")
			end
		end
	end
	return itemstack
end

-- parameters: height, block
function spell_effect_make_skyscraper(itemstack, user, pointed_thing, p_parameters, uses, description)
  local pos1 = pointed_thing.above
  if not pos1 then
  	return itemstack
  end
  local node = nil
  local dir_obj = get_direction_object(pointed_thing)

  local block = p_parameters.block

  local height = math.floor(p_parameters.height)
  local curr_height = 0
  local i = 0
  local base_edge
	local central_pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
	local pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
  base_edge = 0.5 * math.sqrt(3 * height)
  repeat
  	i = 0
  	-- repeat for every height
  	repeat
      draw_square(dir_obj, i, base_edge, curr_height, central_pointer, user, block)
  		i = i + 1
  	until ( i > base_edge + 1 )
    curr_height = curr_height + 1
  	base_edge = 0.5 * math.sqrt(3 * (height - curr_height) )
  	base_edge = base_edge-1
  until (height < curr_height + 1)

	return itemstack
end

-- parameters: block, height
function spell_effect_make_tent(itemstack, user, pointed_thing, p_parameters, uses, description)
  local pos1 = pointed_thing.above
  if not pos1 then
  	return itemstack
  end
  local node = nil
  local dir_obj = get_direction_object(pointed_thing)

  local block = p_parameters.block

  local height = math.floor(p_parameters.height)
  local i = 0
  local base_edge
	local central_pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
  local pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
  repeat
  	base_edge = 0.5 * math.sqrt(3 * height)
  	-- repeat for every height
  	repeat
	  	draw_square(dir_obj, i, base_edge, height, central_pointer, user, block)
	  	i = i + 1
  	until ( i > base_edge +1 )
  	height = height -1
  until (height < 5)
	return itemstack
end

-- params: height, block
function spell_effect_make_pyramid(itemstack, user, pointed_thing, p_parameters, uses, description)
  local pos1 = pointed_thing.above
  if not pos1 then
  	return itemstack
  end
  local node = nil
  local dir_obj = get_direction_object(pointed_thing)
  local block = p_parameters.block
  local height = math.floor(p_parameters.height)
  local curr_height = 0
  local i = 0
  local base_edge = 0.5 * math.sqrt(3 * height)
  local central_pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
  local pointer = {x = dir_obj.pos2.x , y = dir_obj.pos2.y, z = dir_obj.pos2.z }
  repeat
  	i = 0
  	-- repeat for every height
  	repeat
			draw_square(dir_obj, i, base_edge, curr_height, central_pointer, user, block)
  		i = i + 1
  	until ( i > base_edge )
    curr_height = curr_height + 1
  	base_edge = base_edge-1
  until ( base_edge  < 0)
	return itemstack
end

-- parameters: block, width, height, length, value
function spell_effect_excavate(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos1 = pointed_thing.above
	if not pos1 then
		return itemstack
	end
	local node = nil
	local pos2 = pointed_thing.under
	local x_mod = pos1.x - pos2.x
	local y_mod = pos1.y - pos2.y
	local z_mod = pos1.z - pos2.z
	local pointer = {x = pos2.x, y = pos2.y, z = pos2.z}
	local length = math.ceil(p_parameters.length * (p_parameters.value / 300))
	local width = math.ceil(p_parameters.width * (p_parameters.value / 300));
	local height = math.ceil(p_parameters.height * (p_parameters.value / 300));

	height = height / 2
	width = width / 2

	for h = -height, height do
		for w = -width, width do
			if y_mod == 0 then
				pointer = {
					x = pos2.x + w * z_mod,
					y = pos2.y + h,
					z = pos2.z + w * x_mod
				}
			else
				pointer = {
					x = pos2.x + h,
					y = pos2.y,
					z = pos2.z + w
				}
			end
			for l = 1, length do
				node = minetest.get_node_or_nil(pointer)
				if node then
					minetest.dig_node(pointer)
				end
				
				pointer.x = pointer.x - x_mod
				pointer.y = pointer.y - y_mod
				pointer.z = pointer.z - z_mod
			end
		end
	end
	return itemstack
end

-- parameters: block, value
function spell_effect_tree(itemstack, user, pointed_thing, p_parameters, uses, description)
	local treedef = {
		axiom="FFFFFAFFBF",
		rules_a="[&&&FFFFF&&FFFF][&&&++++FFFFF&&FFFF][&&&----FFFFF&&FFFF]",
		rules_b="[&&&++FFFFF&&FFFF][&&&--FFFFF&&FFFF][&&&------FFFFF&&FFFF]",
		trunk="default:tree",
		leaves="default:leaves",
		angle=math.random(0,math.ceil(p_parameters.value/2)),
		iterations=math.ceil(p_parameters.value/10),
		random_level=0,
		trunk_type="single",
		thin_branches=true,
		fruit_chance=math.ceil(p_parameters.value/10),
		fruit=p_parameters.block
	}
	minetest.spawn_tree(pointed_thing.above, treedef)
	return itemstack
end

-- parameters: value
function spell_effect_dig_block(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos = pointed_thing.under
	if not pos then
		return itemstack
	end
	local value = p_parameters.value
	
	local node = minetest.get_node(pos).name
	local inv = user:get_inventory()
	if not minetest.is_protected(pos, user:get_player_name()) then
		inv:add_item("main", node .. " " .. math.floor(value / 15))
		minetest.set_node(pos, {name = "air"})
	end
	return itemstack
end

-- parameters: height, width, block
function spell_effect_place_wall(itemstack, user, pointed_thing, p_parameters, uses, description)
	local height = math.ceil(p_parameters.height * (p_parameters.value / 200))
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
			checked_set_node ({x = pos.x, y= pos.y + i - 1, z = pos.z}, 0, 0, 0, block , user)
		end
		if (dir == 0) then
			pos.x = pos.x + 1
		else
			pos.z = pos.z + 1
		end
	end
	return itemstack
end

-- parameters: block, height
function spell_effect_make_cube(itemstack, user, pointed_thing, p_parameters, uses, description)
	local pos1 = pointed_thing.above
	if not pos1 then
		return itemstack
	end
	local node = nil
	local pos2 = pointed_thing.under
	local x_mod = pos1.x - pos2.x
	local y_mod = pos1.y - pos2.y
	local z_mod = pos1.z - pos2.z

	local block = p_parameters.block
	p_parameters.height = math.floor(p_parameters.height / 4)
	local central_pointer = {x = pos2.x , y = pos2.y, z = pos2.z }
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

-- (name, description, image, uses, texture, velocity, duration, on_collision_parameter_list, on_collision)
register_projectile_spell("spell_light", "Light", "spelltest_spell_white.png", 5,
						  "spelltest_light.png", 0.3, 2, {block = "spelltest:light"}, function(prev_pos, pos, parameter)
		checked_set_node (prev_pos, 0, 0, 0, parameter.block)
	end)

register_projectile_spell("spell_waterball", "Waterball", "spelltest_spell_blue.png", 5,
						  "spelltest_light.png", 0.5, 2, {block = "default:water_source"}, function(prev_pos, pos, parameter)
		checked_set_node (prev_pos, 0, 0, 0, block , user)
	end)
	
register_projectile_spell("spell_fireball", "Fireball", "spelltest_spell_red.png", 5,
						  "spelltest_light.png", 0.5, 2, {}, function(prev_pos, pos, parameter)
		local objs = minetest.get_objects_inside_radius({x=prev_pos.x, y=prev_pos.y, z=prev_pos.z},2)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "spelltest:spell_fireball" and obj:get_luaentity().name ~= "__builtin:item" then
					obj:punch(parameter.self, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=3},
					}, nil)
				end
			end
		end
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

--[[
	HOW TO: Create a custom spell
	- create a new itemstack from spelltest:spell_custom and do the basic stuff - count, description ...
	- set the following meta datas for the itemstack:
		* STRING spell_description - Usually equals description, is used to change the name with uses left
		* INT	 spell_uses		   - Defines how often the spell may be used before it's destroyed
		* TABLE spell			   - Table with the wanted spell effect and parameters
			-> STRING spell.spell_effect	- One of the given spell effect functions above. E.g "spell_effect_pillar", "spell_effect_place_row", "spell_effect_place_wall"
			-> TABLE  spell.parameters		- Stores all the parameters that are used for the given effect. All currently used parameters are: length, height, width, duration, value, block
	- You're done.
--]]
minetest.register_craftitem("spelltest:spell_custom",{
	description = "Undefined Spell",
	inventory_image = "spelltest_spell_white.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		local meta = itemstack:get_meta()
		if not meta then
			minetest.chat_send_player(user:get_player_name(), "Could not load meta for spell")
			return itemstack
		end
		
		local spell_string 		= meta:get_string("spell") -- consists of: spell_effect, parameters {length, height, width, duration, value, block}
		local spell_description = meta:get_string("spell_description")
		local uses 				= meta:get_int("spell_uses")
		local spell 			= nil
		
		if not spell_string then
			minetest.chat_send_player(user:get_player_name(), "Spell not defined yet")
			return itemstack
		else 
			spell = str_to_table(spell_string)
		end
		
		if not spell then
			minetest.chat_send_player(user:get_player_name(), "Spell metadata faulty, look into debug.log for details")
			minetest.log("spelltest:ERROR - Faulty metadata: " .. spell_string)
			return itemstack
		end
		
		itemstack:set_wear(itemstack:get_wear() + 65535 / (uses - 1))
		local callstring = spell.spell_effect .. "(arg.i, arg.u, arg.p, arg.s.parameters, arg.us, arg.d)"
		
		if spell.parameters.projectile then
				local velocity = spell.parameters.value
				local dir = user:get_look_dir()
				local playerpos = user:getpos()
				local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "spelltest:custom_projectile")
				obj:setvelocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
				obj:get_luaentity():set_parameters(obj,velocity, spell.parameters.duration, callstring, {
					i = itemstack, u = user, p = pointed_thing, s = spell, us = uses, d = spell_description
				})
		else 
			local call = cust_load_string(callstring)
			call({i = itemstack, u = user, p = pointed_thing, s = spell, us = uses, d = spell_description})
		end
		
		meta:set_string("description", meta:get_string("spell_description") .. " | " .. tostring(round(((65535 - itemstack:get_wear()) / 65535) * uses + 1)) .. " uses")
		return itemstack
	end
})

function cust_load_string(str, name)
	local f, err = loadstring("return function(arg) " .. str .. " end", name or str)
	if f then 
		return f()
	else
		return f, err
	end
end

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

function str_to_table(s)
	if not (s) or s == "nil" then
		return
	end
	return loadstring("return "..s)()
end

-- functions to serialize tables http://lua-users.org/wiki/TableUtils

function val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table_to_str( v ) or
      tostring( v )
  end
end

function key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. val_to_str( k ) .. "]"
  end
end

function table_to_str( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        key_to_str( k ) .. "=" .. val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end