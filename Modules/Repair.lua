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
			local withdrawLimit = GetGuildBankWithdrawMoney()
			if withdrawLimit == -1 then
				withdrawLimit = GetGuildBankMoney()
			end
			if not CanGuildBankRepair() then
				print("|cFFFF0000Minutiae|r: Guild bank repair is not allowed")
			elseif withdrawLimit > GetRepairAllCost() then
				print("|cFFFF0000Minutiae|r: Repair costs: "..abacus:FormatMoneyFull(GetRepairAllCost(), true).." (Guild)")
				RepairAllItems(1)
				return
			else
				print("|cFFFF0000Minutiae|r: Repair costs: "..abacus:FormatMoneyFull(GetRepairAllCost(), true).." (Insufficient guild funds or cannot withdraw)")
			end
		end
		if GetRepairAllCost() > 0 and GetMoney() > GetRepairAllCost() then
			print("|cFFFF0000Minutiae|r: Repair costs: "..abacus:FormatMoneyFull(GetRepairAllCost(), true).." (Repaired)")
			RepairAllItems()
		else
			print("|cFFFF0000Minutiae|r: Repair costs: "..abacus:FormatMoneyFull(GetRepairAllCost(), true).." (Insufficient funds)")
		end
	end
end