/obj/item/implant/tracking
	name = "tracking implant"
	desc = "Track with this."
	activated = 0

/obj/item/implant/tracking/Initialize()
	. = ..()
	GLOB.tracked_implants += src

/obj/item/implant/tracking/Destroy()
	. = ..()
	GLOB.tracked_implants -= src

/obj/item/implanter/tracking
	imp_type = /obj/item/implant/tracking

/obj/item/implanter/tracking/gps
	imp_type = /obj/item/implant/gps

/obj/item/implant/gps
	name = "\improper GPS implant"
	desc = "Track with this and a GPS."
	activated = FALSE
	var/obj/item/gps/internal/mining/real_gps

/obj/item/implant/gps/implant(mob/living/target, mob/user, silent = FALSE)
	. = ..()
	if(!.)
		return
	if(real_gps)
		real_gps.forceMove(target)
	else
		real_gps = new(target)

/obj/item/implant/gps/removed(mob/living/source, silent = FALSE, special = 0)
	. = ..()
	if(!.)
		return
	if(!special)
		qdel(real_gps)
	else
		real_gps?.moveToNullspace()

/obj/item/implant/tracking/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Tracking Beacon<BR>
				<b>Life:</b> 10 minutes after death of host<BR>
				<b>Important Notes:</b> None<BR>
				<HR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Continuously transmits low power signal. Useful for tracking.<BR>
				<b>Special Features:</b><BR>
				<i>Neuro-Safe</i>- Specialized shell absorbs excess voltages self-destructing the chip if
				a malfunction occurs thereby securing safety of subject. The implant will melt and
				disintegrate into bio-safe elements.<BR>
				<b>Integrity:</b> Gradient creates slight risk of being overcharged and frying the
				circuitry. As a result neurotoxins can cause massive damage."}
	return dat


/obj/item/implantcase/track
	name = "implant case - 'Tracking'"
	desc = "A glass case containing a tracking implant."
	imp_type = /obj/item/implant/tracking