MinutiaeBind = Minutiae:NewModule("MinutiaeBind", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeBind:OnEnable()
	self:RegisterEvent("CONFIRM_LOOT_ROLL")
	self:RegisterEvent("CONFIRM_DISENCHANT_ROLL")
	if not Minutiae.db.global.bind then
		self:Disable()
	end
end

function MinutiaeBind:OnDisable()
	self:UnregisterEvent("CONFIRM_LOOT_ROLL")
	self:UnregisterEvent("CONFIRM_DISENCHANT_ROLL")
end

function MinutiaeBind:CONFIRM_LOOT_ROLL(_, id, roll)
	ConfirmLootRoll(id, roll)
	StaticPopup_Hide("CONFIRM_LOOT_ROLL")
end

function MinutiaeBind:CONFIRM_DISENCHANT_ROLL(_, id, roll)
	ConfirmLootRoll(id, roll)
	StaticPopup_Hide("CONFIRM_LOOT_ROLL")
end