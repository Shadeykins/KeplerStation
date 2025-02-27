/obj/item/gun/energy/taser
	name = "taser gun"
	desc = "A low-capacity, energy-based stun gun used by security teams to subdue targets at range."
	icon_state = "taser"
	item_state = null	//so the human update icon uses the icon_state instead.
	ammo_type = list(/obj/item/ammo_casing/energy/electrode)
	ammo_x_offset = 3

/obj/item/gun/energy/tesla_revolver
	name = "tesla gun"
	desc = "An experimental gun based on an experimental engine, it's about as likely to kill its operator as it is the target."
	icon_state = "tesla"
	item_state = "tesla"
	ammo_type = list(/obj/item/ammo_casing/energy/tesla_revolver)
	can_flashlight = 0
	pin = null
	shaded_charge = 1

/obj/item/gun/energy/e_gun/advtaser
	name = "hybrid taser"
	desc = "A dual-mode taser designed to fire both short-range high-power electrodes and long-range disabler beams."
	icon_state = "advtaser"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/electrode)
	ammo_x_offset = 2

/obj/item/gun/energy/e_gun/advtaser/cyborg
	name = "cyborg taser"
	desc = "An integrated hybrid taser that draws directly from a cyborg's power cell. The one contains a limiter to prevent the cyborg's power cell from overheating."
	can_flashlight = FALSE
	can_charge = FALSE
	selfcharge = EGUN_SELFCHARGE_BORG
	cell_type = /obj/item/stock_parts/cell/secborg
	charge_delay = 5

/obj/item/gun/energy/e_gun/advtaser/cyborg/mean
	desc = "An integrated hybrid taser that draws directly from a cyborg's power cell."
	use_cyborg_cell = TRUE
	selfcharge = EGUN_NO_SELFCHARGE

/obj/item/gun/energy/disabler
	name = "disabler"
	desc = "A self-defense weapon that exhausts organic targets, weakening them until they collapse."
	icon_state = "disabler"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 3

/obj/item/gun/energy/disabler/cyborg
	name = "cyborg disabler"
	desc = "An integrated disabler that draws from a cyborg's power cell. This one contains a limiter to prevent the cyborg's power cell from overheating."
	can_charge = FALSE
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/secborg)
	selfcharge = EGUN_SELFCHARGE_BORG
	cell_type = /obj/item/stock_parts/cell/secborg
	charge_delay = 5

/obj/item/gun/energy/disabler/cyborg/mean
	desc = "An integrated disabler that draws from a cyborg's power cell."
	use_cyborg_cell = TRUE
	selfcharge = EGUN_NO_SELFCHARGE
