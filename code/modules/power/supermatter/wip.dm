/*
	GAS EFFECTS
	PHORON: Heals the supermatter up until level 9
	N2O: Slows down power production
	O2: Acts as a turbocharger, multiplying heat and power production by a certain amount.
		Is required to keep a stable engine after level 5. If an engine is starved of O2, it will start experiencing critical failures.
	CO2: Fire suppressant, but also increases heat output by a small amount if SM level is 3 or above
*/

#define SM_PRISTINE 0
#define SM_EXPLODING 1
#define SM_DESTROYED 2
#define SM_WARNING 3

#define DELAM_SAFE_TIME 60 // Grace Time before exploding, once the crystal has begun delaminating. The actual time is about 3x this number.

#define SM_EXPLODE_TIME 3 // Time that the crystal spends on explosion.
#define SM_DELAM_RADIUS 20 // Delamination radius.
#define SM_HEAT_FACTOR 1000000 // Multiplier for the amount of heat generated.
#define SM_EFFECT_FACTOR 10 // How horrible the radiation and hallucination effects are.
#define SM_INSTABILITY_FACTOR 0.001 // How quickly emitters raise the instability.
#define SM_DEPLETION_FACTOR 0.001 // Modifier for instability -> power ratio. Increasing this makes power deplete faster.
#define SM_EFFECT_RANGE 7 // Range of Effect for sickness, hallucinations, and collectors. Recommended minimum of 3.
#define SM_POWER_FACTOR 500 // Multiplier for power produced.
#define SM_WARN_FREQUENCY 5 // Lower this number to increase the frequency of delamination warnings. Increase it to reduce spam. Should be int.


/obj/machinery/power/supermatter
	name = "supermatter core"
	desc = "A strangely translucent and iridescent crystal. <span class='alert'>You get headaches just from looking at it.</span>"
	icon = 'icons/obj/supermatter.dmi'
	icon_state = "supermatter"
	var/base_icon = "base"

	density = 1
	anchored = 0

	light_range = SM_EFFECT_RANGE

	var/mass = 2500 // The maximum amount of energy that can be stored.
	var/energy = 800 // The amount of energy that is stored.
	var/instability = 0 // The rate at which energy is depleted. (mass * instability)
	var/archived_resonance // Reduces the number of lighting and sprite updates.
	var/timetodet = DELAM_SAFE_TIME
	var/stage = SM_PRISTINE
	var/obj/item/device/radio/radio

/obj/machinery/power/supermatter/New(loc as turf, startmass, startenergy)
	. = ..()
	if(startmass)
		mass = startmass
	if(startenergy)
		energy = startenergy
	radio = new()
	update_icon()

/obj/machinery/power/supermatter/Destroy()
	qdel(radio)
	. = ..()

// Not fast enough. BOOM!
/obj/machinery/power/supermatter/proc/explode()
	message_admins("Supermatter exploded at ([x],[y],[z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)", "LOG:")
	log_game("Supermatter exploded at ([x],[y],[z])")

	spawn( SM_EXPLODE_TIME * TICKS_IN_SECOND )
		var/turf/epicenter = get_turf(src)

		explosion(epicenter, \
		          SM_DELAM_RADIUS/3, \
		          SM_DELAM_RADIUS/2, \
		          SM_DELAM_RADIUS, \
		          SM_DELAM_RADIUS*2, 1)

		supermatter_delamination( epicenter, SM_DELAM_RADIUS, 1 )
		qdel( src )
		return

// Out of energy. Become useless.
/obj/machinery/power/supermatter/proc/crumble()
	stage = SM_DESTROYED

/obj/machinery/power/supermatter/process()
	if(istype( loc, /obj/machinery/phoron_desublimer/resonant_chamber ))
		return // Resonant chambers are similar to bluespace beakers, they halt reactions within them

	switch(stage)
		if(SM_EXPLODING)
			supermatter_pull()
			return

		if(SM_DESTROYED)
			return

	// SUPERMATTER GAS INTERACTIONS
	gasInteract()
	// SUPERMATTER PSIONIC SHIT
	psionicBurst()
	// SUPERMATTER RADIATION
	radiate()
	// POWER HANDLING
	transfer_energy()
	// ICON STUFF
	update_stage()

/obj/machinery/power/supermatter/proc/update_stage()
	switch(stage)
		if(SM_PRISTINE)
			if(energy > mass)
				stage = SM_WARNING
		if(SM_WARNING)
			if(energy > mass)
				delam_warn()
			else
				delam_safe()
	update_icon()
	world << "Mass: [mass], Energy: [energy], Instability: [instability], Output: [min(energy, mass * instability * SM_DEPLETION_FACTOR)]"

/obj/machinery/power/supermatter/proc/delam_warn()
	if(!(timetodet%SM_WARN_FREQUENCY))
		var/message = "SUPERMATTER DELAMINATION IMMINENT! Integrity at [(timetodet/DELAM_SAFE_TIME)*100]%"
		radio.autosay(message, "Supermatter Monitor")
	timetodet--
	if(!timetodet)
		stage = SM_EXPLODING

/obj/machinery/power/supermatter/proc/delam_safe()
	stage = SM_PRISTINE
	timetodet = DELAM_SAFE_TIME
	var/message = "SUPERMATTER DELAMINATION CRISIS AVERTED"
	radio.autosay(message, "Supermatter Monitor")


/obj/machinery/power/supermatter/proc/gasInteract()
	if(!energy)
		return
	var/turf/L = loc
	var/datum/gas_mixture/env = null

	// Perform Gas Interactions and Calculations.
	if(istype(L, /turf/space))
		return
	env = L.return_air()
	var/deltamass = (env.gas["hydrogen"] * 2) + (env.gas["methane"] * 10) + ((env.gas["phoron"] + env.gas["en_phoron"] + env.gas["h_phoron"]) * 10) + (env.gas["oxygen"] * -6)
	var/deltaenergy = env.gas["phoron"] + (env.gas["en_phoron"] * 4) + (env.gas["h_phoron"] * 10)
	mass = max(1, mass + deltamass)
	energy = max(0, energy + deltaenergy)
	var/true_energy = min(energy, mass * instability * SM_DEPLETION_FACTOR)

	// Handle Gas Consumption And Heat Radiation.
	env.gas["carbon_dioxide"] += env.gas["oxygen"]
	env.gas["oxygen"] = 0
	env.gas["hydrogen"] = 0
	env.gas["methane"] = 0
	env.gas["phoron"] = 0
	env.gas["en_phoron"] = 0
	env.gas["h_phoron"] = 0
	env.add_thermal_energy(SM_HEAT_FACTOR * true_energy)

/obj/machinery/power/supermatter/proc/psionicBurst()
	if(!energy)
		return
	for(var/mob/living/carbon/human/l in oview(src, 7)) // If they can see it without mesons on.  Bad on them.
		if(!istype(l.glasses, /obj/item/clothing/glasses/meson))
			if(!isnucleation(l))
				l.hallucination = max(0, SM_EFFECT_FACTOR)
			else // Nucleations get less hallucinatoins
				l.hallucination = max(0, SM_EFFECT_FACTOR * 0.2)

// should probably be replaced with something more intricate sometime
// I meant an effect system. Not the math for fucks sake.
/obj/machinery/power/supermatter/proc/radiate()
	if(!energy)
		return
	var/true_energy = min(energy, mass * instability * SM_DEPLETION_FACTOR)
	for(var/mob/living/l in range(SM_EFFECT_RANGE))
		var/rads = (true_energy * SM_EFFECT_FACTOR) / (get_dist(l, src) + 1)
		l.apply_effect(rads, IRRADIATE)

//Hitting the core with anything, this includes power and damage calculations from the emitter.
/obj/machinery/power/supermatter/bullet_act(var/obj/item/projectile/Proj)
	instability += SM_INSTABILITY_FACTOR * Proj.damage
	return 0

/obj/machinery/power/supermatter/proc/arc_act(power)
	instability += SM_INSTABILITY_FACTOR * power

/obj/machinery/power/supermatter/attack_robot(mob/user as mob)
	if(Adjacent(user))
		return attack_hand(user)

/obj/machinery/power/supermatter/attack_hand(mob/user as mob)
	// The crystal is dead.
	if(!energy)
		user.visible_message("\The [user] reaches out and touches \the [src]... but nothing happens.</span>",\
							 "You reach out and touch \the [src]... but nothing happens.</span>")
		return
	// Nucleation's can touch it to heal completely. This consumes energy from the crystal.
	if( isnucleation( user ))
		var/mob/living/L = user
		user.visible_message("<span class=\"warning\">\The [user] reaches out and touches \the [src], inducing a resonance... \his body starts to glow before they calmly pull away from it.</span>",\
		"<span class='notice'>You reach out and touch \the [src]. Everything seems to go quiet and slow down as you feel your bodies crystal structures mending.\"</span></span>", \
		"<span class=\"danger\">Everything suddenly goes silent.\"</span>")
		L.rejuvenate()
		L.changeNext_move(CLICK_CD_MELEE)
		energy = max(0, energy - 10)
		return

	user.visible_message("<span class=\"warning\">\The [user] reaches out and touches \the [src], inducing a resonance... \his body starts to glow and bursts into flames before flashing into ash.</span>",\
		"<span class=\"danger\">You reach out and touch \the [src]. Everything starts burning and all you can hear is ringing. Your last thought is \"That was not a wise decision.\"</span>",\
		"<span class=\"warning\">You hear an uneartly ringing, then what sounds like a shrilling kettle as you are washed with a wave of heat.</span>")

	Consume(user)

/obj/machinery/power/supermatter/proc/transfer_energy()
	// Deplete Energy.
	var/true_energy = min(energy, mass * instability * SM_DEPLETION_FACTOR)
	statistics.increase_stat("energy_depleted", true_energy)
	energy = max(0, energy - true_energy)

	for(var/obj/machinery/power/rad_collector/R in rad_collectors)
		var/distance = get_dist(R, src)
		if(distance && distance <= SM_EFFECT_RANGE)
			//stop their being a massive benifit to moving the rad collectors closer
			if(distance < 3)	distance = 2.67			// between 25 - 50k benifit 	(level 1)

			R.receive_pulse((energy/mass) * true_energy * SM_POWER_FACTOR / distance)
	return

/obj/machinery/power/supermatter/attackby(obj/item/weapon/W as obj, mob/living/user as mob)
	if(!energy)
		return
	if(istype(W, /obj/item/weapon/shard/supermatter))
		src.instability += W.force * SM_INSTABILITY_FACTOR
		user.visible_message("<span class=\"warning\">\The [user] slashes at \the [src] with a [W] with a horrendous clash!</span>",\
		"<span class=\"danger\">You slash at \the [src] with \the [src] with a horrendous clash!\"</span>",\
		"<span class=\"warning\">A horrendous clash fills your ears.</span>")
		return

	user.visible_message("<span class=\"warning\">\The [user] touches \a [W] to \the [src] as a silence fills the room...</span>",\
		"<span class=\"danger\">You touch \the [W] to \the [src] when everything suddenly goes silent.\"</span>\n<span class=\"notice\">\The [W] flashes into dust as you flinch away from \the [src].</span>",\
		"<span class=\"warning\">Everything suddenly goes silent.</span>")

	user.drop_from_inventory(W)
	Consume(W)

/obj/machinery/power/supermatter/ex_act()
	instability += 5
	return

/obj/machinery/power/supermatter/Bumped( atom/AM as mob|obj )
	if(!energy)
		return
	if(istype(AM, /mob/living))
		var/mob/living/M = AM
		if( !M.smVaporize()) // Nucleation's biology doesn't react to this
			return
		AM.visible_message("<span class=\"warning\">\The [AM] slams into \the [src] inducing a resonance... \his body starts to glow and catch flame before flashing into ash.</span>",\
		"<span class=\"danger\">You slam into \the [src] as your ears are filled with unearthly ringing. Your last thought is \"Oh, fuck.\"</span>",\
		"<span class=\"warning\">You hear an uneartly ringing, then what sounds like a shrilling kettle as you are washed with a wave of heat.</span>")
	else if(stage != SM_EXPLODING) //To prevent spam, detonating supermatter does not indicate non-mobs being destroyed
		AM.visible_message("<span class=\"warning\">\The [AM] smacks into \the [src] and rapidly flashes to ash.</span>",\
		"<span class=\"warning\">You hear a loud crack as you are washed with a wave of heat.</span>")
	Consume(AM)

/obj/machinery/power/supermatter/proc/Consume(var/mob/living/user)
	if(!energy)
		return
	if(!istype(user))
		qdel( user )
		return
	if( user.smVaporize() )
		mass += 65000 // Roughly the weight of the average joe.
		radiate()

/obj/machinery/power/supermatter/update_icon()
	switch(energy/mass)
		if(-INFINITY to 0) // Black
			if(archived_resonance != 0)
				archived_resonance = 0
				light_power = 0.0
				shift_light("#ffffff")
				icon_state = "[initial(icon_state)]_black"
				name = "depleted [initial(name)]"
				return
		if(0 to 0.1) // Near Black
			icon_state = "[initial(icon_state)]_dark"
			if(archived_resonance != 0.1)
				archived_resonance = 0.1
				light_power = 1.0
				shift_light("#ff4444")
				return
		if(0.1 to 0.2) // Red
			icon_state = "[initial(icon_state)]_red"
			if(archived_resonance != 0.2)
				archived_resonance = 0.2
				light_power = 1.5
				shift_light("#ffaaaa")
				return
		if(0.2 to 0.3) // Orange
			icon_state = "[initial(icon_state)]_orange"
			if(archived_resonance != 0.3)
				archived_resonance = 0.3
				light_power = 2
				shift_light("#ffddaa")
				return
		if(0.3 to 0.4) // Yellow
			icon_state = "[initial(icon_state)]_yellow"
			if(archived_resonance != 0.4)
				archived_resonance = 0.4
				light_power = 2.5
				shift_light("#ffffaa")
				return
		if(0.4 to 0.5) // Lime
			icon_state = "[initial(icon_state)]_lime"
			if(archived_resonance != 0.5)
				archived_resonance = 0.5
				light_power = 3
				shift_light("#ddffaa")
				return
		if(0.5 to 0.6) // Green
			icon_state = "[initial(icon_state)]_green"
			if(archived_resonance != 0.6)
				archived_resonance = 0.6
				light_power = 3.5
				shift_light("#aaffaa")
				return
		if(0.6 to 0.7) // Cyan
			icon_state = "[initial(icon_state)]_cyan"
			if(archived_resonance != 0.7)
				archived_resonance = 0.7
				light_power = 4
				shift_light("#aaffff")
				return
		if(0.7 to 0.8) // Blue
			icon_state = "[initial(icon_state)]_blue"
			if(archived_resonance != 0.8)
				archived_resonance = 0.8
				light_power = 4.5
				shift_light("#aaddff")
				return
		if(0.8 to 0.9) // Purple
			icon_state = "[initial(icon_state)]_purple"
			if(archived_resonance != 0.9)
				archived_resonance = 0.9
				light_power = 5
				shift_light("#ddaaff")
				return
		if(0.9 to 0.995) // Rainbow
			icon_state = "[initial(icon_state)]_rainbow"
			if(archived_resonance != 0.995)
				archived_resonance = 0.995
				light_power = 5.5
				shift_light("#ffffff")
				return
		if(0.995 to INFINITY) // Ultra Rainbow
			icon_state = "[initial(icon_state)]_ultra"
			if(archived_resonance != 1)
				archived_resonance = 1
				light_power = 6
				shift_light("#ffffff")
				return

//Changes color and light_range of the light to these values if they were not already set
/obj/machinery/power/supermatter/proc/shift_light( var/clr, var/lum = light_range )
	light_color = clr
	light_range = lum

	color = clr

	set_light( light_range, light_power, light_color )

/obj/machinery/power/supermatter/proc/supermatter_pull()
	//following is adapted from singulo code
	if(defer_powernet_rebuild != 2)
		defer_powernet_rebuild = 1
	// Let's just make this one loop.
	for(var/atom/X in orange( SM_EFFECT_RANGE, src ))
		X.singularity_pull(src, STAGE_FIVE)

	if(defer_powernet_rebuild != 2)
		defer_powernet_rebuild = 0
	return

/obj/machinery/power/supermatter/GotoAirflowDest(n) //Supermatter not pushed around by airflow
	return

/obj/machinery/power/supermatter/RepelAirflowDest(n)
	return

/obj/machinery/power/supermatter/MouseDrop(atom/over)
	if(!usr || !over) return
	if(!Adjacent(usr) || !over.Adjacent(usr)) return // should stop you from dragging through windows

	spawn(0)
		over.MouseDrop_T(src,usr)
	return

/obj/machinery/power/supermatter/overmapTravel()
	qdel( src )