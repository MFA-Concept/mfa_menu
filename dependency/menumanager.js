/**
 * MenuManager for js usage.
 * @author Absolute.
 */

MenuManager = {};

pools = {};

mfaMenuIsEnable = false;

function clearPool() {
    for (key in pools){
        pools[key]();
    }
}

function checkPools(){
    if(!mfaMenuIsEnable){
        TriggerEvent("mfa_menu:isEnabled", ()=> { mfaMenuIsEnable = true; clearPool(); })
        setTimeout(500,() => checkPools());
    }
}

checkPools();

function addToPool(cb){
    if (! mfaMenuIsEnable) {
        table.insert(pools,cb);
    }else{
        cb();
    }
}



/**
 * Create menu
 * @param id
 * @param title
 * @param subtitle
 * @param parent
 */
MenuManager.createMenu = (id,title,subtitle,parent) => {
    addToPool(() => emit("mfa_menu:createMenu",id,title,subtitle,parent));
}
/**
 * Create button.
 * @param id
 * @param leftLabel
 * @param leftIcon
 * @param description
 * @param rightLabel
 * @param rightIcon
 * @param cbk
 */
MenuManager.button = (id, leftLabel, leftIcon, description, rightLabel, rightIcon, cbk) => {
    addToPool(() => emit("mfa_menu:button", id, leftLabel, leftIcon, description, rightLabel, rightIcon, cbk));
}

MenuManager.banniere = (id,image,hideTitle,centerTitle) => {
    addToPool(() => emit("mfa_menu:baniere",id,image,hideTitle,centerTitle));
}

/**
 * Create checkbox.
 * @param id
 * @param leftLabel
 * @param leftIcon
 * @param description
 * @param initialValue
 * @param cbk
 */
MenuManager.checkbox = (id, leftLabel, leftIcon, description, initialValue, cbk) =>{
    addToPool(() => emit("mfa_menu:checkbox",id, leftLabel, leftIcon, description, initialValue, cbk));
}
/**
 *
 * @param id
 * @param leftLabel
 * @param leftIcon
 * @param description
 * @param submenu
 * @param cbk
 */
MenuManager.buttonSubmenu = (id, leftLabel, leftIcon, description, submenu, cbk) => {
    addToPool(() =>  emit("mfa_menu:buttonSubmenu",id, leftLabel, leftIcon, description, submenu, cbk));
}

MenuManager.listbox = (id, leftLabel, leftIcon, description, data, cbk) =>{
    addToPool(() => emit("mfa_menu:listbox",id, leftLabel, leftIcon, description, data, cbk));}


MenuManager.separator = (id, leftLabel, leftIcon,enableLines) => {
    addToPool(() => emit("mfa_menu:separator",id, leftLabel, leftIcon,enableLines));
}

MenuManager.progressbar = (id, leftLabel, leftIcon, description, userCanInteract, value, step, maxVal, cbk) => {
    addToPool(() => emit("mfa_menu:progressbar",id, leftLabel, leftIcon, description, userCanInteract, value, step, maxVal, cbk))
}

MenuManager.input = (id, leftLabel, leftIcon, description, typ, cbk) => {
    addToPool(() => emit("mfa_menu:input",id, leftLabel, leftIcon));
}

MenuManager.banniere = (id,image,hideTitle,centerTitle,font)=>{
    addToPool(() => emit("mfa_menu:banniere",id,image,hideTitle,centerTitle,font));
}

MenuManager.fontGlobalForMenu = (id,fontName)=>{
    addToPool(() => emit("mfa_menu:fontGlobalForMenu",id,fontName));
}

MenuManager.toggle = (id, leftLabel, leftIcon, description, initialValue, cbk) => {
    addToPool(() => emit("mfa_menu:toggle", id, leftLabel, leftIcon, description, initialValue, cbk));
}

MenuManager.clearMenuItem = (id,index) => {
    addToPool(() => emit("mfa_menu:clearMenuItem",id,index));
}

MenuManager.openMenu = (id) => {
    addToPool(() => emit("mfa_menu:select", id));
}

MenuManager.closeMenu = () =>{
    addToPool(() => emit("mfa_menu:select", null));
}