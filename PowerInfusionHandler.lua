PowerInfusionHandler = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "CandyBar-2.0")

function PowerInfusionHandler:CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS(msg)
	if string.find(msg, "You gain Power Infusion") then
		PlaySound("LEVELUP")
		self:StopCandyBar("Power_Infusion_Cooldown")
		self:StartCandyBar("Power_Infusion")
	end
end

function PowerInfusionHandler:OnInitialize()
	self.anchor = self:CreateAnchor()

	self:RegisterCandyBarGroup("PowerInfusionHandler")
	self:SetCandyBarGroupPoint("PowerInfusionHandler", "TOP", self.anchor, "BOTTOM", 0, 0)
end

function PowerInfusionHandler:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
	self:RegisterCandyBar("Power_Infusion", 15, "Power Infusion, go HAM!", "Interface\\Icons\\Spell_Holy_PowerInfusion", "red")
	self:RegisterCandyBar("Power_Infusion_Cooldown", 165, "Power Infusion Cooldown", "Interface\\Icons\\Spell_Holy_PowerInfusion", "yellow")

	self:RegisterCandyBarWithGroup("Power_Infusion_Cooldown", "PowerInfusionHandler")
	self:RegisterCandyBarWithGroup("Power_Infusion", "PowerInfusionHandler")
	self:SetCandyBarCompletion("Power_Infusion", self.StartCooldownBar, self)
end

function PowerInfusionHandler:CreateAnchor()
	local f = CreateFrame("Button", nil, UIParent)
	f:SetWidth(10)
	f:SetHeight(10)

	f.owner = self
	f:SetPoint("CENTER", UIParent, "CENTER", 0, -50)

	return f
end

function PowerInfusionHandler:StartCooldownBar()
	self:StartCandyBar("Power_Infusion_Cooldown")
end
