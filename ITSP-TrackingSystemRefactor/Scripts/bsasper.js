/*!
 * bsasper v1.0
 * Copyright 2014 Julian Hill
 * 
 * A jQuery plugin that converts ASP.NET validation errors to Bootstrap popovers
 * https://bsasper.codeplex.com/
 *
 */
(function ($) {

    $.fn.bsasper = function (options) {

        // Contains the control ids of all controls in the jquery selector.
        var selectedForPopover = {};
        var activePopups = {};
      
        var ValidatorUpdateIsValidBase,
            ValidatorUpdateDisplayBase;
        
        var validatorUpdateDisplayOverride = function (val) {
            if (typeof (val.display) !== "string" || val.display !== "Dynamic" || !selectedForPopover[val.controltovalidate]) {
                ValidatorUpdateDisplayBase(val);
            }
        };

        var validatorUpdateIsValidOverride = function () {
            ValidatorUpdateIsValidBase();
            ConvertMessagesToPopovers();
        }

        var ConvertMessagesToPopovers = function () {
            if (typeof Page_Validators != "undefined") {
                // Save the id and error messages for each control that is associated with at least one in-error validation control.
                var invalidControlIds = {};
                for (var i = 0; i < Page_Validators.length; i++) {

                    var val = Page_Validators[i];

                    if (typeof (val.display) === "string" && val.display === "Dynamic") {
                        var id = val.controltovalidate;
                        if (id === "undefined") { id = "MainContent_RegisterUser_CreateUserStepContainer_cbConfirm";}
                        if (selectedForPopover[id]) {
                            if (!val.isvalid) {
                                // If the control was validated server-side, we need to hide the message.
                                if (val.style.display !== "none") {
                                    val.style.display = "none"
                                }
                                if (!invalidControlIds[id]) {
                                    invalidControlIds[id] = { errors: [val.textContent] };
                                }
                                else {
                                    invalidControlIds[id].errors.push(val.textContent);
                                }
                            }
                        }
                    }
                }

                // Destroy popovers that are attached to controls that are no longer in error.
                for (var id in activePopups) {
                    if (!invalidControlIds[id]) {
                        $("#" + id).popover('destroy');
                        var prnt = $("#" + id).closest(".form-group");
                        prnt.removeClass("has-error");
                        prnt.addClass("has-success");
                        delete activePopups[id];
                    }
                }

                // Display a popover for each control that is in error. If the popover already exists, refresh the text incase it
                // has changed (the text can change if the number of errors for the control changes).
                for (var id in invalidControlIds) {
                    if (invalidControlIds.hasOwnProperty(id)) {

                        var $controltovalidate = $("#" + id);
                        var settings = $.extend({}, $.fn.bsasper.defaults, $controltovalidate.data(), options);
                        var content = settings.createContent(invalidControlIds[id].errors);

                        if (activePopups[id]) {
                            // If the change in text causes postion problems then either: (1) destroy all existing popovers 
                            // (see above) and then recreate (see below). Currently only those without errors are destroyed.
                            // (2) Hide the pop-up, set the content: $control.popover().data("bs.popover").options.content = 'xxx'
                            // and re-show.
                            $controltovalidate.popover().data("bs.popover").tip().find(".popover-content").html(content);
                            // If popover.trigger is left at the default ('click'), the message is removed when the textbox is clicked 
                            // into (this may actually be desirable). In this situation, .popover('show') must be invoked each time.
                            //$controltovalidate.popover('show');
                        }
                        else {
                            activePopups[id] = true;
                            var prnt = $controltovalidate.closest(".form-group");
                            prnt.addClass("has-error");
                            $controltovalidate.popover({
                                animation: settings.animation,
                                container: settings.container,
                                content: content,
                                html: true,
                                placement: settings.placement,
                                title: settings.title,
                                trigger: "manual"
                            });
                            $controltovalidate.popover('show');
                        }
                    }
                }
            }
        };

        var toReturn = this.each(function () {
            if (!ValidatorUpdateIsValidBase) {
                ValidatorUpdateIsValidBase = ValidatorUpdateIsValid;
                ValidatorUpdateIsValid = validatorUpdateIsValidOverride;
                ValidatorUpdateDisplayBase = ValidatorUpdateDisplay;
                ValidatorUpdateDisplay = validatorUpdateDisplayOverride;
            }
            selectedForPopover[$(this).attr("id")] = true;
        });

        // After a postback, any message that wasn't validated client-side will be displayed normally so we need to initially
        // call the routine to convert these.
        ConvertMessagesToPopovers();

        return toReturn;
    };

    $.fn.bsasper.defaults = {
        animation: true,
        placement: "right",
        container: "body",
        title: "",
        createContent: function (errors) {
            var res = "";
            $.each(errors, function (i, item) {
                if (res.length > 0) {
                    res += "<br />";
                }
                res += item;
            });
            return res;
        }
    };

}(jQuery));