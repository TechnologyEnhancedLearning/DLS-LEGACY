﻿    var checkboxFilter = {
        $filters: null,
        $reset: null,
        groups: [],
        outputArray: [],
        outputString: "",
        init: function () {
            var t = this;
            t.$filters = $("#Filters"), t.$reset = $("#Reset"), t.$container = $("#Container"), t.$filters.find("fieldset").each(function () {
                t.groups.push({
                    $inputs: $(this).find("input"),
                    active: [],
                    tracker: !1
                });
            }), t.bindHandlers();
        },
        bindHandlers: function () {
            var r = this;
            r.$filters.on("change", function () {
                r.parseFilters();
            }), r.$reset.on("click", function (t) {
                t.preventDefault(), r.$filters[0].reset(), r.parseFilters();
            });
        },
        parseFilters: function () {
            for (var t, r = this, e = 0; r.groups[e]; e++)(t = r.groups[e]).active = [], t.$inputs.each(function () {
                $(this).is(":checked") && t.active.push(this.value);
            }), t.active.length && (t.tracker = 0);
            r.concatenate();
        },
        concatenate: function () {
            var e = this,
                i = "",
                n = !1,
                t = function () {
                    for (var t = 0, r = 0; e.groups[r]; r++) !1 === e.groups[r].tracker && t++;
                    return t < e.groups.length;
                },
                r = function () {
                    for (var t, r = 0; e.groups[r]; r++)(t = e.groups[r]).active[t.tracker] && (i += t.active[t.tracker]), r === e.groups.length - 1 && (e.outputArray.push(i), i = "", a());
                },
                a = function () {
                    for (var t = e.groups.length - 1; - 1 < t; t--) {
                        var r = e.groups[t];
                        if (r.active[r.tracker + 1]) {
                            r.tracker++;
                            break;
                        }
                        0 < t ? r.tracker && (r.tracker = 0) : n = !0;
                    }
                };
            for (e.outputArray = []; r(), !n && t(););
            e.outputString = e.outputArray.join(), !e.outputString.length && (e.outputString = "all"), e.$container.mixItUp("isLoaded") && e.$container.mixItUp("filter", e.outputString);
        }
    };
$(function () {
    var t = $("#SortSelect"),
        r = $("#Container");
    checkboxFilter.init(), r.mixItUp({
        controls: {
            enable: !1
        },
        animation: {
            easing: "cubic-bezier(0.86, 0, 0.07, 1)",
            duration: 600
        }
    }), t.on("change", function () {
        r.mixItUp("sort", this.value);
    });
    });
