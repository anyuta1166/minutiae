MinutiaeDuel = Minutiae:NewModule("MinutiaeDuel", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeDuel:OnEnable()
	self:RegisterEvent("DUEL_REQUESTED")
	if not Minutiae.db.global.duel then
	self:Disable()
	end
end

function MinutiaeDuel:OnDisable()
	self:UnregisterEvent("DUEL_REQUESTED")
end

function MinutiaeDuel:DUEL_REQUESTED()
	CancelDuel()
	StaticPopup_Hide("DUEL_REQUESTED")
end