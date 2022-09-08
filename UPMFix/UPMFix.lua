function UnitPopupManager:OnUpdate(elapsed)
	if ( not DropDownList1:IsShown() ) then
		return;
	end

	if ( not UnitPopup_HasVisibleMenu() ) then
		return;
	end
	local tempCount, count; 
	for level, dropdownFrame in pairs(OPEN_DROPDOWNMENUS) do
		if(dropdownFrame) then
			count = 0;
			local menu = self:GetMenu(dropdownFrame.which);
			local topLevelButtons = menu:GetButtons(); 
			local menuButtons; 
			if(level == 2) then 
				local nestedMenu = topLevelButtons[UIDROPDOWNMENU_MENU_VALUE];
				local nestedMenusButtons = nestedMenu and nestedMenu:GetButtons(); 
				menuButtons = nestedMenusButtons; 
			else 
				menuButtons =  topLevelButtons;
			end 
			if (menuButtons) then 
				for index, button in ipairs(menuButtons) do 
					local shown = button:CanShow(); 
					if(shown) then
						count = count + 1;
						local enable = UnitPopupSharedUtil:IsEnabled(button);
						local diff = (level > 1) and 0 or 1;
						tempCount = count + diff; 
						if(button.isSubsectionTitle) then 
							count = count + 1; 
						elseif (not button.isSubsection) then
							if (enable) then
								UIDropDownMenu_EnableButton(level, tempCount);
							else 
								UIDropDownMenu_DisableButton(level, tempCount);
							end
						end		
					end 
				end
			end 
		end
	end 
end 
