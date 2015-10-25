/obj/item/storage/pill_bottle/dice
	name = "pack of dice"
	desc = "It's a small container with dice inside."

	New()
		..()
		new /obj/item/weapon/dice(storage)
		new /obj/item/weapon/dice/d20(storage)

/*
 * Donut Box
 */

/obj/item/storage/box/donut_box
	icon = 'icons/obj/food.dmi'
	icon_state = "donutbox"
	name = "donut box"

/obj/item/storage/box/donut_box/New()
	..()
	storage.max_size = 2
	storage.max_volume = 48
	storage.updates_icon = 1
	storage.hold_list = list("/obj/item/weapon/reagent_containers/food/snacks/donut")
	new /obj/item/weapon/reagent_containers/food/snacks/donut/normal(storage)
	new /obj/item/weapon/reagent_containers/food/snacks/donut/normal(storage)
	new /obj/item/weapon/reagent_containers/food/snacks/donut/normal(storage)
	new /obj/item/weapon/reagent_containers/food/snacks/donut/normal(storage)
	new /obj/item/weapon/reagent_containers/food/snacks/donut/normal(storage)
	new /obj/item/weapon/reagent_containers/food/snacks/donut/normal(storage)
	update_icon()
	return

/obj/item/storage/box/donut_box/update_icon()
	overlays.Cut()
	var/i = 0
	for(var/obj/item/weapon/reagent_containers/food/snacks/donut/D in storage)
		var/image/img = image('icons/obj/food.dmi', D.overlay_state)
		img.pixel_x = i * 3
		overlays += img
		i++

/obj/item/storage/box/donut_box/empty
	New()
		..()
		storage.reset()
		update_icon()
