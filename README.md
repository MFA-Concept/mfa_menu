# mfa-menu
Library to create menus in FiveM using JS/HTML/CSS

Documentation
Installation du menu

Il faut la ressource mfa_menu dans le serveur, tous les menus créés avec la librairie sont générés à l'intérieur.
Ensuite il suffit de créer une ressource comme la ressource exemple mfa_menu_test.
Dans la ressource où l'on souhaite utiliser le menu MenuManager il faut ajouter dans le fxmanifest.

Pour le lua:

    client_script "@mfa_menu/dependency/menumanager.lua"



Pour le js:

    client_script "@mfa_menu/dependency/menumanager.js"



Création d'un menu

Il faut utiliser l'objet MenuManager présent dans le dossier dependency

    MenuManager.createMenu("test2","Titre Test","Subtitle",null)



Le 1er paramètre est un identifiant ici "test2" grâce à l'identifiant on pourra afficher/masquer/ajouter/modifier le menu
Le 2eme paramètre est le titre du menu
Le 3eme paramètre est le titre du subtitle

Création d'un sous-menu:

    MenuManager.createMenu("test3","Tesstt","TItrerTest","test2")



Ici on déclare "test3" qui est un sous-menu du menu "test2" avec le 4ème paramètres

Création d'item menu 

Pour la majorité des composants d'un menu les paramètres des fonctions sont souvent les mêmes.

    id = identifiant du menu
    leftLabel = le label de gauche
    leftIcon = icon de gauche 
    description = la description
    cbk = la fonction de callback relative a l'itemmenu


Icônes 

Les icônes proviennent de font awesome.
Exemple
<i class="fas fa-address-card"></i>



il suffit de prendre le contenu dans l'attribut class ici → fas fa-address-card

Exemple avec un bouton:

    MenuManager.button('menuId','labelLeft','fas fa-address-car','description','rightLabel','rightIcon',function() end);




Voici le lien de font awesome
https://fontawesome.com/v5.15/icons/

Le système de callback

Un callback est une fonction appelé en retour d'une action.
Pour le menu il s'agit de l'action comme appuyer sur la touche Enter ou la navigation ← → / à venir quand l'on rentre dans le boutton (hover)
Lors de la déclaration d'un item menu (button, progressbar, input, listbox, checkbox, toggle, etc) le dernier paramètre de la fonction est toujours un callback.

    MenuManager.button('menuId','label','fas fa-user','madescription','rightLabel','rightIcon',function(data) 
        if data.action == "onChange" then
            print("Appeler lors de l'utilisation des flèches du clavier ← →")
        elseif data.action == "onPressed" then
            print("On entre dans la condition quand la touche Enter est pressé")    
        elseif data.action == "onHover" then
            print("On entre dans la condition quand on rentre dans le bouton avec la navigation ↑↓")
        end
    end);




Exemple d'un input(Champ de saisi)
    MenuManager.input('menuId','labelLeft','fas fa-address-car','ma description','text',function(data) 
        print(data.value)
    end)


Sur les champs où l'on attend un retour on reçoit la valeur en appuyant sur la touche Enter, la valeur est contenue dans data.value.
Une information supplémentaire est portée par le paramètre data c'est le type d'action soit "change" (← →), soit "action" (Enter)

Les items avec navigation possible ← → (listbox, progressbar) :

    MenuManager.listbox('menuId','labelLeft','fas fa-address-car','ma description',{"test1","test2","test3"},function(data) 
    if data.action == "change" then -- pour la navigation ← →
        print(data.value)
    elseif data.action == "action" then -- pour la touche Enter
        print(data.value)
        end
    end)


⚠️ Il faut que la touche Choisir (téléphone) soit bien binder sur la touche ENTER
Absolute 

