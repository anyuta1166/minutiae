MinutiaeSummon = Minutiae:NewModule("MinutiaeSummon", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeSummon:OnEnable()
	self:RegisterEvent("CONFIRM_SUMMON")
	if not Minutiae.db.global.summon then
		self:Disable()
	end
end

function MinutiaeSummon:OnDisable()
	self:UnregisterEvent("CONFIRM_SUMMON")
end

function MinutiaeSummon:CONFIRM_SUMMON()
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		ConfirmSummon()
		StaticPopup_Hide("CONFIRM_SUMMON")
	end
end

function MinutiaeSummon:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	ConfirmSummon()
	StaticPopup_Hide("CONFIRM_SUMMON")
end