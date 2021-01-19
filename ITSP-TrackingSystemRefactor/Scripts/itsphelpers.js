//A nice ticker for the master page:

(function (c) {
    var f = function (d) {
        function a(a) { b.el.css({ webkitTransition: a, mozTransition: a, msTransition: a, oTransition: a, transition: a }) } function c() { a("left " + b.duration + "s " + b.effect); b.el.css({ left: b.width + "px" }) } function e() { a("none"); b.el.css({ left: 0 }); setTimeout(c, 1E3 * b.loop) } var b = d || {}; return {
            initialize: function () {
                var a, c; b.container.css({ overflow: "hidden" }); b.el.css({ whiteSpace: "nowrap", position: "relative" }); a = b.el.width(); c = b.container.width(); a > c && (b.width = -1 * (a + 3), b.el.append(" " + b.el.html()),
                b.el.on("webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend", e), e())
            }
        }
    }; c.fn.jTicker = function () { var d; return this.each(function () { var a; a = c(this); a = { container: a, el: a.children("span").first(), duration: a.data().duration || 50, loop: a.data().loop || 1, effect: a.data().effect || "" }; d = new f(a); d.initialize() }) }
})(jQuery);

/*
LIMIT INPUI TO NUMERALS
 */
(function ($) { $.fn.numeric = function (config, callback) { if (typeof config === "boolean") { config = { decimal: config, negative: true, decimalPlaces: -1 } } config = config || {}; if (typeof config.negative == "undefined") { config.negative = true } var decimal = config.decimal === false ? "" : config.decimal || "."; var negative = config.negative === true ? true : false; var decimalPlaces = typeof config.decimalPlaces == "undefined" ? -1 : config.decimalPlaces; callback = typeof callback == "function" ? callback : function () { }; return this.data("numeric.decimal", decimal).data("numeric.negative", negative).data("numeric.callback", callback).data("numeric.decimalPlaces", decimalPlaces).keypress($.fn.numeric.keypress).keyup($.fn.numeric.keyup).blur($.fn.numeric.blur) }; $.fn.numeric.keypress = function (e) { var decimal = $.data(this, "numeric.decimal"); var negative = $.data(this, "numeric.negative"); var decimalPlaces = $.data(this, "numeric.decimalPlaces"); var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0; if (key == 13 && this.nodeName.toLowerCase() == "input") { return true } else if (key == 13) { return false } var allow = false; if (e.ctrlKey && key == 97 || e.ctrlKey && key == 65) { return true } if (e.ctrlKey && key == 120 || e.ctrlKey && key == 88) { return true } if (e.ctrlKey && key == 99 || e.ctrlKey && key == 67) { return true } if (e.ctrlKey && key == 122 || e.ctrlKey && key == 90) { return true } if (e.ctrlKey && key == 118 || e.ctrlKey && key == 86 || e.shiftKey && key == 45) { return true } if (key < 48 || key > 57) { var value = $(this).val(); if ($.inArray("-", value.split("")) !== 0 && negative && key == 45 && (value.length === 0 || parseInt($.fn.getSelectionStart(this), 10) === 0)) { return true } if (decimal && key == decimal.charCodeAt(0) && $.inArray(decimal, value.split("")) != -1) { allow = false } if (key != 8 && key != 9 && key != 13 && key != 35 && key != 36 && key != 37 && key != 39 && key != 46) { allow = false } else { if (typeof e.charCode != "undefined") { if (e.keyCode == e.which && e.which !== 0) { allow = true; if (e.which == 46) { allow = false } } else if (e.keyCode !== 0 && e.charCode === 0 && e.which === 0) { allow = true } } } if (decimal && key == decimal.charCodeAt(0)) { if ($.inArray(decimal, value.split("")) == -1) { allow = true } else { allow = false } } } else { allow = true; if (decimal && decimalPlaces > 0) { var dot = $.inArray(decimal, $(this).val().split("")); if (dot >= 0 && $(this).val().length > dot + decimalPlaces) { allow = false } } } return allow }; $.fn.numeric.keyup = function (e) { var val = $(this).val(); if (val && val.length > 0) { var carat = $.fn.getSelectionStart(this); var selectionEnd = $.fn.getSelectionEnd(this); var decimal = $.data(this, "numeric.decimal"); var negative = $.data(this, "numeric.negative"); var decimalPlaces = $.data(this, "numeric.decimalPlaces"); if (decimal !== "" && decimal !== null) { var dot = $.inArray(decimal, val.split("")); if (dot === 0) { this.value = "0" + val; carat++; selectionEnd++ } if (dot == 1 && val.charAt(0) == "-") { this.value = "-0" + val.substring(1); carat++; selectionEnd++ } val = this.value } var validChars = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "-", decimal]; var length = val.length; for (var i = length - 1; i >= 0; i--) { var ch = val.charAt(i); if (i !== 0 && ch == "-") { val = val.substring(0, i) + val.substring(i + 1) } else if (i === 0 && !negative && ch == "-") { val = val.substring(1) } var validChar = false; for (var j = 0; j < validChars.length; j++) { if (ch == validChars[j]) { validChar = true; break } } if (!validChar || ch == " ") { val = val.substring(0, i) + val.substring(i + 1) } } var firstDecimal = $.inArray(decimal, val.split("")); if (firstDecimal > 0) { for (var k = length - 1; k > firstDecimal; k--) { var chch = val.charAt(k); if (chch == decimal) { val = val.substring(0, k) + val.substring(k + 1) } } } if (decimal && decimalPlaces > 0) { var dot = $.inArray(decimal, val.split("")); if (dot >= 0) { val = val.substring(0, dot + decimalPlaces + 1); selectionEnd = Math.min(val.length, selectionEnd) } } this.value = val; $.fn.setSelection(this, [carat, selectionEnd]) } }; $.fn.numeric.blur = function () { var decimal = $.data(this, "numeric.decimal"); var callback = $.data(this, "numeric.callback"); var negative = $.data(this, "numeric.negative"); var val = this.value; if (val !== "") { var re = new RegExp(negative ? "-?" : "" + "^\\d+$|^\\d*" + decimal + "\\d+$"); if (!re.exec(val)) { callback.apply(this) } } }; $.fn.removeNumeric = function () { return this.data("numeric.decimal", null).data("numeric.negative", null).data("numeric.callback", null).data("numeric.decimalPlaces", null).unbind("keypress", $.fn.numeric.keypress).unbind("keyup", $.fn.numeric.keyup).unbind("blur", $.fn.numeric.blur) }; $.fn.getSelectionStart = function (o) { if (o.type === "number") { return undefined } else if (o.createTextRange && document.selection) { var r = document.selection.createRange().duplicate(); r.moveEnd("character", o.value.length); if (r.text == "") return o.value.length; return Math.max(0, o.value.lastIndexOf(r.text)) } else { try { return o.selectionStart } catch (e) { return 0 } } }; $.fn.getSelectionEnd = function (o) { if (o.type === "number") { return undefined } else if (o.createTextRange && document.selection) { var r = document.selection.createRange().duplicate(); r.moveStart("character", -o.value.length); return r.text.length } else return o.selectionEnd }; $.fn.setSelection = function (o, p) { if (typeof p == "number") { p = [p, p] } if (p && p.constructor == Array && p.length == 2) { if (o.type === "number") { o.focus() } else if (o.createTextRange) { var r = o.createTextRange(); r.collapse(true); r.moveStart("character", p[0]); r.moveEnd("character", p[1] - p[0]); r.select() } else { o.focus(); try { if (o.setSelectionRange) { o.setSelectionRange(p[0], p[1]) } } catch (e) { } } } } })(jQuery);

/*
    JSON 2 FOR STRINGIFY
*/

if (typeof JSON !== 'object') {
    JSON = {};
}

(function () {
    'use strict';

    function f(n) {
        // Format integers to have at least two digits.
        return n < 10 ? '0' + n : n;
    }

    if (typeof Date.prototype.toJSON !== 'function') {

        Date.prototype.toJSON = function () {

            return isFinite(this.valueOf())
                ? this.getUTCFullYear() + '-' +
                    f(this.getUTCMonth() + 1) + '-' +
                    f(this.getUTCDate()) + 'T' +
                    f(this.getUTCHours()) + ':' +
                    f(this.getUTCMinutes()) + ':' +
                    f(this.getUTCSeconds()) + 'Z'
                : null;
        };

        String.prototype.toJSON =
            Number.prototype.toJSON =
            Boolean.prototype.toJSON = function () {
                return this.valueOf();
            };
    }

    var cx,
        escapable,
        gap,
        indent,
        meta,
        rep;


    function quote(string) {

        // If the string contains no control characters, no quote characters, and no
        // backslash characters, then we can safely slap some quotes around it.
        // Otherwise we must also replace the offending characters with safe escape
        // sequences.

        escapable.lastIndex = 0;
        return escapable.test(string) ? '"' + string.replace(escapable, function (a) {
            var c = meta[a];
            return typeof c === 'string'
                ? c
                : '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
        }) + '"' : '"' + string + '"';
    }


    function str(key, holder) {

        // Produce a string from holder[key].

        var i,          // The loop counter.
            k,          // The member key.
            v,          // The member value.
            length,
            mind = gap,
            partial,
            value = holder[key];

        // If the value has a toJSON method, call it to obtain a replacement value.

        if (value && typeof value === 'object' &&
                typeof value.toJSON === 'function') {
            value = value.toJSON(key);
        }

        // If we were called with a replacer function, then call the replacer to
        // obtain a replacement value.

        if (typeof rep === 'function') {
            value = rep.call(holder, key, value);
        }

        // What happens next depends on the value's type.

        switch (typeof value) {
            case 'string':
                return quote(value);

            case 'number':

                // JSON numbers must be finite. Encode non-finite numbers as null.

                return isFinite(value) ? String(value) : 'null';

            case 'boolean':
            case 'null':

                // If the value is a boolean or null, convert it to a string. Note:
                // typeof null does not produce 'null'. The case is included here in
                // the remote chance that this gets fixed someday.

                return String(value);

                // If the type is 'object', we might be dealing with an object or an array or
                // null.

            case 'object':

                // Due to a specification blunder in ECMAScript, typeof null is 'object',
                // so watch out for that case.

                if (!value) {
                    return 'null';
                }

                // Make an array to hold the partial results of stringifying this object value.

                gap += indent;
                partial = [];

                // Is the value an array?

                if (Object.prototype.toString.apply(value) === '[object Array]') {

                    // The value is an array. Stringify every element. Use null as a placeholder
                    // for non-JSON values.

                    length = value.length;
                    for (i = 0; i < length; i += 1) {
                        partial[i] = str(i, value) || 'null';
                    }

                    // Join all of the elements together, separated with commas, and wrap them in
                    // brackets.

                    v = partial.length === 0
                        ? '[]'
                        : gap
                        ? '[\n' + gap + partial.join(',\n' + gap) + '\n' + mind + ']'
                        : '[' + partial.join(',') + ']';
                    gap = mind;
                    return v;
                }

                // If the replacer is an array, use it to select the members to be stringified.

                if (rep && typeof rep === 'object') {
                    length = rep.length;
                    for (i = 0; i < length; i += 1) {
                        if (typeof rep[i] === 'string') {
                            k = rep[i];
                            v = str(k, value);
                            if (v) {
                                partial.push(quote(k) + (gap ? ': ' : ':') + v);
                            }
                        }
                    }
                } else {

                    // Otherwise, iterate through all of the keys in the object.

                    for (k in value) {
                        if (Object.prototype.hasOwnProperty.call(value, k)) {
                            v = str(k, value);
                            if (v) {
                                partial.push(quote(k) + (gap ? ': ' : ':') + v);
                            }
                        }
                    }
                }

                // Join all of the member texts together, separated with commas,
                // and wrap them in braces.

                v = partial.length === 0
                    ? '{}'
                    : gap
                    ? '{\n' + gap + partial.join(',\n' + gap) + '\n' + mind + '}'
                    : '{' + partial.join(',') + '}';
                gap = mind;
                return v;
        }
    }

    // If the JSON object does not yet have a stringify method, give it one.

    if (typeof JSON.stringify !== 'function') {
        escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;
        meta = {    // table of character substitutions
            '\b': '\\b',
            '\t': '\\t',
            '\n': '\\n',
            '\f': '\\f',
            '\r': '\\r',
            '"': '\\"',
            '\\': '\\\\'
        };
        JSON.stringify = function (value, replacer, space) {

            // The stringify method takes a value and an optional replacer, and an optional
            // space parameter, and returns a JSON text. The replacer can be a function
            // that can replace values, or an array of strings that will select the keys.
            // A default replacer method can be provided. Use of the space parameter can
            // produce text that is more easily readable.

            var i;
            gap = '';
            indent = '';

            // If the space parameter is a number, make an indent string containing that
            // many spaces.

            if (typeof space === 'number') {
                for (i = 0; i < space; i += 1) {
                    indent += ' ';
                }

                // If the space parameter is a string, it will be used as the indent string.

            } else if (typeof space === 'string') {
                indent = space;
            }

            // If there is a replacer, it must be a function or an array.
            // Otherwise, throw an error.

            rep = replacer;
            if (replacer && typeof replacer !== 'function' &&
                    (typeof replacer !== 'object' ||
                    typeof replacer.length !== 'number')) {
                throw new Error('JSON.stringify');
            }

            // Make a fake root object containing our value under the key of ''.
            // Return the result of stringifying the value.

            return str('', { '': value });
        };
    }


    // If the JSON object does not yet have a parse method, give it one.

    if (typeof JSON.parse !== 'function') {
        cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;
        JSON.parse = function (text, reviver) {

            // The parse method takes a text and an optional reviver function, and returns
            // a JavaScript value if the text is a valid JSON text.

            var j;

            function walk(holder, key) {

                // The walk method is used to recursively walk the resulting structure so
                // that modifications can be made.

                var k, v, value = holder[key];
                if (value && typeof value === 'object') {
                    for (k in value) {
                        if (Object.prototype.hasOwnProperty.call(value, k)) {
                            v = walk(value, k);
                            if (v !== undefined) {
                                value[k] = v;
                            } else {
                                delete value[k];
                            }
                        }
                    }
                }
                return reviver.call(holder, key, value);
            }


            // Parsing happens in four stages. In the first stage, we replace certain
            // Unicode characters with escape sequences. JavaScript handles many characters
            // incorrectly, either silently deleting them, or treating them as line endings.

            text = String(text);
            cx.lastIndex = 0;
            if (cx.test(text)) {
                text = text.replace(cx, function (a) {
                    return '\\u' +
                        ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
                });
            }

            // In the second stage, we run the text against regular expressions that look
            // for non-JSON patterns. We are especially concerned with '()' and 'new'
            // because they can cause invocation, and '=' because it can cause mutation.
            // But just to be safe, we want to reject all unexpected forms.

            // We split the second stage into 4 regexp operations in order to work around
            // crippling inefficiencies in IE's and Safari's regexp engines. First we
            // replace the JSON backslash pairs with '@' (a non-JSON character). Second, we
            // replace all simple value tokens with ']' characters. Third, we delete all
            // open brackets that follow a colon or comma or that begin the text. Finally,
            // we look to see that the remaining characters are only whitespace or ']' or
            // ',' or ':' or '{' or '}'. If that is so, then the text is safe for eval.

            if (/^[\],:{}\s]*$/
                    .test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@')
                        .replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']')
                        .replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {

                // In the third stage we use the eval function to compile the text into a
                // JavaScript structure. The '{' operator is subject to a syntactic ambiguity
                // in JavaScript: it can begin a block or an object literal. We wrap the text
                // in parens to eliminate the ambiguity.

                j = eval('(' + text + ')');

                // In the optional fourth stage, we recursively walk the new structure, passing
                // each name/value pair to a reviver function for possible transformation.

                return typeof reviver === 'function'
                    ? walk({ '': j }, '')
                    : j;
            }

            // If the text is not JSON parseable, then a SyntaxError is thrown.

            throw new SyntaxError('JSON.parse');
        };
    }
}());

/*NICE BOOTSTRAP PAGINATOR*/

$(document).ready(function () {
    $('.bs-pagination td table').each(function (index, obj) {
        convertToPagination(obj)
    });
});

function convertToPagination(obj) {
    var liststring = '<ul class="pagination">';

    $(obj).find("tbody tr").each(function () {
        $(this).children().map(function () {
            liststring = liststring + "<li>" + $(this).html() + "</li>";
        });
    });
    liststring = liststring + "</ul>";
    var list = $(liststring);
    list.find('span').parent().addClass('active');

    $(obj).replaceWith(list);
}
if (!!navigator.userAgent.match(/Trident\/7\./) && Sys.Extended && Sys.Extended.UI && Sys.Extended.UI.HtmlEditorExtenderBehavior &&
    Sys.Extended.UI.HtmlEditorExtenderBehavior.prototype && Sys.Extended.UI.HtmlEditorExtenderBehavior.prototype._editableDiv_submit) {
    Sys.Extended.UI.HtmlEditorExtenderBehavior.prototype._editableDiv_submit = function () {
        var char = 3;
        var sel = null;
        setTimeout(function () {
            if (this._editableDiv != null)
                this._editableDiv.focus();
        }, 0);
        this._textbox._element.value = this._encodeHtml();
    };
}
//Create a Morris.js activity chart:
//function doActivityChart(elem, chartdata) {
//    Morris.Area({
//        element: elem,
//        data: chartdata,
//        xkey: 'period',
//        ykeys: ['registrations', 'completions', 'evaluations', 'kbsearches', 'kbtutorials', 'kbvideos', 'kbyoutubeviews'],
//        labels: ['Course registrations', 'Course completions', 'Course evaluations', 'Knowledge Bank searches', 'Knowledge Bank tutorials viewed', 'Knowledge Bank videos viewed', 'Knowledge Bank YouTube videos viewed'], behaveLikeLine: true, hideHover: true, fillOpacity: 0.3, gridTextSize: 9
//    });
//}
//function doActivityByGroupChart(elem, chartdata) {
//    Morris.Bar({
//        element: elem,
//        data: chartdata,
//        xkey: 'appgroup',
//        ykeys: ['registrations', 'completions'],
//        labels: ['Course registrations', 'Course completions'], hideHover: true, gridTextSize: 9
//    });
//}
function doHelpdeskChart(elem, chartdata) {
    Morris.Bar({
        element: elem,
        data: chartdata,
        xkey: 'period',
        ykeys: ['SLACompliant', 'NonCompliant'],
        labels: ['Compliant Tickets', 'Non-compliant Tickets'], stacked: true, barColors: ['#0f9d58', '#db4437'], hideHover: true, gridTextSize:9
    });
}
function doHelpdeskDonut(elem, donutdata) {
    Morris.Donut({
        element: elem,
        data: donutdata,
        colors: ['#0f9d58', '#db4437', '#cccccc']
    });
}
function doEvalYYNDonut(elem, donutdata) {
    Morris.Donut({
        element: elem,
        data: donutdata,
        colors: ['#0f9d58', '#f4b400', '#db4437', '#cccccc']
    });
}
function doEvalTimeDonut(elem, donutdata) {
    Morris.Donut({
        element: elem,
        data: donutdata,
        colors: ['#FF0000', '#ff6600', '#FFFF00', '#99ff00', '#33ff00', '#00FF00', '#cccccc']
    });
}
function RestrictSpace() {
    if (event.keyCode == 32) {
        event.returnValue = false;
        return false;
    }
}
function binaryImageUploaded(s, e) {
    e.processOnServer = true;
    e.usePostBack = true;
}
function onToolbarItemClick(s, e) {
    switch (e.item.name) {
        case "Register":
        case "DelegatesTemplate":
        case "DownloadDelegates":
        case "JobGroupsList":
        case "ExcelExport":
        case "AddDelegates":
        case "AddCourse":
        case "EnrolOnCourse":
        case "PreviewBrands":
        case "PreviewCases":
        case "PreviewNews":
        case "PreviewProducts":
        case "PreviewQuotes":
            case "PreviewBulletins":
        case "ExcelExportAll":
        case "SendWelcomeMsgs":
            e.processOnServer = true;
            e.usePostBack = true;
            break;
        case "BulkUpload":
            $('#bulkuploadModal').modal('show');
            break;
        case "GenerateGroups":
            $('#GenerateGroupsModal').modal('show');
            break;
    }
}