/*
 * The 'fancy' path is for objects like donut boxes that show how many items are in the storage item on the sprite itself
 * .. Sorry for the shitty path name, I couldnt think of a better one.
 *
 * WARNING: var/icon_type is used for both examine text and sprite name. Please look at the procs below and adjust your sprite names accordingly
 *		TODO: Cigarette boxes should be ported to this standard
 *
 * Contains:
 *		Donut Box
 *		Egg Box
 *		Candle Box
 *		Crayon Box
 *		Cigarette Box
 */

/obj/item/storage/fancy/
	icon = 'icons/obj/food.dmi'
	icon_state = "donutbox6"
	name = "donut box"
	var/icon_type = "donut"
	New()
		..()
		storage.updates_icon = 1

/obj/item/storage/fancy/update_icon(var/itemremoved = 0)
	var/total_contents = storage.contents.len - itemremoved
	src.icon_state = "[src.icon_type]box[total_contents]"
	return

/obj/item/storage/fancy/examine(mob/user)
	if(!..(user, 1))
		return

	if(storage.contents.len <= 0)
		user << "There are no [src.icon_type]s left in the box."
	else if(contents.len == 1)
		user << "There is one [src.icon_type] left in the box."
	else
		user << "There are [src.contents.len] [src.icon_type]s in the box."

	return

/*
 * Egg Box
 */

/obj/item/storage/fancy/egg_box
	icon = 'icons/obj/food.dmi'
	icon_state = "eggbox"
	icon_type = "egg"
	name = "egg box"
	New()
		..()
		storage.max_size = 1
		storage.max_volume = 24
		storage.hold_list = list("/obj/item/weapon/reagent_containers/food/snacks/egg")
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(storage)
		return

/*
 * Candle Box
 */

/obj/item/storage/fancy/candle_box
	name = "candle pack"
	desc = "A pack of red candles."
	icon = 'icons/obj/candle.dmi'
	icon_state = "candlebox5"
	icon_type = "candle"
	item_state = "candlebox5"
	throwforce = 2
	slot_flags = SLOT_BELT
	New()
		storage.max_size = 2
		storage.max_volume = 44
		storage.hold_list = list("/obj/item/weapon/flame/candle")
		new /obj/item/weapon/flame/candle(storage)
		new /obj/item/weapon/flame/candle(storage)
		new /obj/item/weapon/flame/candle(storage)
		new /obj/item/weapon/flame/candle(storage)
		new /obj/item/weapon/flame/candle(storage)
		return

/*
 * Crayon Box
 */

/obj/item/storage/fancy/crayons
	name = "box of crayons"
	desc = "A box of crayons for all your rune drawing needs."
	icon = 'icons/obj/crayons.dmi'
	icon_state = "crayonbox"
	icon_type = "crayon"
	w_class = 2.0
	New()
		storage.max_size = 1
		storage.max_volume = 12
		storage.hold_list = list("/obj/item/toy/crayon")
		new /obj/item/toy/crayon/red(storage)
		new /obj/item/toy/crayon/orange(storage)
		new /obj/item/toy/crayon/yellow(storage)
		new /obj/item/toy/crayon/green(storage)
		new /obj/item/toy/crayon/blue(storage)
		new /obj/item/toy/crayon/purple(storage)
		update_icon()


/obj/item/storage/fancy/crayons/update_icon()
	overlays = list() //resets list
	overlays += image('icons/obj/crayons.dmi',"crayonbox")
	for(var/obj/item/toy/crayon/crayon in storage.contents)
		overlays += image('icons/obj/crayons.dmi',crayon.colourName)

/obj/item/storage/fancy/crayons/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/toy/crayon))
		switch(W:colourName)
			if("mime")
				usr << "This crayon is too sad to be contained in this box."
				return
			if("rainbow")
				usr << "This crayon is too powerful to be contained in this box."
				return
	..()

////////////
//CIG PACK//
////////////
/obj/item/storage/fancy/cigarettes
	name = "NanoSmokens packet"
	desc = "The most popular brand of Space Cigarettes, sponsors of the Space Olympics."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cigpacket"
	item_state = "cigpacket"
	w_class = 1
	throwforce = 2
	slot_flags = SLOT_BELT
	var/cig_type = /obj/item/clothing/mask/cigarette
	icon_type = "cigarette"
	New()
		storage.max_size = 1
		storage.max_volume = 28
		storage.hold_list = list("/obj/item/clothing/mask/cigarette")
		flags |= NOREACT
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		new cig_type(storage)
		create_reagents(15 * 14)

/obj/item/storage/fancy/cigarettes/Destroy()
	qdel(reagents)
	..()


/obj/item/storage/fancy/cigarettes/update_icon()
	icon_state = "[initial(icon_state)][min(8, storage.contents.len)]"
	return

/obj/item/storage/fancy/cigarettes/dromedaryco
	name = "\improper DromedaryCo packet"
	desc = "A packet of six imported DromedaryCo cancer sticks. A label on the packaging reads, \"Wouldn't a slow death make a change?\""
	icon_state = "Dpacket"
	item_state = "Dpacket"

/obj/item/storage/fancy/cigarettes/lucky7
	name = "\improper Lucky Sevens packet"
	desc = "A packet of seven \"Lucky Sevens\" cigarettes. A label on the packaging reads \"Take a chance with Lucky Sevens\"."
	icon_state = "L7packet"
	item_state = "L7packet"
	cig_type = /obj/item/clothing/mask/cigarette/lucky7

/obj/item/storage/fancy/cigarettes/cigar
	name = "cigar case"
	desc = "A case for holding your cigars when you are not smoking them."
	icon_state = "cigarcase"
	item_state = "cigarcase"
	icon = 'icons/obj/cigarettes.dmi'
	slot_flags = SLOT_BELT
	cig_type = /obj/item/clothing/mask/cigarette/cigar
	icon_type = "cigar"
	New()
		..()
		storage.hold_list = list("/obj/item/clothing/mask/cigarette/cigar")

/*
 * Vial Box
 */

/obj/item/storage/fancy/vials
	icon = 'icons/obj/vialbox.dmi'
	icon_state = "vialbox6"
	icon_type = "vial"
	name = "vial storage box"
	New()
		..()
		storage.max_size = 1
		storage.max_volume = 12
		storage.hold_list = list("/obj/item/weapon/reagent_containers/glass/beaker/vial")
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)

/obj/item/storage/lockbox/vials
	name = "secure vial storage box"
	desc = "A locked box for keeping things away from children."
	icon = 'icons/obj/vialbox.dmi'
	icon_state = "vialbox0"
	item_state = "syringe_kit"
	req_access = list(access_virology)
	New()
		..()
		storage.updates_icon = 1
		storage.max_size = 1
		storage.max_volume = 12
		storage.hold_list = list("/obj/item/weapon/reagent_containers/glass/beaker/vial")
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(storage)
		update_icon()

/obj/item/storage/lockbox/vials/update_icon()
	src.icon_state = "vialbox[min(6, storage.contents.len)]"
	src.overlays.Cut()
	if (!broken)
		overlays += image(icon, src, "led[locked]")
		if(locked)
			overlays += image(icon, src, "cover")
	else
		overlays += image(icon, src, "ledb")
	return

/obj/item/storage/lockbox/vials/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	update_icon()
