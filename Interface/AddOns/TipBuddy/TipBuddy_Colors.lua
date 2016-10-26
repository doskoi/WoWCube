-- TipBuddy: Copyright 2004 by Chester --

-- TipBuddy configurable text color
function TipBuddy_InitializeTextColors()
	if (not TipBuddy_SavedVars) then
		return;
	end

	local colors = TipBuddy_SavedVars["textcolors"];

	tbcolor_nam_hostile =			TipBuddy_RGBToHex(colors.nam_hos.r, colors.nam_hos.g, colors.nam_hos.b);
	tbcolor_nam_neutral =			TipBuddy_RGBToHex(colors.nam_neu.r, colors.nam_neu.g, colors.nam_neu.b);
	tbcolor_nam_friendly =			TipBuddy_RGBToHex(colors.nam_fri.r, colors.nam_fri.g, colors.nam_fri.b);
	tbcolor_nam_exalted =			TipBuddy_RGBToHex(colors.nam_fri.r, colors.nam_fri.g, colors.nam_fri.b);
	tbcolor_nam_caution =			TipBuddy_RGBToHex(colors.nam_cau.r, colors.nam_cau.g, colors.nam_cau.b);
	tbcolor_nam_pvp =				TipBuddy_RGBToHex(colors.nam_pvp.r, colors.nam_pvp.g, colors.nam_pvp.b);
	tbcolor_nam_tappedplayer =		TipBuddy_RGBToHex(colors.nam_tpp.r, colors.nam_tpp.g, colors.nam_tpp.b);
	tbcolor_nam_tappedother =		TipBuddy_RGBToHex(colors.nam_tpo.r, colors.nam_tpo.g, colors.nam_tpo.b);

	tbcolor_gld_hostile =			TipBuddy_RGBToHex(colors.gld_hos.r, colors.gld_hos.g, colors.gld_hos.b);
	tbcolor_gld_neutral =			TipBuddy_RGBToHex(colors.gld_neu.r, colors.gld_neu.g, colors.gld_neu.b);
	tbcolor_gld_friendly =			TipBuddy_RGBToHex(colors.gld_fri.r, colors.gld_fri.g, colors.gld_fri.b);
	tbcolor_gld_exalted =			TipBuddy_RGBToHex(colors.gld_fri.r, colors.gld_fri.g, colors.gld_fri.b);
	tbcolor_gld_caution =			TipBuddy_RGBToHex(colors.gld_cau.r, colors.gld_cau.g, colors.gld_cau.b);
	tbcolor_gld_pvp =				TipBuddy_RGBToHex(colors.gld_pvp.r, colors.gld_pvp.g, colors.gld_pvp.b);
	tbcolor_gld_tappedplayer =		TipBuddy_RGBToHex(colors.gld_tpp.r, colors.gld_tpp.g, colors.gld_tpp.b);
	tbcolor_gld_tappedother=		TipBuddy_RGBToHex(colors.gld_tpo.r, colors.gld_tpo.g, colors.gld_tpo.b);
	tbcolor_gld_mate =				TipBuddy_RGBToHex(colors.gld_mte.r, colors.gld_mte.g, colors.gld_mte.b);

	tbcolor_lvl_impossible =		TipBuddy_RGBToHex(colors.lvl_imp.r, colors.lvl_imp.g, colors.lvl_imp.b);
	tbcolor_lvl_verydifficult =		TipBuddy_RGBToHex(colors.lvl_vdf.r, colors.lvl_vdf.g, colors.lvl_vdf.b);
	tbcolor_lvl_difficult =			TipBuddy_RGBToHex(colors.lvl_dif.r, colors.lvl_dif.g, colors.lvl_dif.b);
	tbcolor_lvl_standard =			TipBuddy_RGBToHex(colors.lvl_stn.r, colors.lvl_stn.g, colors.lvl_stn.b);
	tbcolor_lvl_trivial =			TipBuddy_RGBToHex(colors.lvl_trv.r, colors.lvl_trv.g, colors.lvl_trv.b);
	tbcolor_lvl_same_faction =		TipBuddy_RGBToHex(colors.lvl_sfc.r, colors.lvl_sfc.g, colors.lvl_sfc.b);

	tbcolor_elite_rare =			TipBuddy_RGBToHex(colors.elite_rar.r, colors.elite_rar.g, colors.elite_rar.b);
	tbcolor_elite_worldboss =		TipBuddy_RGBToHex(colors.elite_bss.r, colors.elite_bss.g, colors.elite_bss.b);

	tbcolor_corpse = 			TipBuddy_RGBToHex(colors.other_crp.r, colors.other_crp.g, colors.other_crp.b);
	tbcolor_unknown =			TipBuddy_RGBToHex(colors.other_unk.r, colors.other_unk.g, colors.other_unk.b);
	tbcolor_race =				TipBuddy_RGBToHex(colors.other_rac.r, colors.other_rac.g, colors.other_rac.b);
	tbcolor_cityfac =			TipBuddy_RGBToHex(colors.other_ctf.r, colors.other_ctf.g, colors.other_ctf.b);

	-- Class Colors
	tbcolor_cls_other =			TipBuddy_RGBToHex(colors.cls_oth.r, colors.cls_oth.g, colors.cls_oth.b);
	tbcolor_cls = {
		["MAGE"] =		TipBuddy_RGBToHex(colors.cls_mag.r, colors.cls_mag.g, colors.cls_mag.b),
		["WARLOCK"] =	TipBuddy_RGBToHex(colors.cls_wlk.r, colors.cls_wlk.g, colors.cls_wlk.b),
		["PRIEST"] =	TipBuddy_RGBToHex(colors.cls_pri.r, colors.cls_pri.g, colors.cls_pri.b),
		["DRUID"] =		TipBuddy_RGBToHex(colors.cls_drd.r, colors.cls_drd.g, colors.cls_drd.b),
		["SHAMAN"] =	TipBuddy_RGBToHex(colors.cls_shm.r, colors.cls_shm.g, colors.cls_shm.b),
		["PALADIN"] =	TipBuddy_RGBToHex(colors.cls_pal.r, colors.cls_pal.g, colors.cls_pal.b),
		["ROGUE"] =		TipBuddy_RGBToHex(colors.cls_rog.r, colors.cls_rog.g, colors.cls_rog.b),
		["HUNTER"] =	TipBuddy_RGBToHex(colors.cls_hun.r, colors.cls_hun.g, colors.cls_hun.b),
		["WARRIOR"] =	TipBuddy_RGBToHex(colors.cls_war.r, colors.cls_war.g, colors.cls_war.b),
	};
end