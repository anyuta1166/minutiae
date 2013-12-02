MinutiaeInvite = Minutiae:NewModule("MinutiaeInvite", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeInvite:OnEnable()
	self:RegisterEvent("PARTY_INVITE_REQUEST")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	if not Minutiae.db.global.invite then
		self:Disable()
	end
end

function MinutiaeInvite:OnDisable()
	self:UnregisterEvent("PARTY_INVITE_REQUEST")
	self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
end

function MinutiaeInvite:PARTY_MEMBERS_CHANGED()
	StaticPopup_Hide("PARTY_INVITE")
end

function MinutiaeInvite:PARTY_INVITE_REQUEST(_, arg)
	for i=1, GetNumFriends() do
		local name = GetFriendInfo(i)
		if name == arg then
			AcceptGroup()
			return
		end
	end
	for i=1, BNGetNumFriends() do
		local _, _, _, name = BNGetFriendInfo(i)
		if name == arg then
			AcceptGroup()
			return
		end
	end
	for i=1, GetNumGuildMembers() do
		local name = GetGuildRosterInfo(i)
		if name == arg then
			AcceptGroup()
			return
		end
	end
end