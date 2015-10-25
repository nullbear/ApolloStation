// For simple dedicated storage objects like boxes and stuff. Makes it easier to share certain behaviours such as showing the amount of room remaining,
// opening when dragged to self, or attacked with an empty hand, accepting items when clicked on, as well as for slightly better code organization. (as opposed to them being classified as weapons.)

/obj/item/storage
	name = "storage item"
	desc = "a small item for storing objects"
	icon_state = "box"
	var/obj/storage/storage = new/obj/storage()

/obj/item/storage/examine()
	..()
	var/remainder = storage.max_volume - storage.total_volume()
	var/ttd = "There is a colossal amount of space inside."
	switch(remainder)
		if(0 to 1)
			ttd = "There is no room inside."
		if(2 to 7)
			ttd = "There is a tiny amount of room inside."
		if(8 to 25)
			ttd = "There is a small amount of room inside."
		if(26 to 79)
			ttd = "There is an average amount of room inside."
		if(80 to 241)
			ttd = "There is a large amount of room inside."
		if(242 to 727)
			ttd = "There is a huge amount of room inside."
		if(728 to 2185)
			ttd = "There is a gigantic amount of room inside."
		else
			ttd = "There is a colossal amount of room inside."

	usr << ttd