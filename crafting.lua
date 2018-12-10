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