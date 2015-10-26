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

/obj/item/storage/bag/
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
		storage.max_size = 2
		storage.max_volume = 80
		storage.hold_list = list("/obj/item/weapon/disk/nuclear")
		storage.whitelist = 0


/obj/item/storage/bag/trash/update_icon()
	if(storage.contents.len == 0)
		icon_state = "trashbag0"
	else if(storage.contents.len < 12)
		icon_state = "trashbag1"
	else if(storage.contents.len < 21)
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
		storage.max_size = 2
		storage.max_volume = 80
		storage.hold_list = list("/obj/item/weapon/disk/nuclear")
		storage.whitelist = 0

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
		storage.max_size = 3
		storage.max_volume = 80
		storage.hold_list = list("/obj/item/weapon/ore")


// -----------------------------
//          Plant bag
// -----------------------------

/obj/item/storage/bag/plants
	name = "plant bag"
	icon = 'icons/obj/hydroponics.dmi'
	icon_state = "plantbag"
	w_class = 2
	New()
		..()
		storage.max_size = 2
		storage.max_volume = 26
		storage.hold_list = list("/obj/item/weapon/reagent_containers/food/snacks/grown","/obj/item/seeds","/obj/item/weapon/grown")


// -----------------------------
//        Sheet Snatcher
// -----------------------------
// Because it stacks stacks, this doesn't operate normally.
// However, making it a storage/bag allows us to reuse existing code in some places. -Sayu

/obj/item/storage/bag/sheetsnatcher
	name = "sheet snatcher"
	icon = 'icons/obj/mining.dmi'
	icon_state = "sheetsnatcher"
	desc = "A patented Nanotrasen storage system designed for any kind of mineral sheet."

	var/capacity = 300; //the number of sheets it can carry.
	w_class = 3

	New()
		..()


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
	w_class = 2
	New()
		..()
		storage.max_size = 2
		storage.max_volume = 26
		storage.hold_list = list("/obj/item/weapon/coin","/obj/item/weapon/spacecash")

