MinutiaeSell = Minutiae:NewModule("MinutiaeSell", "AceConsole-3.0", "AceEvent-3.0")
local abacus = LibStub("LibAbacus-3.0")
local playerMoney

function MinutiaeSell:OnEnable()
	self:RegisterEvent("MERCHANT_SHOW")
	if not Minutiae.db.global.sell then
		self:Disable()
	end
end

function MinutiaeSell:OnDisable()
	self:UnregisterEvent("MERCHANT_SHOW")
end

function MinutiaeSell:MERCHANT_SHOW()
	playerMoney = GetMoney()
	for i=0, 4 do
		if GetContainerNumSlots(i) > 0 then
			for j=1, GetContainerNumSlots(i) do
				local q = GetContainerItemLink(i, j)
				if q then
					if strfind(q, "|cff9d9d9d") or q == 0 then
						UseContainerItem(i, j)
						self:RegisterEvent("MERCHANT_UPDATE")
					end
				end
			end
		end
	end
end

function MinutiaeSell:MERCHANT_UPDATE()
	if not ((GetMoney() - playerMoney) == 0) then
		print("|cFFFF0000Minutiae|r: Junk selling profits: "..abacus:FormatMoneyFull(GetMoney() - playerMoney, true))
		self:UnregisterEvent("MERCHANT_UPDATE")
	end
end