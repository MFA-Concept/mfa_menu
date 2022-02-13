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

MfaMenus = {};
Menu = {};

Menu.random = math.random
function Menu.uuid()
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and Menu.random(0, 0xf) or Menu.random(8, 0xb)
        return string.format('%x', v)
    end)
end

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

checkPools()

function addToPool(cb)
    if not mfaMenuIsEnable then
        table.insert(pools,cb);
    else
       cb();
    end
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

--- Create Menu Or Submenu, for create a submenu you just need to specify parent id.
--- @param id string id menu
--- @param title string title menu
--- @param subtitle string subtitle menu
--- @param image string
--- @param parent string parent id
--- @param titleFont string
--- @param globalFont string
--- @param showTitle boolean
--- @param centerTitle boolean
function Menu:createMenu(title,subtitle, image, parent, titleFont, globalFont, showTitle, centerTitle)
    local o = {}
    self.__index = self;
    setmetatable(o,self);
    local c = { centerTitle = true, showTitle = true }
    if centerTitle == false then title = title.."ㅤ"; c.centerTitle = false end
    if showTitle == false then c.showTitle = false end
    o.id = Menu.uuid()
    o.title = title
    o.subtitle = subtitle;
    o.parent = parent;
    o.data = json.encode(o)
    if parent == nil then
        addToPool(function() TriggerEvent("mfa_menu:createMenu",o.id, o.title, o.subtitle) end)
    else
        addToPool(function() TriggerEvent("mfa_menu:createMenu",o.id, o.title, o.subtitle, parent.id) end)
    end
    addToPool(function() TriggerEvent("mfa_menu:fontGlobalForMenu", o.id, globalFont or "Cologne 1960") end)
    addToPool(function() TriggerEvent("mfa_menu:onCloseMenu", o.id,function()
    end) end)
    addToPool(function() TriggerEvent("mfa_menu:banniere", o.id, image, c.showTitle, c.centerTitle, titleFont or nil) end)
    return o;
end

---Create Button
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param rightLabel string define right label
---@param rightIcon string define right icon font awesome ex: "fas fa-user"
---@param cbk function The callback function for the button called when Enter is pressed
function Menu:button(leftLabel, leftIcon, description, rightLabel, rightIcon, cb, submenu, isLock)
    if submenu == nil then
        addToPool(function() TriggerEvent("mfa_menu:button", self.id, leftLabel, leftIcon, description, rightLabel, rightIcon, function(data)
            if cb then cb(data.action == "onHover", data.action == "onPressed", data.value) end end)
        end)
    else
        addToPool(function() TriggerEvent("mfa_menu:buttonSubmenu", self.id, leftLabel, leftIcon, description, rightIcon or "fa-solid fa-right-from-bracket", submenu.id,function(data)
                if cb then cb(data.action == "onHover", data.action == "onPressed", data.value) end 
                if data.action == "onPressed" then
                    submenu:clearMenuItem(0)
                    submenu:menu()
                end
            end, isLock or false) 
        end)
    end
end

---Create Checkbox
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param initialValue boolean define default value
---@param cbk function The callback function for the button called when Enter is pressed. the function received in param data => data.value contains true/false
function Menu:checkbox(leftLabel, leftIcon, description, initialValue, cb)
    local value = false
    addToPool(function() TriggerEvent("mfa_menu:checkbox", self.id, leftLabel, leftIcon, description, initialValue, function(data)
            cb(data.action == "onHover", data.action == "onPressed", data.value)
        end) 
    end)
end

---Create listbox
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param data object the data in listbox ex {"test1","test2","test3"} or {1,2,3,4,5}
---@param cbk function The callback function for the button called when Enter is pressed.The function received in param data => data.value contains current value of selected in listbox
function Menu:listbox(leftLabel, leftIcon, description, data, cb)
    addToPool(function() TriggerEvent("mfa_menu:listbox", self.id, leftLabel, leftIcon, description, data, function(data)
        cb(data.action == "onHover", data.action == "onPressed", data.action == "onChange", data.value) end)
    end)
end


---Create Separator
---@param label string label separator
---@param icon string icon separator
---@param enableLines boolean
function Menu:separator(label, icon,enableLines, animated)
    if animated then 
        label = "marquee|"..label
    end
    addToPool(function() TriggerEvent("mfa_menu:separator",self.id, label or "", icon or "", enableLines or false) end)
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
function Menu:progressbar(leftLabel, leftIcon, description, userCanInteract, value, step, maxVal, cb)
    addToPool(function() TriggerEvent("mfa_menu:progressbar", self.id, leftLabel, leftIcon, description, userCanInteract, value, step, maxVal, function(data)
        cb(data.action == "onHover", data.action == "onPressed", data.action == "onChange", data.value) end)
    end)
end

---Create Input
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param type string define type of input ("text"/"date"/"number")
---@param cbk function The callback function for the button called when Enter is pressed.The function received in param data => data.value contains the value
function Menu:input(leftLabel, leftIcon, description, type, cb)
    addToPool(function() TriggerEvent("mfa_menu:input", self.id, leftLabel, leftIcon, description, type, function(data)
        cb(data.action == "onHover", data.action == "onPressed", data.value) end)
    end)
end
---Create Togggle
---@param leftLabel string define left label
---@param leftIcon string define left icon font awesome ex: "fas fa-user"
---@param description string|object define description for the current item menu
---@param initialValue boolean define default value
---@param cbk function The callback function for the button called when Enter is pressed. the function received in param data => data.value contains true/false
function Menu:toggle(leftLabel, leftIcon, description, initialValue, cb)
    addToPool(function() TriggerEvent("mfa_menu:toggle",self.id, leftLabel, leftIcon, description, initialValue, function(data)
        cb(data.action == "onHover", data.action == "onPressed", data.value) end)
    end)
end

---remove all menu items from the specified index until the end
---@param index number index
function Menu:clearMenuItem(index)
    addToPool(function() TriggerEvent("mfa_menu:clearMenuItem", self.id,index) end)
end

function Menu:keyMap(key, desc, cbOnOpen, cbOnClose)
    RegisterCommand(self.id.."_MFA_Concept", function(source, args, rawCommand)
        self:toggleMenu(cbOnOpen, cbOnClose)
    end)
    RegisterKeyMapping(self.id.."_MFA_Concept", desc, "keyboard", key)
end

function Menu:registerCommand(name, cb)
    RegisterCommand(name, function(source, args, rawCommand)
        local argsconcat = table.concat(args, " ")
        cb(argsconcat)
    end)
end

function Menu:toggleMenu(cbOnOpen, cbOnClose)
    self:isVisible(function(visible)
        if visible then
            if cbOnClose ~= nil then
                cbOnClose()
            end
            Menu:closeMenu()
        else
            if cbOnOpen ~= nil then
                cbOnOpen()
            end
            self:clearMenuItem(0)
            self:menu()
            addToPool(function() TriggerEvent("mfa_menu:select",self.id) end)
        end
    end)
end

---open the specific menu
function Menu:openMenu()
    self:isVisible(function(visible)
        if not visible then
            self:clearMenuItem(0)
            self:menu()
            addToPool(function() TriggerEvent("mfa_menu:select",self.id) end)
        end
    end)
end

function Menu:reload()
    self:clearMenuItem(0)
    self:menu()
    self:refresh()
end

---close menu
function Menu:closeMenu()
    addToPool(function() TriggerEvent("mfa_menu:select",null) end)
end

--- Check if the menu is visible the response come in callback.
function Menu:isVisible(cb)
    addToPool(function() TriggerEvent("mfa_menu:isVisible",self.id,cb); end);
end

--- Call when the menu is closed.
function Menu:onCloseMenu(cb)
    TriggerEvent("mfa_menu:onCloseMenu",self.id, function()
        cb()
    end)
end
--- Change descrition content.
function Menu:changeDesc(content, show)
    addToPool(function()
        if not show then 
            addToPool(function() TriggerEvent("mfa_menu:changeDesc",self.id, content) end)
        else
            addToPool(function() TriggerEvent("mfa_menu:changeDescAndShow",self.id, content) end)
        end
    end)
end

--- Refresh menu
function Menu:refresh()
    addToPool(function() TriggerEvent("mfa_menu:refresh",self.id) end)
end

function Menu.KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end

function Menu:getNbItems(cb)
    addToPool(function() TriggerEvent("mfa_menu:getNbItems",self.id,cb); end);
end

function Menu.changeNumberMaxItemByMenu(number)
    addToPool(function() TriggerEvent("mfa_menu:changeNumberMaxItemByMenu",number); end);
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

Menu.ShowHelpNotification = function(msg, thisFrame, beep, duration)
    AddTextEntry('mfaHelpNotification', msg)

    if thisFrame then
        DisplayHelpTextThisFrame('mfaHelpNotification', false)
    else
        if beep == nil then
            beep = true
        end
        BeginTextCommandDisplayHelp('mfaHelpNotification')
        EndTextCommandDisplayHelp(0, false, beep, duration or -1)
    end
end

---@param msg string
Menu.ShowNotification = function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(0,1)
end

RegisterNetEvent('shownotification')
AddEventHandler('shownotification', function(message)
    Menu.ShowNotification(message)
end)

---AdvancedNotification

---@param sender string
---@param subject string
---@param msg string
---@param textureDict string
---@param iconType number
---@param flash boolean
---@param saveToBrief boolean
---@param hudColorIndex number
Menu.ShowAdvancedNotification = function(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
    if saveToBrief == nil then
        saveToBrief = true
    end
    AddTextEntry('mfaAdvancedNotification', msg)
    BeginTextCommandThefeedPost('mfaAdvancedNotification')
    if hudColorIndex then
        ThefeedNextPostBackgroundColor(hudColorIndex)
    end
    EndTextCommandThefeedPostMessagetext(textureDict or "CHAR_MFA", textureDict or "CHAR_MFA", false, iconType or 1, sender or "MFA Concept", subject or "mfa_menu")
    EndTextCommandThefeedPostTicker(flash, saveToBrief)
end

RegisterNetEvent('showadvancednotification')
AddEventHandler('showadvancednotification', function(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
    Menu.ShowAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
end)
