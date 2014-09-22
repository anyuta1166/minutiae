MinutiaeInvite = Minutiae:NewModule("MinutiaeInvite", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeInvite:OnEnable()
	self:RegisterEvent("PARTY_INVITE_REQUEST")
	if not Minutiae.db.global.invite then
		self:Disable()
	end
end

function MinutiaeInvite:OnDisable()
	self:UnregisterEvent("PARTY_INVITE_REQUEST")
end

function MinutiaeInvite:PARTY_MEMBERS_CHANGED()
	for i=1, STATICPOPUP_NUMDIALOGS do
		local whichDialog = _G["StaticPopup"..i].which
		if whichDialog == "PARTY_INVITE" or whichDialog == "PARTY_INVITE_XREALM" then
			_G["StaticPopup"..i].inviteAccepted = 1
			StaticPopup_Hide(whichDialog)
			break
		end
	end
	self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
end

function MinutiaeInvite:AcceptPartyInvite()
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")	
	AcceptGroup()
end

function MinutiaeInvite:PARTY_INVITE_REQUEST(_, arg)
	for i=1, GetNumFriends() do
		if GetFriendInfo(i) == arg then
			self:AcceptPartyInvite()
			return
		end
	end

	local realm = GetRealmName();
	for i = 1, select(2, BNGetNumFriends()) do
		for j = 1, BNGetNumFriendToons(i) do
			local _, toonName, client, realmName = BNGetFriendToonInfo(i, j);
			if client == "WoW" then
				local fullName = toonName.."-"..realmName
				if (realmName == realm and toonName == arg) or fullName == arg then
					self:AcceptPartyInvite()
					return
				end
			end
		end
	end

	for i=1, GetNumGuildMembers() do
		if Ambiguate(GetGuildRosterInfo(i), "guild") == arg then
			self:AcceptPartyInvite()
			return
		end
	end
end