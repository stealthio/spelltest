# SpellTest
A spell-crafting system for MineTest


![SpellTest](screenshot.png "SpellTest")

## Description
This mod is based on Tukkek's idea on how to implement a rather dynamic spell system with flexible spell costs for his minerpg mod. SpellTest consists of two features, a spell book that can store creation of various spells or items with ingredients. The default two recipes are

* A Light-Spell which shoots out a projectile to cast light on the point it hits a surface, costing 5 torches.
* A Healing-Spell which heals the user by 10 HP costing 3 apples.

The recipes in the spell book are stored per player so you could use it on a multiplayer server and each player have their own spell books.

The other feature are spells, which can be randomly generated or implemented. They are implemented via different magic scrolls that are consumed to cast the spell. So far these are pre-implemented

* "spell_dirt_pillar"
* "spell_stone_pillar"
* "spell_fountain"
* "spell_heal_weak"
* "spell_heal_medium"
* "spell_heal_strong"
* "spell_low_gravity"
* "spell_zero_gravity"
* "spell_night"
* "spell_day"
* "spell_water"
* "spell_flood"
* "spell_wall_stone"

with more to come. Each of the spells have a different amount of charges that are depleted by using it. The charges left are shown in the description of the item.

## Commands
The following Commands are added by this mod:
- /add_recipe <player> <item_created> <amount> <item_cost>
- /reset_recipes <player>

## New Items

The following items are added by this mod:
* "spellbook"
* "spell_dirt_pillar"
* "spell_stone_pillar"
* "spell_fountain"
* "spell_heal_weak"
* "spell_heal_medium"
* "spell_heal_strong"
* "spell_low_gravity"
* "spell_zero_gravity"
* "spell_night"
* "spell_day"
* "spell_water"
* "spell_flood"
* "spell_wall_stone"
* "spell_custom"
* "spell_random"

# API Documentation 

## Creating a custom spell
- create a new itemstack from spelltest:spell_custom and do the basic stuff - count, description ...
- set the following meta datas for the itemstack:
	- STRING spell_description - Usually equals description, is used to change the name with uses left
	- INT	 spell_uses - Defines how often the spell may be used before it's destroyed
	- TABLE spell - Table with the wanted spell effect and parameters
		- STRING spell.spell_effect	- One of the given spell effect functions above. E.g "spell_effect_pillar", "spell_effect_place_row", "spell_effect_place_wall"
		- TABLE  spell.parameters - Stores all the parameters that are used for the given effect. All currently used parameters are: length, height, width, duration, value, block
- You're done.

# Change log

- 0.1 - Initial release
- 0.2 - Implemented parametised spells/randomly generated