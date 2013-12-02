Minutiae = LibStub("AceAddon-3.0"):NewAddon("Minutiae", "AceConsole-3.0", "AceEvent-3.0")
local MinutiaeVersion = "1.1.0"
local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)

function Minutiae:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("MinutiaeDB", {
	global = {
		minimap = {
			hide = true},
			repair = true,
			repairSelfless = false,
			release = false,
			sell = true,
			resurrect = false,
			summon = false,
			quest = false,
			invite = false,
			duel = false,
			bind = false,
			nameplates = false,
			gossip = false,
			includedItems = {},
			excludedItems = {},
			startup = false,
			bank = false,
			lootbop = false,
			quit = false,
			roll = false,
			rollNoDE = false,
			tooltip = false
		}
	})
	self:RegisterChatCommand("Minutiae", "ChatCommand")
	MinutiaeLauncher = LDB:NewDataObject("Minutiae", {
		type = "launcher",
		icon = "Interface\\Icons\\Inv_misc_archstone_01.png",
		OnClick = function(_, button)
			local _, _, bg = GetWorldStateUIInfo(1)
			local pvptype = GetZonePVPInfo()
			if button == "RightButton" then
				InterfaceOptionsFrame_OpenToCategory(Minutiae.optionsFrame)
			else
				if type(bg) == 'number' then
					print(bg)
				elseif bg then print("Not Number: "..bg)
				end
				print(pvptype)
			end
		end,
		OnTooltipShow = function(tt)
			tt:AddLine("|cFFFF0000Minutiae "..MinutiaeVersion)
			tt:AddLine("|cFFFF8080Right Click|cFFFFFFFF to display the options panel")
		end})
	LDBIcon:Register("Minutiae", MinutiaeLauncher, self.db.global.minimap)
end

function Minutiae:OnEnable()
	local MinutiaeOptions = {
	name = "Minutiae",
	handler = Minutiae,
	type = "group",
	childGroups = "tab",
	args = {
		vendor = {
			name = "Vendor",
			handler = Minutiae,
			order = 1,
			type = 'group',
			args = {
				repair = {
					order = 1,
					type = 'toggle',
					name = 'Repair',
					desc = 'When checked, Minutiae attempts to repair all equipment at any vendor capable of repairing.  Will try guild repairs before personal funds.',
					get = 'Is',
					set = 'Set'
				},
				repairDesc = {
					order = 2,
					type = 'description',
					name = 'When checked, Minutiae attempts to repair all equipment at any vendor capable of repairing.  Will try guild repairs before personal funds.'
				},
				repairSelfless = {
					order = 3,
					type = 'toggle',
					name = 'Use Personal Funds',
					desc = 'When checked, Minutiae will always use personal funds to repair, not guild funds.',
					get = 'Is',
					set = 'Set',
					disabled = function() return not self.db.global.repair end
				},
				repairSelflessDesc = {
					order = 4,
					type = 'description',
					name = 'When checked, Minutiae will always use personal funds to repair, not guild funds.'
				},
				sell = {
					order = 5,
					type = 'toggle',
					name = 'Sell Grey Items',
					desc = 'When checked, Minutiae automatically grey (junk) quality items.',
					get = 'Is',
					set = 'Set'
				},
				sellDesc = {
					order = 6,
					type = 'description',
					name = 'When checked, Minutiae automatically grey (junk) quality items.'
				},
				inclusions = {
					order = 7,
					type = 'group',
					handler = Minutiae,
					name = 'Inclusions',
					disabled = true,
					args = self.db.global.includedItems
				},
				exclusions = {
					order = 8,
					type = 'group',
					handler = Minutiae,
					name = 'Exclusions',
					disabled = true,
					args = self.db.global.excludedItems
				},
				enterItem = {
					order = 9,
					name = "Enter Item:",
					type = 'input',
					disabled = true,
					set = "AddInclusions"
				},
				addItem = {
					order = 10,
					name = 'Add Item',
					type = 'execute',
					disabled = true,
					func = "AddInclusions"
				},
				removeItem = {
					order = 11,
					name = 'Remove Item',
					type = 'execute',
					disabled = true,
					func = "AddExclusions"
				}
			}
		},
		combat = {
			name = "Combat",
			handler = Minutiae,
			order = 2,
			type = 'group',
			args = {	
				release = {
					order = 1,
					type = 'toggle',
					name = 'Release in BGs',
					desc = 'When checked, Minutiae automatically releases your spirit upon death in a battleground.',
					get = 'Is',
					set = 'Set'
				},
				releaseDesc = {
					order = 2,
					type = 'description',
					name = 'When checked, Minutiae automatically releases your spirit upon death in a battleground.'
				},
				resurrect = {
					order = 3,
					type = 'toggle',
					name = 'Accept Resurrects',
					desc = 'When checked, Minutiae will automatically accept resurrects.',
					get = 'Is',
					set = 'Set'
				},
				resurrectDesc = {
					order = 4,
					type = 'description',
					name = 'When checked, Minutiae will automatically accept resurrects.'
				},
				nameplates = {
					order = 5,
					type = 'toggle',
					name = 'Nameplates in Combat',
					desc = 'When checked, Minutiae will bring up nameplates when entering combat.',
					get = 'Is',
					set = 'Set'
				},
				nameplatesDesc = {
					order = 6,
					type = 'description',
					name = 'When checked, Minutiae will bring up nameplates when entering combat.'
				},
				tooltip = {
					order = 7,
					type = 'toggle',
					name = 'Tooltip in Combat',
					desc = 'When checked, Minutiae will hide tooltips when you are in combat.',
					get = 'Is',
					set = 'Set'
				},
				tooltipDesc = {
					order = 8,
					type = 'description',
					name = 'When checked, Minutiae will hide tooltips when you are in combat.'
				}
			}
		},
		dialogs = {
			name = "Invites",
			handler = Minutiae,
			order = 3,
			type = 'group',
			args = {
				duel = {
					order = 1,
					type = 'toggle',
					name = 'Decline Duels',
					desc = 'When checked, Minutiae will automatically decline any duel request.',
					get = 'Is',
					set = 'Set'
				},
				duelDesc = {
					order = 2,
					type = 'description',
					name = 'When checked, Minutiae will automatically decline any duel request.'
				},
				invite = {
					order = 3,
					type = 'toggle',
					name = 'Accept Invites',
					desc = 'When checked, Minutiae will automatically accept group invites from friends and guild members.',
					get = 'Is',
					set = 'Set'
				},
				inviteDesc = {
					order = 4,
					type = 'description',
					name = 'When checked, Minutiae will automatically accept group invites from friends and guild members.'
				},
				summon = {
					order = 5,
					type = 'toggle',
					name = 'Accept Summons',
					desc = 'When checked, Minutiae will automatically accept summons.',
					get = 'Is',
					set = 'Set'
				},
				summonDesc = {
					order = 6,
					type = 'description',
					name = 'When checked, Minutiae will automatically accept summons.'
				}
			}
		},
		automation = {
			name = "Other Automation",
			handler = Minutiae,
			order = 4,
			type = 'group',
			args = {
				quest = {
					order = 1,
					type = 'toggle',
					name = 'Accept Quests',
					desc = 'When checked, Minutiae will automatically accept quests.',
					get = 'Is',
					set = 'Set'
				},
				questDesc = {
					order = 2,
					type = 'description',
					name = 'When checked, Minutiae will automatically accept quests.  Holding shift will temporarily disable this feature.'
				},
				bind = {
					order = 3,
					type = 'toggle',
					name = 'Roll for Bind On Pickup items',
					desc = 'When checked, Minutiae will automatically confirm the roll for Bind on Pickup items.',
					get = 'Is',
					set = 'Set'
				},
				bindDesc = {
					order = 4,
					type = 'description',
					name = 'When checked, Minutiae will automatically confirm the roll for Bind on Pickup items.'
				},
				lootbop = {
					order = 5,
					type = 'toggle',
					name = 'Loot Bind On Pickup items',
					desc = 'When checked, Minutiae will automatically loot Bind on Pickup items.',
					get = 'Is',
					set = 'Set'
				},
				lootbopDesc = {
					order = 6,
					type = 'description',
					name = 'When checked, Minutiae will automatically loot Bind on Pickup items.'
				},
				gossip = {
					order = 7,
					type = 'toggle',
					name = 'Skip Gossip',
					desc = 'When checked, Minutiae will skip gossip text when interacting with NPCs.',
					get = 'Is',
					set = 'Set'
				},
				gossipDesc = {
					order = 8,
					type = 'description',
					name = 'When checked, Minutiae will skip gossip text when interacting with NPCs.'
				},
				quit = {
					order = 9,
					type = 'toggle',
					name = 'Force quit',
					desc = 'When checked, Minutiae will force quit the game without waiting 20 seconds.',
					get = 'Is',
					set = 'Set'
				},
				quitDesc = {
					order = 10,
					type = 'description',
					name = 'When checked, Minutiae will force quit the game without waiting 20 seconds.'
				},
				roll = {
					order = 11,
					type = 'toggle',
					name = 'Auto roll',
					desc = 'When checked, Minutiae will automatically roll greed or disenchant for green items.',
					get = 'Is',
					set = 'Set'
				},
				rollDesc = {
					order = 12,
					type = 'description',
					name = 'When checked, Minutiae will automatically roll greed or disenchant for green items.'
				},
				rollNoDE = {
					order = 13,
					type = 'toggle',
					name = 'Always greed',
					desc = 'When checked, Minutiae will always roll greed for green items, not disenchant.',
					get = 'Is',
					set = 'Set',
					disabled = function() return not self.db.global.roll end
				},
				rollNoDEDesc = {
					order = 14,
					type = 'description',
					name = 'When checked, Minutiae will always roll greed for green items, not disenchant.'
				},
				bank = {
					order = 15,
					type = 'toggle',
					name = 'Open all bags in bank',
					desc = 'When checked, Minutiae will automatically open all bags in bank.',
					get = 'Is',
					set = 'Set'
				},
				bankDesc = {
					order = 16,
					type = 'description',
					name = 'When checked, Minutiae will automatically open all bags in bank.'
				}
			}
		},	
		misc = {
			name = "Miscellaneous",
			handler = Minutiae,
			order = 5,
			type = "group",
			args = {
				minimap = {
					order = 1,
					type = 'toggle',
					name = 'Show Minimap Button',
					desc = 'Show the Minimap Button',
					get = 'Is',
					set = 'Set'
				},
				startup = {
					order = 2,
					type = 'toggle',
					name = 'Show Version Loaded',
					desc = 'Show the one-line startup text that displays Minutiae version loaded.',
					get = 'Is',
					set = 'Set'
				},
				aboutHeader = {
					order = 3,
					type = 'header',
					name = 'About'
				},
				version = {
					order = 4,
					type = 'description',
					name = "Version: |cFFFF0000"..MinutiaeVersion.."|r"
				},
				author = {
					order = 5,
					type = 'description',
					name = 'by |cFFFF0000InSo(v)nIaX|r'
				}
			}
		}
	}}
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Minutiae", MinutiaeOptions)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Minutiae")  
	if self.db.global.startup then
		self:Print("v"..MinutiaeVersion.." Loaded.")
	end
end

function Minutiae:AddInclusions()
	
end

function Minutiae:AddExclusions()
	
end

function Minutiae:Set(arg, value)
	if arg[2] == "minimap" then
		self.db.global.minimap.hide = not value
		if self.db.global.minimap.hide then
			LDBIcon:Hide("Minutiae")
		else
			LDBIcon:Show("Minutiae")
		end
		return
	else
		self.db.global[arg[2]] = value
		if arg[2] == "startup" or arg[2] == "repairSelfless" or arg[2] == "rollNoDE" then
			return
		end
		local module = "Minutiae"..arg[2]:gsub("^%l", string.upper)
		if self.db.global[arg[2]] then
			_G[module]:Enable()
		else
			_G[module]:Disable()
		end
	end
end

function Minutiae:Is(arg)
	if arg[2] == "minimap" then
		return not self.db.global.minimap.hide
	else
		return self.db.global[arg[2]]
	end
end

function Minutiae:ChatCommand(input)
	if not input or input:trim() == "" or input == "options" then
		InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(Minutiae, "Minutiae", input)
	end
end