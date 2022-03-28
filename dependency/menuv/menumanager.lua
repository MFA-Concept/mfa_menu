--------------------------------------------------------------------------------------------------------

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
--- Edited by TheFRcRaZy. 
--- Lib created for old MenuV user's

MfaMenus = {};
Menu = {};

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
--- @param d { id:string, title:string, subtitle:string, font:string, parent:string, centerTitle:boolean, showTitle:boolean, globalFont:sting, img:string }
function Menu:CreateMenu(d)
    if not d.id then 
        return print("[^4M^7F^1A ^7Menu] >> ^1Error: ^3menu id ^1not specified\n"..json.encode(d));
    end
    local o = {}
    self.__index = self;
    setmetatable(o,self);
    local c = { centerTitle = true, showTitle = true };
    if d.centerTitle == false then d.title = d.title.."ㅤ"; c.centerTitle = false end;
    if d.showTitle == false then c.showTitle = false end;
    o.id = d.id;
    o.title = d.title;
    o.subtitle = d.subtitle or "";
    o.parent = d.parent or "";
    addToPool(function() TriggerEvent("mfa_menu:createMenu",o.id,o.title,o.subtitle,o.parent) end);
    addToPool(function() TriggerEvent("mfa_menu:fontGlobalForMenu",o.id,d.globalFont or ""); end);
    addToPool(function() TriggerEvent("mfa_menu:banniere",o.id, d.img or "native.jpg",c.showTitle, c.centerTitle, d.font or ""); end);
    MfaMenus[d.id] = o;
    return o;
end

--- Set the Banner
--- @param d { title:string, img:string, centerTitle:boolean, showTitle:boolean, font:string }
function Menu:SetBanner(d)
    local c = { centerTitle = true, showTitle = true }
    local title = self.title or d.title
    if d.centerTitle == false then title = title.."ㅤ"; c.centerTitle = false end;
    if d.showTitle == false then c.showTitle = false end;
    addToPool(function() TriggerEvent("mfa_menu:banniere",self.id, d.img or "native.jpg",c.showTitle, c.centerTitle, d.font or ""); end);
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
--- @param fontName string font name ex: Arial
function Menu:SetGlobalFont(fontName)
    addToPool(function() TriggerEvent("mfa_menu:fontGlobalForMenu",self.id,fontName); end);
end


--- Change descrition content.
--- @param d { desc:string, show:boolean }
function Menu:ChangeDesc(d)
    addToPool(function()
        if not d.show then 
            addToPool(function() TriggerEvent("mfa_menu:changeDesc",self.id,d.desc or ""); end);
        else
            addToPool(function() TriggerEvent("mfa_menu:changeDescAndShow",self.id,d.desc or ""); end);
        end
    end);
end

---remove all menu items from the specified index until the end
--- @param index number index
function Menu:ClearItems(index)
    addToPool(function() TriggerEvent("mfa_menu:clearMenuItem",self.id,index); end);
end

--- Check if the menu is visible the response come in callback.
function Menu:IsVisible(cbk)
    addToPool(function() TriggerEvent("mfa_menu:isVisible",self.id,cbk); end);
end


--- Call when the menu is closed.
function Menu:onClose(cbk)
    local me = self
    addToPool(function()
        TriggerEvent("mfa_menu:onCloseMenu",self.id,function()
            if cbk then 
                cbk(me)
            end
        end);
    end);
end

function Menu:onOpen(cbk)
    local me = self
    self.isOpen = function()
        if cbk then 
            cbk(me);
        end
    end;
end

function Menu:onRefresh(cbk)
    local me = self
    self.isRefresh = function()
        if cbk then 
            cbk(me);
        end
    end;
end


---open the specific menu
function Menu:Open()
    Wait(1)
    self:GetNbItems(function(nbr)
        if nbr == 0 then 
            self:Separator({})
            SetTimeout(1, function()
                self:ClearItems()
            end)
        end
        addToPool(function() TriggerEvent("mfa_menu:select",self.id); end);
        Wait(1)
        if self.isOpen then 
            self.isOpen();
        end
    end)
end

---close the specific menu
function Menu:Close()
    local parent = MfaMenus[self.parent];
    addToPool(function() TriggerEvent("mfa_menu:select", nil); end);
    parent:Open()
end

--- Refresh menu
function Menu:Refresh()
    SetTimeout(100, function() 
        addToPool(function() TriggerEvent("mfa_menu:refresh",self.id); end);
        if self.isRefresh then 
            self.isRefresh();
        end
    end)
end


---Create Separator
--- @param d { label:string, animated:boolean, lines:boolean, icon:string }
function Menu:Separator(d)
    addToPool(function()
        if d.animated then 
            d.label = "marquee|"..d.label;
        end
        if d.icon then 
            d.label = d.label..' <i class="'..d.icon..'"></i>'
        end
        TriggerEvent("mfa_menu:separator",self.id, d.label or "", "", d.lines or false);
    end);
end


---Create Button
--- @param d { label:string, icon:string, desc:string, rLabel:string, rIcon:string, disabled:boolean, select:void, change:void, hover:void }
function Menu:AddButton(d)
    addToPool(function() 
        if d.rLabel then 
            if d.rIcon then 
                d.rLabel = d.rLabel..' <i class="'..d.rIcon..'"></i>'
            end
        end
        if d.value then 
            d.rIcon = "fa-duotone fa-arrow-right"
        end
        if d.disabled then 
            d.rIcon = "fa-duotone fa-lock"
        end
        TriggerEvent("mfa_menu:button",self.id, d.label or "", d.icon or "", d.desc or "", d.rLabel or "", d.rIcon or "", function(data)
            if not d.disabled then 
                print(data.action)
                if data.action == "onPressed" then 
                    if d.select then 
                        d.select(data.value)
                    end
                    if d.value then 
                        d.value:Open()
                    end
                end
                if data.action == "onChange" then 
                    if d.change then 
                        d.change(data.value)
                    end
                end
                if data.action == "onHover" then 
                    if d.hover then 
                        d.hover(data.value)
                    end
                end
            end
        end)
    end);
end



---Create Checkbox
--- @param d { label:string, icon:string, desc:string, value:boolean, disabled:boolean, select:void, change:void, hover:void }
function Menu:AddCheckbox(d)
    if d.disabled then 
        self:AddButton(d);
    else
        addToPool(function()
            TriggerEvent("mfa_menu:checkbox",self.id, d.label or "", d.icon or "", d.desc or "", d.value or false, function(data)
                if data.action == "onPressed" then 
                    if d.select then 
                        d.select(data.value)
                    end
                end
                if data.action == "onChange" then 
                    if d.change then 
                        d.change(data.value)
                    end
                end
                if data.action == "onHover" then 
                    if d.hover then 
                        d.hover(data.value)
                    end
                end
            end)
        end)
    end;
end


---Create Togggle
--- @param d { label:string, icon:string, desc:string, value:boolean, disabled:boolean, select:void, change:void, hover:void }
function Menu:AddToggle(d)
    if d.disabled then 
        self:AddButton(d);
    else
        addToPool(function()
            TriggerEvent("mfa_menu:toggle",self.id, d.label or "", d.icon or "", d.desc or "", d.value, function(data)
                if data.action == "onPressed" then 
                    if d.select then 
                        d.select(data.value)
                    end
                end
                if data.action == "onChange" then 
                    if d.change then 
                        d.change(data.value)
                    end
                end
                if data.action == "onHover" then 
                    if d.hover then 
                        d.hover(data.value)
                    end
                end
            end)
        end)
    end;
end



---Create Progressbar
--- @param d { label:string, icon:string, desc:string, disabled:boolean, val:number, step:number, maxVal:number, select:void, change:void, hover:void }
function Menu:AddProgressbar(d)
    if d.disabled then 
        self:AddButton(d);
    else
        addToPool(function()
            TriggerEvent("mfa_menu:progressbar",self.id, d.label or "", d.icon or "", d.desc or "", d.interact or true, d.val or 0, d.step or 1, d.maxVal or 100, function(data)
                if data.action == "onPressed" then 
                    if d.select then 
                        d.select(data.value)
                    end
                end
                if data.action == "onChange" then 
                    if d.change then 
                        d.change(data.value)
                    end
                end
                if data.action == "onHover" then 
                    if d.hover then 
                        d.hover(data.value)
                    end
                end
            end)
        end)
    end;
end

---Create listbox
--- @param d { label:string, icon:string, desc:string, disabled:boolean, values:object, select:void, change:void, hover:void }
function Menu:AddSlider(d)
    if d.disabled then 
        self:AddButton(d);
    else
        addToPool(function()
            TriggerEvent("mfa_menu:listbox",self.id, d.label or "", d.icon or "", d.desc or "", d.values or "", function(data)
                if data.action == "onPressed" then 
                    if d.select then 
                        d.select(data.value)
                    end
                end
                if data.action == "onChange" then 
                    if d.change then 
                        d.change(data.value)
                    end
                end
                if data.action == "onHover" then 
                    if d.hover then 
                        d.hover(data.value)
                    end
                end
            end)
        end)
    end;
end

---Create Input
---@param d { label:string, icon:string, desc:string, type:string, disabled:boolean, select:void, change:void, hover:void }
function Menu:AddInput(d)
    if d.disabled then 
        self:AddButton(d);
    else
        addToPool(function()
            TriggerEvent("mfa_menu:input",self.id, d.label or "", d.icon or "", d.desc or "", d.type or "text", function(data)
                if data.action == "onPressed" then 
                    if d.select then 
                        d.select(data.value)
                    end
                end
                if data.action == "onChange" then 
                    if d.change then 
                        d.change(data.value)
                    end
                end
                if data.action == "onHover" then 
                    if d.hover then 
                        d.hover(data.value)
                    end
                end
            end)
        end)
    end;
end

function Menu:ToggleMenu()
    self:IsVisible(function(value)
        if not value then 
            self:Open();
        else
            self:Close();
        end
    end)
end

--- Register New KeyMapping
--- @param d { key:string, desc:string, opened:void }
function Menu:KeyMap(d)
    if not d.key then 
        return print("[^4M^7F^1A ^7Menu] >> ^1Error: register ^3key menu ^1not defined\n"..json.encode(d));
    elseif not d.desc then 
        return print("[^4M^7F^1A ^7Menu] >> ^1Error: register ^3desc menu ^1not defined\n"..json.encode(d));
    end
    addToPool(function()
        RegisterCommand("mfa_menu"..self.id, function()
            if not IsPauseMenuActive() then
                if d.opened then 
                    local me = self
                    d.opened(me);
                end
                self:ToggleMenu();
            end
        end)
        RegisterKeyMapping("mfa_menu"..self.id, d.desc, 'keyboard', d.key);
    end)
end


--- @param newTitle string
function Menu:SetTitle(newTitle)
    if newTitle == "" or newTitle == nil then 
        newTitle = self.title
    end
    addToPool(function() TriggerEvent("mfa_menu:changeTitle",self.id,newTitle); end);
end

--- @param newSubTitle string
function Menu:SetSubtitle(newSubtitle)
    if newSubtitle == "" or newSubtitle == nil then 
        newSubtitle = self.subTitle
    end
    addToPool(function() TriggerEvent("mfa_menu:changeSubtitle",self.id,newSubtitle); end);
end

function Menu:GetNbItems(cbk)
    addToPool(function() TriggerEvent("mfa_menu:getNbItems",self.id,cbk); end);
end

function Menu:GetCurrentIndex(cbk)
    addToPool(function() TriggerEvent("mfa_menu:getCurrentIndex",self.id,cbk); end);
end







function Menu:CloseAll()
    addToPool(function() TriggerEvent("mfa_menu:select", nil); end);
end

function Menu:ChangeNumberMaxItemByMenu(number)
    addToPool(function() TriggerEvent("mfa_menu:changeNumberMaxItemByMenu",number); end);
end

Menu:ChangeNumberMaxItemByMenu(9) -- 11 for menuv like  css style