/obj/item/storage/belt
	name = "belt"
	desc = "Can hold various things."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utilitybelt"
	item_state = "utility"
	slot_flags = SLOT_BELT
	attack_verb = list("whipped", "lashed", "disciplined")

/obj/item/storage/belt/New()
	..()
	storage.max_size = 3.0
	storage.max_slots = 7 // Maximum of 7 slots, which can each hold an average sized tool.
	storage.max_volume = 126 // This is set up to allow for a full (7 tools) toolbelt.

/obj/item/storage/belt/utility
	name = "tool-belt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Can hold various tools."
	icon_state = "utilitybelt"
	item_state = "utility"
	New()
		..()
		storage.hold_list = list(
		//"/obj/item/weapon/combitool",
		"/obj/item/weapon/crowbar",
		"/obj/item/weapon/screwdriver",
		"/obj/item/weapon/weldingtool",
		"/obj/item/weapon/wirecutters",
		"/obj/item/weapon/wrench",
		"/obj/item/device/multitool",
		"/obj/item/device/flashlight",
		"/obj/item/stack/cable_coil",
		"/obj/item/device/t_scanner",
		"/obj/item/device/analyzer",
		"/obj/item/taperoll/engineering",
		"/obj/item/device/robotanalyzer")


/obj/item/storage/belt/utility/full/New()
	..()
	new /obj/item/weapon/screwdriver(storage)
	new /obj/item/weapon/wrench(storage)
	new /obj/item/weapon/weldingtool(storage)
	new /obj/item/weapon/crowbar(storage)
	new /obj/item/weapon/wirecutters(storage)
	new /obj/item/stack/cable_coil(storage,30,pick("red","yellow","orange"))


/obj/item/storage/belt/utility/atmostech/New()
	..()
	new /obj/item/weapon/screwdriver(storage)
	new /obj/item/weapon/wrench(storage)
	new /obj/item/weapon/weldingtool(storage)
	new /obj/item/weapon/crowbar(storage)
	new /obj/item/weapon/wirecutters(storage)
	new /obj/item/device/t_scanner(storage)



/obj/item/storage/belt/medical
	name = "medical belt"
	desc = "Can hold various medical equipment."
	icon_state = "medicalbelt"
	item_state = "medical"
	New()
		..()
		storage.hold_list = list(
		"/obj/item/device/healthanalyzer",
		"/obj/item/weapon/dnainjector",
		"/obj/item/weapon/reagent_containers/dropper",
		"/obj/item/weapon/reagent_containers/glass/beaker",
		"/obj/item/weapon/reagent_containers/glass/bottle",
		"/obj/item/weapon/reagent_containers/pill",
		"/obj/item/weapon/reagent_containers/syringe",
		"/obj/item/weapon/reagent_containers/glass/dispenser",
		"/obj/item/weapon/flame/lighter/zippo",
		"/obj/item/weapon/storage/fancy/cigarettes",
		"/obj/item/weapon/storage/pill_bottle",
		"/obj/item/stack/medical",
		"/obj/item/device/flashlight/pen",
		"/obj/item/clothing/mask/surgical",
		"/obj/item/clothing/gloves/latex",
	        "/obj/item/weapon/reagent_containers/hypospray")


/obj/item/storage/belt/security
	name = "security belt"
	desc = "Can hold security gear like handcuffs and flashes."
	icon_state = "securitybelt"
	item_state = "security"//Could likely use a better one.
	New()
		..()
		storage.hold_list = list(
		"/obj/item/weapon/grenade",
		"/obj/item/weapon/reagent_containers/spray/pepper",
		"/obj/item/weapon/handcuffs",
		"/obj/item/device/flash",
		"/obj/item/clothing/glasses",
		"/obj/item/ammo_casing/shotgun",
		"/obj/item/ammo_magazine",
		"/obj/item/weapon/reagent_containers/food/snacks/donut/normal",
		"/obj/item/weapon/reagent_containers/food/snacks/donut/jelly",
		"/obj/item/weapon/melee/baton",
		"/obj/item/weapon/gun/energy/taser",
		"/obj/item/weapon/flame/lighter/zippo",
		"/obj/item/weapon/cigpacket",
		"/obj/item/clothing/glasses/hud/security",
		"/obj/item/device/flashlight",
		"/obj/item/device/pda",
		"/obj/item/device/radio/headset",
		"/obj/item/weapon/melee",
		"/obj/item/taperoll/police")

/obj/item/storage/belt/soulstone
	name = "soul stone belt"
	desc = "Designed for ease of access to the shards during a fight, as to not let a single enemy spirit slip away"
	icon_state = "soulstonebelt"
	item_state = "soulstonebelt"
	New()
		..()
		storage.max_slots = 6 // Less slots for some reason.
		storage.min_slots = 6
		storage.hold_list = list("/obj/item/device/soulstone")

/obj/item/storage/belt/soulstone/full
	New()
		..()
		new /obj/item/device/soulstone(storage)
		new /obj/item/device/soulstone(storage)
		new /obj/item/device/soulstone(storage)
		new /obj/item/device/soulstone(storage)
		new /obj/item/device/soulstone(storage)
		new /obj/item/device/soulstone(storage)

/obj/item/storage/belt/champion
	name = "championship belt"
	desc = "Proves to the world that you are the strongest!"
	icon_state = "championbelt"
	item_state = "champion"
	New()
		..()
		storage.max_size = 2
		storage.max_volume = 8
		storage.max_slots = 1
		storage.min_slots = 1
		storage.hold_list = list("/obj/item/clothing/mask/luchador")

/obj/item/storage/belt/security/tactical
	name = "combat belt"
	desc = "Can hold security gear like handcuffs and flashes, with more pouches for more storage."
	icon_state = "swatbelt"
	item_state = "swatbelt"
	New()
		storage.max_slots = 14 // Two rows for equipment. OP as fuck.
		storage.max_volume = 252 // A massive belt.
