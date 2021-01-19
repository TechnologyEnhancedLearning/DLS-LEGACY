﻿//  The function to change the class
var changeClass = function (r, className1, className2) {
    var regex = new RegExp("(?:^|\\s+)" + className1 + "(?:\\s+|$)");
    if (regex.test(r.className)) {
        r.className = r.className.replace(regex, ' ' + className2 + ' ');
    }
    else {
        r.className = r.className.replace(new RegExp("(?:^|\\s+)" + className2 + "(?:\\s+|$)"), ' ' + className1 + ' ');
    }
    return r.className;
};

//  Creating our button in JS for smaller screens
var menuElements = document.getElementById('mmenu');
if (menuElements !== null) {
    menuElements.insertAdjacentHTML('afterBegin', '<button type="button" id="menutoggle" class="navtoogle" aria-hidden="true"><i aria-hidden="true" class="fas fa-bars"> </i> Menu</button>');


    //  Toggle the class on click to show / hide the menu
    document.getElementById('menutoggle').onclick = function () {
        changeClass(this, 'navtoogle active', 'navtoogle');
    }

    document.onclick = function (e) {
        var mobileButton = document.getElementById('menutoggle'),
            buttonStyle = mobileButton.currentStyle ? mobileButton.currentStyle.display : getComputedStyle(mobileButton, null).display;

        if (buttonStyle === 'block' && e.target !== mobileButton && new RegExp(' ' + 'active' + ' ').test(' ' + mobileButton.className + ' ')) {
            changeClass(mobileButton, 'navtoogle active', 'navtoogle');
        }
    }
}