function GladiatorlosSA:GetSpellList () 
	return {
		auraApplied ={					-- aura applied [spellid] = ".ogg file name",
			--general
			--druid
			[61336] = "SurvivalInstincts", -- 
			[29166] = "innervate", -- 
			[22812] = "barkskin", -- 
			[17116] = "naturesSwiftness", -- 
			[16689] = "naturesGrasp", -- 
			[22842] = "frenziedRegeneration", -- 
			[5229] = "enrage", -- 
			[1850] = "dash", -- 
			[50334] = "berserk", -- 
			[69369] = "predatorSwiftness", --  
			--paladin
			[31821] = "auraMastery", -- 
			[1022] = "handOfProtection", -- 
			[1044] = "handOfFreedom", -- 
			[642] = "divineShield", -- 
			[6940] = "handOfSacrifice", -- 
			[54428] = "divinePlea", -- 
			[85696] = "zealotry", -- 
			[31884] = "avengingWrath",
			[64205] = "divineSacrifice",
			[498] = "divineProtection",
			[1044] = "handOfFreedom",
			--rogue
			[51713] = "shadowDance", -- 
			[2983] = "sprint", -- 
			[31224] = "cloakOfShadows", -- 
			[13750] = "adrenalineRush", -- 
			[5277] = "evasion", -- 
			[74001] = "combatReadiness", -- 
			--warrior
			[55694] = "enragedRegeneration", -- 
			[871] = "shieldWall", --
			[18499] = "berserkerRage", -- 
			[20230] = "retaliation", -- 
			[23920] = "spellReflection", -- 
			[12328] = "sweepingStrikes", -- 
			[46924] = "bladestorm", -- 
			[85730] = "deadlyCalm", -- 
			[12292] = "deathWish", -- 
			[1719] = "recklessness", -- 
			--priest
			[33206] = "painSuppression", -- 
			[37274] = "powerInfusion", -- 
			[6346] = "fearWard", -- 
			[47585] = "dispersion", -- 
			[89485] = "innerFocus", -- 
			[87153] = "darkArchangel",
			[87152] = "archangel",
			[47788] = "guardianSpirit",
			--shaman
			[52127] = "waterShield", -- 
			[30823] = "shamanisticRage", -- 
			[974] = "earthShield", -- 
			[16188] = "naturesSwiftness2", -- 
			[79206] = "spiritwalkersGrace",
			[16166] = "elementalMastery",
			--mage
			[45438] = "iceBlock", -- 
			[12042] = "arcanePower", -- 
			[12472] = "icyVeins", --
			--dk
			[49039] = "lichborne", -- 
			[48792] = "iceboundFortitude", -- 
			[55233] = "vampiricBlood", -- 
			[49016] = "unholyFrenzy", -- 
			[51271] = "pillarofFrost",
			[48707] = "antiMagicShell",
			--hunter
			[34471] = "theBeastWithin", -- 
			[19263] = "deterrence", -- 
			[3045] = "rapidFire",
			[54216] = "mastersCall",
			[51753] = "camouflage",
		},
		auraRemoved = {					-- aura removed [spellid] = ".ogg file name",
			[642] = "divineShieldDown", -- 
			[47585] = "dispersionDown", -- 
			[1022] = "handOfProtectionDown", -- 
			[31224] = "cloakDown", -- 
			[74001] = "combatReadinessDown", -- 
			[871] = "shieldWallDown", -- 
			[33206] = "PSDown", -- 
			[5277] = "evasionDown", -- 
			[45438] = "iceBlockDown", -- 
			[49039] = "lichborneDown", -- 
			[48792] = "iceboundFortitudeDown", --  
			--[34471] = "theBeastWithinDown", -- 
			[19263] = "deterrenceDown", -- 
			[51753] = "camouflageDown",
			[53480] = "roarOfSacrificeDown",
			[64205] = "divineSacrificeDown",
			[498] = "divineProtectionDown",
			[1044] = "handOfFreedomDown",
		},
		castStart = {					-- cast start [spellid] = ".ogg file name",
			--general
			[2060] = "bigHeal",
			[82326] = "bigHeal",
			[77472] = "bigHeal",
			[5185] = "bigHeal", --    
			[2006] = "resurrection",
			[7328] = "resurrection",
			[2008] = "resurrection",
			[50769] = "resurrection", --    
			--hunter
			[982] = "revivePet", -- 
			--druid
			[2637] = "hibernate", -- 
			[33786] = "cyclone", -- 
			--paladin
			--rogue
			--warrior
			[64382] = "shatteringThrow",
			--priest		
			[8129] = "manaBurn", -- 
			[9484] = "shackleUndead", -- 
			[605] = "mindControl", -- 
			--shaman
			[51514] = "hex", -- 
			[76780] = "bindElemental", -- 
			--mage
			[118] = "polymorph",
			[28272] = "polymorph",
			[61305] = "polymorph",
			[61721] = "polymorph",
			[61025] = "polymorph",
			[61780] = "polymorph",
			[28271] = "polymorph", --  
			--dk
			[49203] = "hungeringCold", -- 
			--hunter
			[1513] = "scareBeast", -- 
			--warlock
			[710] = "banish", -- 
			[5782] = "fear", -- 
			[5484] = "fear2", -- 
			[691] = "summonDemon",
			[712] = "summonDemon",
			[697] = "summonDemon",
			[688] = "summonDemon",
			[50796] = "chaosBolt",
		},
		castSuccess = {					--cast success [spellid] = ".ogg file name",
			--general
			[58984] = "shadowmeld", -- 			
			[20594] = "stoneform", -- 
			[7744] = "willOfTheForsaken", -- 
			[42292] = "trinket",
			[59752] = "trinket", -- 
			--druid
			[80964] = "skullBash",
			[80965] = "skullBash", -- 
			[740] = "tranquility", 
			[78675] = "solarBeam", -- 
			[5211] = "bash",
			[33831] = "forceOfNature",
			--paladin
			[96231] = "rebuke", -- 
			[20066] = "repentance", -- 
			[853] = "hammerofjustice", -- 
			[633] = "layOnHands",
			--rogue
			[51722] = "disarm2", -- 
			[2094] = "blind", -- 
			[1766] = "kick", -- 
			[14185] = "preparation", -- 
			[1856] = "vanish", --
			[76577] = "smokeBomb", -- 
			[14177] = "coldblood", -- 
			[73981] = "redirect",
			[79140] = "vendetta",
			[51713] = "shadowDance",
			--warrior
			[97462] = "rallyingCry", -- 
			[676] = "disarm", -- 
			[5246] = "fear3", -- 
			[6552] = "pummel", -- 
			--[72] = "shieldBash", -- 
			[85388] = "throwdown", -- 
			[2457] = "battlestance", -- 
			[71] = "defensiveStance", -- 
			[2458] = "berserkerstance", -- 
			[57755] = "heroicThrow",
			--priest
			[8122] = "fear4", -- 
			[34433] = "shadowFiend", -- 
			[64044] = "psychicHorror", -- 
			[15487] = "silence", -- 
			[64843] = "divineHymn",
			[19236] = "desperatePrayer",
			[32379] = "shadowWordDeath",
			--shaman
			[8177] = "grounding", -- 
			[16190] = "manaTide", -- 
			[8143] = "tremorTotem", -- 
			[98008] = "spiritlink", -- 
			[57994] = "windShear",
			[51533] = "feralSpirit",
			[370] = "purge",
			--mage
			[11958] = "coldSnap", -- 
			[44572] = "deepFreeze", -- 
			[2139] = "counterspell", -- 
			[66] = "invisibility", -- 
			[82676] = "ringOfFrost", -- 
			[12051] = "evocation",
			[30449] = "spellsteal",
			--dk
			[47528] = "mindFreeze", -- 
			[47476] = "strangulate", -- 
			[47568] = "empowerruneWeapon", -- 
			[49206] = "summongargoyle", -- 
			[77606] = "darkSimulacrum", -- 
			[48743] = "deathPact",
			--hunter
			[19386] = "wyvernSting", -- 
			[23989] = "readiness", -- 
			[19503] = "scattershot", -- 
			[34490] = "silencingshot", -- 
			[1499] = "freezingTrap",
			[60192] = "freezingTrap",
			[19577] = "intimidation",
			[19574] = "bestialWrath",
			--warlock
			[6789] = "deathCoil", --   
			[5484] = "fear2", -- 
			[19647] = "spellLock", -- 
			[48020] = "demonicCircleTeleport", -- 
			[77801] = "demonSoul", --
			[74434] = "soulburn",
			[19505] = "devourMagic",
		},
		friendlyInterrupt = {			--friendly interrupt [spellid] = ".ogg file name",
			[19647] = "lockout", -- Spell Lock
			[2139] = "lockout", -- Counter Spell
			[1766] = "lockout", -- Kick
			[6552] = "lockout", -- Pummel
			[47528] = "lockout", -- Mind Freeze
			[96231] = "lockout", -- Rebuke
			[93985] = "lockout", -- Skull Bash
			[97547] = "lockout", -- Solar Beam
		},
		friendlyInterrupted = {			--friendly interrupt [spellid] = ".ogg file name",
			[19647] = "interrupted", -- Spell Lock
			[2139] = "interrupted", -- Counter Spell
			[1766] = "interrupted", -- Kick
			[6552] = "interrupted", -- Pummel
			[47528] = "interrupted", -- Mind Freeze
			[96231] = "interrupted", -- Rebuke
			[93985] = "interrupted", -- Skull Bash
			[97547] = "interrupted", -- Solar Beam
		},
	}
end

