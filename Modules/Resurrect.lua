MinutiaeResurrect = Minutiae:NewModule("MinutiaeResurrect", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

function MinutiaeResurrect:OnEnable()
	self:RegisterEvent("RESURRECT_REQUEST")
	if not Minutiae.db.global.resurrect then
		self:Disable()
	end
end

function MinutiaeResurrect:OnDisable()
	self:UnregisterEvent("RESURRECT_REQUEST")
end

function MinutiaeResurrect:RESURRECT_REQUEST()
	self:mResurrectRequest()
end

function MinutiaeResurrect:mResurrectRequest()
	if UnitIsDeadOrGhost("player") then
		if self:CheckGroupCombat() then
			self:ScheduleTimer("mResurrectRequest", 2)
		else
			if ResurrectHasTimer() then
				self:ScheduleTimer("mResurrectRequest", GetCorpseRecoveryDelay() + 1)
			else
				AcceptResurrect()
				StaticPopup_Hide("RESURRECT")
				StaticPopup_Hide("RESURRECT_NO_SICKNESS")
				StaticPopup_Hide("RESURRECT_NO_TIMER")
			end
		end
	end
end

function MinutiaeResurrect:CheckGroupCombat()
	if UnitAffectingCombat("player") then
		return true
	end
	if GetNumGroupMembers() > 0 then
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				if UnitAffectingCombat("raid"..i) then
					return true
				end
				if UnitAffectingCombat("raidpet"..i) then
					return true
				end
			end
		else
			for i = 1, GetNumGroupMembers() do
				if UnitAffectingCombat("party"..i) then
					return true
				end
				if UnitAffectingCombat("partypet"..i) then
					return true
				end
			end
		end
	end
	return false
end
