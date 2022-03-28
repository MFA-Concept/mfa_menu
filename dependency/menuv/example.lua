--   __  __                      
--  |  \/  |                     
--  | \  / | ___ _ __  _   _ ___ 
--  | |\/| |/ _ \ '_ \| | | / __|
--  | |  | |  __/ | | | |_| \__ \
--  |_|  |_|\___|_| |_|\__,_|___/
                              
                              

MAIN_MENU = Menu:CreateMenu({ 
    id = "main_menu",
    title = "My Title",
    subtitle = "This is subtitle",
    font = "Impact", -- For title
    -- parent = "main_menu",
    centerTitle = false,
    -- showTitle = false,
    globalFont = "Monaco", -- for menu items
    img = "dreamv.jpg"
})

SUB_MENU = Menu:CreateMenu({
    id = "sub_menu",
    title = "My Sub Menu",
    subtitle = "This Is Second Menu",
    parent = MAIN_MENU.id
})


--   _  __          __  __             
--  | |/ /         |  \/  |            
--  | ' / ___ _   _| \  / | __ _ _ __  
--  |  < / _ \ | | | |\/| |/ _` | '_ \ 
--  | . \  __/ |_| | |  | | (_| | |_) |
--  |_|\_\___|\__, |_|  |_|\__,_| .__/ 
--             __/ |            | |    
--            |___/             |_|    

MAIN_MENU:KeyMap({ key = "f7", desc = "Open Menu Test (MFA)" })

-- MAIN_MENU:KeyMap({ key = "f7", desc = "Open Menu Test (MFA)", opened = function()
    
-- end})


--    _____                            _             
--   / ____|                          | |            
--  | (___   ___ _ __   __ _ _ __ __ _| |_ ___  _ __ 
--   \___ \ / _ \ '_ \ / _` | '__/ _` | __/ _ \| '__|
--   ____) |  __/ |_) | (_| | | | (_| | || (_) | |   
--  |_____/ \___| .__/ \__,_|_|  \__,_|\__\___/|_|   
--              | |                                  
--              |_|                                  

MAIN_MENU:Separator({ -- first separator
    label = "My Separator",
    animated = true,
    lines = false,
    icon = "fa-duotone fa-rectangle-code"
})

MAIN_MENU:Separator({ lines = true }) -- second separator


MAIN_MENU:Separator({})


--   ____        _   _              
--  |  _ \      | | | |             
--  | |_) |_   _| |_| |_ ___  _ __  
--  |  _ <| | | | __| __/ _ \| '_ \ 
--  | |_) | |_| | |_| || (_) | | | |
--  |____/ \__,_|\__|\__\___/|_| |_|
                                 

MAIN_MENU:AddButton({ 
    label = "My Standard Button",
    icon = "fa-duotone fa-rectangle-code",
    desc = "This is a description Bro !!",
    rLabel = "Hey !!",
    rIcon = "fa-duotone fa-rectangle-code",
    disabled = false,
    select = function(value)
        print("select")
    end,
    change = function(value)
        print("change")
    end,
    hover = function(value)
        print("hover")
    end,
})

MAIN_MENU:AddButton({
    label = "Open Color Menu",
    desc = "Color Menu Is SubMenu",
    value = SUB_MENU
})
MAIN_MENU:AddButton({
    label = "Simple Button",
    select = function(value)
        print("select")
    end
})

MAIN_MENU:AddButton({
    label = "Simple Button",
    disabled = true,
    select = function(value)
        print("select")
    end
})


MAIN_MENU:Separator({})

--    _____ _ _     _           
--   / ____| (_)   | |          
--  | (___ | |_  __| | ___ _ __ 
--   \___ \| | |/ _` |/ _ \ '__|
--   ____) | | | (_| |  __/ |   
--  |_____/|_|_|\__,_|\___|_|   
                             
MAIN_MENU:AddSlider({
    label = "My Slider",
    icon = "fa-duotone fa-rectangle-code",
    desc = "My description",
    disabled = false,
    values = {"Absolute", "JustGod", "TheFRcRaZy"},
    select = function(value)
        print("select")
    end,
    change = function(value)
        print("change")
    end,
    hover = function(value)
        print("hover")
    end,
})


local dataNumbers = {}
for i=1, 57 do 
    table.insert(dataNumbers, { label = tostring(i), value = tostring(i) })
end

MAIN_MENU:AddSlider({
    label = "Slider Numbers",
    values = dataNumbers,
    disabled = true,
    select = function(data)
        print("select", tonumber(data.value))
    end,
})

MAIN_MENU:AddSlider({
    label = "Choice Banner",
    values = {
        { label = "247", img = "247.jpg", centerTitle = true, showTitle = true, font = "Impact" },
        { label = "French Flags", img = "french_flags.jpg", centerTitle = true, showTitle = true, font = "Monaco" },
        { label = "LTD", img = "ltd.jpg", centerTitle = true, showTitle = false, font = "Impact" },
        { label = "Mfa Banner", img = "mfa_banniere.jpg", centerTitle = false, font = "Monace" },
    },
    change = function(data)
        print()
        print("change to", data.label)
        print(data.img)
        print(data.centerTitle)
        print(data.showTitle)
        MAIN_MENU:SetBanner(data)
        -- MAIN_MENU:SetBanner({
        --     title = data.label,
        --     img = data.img,
        --     centerTitle = data.centerTitle,
        --     showTitle = data.showTitle,
        --     font = data.font
        -- })
    end,
})

MAIN_MENU:AddSlider({ label = "Slider Color", values = {
    { label = "color:red", color = "red" },
    { label = "color:green", color = "green" },
    { label = "color:blue", color = "blue" }
}, select = function(data)
    print(data.color)
end})

MAIN_MENU:Separator({})

--    _____ _               _    ____            
--   / ____| |             | |  |  _ \           
--  | |    | |__   ___  ___| | _| |_) | _____  __
--  | |    | '_ \ / _ \/ __| |/ /  _ < / _ \ \/ /
--  | |____| | | |  __/ (__|   <| |_) | (_) >  < 
--   \_____|_| |_|\___|\___|_|\_\____/ \___/_/\_\
                                              

MAIN_MENU:AddCheckbox({
    label = "My CheckBox",
    icon = "fa-duotone fa-rectangle-code",
    desc = "My description",
    value = false,
    select = function(value)
        print("select")
    end,
    change = function(value)
        print("change")
    end,
    hover = function(value)
        print("hover")
    end,
})

MAIN_MENU:AddCheckbox({
    label = "GodMod",
    value = true,
    disabled = true,
    select = function(value)
        print("select")
    end,
})




MAIN_MENU:Separator({})

--   _____                   _   
--  |_   _|                 | |  
--    | |  _ __  _ __  _   _| |_ 
--    | | | '_ \| '_ \| | | | __|
--   _| |_| | | | |_) | |_| | |_ 
--  |_____|_| |_| .__/ \__,_|\__|
--              | |              
--              |_|              

MAIN_MENU:AddInput({
    label = "Input Color",
    icon = "fa-duotone fa-rectangle-code",
    desc = "My description",
    type = "color",
    disabled = false,
    select = function(value)
        print("select", value)
    end,
    change = function(value)
        print("change")
    end,
    hover = function(value)
        print("hover")
    end,
})

MAIN_MENU:AddInput({
    label = "Input Text",
    desc = "For Change Title",
    disabled = true,
    select = function(value)
        MAIN_MENU:SetTitle(value)
    end
})

MAIN_MENU:AddInput({
    label = "Input Data",
    type = "date",
    select = function(value)
        MAIN_MENU:SetSubtitle(value)
    end
})


MAIN_MENU:Separator({})



--   _____                                   _                
--  |  __ \                                 | |               
--  | |__) | __ ___   __ _ _ __ ___  ___ ___| |__   __ _ _ __ 
--  |  ___/ '__/ _ \ / _` | '__/ _ \/ __/ __| '_ \ / _` | '__|
--  | |   | | | (_) | (_| | | |  __/\__ \__ \ |_) | (_| | |   
--  |_|   |_|  \___/ \__, |_|  \___||___/___/_.__/ \__,_|_|   
--                    __/ |                                   
--                   |___/                                    
MAIN_MENU:AddProgressbar({
    label = "ProgressBar",
    icon = "fa-duotone fa-rectangle-code",
    desc = "My description",
    disabled = false,
    val = 0,
    step = 10,
    maxVal = 100,
    select = function(value)
        print("select", value)
    end,
    change = function(value)
        print("change")
    end,
    hover = function(value)
        print("hover")
    end,
})


MAIN_MENU:AddProgressbar({
    label = "Second",
    disabled = true,
    val = 0,
    step = 10,
    maxVal = 100,
    change = function(value)
        print("change", value)
    end,
})



--    _____       _       __  __                  
--   / ____|     | |     |  \/  |                 
--  | (___  _   _| |__   | \  / | ___ _ __  _   _ 
--   \___ \| | | | '_ \  | |\/| |/ _ \ '_ \| | | |
--   ____) | |_| | |_) | | |  | |  __/ | | | |_| |
--  |_____/ \__,_|_.__/  |_|  |_|\___|_| |_|\__,_|
                                               
                                               

SUB_MENU:onOpen(function(m)
    print("SubMenu Open")
    m:ClearItems()
    RefreshSubMenu(m)
end)

SUB_MENU:onRefresh(function(m)
    print("SubMenu Refresh")
    m:Separator({ lines = true })
    m:AddButton({ label = "Mfa Menu Is Good", desc = {
        type = "natifbar",
        data = {
            { label = "Absolute", value = 80 },
            { label = "JustGod", value = 10 },
            { label = "TheFRcRaZy", value = 10 },
        },
    }})
    m:ChangeDesc({ desc = "Mfa Menu Is Good", show = true })
end)

SUB_MENU:onClose(function(m)
    print("SubMenu Close")
end)

function RefreshSubMenu(m)
    m:AddButton({ label = "Close Menu", select = function()
       m:Close();
    end})

    m:AddButton({ label = "Close All Menu", select = function()
        -- m:CloseAll();
        -- or
        Menu:CloseAll();
    end})

    m:AddButton({ label = "Refresh Menu", select = function()
        m:Refresh();
    end})
end