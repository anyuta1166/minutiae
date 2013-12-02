MinutiaeRepair = Minutiae:NewModule("MinutiaeRepair", "AceConsole-3.0", "AceEvent-3.0")
local abacus = LibStub("LibAbacus-3.0")

function MinutiaeRepair:OnEnable()
	self:RegisterEvent("MERCHANT_SHOW")
	if not Minutiae.db.global.repair then
		self:Disable()
	end
end

function MinutiaeRepair:OnDisable()
	self:UnregisterEvent("MERCHANT_SHOW")
end

function MinutiaeRepair:MERCHANT_SHOW()
	if GetRepairAllCost() > 0 then
		if IsInGuild() and not Minutiae.db.global.repairSelfless then
			if GetGuildBankWithdrawMoney() > GetRepairAllCost() then
				print("|cFFFF0000Minutiae|r: Repair costs: "..abacus:FormatMoneyFull(GetRepairAllCost(), true).." (Guild)")
				RepairAllItems(1)
				return
			else
				print("|cFFFF0000Minutiae|r: Repair costs: "..abacus:FormatMoneyFull(GetRepairAllCost(), true).." (Insufficient Guild Funds or Cannot Withdraw)")
			end
	end
		if GetRepairAllCost() > 0 and GetMoney() > GetRepairAllCost() then
			print("|cFFFF0000Minutiae|r: Repair costs: "..abacus:FormatMoneyFull(GetRepairAllCost(), true).." (Repaired)")
			RepairAllItems()
		else
			print("|cFFFF0000Minutiae|r: Repair costs: "..abacus:FormatMoneyFull(GetRepairAllCost(), true).." (Insufficient Funds)")
		end
	end
end