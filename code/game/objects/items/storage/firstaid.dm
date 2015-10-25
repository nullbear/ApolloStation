/* First aid storage
 * Contains:
 *		First Aid Kits
 * 		Pill Bottles
 */

/*
 * First Aid Kits
 */
/obj/item/storage/firstaid
	name = "first-aid kit"
	desc = "It's an emergency medical kit for those serious boo-boos."
	icon_state = "firstaid"
	throw_speed = 2
	throw_range = 8
	var/empty = 0

/obj/item/storage/firstaid/New()
	..()
	storage.max_size = 2.0
	storage.max_volume = 26


/obj/item/storage/firstaid/fire
	name = "fire first-aid kit"
	desc = "It's an emergency medical kit for when the toxins lab <i>-spontaneously-</i> burns down."
	icon_state = "ointment"
	item_state = "firstaid-ointment"

	New()
		..()
		if (empty) return

		icon_state = pick("ointment","firefirstaid")

		new /obj/item/device/healthanalyzer(storage)
		new /obj/item/weapon/reagent_containers/hypospray/autoinjector(storage)
		new /obj/item/stack/medical/ointment(storage)
		new /obj/item/stack/medical/ointment(storage)
		new /obj/item/weapon/reagent_containers/pill/kelotane(storage)
		new /obj/item/weapon/reagent_containers/pill/kelotane(storage)
		new /obj/item/weapon/reagent_containers/pill/kelotane(storage)
		return


/obj/item/storage/firstaid/regular
	icon_state = "firstaid"

	New()
		..()
		if (empty) return
		new /obj/item/stack/medical/bruise_pack(storage)
		new /obj/item/stack/medical/bruise_pack(storage)
		new /obj/item/stack/medical/bruise_pack(storage)
		new /obj/item/stack/medical/ointment(storage)
		new /obj/item/stack/medical/ointment(storage)
		new /obj/item/device/healthanalyzer(storage)
		new /obj/item/weapon/reagent_containers/hypospray/autoinjector(storage)
		return

/obj/item/storage/firstaid/toxin
	name = "toxin first aid"
	desc = "Used to treat when you have a high amoutn of toxins in your body."
	icon_state = "antitoxin"
	item_state = "firstaid-toxin"

	New()
		..()
		if (empty) return

		icon_state = pick("antitoxin","antitoxfirstaid","antitoxfirstaid2","antitoxfirstaid3")

		new /obj/item/weapon/reagent_containers/syringe/antitoxin(storage)
		new /obj/item/weapon/reagent_containers/syringe/antitoxin(storage)
		new /obj/item/weapon/reagent_containers/syringe/antitoxin(storage)
		new /obj/item/weapon/reagent_containers/pill/antitox(storage)
		new /obj/item/weapon/reagent_containers/pill/antitox(storage)
		new /obj/item/weapon/reagent_containers/pill/antitox(storage)
		new /obj/item/device/healthanalyzer( src )
		return

/obj/item/storage/firstaid/o2
	name = "oxygen deprivation first aid"
	desc = "A box full of oxygen goodies."
	icon_state = "o2"
	item_state = "firstaid-o2"

	New()
		..()
		if (empty) return
		new /obj/item/weapon/reagent_containers/pill/dexalin(storage)
		new /obj/item/weapon/reagent_containers/pill/dexalin(storage)
		new /obj/item/weapon/reagent_containers/pill/dexalin(storage)
		new /obj/item/weapon/reagent_containers/pill/dexalin(storage)
		new /obj/item/weapon/reagent_containers/hypospray/autoinjector(storage)
		new /obj/item/weapon/reagent_containers/syringe/inaprovaline(storage)
		new /obj/item/device/healthanalyzer(storage)
		return

/obj/item/storage/firstaid/adv
	name = "advanced first-aid kit"
	desc = "Contains advanced medical treatments."
	icon_state = "advfirstaid"
	item_state = "firstaid-advanced"

/obj/item/storage/firstaid/adv/New()
	..()
	if (empty) return
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector(storage)
	new /obj/item/stack/medical/advanced/bruise_pack(storage)
	new /obj/item/stack/medical/advanced/bruise_pack(storage)
	new /obj/item/stack/medical/advanced/bruise_pack(storage)
	new /obj/item/stack/medical/advanced/ointment(storage)
	new /obj/item/stack/medical/advanced/ointment(storage)
	new /obj/item/stack/medical/splint(storage)
	return
/*
 * Pill Bottles
 */
/obj/item/storage/pill_bottle
	name = "pill bottle"
	desc = "It's an airtight container for storing medication."
	icon_state = "pill_canister"
	icon = 'icons/obj/chemical.dmi'
	item_state = "contsolid"
	w_class = 2.0

/obj/item/storage/pill_bottle/New()
	..()
	storage.hold_list = list("/obj/item/weapon/reagent_containers/pill","/obj/item/weapon/dice","/obj/item/weapon/paper")
	storage.use_sound = null
	storage.max_size = 1.0
	storage.max_volume = 14

/obj/item/storage/pill_bottle/kelotane
	name = "bottle of kelotane pills"
	desc = "Contains pills used to treat burns."

	New()
		..()
		new /obj/item/weapon/reagent_containers/pill/kelotane(storage)
		new /obj/item/weapon/reagent_containers/pill/kelotane(storage)
		new /obj/item/weapon/reagent_containers/pill/kelotane(storage)
		new /obj/item/weapon/reagent_containers/pill/kelotane(storage)
		new /obj/item/weapon/reagent_containers/pill/kelotane(storage)
		new /obj/item/weapon/reagent_containers/pill/kelotane(storage)
		new /obj/item/weapon/reagent_containers/pill/kelotane(storage)

/obj/item/storage/pill_bottle/antitox
	name = "bottle of Dylovene pills"
	desc = "Contains pills used to counter toxins."

	New()
		..()
		new /obj/item/weapon/reagent_containers/pill/antitox(storage)
		new /obj/item/weapon/reagent_containers/pill/antitox(storage)
		new /obj/item/weapon/reagent_containers/pill/antitox(storage)
		new /obj/item/weapon/reagent_containers/pill/antitox(storage)
		new /obj/item/weapon/reagent_containers/pill/antitox(storage)
		new /obj/item/weapon/reagent_containers/pill/antitox(storage)
		new /obj/item/weapon/reagent_containers/pill/antitox(storage)

/obj/item/storage/pill_bottle/inaprovaline
	name = "bottle of Inaprovaline pills"
	desc = "Contains pills used to stabilize patients."

	New()
		..()
		new /obj/item/weapon/reagent_containers/pill/inaprovaline(storage)
		new /obj/item/weapon/reagent_containers/pill/inaprovaline(storage)
		new /obj/item/weapon/reagent_containers/pill/inaprovaline(storage)
		new /obj/item/weapon/reagent_containers/pill/inaprovaline(storage)
		new /obj/item/weapon/reagent_containers/pill/inaprovaline(storage)
		new /obj/item/weapon/reagent_containers/pill/inaprovaline(storage)
		new /obj/item/weapon/reagent_containers/pill/inaprovaline(storage)

/obj/item/storage/pill_bottle/tramadol
	name = "bottle of Tramadol Pills"
	desc = "Contains pills used to relieve pain."

	New()
		..()
		new /obj/item/weapon/reagent_containers/pill/tramadol(storage)
		new /obj/item/weapon/reagent_containers/pill/tramadol(storage)
		new /obj/item/weapon/reagent_containers/pill/tramadol(storage)
		new /obj/item/weapon/reagent_containers/pill/tramadol(storage)
		new /obj/item/weapon/reagent_containers/pill/tramadol(storage)
		new /obj/item/weapon/reagent_containers/pill/tramadol(storage)
		new /obj/item/weapon/reagent_containers/pill/tramadol(storage)
