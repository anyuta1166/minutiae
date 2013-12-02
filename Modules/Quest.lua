MinutiaeQuest = Minutiae:NewModule("MinutiaeQuest", "AceConsole-3.0", "AceEvent-3.0")

function MinutiaeQuest:OnEnable()
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("QUEST_ACCEPTED")
	self:RegisterEvent("QUEST_ACCEPT_CONFIRM")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")
	ORIG_ERR_QUEST_ACCEPTED_S = ERR_QUEST_ACCEPTED_S
	if not Minutiae.db.global.quest then
		self:Disable()
	end
end

function MinutiaeQuest:OnDisable()
	self:UnregisterEvent("QUEST_DETAIL")
	self:UnregisterEvent("QUEST_ACCEPTED")
	self:UnregisterEvent("QUEST_ACCEPT_CONFIRM")
	self:UnregisterEvent("QUEST_PROGRESS")
	self:UnregisterEvent("QUEST_COMPLETE")
	ERR_QUEST_ACCEPTED_S = ORIG_ERR_QUEST_ACCEPTED_S
end

function MinutiaeQuest:QUEST_DETAIL()
	ERR_QUEST_ACCEPTED_S = nil
	if IsShiftKeyDown() then
		return
	end
	if not QuestGetAutoAccept() then
		AcceptQuest()
	else
		CloseQuest()
	end
end

function MinutiaeQuest:QUEST_ACCEPTED(_, arg)
	print("|cFF7FFFBEMinutiae|cFFFFFFFF: Accepted: "..GetQuestLink(arg))
end

function MinutiaeQuest:QUEST_ACCEPT_CONFIRM()
	ConfirmAcceptQuest()
	StaticPopup_Hide("QUEST_ACCEPT")
end

function MinutiaeQuest:QUEST_PROGRESS()
	if IsQuestCompletable() then
		CompleteQuest()
	end
end

function MinutiaeQuest:QUEST_COMPLETE()
	if GetNumQuestChoices() < 2 then
		GetQuestReward(GetNumQuestChoices())
	end
end