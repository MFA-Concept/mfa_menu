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

function caution()
    if MenuManager == nil then
        MenuManager = {}
        print("^1Vous devez start le 'dependency/menumanager.lua' avant !")
    else 
        return
    end

end

caution()

MfaMenus = {};
Menu = {};

--- Create Menu Or Submenu, for create a submenu you just need to specify parent id.
--- @param id string id menu
--- @param title string title menu
--- @param subtitle string subtitle menu
--- @param parent string parent id
function Menu:createMenu(id,title,subtitle,parent)
    local o = {}
    self.__index = self;
    setmetatable(o,self);
    o.id = id;
    o.title = title;
    o.subtitle = subtitle;
    o.parent = parent;
    MenuManager.createMenu(o.id, o.title, o.subtitle, o.parent);
    return o;
end

---Create Button
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
---@param fontName string font name ex: Arial
function Menu:fontGlobalForMenu(fontName)
    MenuManager.fontGlobalForMenu(self.id,fontName);
end
---Create Checkbox
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param initialValue boolean define default value
---@param cbk function The callback function for the button called when Enter is pressed. the function received in param data => data.value contains true/false
function Menu:checkbox(leftLabel, leftIcon, description, initialValue, cbk)
    MenuManager.checkbox(self.id, leftLabel, leftIcon, description, initialValue, cbk)
end
---Create submenu button
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
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param data object the data in listbox ex {"test1","test2","test3"} or {1,2,3,4,5}
---@param cbk function The callback function for the button called when Enter is pressed.The function received in param data => data.value contains current value of selected in listbox
function Menu:listbox(leftLabel, leftIcon, description, data, cbk)
    MenuManager.listbox(self.id, leftLabel, leftIcon, description, data, cbk)
end


---Create Separator
---@param label string label separator
---@param icon string icon separator
---@param enableLines boolean
function Menu:separator(label, icon,enableLines)
    MenuManager.separator(self.id, label, icon,enableLines)
end
---Create Progressbar
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param userCanInteract boolean define if user can change the value
---@param value number default value
---@param step number
---@param maxVal number
---
function Menu:progressbar(leftLabel, leftIcon, description, userCanInteract, value, step, maxVal, cbk)
    MenuManager.progressbar(self.id, leftLabel, leftIcon, description, userCanInteract, value, step, maxVal, cbk)
end

---Create Input
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param type string define type of input ("text"/"date"/"number")
---@param cbk function The callback function for the button called when Enter is pressed.The function received in param data => data.value contains the value
function Menu:input(leftLabel, leftIcon, description, type, cbk)
    MenuManager.input(self.id, leftLabel, leftIcon, description, type, cbk)
end
---Create Togggle
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param initialValue boolean define default value
---@param cbk function The callback function for the button called when Enter is pressed. the function received in param data => data.value contains true/false
function Menu:toggle(leftLabel, leftIcon, description, initialValue, cbk)
    Menu:toggle(self.id, leftLabel, leftIcon, description, initialValue, cbk)
end

---remove all menu items from the specified index until the end
---@param index number index
function Menu:clearMenuItem(index)
    MenuManager.clearMenuItem(self.id,index)
end

---open the specific menu
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

function Menu:getNbItems(cb)
    addToPool(function() TriggerEvent("mfa_menu:getNbItems",self.id,cb); end);
end

function Menu:changeTitle(title)
    addToPool(function() TriggerEvent("mfa_menu:changeTitle",self.id,title); end);
end

function Menu:changeSubtitle(subtitle)
    addToPool(function() TriggerEvent("mfa_menu:changeSubtitle",self.id,subtitle); end);
end

function Menu:getCurrentIndex(cb)
    addToPool(function() TriggerEvent("mfa_menu:getCurrentIndex",self.id,cb); end);
end