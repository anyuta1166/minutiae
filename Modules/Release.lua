MinutiaeRelease = Minutiae:NewModule("MinutiaeRelease", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeRelease:OnEnable()
	self:RegisterEvent("PLAYER_DEAD")
	if not Minutiae.db.global.release then
		self:Disable()
	end
end

function MinutiaeRelease:OnDisable()
	self:UnregisterEvent("PLAYER_DEAD")
end

function MinutiaeRelease:PLAYER_DEAD()
	if GetZonePVPInfo() == "comnbat" then
		RepopMe()
	end
end