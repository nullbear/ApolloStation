#define SM_DETECTION_RANGE 7

/obj/machinery/power/emr_analyzer
	name = "Electromagnetic Resonance Analyzer"
	desc = "A machine used to analyze the energy radiated by supermatter crystals."
	icon = 'icons/obj/machines/phoron_desublimation.dmi'
	icon_state = "resonance_analyzer"
	anchored = 1
	density = 1

	var/obj/machinery/power/supermatter/SM

/obj/machinery/power/emr_analyzer/New()
	..()
	find_sm()

/obj/machinery/power/emr_analyzer/proc/find_sm()
	var/searchdir = turn(dir, 180)
	icon_state = "resonance_analyzer"
	var/steps = 0
	var/turf/T = get_turf(src)
	while(steps < SM_DETECTION_RANGE)
		steps++
		T = get_step(T, searchdir)
		for(var/obj/machinery/power/supermatter/S in T)
			if(!S in view())
				continue
			SM = S
			if(SM.energy > SM.mass)
				icon_state = "resonance_analyzer_warning"
			return 1

/obj/machinery/power/emr_analyzer/verb/rotate()
	set name = "Rotate"
	set category = "Object"
	set src in oview(1) // Should be in adjacent(1) to prevent rotating from behind windows.

	if (src.anchored)
		usr << "It is fastened to the floor!"
		return 0
	src.set_dir(turn(src.dir, 90))
	return 1

/obj/machinery/power/emr_analyzer/attackby(obj/item/W, mob/user)
	if(!istype(user, /mob/living))
		return ..()
	if(istype(W, /obj/item/weapon/wrench))
		if(anchored)
			anchored = 0
			user << "You unfasten the bolts anchoring [src] to the floor."
		else
			anchored = 1
			user << "You tighten the bolts, anchoring [src] to the floor."
		return 1
	return ..()

/obj/machinery/power/emr_analyzer/attack_hand(mob/user)
	add_fingerprint(user)
	ui_interact(user)

/obj/machinery/power/emr_analyzer/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if(stat & BROKEN)
		return

	// this is the data which will be sent to the ui
	var/data[0]
	data["SM"] = 0
	data["mass"] = 0
	data["resonance"] = 0
	data["instability"] = 0
	data["decay"] = 0
	if(find_sm())
		data["SM"] = 1
		data["mass"] = round((SM.mass * 0.002), 0.01)
		data["resonance"] = round((SM.energy / SM.mass * 100), 0.01)
		data["instability"] = round(SM.instability, 0.01)
		data["decay"] = round(min(SM.energy, SM.mass * SM.instability * 0.001), 0.01)
	// update the ui if it exists, returns null if no ui is passed/found
	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "emr_analyzer.tmpl", "Electro-Magnetic Resonance Analyzer", 540, 380)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)


#undef SM_DETECTION_RANGE
