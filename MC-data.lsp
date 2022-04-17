
(setq fixture_types '( 
	LAV-PUB (
		MC-WTR ( :flowrate_gpm 0.5 :gal_per_cycle 0.125 :cycles_per_hour 12 :temperature 100 :use_factor 0.5)
		FUs ( :CW 1 :HW 1 :W 1.4 :D 1 ))

	LAV-PRIVATE (
		MC-WTR ( :flowrate_gpm 1.5 :gal_per_cycle 0.375 :cycles_per_hour 4 :temperature 100 :use_factor 0.5)
		FUs ( :CW 1 :HW 1 :W 1.4 :D 1 ))

	SH (
		MC-WTR ( :flowrate_gpm 1.5 :gal_per_cycle 15 :cycles_per_hour 2 :temperature 105 :use_factor 0.5)
		FUs ( :CW 1 :HW 1 :W 1.4 :D 2 ))

	BT (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 100 :cycles_per_hour 1 :temperature 105 :use_factor 0.2)
		FUs ( :CW 1 :HW 1 :W 1.4 :D 2 ))

	WC-FV (
		MC-WTR ( :flowrate_gpm 24 :gal_per_cycle 1.6 :cycles_per_hour 12 :temperature 50 :use_factor 1.0)
		FUs ( :CW 10 :HW 0 :W 10 :D 4 ))

	UR (
		MC-WTR ( :flowrate_gpm 15 :gal_per_cycle 0.5 :cycles_per_hour 12 :temperature 50 :use_factor 1.0)
		FUs ( :CW 5 :HW 0 :W 5 :D 2 ))

	SINK (
		MC-WTR ( :flowrate_gpm 2 :gal_per_cycle 2.5 :cycles_per_hour 2 :temperature 105 :use_factor 0.5)
		FUs ( :CW 1 :HW 1 :W 1.4 :D 2 ))

	SINK-EXAM (
		MC-WTR ( :flowrate_gpm 1.5 :gal_per_cycle 0.375 :cycles_per_hour 4 :temperature 105 :use_factor 0.5)
		FUs ( :CW 1 :HW 1 :W 1.4 :D 2 ))

	SINK-HS (
		MC-WTR ( :flowrate_gpm 1.5 :gal_per_cycle 0.375 :cycles_per_hour 4 :temperature 110 :use_factor 0.5)
		FUs ( :CW 1 :HW 1 :W 1.4 :D 2 ))

	SINK-TRAY (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 10 :cycles_per_hour 1.5 :temperature 105 :use_factor 0.75)
		FUs ( :CW 2 :HW 2 :W 3 :D 2 ))

	MS (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 15 :cycles_per_hour 1 :temperature 140 :use_factor 0.25)
		FUs ( :CW 1 :HW 1 :W 1.4 :D 2 ))

	WM-12LB (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 18 :cycles_per_hour 1 :temperature 110 :use_factor 0.75)
		FUs ( :CW 1 :HW 1 :W 1.4 :D 2 ))

	WM-20LB (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 40 :cycles_per_hour 1 :temperature 110 :use_factor 0.9)
		FUs ( :CW 3 :HW 3 :W 4 :D 2 ))

	WM-60LB (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 120 :cycles_per_hour 1 :temperature 110 :use_factor 0.9)
		FUs ( :CW 3 :HW 3 :W 4 :D 4 ))

	FSE-BARSINK (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 10 :cycles_per_hour 1 :temperature 140 :use_factor 0.9)
		FUs ( :CW 2 :HW 2 :W 3 :D 2 ))

	FSE-1B (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 30 :cycles_per_hour 1 :temperature 140 :use_factor 0.9)
		FUs ( :CW 3 :HW 3 :W 4 :D 2 ))

	FSE-2B (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 60 :cycles_per_hour 1 :temperature 140 :use_factor 0.9)
		FUs ( :CW 3 :HW 3 :W 4 :D 2 ))

	FSE-3B (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 90 :cycles_per_hour 1 :temperature 140 :use_factor 0.9)
		FUs ( :CW 3 :HW 3 :W 4 :D 2 ))

	FSE-DW (
		MC-WTR ( :flowrate_gpm 10 :gal_per_cycle 45 :cycles_per_hour 1 :temperature 140 :use_factor 0.9)
		FUs ( :CW 3 :HW 3 :W 4 :D 2 ))

	FSE-PRERINSE (
		MC-WTR ( :flowrate_gpm 2.5 :gal_per_cycle 45 :cycles_per_hour 1 :temperature 140 :use_factor 0.9)
		FUs ( :CW 2 :HW 2 :W 3 :D 2 ))

	;zSK (
	;	MC-WTR ( :flowrate_gpm 2.0 :gal_per_cycle 10 :cycles_per_hour 1 :temperature 110 :use_factor 0.5)
	;	FUs ( :CW 1 :HW 1 :W 1.4 :D 2 ))
	
	;zSK_EXAM (
	;	MC-WTR ( :flowrate_gpm 1.5 :gal_per_cycle 5 :cycles_per_hour 1 :temperature 110 :use_factor 0.5)
	;	FUs ( :CW 1 :HW 1 :W 1.4 :D 2 ))

	;zSINK-HS (
	;	MC-WTR ( :flowrate_gpm 1.5 :gal_per_cycle 5 :cycles_per_hour 1 :temperature 110 :use_factor 0.5)
	;	FUs ( :CW 1 :HW 1 :W 1.4 :D 2 ))



	))