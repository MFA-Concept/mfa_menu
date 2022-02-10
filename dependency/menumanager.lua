---
--[[
         __       __  ________  ______          ______                                                       __
        /  \     /  |/        |/      \        /      \                                                     /  |
        $$  \   /$$ |$$$$$$$$//$$$$$$  |      /$$$$$$  |  ______   _______    _______   ______    ______   _$$ |_
        $$$  \ /$$$ |$$ |__   $$ |__$$ |      $$ |  $$/  /      \ /       \  /       | /      \  /      \ / $$   |
        $$$$  /$$$$ |$$    |  $$    $$ |      $$ |      /$$$$$$  |$$$$$$$  |/$$$$$$$/ /$$$$$$  |/$$$$$$  |$$$$$$/
        $$ $$ $$/$$ |$$$$$/   $$$$$$$$ |      $$ |   __ $$ |  $$ |$$ |  $$ |$$ |      $$    $$ |$$ |  $$ |  $$ | __
        $$ |$$$/ $$ |$$ |     $$ |  $$ |      $$ \__/  |$$ \__$$ |$$ |  $$ |$$ \_____ $$$$$$$$/ $$ |__$$ |  $$ |/  |
        $$ | $/  $$ |$$ |     $$ |  $$ |      $$    $$/ $$    $$/ $$ |  $$ |$$       |$$       |$$    $$/   $$  $$/
        $$/      $$/ $$/      $$/   $$/        $$$$$$/   $$$$$$/  $$/   $$/  $$$$$$$/  $$$$$$$/ $$$$$$$/     $$$$/
                                                                                                $$ |
                                                                                                $$ |
                                                                                                $$/
--]]
--- Created by Absolute.
--- DateTime: 14/01/2022 11:09
---

--- MenuManager for lua usage.

MenuManager = {};

MN = MenuManager;

local pools = {};

local mfaMenuIsEnable = false;

function clearPool()
    for i, v in pairs(pools) do
        v();
    end
end

function checkPools()
    if not mfaMenuIsEnable then
        TriggerEvent("mfa_menu:isEnabled", function() mfaMenuIsEnable = true; clearPool(); end)
        SetTimeout(500,function() checkPools() end);
    end
end

checkPools();

function addToPool(cb)
    if not mfaMenuIsEnable then
        table.insert(pools,cb);
    else
       cb();
    end
end

--- Create Menu Or Submenu, for create a submenu you just need to specify parent id.
--- @param id string id menu
--- @param title string title menu
--- @param subtitle string subtitle menu
--- @param parent string parent id
function MenuManager.createMenu(id,title,subtitle,parent)
    addToPool(function() TriggerEvent("mfa_menu:createMenu",id,title,subtitle,parent) end);
end

---Create Button
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param rightLabel string define right label
---@param rightIcon string define right icon font awesome ex: "fas fa-user"
---@param cbk function The callback function for the button called when Enter is pressed
function MenuManager.button(id, leftLabel, leftIcon, description, rightLabel, rightIcon, cbk)
    addToPool(function() TriggerEvent("mfa_menu:button",id,
            leftLabel, leftIcon, description, rightLabel, rightIcon, cbk) end);
end

---Create Banniere
---@param id string id menu
---@param image string define image for menu the image need to be in images folder in mfa_menu
---@param hideTitle boolean hide title if is true
---@param centerTitle boolean center title is is true
---@param font string define the font of banniere
function MenuManager.banniere(id,image,showTitle,centerTitle,font)
    addToPool(function() TriggerEvent("mfa_menu:banniere",id, image,showTitle,centerTitle,font); end);
end

---Set the font menu, the basic fonts are that of webfonts:
---Arial
---Arial Black
---Verdana
---Tahoma
---Trebuchet MS
---Impact
---Times New Roman
---Didot
---Georgia
---American Typewriter
---Andalé Mono
---Courier
---Lucida Console
---Monaco
---Bradley Hand
---Brush Script MT
---Luminari
---Comic Sans MS
---https://blog.hubspot.com/website/web-safe-html-css-fonts
---@param id string id menu
---@param fontName string font name ex: Arial
function MenuManager.fontGlobalForMenu(id,fontName)
    addToPool(function() TriggerEvent("mfa_menu:fontGlobalForMenu",id,fontName); end);

end
---Create Checkbox
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param initialValue boolean define default value
---@param cbk function The callback function for the button called when Enter is pressed. the function received in param data => data.value contains true/false
function MenuManager.checkbox(id, leftLabel, leftIcon, description, initialValue, cbk)
    addToPool(function() TriggerEvent("mfa_menu:checkbox",id, leftLabel, leftIcon, description, initialValue, cbk); end);

end
---Create submenu button
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param rightIcon string define description for the current item menu
---@param submenu string id menu of the submenu
---@param cbk function The callback function for the button called when Enter is pressed
---@param isLock boolean Lock the submenu
-----
function MenuManager.buttonSubmenu(id, leftLabel, leftIcon, description, rightIcon,submenu, cbk,isLock)
    addToPool(function() TriggerEvent("mfa_menu:buttonSubmenu",id, leftLabel, leftIcon, description,rightIcon, submenu, cbk,isLock); end);
end
---Create listbox
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param data object the data in listbox ex {"test1","test2","test3"} or {1,2,3,4,5}
---@param cbk function The callback function for the button called when Enter is pressed.The function received in param data => data.value contains current value of selected in listbox
function MenuManager.listbox(id, leftLabel, leftIcon, description, data, cbk)
    addToPool(function() TriggerEvent("mfa_menu:listbox",id, leftLabel, leftIcon, description, data, cbk); end);

end


---Create Separator
---@param id string id menu
---@param label string label separator
---@param icon string icon separator
---@param enableLines boolean
function MenuManager.separator(id, label, icon,enableLines)
    addToPool(function() TriggerEvent("mfa_menu:separator",id, label, icon,enableLines); end);

end
---Create Progressbar
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param userCanInteract boolean define if user can change the value
---@param value number default value
---@param step number
---@param maxVal number
---
function MenuManager.progressbar(id, leftLabel, leftIcon, description, userCanInteract, value, step, maxVal, cbk)
    addToPool(function() TriggerEvent("mfa_menu:progressbar",id, leftLabel, leftIcon, description, userCanInteract, value, step, maxVal, cbk); end);

end

---Create Input
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param type string define type of input ("text"/"date"/"number")
---@param cbk function The callback function for the button called when Enter is pressed.The function received in param data => data.value contains the value
function MenuManager.input(id, leftLabel, leftIcon, description, type, cbk)
    addToPool(function() TriggerEvent("mfa_menu:input",id, leftLabel, leftIcon,description,type,cbk); end);

end
---Create Togggle
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param initialValue boolean define default value
---@param cbk function The callback function for the button called when Enter is pressed. the function received in param data => data.value contains true/false
function MenuManager.toggle(id, leftLabel, leftIcon, description, initialValue, cbk)
    addToPool(function() TriggerEvent("mfa_menu:toggle",id, leftLabel, leftIcon, description, initialValue, cbk); end);
end

---remove all menu items from the specified index until the end
---@param id string id menu
---@param index number index
function MenuManager.clearMenuItem(id,index)
    addToPool(function() TriggerEvent("mfa_menu:clearMenuItem",id,index); end);
end

---open the specific menu
---@param id string id menu
function MenuManager.openMenu(id)
    addToPool(function() TriggerEvent("mfa_menu:select",id); end);
end

---close menu
function MenuManager.closeMenu()
    addToPool(function() TriggerEvent("mfa_menu:select",null); end);
end

--- Check if the menu is visible the response come in callback.
function MenuManager.isVisible(id,cb)
    addToPool(function() TriggerEvent("mfa_menu:isVisible",id,cb); end);
end

--- Call when the menu is closed.
function MenuManager.onCloseMenu(id,cb)
    --c.o[id] = cb;
    addToPool(function() TriggerEvent("mfa_menu:onCloseMenu",id,cb); end);
end
--- Change descrition content.
function MenuManager.changeDesc(id,content)
    addToPool(function() TriggerEvent("mfa_menu:changeDesc",id,content); end);
end
--- Change description content and show description
function MenuManager.changeDescAndShow(id,content)
    addToPool(function() TriggerEvent("mfa_menu:changeDescAndShow",id,content); end);
end

--- Refresh menu
function MenuManager.refresh(id)
    addToPool(function() TriggerEvent("mfa_menu:refresh",id); end);
end


function MenuManager.onPressed(action)
    if action == "onPressed" then
        return true
    end
    return false
end

function MenuManager.onChange(action)
    if action == "onChange" then
        return true
    end
    return false
end

function MenuManager.onHover(action)
    if action == "onHover" then
        return true
    end
    return false
end

--------------------------------------------------------------------------------------------------------

MfaMenus = {};
Menu = {};
--- Create Menu Or Submenu, for create a submenu you just need to specify parent id.
--- @param id string id menu
--- @param title string title menu
--- @param subtitle string subtitle menu
--- @param parent string parent id
function Menu:createMenu(id,title,subtitle,parent)
    o = {}
    setmetatable(o,self);
    o.id = id;
    o.title = title;
    o.subtitle = subtitle;
    o.parent = parent;
    return o;
end

---Create Button
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param rightLabel string define right label
---@param rightIcon string define right icon font awesome ex: "fas fa-user"
---@param cbk function The callback function for the button called when Enter is pressed
function Menu:button(leftLabel, leftIcon, description, rightLabel, rightIcon, cbk)
    MenuManager.button(self.id,leftLabel, leftIcon, description, rightLabel, rightIcon, cbk);
end

---Create Banniere
---@param id string id menu
---@param image string define image for menu the image need to be in images folder in mfa_menu
---@param hideTitle boolean hide title if is true
---@param centerTitle boolean center title is is true
---@param font string define the font of banniere
function Menu:banniere(image,showTitle,centerTitle,font)
    MenuManager.banniere(self.id,image,showTitle,centerTitle,font);
end

---Set the font menu, the basic fonts are that of webfonts:
---Arial
---Arial Black
---Verdana
---Tahoma
---Trebuchet MS
---Impact
---Times New Roman
---Didot
---Georgia
---American Typewriter
---Andalé Mono
---Courier
---Lucida Console
---Monaco
---Bradley Hand
---Brush Script MT
---Luminari
---Comic Sans MS
---https://blog.hubspot.com/website/web-safe-html-css-fonts
---@param id string id menu
---@param fontName string font name ex: Arial
function Menu:fontGlobalForMenu(fontName)
    MenuManager.fontGlobalForMenu(self.id,fontName);
end
---Create Checkbox
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param initialValue boolean define default value
---@param cbk function The callback function for the button called when Enter is pressed. the function received in param data => data.value contains true/false
function Menu:checkbox(leftLabel, leftIcon, description, initialValue, cbk)
    MenuManager.checkbox(self.id, leftLabel, leftIcon, description, initialValue, cbk)
end
---Create submenu button
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param rightIcon string define description for the current item menu
---@param submenu string id menu of the submenu
---@param cbk function The callback function for the button called when Enter is pressed
---@param isLock boolean Lock the submenu
-----
function Menu:buttonSubmenu(leftLabel, leftIcon, description, rightIcon,submenu, cbk,isLock)
    MenuManager.buttonSubmenu(self.id, leftLabel, leftIcon, description, rightIcon,submenu, cbk,isLock)
end
---Create listbox
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param data object the data in listbox ex {"test1","test2","test3"} or {1,2,3,4,5}
---@param cbk function The callback function for the button called when Enter is pressed.The function received in param data => data.value contains current value of selected in listbox
function Menu:listbox(leftLabel, leftIcon, description, data, cbk)

    MenuManager.listbox(self.id, leftLabel, leftIcon, description, data, cbk)
end


---Create Separator
---@param id string id menu
---@param label string label separator
---@param icon string icon separator
---@param enableLines boolean
function Menu:separator(id, label, icon,enableLines)
    MenuManager.separator(self.id, label, icon,enableLines)
end
---Create Progressbar
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param userCanInteract boolean define if user can change the value
---@param value number default value
---@param step number
---@param maxVal number
---
function Menu:progressbar(id, leftLabel, leftIcon, description, userCanInteract, value, step, maxVal, cbk)
    MenuManager.progressbar(self.id, leftLabel, leftIcon, description, userCanInteract, value, step, maxVal, cbk)

end

---Create Input
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param type string define type of input ("text"/"date"/"number")
---@param cbk function The callback function for the button called when Enter is pressed.The function received in param data => data.value contains the value
function Menu:input(id, leftLabel, leftIcon, description, type, cbk)
    MenuManager.input(self.id, leftLabel, leftIcon, description, type, cbk)

end
---Create Togggle
---@param id string id menu
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param initialValue boolean define default value
---@param cbk function The callback function for the button called when Enter is pressed. the function received in param data => data.value contains true/false
function Menu:toggle(id, leftLabel, leftIcon, description, initialValue, cbk)
    Menu:toggle(self.id, leftLabel, leftIcon, description, initialValue, cbk)
end

---remove all menu items from the specified index until the end
---@param id string id menu
---@param index number index
function Menu:clearMenuItem(id,index)
    MenuManager.clearMenuItem(self.id,index)
end

---open the specific menu
---@param id string id menu
function Menu:openMenu()
    MenuManager.openMenu(self.id);
end

---close menu
function Menu:closeMenu()
    MenuManager.closeMenu();
end

--- Check if the menu is visible the response come in callback.
function Menu:isVisible(cb)
    MenuManager.isVisible(self.id,cb);
end

--- Call when the menu is closed.
function Menu:onCloseMenu(cb)
    MenuManager.onCloseMenu(self.id,cb);
end
--- Change descrition content.
function Menu:changeDesc(content)
    MenuManager.changeDesc(self.id,content);
end
--- Change description content and show description
function Menu:changeDescAndShow(content)
    MenuManager.changeDescAndShow(self.id,content);
end

--- Refresh menu
function Menu:refresh()
    MenuManager.refresh(self.id);
end


