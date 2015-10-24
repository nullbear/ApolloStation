object/machinery/reprocessor
	name = "industrial reprocessor"
	desc = "An industrial grinder used by disposal crews for recycling old junk into their constituent materials."
	icon_state = "d_analyzer"
	use_power = 1
	idle_power_usage = 20
	active_power_usage = 3500

	/*
		Power - Pulse deactivates machine for 30 seconds. Cut prevents the machine from taking power from the network.
		Conveyor - Pulse toggles coveyor mode. Cut deactivates the conveyor permanently.
		Turbo - Pulse causes the grinder to grind automatically for 30 seconds. Cut Grinds at 300% speed, but has a 5% chance of jamming, and uses tons more power.
		Control - Pulse activates the grinder if there is an object inside. Cut prevents the grinder from being activated.
	*/
	var/list/wires = new/list("power" = 1, "conveyor" = 1, "turbo" = 1, "control" = 1)

	var/jammed = 0	// Whether the machine is currently jammed.
	var/processing = null // The reference of whatever is currently going through the machine.

	/*
		Multinet variables. Kind of a WIP at the moment, but it allows connections between different devices by configuring them with a multimeter in-game.
		Frequency used is effectively just bluetooth range, modified to look like the radio frequency formats. Despite how it looks, it is NOT compatible with
		radios or telecomms whatsoever. ID is the id of this specific machine, used if there are more than one of them on the same frequency, or with
		machines that connect to multiple different machines on the same frequency. Think how airlocks work code-wise.
	*/
	var/multinet_freq = (rand(2402, 2480)/10) // Select a random frequency within the multinet range. This only applies to newly made machines.
	var/multinet_id = "indreprocessor_01" // Default reprocessor id. Will need to be changed if a new one is added on the same frequency

/* ToDo:

	Add wires and maintenacne panel stuff.
	Add multinet functionality.
	Add sprites.
	Make it idle.
	Make it push items through it if conveyor is enabled.
	Make it grind objects if conveyor is not enabled.
	Add Jamming event.
	Add Emag functionality.
	Add Machine functionality.
	Add Turbo Mode.

*/

/obj/machinery/process()//If you dont use process or power why are you here
	return PROCESS_KILL




