/mob/living/carbon/movement_delay()
	. = ..()
	. += grab_state * 3 //can't go fast while grabbing something.

	if(!get_leg_ignore()) //ignore the fact we lack legs
		var/leg_amount = get_num_legs()
		. += 6 - 3*leg_amount //the fewer the legs, the slower the mob
		if(!leg_amount)
			. += 6 - 3*get_num_arms() //crawling is harder with fewer arms
		if(legcuffed)
			. += legcuffed.slowdown
		for(var/obj/item/bodypart/X in bodyparts)
			if(X.bone_status == BONE_FLAG_BROKEN)
				if(X.body_part == LEG_RIGHT || X.body_part == LEG_LEFT)
					. += 2 //can't move fast with a broken leg
					break // Dont stack the speed if a lot of shit is broken
	
	if(stat == SOFT_CRIT)
		. += SOFTCRIT_ADD_SLOWDOWN

/mob/living/carbon/slip(knockdown_amount, obj/O, lube)
	if(movement_type & FLYING)
		return 0
	if(!(lube&SLIDE_ICE))
		log_combat(src, (O ? O : get_turf(src)), "slipped on the", null, ((lube & SLIDE) ? "(LUBE)" : null))
	return loc.handle_slip(src, knockdown_amount, O, lube)

/mob/living/carbon/Process_Spacemove(movement_dir = 0)
	if(..())
		return 1
	if(!isturf(loc))
		return 0

	// Do we have a jetpack implant (and is it on)?
	var/obj/item/organ/cyberimp/chest/thrusters/T = getorganslot(ORGAN_SLOT_THRUSTERS)
	if(istype(T) && movement_dir && T.allow_thrust(0.01))
		return 1

	var/obj/item/tank/jetpack/J = get_jetpack()
	if(istype(J) && (movement_dir || J.stabilizers) && J.allow_thrust(0.01, src))
		return 1

/mob/living/carbon/Move(NewLoc, direct)
	. = ..()
	if(. && mob_has_gravity()) //floating is easy
		if(HAS_TRAIT(src, TRAIT_NOHUNGER))
			nutrition = NUTRITION_LEVEL_FED - 1	//just less than feeling vigorous
		else if(nutrition && stat != DEAD)
			nutrition -= HUNGER_FACTOR/10
			if(m_intent == MOVE_INTENT_RUN)
				nutrition -= HUNGER_FACTOR/10
