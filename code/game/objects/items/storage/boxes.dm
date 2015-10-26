/*
 *	Everything derived from the common cardboard box.
 *	Basically everything except the original is a kit (starts full).
 *
 *	Contains:
 *		Empty box, starter boxes (survival/engineer),
 *		Latex glove and sterile mask boxes,
 *		Syringe, beaker, dna injector boxes,
 *		Blanks, flashbangs, and EMP grenade boxes,
 *		Tracking and chemical implant boxes,
 *		Prescription glasses and drinking glass boxes,
 *		Condiment bottle and silly cup boxes,
 *		Donkpocket and monkeycube boxes,
 *		ID and security PDA cart boxes,
 *		Handcuff, mousetrap, and pillbottle boxes,
 *		Snap-pops and matchboxes,
 *		Replacement light boxes.
 *		Box of bodybags
 *
 *		For syndicate call-ins see uplink_kits.dm
 */

/obj/item/storage/box
	name = "box"
	desc = "It's just an ordinary box."
	icon_state = "box"
	item_state = "syringe_kit"
	//foldable = /obj/item/stack/sheet/cardboard

/obj/item/storage/box/New()
	storage.max_slots = 14
	storage.max_size = 2.0
	storage.max_volume = 26

/obj/item/storage/box/attack_self(mob/user as mob)
	if(storage.contents.len)
		return
	else
		for(var/mob/M in range(1))
			if (M.s_active == storage)
				storage.close(M)
		user << "<span class='notice'>You fold [src] flat.</span>"
		storage = null
		qdel(storage)
		new /obj/item/stack/sheet/cardboard(get_turf(src))
		qdel(src)
		return

/obj/item/storage/box/survival/
	New()
		..()
		sleep(1)
		new /obj/item/clothing/mask/breath(storage)
		new /obj/item/weapon/tank/emergency_oxygen(storage)
		return

/obj/item/storage/box/engineer/
	New()
		..()
		sleep(1)
		new /obj/item/clothing/mask/breath(storage)
		new /obj/item/weapon/tank/emergency_oxygen/engi(storage)
		return

/obj/item/storage/box/gloves
	name = "box of latex gloves"
	desc = "Contains white gloves."
	icon_state = "latex"


	New()
		..()
		sleep(1)
		new /obj/item/clothing/gloves/latex(storage)
		new /obj/item/clothing/gloves/latex(storage)
		new /obj/item/clothing/gloves/latex(storage)
		new /obj/item/clothing/gloves/latex(storage)
		new /obj/item/clothing/gloves/latex(storage)
		new /obj/item/clothing/gloves/latex(storage)
		new /obj/item/clothing/gloves/latex(storage)
		return


/obj/item/storage/box/masks
	name = "box of sterile masks"
	desc = "This box contains masks of sterility."
	icon_state = "sterile"

	New()
		..()
		sleep(1)
		new /obj/item/clothing/mask/surgical(storage)
		new /obj/item/clothing/mask/surgical(storage)
		new /obj/item/clothing/mask/surgical(storage)
		new /obj/item/clothing/mask/surgical(storage)
		new /obj/item/clothing/mask/surgical(storage)
		new /obj/item/clothing/mask/surgical(storage)
		new /obj/item/clothing/mask/surgical(storage)
		return


/obj/item/storage/box/syringes
	name = "box of syringes"
	desc = "A box full of syringes."
	desc = "A biohazard alert warning is printed on the box"
	icon_state = "syringe"


	New()
		..()
		new /obj/item/weapon/reagent_containers/syringe(storage)
		new /obj/item/weapon/reagent_containers/syringe(storage)
		new /obj/item/weapon/reagent_containers/syringe(storage)
		new /obj/item/weapon/reagent_containers/syringe(storage)
		new /obj/item/weapon/reagent_containers/syringe(storage)
		return

/obj/item/storage/box/beakers
	name = "box of beakers"
	icon_state = "beaker"

	New()
		..()
		new /obj/item/weapon/reagent_containers/glass/beaker(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker(storage)
		new /obj/item/weapon/reagent_containers/glass/beaker(storage)
		return

/obj/item/storage/box/injectors
	name = "box of DNA injectors"
	desc = "This box contains injectors it seems."

	New()
		..()
		new /obj/item/weapon/dnainjector/h2m(storage)
		new /obj/item/weapon/dnainjector/h2m(storage)
		new /obj/item/weapon/dnainjector/h2m(storage)
		new /obj/item/weapon/dnainjector/h2m(storage)
		new /obj/item/weapon/dnainjector/h2m(storage)


/obj/item/storage/box/blanks
	name = "box of blank shells"
	desc = "It has a picture of a gun and several warning symbols on the front."

	New()
		..()
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		new /obj/item/ammo_casing/shotgun/blank(storage)
		return

/obj/item/storage/box/beanbags
	name = "box of beanbag shells"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

	New()
		..()
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		new /obj/item/ammo_casing/shotgun/beanbag(storage)
		return

/obj/item/storage/box/shotgunammo
	name = "box of shotgun shells"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

	New()
		..()
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		new /obj/item/ammo_casing/shotgun(storage)
		return

/obj/item/storage/box/flashbangs
	name = "box of flashbangs (WARNING)"
	desc = "<B>WARNING: These devices are extremely dangerous and can cause blindness or deafness in repeated use.</B>"
	icon_state = "flashbang"

	New()
		..()
		new /obj/item/weapon/grenade/flashbang(storage)
		new /obj/item/weapon/grenade/flashbang(storage)
		new /obj/item/weapon/grenade/flashbang(storage)
		new /obj/item/weapon/grenade/flashbang(storage)
		new /obj/item/weapon/grenade/flashbang(storage)
		return

/obj/item/storage/box/emps
	name = "box of emp grenades"
	desc = "A box with 4 emp grenades."
	icon_state = "flashbang"

	New()
		..()
		new /obj/item/weapon/grenade/empgrenade(storage)
		new /obj/item/weapon/grenade/empgrenade(storage)
		new /obj/item/weapon/grenade/empgrenade(storage)
		new /obj/item/weapon/grenade/empgrenade(storage)
		new /obj/item/weapon/grenade/empgrenade(storage)
		return

/obj/item/storage/box/trackimp
	name = "boxed tracking implant kit"
	desc = "Box of stuff used to track criminals."
	icon_state = "implant"

	New()
		..()
		new /obj/item/weapon/implanter(storage)
		new /obj/item/weapon/locator(storage)
		new /obj/item/weapon/implantpad(storage)
		new /obj/item/weapon/implantcase/tracking(storage)
		new /obj/item/weapon/implantcase/tracking(storage)
		return

/obj/item/storage/box/chemimp
	name = "boxed chemical implant kit"
	desc = "Box of stuff used to implant chemicals."
	icon_state = "implant"

	New()
		..()
		new /obj/item/weapon/implanter(storage)
		new /obj/item/weapon/implantpad(storage)
		new /obj/item/weapon/implantcase/chem(storage)
		new /obj/item/weapon/implantcase/chem(storage)
		new /obj/item/weapon/implantcase/chem(storage)
		return



/obj/item/storage/box/rxglasses
	name = "box of prescription glasses"
	desc = "This box contains nerd glasses."
	icon_state = "glasses"

	New()
		..()
		new /obj/item/clothing/glasses/regular(storage)
		new /obj/item/clothing/glasses/regular(storage)
		new /obj/item/clothing/glasses/regular(storage)
		new /obj/item/clothing/glasses/regular(storage)
		new /obj/item/clothing/glasses/regular(storage)
		new /obj/item/clothing/glasses/regular(storage)
		new /obj/item/clothing/glasses/regular(storage)
		return

/obj/item/storage/box/drinkingglasses
	name = "box of drinking glasses"
	desc = "It has a picture of drinking glasses on it."

	New()
		..()
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(storage)
		return

/obj/item/storage/box/cdeathalarm_kit
	name = "death alarm kit"
	desc = "Box of stuff used to implant death alarms."
	icon_state = "implant"
	item_state = "syringe_kit"

	New()
		..()
		new /obj/item/weapon/implanter(storage)
		new /obj/item/weapon/implantcase/death_alarm(storage)
		new /obj/item/weapon/implantcase/death_alarm(storage)
		new /obj/item/weapon/implantcase/death_alarm(storage)
		new /obj/item/weapon/implantcase/death_alarm(storage)
		new /obj/item/weapon/implantcase/death_alarm(storage)
		new /obj/item/weapon/implantcase/death_alarm(storage)
		return

/obj/item/storage/box/condimentbottles
	name = "box of condiment bottles"
	desc = "It has a large ketchup smear on it."

	New()
		..()
		new /obj/item/weapon/reagent_containers/food/condiment(storage)
		new /obj/item/weapon/reagent_containers/food/condiment(storage)
		new /obj/item/weapon/reagent_containers/food/condiment(storage)
		new /obj/item/weapon/reagent_containers/food/condiment(storage)
		new /obj/item/weapon/reagent_containers/food/condiment(storage)
		return

/obj/item/storage/box/cups
	name = "box of paper cups"
	desc = "It has pictures of paper cups on the front."
	New()
		..()
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		new /obj/item/weapon/reagent_containers/food/drinks/sillycup(storage)
		return

/obj/item/storage/box/donkpockets
	name = "box of donk-pockets"
	desc = "<B>Instructions:</B> <I>Heat in microwave. Product will cool if not eaten within seven minutes.</I>"
	icon_state = "donk_kit"

	New()
		..()
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/donkpocket(storage)
		return

/obj/item/storage/box/monkeycubes
	name = "monkey cube box"
	desc = "Drymate brand monkey cubes. Just add water!"
	icon = 'icons/obj/food.dmi'
	icon_state = "monkeycubebox"
	New()
		..()
		storage.hold_list = list("/obj/item/weapon/reagent_containers/food/snacks/monkeycube")
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(storage)
		return

/obj/item/storage/box/farwacubes
	name = "farwa cube box"
	desc = "Drymate brand farwa cubes, shipped from Ahdomai. Just add water!"
	icon = 'icons/obj/food.dmi'
	icon_state = "monkeycubebox"
	New()
		..()
		storage.hold_list = list("/obj/item/weapon/reagent_containers/food/snacks/monkeycube")
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube(storage)
		return


/obj/item/storage/box/stokcubes
	name = "stok cube box"
	desc = "Drymate brand stok cubes, shipped from Moghes. Just add water!"
	icon = 'icons/obj/food.dmi'
	icon_state = "monkeycubebox"
	New()
		..()
		storage.hold_list = list("/obj/item/weapon/reagent_containers/food/snacks/monkeycube")
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube(storage)
		return


/obj/item/storage/box/neaeracubes
	name = "neaera cube box"
	desc = "Drymate brand neaera cubes, shipped from Jargon 4. Just add water!"
	icon = 'icons/obj/food.dmi'
	icon_state = "monkeycubebox"
	New()
		..()
		storage.hold_list = list("/obj/item/weapon/reagent_containers/food/snacks/monkeycube")
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube(storage)
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube(storage)
		return


/obj/item/storage/box/ids
	name = "box of spare IDs"
	desc = "Has so many empty IDs."
	icon_state = "id"

	New()
		..()
		new /obj/item/weapon/card/id(storage)
		new /obj/item/weapon/card/id(storage)
		new /obj/item/weapon/card/id(storage)
		new /obj/item/weapon/card/id(storage)
		new /obj/item/weapon/card/id(storage)
		new /obj/item/weapon/card/id(storage)
		new /obj/item/weapon/card/id(storage)
		return



/obj/item/storage/box/seccarts
	name = "box of spare R.O.B.U.S.T. Cartridges"
	desc = "A box full of R.O.B.U.S.T. Cartridges, used by Security."
	icon_state = "pda"

	New()
		..()
		new /obj/item/weapon/cartridge/security(storage)
		new /obj/item/weapon/cartridge/security(storage)
		new /obj/item/weapon/cartridge/security(storage)
		new /obj/item/weapon/cartridge/security(storage)
		new /obj/item/weapon/cartridge/security(storage)
		new /obj/item/weapon/cartridge/security(storage)
		new /obj/item/weapon/cartridge/security(storage)
		return

/obj/item/storage/box/handcuffs
	name = "box of spare handcuffs"
	desc = "A box full of handcuffs."
	icon_state = "handcuff"

	New()
		..()
		new /obj/item/weapon/handcuffs(storage)
		new /obj/item/weapon/handcuffs(storage)
		new /obj/item/weapon/handcuffs(storage)
		new /obj/item/weapon/handcuffs(storage)
		new /obj/item/weapon/handcuffs(storage)
		return

/obj/item/storage/box/mousetraps
	name = "box of Pest-B-Gon mousetraps"
	desc = "<B><FONT color='red'>WARNING:</FONT></B> <I>Keep out of reach of man-children</I>."
	icon_state = "mousetraps"

	New()
		..()
		new /obj/item/device/assembly/mousetrap(storage)
		new /obj/item/device/assembly/mousetrap(storage)
		new /obj/item/device/assembly/mousetrap(storage)
		new /obj/item/device/assembly/mousetrap(storage)
		new /obj/item/device/assembly/mousetrap(storage)
		return

/obj/item/storage/box/pillbottles
	name = "box of pill bottles"
	desc = "It has pictures of pill bottles on its front."

	New()
		..()
		new /obj/item/storage/pill_bottle(storage)
		new /obj/item/storage/pill_bottle(storage)
		new /obj/item/storage/pill_bottle(storage)
		new /obj/item/storage/pill_bottle(storage)
		new /obj/item/storage/pill_bottle(storage)
		return

/obj/item/storage/box/snappops
	name = "snap pop box"
	desc = "Ten wrappers of fun for all ages! Ages 10 and up. Not suitable for children."
	icon = 'icons/obj/toy.dmi'
	icon_state = "spbox"
	New()
		..()
		storage.hold_list = list("/obj/item/toy/snappop")
		new /obj/item/toy/snappop(storage)
		new /obj/item/toy/snappop(storage)
		new /obj/item/toy/snappop(storage)
		new /obj/item/toy/snappop(storage)
		new /obj/item/toy/snappop(storage)
		new /obj/item/toy/snappop(storage)
		new /obj/item/toy/snappop(storage)
		new /obj/item/toy/snappop(storage)
		new /obj/item/toy/snappop(storage)
		new /obj/item/toy/snappop(storage)
		return


/obj/item/storage/box/matches
	name = "matchbox"
	desc = "A small box of 'Space-Proof' premium matches."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "matchbox"
	item_state = "zippo"
	w_class = 2.0
	slot_flags = SLOT_BELT
	New()
		..()
		storage.hold_list = list("/obj/item/weapon/flame/match")
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		new /obj/item/weapon/flame/match(storage)
		return

	attackby(obj/item/weapon/flame/match/W as obj, mob/user as mob)
		if(istype(W) && !W.lit && !W.burnt)
			W.lit = 1
			W.damtype = "burn"
			W.icon_state = "match_lit"
			processing_objects.Add(W)
		W.update_icon()
		return

	attack_self(mob/user as mob)
		return

/obj/item/storage/box/autoinjectors
	name = "box of injectors"
	desc = "Contains autoinjectors."
	icon_state = "syringe"
	New()
		..()
		new /obj/item/weapon/reagent_containers/hypospray/autoinjector(storage)
		new /obj/item/weapon/reagent_containers/hypospray/autoinjector(storage)
		new /obj/item/weapon/reagent_containers/hypospray/autoinjector(storage)
		new /obj/item/weapon/reagent_containers/hypospray/autoinjector(storage)
		new /obj/item/weapon/reagent_containers/hypospray/autoinjector(storage)
		return

/obj/item/storage/box/lights
	name = "box of replacement bulbs"
	icon = 'icons/obj/storage.dmi'
	icon_state = "light"
	desc = "This box is shaped on the inside so that only light tubes and bulbs fit."
	item_state = "syringe_kit"
	w_class = 3.0
	New()
		storage.max_size = 2.0
		storage.max_slots = 28
		storage.max_volume = 80
		storage.hold_list = list("/obj/item/weapon/light/tube", "/obj/item/weapon/light/bulb")

/obj/item/storage/box/lights/bulbs/New()
	..()
	storage.max_volume = 26
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	return

/obj/item/storage/box/lights/tubes
	name = "box of replacement tubes"
	icon_state = "lighttube"

/obj/item/storage/box/lights/tubes/New()
	..()
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	return

/obj/item/storage/box/lights/mixed
	name = "box of replacement lights"
	icon_state = "lightmixed"

/obj/item/storage/box/lights/mixed/New()
	..()
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/tube(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	new /obj/item/weapon/light/bulb(storage)
	return

/obj/item/storage/box/bodybags
	name = "body bags"
	desc = "This box contains body bags."
	icon_state = "bodybags"
	New()
		..()
		new /obj/item/bodybag(storage)
		new /obj/item/bodybag(storage)
		new /obj/item/bodybag(storage)
		new /obj/item/bodybag(storage)
		new /obj/item/bodybag(storage)
		return