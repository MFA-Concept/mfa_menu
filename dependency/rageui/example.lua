local test = Menu:createMenu("Mon titre", "Sous titre 1", "mfa_banniere.jpg", nil, nil, nil, true, false)
local SubmenuTest = Menu:createMenu("Mon titre Sub", "Sous titre 2", "mfa_banniere.jpg", test)
local checked = false

test.menu = function()
    test:separator("Mon Separator", nil, false, true)
    test:button("Mon button standard", "", "Ma description", "Mon rightlabel", "", function(Hovered, Selected)
        if Hovered then
            print("Je suis sur mon button")
        end
        if (Selected) then
            print("J'ai cliqué sur mon button")
        end
    end)
    test:button("Mon button Submenu", "", "Ma description", "Mon rightlabel", nil, function(Hovered, Selected)
        if Hovered then
            print("Je suis sur mon button")
        end
        if (Selected) then
            print("J'ai cliqué sur mon button")
            --J'appel la function de mon sous menu:
        end
    end, SubmenuTest, false)
    test:listbox("Ma listbox", "", "Ma description", {"Absolute", "JustGod", "Et l'autre"}, function(Hovered, Selected, onChange, index)
        if Selected then
            if index == "Absolute" then
                print("Il sais pas dev")
            elseif index == "JustGod" then
                print("C'est un beau gosse")
            elseif index == "Et l'autre" then
                print("C'est JL Power askip")
            end
        end
    end)
    test:checkbox("Ma checkbox", "", "Ma description", checked, function(Hovered, Selected, val)
        if Selected then
            if val then
                checked = val
                print("Checked")
            else
                checked = val
                print("UnChecked")
            end
            test:reload()
        end
    end, SubmenuTest)
    if checked then
        test:line()
    end
    test:input("Mon input", "", "", "text", function(Hovered, Selected, inputCallback)
        if Selected then
            print("J'ai écrit: "..inputCallback)
            test:changeDesc("J'ai écrit: "..inputCallback, true)
            test:reload() --Je rappel ma fonction pour rafraichir le menu
        end
    end)
    test:button("Mon button Keyboard input", "", "Ma description", "Mon rightlabel", "", function(Hovered, Selected)
        if Hovered then
            print("Je suis sur mon button")
        end
        if (Selected) then
            local montext = Menu:KeyboardInput("Ecrire du text", "", "", 10)
            test:changeDesc("J'ai écrit: "..montext, true)
            print("J'ai cliqué sur mon button")
        end
    end)
    test:progressbar("Ma progress bar", "", "Ma description", true, 0, 10, 100, function(Hovered, Selected, onChange,ActualValue)
        if Selected then
            print("Valeur actuel: "..ActualValue)
            test:changeDesc("Valeur actuel: "..ActualValue, true)
        end
    end)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        test:progressbar("Niveau d'essence", "", "Ma description", false, GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(), false)), 10, 100, function(Hovered, Selected, onChange,ActualValue)
            if Selected then
                print("Niveau d'essence: "..ActualValue.."%")
                test:changeDesc("Niveau d'essence: "..ActualValue.."%", true)
            end
        end)
    end
    test:refresh()
end

SubmenuTest.menu = function()
    SubmenuTest:clearMenuItem(0)
    SubmenuTest:separator("Mon Separator Sous Menu")
    SubmenuTest:button("Mon button standard", "", "Ma descritption Sous Menu", "Mon rightlabel", "", function(Hovered, Selected)
        if Hovered then
            print("Je suis sur mon button")
        end
        if Selected then
            print("J'ai cliqué sur mon button")
        end
    end)
end

AddEventHandler("gameEventTriggered", function(name)
    if name == "CEventNetworkPlayerEnteredVehicle" then
        test:isVisible(function(visible)
            if visible then
                test:reload()
                CreateThread(function()
                   while true do
                    Wait(250)
                    if not IsPedInAnyVehicle(PlayerPedId(), false) then
                        test:reload()
                        break
                    end
                   end
                end)
            end
        end)
    end
end)

test:keyMap("F5", "i", "Ouvrir le menu test MFA Concept")
