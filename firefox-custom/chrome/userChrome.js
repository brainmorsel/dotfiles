// ==UserScript==
// @name           FloatingScrollbar.uc.js
// @namespace      nightson1988@gmail.com
// @include        main
// @version        0.0.3
// @note           Thanks to Griever(https://github.com/Griever/userChromeJS/blob/master/SmartScrollbar.uc.js) and Paul Rouget(https://gist.github.com/4003205)
// @note...........0.0.3 Fixed a problem of breaking hbox layout 
// @note           0.0.2 Remove usage of E4X (https://bugzilla.mozilla.org/show_bug.cgi?id=788293)
// ==/UserScript==

(function () {
    var prefs = Services.prefs,
        enabled;
    if (prefs.prefHasUserValue('userChromeJS.floating_scrollbar.enabled')) {
        enabled = prefs.getBoolPref('userChromeJS.floating_scrollbar.enabled')
    } else {
        prefs.setBoolPref('userChromeJS.floating_scrollbar.enabled', true);
        enabled = true;
    }

    var css = '\
    @namespace url(http: //www.mozilla.org/keymaster/gatekeeper/there.is.only.xul);\
    :not(select):not(hbox) > scrollbar {\
        -moz-appearance: none!important;\
        position: relative;\
        background-color: rgba(38, 74, 83, 0.2)!important;\
        background-image: none;\
        opacity: 0.5;\
        z-index: 2147483647;\
        padding: 2px;\
        transition: opacity 0.5s ease-in-out;\
        backface-visibility: hidden;\
    }\
    :not(select):not(hbox) > scrollbar:hover {\
        background-color: rgba(38, 74, 83, 1)!important;\
        opacity: 1.0;\
    }\
    :not(select):not(hbox) > scrollbar[orient = "vertical"] {\
        -moz-margin-start: -10px;\
        min-width: 10px;\
    }\
    :not(select):not(hbox) > scrollbar[orient = "vertical"]:hover {\
        -moz-margin-start: -15px;\
        min-width: 15px;\
    }\
    :not(select):not(hbox) > scrollbar[orient = "vertical"] thumb {\
        min-height: 20px;\
    }\
   :not(select):not(hbox) > scrollbar[orient = "horizontal"] {\
        margin-top: -10px;\
        min-height: 10px;\
    }\
   :not(select):not(hbox) > scrollbar[orient = "horizontal"]:hover {\
        margin-top: -15px;\
        min-height: 15px;\
    }\
    :not(select):not(hbox) > scrollbar[orient = "horizontal"] thumb {\
        min-width: 20px;\
    }\
    :not(select):not(hbox) > scrollbar thumb {\
        -moz-appearance: none!important;\
        border-width: 0px!important;\
        border-radius: 3px!important;\
        background-color: rgba(38, 139, 210, 1)!important;\
        transition: background-color 0.2s ease-in-out;\
    }\
    :not(select):not(hbox) > scrollbar:hover thumb {\
        border-radius: 5px!important;\
    }\
    :not(select):not(hbox) > scrollbar thumb:active,\
    :not(select):not(hbox) > scrollbar thumb:hover {\
        background-color: rgba(220, 220, 220, 1)!important;\
    }\
    :not(select):not(hbox) > scrollbar scrollbarbutton, :not(select):not(hbox) > scrollbar gripper {\
        display: none;\
    }';

    var sss = Cc['@mozilla.org/content/style-sheet-service;1'].getService(Ci.nsIStyleSheetService);
    var uri = makeURI('data:text/css;charset=UTF=8,' + encodeURIComponent(css));

    var p = document.getElementById('devToolsSeparator');
    var m = document.createElement('menuitem');
    m.setAttribute('label', "Schwebende Scrollbar");
    m.setAttribute('type', 'checkbox');
    m.setAttribute('autocheck', 'false');
    m.setAttribute('checked', enabled);
    p.parentNode.insertBefore(m, p);
    m.addEventListener('command', command, false);

    if (enabled) {
        sss.loadAndRegisterSheet(uri, sss.AGENT_SHEET);
    }

    function command() {
        if (sss.sheetRegistered(uri, sss.AGENT_SHEET)) {
            prefs.setBoolPref('userChromeJS.floating_scrollbar.enabled', false);
            sss.unregisterSheet(uri, sss.AGENT_SHEET);
            m.setAttribute('checked', false);
        } else {
            prefs.setBoolPref('userChromeJS.floating_scrollbar.enabled', true);
            sss.loadAndRegisterSheet(uri, sss.AGENT_SHEET);
            m.setAttribute('checked', true);
        }

        let root = document.documentElement;
        let display = root.style.display;
        root.style.display = 'none';
        window.getComputedStyle(root).display; // Flush
        root.style.display = display;
    }

})();
