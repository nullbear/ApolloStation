/obj/item/storage/wallet
	name = "wallet"
	desc = "It can hold a few small and personal things."
	icon_state = "wallet"
	w_class = 2
	slot_flags = SLOT_ID

	var/obj/item/weapon/card/id/front_id = null

/obj/item/storage/wallet/New()
	..()
	storage.hold_list = list(
		"/obj/item/weapon/spacecash",
		"/obj/item/weapon/card",
		"/obj/item/clothing/mask/cigarette",
		"/obj/item/device/flashlight/pen",
		"/obj/item/seeds",
		"/obj/item/stack/medical",
		"/obj/item/toy/crayon",
		"/obj/item/weapon/coin",
		"/obj/item/weapon/dice",
		"/obj/item/weapon/disk",
		"/obj/item/weapon/implanter",
		"/obj/item/weapon/flame/lighter",
		"/obj/item/weapon/flame/match",
		"/obj/item/weapon/paper",
		"/obj/item/weapon/pen",
		"/obj/item/weapon/photo",
		"/obj/item/weapon/reagent_containers/dropper",
		"/obj/item/weapon/screwdriver",
		"/obj/item/weapon/stamp")
	storage.max_size = 1.0
	storage.max_volume = 8
	storage.name = "wallet"

/obj/item/storage/wallet/attack_hand(mob/user as mob)
	..()
	if(front_id)
		if(!front_id.loc == storage)
			front_id = null
			name = initial(name)
			update_icon()

/obj/item/storage/wallet/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/weapon/card/id) && W.loc == storage && !front_id)
		front_id = W
		name = "[name] ([front_id])"
		update_icon()
	if(front_id)
		if(!front_id.loc == storage)
			front_id = null
			name = initial(name)
			update_icon()

/obj/item/storage/wallet/update_icon()

	if(front_id)
		if(!front_id.loc == storage)
			front_id = null
			name = initial(name)
			update_icon()
			return
		switch(front_id.icon_state)
			if("id")
				icon_state = "walletid"
				return
			if("silver")
				icon_state = "walletid_silver"
				return
			if("gold")
				icon_state = "walletid_gold"
				return
			if("centcom")
				icon_state = "walletid_centcom"
				return

	icon_state = "wallet"


/obj/item/storage/wallet/GetID()
	if(front_id)
		if(!front_id.loc == storage)
			front_id = null
			name = initial(name)
			update_icon()
	return front_id

/obj/item/storage/wallet/GetAccess()
	var/obj/item/I = GetID()
	if(I)
		return I.GetAccess()
	else
		return ..()

/obj/item/storage/wallet/random/New()
	..()
	var/item1_type = pick( /obj/item/weapon/spacecash/c10,/obj/item/weapon/spacecash/c100,/obj/item/weapon/spacecash/c1000,/obj/item/weapon/spacecash/c20,/obj/item/weapon/spacecash/c200,/obj/item/weapon/spacecash/c50, /obj/item/weapon/spacecash/c500)
	var/item2_type
	if(prob(50))
		item2_type = pick( /obj/item/weapon/spacecash/c10,/obj/item/weapon/spacecash/c100,/obj/item/weapon/spacecash/c1000,/obj/item/weapon/spacecash/c20,/obj/item/weapon/spacecash/c200,/obj/item/weapon/spacecash/c50, /obj/item/weapon/spacecash/c500)
	var/item3_type = pick( /obj/item/weapon/coin/silver, /obj/item/weapon/coin/silver, /obj/item/weapon/coin/gold, /obj/item/weapon/coin/iron, /obj/item/weapon/coin/iron, /obj/item/weapon/coin/iron )

	spawn(2)
		if(item1_type)
			new item1_type(storage)
		if(item2_type)
			new item2_type(storage)
		if(item3_type)
			new item3_type(storage)
