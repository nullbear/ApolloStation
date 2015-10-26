/*

	Item Storage

	This is a container that is able to store items, allowing for more flexible useage across code.

	max_size affects the maximum weight class the storage object can hold.
	total_volume affects the total volume the storage can hold. Object Volume is calculated by weight class:

	w_class 1 = 2u
	w_class 2 = 5u
	w_class 3 = 18u
	w_class 4 = 65u
	w_class 5 = 218u
	w_class 6 = 693u

	While Internal volume is USUALLY determined by weight class:

	w_class 1 = 2u, can store ONE tiny object, but usually due to w_size limitations, will not store anything.
	w_class 2 = 8u, can store FOUR tiny objects.
	w_class 3 = 26u, can store THIRTEEN tiny objects or FIVE small objects.
	w_class 4 = 80u, can store FOURTY tiny objects, SIXTEEN small or FOUR average and EIGHT tiny.
	w_class 5 = 242u, can store FORTY-NINE tiny, FORTY EIGHT small, THIRTEEN average, or THREE large and TWENTY THREE tiny.
	w_class 6 = 728u, can store FORTY-NINE tiny or small, FORTY average, ELEVEN large, THREE huge, or ONE gigantic and 17 tiny.

	A bag of holding, can store 49 pens, 48 pda's, 13 boxes, or 3 Backpacks.
	A backpack, can store 40 pens, 16 pdas, or 4 boxes.

	When examined, a bag will calculate the amount of space remaining inside, and return a value similar to w_class in a way that is intuitive, but not too mechanical.

	For example:

	There is a colossal amount of space, means that there is more than 2,138 units of space remaining, any item should fit.
	There is a gigantic amount of space, means that there is between 693, and 2,138 units of space remaining, a gigantic item will fit.
	There is a huge amount of space, means that there is between 218, and 693 units of space remaining, a huge item will fit.
	There is a large amount of space, means that there is between 65 and 218 units of space remaining, a large item will fit.
	There is a normal amount of space, means that there is between 18 and 65 units of space remaining, an average item will fit.
	There is a small amount of space, means that there is between 5 and 18 units of space remaining, a small item will fit.
	There is a tiny amount of space means that there is between 2 and 5 units of space remaining, a tiny item will fit.
	It is full, means that there is less than 2 units of space remaining, and nothing will fit.


	Flavour:

	use_sound // The sound that is used whenever this object is handled.
	inventory_images // The icon that is used whenever this object is handled.

	Screen:

	boxes // The boxes displayed on the screen, which represent the inventory.
	closer // The button displayed on the screen, which closes the inventory when clicked.


	Procs and Verbs:

	Destroy(drop_contents) // If drop_contents is set to 1, the object will drop the contents onto the floor, instead.
	Return_Inv() // Will return the objects inventory as a list, including the inventory of all objects inside.

*/


/obj/storage
	name = "storage container"
	desc = "a container for storing objects inside of another object."

	var/updates_icon = 0 // Whether the container should update it's icon when objects are interacted with.
	var/min_slots = 7	// The amount of slots that will always show for this object, even when empty.
	var/max_slots = 0 // The hard limit to the amount of slots in a container. This will prevent new items being added even if there is volumetric space. 0 Allows for infinite items.
	var/max_size = 3.0 // The maximum size of an object that can be placed within the container.
	var/max_volume = 21 // The total volume of objects that can be placed inside the container.
	var/whitelist = 1	// Whether the hold_list is a whitelist, or a blacklist.
	var/list/hold_list = new/list() // A list of items that are either blacklisted, or whitelisted to this storage container.

	// Flavour

	var/use_sound = "rustle"	//sound played when used. May add alternative sounds depending on inventory type. (ie. metallic for crates. rustle for cloth. static/electrical for bluespace.)
	var/icon/inventory_images	//icon file to use for boxes and internal inventory. May add alternative appearances depending on inventory type. (ie. cloth for cloth, grey for metal, blue for bluespace.)

	// Screen

	var/obj/screen/storage/boxes = null
	var/obj/screen/close/closer = null

/obj/storage/New()
	src.boxes = new /obj/screen/storage(  )
	src.boxes.name = "storage"
	src.boxes.master = src
	src.boxes.icon_state = "block"
	src.boxes.screen_loc = "7,7 to 10,8"
	src.boxes.layer = 19
	src.closer = new /obj/screen/close(  )
	src.closer.master = src
	src.closer.icon_state = "x"
	src.closer.layer = 20
	orient2hud()
	return

/obj/storage/proc/reset() // Deletes the contents of the storage container.
	for (var/obj/A in src)
		del(A)
	return

/obj/storage/Destroy(var/drop_contents = 0)
	for(var/obj/I in src)
		if(drop_contents)
			I.loc = get_turf(src)
		else
			qdel(I)
	hold_list = null
	boxes = null
	closer = null
	..()

/obj/storage/proc/return_inv()

	var/list/L = list(  )

	L += src.contents

	for(var/obj/A in src)
		for(var/obj/storage/S in A)
			L += S.return_inv()

	return L

/obj/storage/proc/show_to(mob/user as mob)
	if(user.s_active != src)
		for(var/obj/A in src)
			if(A.on_found(user))
				return
	if(user.s_active)
		user.s_active.hide_from(user)
	user.client.screen += src.boxes
	user.client.screen += src.closer
	user.client.screen += src.contents
	user.s_active = src
	return

/obj/storage/proc/hide_from(mob/user as mob)

	if(!user.client)
		return
	user.client.screen -= src.boxes
	user.client.screen -= src.closer
	user.client.screen -= src.contents
	if(user.s_active == src)
		user.s_active = null
	return

/obj/storage/proc/open(mob/user as mob)
	if (src.use_sound)
		playsound(src.loc, src.use_sound, 50, 1, -5)

	orient2hud(user)
	if (user.s_active)
		user.s_active.close(user)
	show_to(user)

/obj/storage/proc/close(mob/user as mob)

	src.hide_from(user)
	user.s_active = null
	return

//This proc draws out the inventory and places the items on it. tx and ty are the upper left tile and mx, my are the bottm right.
//The numbers are calculated from the bottom-left The bottom-left slot being 1,1.
/obj/storage/proc/orient_objs(tx, ty, mx, my)
	var/cx = tx
	var/cy = ty
	src.boxes.screen_loc = "[tx]:,[ty] to [mx],[my]"
	for(var/obj/A in src.contents)
		A.screen_loc = "[cx],[cy]"
		A.layer = 20
		cx++
		if (cx > mx)
			cx = tx
			cy--
	src.closer.screen_loc = "[mx+1],[my]"
	return

//This proc draws out the inventory and places the items on it. It uses the standard position.
/obj/storage/proc/standard_orient_objs(var/rows, var/cols)
	var/cx = 4
	var/cy = 2+rows
	src.boxes.screen_loc = "4:16,2:16 to [4+cols]:16,[2+rows]:16"

	for(var/obj/A in contents)
		A.screen_loc = "[cx]:16,[cy]:16"
		A.maptext = ""
		A.layer = 20
		cx++
		if (cx > (4+cols))
			cx = 4
			cy--
	src.closer.screen_loc = "[4+cols+1]:16,2:16"
	return

//This proc determins the size of the inventory to be displayed. Please touch it only if you know what you're doing.
/obj/storage/proc/orient2hud(mob/user as mob)

	var/adjusted_contents = contents.len

	var/row_num = 0
	var/col_count = min(7, max(contents.len+1, min_slots)) -1
	if (adjusted_contents > 7)
		if(max_slots > adjusted_contents) // Always make sure there is room to put another item, unless the bag has no more slots available.
			row_num = round((adjusted_contents) / 7) // 7 is the maximum allowed width.
		else
			row_num = round((adjusted_contents-1) / 7) // 7 is the maximum allowed width.
	src.standard_orient_objs(row_num, col_count)
	return

//This proc return 1 if the item can be picked up and 0 if it can't.
//Set the stop_messages to stop it from printing messages
/obj/storage/proc/can_be_inserted(obj/W as obj, stop_messages = 0)
	if(!istype(W)) return //Not an atom

	if(src.loc == W)
		return 0 //Means the storage item is the item itself.
	if(max_slots && contents.len >= max_slots) // If the storage object has a maximum limit on slots, and the contents are equal or greater than it, reject a new item.
		if(!stop_messages)
			usr << "<span class='notice'>[loc.name] is full, make some space.</span>"
		return 0 //Storage item is full

	if(hold_list.len)
		var/ok = 0
		for(var/A in hold_list)
			if(istype(W, text2path(A)) && whitelist)
				ok = 1
				break
		if(!ok)
			if(!stop_messages)
				usr << "<span class='notice'>[loc.name] cannot hold [W].</span>"
			return 0 // The item is restricted from the storage object.

	if (W.w_class > max_size)
		if(!stop_messages)
			usr << "<span class='notice'>[W] is too big for this [loc].</span>"
		return 0

	var/sum_w_class = total_volume()+((3**W.w_class)-(W.w_class**2))
	if(sum_w_class > max_volume)
		usr << "<span class='notice'>There is not enough room for [W], make some space.</span>"

	return 1

//This proc handles items being inserted. It does not perform any checks of whether an item can or can't be inserted. That's done by can_be_inserted()
//The stop_warning parameter will stop the insertion message from being displayed. It is intended for cases where you are inserting multiple items at once,
//such as when picking up all the items on a tile with one click.
/obj/storage/proc/insert(obj/W as obj, prevent_warning = 0)
	if(!istype(W)) return 0
	if(usr)
		usr.u_equip(W)
		usr.update_icons()	//update our overlays
	W.loc = src
	W.on_enter_storage(src)
	if(usr)
		if (usr.client && usr.s_active != src)
			usr.client.screen -= W
		W.dropped(usr)
		src.loc.add_fingerprint(usr)

		if(!prevent_warning)
			for(var/mob/M in viewers(usr, null))
				if (M == usr)
					usr << "<span class='notice'>You put \the [W] into [loc].</span>"
				else if (M in range(1)) //If someone is standing close enough, they can tell what it is...
					M.show_message("<span class='notice'>[usr] puts [W] into [loc].</span>")
				else if (W && W.w_class >= 3.0) //Otherwise they can only see large or normal items from a distance...
					M.show_message("<span class='notice'>[usr] puts [W] into [loc].</span>")

		src.orient2hud(usr)
		if(usr.s_active)
			usr.s_active.show_to(usr)
	update_icon()
	if(updates_icon && istype(loc, /obj))
		var/obj/L
		L.update_icon()
	return 1

/obj/storage/proc/total_volume()
	var/vol = 0
	for(var/obj/W in contents)
		vol += (3**W.w_class)-(W.w_class**2)
	return vol


//Call this proc to handle the removal of an item from the storage item. The item will be moved to the atom sent as new_target
/obj/storage/proc/remove(obj/W as obj, atom/new_location)
	if(!istype(W)) return 0

	for(var/mob/M in range(1, src.loc))
		if (M.s_active == src)
			if (M.client)
				M.client.screen -= W

	if(new_location)
		if(ismob(loc))
			W.dropped(usr)
		if(ismob(new_location))
			W.layer = 20
		else if(istype(new_location, /obj/storage))
			var/obj/storage/N = new_location
			if (!N.can_be_inserted(W))
				new_location = get_turf(src)
			else
				N.insert(W)
		else
			W.layer = initial(W.layer)
		W.loc = new_location
	else
		W.loc = get_turf(src)

	if(usr)
		src.orient2hud(usr)
		if(usr.s_active)
			usr.s_active.show_to(usr)
	if(W.maptext)
		W.maptext = ""
	W.on_exit_storage(src)
	update_icon()
	if(updates_icon && istype(loc, /obj))
		var/obj/L
		L.update_icon()
	return 1

//This proc is called when you want to place an item into the storage item.
/obj/storage/attackby(obj/item/W as obj, mob/user as mob)
	..()

	if(isrobot(user))
		user << "\blue You're a robot. No."
		return //Robots can't interact with storage items.

	if(!can_be_inserted(W))
		return

	W.add_fingerprint(user)
	return insert(W)

/obj/storage/emp_act(severity)
	for(var/obj/A in src)
		A.emp_act(severity)
	..()

/obj/storage/hear_talk(mob/M as mob, text, verb, datum/language/speaking)
	for (var/obj/A in src)
		A.hear_talk(M, text, verb, speaking)

/atom/proc/storage_depth(var/atom/A)
	var/depth = 0
	var/atom/cur_atom = A
	while (!istype(cur_atom, /area))
		if (istype(cur_atom.loc, /obj/storage))
			depth += 1
			cur_atom = cur_atom.loc.loc
		else if(loc)
			depth += 1
			cur_atom = cur_atom.loc
		else
			return -1

	return depth

/atom/proc/storage_depth_turf()
	var/depth = 0
	var/atom/cur_atom = src
	while (!istype(cur_atom, /turf))
		if (istype(cur_atom.loc, /obj/storage))
			depth += 1
			cur_atom = cur_atom.loc.loc
		else if(loc)
			depth += 1
			cur_atom = cur_atom.loc
		else
			return -1

	return depth