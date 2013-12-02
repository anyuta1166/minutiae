MinutiaeResurrect = Minutiae:NewModule("MinutiaeResurrect", "AceConsole-3.0", "AceEvent-3.0")

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
	AcceptResurrect()
	StaticPopup_Hide("RESURRECT_REQUEST")
end