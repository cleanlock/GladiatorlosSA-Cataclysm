 GladiatorlosSA = LibStub("AceAddon-3.0"):NewAddon("GladiatorlosSA", "AceEvent-3.0","AceConsole-3.0","AceTimer-3.0")

--Libraries
 local AceConfigDialog = LibStub("AceConfigDialog-3.0")
 local AceConfig = LibStub("AceConfig-3.0")
 local L = LibStub("AceLocale-3.0"):GetLocale("GladiatorlosSA")
 local LSM = LibStub("LibSharedMedia-3.0")
 local rc = LibStub("LibRangeCheck-3.0")
 

-- initializations
local self, GSA, PlaySoundFile = GladiatorlosSA, GladiatorlosSA, PlaySoundFile
local gsadb
local GSA_TEXT = "|cff69CCF0GladiatorlosSA|r (|cffFFF569/gsa|r)"
local GSA_VERSION = "|cffFF7D0A Cata-1.2 |r(|cff4DFF4D4.4.0 Cataclysm (Classic)|r)"
local GSA_TEST_BRANCH = ""
local GSA_AUTHOR = " Updated by Porkloaf"
local soundz,sourcetype,sourceuid,desttype,destuid = {},{},{},{},{}
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local canSpeakHere = false
local playerCurrentZone = ""
local debugMode = 0
local opponentName = ""
local duelingOn = false


local GSA_LOCALEPATH = {
	enUS = "GladiatorlosSA(Cataclysm)\\Voice_enUS",
}
 self.GSA_LOCALEPATH = GSA_LOCALEPATH

local GSA_LANGUAGE = {
	["GladiatorlosSA(Cataclysm)\\Voice_enUS"] = L["English(female)"],
}
self.GSA_LANGUAGE = GSA_LANGUAGE



--event/unit/spellID declarations
local GSA_EVENT = {
	SPELL_CAST_SUCCESS = L["Spell_CastSuccess"],
	SPELL_CAST_START = L["Spell_CastStart"],
	SPELL_AURA_APPLIED = L["Spell_AuraApplied"],
	SPELL_AURA_REMOVED = L["Spell_AuraRemoved"],
	SPELL_INTERRUPT = L["Spell_Interrupt"],
	SPELL_SUMMON = L["Spell_Summon"],
}
self.GSA_EVENT = GSA_EVENT
 
local GSA_TYPE = {
	[COMBATLOG_FILTER_EVERYTHING] = L["Any"],
	[COMBATLOG_FILTER_FRIENDLY_UNITS] = L["Friendly"],
	[COMBATLOG_FILTER_HOSTILE_PLAYERS] = L["Hostile player"],
	[COMBATLOG_FILTER_HOSTILE_UNITS] = L["Hostile unit"],
	[COMBATLOG_FILTER_NEUTRAL_UNITS] = L["Neutral"],
	[COMBATLOG_FILTER_ME] = L["Myself"],
	[COMBATLOG_FILTER_MINE] = L["Mine"],
	[COMBATLOG_FILTER_MY_PET] = L["My pet"],
	[COMBATLOG_FILTER_UNKNOWN_UNITS] = "Unknown unit",
}
self.GSA_TYPE = GSA_TYPE

local GSA_UNIT = {
	any = L["Any"],
	player = L["Player"],
	target = L["Target"],
	focus = L["Focus"],
	mouseover = L["Mouseover"],
	--party = L["Party"],
	--raid = L["Raid"],
	--arena = L["Arena"],
	--boss = L["Boss"],
	custom = L["Custom"], 
}
self.GSA_UNIT = GSA_UNIT

local friendlyDebuffs = {
	9005, -- Pounce
	9823, -- Pounce
	9827, -- Pounce
	27006, -- Garrote Silence
	26839, -- Garrote Silence
	19577, -- Intimidation
	12355, -- Impact (Fire Mage RNG stun talent)
	20170, -- Seal of Justice Stun
	1833, -- Cheap Shot
	6770, -- Sap
	2070, -- Sap
	11297, -- Sap
	5530, -- Mace Stun
}

local epicBGIDs = {
	2118, -- Wintergrasp [Epic]
	5095, -- Tol Barad
	30, -- Alterac Valley
	628, -- Isle of Conquest
	1280, -- Southshore vs Tarren Mill
	1191, -- Trashcan
	2197, -- Korrak's Revenge
}

--default settigns [MOVE TO OPTIONS.LUA]
local dbDefaults = {
	profile = {
		all = false,
		arena = true,
		battleground = true,
		field = false,
		path = GSA_LOCALEPATH[GetLocale()] or "GladiatorlosSA(Cataclysm)\\Voice",
		throttle = 0,
		smartDisable = false,
		rangeFilter = false,
		rangeFilterCutoff = 40,
		
		
		auraApplied = false,
		aruaRemoved = false,
		castStart = false,
		castSuccess = false,
		interrupt = false,
		
		aonlyTF = false,
		conlyTF= false,
		sonlyTF = false,
		ronlyTF = false,
		drinking = true,
		class = true,

		enrage = false,
		naturesGrasp = false,
		dash = false,
		sprint = false,
		berserkerRage = false,
		sweepingStrikes = false,
		archangel = false,
		earthShield = false,
		waterShield = false,
		spiritwalkersGrace = false,
		vampiricBlood = false,
		theBeastWithin = false,
		mastersCall = false,
		handOfFreedomDown = false,
		divindProtectionDown = false,
		hibernate = false,
		shackleUndead = false,
		bindElemental = false,
		hungeringCold = false,
		scareBeast = false,
		banish = false,
		stoneform = false,
		bash = false,
		forceOfNature = false,
		repentance = false,
		hammerOfJustice = false,
		layOnHands = false,
		coldBlood = false,
		redirect = false,
		disarm = false,
		intimidatingShout = false,
		throwdown = false,
		battleStance = false,
		defenseStance = false,
		berserkerStance = false,
		desperatePrayer = false,
		shadowfiend = false,
		tremorTotem = false,
		invisibility = false,
		evocation = false,
		ringOfFrost = false,
		deathPact = false,
		wyvernSting = false,
		intimidation = false,
		bestialWrath = false,
		
		custom = {},
	}	
}

--login message
GSA.log = function(msg) DEFAULT_CHAT_FRAME:AddMessage("|cFF33FF22GladiatorlosSA|r: "..msg) end


--addon initialization
function GladiatorlosSA:OnInitialize()
	if not self.spellList then
		self.spellList = self:GetSpellList() --from spelllist.lua
	end
	for _,v in pairs(self.spellList) do
		for _,spell in pairs(v) do
			if dbDefaults.profile[spell] == nil then dbDefaults.profile[spell] = true end --enable all spells not contained in dbDefaults [CHECK THAT TRUE IN DBDEFAULTS WORKS]
		end
	end
	
	self.db1 = LibStub("AceDB-3.0"):New("GladiatorlosSADB",dbDefaults, "Default");
	DEFAULT_CHAT_FRAME:AddMessage(GSA_TEXT .. GSA_VERSION .. GSA_AUTHOR .." "..GSA_TEST_BRANCH);
	self:RegisterChatCommand("GladiatorlosSA", "ShowConfig")
	self:RegisterChatCommand("gsa", "ShowConfig")
	self.db1.RegisterCallback(self, "OnProfileChanged", "ChangeProfile")
	self.db1.RegisterCallback(self, "OnProfileCopied", "ChangeProfile")
	self.db1.RegisterCallback(self, "OnProfileReset", "ChangeProfile")
	gsadb = self.db1.profile
	
	local options = {
		name = "GladiatorlosSA",
		desc = L["PVP Voice Alert"],
		type = 'group',
		args = {
			creditdesc = {
			order = 1,
			type = "description",
			name = L["GladiatorlosSACredits"].."\n",
			cmdHidden = true
			},
			gsavers = {
			order = 2,
			type = "description",
			name = GSA_VERSION,
			cmdHidden = true
			},
		},
	}
	LibStub("AceConfig-3.0"):RegisterOptionsTable("GladiatorlosSA_bliz", options)
	AceConfigDialog:AddToBlizOptions("GladiatorlosSA_bliz", "GladiatorlosSA")
	self:OnOptionCreate()
end

function GladiatorlosSA:OnEnable()
	GladiatorlosSA:RegisterEvent("PLAYER_ENTERING_WORLD")
	GladiatorlosSA:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	GladiatorlosSA:RegisterEvent("UNIT_AURA")
	GladiatorlosSA:RegisterEvent("DUEL_REQUESTED")
	GladiatorlosSA:RegisterEvent("DUEL_FINISHED")
	GladiatorlosSA:RegisterEvent("CHAT_MSG_SYSTEM")
	GladiatorlosSA:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	if not GSA_LANGUAGE[gsadb.path] then gsadb.path = GSA_LOCALEPATH[GetLocale()] end
	self.throttled = {}
	self.smarter = 0
end

-- play sound by file name	
function GSA:PlaySound(fileName)
	 PlaySoundFile("Interface\\Addons\\" ..gsadb.path.. "\\"..fileName .. ".ogg", gsadb.output_menu)
end


--return class for pvp trinket use
function GladiatorlosSA:ArenaClass(id)
	for i = 1 , 5 do
		if id == UnitGUID("arena"..i) then
			return select(2, UnitClass("arena"..i))
		end
	end
end

--check if addon should speak in zone
function GladiatorlosSA:PLAYER_ENTERING_WORLD()
	 self:CanTalkHere()
end

-- Checks if player is in a battleground
function GSA:IsInBG()
	local _,currentZoneType = IsInInstance()
	local _,_,_,_,_,_,_,instanceMapID = GetInstanceInfo()
	local playerCurrentZone = currentZoneType
	
	if currentZoneType == "pvp" then
		return true
	else
		return false
	end
end

--check range of relevant unit (if option is enabled)
function GladiatorlosSA:RangeCheck(sourceUnitID)
	if not sourceUnitID then
		return false
	end
	if (not gsadb.rangeFilter or not self:IsInBG()) then
		return true
	else
		local minRange, maxRange = rc:GetRange(sourceUnitID, true)
 		if not minRange then
			--print("cannot get range estimate for " .. sourceUnitID .. ".")
			return false
		elseif not maxRange then
			if UnitIsDead(sourceUnitID) then
				return false
			end
			--print(sourceUnitID ..  " is over " .. minRange .. " yards")
			return false
		else
			--print(sourceUnitID .. " is between " .. minRange .. " and " .. maxRange .. " yards.")
			if minRange > gsadb.rangeFilterCutoff then
				return false
			end
		end
	end
	return true
end



-- play sound by spell id and spell type
function GladiatorlosSA:PlaySpell(listName, spellID, sourceGUID, destGUID, ...)
	local list = self.spellList[listName]
	if not list[spellID] then return end
	if not gsadb[list[spellID]] then return	end
	if gsadb.throttle ~= 0 and self:Throttle("playspell",gsadb.throttle) then return end
	if gsadb.smartDisable then
		if (GetNumGroupMembers() or 0) > 20 then return end
		if self:Throttle("smarter",20) then
			self.smarter = self.smarter + 1
			if self.smarter > 30 then return end
		else 
			self.smarter = 0
		end
	end
	_, _, _, _, _, sourceName, _ = GetPlayerInfoByGUID(sourceGUID)
	
	if destGUID ~= "" then
		_, _, _, _, _, destName, _ = GetPlayerInfoByGUID(destGUID)
	end
	if (self:RangeCheck(sourceName) or self:RangeCheck(destName)) then
		self:PlaySound(list[spellID])
	end
end

function GSA:CheckForEpicBG(instanceMapID)	-- Determines if battleground is in list of epic bgs.
	for _, checkID in  ipairs(friendlyDebuffs) do
		if checkID == instanceMapID then
			return true
		end
	end
end

-- Checks settings and world location to determine if alerts should occur.
function GSA:CanTalkHere()
	-- !!Triggered from PLAYER_ENTERING_WORLD!!
	--Disable By Location
	local _,currentZoneType = IsInInstance()
	local _,_,_,_,_,_,_,instanceMapID = GetInstanceInfo()
	--local isPvP = UnitIsWarModeDesired("player")
	playerCurrentZone = currentZoneType
	duelingOn = false; -- Failsafe for when dueling events are skipped under unusual circumstances.
	if (not ((currentZoneType == "none" and gsadb.field and not gsadb.onlyFlagged) or 												-- World
		--(currentZoneType == "none" and gsadb.field and (gsadb.onlyFlagged and UnitIsWarModeDesired("player"))) or
		(currentZoneType == "pvp" and gsadb.battleground and not self:CheckForEpicBG(instanceMapID)) or 	-- Battleground
		(currentZoneType == "pvp" and gsadb.epicbattleground and self:CheckForEpicBG(instanceMapID)) or		-- Epic Battleground
		(currentZoneType == "arena" and gsadb.arena) or 													-- Arena
		(currentZoneType == "scenario" and gsadb.arena) or 													-- Scenario
		gsadb.all)) then																					-- Anywhere
		--return false
		canSpeakHere = false
	else
		canSpeakHere = true
	end
end




function GSA:CheckFriendlyDebuffs(spellID)
	for _, checkID in  ipairs(friendlyDebuffs) do
		if checkID == spellID then
			return true
		end
	end
end

--check for pvp trinket usage
function GladiatorlosSA:UNIT_SPELLCAST_SUCCEEDED(event, unitTarget, castGUID, spellID)
	if gsadb.class and (spellID == 42292 or spellID == 59752) then
		local guid = UnitGUID(unitTarget)
		local c = self:ArenaClass(guid)
		if c then
			self:PlaySound(c);
		end
	end
end

--big boi
function GladiatorlosSA:COMBAT_LOG_EVENT_UNFILTERED(event , ...)
	 -- Checks if alerts should occur here.
	 local isSanctuary = GetZonePVPInfo()
	 if (isSanctuary == "sanctuary") then return end	-- Checks for Sanctuary
	 if (not canSpeakHere) then return end				-- Checks result for everywhere else

	 local inBG = self:IsInBG()	
	 
	 -- Area check passed, fetch combat event payload.
	 local timestamp,event,hideCaster,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellID = CombatLogGetCurrentEventInfo()
	 if not GSA_EVENT[event] then return end

	 -- Checks if actively engaged in a duel
	 if (duelingOn and not string.find(sourceName, opponentName)) then
		 return
	 end
	 
	--get unit info (i think)
	 if (destFlags) then
		 for k in pairs(GSA_TYPE) do
			 desttype[k] = CombatLog_Object_IsA(destFlags,k)
			 --print("desttype:"..k.."="..(desttype[k] or "nil"))
		 end
	 else
		 for k in pairs(GSA_TYPE) do
			 desttype[k] = nil
		 end
	 end
	 if (destGUID) then
		 for k in pairs(GSA_UNIT) do
			 destuid[k] = (UnitGUID(k) == destGUID)
			 --print("destuid:"..k.."="..(destuid[k] and "true" or "false"))
		 end
	 else
		 for k in pairs(GSA_UNIT) do
			 destuid[k] = nil
			 --print("destuid:"..k.."="..(destuid[k] and "true" or "false"))
		 end
	 end
	 destuid.any = true
	 if (sourceFlags) then
		 for k in pairs(GSA_TYPE) do
			 sourcetype[k] = CombatLog_Object_IsA(sourceFlags,k)
			 --print("sourcetype:"..k.."="..(sourcetype[k] or "nil"))
		 end
	 else
		 for k in pairs(GSA_TYPE) do
			 sourcetype[k] = nil
			 --print("sourcetype:"..k.."="..(sourcetype[k] or "nil"))
		 end
	 end
	 if (sourceGUID) then
		 for k in pairs(GSA_UNIT) do
			 sourceuid[k] = (UnitGUID(k) == sourceGUID)
			 --print("sourceuid:"..k.."="..(sourceuid[k] and "true" or "false"))
		 end
	 else
		 for k in pairs(GSA_UNIT) do
			 sourceuid[k] = nil
			 --print("sourceuid:"..k.."="..(sourceuid[k] and "true" or "false"))
		 end
	 end
	 sourceuid.any = true

	--play predefined spells
	 if (event == "SPELL_AURA_APPLIED" and desttype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and (not gsadb.aonlyTF or destuid.target or destuid.focus) and not gsadb.aruaApplied) then
		 if self:CheckFriendlyDebuffs(spellID) then
			 return
		 end
		 self:PlaySpell("auraApplied", spellID, sourceGUID, destGUID)
	 elseif (event == "SPELL_AURA_APPLIED" and (desttype[COMBATLOG_FILTER_FRIENDLY_UNITS] or desttype[COMBATLOG_FILTER_ME]) and (not gsadb.aonlyTF or destuid.target or destuid.focus) and not gsadb.aruaApplied) then
		 if self:CheckFriendlyDebuffs(spellID) then
			 self:PlaySpell("auraApplied", spellID, sourceGUID, destGUID)
		 end
	 elseif (event == "SPELL_AURA_REMOVED" and desttype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and (not gsadb.ronlyTF or destuid.target or destuid.focus) and not gsadb.aruaRemoved) then
		 self:PlaySpell("auraRemoved", spellID, sourceGUID, destGUID)
	 elseif (event == "SPELL_CAST_START" and sourcetype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and (not gsadb.conlyTF or sourceuid.target or sourceuid.focus) and not gsadb.castStart) then
		 self:PlaySpell("castStart", spellID, sourceGUID, destGUID)
	 elseif (event == "SPELL_CAST_SUCCESS" and sourcetype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and (not gsadb.sonlyTF or sourceuid.target or sourceuid.focus) and not gsadb.castSuccess) then
		 if self:Throttle(tostring(spellID).."default", 0.05) then return end
		 self:PlaySpell("castSuccess", spellID, sourceGUID, destGUID)
	 elseif (event == "SPELL_INTERRUPT" and desttype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and not gsadb.interrupt) then
		 self:PlaySpell ("friendlyInterrupt", spellID, sourceGUID, destGUID)
	 elseif (event == "SPELL_INTERRUPT" and (desttype[COMBATLOG_FILTER_FRIENDLY_UNITS] or desttype[COMBATLOG_FILTER_ME]) and not gsadb.interruptedfriendly) then
		 self:PlaySpell ("friendlyInterrupted", spellID, sourceGUID, destGUID)
	 end


	 -- play custom spells
	 for k, css in pairs (gsadb.custom) do
		 if css.destuidfilter == "custom" and destName == css.destcustomname then
			 destuid.custom = true
		 else
			 destuid.custom = false
		 end
		 if css.sourceuidfilter == "custom" and sourceName == css.sourcecustomname then
			 sourceuid.custom = true
		 else
			 sourceuid.custom = false
		 end

		 if css.eventtype[event] and destuid[css.destuidfilter] and desttype[css.desttypefilter] and sourceuid[css.sourceuidfilter] and sourcetype[css.sourcetypefilter] and spellID == tonumber(css.spellid) then
			 if self:Throttle(tostring(spellID)..css.name, 0.1) then return end
			 --PlaySoundFile(css.soundfilepath, "Master")

			 if css.existingsound then -- Added to 2.3.3
				 if (css.existinglist ~= nil and css.existinglist ~= ('')) then
					 local soundz = LSM:Fetch('sound', css.existinglist)
					 PlaySoundFile(soundz, gsadb.output_menu)
				 else
					 GSA.log (L["No sound selected for the Custom alert : |cffC41F4B"] .. css.name .. "|r.")
				 end
			 else
				 PlaySoundFile(css.soundfilepath, gsadb.output_menu)
			 end
		 end
	 end
end

-- play drinking in arena
function GladiatorlosSA:UNIT_AURA(event,uid)
 	local _,currentZoneType = IsInInstance()
		if UnitIsEnemy("player", uid) and gsadb.drinking then
			if (AuraUtil.FindAuraByName("Drinking",uid) or AuraUtil.FindAuraByName("Food",uid) or AuraUtil.FindAuraByName("Refreshment",uid) or AuraUtil.FindAuraByName("Drink",uid)) and currentZoneType == "arena" then
				if self:Throttle(tostring(104270) .. uid, 4) then return end
			self:PlaySound("drinking")
			end
		end
end


function GladiatorlosSA:Throttle(key,throttle)
	if (not self.throttled) then
		self.throttled = {}
	end
	-- Throttling of Playing
	if (not self.throttled[key]) then
		self.throttled[key] = GetTime()+throttle
		return false
	elseif (self.throttled[key] < GetTime()) then
		self.throttled[key] = GetTime()+throttle
		return false
	else
		return true
	end
end

 -- A player has requested to duel me
function GladiatorlosSA:DUEL_REQUESTED(event, playerName)
	opponentName = playerName
	duelingOn = true
end
 
 --I requested a duel to my target
function GladiatorlosSA:CHAT_MSG_SYSTEM(event, text)
	if string.find(text, _G.ERR_DUEL_REQUESTED ) then
		if (UnitExists("target")) then
			duelingOn = true
			opponentName = UnitName("target")
		end
	end
end
 
  -- The duel finished or was canceled
function GladiatorlosSA:DUEL_FINISHED(event)
	opponentName = ""
	duelingOn = false
end