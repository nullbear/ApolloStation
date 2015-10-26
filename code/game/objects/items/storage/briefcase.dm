/obj/item/storage/briefcase
	name = "briefcase"
	desc = "It's made of AUTHENTIC faux-leather and has a price-tag still attached. Its owner must be a real professional."
	icon_state = "briefcase"
	item_state = "briefcase"
	flags = CONDUCT
	force = 8.0
	throw_speed = 1
	throw_range = 4
	w_class = 3.0

/obj/item/storage/briefcase/New()
	..()
	storage.max_slots = 14
	storage.max_size = 2.0
	storage.max_volume = 26
