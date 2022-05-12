local RunThisFrame = CreateFrame("Frame")

RunThisFrame.defaults = {
  scripts = {
	  "C_NamePlate.SetNamePlateFriendlySize(60, 30)",
	  "C_NamePlate.SetNamePlateFriendlySize(60, 30)",
	},
}

function RunThisFrame:InitializeOptions()
	self.panel = CreateFrame( "Frame");
	-- Register in the Interface Addon Options GUI
	-- Set the name for the Category for the Options Panel
	self.panel.name = "RunThis";
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

function RunThisFrame:PLAYER_LOGIN(event)
	-- -- put things here to be loaded
  	-- -- C_NamePlate.SetNamePlateFriendlySize(60, 30)
	RunThisFrame:toggleSmallFriendlyNameplates()
end

function RunThisFrame:ADDON_LOADED(event, RunThis, ...)
	if RunThis == "RunThis" then
		RunThisDB = CopyTable(self.defaults) or RunThisDB
		self.db = RunThisDB
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

function RunThisFrame:toggleSmallFriendlyNameplates()
	C_NamePlate.SetNamePlateFriendlySize(60, 30)
end

function RunThisFrame:OnEvent(event, ...)
	self[event](self, event, ...)
end

RunThisFrame:RegisterEvent("ADDON_LOADED")
RunThisFrame:RegisterEvent("PLAYER_LOGIN")
RunThisFrame:SetScript("OnEvent", RunThisFrame.OnEvent)


-- Register in the Interface Addon Options GUI
-- Set the name for the Category for the Options Panel
-- RunThis.panel.name = "RunThis";
-- Add the panel to the Interface Options
-- InterfaceOptions_AddCategory(RunThis.panel);

-- Make a child panel
-- RunThis.childpanel = CreateFrame( "Frame", "MyAddonChild", RunThis.panel);
-- RunThis.childpanel.name = "MyChild";
-- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
-- RunThis.childpanel.parent = RunThis.panel.name;
-- Add the child to the Interface Options
-- InterfaceOptions_AddCategory(RunThis.childpanel);