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

/obj/item/storage/MouseDrop(obj/over_object as obj)

	if(!canremove)
		return

	if (ishuman(usr) || issmall(usr)) //so monkeys can take off their backpacks -- Urist

		if (istype(usr.loc,/obj/mecha)) // stops inventory actions in a mech
			return

		if(over_object == usr && Adjacent(usr)) // this must come before the screen objects only block
			storage.open(usr)
			return

		if (!( istype(over_object, /obj/screen) ))
			return ..()

		//makes sure that the storage is equipped, so that we can't drag it into our hand from miles away.
		//there's got to be a better way of doing this.
		if (!(src.loc == usr) || (src.loc && src.loc.loc == usr))
			return

		if (!( usr.restrained() ) && !( usr.stat ))
			switch(over_object.name)
				if("r_hand")
					usr.u_equip(src)
					usr.put_in_r_hand(src)
				if("l_hand")
					usr.u_equip(src)
					usr.put_in_l_hand(src)
			src.add_fingerprint(usr)
			return
	return

/obj/item/storage/attack_hand(mob/user as mob)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.l_store == src && !H.get_active_hand())	//Prevents opening if it's in a pocket.
			H.put_in_hands(src)
			H.l_store = null
			return
		if(H.r_store == src && !H.get_active_hand())
			H.put_in_hands(src)
			H.r_store = null
			return

	if (src.loc == user)
		storage.open(user)
	else
		..()
		for(var/mob/M in range(1))
			if (M.s_active == storage)
				storage.close(M)
	src.add_fingerprint(user)
	return

//This proc is called when you want to place an item into the storage item.
/obj/item/storage/attackby(obj/item/W as obj, mob/user as mob)
	..()

	if(isrobot(user))
		user << "\blue You're a robot. No."
		return //Robots can't interact with storage items.

	if(!storage.can_be_inserted(W))
		return

	W.add_fingerprint(user)
	return storage.insert(W)

/obj/item/storage/hear_talk(mob/M as mob, text, verb, datum/language/speaking)
	for(var/obj/O in storage)
		O.hear_talk(M, text, verb, speaking)
	return

/obj/item/storage/emp_act(severity)
	for(var/obj/O in storage)
		O.emp_act(severity)
	return