/obj/item/storage/box/syndicate/
	New()
		..()
		switch (pickweight(list("bloodyspai" = 1, "stealth" = 1, "screwed" = 1, "guns" = 1, "murder" = 1, "freedom" = 1, "hacker" = 1, "lordsingulo" = 1, "smoothoperator" = 1)))
			if("bloodyspai")
				new /obj/item/clothing/under/chameleon(src)
				new /obj/item/clothing/mask/gas/voice(src)
				new /obj/item/weapon/card/id/syndicate(src)
				new /obj/item/clothing/shoes/syndigaloshes(src)
				return

			if("stealth")
				new /obj/item/weapon/gun/energy/crossbow(src)
				new /obj/item/weapon/pen/paralysis(src)
				new /obj/item/device/chameleon(src)
				return

			if("screwed")
				new /obj/effect/spawner/newbomb/timer/syndicate(src)
				new /obj/effect/spawner/newbomb/timer/syndicate(src)
				new /obj/item/device/powersink(src)
				new /obj/item/clothing/suit/space/syndicate(src)
				new /obj/item/clothing/head/helmet/space/syndicate(src)
				new /obj/item/clothing/mask/gas/syndicate(src)
				new /obj/item/weapon/tank/emergency_oxygen/double(src)
				return

			if("guns")
				new /obj/item/weapon/gun/projectile(src)
				new /obj/item/ammo_magazine/a357(src)
				new /obj/item/weapon/card/emag(src)
				new /obj/item/weapon/plastique(src)
				return

			if("murder")
				new /obj/item/weapon/melee/energy/sword(src)
				new /obj/item/clothing/glasses/thermal/syndi(src)
				new /obj/item/weapon/card/emag(src)
				new /obj/item/clothing/shoes/syndigaloshes(src)
				return

			if("freedom")
				var/obj/item/weapon/implanter/O = new /obj/item/weapon/implanter(src)
				O.imp = new /obj/item/weapon/implant/freedom(O)
				var/obj/item/weapon/implanter/U = new /obj/item/weapon/implanter(src)
				U.imp = new /obj/item/weapon/implant/uplink(U)
				return

			if("hacker")
				new /obj/item/weapon/aiModule/syndicate(src)
				new /obj/item/weapon/card/emag(src)
				new /obj/item/device/encryptionkey/binary(src)
				return

			if("lordsingulo")
				new /obj/item/device/radio/beacon/syndicate(src)
				new /obj/item/clothing/suit/space/syndicate(src)
				new /obj/item/clothing/head/helmet/space/syndicate(src)
				new /obj/item/clothing/mask/gas/syndicate(src)
				new /obj/item/weapon/tank/emergency_oxygen/double(src)
				new /obj/item/weapon/card/emag(src)
				return

			if("smoothoperator")
				new /obj/item/weapon/gun/projectile/pistol(src)
				new /obj/item/weapon/silencer(src)
				new /obj/item/weapon/soap/syndie(src)
				new /obj/item/storage/bag/trash(src)
				new /obj/item/bodybag(src)
				new /obj/item/clothing/under/suit_jacket(src)
				new /obj/item/clothing/shoes/laceup(src)
				return

/obj/item/storage/box/syndie_kit
	name = "box"
	desc = "A sleek, sturdy box"
	icon_state = "box_of_doom"

/obj/item/storage/box/syndie_kit/imp_freedom
	name = "boxed freedom implant (with injector)"

/obj/item/storage/box/syndie_kit/imp_freedom/New()
	..()
	var/obj/item/weapon/implanter/O = new(storage)
	O.imp = new /obj/item/weapon/implant/freedom(O)
	O.update()
	return

/obj/item/storage/box/syndie_kit/imp_compress
	name = "box (C)"

/obj/item/storage/box/syndie_kit/imp_compress/New()
	..()
	new /obj/item/weapon/implanter/compressed(storage)
	return

/obj/item/storage/box/syndie_kit/imp_explosive
	name = "box (E)"

/obj/item/storage/box/syndie_kit/imp_explosive/New()
	..()
	new /obj/item/weapon/implanter/explosive(storage)
	return

/obj/item/storage/box/syndie_kit/imp_uplink
	name = "boxed uplink implant (with injector)"

/obj/item/storage/box/syndie_kit/imp_uplink/New()
	..()
	var/obj/item/weapon/implanter/O = new(storage)
	O.imp = new /obj/item/weapon/implant/uplink(O)
	O.update()
	return

/obj/item/storage/box/syndie_kit/space
	name = "boxed space suit and helmet"

/obj/item/storage/box/syndie_kit/space/New()
	..()
	new /obj/item/clothing/suit/space/syndicate(storage)
	new /obj/item/clothing/head/helmet/space/syndicate(storage)
	new /obj/item/clothing/mask/gas/syndicate(storage)
	new /obj/item/weapon/tank/emergency_oxygen/double(storage)
	return

/obj/item/storage/box/syndie_kit/chameleon
	name = "chameleon kit"
	desc = "Comes with all the clothes you need to impersonate most people.  Acting lessons sold seperately."

/obj/item/storage/box/syndie_kit/chameleon/New()
	..()
	new /obj/item/clothing/under/chameleon(storage)
	new /obj/item/clothing/head/chameleon(storage)
	new /obj/item/clothing/suit/chameleon(storage)
	new /obj/item/clothing/shoes/chameleon(storage)
	new /obj/item/storage/backpack/chameleon(storage)
	new /obj/item/clothing/gloves/chameleon(storage)
	new /obj/item/clothing/mask/chameleon(storage)
	new /obj/item/clothing/glasses/chameleon(storage)
	new /obj/item/weapon/gun/projectile/chameleon(storage)
	new /obj/item/ammo_magazine/chameleon(storage)

/obj/item/storage/box/syndie_kit/clerical
	name = "clerical kit"
	desc = "Comes with all you need to fake paperwork. Assumes you have passed basic writing lessons."

/obj/item/storage/box/syndie_kit/clerical/New()
	..()
	new /obj/item/weapon/stamp/chameleon(storage)
	new /obj/item/weapon/pen/chameleon(storage)

/obj/item/storage/box/syndie_kit/spybug
	name = "spybug kit"
	desc = "Comes with everything you'll need to collect intel on the enemy."

/obj/item/storage/box/syndie_kit/spybug/New()
	..()
	new /obj/item/clothing/head/helmet/virtual(storage)
	new /obj/item/weapon/holder/spybug(storage)