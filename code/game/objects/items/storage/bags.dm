/*
 *	These absorb the functionality of the plant bag, ore satchel, etc.
 *	They use the use_to_pickup, quick_gather, and quick_empty functions
 *	that were already defined in weapon/storage, but which had been
 *	re-implemented in other classes.
 *
 *	Contains:
 *		Trash Bag
 *		Mining Satchel
 *		Plant Bag
 *		Sheet Snatcher
 *		Cash Bag
 *
 *	-Sayu
 */

//  Generic non-item
/obj/item/storage/bag
	slot_flags = SLOT_BELT

/obj/item/storage/bag/New()
	..()
	storage.hold_list = list("/obj/item/weapon/disk/nuclear")
	storage.whitelist = 0 // Blacklists the nuclear disc. I don't know why.
// -----------------------------
//          Trash bag
// -----------------------------
/obj/item/storage/bag/trash
	name = "trash bag"
	desc = "It's the heavy-duty black polymer kind. Time to take out the trash!"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "trashbag0"
	item_state = "trashbag"
	w_class = 4
	New()
		..()
		storage.updates_icon = 1
		storage.max_slots = 35 // As many as 5 whole rows of trash.
		storage.max_size = 2 // Small items only. Can't be used to store bombs.
		storage.max_volume = 80 // Can store like, 35 pieces of trash.

/obj/item/storage/bag/trash/update_icon() // Changes the sprite of the bag depending on how full it is, based on volume.
	if(storage.total_volume() == 0)
		icon_state = "trashbag0"
	else if(storage.total_volume() < 40)
		icon_state = "trashbag1"
	else if(storage.total_volume() < 80)
		icon_state = "trashbag2"
	else icon_state = "trashbag3"


// -----------------------------
//        Plastic Bag
// -----------------------------

/obj/item/storage/bag/plasticbag
	name = "plastic bag"
	desc = "It's a very flimsy, very noisy alternative to a bag."
	icon = 'icons/obj/trash.dmi'
	icon_state = "plasticbag"
	item_state = "plasticbag"

	w_class = 4
	New()
		..()
		storage.max_slots = 21 // Three rows of junk. Even worse than a backpack.
		storage.max_size = 2 // Small items only. Pretty pathetic.
		storage.max_volume = 80

// -----------------------------
//        Mining Satchel
// -----------------------------

/obj/item/storage/bag/ore
	name = "mining satchel"
	desc = "This little bugger can be used to store and transport ores."
	icon = 'icons/obj/mining.dmi'
	icon_state = "satchel"
	slot_flags = SLOT_BELT | SLOT_POCKET
	w_class = 3
	New()
		..()
		storage.max_size = 2
		storage.max_slots = 35 // Maximum of 5 rows, allowing for a potential of 35 ore.
		storage.max_volume = 80 // Can store like, 16 pieces of ore. It's intended primarily for picking ore up, not hauling it.
		storage.hold_list = list("/obj/item/weapon/ore")
		storage.whitelist = 1


// -----------------------------
//          Plant bag
// -----------------------------

/obj/item/storage/bag/plants
	name = "plant bag"
	icon = 'icons/obj/hydroponics.dmi'
	icon_state = "plantbag"
	w_class = 3
	New()
		..()
		storage.max_size = 2
		storage.max_slots = 35
		storage.max_volume = 80
		storage.hold_list = list("/obj/item/weapon/reagent_containers/food/snacks/grown","/obj/item/seeds","/obj/item/weapon/grown")
		storage.whitelist = 1


// -----------------------------
//        Sheet Snatcher
// -----------------------------

/obj/item/storage/bag/sheetsnatcher
	name = "sheet snatcher"
	icon = 'icons/obj/mining.dmi'
	icon_state = "sheetsnatcher"
	desc = "A patented Nanotrasen storage system designed for any kind of mineral sheet."

	var/capacity = 300; //the number of sheets it can carry.
	w_class = 3

	New()
		..()
		storage.max_size = 2
		storage.max_slots = 14
		storage.max_volume = 80
		storage.hold_list = list("/obj/item/stack/sheet")
		storage.whitelist = 1


/obj/item/storage/bag/sheetsnatcher/borg
	name = "sheet snatcher 9000"
	desc = ""
	capacity = 500//Borgs get more because >specialization

// -----------------------------
//           Cash Bag
// -----------------------------

/obj/item/storage/bag/cash
	name = "cash bag"
	icon = 'icons/obj/storage.dmi'
	icon_state = "cashbag"
	desc = "A bag for carrying lots of cash. It's got a big dollar sign printed on the front."
	w_class = 3
	New()
		..()
		storage.max_size = 2
		storage.max_slots = 21
		storage.whitelist = 1
		storage.max_volume = 80
		storage.hold_list = list("/obj/item/weapon/coin","/obj/item/weapon/spacecash")

