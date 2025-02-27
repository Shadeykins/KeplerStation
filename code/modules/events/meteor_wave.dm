// Normal strength

#define SINGULO_BEACON_DISTURBANCE 0.2 //singularity beacon also improve the odds of meteor waves and speed them up a little.
#define SINGULO_BEACON_MAX_DISTURBANCE 0.6 //maximum cap due to how meteor waves can be potentially round ending.

/datum/round_event_control/meteor_wave
	name = "Meteor Wave: Normal"
	typepath = /datum/round_event/meteor_wave
	weight = 4
	min_players = 15
	max_occurrences = 3
	earliest_start = 25 MINUTES

/datum/round_event/meteor_wave
	startWhen		= 6
	endWhen			= 66
	announceWhen	= 1
	var/list/wave_type
	var/wave_name = "normal"

/datum/round_event/meteor_wave/setup()
	announceWhen = 1
	startWhen = rand(300, 600) //Yeah for SOME REASON this is measured in seconds and not deciseconds???
	if(GLOB.singularity_counter)
		startWhen *= 1 - min(GLOB.singularity_counter * SINGULO_BEACON_DISTURBANCE, SINGULO_BEACON_MAX_DISTURBANCE)
	endWhen = startWhen + 60


/datum/round_event/meteor_wave/New()
	..()
	if(!wave_type)
		determine_wave_type()

/datum/round_event/meteor_wave/proc/determine_wave_type()
	if(!wave_name)
		wave_name = pickweight(list(
			"normal" = 50,
			"threatening" = 40,
			"catastrophic" = 10))
	switch(wave_name)
		if("normal")
			wave_type = GLOB.meteors_normal
		if("threatening")
			wave_type = GLOB.meteors_threatening
		if("catastrophic")
			if(SSevents.holidays && SSevents.holidays[HALLOWEEN])
				wave_type = GLOB.meteorsSPOOKY
			else
				wave_type = GLOB.meteors_catastrophic
		if("meaty")
			wave_type = GLOB.meteorsB
		if("space dust")
			wave_type = GLOB.meteorsC
		if("halloween")
			wave_type = GLOB.meteorsSPOOKY
		else
			WARNING("Wave name of [wave_name] not recognised.")
			kill()

/datum/round_event/meteor_wave/announce(fake)
	priority_announce("Meteors have been detected on collision course with the station. Estimated time until impact: [round(startWhen/60)] minutes.[GLOB.singularity_counter ? " Warning: Anomalous gravity pulse detected, Syndicate technology interference likely." : ""]", "Meteor Alert", 'sound/ai/meteors.ogg')

/datum/round_event/meteor_wave/tick()
	if(ISMULTIPLE(activeFor, 3))
		spawn_meteors(5, wave_type) //meteor list types defined in gamemode/meteor/meteors.dm

/datum/round_event_control/meteor_wave/threatening
	name = "Meteor Wave: Threatening"
	typepath = /datum/round_event/meteor_wave/threatening
	weight = 5
	min_players = 20
	max_occurrences = 3
	earliest_start = 35 MINUTES

/datum/round_event/meteor_wave/threatening
	wave_name = "threatening"

/datum/round_event_control/meteor_wave/catastrophic
	name = "Meteor Wave: Catastrophic"
	typepath = /datum/round_event/meteor_wave/catastrophic
	weight = 7
	min_players = 25
	max_occurrences = 3
	earliest_start = 45 MINUTES

/datum/round_event/meteor_wave/catastrophic
	wave_name = "catastrophic"

#undef SINGULO_BEACON_DISTURBANCE
#undef SINGULO_BEACON_MAX_DISTURBANCE
