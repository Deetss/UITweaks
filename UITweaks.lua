local UITweaksFrame = CreateFrame("Frame")

UITweaksFrame.defaults = {
  scripts = {
	  "C_NamePlate.SetNamePlateFriendlySize(60, 30)",
	  "C_NamePlate.SetNamePlateFriendlySize(60, 30)",
	},
}

function UITweaksFrame:InitializeOptions()
	self.panel = CreateFrame( "Frame");
	-- Register in the Interface Addon Options GUI
	-- Set the name for the Category for the Options Panel
	self.panel.name = "UITweaks";
	local offy = -20
	local offx = 20
	local oldEB = {}
	for i, s in pairs(self.db.scripts) do
		local seb = CreateFrame("EditBox", format("eb%d",i), self.panel, "StoreEditBoxTemplate");
		seb:Insert(s)
		if oldEB ~= {} then
			seb:SetPoint("TOPLEFT",oldEB, 0, offy)
		else
			seb:SetPoint("TOPLEFT", 0, offy)
		end
		offy = offy -20

		local btn = CreateFrame("Button", nil, self.panel, "UIPanelButtonTemplate")
		btn:SetPoint("TOPLEFT", seb, 0, offy)
		btn:SetText("Reload UI")
		btn:SetWidth(100)
		btn:SetScript("OnClick", function()
			C_UI.Reload() -- reload ui
		end)
		offy = offy -20
		oldEB = seb
	end

	-- Add the panel to the Interface Options
	InterfaceOptions_AddCategory(self.panel);
end

function UITweaksFrame:PLAYER_LOGIN(event)
	-- -- put things here to be loaded
  	-- -- C_NamePlate.SetNamePlateFriendlySize(60, 30)
	UITweaksFrame:toggleSmallFriendlyNameplates()
end

function UITweaksFrame:ADDON_LOADED(event, UITweaks, ...)
	if UITweaks == "UITweaks" then
		UITweaksDB = CopyTable(self.defaults) or UITweaksDB
		self.db = UITweaksDB
		for k, v in pairs(self.defaults) do -- copy the defaults table and possibly any new options
			if self.db[k] == nil then -- avoids resetting any false values
				self.db[k] = v
			end
		end

		for i, s in pairs(self.db.scripts) do
			print(s)
			loadstring(s)
		end
		
		self:InitializeOptions()
	end
end

function UITweaksFrame:toggleSmallFriendlyNameplates()
	C_NamePlate.SetNamePlateFriendlySize(60, 30)
end

function UITweaksFrame:OnEvent(event, ...)
	self[event](self, event, ...)
end

UITweaksFrame:RegisterEvent("ADDON_LOADED")
UITweaksFrame:RegisterEvent("PLAYER_LOGIN")
UITweaksFrame:SetScript("OnEvent", UITweaksFrame.OnEvent)


-- Register in the Interface Addon Options GUI
-- Set the name for the Category for the Options Panel
-- UITweaks.panel.name = "UITweaks";
-- Add the panel to the Interface Options
-- InterfaceOptions_AddCategory(UITweaks.panel);

-- Make a child panel
-- UITweaks.childpanel = CreateFrame( "Frame", "MyAddonChild", UITweaks.panel);
-- UITweaks.childpanel.name = "MyChild";
-- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
-- UITweaks.childpanel.parent = UITweaks.panel.name;
-- Add the child to the Interface Options
-- InterfaceOptions_AddCategory(UITweaks.childpanel);