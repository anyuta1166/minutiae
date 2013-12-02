MinutiaeNameplates = Minutiae:NewModule("MinutiaeNameplates", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeNameplates:OnEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	if not Minutiae.db.global.nameplates then
		self:Disable()
	end
end

function MinutiaeNameplates:OnDisable()
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
end

function MinutiaeNameplates:PLAYER_REGEN_DISABLED()
	SetCVar("nameplateShowEnemies", 1)
	NAMEPLATES_ON = true
end

function MinutiaeNameplates:PLAYER_REGEN_ENABLED()
	SetCVar("nameplateShowEnemies", 0)
	NAMEPLATES_ON = false
end