function UnitPopupManager:OnUpdate(elapsed)
    if ( not DropDownList1:IsShown() ) then
        return;
    end

    if ( not UnitPopup_HasVisibleMenu() ) then
        return;
    end
    local count, wasLastSeparator;
    for level, dropdownFrame in pairs(OPEN_DROPDOWNMENUS) do
        if(dropdownFrame) then
            count = 0
            if level == 1 then
                count = 2
            end
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
                        if(button.isSubsectionTitle) then 
                            if button:GetText() == UNIT_FRAME_DROPDOWN_SUBSECTION_TITLE_OTHER then
                                count = count + 1
                            end
                        elseif button.isSubsection then
                            if wasLastSeparator then
                                count = count - 1
                            end
                            wasLastSeparator = true
                        elseif (not button.isSubsection) then
                            wasLastSeparator = false
                            if (enable) then
                                UIDropDownMenu_EnableButton(level, count);
                            else
                                UIDropDownMenu_DisableButton(level, count);
                            end
                        end
                    end 
                end
            end 
        end
    end 
end 