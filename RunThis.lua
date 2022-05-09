local myRunThisFrame = CreateFrame("Frame")

local defaults = {
  scripts = {"C_NamePlate.SetNamePlateFriendlySize(60, 30)"},
}

function myRunThisFrame:PLAYER_LOGIN(event, ...)
	RunThis = RunThis or {}
	RunThis.panel = CreateFrame( "Frame", "RunThisPanel", UIParent );
	-- Register in the Interface Addon Options GUI
	-- Set the name for the Category for the Options Panel
	RunThis.panel.name = "RunThis";

	-- Add the panel to the Interface Options
	InterfaceOptions_AddCategory(RunThis.panel);
	self.db = RunThis -- makes it more readable and generally a good practice
	for k, v in pairs(defaults) do -- copy the defaults table and possibly any new options
		if self.db[k] == nil then -- avoids resetting any false values
			self.db[k] = v
		end
	end

	for i, s in pairs(self.db.scripts) do
      print(format("%d : %s",i,s))
	  loadstring(s)()
    end
	-- put things here to be loaded
  	-- C_NamePlate.SetNamePlateFriendlySize(60, 30)
end

local function OnEvent(self, event, ...)
	self[event](self, event, ...)
end

myRunThisFrame:RegisterEvent("PLAYER_LOGIN")
myRunThisFrame:SetScript("OnEvent", OnEvent)


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