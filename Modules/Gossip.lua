MinutiaeGossip = Minutiae:NewModule("MinutiaeGossip", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeGossip:OnEnable()
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_GREETING")
	if not Minutiae.db.global.gossip then
		self:Disable()
	end
end

function MinutiaeGossip:OnDisable()
	self:UnregisterEvent("GOSSIP_SHOW")
	self:UnregisterEvent("QUEST_GREETING")
end

function MinutiaeGossip:GOSSIP_SHOW()
	if (GetNumGossipActiveQuests() + GetNumGossipAvailableQuests()) == 0 and GetNumGossipOptions() == 1 then
		SelectGossipOption(1)
	end
	for i=1, GetNumGossipActiveQuests() do
		if select(i*4, GetGossipActiveQuests(i)) == 1 then
			SelectGossipActiveQuest(i)
		end
	end
end

function MinutiaeGossip:QUEST_GREETING()
	MinutiaeGossip:GOSSIP_SHOW()
end