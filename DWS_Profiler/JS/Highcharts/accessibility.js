﻿/*
 Highcharts JS v8.2.2 (2020-10-22)

 Accessibility module

 (c) 2010-2019 Highsoft AS
 Author: Oystein Moseng

 License: www.highcharts.com/license
*/
(function (a) { "object" === typeof module && module.exports ? (a["default"] = a, module.exports = a) : "function" === typeof define && define.amd ? define("highcharts/modules/accessibility", ["highcharts"], function (p) { a(p); a.Highcharts = p; return a }) : a("undefined" !== typeof Highcharts ? Highcharts : void 0) })(function (a) {
    function p(a, f, l, m) { a.hasOwnProperty(f) || (a[f] = m.apply(null, l)) } a = a ? a._modules : {}; p(a, "Accessibility/Utils/HTMLUtilities.js", [a["Core/Globals.js"], a["Core/Utilities.js"]], function (a, f) {
        function u(a) {
            return a.replace(/&/g,
                "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#x27;").replace(/\//g, "&#x2F;")
        } var m = a.doc, n = a.win, g = f.merge; return {
            addClass: function (a, g) { a.classList ? a.classList.add(g) : 0 > a.className.indexOf(g) && (a.className += g) }, escapeStringForHTML: u, getElement: function (a) { return m.getElementById(a) }, getFakeMouseEvent: function (a) {
                if ("function" === typeof n.MouseEvent) return new n.MouseEvent(a); if (m.createEvent) {
                    var g = m.createEvent("MouseEvent"); if (g.initMouseEvent) return g.initMouseEvent(a,
                        !0, !0, n, "click" === a ? 1 : 0, 0, 0, 0, 0, !1, !1, !1, !1, 0, null), g
                } return { type: a }
            }, removeElement: function (a) { a && a.parentNode && a.parentNode.removeChild(a) }, reverseChildNodes: function (a) { for (var g = a.childNodes.length; g--;)a.appendChild(a.childNodes[g]) }, setElAttrs: function (a, g) { Object.keys(g).forEach(function (e) { var d = g[e]; null === d ? a.removeAttribute(e) : (d = u("" + d), a.setAttribute(e, d)) }) }, stripHTMLTagsFromString: function (a) { return "string" === typeof a ? a.replace(/<\/?[^>]+(>|$)/g, "") : a }, visuallyHideElement: function (a) {
                g(!0,
                    a.style, { position: "absolute", width: "1px", height: "1px", overflow: "hidden", whiteSpace: "nowrap", clip: "rect(1px, 1px, 1px, 1px)", marginTop: "-3px", "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=1)", filter: "alpha(opacity=1)", opacity: "0.01" })
            }
        }
    }); p(a, "Accessibility/Utils/ChartUtilities.js", [a["Accessibility/Utils/HTMLUtilities.js"], a["Core/Utilities.js"]], function (a, f) {
        function u(d) {
            var b, c; if (null === (b = d.points) || void 0 === b ? 0 : b.length) return d = q(d.points, function (c) { return !!c.graphic }), null ===
                (c = null === d || void 0 === d ? void 0 : d.graphic) || void 0 === c ? void 0 : c.element
        } function m(d) { var b = u(d); return b && b.parentNode || d.graph && d.graph.element || d.group && d.group.element } function n(d, b) { b.setAttribute("aria-hidden", !1); b !== d.renderTo && b.parentNode && (Array.prototype.forEach.call(b.parentNode.childNodes, function (c) { c.hasAttribute("aria-hidden") || c.setAttribute("aria-hidden", !0) }), n(d, b.parentNode)) } var g = a.stripHTMLTagsFromString, h = f.defined, q = f.find, e = f.fireEvent; return {
            getChartTitle: function (d) {
                return g(d.options.title.text ||
                    d.langFormat("accessibility.defaultChartTitle", { chart: d }))
            }, getAxisDescription: function (d) { return g(d && (d.userOptions && d.userOptions.accessibility && d.userOptions.accessibility.description || d.axisTitle && d.axisTitle.textStr || d.options.id || d.categories && "categories" || d.dateTime && "Time" || "values")) }, getPointFromXY: function (d, b, c) { for (var k = d.length, t; k--;)if (t = q(d[k].points || [], function (v) { return v.x === b && v.y === c })) return t }, getSeriesFirstPointElement: u, getSeriesFromName: function (d, b) {
                return b ? (d.series ||
                    []).filter(function (c) { return c.name === b }) : d.series
            }, getSeriesA11yElement: m, unhideChartElementFromAT: n, hideSeriesFromAT: function (d) { (d = m(d)) && d.setAttribute("aria-hidden", !0) }, scrollToPoint: function (d) {
                var b = d.series.xAxis, c = d.series.yAxis, k = (null === b || void 0 === b ? 0 : b.scrollbar) ? b : c; if ((b = null === k || void 0 === k ? void 0 : k.scrollbar) && h(b.to) && h(b.from)) {
                    c = b.to - b.from; if (h(k.dataMin) && h(k.dataMax)) { var t = k.toPixels(k.dataMin), v = k.toPixels(k.dataMax); d = (k.toPixels(d["xAxis" === k.coll ? "x" : "y"] || 0) - t) / (v - t) } else d =
                        0; b.updatePosition(d - c / 2, d + c / 2); e(b, "changed", { from: b.from, to: b.to, trigger: "scrollbar", DOMEvent: null })
                }
            }
        }
    }); p(a, "Accessibility/KeyboardNavigationHandler.js", [a["Core/Utilities.js"]], function (a) {
        function f(a, f) { this.chart = a; this.keyCodeMap = f.keyCodeMap || []; this.validate = f.validate; this.init = f.init; this.terminate = f.terminate; this.response = { success: 1, prev: 2, next: 3, noHandler: 4, fail: 5 } } var u = a.find; f.prototype = {
            run: function (a) {
                var f = a.which || a.keyCode, g = this.response.noHandler, h = u(this.keyCodeMap, function (a) {
                    return -1 <
                        a[0].indexOf(f)
                }); h ? g = h[1].call(this, f, a) : 9 === f && (g = this.response[a.shiftKey ? "prev" : "next"]); return g
            }
        }; return f
    }); p(a, "Accessibility/Utils/DOMElementProvider.js", [a["Core/Globals.js"], a["Accessibility/Utils/HTMLUtilities.js"], a["Core/Utilities.js"]], function (a, f, l) {
        var u = a.doc, n = f.removeElement; a = l.extend; f = function () { this.elements = [] }; a(f.prototype, {
            createElement: function () { var a = u.createElement.apply(u, arguments); this.elements.push(a); return a }, destroyCreatedElements: function () {
                this.elements.forEach(function (a) { n(a) });
                this.elements = []
            }
        }); return f
    }); p(a, "Accessibility/Utils/EventProvider.js", [a["Core/Globals.js"], a["Core/Utilities.js"]], function (a, f) { var u = f.addEvent; f = f.extend; var m = function () { this.eventRemovers = [] }; f(m.prototype, { addEvent: function () { var f = u.apply(a, arguments); this.eventRemovers.push(f); return f }, removeAddedEvents: function () { this.eventRemovers.forEach(function (a) { a() }); this.eventRemovers = [] } }); return m }); p(a, "Accessibility/AccessibilityComponent.js", [a["Accessibility/Utils/ChartUtilities.js"],
    a["Accessibility/Utils/DOMElementProvider.js"], a["Accessibility/Utils/EventProvider.js"], a["Core/Globals.js"], a["Accessibility/Utils/HTMLUtilities.js"], a["Core/Utilities.js"]], function (a, f, l, m, n, g) {
        function h() { } var q = a.unhideChartElementFromAT, e = m.doc, d = m.win, b = n.removeElement, c = n.getFakeMouseEvent; a = g.extend; var k = g.fireEvent, t = g.merge; h.prototype = {
            initBase: function (c) {
            this.chart = c; this.eventProvider = new l; this.domElementProvider = new f; this.keyCodes = {
                left: 37, right: 39, up: 38, down: 40, enter: 13, space: 32,
                esc: 27, tab: 9
            }
            }, addEvent: function () { return this.eventProvider.addEvent.apply(this.eventProvider, arguments) }, createElement: function () { return this.domElementProvider.createElement.apply(this.domElementProvider, arguments) }, fireEventOnWrappedOrUnwrappedElement: function (c, b) { var v = b.type; e.createEvent && (c.dispatchEvent || c.fireEvent) ? c.dispatchEvent ? c.dispatchEvent(b) : c.fireEvent(v, b) : k(c, v, b) }, fakeClickEvent: function (b) { if (b) { var v = c("click"); this.fireEventOnWrappedOrUnwrappedElement(b, v) } }, addProxyGroup: function (c) {
                this.createOrUpdateProxyContainer();
                var b = this.createElement("div"); Object.keys(c || {}).forEach(function (v) { null !== c[v] && b.setAttribute(v, c[v]) }); this.chart.a11yProxyContainer.appendChild(b); return b
            }, createOrUpdateProxyContainer: function () { var c = this.chart, b = c.renderer.box; c.a11yProxyContainer = c.a11yProxyContainer || this.createProxyContainerElement(); b.nextSibling !== c.a11yProxyContainer && c.container.insertBefore(c.a11yProxyContainer, b.nextSibling) }, createProxyContainerElement: function () {
                var c = e.createElement("div"); c.className = "highcharts-a11y-proxy-container";
                return c
            }, createProxyButton: function (c, b, a, d, k) { var v = c.element, e = this.createElement("button"), w = t({ "aria-label": v.getAttribute("aria-label") }, a); Object.keys(w).forEach(function (c) { null !== w[c] && e.setAttribute(c, w[c]) }); e.className = "highcharts-a11y-proxy-button"; k && this.addEvent(e, "click", k); this.setProxyButtonStyle(e); this.updateProxyButtonPosition(e, d || c); this.proxyMouseEventsForButton(v, e); b.appendChild(e); w["aria-hidden"] || q(this.chart, e); return e }, getElementPosition: function (c) {
                var b = c.element;
                return (c = this.chart.renderTo) && b && b.getBoundingClientRect ? (b = b.getBoundingClientRect(), c = c.getBoundingClientRect(), { x: b.left - c.left, y: b.top - c.top, width: b.right - b.left, height: b.bottom - b.top }) : { x: 0, y: 0, width: 1, height: 1 }
            }, setProxyButtonStyle: function (c) {
                t(!0, c.style, {
                    "border-width": 0, "background-color": "transparent", cursor: "pointer", outline: "none", opacity: .001, filter: "alpha(opacity=1)", "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=1)", zIndex: 999, overflow: "hidden", padding: 0, margin: 0, display: "block",
                    position: "absolute"
                })
            }, updateProxyButtonPosition: function (c, b) { b = this.getElementPosition(b); t(!0, c.style, { width: (b.width || 1) + "px", height: (b.height || 1) + "px", left: (b.x || 0) + "px", top: (b.y || 0) + "px" }) }, proxyMouseEventsForButton: function (c, b) {
                var a = this; "click touchstart touchend touchcancel touchmove mouseover mouseenter mouseleave mouseout".split(" ").forEach(function (d) {
                    var t = 0 === d.indexOf("touch"); a.addEvent(b, d, function (b) {
                        var d = t ? a.cloneTouchEvent(b) : a.cloneMouseEvent(b); c && a.fireEventOnWrappedOrUnwrappedElement(c,
                            d); b.stopPropagation(); b.preventDefault()
                    })
                })
            }, cloneMouseEvent: function (b) { if ("function" === typeof d.MouseEvent) return new d.MouseEvent(b.type, b); if (e.createEvent) { var a = e.createEvent("MouseEvent"); if (a.initMouseEvent) return a.initMouseEvent(b.type, b.bubbles, b.cancelable, b.view || d, b.detail, b.screenX, b.screenY, b.clientX, b.clientY, b.ctrlKey, b.altKey, b.shiftKey, b.metaKey, b.button, b.relatedTarget), a } return c(b.type) }, cloneTouchEvent: function (b) {
                var c = function (b) {
                    for (var c = [], a = 0; a < b.length; ++a) {
                        var d =
                            b.item(a); d && c.push(d)
                    } return c
                }; if ("function" === typeof d.TouchEvent) return c = new d.TouchEvent(b.type, { touches: c(b.touches), targetTouches: c(b.targetTouches), changedTouches: c(b.changedTouches), ctrlKey: b.ctrlKey, shiftKey: b.shiftKey, altKey: b.altKey, metaKey: b.metaKey, bubbles: b.bubbles, cancelable: b.cancelable, composed: b.composed, detail: b.detail, view: b.view }), b.defaultPrevented && c.preventDefault(), c; c = this.cloneMouseEvent(b); c.touches = b.touches; c.changedTouches = b.changedTouches; c.targetTouches = b.targetTouches;
                return c
            }, destroyBase: function () { b(this.chart.a11yProxyContainer); this.domElementProvider.destroyCreatedElements(); this.eventProvider.removeAddedEvents() }
        }; a(h.prototype, { init: function () { }, getKeyboardNavigation: function () { }, onChartUpdate: function () { }, onChartRender: function () { }, destroy: function () { } }); return h
    }); p(a, "Accessibility/KeyboardNavigation.js", [a["Core/Globals.js"], a["Core/Utilities.js"], a["Accessibility/Utils/HTMLUtilities.js"], a["Accessibility/Utils/EventProvider.js"]], function (a, f, l, m) {
        function n(b,
            c) { this.init(b, c) } var g = a.doc, h = a.win, q = f.addEvent, e = f.fireEvent, d = l.getElement; q(g, "keydown", function (b) { 27 === (b.which || b.keyCode) && a.charts && a.charts.forEach(function (b) { b && b.dismissPopupContent && b.dismissPopupContent() }) }); a.Chart.prototype.dismissPopupContent = function () { var b = this; e(this, "dismissPopupContent", {}, function () { b.tooltip && b.tooltip.hide(0); b.hideExportMenu() }) }; n.prototype = {
                init: function (b, c) {
                    var a = this, d = this.eventProvider = new m; this.chart = b; this.components = c; this.modules = []; this.currentModuleIx =
                        0; this.update(); d.addEvent(this.tabindexContainer, "keydown", function (b) { return a.onKeydown(b) }); d.addEvent(this.tabindexContainer, "focus", function (b) { return a.onFocus(b) });["mouseup", "touchend"].forEach(function (b) { return d.addEvent(g, b, function () { return a.onMouseUp() }) });["mousedown", "touchstart"].forEach(function (c) { return d.addEvent(b.renderTo, c, function () { a.isClickingChart = !0 }) }); d.addEvent(b.renderTo, "mouseover", function () { a.pointerIsOverChart = !0 }); d.addEvent(b.renderTo, "mouseout", function () {
                        a.pointerIsOverChart =
                            !1
                        }); this.modules.length && this.modules[0].init(1)
                }, update: function (b) { var c = this.chart.options.accessibility; c = c && c.keyboardNavigation; var a = this.components; this.updateContainerTabindex(); c && c.enabled && b && b.length ? (this.modules = b.reduce(function (b, c) { c = a[c].getKeyboardNavigation(); return b.concat(c) }, []), this.updateExitAnchor()) : (this.modules = [], this.currentModuleIx = 0, this.removeExitAnchor()) }, onFocus: function (b) {
                    var c, a = this.chart; b = b.relatedTarget && a.container.contains(b.relatedTarget); this.isClickingChart ||
                        b || (null === (c = this.modules[0]) || void 0 === c ? void 0 : c.init(1))
                }, onMouseUp: function () { delete this.isClickingChart; if (!this.keyboardReset && !this.pointerIsOverChart) { var b = this.chart, c = this.modules && this.modules[this.currentModuleIx || 0]; c && c.terminate && c.terminate(); b.focusElement && b.focusElement.removeFocusBorder(); this.currentModuleIx = 0; this.keyboardReset = !0 } }, onKeydown: function (b) {
                    b = b || h.event; var c, a = this.modules && this.modules.length && this.modules[this.currentModuleIx]; this.keyboardReset = !1; if (a) {
                        var d =
                            a.run(b); d === a.response.success ? c = !0 : d === a.response.prev ? c = this.prev() : d === a.response.next && (c = this.next()); c && (b.preventDefault(), b.stopPropagation())
                    }
                }, prev: function () { return this.move(-1) }, next: function () { return this.move(1) }, move: function (b) {
                    var c = this.modules && this.modules[this.currentModuleIx]; c && c.terminate && c.terminate(b); this.chart.focusElement && this.chart.focusElement.removeFocusBorder(); this.currentModuleIx += b; if (c = this.modules && this.modules[this.currentModuleIx]) {
                        if (c.validate && !c.validate()) return this.move(b);
                        if (c.init) return c.init(b), !0
                    } this.currentModuleIx = 0; 0 < b ? (this.exiting = !0, this.exitAnchor.focus()) : this.tabindexContainer.focus(); return !1
                }, updateExitAnchor: function () { var b = d("highcharts-end-of-chart-marker-" + this.chart.index); this.removeExitAnchor(); b ? (this.makeElementAnExitAnchor(b), this.exitAnchor = b) : this.createExitAnchor() }, updateContainerTabindex: function () {
                    var b = this.chart.options.accessibility; b = b && b.keyboardNavigation; b = !(b && !1 === b.enabled); var c = this.chart, a = c.container; c.renderTo.hasAttribute("tabindex") &&
                        (a.removeAttribute("tabindex"), a = c.renderTo); this.tabindexContainer = a; var d = a.getAttribute("tabindex"); b && !d ? a.setAttribute("tabindex", "0") : b || c.container.removeAttribute("tabindex")
                }, makeElementAnExitAnchor: function (b) { var c = this.tabindexContainer.getAttribute("tabindex") || 0; b.setAttribute("class", "highcharts-exit-anchor"); b.setAttribute("tabindex", c); b.setAttribute("aria-hidden", !1); this.addExitAnchorEventsToEl(b) }, createExitAnchor: function () {
                    var b = this.chart, c = this.exitAnchor = g.createElement("div");
                    b.renderTo.appendChild(c); this.makeElementAnExitAnchor(c)
                }, removeExitAnchor: function () { this.exitAnchor && this.exitAnchor.parentNode && (this.exitAnchor.parentNode.removeChild(this.exitAnchor), delete this.exitAnchor) }, addExitAnchorEventsToEl: function (b) {
                    var c = this.chart, a = this; this.eventProvider.addEvent(b, "focus", function (b) {
                        b = b || h.event; b.relatedTarget && c.container.contains(b.relatedTarget) || a.exiting ? a.exiting = !1 : (a.tabindexContainer.focus(), b.preventDefault(), a.modules && a.modules.length && (a.currentModuleIx =
                            a.modules.length - 1, (b = a.modules[a.currentModuleIx]) && b.validate && !b.validate() ? a.prev() : b && b.init(-1)))
                    })
                }, destroy: function () { this.removeExitAnchor(); this.eventProvider.removeAddedEvents(); this.chart.container.removeAttribute("tabindex") }
            }; return n
    }); p(a, "Accessibility/Components/LegendComponent.js", [a["Core/Globals.js"], a["Core/Legend.js"], a["Core/Utilities.js"], a["Accessibility/AccessibilityComponent.js"], a["Accessibility/KeyboardNavigationHandler.js"], a["Accessibility/Utils/HTMLUtilities.js"]],
        function (a, f, l, m, n, g) {
            function h(b) { var c = b.legend && b.legend.allItems, a = b.options.legend.accessibility || {}; return !(!c || !c.length || b.colorAxis && b.colorAxis.length || !1 === a.enabled) } var q = l.addEvent, e = l.extend, d = l.find, b = l.fireEvent, c = g.stripHTMLTagsFromString, k = g.removeElement; a.Chart.prototype.highlightLegendItem = function (c) {
                var a = this.legend.allItems, d = this.highlightedLegendItemIx; if (a[c]) {
                a[d] && b(a[d].legendGroup.element, "mouseout"); d = this.legend; var k = d.allItems[c].pageIx, t = d.currentPage; "undefined" !==
                    typeof k && k + 1 !== t && d.scroll(1 + k - t); this.setFocusToElement(a[c].legendItem, a[c].a11yProxyElement); b(a[c].legendGroup.element, "mouseover"); return !0
                } return !1
            }; q(f, "afterColorizeItem", function (b) { var c = b.item; this.chart.options.accessibility.enabled && c && c.a11yProxyElement && c.a11yProxyElement.setAttribute("aria-pressed", b.visible ? "false" : "true") }); a = function () { }; a.prototype = new m; e(a.prototype, {
                init: function () {
                    var b = this; this.proxyElementsList = []; this.recreateProxies(); this.addEvent(f, "afterScroll", function () {
                    this.chart ===
                        b.chart && (b.updateProxiesPositions(), b.updateLegendItemProxyVisibility(), this.chart.highlightLegendItem(b.highlightedLegendItemIx))
                    }); this.addEvent(f, "afterPositionItem", function (c) { this.chart === b.chart && this.chart.renderer && b.updateProxyPositionForItem(c.item) })
                }, updateLegendItemProxyVisibility: function () {
                    var b = this.chart.legend, c = b.currentPage || 1, a = b.clipHeight || 0; (b.allItems || []).forEach(function (d) {
                        var k = d.pageIx || 0, t = d._legendItemPos ? d._legendItemPos[1] : 0, e = d.legendItem ? Math.round(d.legendItem.getBBox().height) :
                            0; k = t + e - b.pages[k] > a || k !== c - 1; d.a11yProxyElement && (d.a11yProxyElement.style.visibility = k ? "hidden" : "visible")
                    })
                }, onChartRender: function () { h(this.chart) ? this.updateProxiesPositions() : this.removeProxies() }, updateProxiesPositions: function () { for (var b = 0, c = this.proxyElementsList; b < c.length; b++) { var a = c[b]; this.updateProxyButtonPosition(a.element, a.posElement) } }, updateProxyPositionForItem: function (b) {
                    var c = d(this.proxyElementsList, function (c) { return c.item === b }); c && this.updateProxyButtonPosition(c.element,
                        c.posElement)
                }, recreateProxies: function () { this.removeProxies(); h(this.chart) && (this.addLegendProxyGroup(), this.proxyLegendItems(), this.updateLegendItemProxyVisibility()) }, removeProxies: function () { k(this.legendProxyGroup); this.proxyElementsList = [] }, addLegendProxyGroup: function () { var b = this.chart.options.accessibility, c = this.chart.langFormat("accessibility.legend.legendLabel", {}); this.legendProxyGroup = this.addProxyGroup({ "aria-label": c, role: "all" === b.landmarkVerbosity ? "region" : null }) }, proxyLegendItems: function () {
                    var b =
                        this; (this.chart.legend && this.chart.legend.allItems || []).forEach(function (c) { c.legendItem && c.legendItem.element && b.proxyLegendItem(c) })
                }, proxyLegendItem: function (b) {
                    if (b.legendItem && b.legendGroup) {
                        var a = this.chart.langFormat("accessibility.legend.legendItem", { chart: this.chart, itemName: c(b.name) }), d = b.legendGroup.div ? b.legendItem : b.legendGroup; b.a11yProxyElement = this.createProxyButton(b.legendItem, this.legendProxyGroup, { tabindex: -1, "aria-pressed": !b.visible, "aria-label": a }, d); this.proxyElementsList.push({
                            item: b,
                            element: b.a11yProxyElement, posElement: d
                        })
                    }
                }, getKeyboardNavigation: function () { var b = this.keyCodes, c = this; return new n(this.chart, { keyCodeMap: [[[b.left, b.right, b.up, b.down], function (b) { return c.onKbdArrowKey(this, b) }], [[b.enter, b.space], function () { return c.onKbdClick(this) }]], validate: function () { return c.shouldHaveLegendNavigation() }, init: function (b) { return c.onKbdNavigationInit(b) } }) }, onKbdArrowKey: function (b, c) {
                    var a = this.keyCodes, d = b.response, k = this.chart, e = k.options.accessibility, t = k.legend.allItems.length;
                    c = c === a.left || c === a.up ? -1 : 1; return k.highlightLegendItem(this.highlightedLegendItemIx + c) ? (this.highlightedLegendItemIx += c, d.success) : 1 < t && e.keyboardNavigation.wrapAround ? (b.init(c), d.success) : d[0 < c ? "next" : "prev"]
                }, onKbdClick: function (c) { var a = this.chart.legend.allItems[this.highlightedLegendItemIx]; a && a.a11yProxyElement && b(a.a11yProxyElement, "click"); return c.response.success }, shouldHaveLegendNavigation: function () {
                    var b = this.chart, c = b.colorAxis && b.colorAxis.length, a = (b.options.legend || {}).accessibility ||
                        {}; return !!(b.legend && b.legend.allItems && b.legend.display && !c && a.enabled && a.keyboardNavigation && a.keyboardNavigation.enabled)
                }, onKbdNavigationInit: function (b) { var c = this.chart, a = c.legend.allItems.length - 1; b = 0 < b ? 0 : a; c.highlightLegendItem(b); this.highlightedLegendItemIx = b }
            }); return a
        }); p(a, "Accessibility/Components/MenuComponent.js", [a["Core/Globals.js"], a["Core/Utilities.js"], a["Accessibility/AccessibilityComponent.js"], a["Accessibility/KeyboardNavigationHandler.js"], a["Accessibility/Utils/ChartUtilities.js"],
        a["Accessibility/Utils/HTMLUtilities.js"]], function (a, f, l, m, n, g) {
            function h(b) { return b.exportSVGElements && b.exportSVGElements[0] } f = f.extend; var q = n.unhideChartElementFromAT, e = g.removeElement, d = g.getFakeMouseEvent; a.Chart.prototype.showExportMenu = function () { var b = h(this); if (b && (b = b.element, b.onclick)) b.onclick(d("click")) }; a.Chart.prototype.hideExportMenu = function () {
                var b = this.exportDivElements; b && this.exportContextMenu && (b.forEach(function (b) { if ("highcharts-menu-item" === b.className && b.onmouseout) b.onmouseout(d("mouseout")) }),
                    this.highlightedExportItemIx = 0, this.exportContextMenu.hideMenu(), this.container.focus())
            }; a.Chart.prototype.highlightExportItem = function (b) {
                var c = this.exportDivElements && this.exportDivElements[b], a = this.exportDivElements && this.exportDivElements[this.highlightedExportItemIx]; if (c && "LI" === c.tagName && (!c.children || !c.children.length)) {
                    var e = !!(this.renderTo.getElementsByTagName("g")[0] || {}).focus; c.focus && e && c.focus(); if (a && a.onmouseout) a.onmouseout(d("mouseout")); if (c.onmouseover) c.onmouseover(d("mouseover"));
                    this.highlightedExportItemIx = b; return !0
                } return !1
            }; a.Chart.prototype.highlightLastExportItem = function () { var b; if (this.exportDivElements) for (b = this.exportDivElements.length; b--;)if (this.highlightExportItem(b)) return !0; return !1 }; a = function () { }; a.prototype = new l; f(a.prototype, {
                init: function () { var b = this.chart, c = this; this.addEvent(b, "exportMenuShown", function () { c.onMenuShown() }); this.addEvent(b, "exportMenuHidden", function () { c.onMenuHidden() }) }, onMenuHidden: function () {
                    var b = this.chart.exportContextMenu;
                    b && b.setAttribute("aria-hidden", "true"); this.isExportMenuShown = !1; this.setExportButtonExpandedState("false")
                }, onMenuShown: function () { var b = this.chart, c = b.exportContextMenu; c && (this.addAccessibleContextMenuAttribs(), q(b, c)); this.isExportMenuShown = !0; this.setExportButtonExpandedState("true") }, setExportButtonExpandedState: function (b) { var c = this.exportButtonProxy; c && c.setAttribute("aria-expanded", b) }, onChartRender: function () {
                    var b = this.chart, c = b.options.accessibility; e(this.exportProxyGroup); var a = b.options.exporting,
                        d = h(b); a && !1 !== a.enabled && a.accessibility && a.accessibility.enabled && d && d.element && (this.exportProxyGroup = this.addProxyGroup("all" === c.landmarkVerbosity ? { "aria-label": b.langFormat("accessibility.exporting.exportRegionLabel", { chart: b }), role: "region" } : {}), c = h(this.chart), this.exportButtonProxy = this.createProxyButton(c, this.exportProxyGroup, { "aria-label": b.langFormat("accessibility.exporting.menuButtonLabel", { chart: b }), "aria-expanded": "false" }))
                }, addAccessibleContextMenuAttribs: function () {
                    var b = this.chart,
                    c = b.exportDivElements; c && c.length && (c.forEach(function (b) { "LI" !== b.tagName || b.children && b.children.length ? b.setAttribute("aria-hidden", "true") : b.setAttribute("tabindex", -1) }), c = c[0].parentNode, c.removeAttribute("aria-hidden"), c.setAttribute("aria-label", b.langFormat("accessibility.exporting.chartMenuLabel", { chart: b })))
                }, getKeyboardNavigation: function () {
                    var b = this.keyCodes, c = this.chart, a = this; return new m(c, {
                        keyCodeMap: [[[b.left, b.up], function () { return a.onKbdPrevious(this) }], [[b.right, b.down], function () { return a.onKbdNext(this) }],
                        [[b.enter, b.space], function () { return a.onKbdClick(this) }]], validate: function () { return c.exportChart && !1 !== c.options.exporting.enabled && !1 !== c.options.exporting.accessibility.enabled }, init: function () { var b = a.exportButtonProxy, d = c.exportingGroup; d && b && c.setFocusToElement(d, b) }, terminate: function () { c.hideExportMenu() }
                    })
                }, onKbdPrevious: function (b) {
                    var c = this.chart, a = c.options.accessibility; b = b.response; for (var d = c.highlightedExportItemIx || 0; d--;)if (c.highlightExportItem(d)) return b.success; return a.keyboardNavigation.wrapAround ?
                        (c.highlightLastExportItem(), b.success) : b.prev
                }, onKbdNext: function (b) { var c = this.chart, a = c.options.accessibility; b = b.response; for (var d = (c.highlightedExportItemIx || 0) + 1; d < c.exportDivElements.length; ++d)if (c.highlightExportItem(d)) return b.success; return a.keyboardNavigation.wrapAround ? (c.highlightExportItem(0), b.success) : b.next }, onKbdClick: function (b) {
                    var c = this.chart, a = c.exportDivElements[c.highlightedExportItemIx], d = h(c).element; this.isExportMenuShown ? this.fakeClickEvent(a) : (this.fakeClickEvent(d),
                        c.highlightExportItem(0)); return b.response.success
                }
            }); return a
        }); p(a, "Accessibility/Components/SeriesComponent/SeriesKeyboardNavigation.js", [a["Core/Series/Series.js"], a["Core/Series/CartesianSeries.js"], a["Core/Chart/Chart.js"], a["Core/Series/Point.js"], a["Core/Utilities.js"], a["Accessibility/KeyboardNavigationHandler.js"], a["Accessibility/Utils/EventProvider.js"], a["Accessibility/Utils/ChartUtilities.js"]], function (a, f, l, m, n, g, h, q) {
            function e(b) {
                var c = b.index, a = b.series.points, d = a.length; if (a[c] !==
                    b) for (; d--;) { if (a[d] === b) return d } else return c
            } function d(b) { var c = b.chart.options.accessibility.keyboardNavigation.seriesNavigation, a = b.options.accessibility || {}, d = a.keyboardNavigation; return d && !1 === d.enabled || !1 === a.enabled || !1 === b.options.enableMouseTracking || !b.visible || c.pointNavigationEnabledThreshold && c.pointNavigationEnabledThreshold <= b.points.length } function b(b) {
                var c = b.series.chart.options.accessibility; return b.isNull && c.keyboardNavigation.seriesNavigation.skipNullPoints || !1 === b.visible ||
                    d(b.series)
            } function c(b, c, a, d) { var r = Infinity, e = c.points.length, k = function (b) { return !(w(b.plotX) && w(b.plotY)) }; if (!k(b)) { for (; e--;) { var g = c.points[e]; if (!k(g) && (g = (b.plotX - g.plotX) * (b.plotX - g.plotX) * (a || 1) + (b.plotY - g.plotY) * (b.plotY - g.plotY) * (d || 1), g < r)) { r = g; var h = e } } return w(h) ? c.points[h] : void 0 } } function k(b) { var c = !1; delete b.highlightedPoint; return c = b.series.reduce(function (b, c) { return b || c.highlightFirstValidPoint() }, !1) } function t(b, c) { this.keyCodes = c; this.chart = b } var v = a.seriesTypes, w = n.defined;
            a = n.extend; var u = q.getPointFromXY, A = q.getSeriesFromName, p = q.scrollToPoint; f.prototype.keyboardMoveVertical = !0;["column", "pie"].forEach(function (b) { v[b] && (v[b].prototype.keyboardMoveVertical = !1) }); m.prototype.highlight = function () { var b = this.series.chart; if (this.isNull) b.tooltip && b.tooltip.hide(0); else this.onMouseOver(); p(this); this.graphic && b.setFocusToElement(this.graphic); b.highlightedPoint = this; return this }; l.prototype.highlightAdjacentPoint = function (c) {
                var a = this.series, k = this.highlightedPoint,
                r = k && e(k) || 0, g = k && k.series.points, h = this.series && this.series[this.series.length - 1]; h = h && h.points && h.points[h.points.length - 1]; if (!a[0] || !a[0].points) return !1; if (k) { if (a = a[k.series.index + (c ? 1 : -1)], r = g[r + (c ? 1 : -1)], !r && a && (r = a.points[c ? 0 : a.points.length - 1]), !r) return !1 } else r = c ? a[0].points[0] : h; return b(r) ? (a = r.series, d(a) ? this.highlightedPoint = c ? a.points[a.points.length - 1] : a.points[0] : this.highlightedPoint = r, this.highlightAdjacentPoint(c)) : r.highlight()
            }; f.prototype.highlightFirstValidPoint = function () {
                var c =
                    this.chart.highlightedPoint, a = (c && c.series) === this ? e(c) : 0; c = this.points; var d = c.length; if (c && d) { for (var r = a; r < d; ++r)if (!b(c[r])) return c[r].highlight(); for (; 0 <= a; --a)if (!b(c[a])) return c[a].highlight() } return !1
            }; l.prototype.highlightAdjacentSeries = function (b) {
                var a, k = this.highlightedPoint; var r = (a = this.series && this.series[this.series.length - 1]) && a.points && a.points[a.points.length - 1]; if (!this.highlightedPoint) return a = b ? this.series && this.series[0] : a, (r = b ? a && a.points && a.points[0] : r) ? r.highlight() : !1;
                a = this.series[k.series.index + (b ? -1 : 1)]; if (!a) return !1; r = c(k, a, 4); if (!r) return !1; if (d(a)) return r.highlight(), b = this.highlightAdjacentSeries(b), b ? b : (k.highlight(), !1); r.highlight(); return r.series.highlightFirstValidPoint()
            }; l.prototype.highlightAdjacentPointVertical = function (c) {
                var a = this.highlightedPoint, k = Infinity, r; if (!w(a.plotX) || !w(a.plotY)) return !1; this.series.forEach(function (e) {
                d(e) || e.points.forEach(function (d) {
                    if (w(d.plotY) && w(d.plotX) && d !== a) {
                        var g = d.plotY - a.plotY, h = Math.abs(d.plotX - a.plotX);
                        h = Math.abs(g) * Math.abs(g) + h * h * 4; e.yAxis && e.yAxis.reversed && (g *= -1); !(0 >= g && c || 0 <= g && !c || 5 > h || b(d)) && h < k && (k = h, r = d)
                    }
                })
                }); return r ? r.highlight() : !1
            }; a(t.prototype, {
                init: function () {
                    var b = this, c = this.chart, a = this.eventProvider = new h; a.addEvent(f, "destroy", function () { return b.onSeriesDestroy(this) }); a.addEvent(c, "afterDrilldown", function () { k(this); this.focusElement && this.focusElement.removeFocusBorder() }); a.addEvent(c, "drilldown", function (c) {
                        c = c.point; var a = c.series; b.lastDrilledDownPoint = {
                            x: c.x, y: c.y,
                            seriesName: a ? a.name : ""
                        }
                    }); a.addEvent(c, "drillupall", function () { setTimeout(function () { b.onDrillupAll() }, 10) })
                }, onDrillupAll: function () { var b = this.lastDrilledDownPoint, c = this.chart, a = b && A(c, b.seriesName), d; b && a && w(b.x) && w(b.y) && (d = u(a, b.x, b.y)); c.container && c.container.focus(); d && d.highlight && d.highlight(); c.focusElement && c.focusElement.removeFocusBorder() }, getKeyboardNavigationHandler: function () {
                    var b = this, c = this.keyCodes, a = this.chart, d = a.inverted; return new g(a, {
                        keyCodeMap: [[d ? [c.up, c.down] : [c.left,
                        c.right], function (c) { return b.onKbdSideways(this, c) }], [d ? [c.left, c.right] : [c.up, c.down], function (c) { return b.onKbdVertical(this, c) }], [[c.enter, c.space], function () { a.highlightedPoint && a.highlightedPoint.firePointEvent("click"); return this.response.success }]], init: function (c) { return b.onHandlerInit(this, c) }, terminate: function () { return b.onHandlerTerminate() }
                    })
                }, onKbdSideways: function (b, c) { var a = this.keyCodes; return this.attemptHighlightAdjacentPoint(b, c === a.right || c === a.down) }, onKbdVertical: function (b,
                    c) { var a = this.chart, d = this.keyCodes; c = c === d.down || c === d.right; d = a.options.accessibility.keyboardNavigation.seriesNavigation; if (d.mode && "serialize" === d.mode) return this.attemptHighlightAdjacentPoint(b, c); a[a.highlightedPoint && a.highlightedPoint.series.keyboardMoveVertical ? "highlightAdjacentPointVertical" : "highlightAdjacentSeries"](c); return b.response.success }, onHandlerInit: function (b, c) {
                        var a = this.chart; if (0 < c) k(a); else {
                            c = a.series.length; for (var d; c-- && !(a.highlightedPoint = a.series[c].points[a.series[c].points.length -
                                1], d = a.series[c].highlightFirstValidPoint()););
                        } return b.response.success
                    }, onHandlerTerminate: function () { var b, c, a = this.chart, d = a.highlightedPoint; null === (b = a.tooltip) || void 0 === b ? void 0 : b.hide(0); null === (c = null === d || void 0 === d ? void 0 : d.onMouseOut) || void 0 === c ? void 0 : c.call(d); delete a.highlightedPoint }, attemptHighlightAdjacentPoint: function (b, c) {
                        var a = this.chart, d = a.options.accessibility.keyboardNavigation.wrapAround; return a.highlightAdjacentPoint(c) ? b.response.success : d ? b.init(c ? 1 : -1) : b.response[c ?
                            "next" : "prev"]
                    }, onSeriesDestroy: function (b) { var c = this.chart; c.highlightedPoint && c.highlightedPoint.series === b && (delete c.highlightedPoint, c.focusElement && c.focusElement.removeFocusBorder()) }, destroy: function () { this.eventProvider.removeAddedEvents() }
            }); return t
        }); p(a, "Accessibility/Components/AnnotationsA11y.js", [a["Accessibility/Utils/HTMLUtilities.js"]], function (a) {
            function f(a) {
                return (a.annotations || []).reduce(function (a, d) {
                    var b; !1 !== (null === (b = d.options) || void 0 === b ? void 0 : b.visible) && (a = a.concat(d.labels));
                    return a
                }, [])
            } function l(a) { var e, d, b, c, k = null === (d = null === (e = a.options) || void 0 === e ? void 0 : e.accessibility) || void 0 === d ? void 0 : d.description; return k ? k : (null === (c = null === (b = a.graphic) || void 0 === b ? void 0 : b.text) || void 0 === c ? void 0 : c.textStr) || "" } function m(a) {
                var e, d, b = null === (d = null === (e = a.options) || void 0 === e ? void 0 : e.accessibility) || void 0 === d ? void 0 : d.description; if (b) return b; e = a.chart; d = l(a); b = a.points.filter(function (b) { return !!b.graphic }).map(function (b) {
                    var c, a; if (!(a = null === (c = null === b ||
                        void 0 === b ? void 0 : b.accessibility) || void 0 === c ? void 0 : c.valueDescription)) { var d, e; a = (null === (e = null === (d = null === b || void 0 === b ? void 0 : b.graphic) || void 0 === d ? void 0 : d.element) || void 0 === e ? void 0 : e.getAttribute("aria-label")) || "" } b = (null === b || void 0 === b ? void 0 : b.series.name) || ""; return (b ? b + ", " : "") + "data point " + a
                }).filter(function (b) { return !!b }); var c = b.length; a = "accessibility.screenReaderSection.annotations.description" + (1 < c ? "MultiplePoints" : c ? "SinglePoint" : "NoPoints"); d = {
                    annotationText: d, numPoints: c,
                    annotationPoint: b[0], additionalAnnotationPoints: b.slice(1)
                }; return e.langFormat(a, d)
            } function n(a) { return f(a).map(function (a) { return (a = g(h(m(a)))) ? "<li>" + a + "</li>" : "" }) } var g = a.escapeStringForHTML, h = a.stripHTMLTagsFromString; return {
                getAnnotationsInfoHTML: function (a) { var e = a.annotations; return e && e.length ? "<ul>" + n(a).join(" ") + "</ul>" : "" }, getAnnotationLabelDescription: m, getAnnotationListItems: n, getPointAnnotationTexts: function (a) {
                    var e = f(a.series.chart).filter(function (d) { return -1 < d.points.indexOf(a) });
                    return e.length ? e.map(function (a) { return "" + l(a) }) : []
                }
            }
        }); p(a, "Accessibility/Components/SeriesComponent/SeriesDescriber.js", [a["Accessibility/Components/AnnotationsA11y.js"], a["Accessibility/Utils/ChartUtilities.js"], a["Accessibility/Utils/HTMLUtilities.js"], a["Core/Tooltip.js"], a["Core/Utilities.js"]], function (a, f, l, m, n) {
            function g(b) {
                var c = b.index; return b.series && b.series.data && G(c) ? K(b.series.data, function (b) { return !!(b && "undefined" !== typeof b.index && b.index > c && b.graphic && b.graphic.element) }) ||
                    null : null
            } function h(b) { var c = b.chart.options.accessibility.series.pointDescriptionEnabledThreshold; return !!(!1 !== c && b.points && b.points.length >= c) } function q(b) { var c = b.options.accessibility || {}; return !h(b) && !c.exposeAsGroupOnly } function e(b) { var c = b.chart.options.accessibility.keyboardNavigation.seriesNavigation; return !(!b.points || !(b.points.length < c.pointNavigationEnabledThreshold || !1 === c.pointNavigationEnabledThreshold)) } function d(b, c) {
                var a = b.series.chart, d = a.options.accessibility.point || {};
                b = b.series.tooltipOptions || {}; a = a.options.lang; return L(c) ? M(c, d.valueDecimals || b.valueDecimals || -1, a.decimalPoint, a.accessibility.thousandsSep || a.thousandsSep) : c
            } function b(b) { var c = (b.options.accessibility || {}).description; return c && b.chart.langFormat("accessibility.series.description", { description: c, series: b }) || "" } function c(b, c) { return b.chart.langFormat("accessibility.series." + c + "Description", { name: x(b[c]), series: b }) } function k(b) {
                var c = b.series, a = c.chart, d = a.options.accessibility.point || {};
                if (c.xAxis && c.xAxis.dateTime) return c = m.prototype.getXDateFormat.call({ getDateFormat: m.prototype.getDateFormat, chart: a }, b, a.options.tooltip, c.xAxis), d = d.dateFormatter && d.dateFormatter(b) || d.dateFormat || c, a.time.dateFormat(d, b.x, void 0)
            } function t(b) { var c = k(b), a = (b.series.xAxis || {}).categories && G(b.category) && ("" + b.category).replace("<br/>", " "), d = b.id && 0 > b.id.indexOf("highcharts-"), e = "x, " + b.x; return b.name || c || a || (d ? b.id : e) } function v(b, c, a) {
                var e = c || "", k = a || ""; return b.series.pointArrayMap.reduce(function (c,
                    a) { c += c.length ? ", " : ""; var r = d(b, C(b[a], b.options[a])); return c + (a + ": " + e + r + k) }, "")
            } function w(b) { var c = b.series, a = c.chart.options.accessibility.point || {}, e = c.tooltipOptions || {}, k = a.valuePrefix || e.valuePrefix || ""; a = a.valueSuffix || e.valueSuffix || ""; e = d(b, b["undefined" !== typeof b.value ? "value" : "y"]); return b.isNull ? c.chart.langFormat("accessibility.series.nullPointValue", { point: b }) : c.pointArrayMap ? v(b, k, a) : k + e + a } function u(b) {
                var c = b.series, a = c.chart, d = a.options.accessibility.point.valueDescriptionFormat,
                e = (c = C(c.xAxis && c.xAxis.options.accessibility && c.xAxis.options.accessibility.enabled, !a.angular)) ? t(b) : ""; b = { point: b, index: G(b.index) ? b.index + 1 : "", xDescription: e, value: w(b), separator: c ? ", " : "" }; return N(d, b, a)
            } function A(b) {
                var c = b.series, a = c.chart, d = u(b), e = b.options && b.options.accessibility && b.options.accessibility.description; e = e ? " " + e : ""; c = 1 < a.series.length && c.name ? " " + c.name + "." : ""; a = b.series.chart; var k = z(b), r = { point: b, annotations: k }; a = k.length ? a.langFormat("accessibility.series.pointAnnotationsDescription",
                    r) : ""; b.accessibility = b.accessibility || {}; b.accessibility.valueDescription = d; return d + e + c + (a ? " " + a : "")
            } function p(b) {
                var c = q(b), a = e(b); (c || a) && b.points.forEach(function (b) {
                    var a; if (!(a = b.graphic && b.graphic.element) && (a = b.series && b.series.is("sunburst"), a = b.isNull && !a)) {
                        var d = b.series, e = g(b); d = (a = e && e.graphic) ? a.parentGroup : d.graph || d.group; e = e ? { x: C(b.plotX, e.plotX, 0), y: C(b.plotY, e.plotY, 0) } : { x: C(b.plotX, 0), y: C(b.plotY, 0) }; e = b.series.chart.renderer.rect(e.x, e.y, 1, 1); e.attr({
                            "class": "highcharts-a11y-dummy-point",
                            fill: "none", opacity: 0, "fill-opacity": 0, "stroke-opacity": 0
                        }); d && d.element ? (b.graphic = e, b.hasDummyGraphic = !0, e.add(d), d.element.insertBefore(e.element, a ? a.element : null), a = e.element) : a = void 0
                    } a && (a.setAttribute("tabindex", "-1"), a.style.outline = "0", c ? (e = b.series, d = e.chart.options.accessibility.point || {}, e = e.options.accessibility || {}, b = B(I(e.pointDescriptionFormatter && e.pointDescriptionFormatter(b) || d.descriptionFormatter && d.descriptionFormatter(b) || A(b))), a.setAttribute("role", "img"), a.setAttribute("aria-label",
                        b)) : a.setAttribute("aria-hidden", !0))
                })
            } function y(a) { var d = a.chart, e = d.types || [], k = b(a), r = function (b) { return d[b] && 1 < d[b].length && a[b] }, g = c(a, "xAxis"), h = c(a, "yAxis"), f = { name: a.name || "", ix: a.index + 1, numSeries: d.series && d.series.length, numPoints: a.points && a.points.length, series: a }; e = 1 < e.length ? "Combination" : ""; return (d.langFormat("accessibility.series.summary." + a.type + e, f) || d.langFormat("accessibility.series.summary.default" + e, f)) + (k ? " " + k : "") + (r("yAxis") ? " " + h : "") + (r("xAxis") ? " " + g : "") } var z = a.getPointAnnotationTexts,
                x = f.getAxisDescription, r = f.getSeriesFirstPointElement, J = f.getSeriesA11yElement, F = f.unhideChartElementFromAT, B = l.escapeStringForHTML, E = l.reverseChildNodes, I = l.stripHTMLTagsFromString, K = n.find, N = n.format, L = n.isNumber, M = n.numberFormat, C = n.pick, G = n.defined; return {
                    describeSeries: function (b) {
                        var c = b.chart, a = r(b), d = J(b), e = c.is3d && c.is3d(); if (d) {
                        d.lastChild !== a || e || E(d); p(b); F(c, d); e = b.chart; c = e.options.chart || {}; a = 1 < e.series.length; e = e.options.accessibility.series.describeSingleSeries; var k = (b.options.accessibility ||
                            {}).exposeAsGroupOnly; c.options3d && c.options3d.enabled && a || !(a || e || k || h(b)) ? d.setAttribute("aria-label", "") : (c = b.chart.options.accessibility, a = c.landmarkVerbosity, (b.options.accessibility || {}).exposeAsGroupOnly ? d.setAttribute("role", "img") : "all" === a && d.setAttribute("role", "region"), d.setAttribute("tabindex", "-1"), d.style.outline = "0", d.setAttribute("aria-label", B(I(c.series.descriptionFormatter && c.series.descriptionFormatter(b) || y(b)))))
                        }
                    }, defaultPointDescriptionFormatter: A, defaultSeriesDescriptionFormatter: y,
                    getPointA11yTimeDescription: k, getPointXDescription: t, getPointValue: w, getPointValueDescription: u
                }
        }); p(a, "Accessibility/Utils/Announcer.js", [a["Core/Globals.js"], a["Accessibility/Utils/DOMElementProvider.js"], a["Accessibility/Utils/HTMLUtilities.js"]], function (a, f, l) {
            var m = l.visuallyHideElement; l = function () {
                function a(a, h) { this.chart = a; this.domElementProvider = new f; this.announceRegion = this.addAnnounceRegion(h) } a.prototype.destroy = function () { this.domElementProvider.destroyCreatedElements() }; a.prototype.announce =
                    function (a) { var g = this; this.announceRegion.innerHTML = a; this.clearAnnouncementRegionTimer && clearTimeout(this.clearAnnouncementRegionTimer); this.clearAnnouncementRegionTimer = setTimeout(function () { g.announceRegion.innerHTML = ""; delete g.clearAnnouncementRegionTimer }, 1E3) }; a.prototype.addAnnounceRegion = function (a) { var g = this.chart.renderTo, f = this.domElementProvider.createElement("div"); f.setAttribute("aria-hidden", !1); f.setAttribute("aria-live", a); m(f); g.insertBefore(f, g.firstChild); return f }; return a
            }();
            return a.Announcer = l
        }); p(a, "Accessibility/Components/SeriesComponent/NewDataAnnouncer.js", [a["Core/Globals.js"], a["Core/Series/CartesianSeries.js"], a["Core/Utilities.js"], a["Accessibility/Utils/ChartUtilities.js"], a["Accessibility/Components/SeriesComponent/SeriesDescriber.js"], a["Accessibility/Utils/Announcer.js"], a["Accessibility/Utils/EventProvider.js"]], function (a, f, l, m, n, g, h) {
            function q(b) { var c = b.series.data.filter(function (c) { return b.x === c.x && b.y === c.y }); return 1 === c.length ? c[0] : b } function e(b,
                c) { var a = (b || []).concat(c || []).reduce(function (b, c) { b[c.name + c.index] = c; return b }, {}); return Object.keys(a).map(function (b) { return a[b] }) } var d = l.extend, b = l.defined, c = m.getChartTitle, k = n.defaultPointDescriptionFormatter, t = n.defaultSeriesDescriptionFormatter; l = function (b) { this.chart = b }; d(l.prototype, {
                    init: function () {
                        var b = this.chart, c = b.options.accessibility.announceNewData.interruptUser ? "assertive" : "polite"; this.lastAnnouncementTime = 0; this.dirty = { allSeries: {} }; this.eventProvider = new h; this.announcer =
                            new g(b, c); this.addEventListeners()
                    }, destroy: function () { this.eventProvider.removeAddedEvents(); this.announcer.destroy() }, addEventListeners: function () { var b = this, c = this.chart, a = this.eventProvider; a.addEvent(c, "afterDrilldown", function () { b.lastAnnouncementTime = 0 }); a.addEvent(f, "updatedData", function () { b.onSeriesUpdatedData(this) }); a.addEvent(c, "afterAddSeries", function (c) { b.onSeriesAdded(c.series) }); a.addEvent(f, "addPoint", function (c) { b.onPointAdded(c.point) }); a.addEvent(c, "redraw", function () { b.announceDirtyData() }) },
                    onSeriesUpdatedData: function (b) { var c = this.chart; b.chart === c && c.options.accessibility.announceNewData.enabled && (this.dirty.hasDirty = !0, this.dirty.allSeries[b.name + b.index] = b) }, onSeriesAdded: function (c) { this.chart.options.accessibility.announceNewData.enabled && (this.dirty.hasDirty = !0, this.dirty.allSeries[c.name + c.index] = c, this.dirty.newSeries = b(this.dirty.newSeries) ? void 0 : c) }, onPointAdded: function (c) {
                        var a = c.series.chart; this.chart === a && a.options.accessibility.announceNewData.enabled && (this.dirty.newPoint =
                            b(this.dirty.newPoint) ? void 0 : c)
                    }, announceDirtyData: function () { var b = this; if (this.chart.options.accessibility.announceNewData && this.dirty.hasDirty) { var c = this.dirty.newPoint; c && (c = q(c)); this.queueAnnouncement(Object.keys(this.dirty.allSeries).map(function (c) { return b.dirty.allSeries[c] }), this.dirty.newSeries, c); this.dirty = { allSeries: {} } } }, queueAnnouncement: function (b, c, a) {
                        var d = this, k = this.chart.options.accessibility.announceNewData; if (k.enabled) {
                            var g = +new Date; k = Math.max(0, k.minAnnounceInterval -
                                (g - this.lastAnnouncementTime)); b = e(this.queuedAnnouncement && this.queuedAnnouncement.series, b); if (c = this.buildAnnouncementMessage(b, c, a)) this.queuedAnnouncement && clearTimeout(this.queuedAnnouncementTimer), this.queuedAnnouncement = { time: g, message: c, series: b }, this.queuedAnnouncementTimer = setTimeout(function () { d && d.announcer && (d.lastAnnouncementTime = +new Date, d.announcer.announce(d.queuedAnnouncement.message), delete d.queuedAnnouncement, delete d.queuedAnnouncementTimer) }, k)
                        }
                    }, buildAnnouncementMessage: function (b,
                        d, e) { var g = this.chart, h = g.options.accessibility.announceNewData; if (h.announcementFormatter && (b = h.announcementFormatter(b, d, e), !1 !== b)) return b.length ? b : null; b = a.charts && 1 < a.charts.length ? "Multiple" : "Single"; b = d ? "newSeriesAnnounce" + b : e ? "newPointAnnounce" + b : "newDataAnnounce"; h = c(g); return g.langFormat("accessibility.announceNewData." + b, { chartTitle: h, seriesDesc: d ? t(d) : null, pointDesc: e ? k(e) : null, point: e, series: d }) }
                }); return l
        }); p(a, "Accessibility/Components/SeriesComponent/ForcedMarkers.js", [a["Core/Series/CartesianSeries.js"],
        a["Core/Utilities.js"]], function (a, f) {
            function l(a) { n(!0, a, { marker: { enabled: !0, states: { normal: { opacity: 0 } } } }) } var m = f.addEvent, n = f.merge; return function () {
                m(a, "render", function () {
                    var a = this.options, h = !1 !== (this.options.accessibility && this.options.accessibility.enabled); if (h = this.chart.options.accessibility.enabled && h) h = this.chart.options.accessibility, h = this.points.length < h.series.pointDescriptionEnabledThreshold || !1 === h.series.pointDescriptionEnabledThreshold; if (h) {
                        if (a.marker && !1 === a.marker.enabled &&
                            (this.a11yMarkersForced = !0, l(this.options)), this._hasPointMarkers && this.points && this.points.length) for (a = this.points.length; a--;) { h = this.points[a]; var f = h.options; delete h.hasForcedA11yMarker; f.marker && (f.marker.enabled ? (n(!0, f.marker, { states: { normal: { opacity: f.marker.states && f.marker.states.normal && f.marker.states.normal.opacity || 1 } } }), h.hasForcedA11yMarker = !1) : (l(f), h.hasForcedA11yMarker = !0)) }
                    } else this.a11yMarkersForced && (delete this.a11yMarkersForced, (a = this.resetA11yMarkerOptions) && n(!0, this.options,
                        { marker: { enabled: a.enabled, states: { normal: { opacity: a.states && a.states.normal && a.states.normal.opacity } } } }))
                }); m(a, "afterSetOptions", function (a) { this.resetA11yMarkerOptions = n(a.options.marker || {}, this.userOptions.marker || {}) }); m(a, "afterRender", function () {
                    if (this.chart.styledMode) {
                        if (this.markerGroup) this.markerGroup[this.a11yMarkersForced ? "addClass" : "removeClass"]("highcharts-a11y-markers-hidden"); this._hasPointMarkers && this.points && this.points.length && this.points.forEach(function (a) {
                        a.graphic && (a.graphic[a.hasForcedA11yMarker ?
                            "addClass" : "removeClass"]("highcharts-a11y-marker-hidden"), a.graphic[!1 === a.hasForcedA11yMarker ? "addClass" : "removeClass"]("highcharts-a11y-marker-visible"))
                        })
                    }
                })
            }
        }); p(a, "Accessibility/Components/SeriesComponent/SeriesComponent.js", [a["Core/Globals.js"], a["Core/Utilities.js"], a["Accessibility/AccessibilityComponent.js"], a["Accessibility/Components/SeriesComponent/SeriesKeyboardNavigation.js"], a["Accessibility/Components/SeriesComponent/NewDataAnnouncer.js"], a["Accessibility/Components/SeriesComponent/ForcedMarkers.js"],
        a["Accessibility/Utils/ChartUtilities.js"], a["Accessibility/Components/SeriesComponent/SeriesDescriber.js"], a["Core/Tooltip.js"]], function (a, f, l, m, n, g, h, q, e) {
            f = f.extend; var d = h.hideSeriesFromAT, b = q.describeSeries; a.SeriesAccessibilityDescriber = q; g(); a = function () { }; a.prototype = new l; f(a.prototype, {
                init: function () {
                this.newDataAnnouncer = new n(this.chart); this.newDataAnnouncer.init(); this.keyboardNavigation = new m(this.chart, this.keyCodes); this.keyboardNavigation.init(); this.hideTooltipFromATWhenShown();
                    this.hideSeriesLabelsFromATWhenShown()
                }, hideTooltipFromATWhenShown: function () { var b = this; this.addEvent(e, "refresh", function () { this.chart === b.chart && this.label && this.label.element && this.label.element.setAttribute("aria-hidden", !0) }) }, hideSeriesLabelsFromATWhenShown: function () { this.addEvent(this.chart, "afterDrawSeriesLabels", function () { this.series.forEach(function (b) { b.labelBySeries && b.labelBySeries.attr("aria-hidden", !0) }) }) }, onChartRender: function () {
                    this.chart.series.forEach(function (c) {
                    !1 !== (c.options.accessibility &&
                        c.options.accessibility.enabled) && c.visible ? b(c) : d(c)
                    })
                }, getKeyboardNavigation: function () { return this.keyboardNavigation.getKeyboardNavigationHandler() }, destroy: function () { this.newDataAnnouncer.destroy(); this.keyboardNavigation.destroy() }
            }); return a
        }); p(a, "Accessibility/Components/ZoomComponent.js", [a["Accessibility/AccessibilityComponent.js"], a["Accessibility/Utils/ChartUtilities.js"], a["Core/Globals.js"], a["Accessibility/Utils/HTMLUtilities.js"], a["Accessibility/KeyboardNavigationHandler.js"], a["Core/Utilities.js"]],
            function (a, f, l, m, n, g) {
                var h = f.unhideChartElementFromAT; f = l.noop; var q = m.removeElement, e = m.setElAttrs; m = g.extend; var d = g.pick; l.Axis.prototype.panStep = function (b, c) { var a = c || 3; c = this.getExtremes(); var d = (c.max - c.min) / a * b; a = c.max + d; d = c.min + d; var e = a - d; 0 > b && d < c.dataMin ? (d = c.dataMin, a = d + e) : 0 < b && a > c.dataMax && (a = c.dataMax, d = a - e); this.setExtremes(d, a) }; f.prototype = new a; m(f.prototype, {
                    init: function () {
                        var b = this, c = this.chart;["afterShowResetZoom", "afterDrilldown", "drillupall"].forEach(function (a) {
                            b.addEvent(c,
                                a, function () { b.updateProxyOverlays() })
                        })
                    }, onChartUpdate: function () { var b = this.chart, c = this; b.mapNavButtons && b.mapNavButtons.forEach(function (a, d) { h(b, a.element); c.setMapNavButtonAttrs(a.element, "accessibility.zoom.mapZoom" + (d ? "Out" : "In")) }) }, setMapNavButtonAttrs: function (b, c) { var a = this.chart; c = a.langFormat(c, { chart: a }); e(b, { tabindex: -1, role: "button", "aria-label": c }) }, onChartRender: function () { this.updateProxyOverlays() }, updateProxyOverlays: function () {
                        var b = this.chart; q(this.drillUpProxyGroup); q(this.resetZoomProxyGroup);
                        b.resetZoomButton && this.recreateProxyButtonAndGroup(b.resetZoomButton, "resetZoomProxyButton", "resetZoomProxyGroup", b.langFormat("accessibility.zoom.resetZoomButton", { chart: b })); b.drillUpButton && this.recreateProxyButtonAndGroup(b.drillUpButton, "drillUpProxyButton", "drillUpProxyGroup", b.langFormat("accessibility.drillUpButton", { chart: b, buttonText: b.getDrilldownBackText() }))
                    }, recreateProxyButtonAndGroup: function (b, c, a, d) {
                        q(this[a]); this[a] = this.addProxyGroup(); this[c] = this.createProxyButton(b, this[a],
                            { "aria-label": d, tabindex: -1 })
                    }, getMapZoomNavigation: function () { var b = this.keyCodes, a = this.chart, d = this; return new n(a, { keyCodeMap: [[[b.up, b.down, b.left, b.right], function (b) { return d.onMapKbdArrow(this, b) }], [[b.tab], function (b, a) { return d.onMapKbdTab(this, a) }], [[b.space, b.enter], function () { return d.onMapKbdClick(this) }]], validate: function () { return !!(a.mapZoom && a.mapNavButtons && a.mapNavButtons.length) }, init: function (b) { return d.onMapNavInit(b) } }) }, onMapKbdArrow: function (b, a) {
                        var c = this.keyCodes; this.chart[a ===
                            c.up || a === c.down ? "yAxis" : "xAxis"][0].panStep(a === c.left || a === c.up ? -1 : 1); return b.response.success
                    }, onMapKbdTab: function (b, a) { var c = this.chart; b = b.response; var d = (a = a.shiftKey) && !this.focusedMapNavButtonIx || !a && this.focusedMapNavButtonIx; c.mapNavButtons[this.focusedMapNavButtonIx].setState(0); if (d) return c.mapZoom(), b[a ? "prev" : "next"]; this.focusedMapNavButtonIx += a ? -1 : 1; a = c.mapNavButtons[this.focusedMapNavButtonIx]; c.setFocusToElement(a.box, a.element); a.setState(2); return b.success }, onMapKbdClick: function (b) {
                        this.fakeClickEvent(this.chart.mapNavButtons[this.focusedMapNavButtonIx].element);
                        return b.response.success
                    }, onMapNavInit: function (b) { var a = this.chart, d = a.mapNavButtons[0], e = a.mapNavButtons[1]; d = 0 < b ? d : e; a.setFocusToElement(d.box, d.element); d.setState(2); this.focusedMapNavButtonIx = 0 < b ? 0 : 1 }, simpleButtonNavigation: function (b, a, e) {
                        var c = this.keyCodes, k = this, g = this.chart; return new n(g, {
                            keyCodeMap: [[[c.tab, c.up, c.down, c.left, c.right], function (b, a) { return this.response[b === c.tab && a.shiftKey || b === c.left || b === c.up ? "prev" : "next"] }], [[c.space, c.enter], function () {
                                var b = e(this, g); return d(b,
                                    this.response.success)
                            }]], validate: function () { return g[b] && g[b].box && k[a] }, init: function () { g.setFocusToElement(g[b].box, k[a]) }
                        })
                    }, getKeyboardNavigation: function () { return [this.simpleButtonNavigation("resetZoomButton", "resetZoomProxyButton", function (b, a) { a.zoomOut() }), this.simpleButtonNavigation("drillUpButton", "drillUpProxyButton", function (b, a) { a.drillUp(); return b.response.prev }), this.getMapZoomNavigation()] }
                }); return f
            }); p(a, "Accessibility/Components/RangeSelectorComponent.js", [a["Accessibility/AccessibilityComponent.js"],
            a["Accessibility/Utils/ChartUtilities.js"], a["Core/Globals.js"], a["Accessibility/Utils/HTMLUtilities.js"], a["Accessibility/KeyboardNavigationHandler.js"], a["Core/Utilities.js"]], function (a, f, l, m, n, g) {
                var h = f.unhideChartElementFromAT, q = m.setElAttrs; f = g.extend; l.Chart.prototype.highlightRangeSelectorButton = function (a) {
                    var d = this.rangeSelector.buttons, b = this.highlightedRangeSelectorItemIx; "undefined" !== typeof b && d[b] && d[b].setState(this.oldRangeSelectorItemState || 0); this.highlightedRangeSelectorItemIx =
                        a; return d[a] ? (this.setFocusToElement(d[a].box, d[a].element), this.oldRangeSelectorItemState = d[a].state, d[a].setState(2), !0) : !1
                }; l = function () { }; l.prototype = new a; f(l.prototype, {
                    onChartUpdate: function () {
                        var a = this.chart, d = this, b = a.rangeSelector; b && (b.buttons && b.buttons.length && b.buttons.forEach(function (b) { h(a, b.element); d.setRangeButtonAttrs(b) }), b.maxInput && b.minInput && ["minInput", "maxInput"].forEach(function (c, e) {
                            if (c = b[c]) h(a, c), d.setRangeInputAttrs(c, "accessibility.rangeSelector." + (e ? "max" : "min") +
                                "InputLabel")
                        }))
                    }, setRangeButtonAttrs: function (a) { var d = this.chart; d = d.langFormat("accessibility.rangeSelector.buttonText", { chart: d, buttonText: a.text && a.text.textStr }); q(a.element, { tabindex: -1, role: "button", "aria-label": d }) }, setRangeInputAttrs: function (a, d) { var b = this.chart; q(a, { tabindex: -1, role: "textbox", "aria-label": b.langFormat(d, { chart: b }) }) }, getRangeSelectorButtonNavigation: function () {
                        var a = this.chart, d = this.keyCodes, b = this; return new n(a, {
                            keyCodeMap: [[[d.left, d.right, d.up, d.down], function (a) {
                                return b.onButtonNavKbdArrowKey(this,
                                    a)
                            }], [[d.enter, d.space], function () { return b.onButtonNavKbdClick(this) }]], validate: function () { return a.rangeSelector && a.rangeSelector.buttons && a.rangeSelector.buttons.length }, init: function (b) { var c = a.rangeSelector.buttons.length - 1; a.highlightRangeSelectorButton(0 < b ? 0 : c) }
                        })
                    }, onButtonNavKbdArrowKey: function (a, d) {
                        var b = a.response, c = this.keyCodes, e = this.chart, g = e.options.accessibility.keyboardNavigation.wrapAround; d = d === c.left || d === c.up ? -1 : 1; return e.highlightRangeSelectorButton(e.highlightedRangeSelectorItemIx +
                            d) ? b.success : g ? (a.init(d), b.success) : b[0 < d ? "next" : "prev"]
                    }, onButtonNavKbdClick: function (a) { a = a.response; var d = this.chart; 3 !== d.oldRangeSelectorItemState && this.fakeClickEvent(d.rangeSelector.buttons[d.highlightedRangeSelectorItemIx].element); return a.success }, getRangeSelectorInputNavigation: function () {
                        var a = this.chart, d = this.keyCodes, b = this; return new n(a, {
                            keyCodeMap: [[[d.tab, d.up, d.down], function (a, e) { return b.onInputKbdMove(this, a === d.tab && e.shiftKey || a === d.up ? -1 : 1) }]], validate: function () {
                                return a.rangeSelector &&
                                    a.rangeSelector.inputGroup && "hidden" !== a.rangeSelector.inputGroup.element.getAttribute("visibility") && !1 !== a.options.rangeSelector.inputEnabled && a.rangeSelector.minInput && a.rangeSelector.maxInput
                            }, init: function (a) { b.onInputNavInit(a) }, terminate: function () { b.onInputNavTerminate() }
                        })
                    }, onInputKbdMove: function (a, d) { var b = this.chart; a = a.response; var c = b.highlightedInputRangeIx += d; if (1 < c || 0 > c) return a[0 < d ? "next" : "prev"]; b.rangeSelector[c ? "maxInput" : "minInput"].focus(); return a.success }, onInputNavInit: function (a) {
                        var d =
                            this.chart; a = 0 < a ? 0 : 1; d.highlightedInputRangeIx = a; d.rangeSelector[a ? "maxInput" : "minInput"].focus()
                    }, onInputNavTerminate: function () { var a = this.chart.rangeSelector || {}; a.maxInput && a.hideInput("max"); a.minInput && a.hideInput("min") }, getKeyboardNavigation: function () { return [this.getRangeSelectorButtonNavigation(), this.getRangeSelectorInputNavigation()] }
                }); return l
            }); p(a, "Accessibility/Components/InfoRegionsComponent.js", [a["Core/Globals.js"], a["Core/Utilities.js"], a["Accessibility/AccessibilityComponent.js"],
            a["Accessibility/Utils/Announcer.js"], a["Accessibility/Components/AnnotationsA11y.js"], a["Accessibility/Utils/ChartUtilities.js"], a["Accessibility/Utils/HTMLUtilities.js"]], function (a, f, l, m, n, g, h) {
                function q(b) { return b.replace(/&lt;(h[1-7]|p|div|ul|ol|li)&gt;/g, "<$1>").replace(/&lt;&#x2F;(h[1-7]|p|div|ul|ol|li|a|button)&gt;/g, "</$1>").replace(/&lt;(div|a|button) id=&quot;([a-zA-Z\-0-9#]*?)&quot;&gt;/g, '<$1 id="$2">') } var e = a.doc, d = f.extend, b = f.format, c = f.pick, k = n.getAnnotationsInfoHTML, t = g.unhideChartElementFromAT,
                    v = g.getChartTitle, w = g.getAxisDescription, p = h.addClass, u = h.setElAttrs, D = h.escapeStringForHTML, y = h.stripHTMLTagsFromString, z = h.getElement, x = h.visuallyHideElement; a.Chart.prototype.getTypeDescription = function (b) {
                        var a = b[0], c = this.series && this.series[0] || {}; c = { numSeries: this.series.length, numPoints: c.points && c.points.length, chart: this, mapTitle: c.mapTitle }; if (!a) return this.langFormat("accessibility.chartTypes.emptyChart", c); if ("map" === a) return c.mapTitle ? this.langFormat("accessibility.chartTypes.mapTypeDescription",
                            c) : this.langFormat("accessibility.chartTypes.unknownMap", c); if (1 < this.types.length) return this.langFormat("accessibility.chartTypes.combinationChart", c); b = b[0]; a = this.langFormat("accessibility.seriesTypeDescriptions." + b, c); var d = this.series && 2 > this.series.length ? "Single" : "Multiple"; return (this.langFormat("accessibility.chartTypes." + b + d, c) || this.langFormat("accessibility.chartTypes.default" + d, c)) + (a ? " " + a : "")
                    }; f = function () { }; f.prototype = new l; d(f.prototype, {
                        init: function () {
                            var b = this.chart, a = this;
                            this.initRegionsDefinitions(); this.addEvent(b, "afterGetTable", function (b) { a.onDataTableCreated(b) }); this.addEvent(b, "afterViewData", function (b) { a.dataTableDiv = b; setTimeout(function () { a.focusDataTable() }, 300) }); this.announcer = new m(b, "assertive")
                        }, initRegionsDefinitions: function () {
                            var b = this; this.screenReaderSections = {
                                before: {
                                    element: null, buildContent: function (a) { var c = a.options.accessibility.screenReaderSection.beforeChartFormatter; return c ? c(a) : b.defaultBeforeChartFormatter(a) }, insertIntoDOM: function (b,
                                        a) { a.renderTo.insertBefore(b, a.renderTo.firstChild) }, afterInserted: function () { "undefined" !== typeof b.sonifyButtonId && b.initSonifyButton(b.sonifyButtonId); "undefined" !== typeof b.dataTableButtonId && b.initDataTableButton(b.dataTableButtonId) }
                                }, after: { element: null, buildContent: function (a) { var c = a.options.accessibility.screenReaderSection.afterChartFormatter; return c ? c(a) : b.defaultAfterChartFormatter() }, insertIntoDOM: function (b, a) { a.renderTo.insertBefore(b, a.container.nextSibling) } }
                            }
                        }, onChartRender: function () {
                            var b =
                                this; this.linkedDescriptionElement = this.getLinkedDescriptionElement(); this.setLinkedDescriptionAttrs(); Object.keys(this.screenReaderSections).forEach(function (a) { b.updateScreenReaderSection(a) })
                        }, getLinkedDescriptionElement: function () { var a = this.chart.options.accessibility.linkedDescription; if (a) { if ("string" !== typeof a) return a; a = b(a, this.chart); a = e.querySelectorAll(a); if (1 === a.length) return a[0] } }, setLinkedDescriptionAttrs: function () {
                            var b = this.linkedDescriptionElement; b && (b.setAttribute("aria-hidden",
                                "true"), p(b, "highcharts-linked-description"))
                        }, updateScreenReaderSection: function (b) { var a = this.chart, c = this.screenReaderSections[b], d = c.buildContent(a), e = c.element = c.element || this.createElement("div"), g = e.firstChild || this.createElement("div"); this.setScreenReaderSectionAttribs(e, b); g.innerHTML = d; e.appendChild(g); c.insertIntoDOM(e, a); x(g); t(a, g); c.afterInserted && c.afterInserted() }, setScreenReaderSectionAttribs: function (b, a) {
                            var c = this.chart, d = c.langFormat("accessibility.screenReaderSection." + a + "RegionLabel",
                                { chart: c }); u(b, { id: "highcharts-screen-reader-region-" + a + "-" + c.index, "aria-label": d }); b.style.position = "relative"; "all" === c.options.accessibility.landmarkVerbosity && d && b.setAttribute("role", "region")
                        }, defaultBeforeChartFormatter: function () {
                            var b, c = this.chart, d = c.options.accessibility.screenReaderSection.beforeChartFormat, e = this.getAxesDescription(), g = c.sonify && (null === (b = c.options.sonification) || void 0 === b ? void 0 : b.enabled); b = "highcharts-a11y-sonify-data-btn-" + c.index; var h = "hc-linkto-highcharts-data-table-" +
                                c.index, f = k(c), t = c.langFormat("accessibility.screenReaderSection.annotations.heading", { chart: c }); e = { chartTitle: v(c), typeDescription: this.getTypeDescriptionText(), chartSubtitle: this.getSubtitleText(), chartLongdesc: this.getLongdescText(), xAxisDescription: e.xAxis, yAxisDescription: e.yAxis, playAsSoundButton: g ? this.getSonifyButtonText(b) : "", viewTableButton: c.getCSV ? this.getDataTableButtonText(h) : "", annotationsTitle: f ? t : "", annotationsList: f }; c = a.i18nFormat(d, e, c); this.dataTableButtonId = h; this.sonifyButtonId =
                                    b; return q(D(c)).replace(/<(\w+)[^>]*?>\s*<\/\1>/g, "")
                        }, defaultAfterChartFormatter: function () { var b = this.chart, c = b.options.accessibility.screenReaderSection.afterChartFormat, d = { endOfChartMarker: this.getEndOfChartMarkerText() }; b = a.i18nFormat(c, d, b); return q(D(b)).replace(/<(\w+)[^>]*?>\s*<\/\1>/g, "") }, getLinkedDescription: function () { var b = this.linkedDescriptionElement; return y(b && b.innerHTML || "") }, getLongdescText: function () {
                            var b = this.chart.options, a = b.caption; a = a && a.text; var c = this.getLinkedDescription();
                            return b.accessibility.description || c || a || ""
                        }, getTypeDescriptionText: function () { var b = this.chart; return b.types ? b.options.accessibility.typeDescription || b.getTypeDescription(b.types) : "" }, getDataTableButtonText: function (b) { var a = this.chart; a = a.langFormat("accessibility.table.viewAsDataTableButtonText", { chart: a, chartTitle: v(a) }); return '<button id="' + b + '">' + a + "</button>" }, getSonifyButtonText: function (b) {
                            var a, c = this.chart; if (!1 === (null === (a = c.options.sonification) || void 0 === a ? void 0 : a.enabled)) return "";
                            a = c.langFormat("accessibility.sonification.playAsSoundButtonText", { chart: c, chartTitle: v(c) }); return '<button id="' + b + '">' + a + "</button>"
                        }, getSubtitleText: function () { var b = this.chart.options.subtitle; return y(b && b.text || "") }, getEndOfChartMarkerText: function () { var b = this.chart, a = b.langFormat("accessibility.screenReaderSection.endOfChartMarker", { chart: b }); return '<div id="highcharts-end-of-chart-marker-' + b.index + '">' + a + "</div>" }, onDataTableCreated: function (b) {
                            var a = this.chart; a.options.accessibility.enabled &&
                                (this.viewDataTableButton && this.viewDataTableButton.setAttribute("aria-expanded", "true"), b.html = b.html.replace("<table ", '<table tabindex="-1" summary="' + a.langFormat("accessibility.table.tableSummary", { chart: a }) + '"'))
                        }, focusDataTable: function () { var b = this.dataTableDiv; (b = b && b.getElementsByTagName("table")[0]) && b.focus && b.focus() }, initSonifyButton: function (b) {
                            var a = this, c = this.sonifyButton = z(b), d = this.chart, e = function (b) {
                            null === c || void 0 === c ? void 0 : c.setAttribute("aria-hidden", "true"); null === c || void 0 ===
                                c ? void 0 : c.setAttribute("aria-label", ""); b.preventDefault(); b.stopPropagation(); b = d.langFormat("accessibility.sonification.playAsSoundClickAnnouncement", { chart: d }); a.announcer.announce(b); setTimeout(function () { null === c || void 0 === c ? void 0 : c.removeAttribute("aria-hidden"); null === c || void 0 === c ? void 0 : c.removeAttribute("aria-label"); d.sonify && d.sonify() }, 1E3)
                            }; c && d && (u(c, { tabindex: "-1" }), c.onclick = function (b) {
                                var a; ((null === (a = d.options.accessibility) || void 0 === a ? void 0 : a.screenReaderSection.onPlayAsSoundClick) ||
                                    e).call(this, b, d)
                            })
                        }, initDataTableButton: function (b) { var a = this.viewDataTableButton = z(b), c = this.chart; b = b.replace("hc-linkto-", ""); a && (u(a, { tabindex: "-1", "aria-expanded": !!z(b) }), a.onclick = c.options.accessibility.screenReaderSection.onViewDataTableClick || function () { c.viewData() }) }, getAxesDescription: function () {
                            var b = this.chart, a = function (a, d) { a = b[a]; return 1 < a.length || a[0] && c(a[0].options.accessibility && a[0].options.accessibility.enabled, d) }, d = !!b.types && 0 > b.types.indexOf("map"), e = !!b.hasCartesianSeries,
                            g = a("xAxis", !b.angular && e && d); a = a("yAxis", e && d); d = {}; g && (d.xAxis = this.getAxisDescriptionText("xAxis")); a && (d.yAxis = this.getAxisDescriptionText("yAxis")); return d
                        }, getAxisDescriptionText: function (b) { var a = this, c = this.chart, d = c[b]; return c.langFormat("accessibility.axis." + b + "Description" + (1 < d.length ? "Plural" : "Singular"), { chart: c, names: d.map(function (b) { return w(b) }), ranges: d.map(function (b) { return a.getAxisRangeDescription(b) }), numAxes: d.length }) }, getAxisRangeDescription: function (b) {
                            var a = b.options ||
                                {}; return a.accessibility && "undefined" !== typeof a.accessibility.rangeDescription ? a.accessibility.rangeDescription : b.categories ? this.getCategoryAxisRangeDesc(b) : !b.dateTime || 0 !== b.min && 0 !== b.dataMin ? this.getAxisFromToDescription(b) : this.getAxisTimeLengthDesc(b)
                        }, getCategoryAxisRangeDesc: function (b) { var a = this.chart; return b.dataMax && b.dataMin ? a.langFormat("accessibility.axis.rangeCategories", { chart: a, axis: b, numCategories: b.dataMax - b.dataMin + 1 }) : "" }, getAxisTimeLengthDesc: function (b) {
                            var a = this.chart,
                            c = {}, d = "Seconds"; c.Seconds = ((b.max || 0) - (b.min || 0)) / 1E3; c.Minutes = c.Seconds / 60; c.Hours = c.Minutes / 60; c.Days = c.Hours / 24;["Minutes", "Hours", "Days"].forEach(function (b) { 2 < c[b] && (d = b) }); var e = c[d].toFixed("Seconds" !== d && "Minutes" !== d ? 1 : 0); return a.langFormat("accessibility.axis.timeRange" + d, { chart: a, axis: b, range: e.replace(".0", "") })
                        }, getAxisFromToDescription: function (b) {
                            var a = this.chart, c = a.options.accessibility.screenReaderSection.axisRangeDateFormat, d = function (d) {
                                return b.dateTime ? a.time.dateFormat(c,
                                    b[d]) : b[d]
                            }; return a.langFormat("accessibility.axis.rangeFromTo", { chart: a, axis: b, rangeFrom: d("min"), rangeTo: d("max") })
                        }, destroy: function () { var b; null === (b = this.announcer) || void 0 === b ? void 0 : b.destroy() }
                    }); return f
            }); p(a, "Accessibility/Components/ContainerComponent.js", [a["Accessibility/AccessibilityComponent.js"], a["Accessibility/Utils/ChartUtilities.js"], a["Core/Globals.js"], a["Accessibility/Utils/HTMLUtilities.js"], a["Core/Utilities.js"]], function (a, f, l, m, n) {
                var g = f.unhideChartElementFromAT, h = f.getChartTitle,
                q = l.doc, e = m.stripHTMLTagsFromString; f = n.extend; l = function () { }; l.prototype = new a; f(l.prototype, {
                    onChartUpdate: function () { this.handleSVGTitleElement(); this.setSVGContainerLabel(); this.setGraphicContainerAttrs(); this.setRenderToAttrs(); this.makeCreditsAccessible() }, handleSVGTitleElement: function () {
                        var a = this.chart, b = "highcharts-title-" + a.index, c = e(a.langFormat("accessibility.svgContainerTitle", { chartTitle: h(a) })); if (c.length) {
                            var g = this.svgTitleElement = this.svgTitleElement || q.createElementNS("http://www.w3.org/2000/svg",
                                "title"); g.textContent = c; g.id = b; a.renderTo.insertBefore(g, a.renderTo.firstChild)
                        }
                    }, setSVGContainerLabel: function () { var a = this.chart, b = e(a.langFormat("accessibility.svgContainerLabel", { chartTitle: h(a) })); a.renderer.box && b.length && a.renderer.box.setAttribute("aria-label", b) }, setGraphicContainerAttrs: function () { var a = this.chart, b = a.langFormat("accessibility.graphicContainerLabel", { chartTitle: h(a) }); b.length && a.container.setAttribute("aria-label", b) }, setRenderToAttrs: function () {
                        var a = this.chart; "disabled" !==
                            a.options.accessibility.landmarkVerbosity ? a.renderTo.setAttribute("role", "region") : a.renderTo.removeAttribute("role"); a.renderTo.setAttribute("aria-label", a.langFormat("accessibility.chartContainerLabel", { title: h(a), chart: a }))
                    }, makeCreditsAccessible: function () { var a = this.chart, b = a.credits; b && (b.textStr && b.element.setAttribute("aria-label", e(a.langFormat("accessibility.credits", { creditsStr: b.textStr }))), g(a, b.element)) }, destroy: function () { this.chart.renderTo.setAttribute("aria-hidden", !0) }
                }); return l
            });
    p(a, "Accessibility/HighContrastMode.js", [a["Core/Globals.js"]], function (a) {
        var f = a.isMS, l = a.win, m = l.document; return {
            isHighContrastModeActive: function () {
                var a = /(Edg)/.test(l.navigator.userAgent); if (l.matchMedia && a) return l.matchMedia("(-ms-high-contrast: active)").matches; if (f && l.getComputedStyle) {
                    a = m.createElement("div"); a.style.backgroundImage = "url(data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==)"; m.body.appendChild(a); var g = (a.currentStyle || l.getComputedStyle(a)).backgroundImage;
                    m.body.removeChild(a); return "none" === g
                } return !1
            }, setHighContrastTheme: function (a) { a.highContrastModeActive = !0; var g = a.options.accessibility.highContrastTheme; a.update(g, !1); a.series.forEach(function (a) { var f = g.plotOptions[a.type] || {}; a.update({ color: f.color || "windowText", colors: [f.color || "windowText"], borderColor: f.borderColor || "window" }); a.points.forEach(function (a) { a.options && a.options.color && a.update({ color: f.color || "windowText", borderColor: f.borderColor || "window" }, !1) }) }); a.redraw() }
        }
    }); p(a, "Accessibility/HighContrastTheme.js",
        [], function () {
            return {
                chart: { backgroundColor: "window" }, title: { style: { color: "windowText" } }, subtitle: { style: { color: "windowText" } }, colorAxis: { minColor: "windowText", maxColor: "windowText", stops: [] }, colors: ["windowText"], xAxis: { gridLineColor: "windowText", labels: { style: { color: "windowText" } }, lineColor: "windowText", minorGridLineColor: "windowText", tickColor: "windowText", title: { style: { color: "windowText" } } }, yAxis: {
                    gridLineColor: "windowText", labels: { style: { color: "windowText" } }, lineColor: "windowText", minorGridLineColor: "windowText",
                    tickColor: "windowText", title: { style: { color: "windowText" } }
                }, tooltip: { backgroundColor: "window", borderColor: "windowText", style: { color: "windowText" } }, plotOptions: {
                    series: { lineColor: "windowText", fillColor: "window", borderColor: "windowText", edgeColor: "windowText", borderWidth: 1, dataLabels: { connectorColor: "windowText", color: "windowText", style: { color: "windowText", textOutline: "none" } }, marker: { lineColor: "windowText", fillColor: "windowText" } }, pie: { color: "window", colors: ["window"], borderColor: "windowText", borderWidth: 1 },
                    boxplot: { fillColor: "window" }, candlestick: { lineColor: "windowText", fillColor: "window" }, errorbar: { fillColor: "window" }
                }, legend: { backgroundColor: "window", itemStyle: { color: "windowText" }, itemHoverStyle: { color: "windowText" }, itemHiddenStyle: { color: "#555" }, title: { style: { color: "windowText" } } }, credits: { style: { color: "windowText" } }, labels: { style: { color: "windowText" } }, drilldown: { activeAxisLabelStyle: { color: "windowText" }, activeDataLabelStyle: { color: "windowText" } }, navigation: {
                    buttonOptions: {
                        symbolStroke: "windowText",
                        theme: { fill: "window" }
                    }
                }, rangeSelector: { buttonTheme: { fill: "window", stroke: "windowText", style: { color: "windowText" }, states: { hover: { fill: "window", stroke: "windowText", style: { color: "windowText" } }, select: { fill: "#444", stroke: "windowText", style: { color: "windowText" } } } }, inputBoxBorderColor: "windowText", inputStyle: { backgroundColor: "window", color: "windowText" }, labelStyle: { color: "windowText" } }, navigator: {
                    handles: { backgroundColor: "window", borderColor: "windowText" }, outlineColor: "windowText", maskFill: "transparent",
                    series: { color: "windowText", lineColor: "windowText" }, xAxis: { gridLineColor: "windowText" }
                }, scrollbar: { barBackgroundColor: "#444", barBorderColor: "windowText", buttonArrowColor: "windowText", buttonBackgroundColor: "window", buttonBorderColor: "windowText", rifleColor: "windowText", trackBackgroundColor: "window", trackBorderColor: "windowText" }
            }
        }); p(a, "Accessibility/Options/Options.js", [], function () {
            return {
                accessibility: {
                    enabled: !0, screenReaderSection: {
                        beforeChartFormat: "<h5>{chartTitle}</h5><div>{typeDescription}</div><div>{chartSubtitle}</div><div>{chartLongdesc}</div><div>{playAsSoundButton}</div><div>{viewTableButton}</div><div>{xAxisDescription}</div><div>{yAxisDescription}</div><div>{annotationsTitle}{annotationsList}</div>",
                        afterChartFormat: "{endOfChartMarker}", axisRangeDateFormat: "%Y-%m-%d %H:%M:%S"
                    }, series: { describeSingleSeries: !1, pointDescriptionEnabledThreshold: 200 }, point: { valueDescriptionFormat: "{index}. {xDescription}{separator}{value}." }, landmarkVerbosity: "all", linkedDescription: '*[data-highcharts-chart="{index}"] + .highcharts-description', keyboardNavigation: {
                        enabled: !0, focusBorder: { enabled: !0, hideBrowserFocusOutline: !0, style: { color: "#335cad", lineWidth: 2, borderRadius: 3 }, margin: 2 }, order: ["series", "zoom", "rangeSelector",
                            "legend", "chartMenu"], wrapAround: !0, seriesNavigation: { skipNullPoints: !0, pointNavigationEnabledThreshold: !1 }
                    }, announceNewData: { enabled: !1, minAnnounceInterval: 5E3, interruptUser: !1 }
                }, legend: { accessibility: { enabled: !0, keyboardNavigation: { enabled: !0 } } }, exporting: { accessibility: { enabled: !0 } }
            }
        }); p(a, "Accessibility/Options/LangOptions.js", [], function () {
            return {
                accessibility: {
                    defaultChartTitle: "Chart", chartContainerLabel: "{title}. Highcharts interactive chart.", svgContainerLabel: "Interactive chart", drillUpButton: "{buttonText}",
                    credits: "Chart credits: {creditsStr}", thousandsSep: ",", svgContainerTitle: "", graphicContainerLabel: "", screenReaderSection: { beforeRegionLabel: "Chart screen reader information.", afterRegionLabel: "", annotations: { heading: "Chart annotations summary", descriptionSinglePoint: "{annotationText}. Related to {annotationPoint}", descriptionMultiplePoints: "{annotationText}. Related to {annotationPoint}{ Also related to, #each(additionalAnnotationPoints)}", descriptionNoPoints: "{annotationText}" }, endOfChartMarker: "End of interactive chart." },
                    sonification: { playAsSoundButtonText: "Play as sound, {chartTitle}", playAsSoundClickAnnouncement: "Play" }, legend: { legendLabel: "Toggle series visibility", legendItem: "Hide {itemName}" }, zoom: { mapZoomIn: "Zoom chart", mapZoomOut: "Zoom out chart", resetZoomButton: "Reset zoom" }, rangeSelector: { minInputLabel: "Select start date.", maxInputLabel: "Select end date.", buttonText: "Select range {buttonText}" }, table: { viewAsDataTableButtonText: "View as data table, {chartTitle}", tableSummary: "Table representation of chart." },
                    announceNewData: { newDataAnnounce: "Updated data for chart {chartTitle}", newSeriesAnnounceSingle: "New data series: {seriesDesc}", newPointAnnounceSingle: "New data point: {pointDesc}", newSeriesAnnounceMultiple: "New data series in chart {chartTitle}: {seriesDesc}", newPointAnnounceMultiple: "New data point in chart {chartTitle}: {pointDesc}" }, seriesTypeDescriptions: {
                        boxplot: "Box plot charts are typically used to display groups of statistical data. Each data point in the chart can have up to 5 values: minimum, lower quartile, median, upper quartile, and maximum.",
                        arearange: "Arearange charts are line charts displaying a range between a lower and higher value for each point.", areasplinerange: "These charts are line charts displaying a range between a lower and higher value for each point.", bubble: "Bubble charts are scatter charts where each data point also has a size value.", columnrange: "Columnrange charts are column charts displaying a range between a lower and higher value for each point.", errorbar: "Errorbar series are used to display the variability of the data.",
                        funnel: "Funnel charts are used to display reduction of data in stages.", pyramid: "Pyramid charts consist of a single pyramid with item heights corresponding to each point value.", waterfall: "A waterfall chart is a column chart where each column contributes towards a total end value."
                    }, chartTypes: {
                        emptyChart: "Empty chart", mapTypeDescription: "Map of {mapTitle} with {numSeries} data series.", unknownMap: "Map of unspecified region with {numSeries} data series.", combinationChart: "Combination chart with {numSeries} data series.",
                        defaultSingle: "Chart with {numPoints} data {#plural(numPoints, points, point)}.", defaultMultiple: "Chart with {numSeries} data series.", splineSingle: "Line chart with {numPoints} data {#plural(numPoints, points, point)}.", splineMultiple: "Line chart with {numSeries} lines.", lineSingle: "Line chart with {numPoints} data {#plural(numPoints, points, point)}.", lineMultiple: "Line chart with {numSeries} lines.", columnSingle: "Bar chart with {numPoints} {#plural(numPoints, bars, bar)}.", columnMultiple: "Bar chart with {numSeries} data series.",
                        barSingle: "Bar chart with {numPoints} {#plural(numPoints, bars, bar)}.", barMultiple: "Bar chart with {numSeries} data series.", pieSingle: "Pie chart with {numPoints} {#plural(numPoints, slices, slice)}.", pieMultiple: "Pie chart with {numSeries} pies.", scatterSingle: "Scatter chart with {numPoints} {#plural(numPoints, points, point)}.", scatterMultiple: "Scatter chart with {numSeries} data series.", boxplotSingle: "Boxplot with {numPoints} {#plural(numPoints, boxes, box)}.", boxplotMultiple: "Boxplot with {numSeries} data series.",
                        bubbleSingle: "Bubble chart with {numPoints} {#plural(numPoints, bubbles, bubble)}.", bubbleMultiple: "Bubble chart with {numSeries} data series."
                    }, axis: {
                        xAxisDescriptionSingular: "The chart has 1 X axis displaying {names[0]}. {ranges[0]}", xAxisDescriptionPlural: "The chart has {numAxes} X axes displaying {#each(names, -1) }and {names[-1]}.", yAxisDescriptionSingular: "The chart has 1 Y axis displaying {names[0]}. {ranges[0]}", yAxisDescriptionPlural: "The chart has {numAxes} Y axes displaying {#each(names, -1) }and {names[-1]}.",
                        timeRangeDays: "Range: {range} days.", timeRangeHours: "Range: {range} hours.", timeRangeMinutes: "Range: {range} minutes.", timeRangeSeconds: "Range: {range} seconds.", rangeFromTo: "Range: {rangeFrom} to {rangeTo}.", rangeCategories: "Range: {numCategories} categories."
                    }, exporting: { chartMenuLabel: "Chart menu", menuButtonLabel: "View chart menu", exportRegionLabel: "Chart menu" }, series: {
                        summary: {
                            "default": "{name}, series {ix} of {numSeries} with {numPoints} data {#plural(numPoints, points, point)}.", defaultCombination: "{name}, series {ix} of {numSeries} with {numPoints} data {#plural(numPoints, points, point)}.",
                            line: "{name}, line {ix} of {numSeries} with {numPoints} data {#plural(numPoints, points, point)}.", lineCombination: "{name}, series {ix} of {numSeries}. Line with {numPoints} data {#plural(numPoints, points, point)}.", spline: "{name}, line {ix} of {numSeries} with {numPoints} data {#plural(numPoints, points, point)}.", splineCombination: "{name}, series {ix} of {numSeries}. Line with {numPoints} data {#plural(numPoints, points, point)}.", column: "{name}, bar series {ix} of {numSeries} with {numPoints} {#plural(numPoints, bars, bar)}.",
                            columnCombination: "{name}, series {ix} of {numSeries}. Bar series with {numPoints} {#plural(numPoints, bars, bar)}.", bar: "{name}, bar series {ix} of {numSeries} with {numPoints} {#plural(numPoints, bars, bar)}.", barCombination: "{name}, series {ix} of {numSeries}. Bar series with {numPoints} {#plural(numPoints, bars, bar)}.", pie: "{name}, pie {ix} of {numSeries} with {numPoints} {#plural(numPoints, slices, slice)}.", pieCombination: "{name}, series {ix} of {numSeries}. Pie with {numPoints} {#plural(numPoints, slices, slice)}.",
                            scatter: "{name}, scatter plot {ix} of {numSeries} with {numPoints} {#plural(numPoints, points, point)}.", scatterCombination: "{name}, series {ix} of {numSeries}, scatter plot with {numPoints} {#plural(numPoints, points, point)}.", boxplot: "{name}, boxplot {ix} of {numSeries} with {numPoints} {#plural(numPoints, boxes, box)}.", boxplotCombination: "{name}, series {ix} of {numSeries}. Boxplot with {numPoints} {#plural(numPoints, boxes, box)}.", bubble: "{name}, bubble series {ix} of {numSeries} with {numPoints} {#plural(numPoints, bubbles, bubble)}.",
                            bubbleCombination: "{name}, series {ix} of {numSeries}. Bubble series with {numPoints} {#plural(numPoints, bubbles, bubble)}.", map: "{name}, map {ix} of {numSeries} with {numPoints} {#plural(numPoints, areas, area)}.", mapCombination: "{name}, series {ix} of {numSeries}. Map with {numPoints} {#plural(numPoints, areas, area)}.", mapline: "{name}, line {ix} of {numSeries} with {numPoints} data {#plural(numPoints, points, point)}.", maplineCombination: "{name}, series {ix} of {numSeries}. Line with {numPoints} data {#plural(numPoints, points, point)}.",
                            mapbubble: "{name}, bubble series {ix} of {numSeries} with {numPoints} {#plural(numPoints, bubbles, bubble)}.", mapbubbleCombination: "{name}, series {ix} of {numSeries}. Bubble series with {numPoints} {#plural(numPoints, bubbles, bubble)}."
                        }, description: "{description}", xAxisDescription: "X axis, {name}", yAxisDescription: "Y axis, {name}", nullPointValue: "No value", pointAnnotationsDescription: "{Annotation: #each(annotations). }"
                    }
                }
            }
        }); p(a, "Accessibility/Options/DeprecatedOptions.js", [a["Core/Utilities.js"]],
            function (a) {
                function f(a, d, b) { for (var c, e = 0; e < d.length - 1; ++e)c = d[e], a = a[c] = q(a[c], {}); a[d[d.length - 1]] = b } function l(a, d, b, c) { function e(b, a) { return a.reduce(function (b, a) { return b[a] }, b) } var g = e(a.options, d), l = e(a.options, b); Object.keys(c).forEach(function (e) { var k, t = g[e]; "undefined" !== typeof t && (f(l, c[e], t), h(32, !1, a, (k = {}, k[d.join(".") + "." + e] = b.join(".") + "." + c[e].join("."), k))) }) } function m(a) {
                    var d = a.options.chart || {}, b = a.options.accessibility || {};["description", "typeDescription"].forEach(function (c) {
                        var e;
                        d[c] && (b[c] = d[c], h(32, !1, a, (e = {}, e["chart." + c] = "use accessibility." + c, e)))
                    })
                } function n(a) { a.axes.forEach(function (d) { (d = d.options) && d.description && (d.accessibility = d.accessibility || {}, d.accessibility.description = d.description, h(32, !1, a, { "axis.description": "use axis.accessibility.description" })) }) } function g(a) {
                    var d = {
                        description: ["accessibility", "description"], exposeElementToA11y: ["accessibility", "exposeAsGroupOnly"], pointDescriptionFormatter: ["accessibility", "pointDescriptionFormatter"], skipKeyboardNavigation: ["accessibility",
                            "keyboardNavigation", "enabled"]
                    }; a.series.forEach(function (b) { Object.keys(d).forEach(function (c) { var e, g = b.options[c]; "undefined" !== typeof g && (f(b.options, d[c], "skipKeyboardNavigation" === c ? !g : g), h(32, !1, a, (e = {}, e["series." + c] = "series." + d[c].join("."), e))) }) })
                } var h = a.error, q = a.pick; return function (a) {
                    m(a); n(a); a.series && g(a); l(a, ["accessibility"], ["accessibility"], {
                        pointDateFormat: ["point", "dateFormat"], pointDateFormatter: ["point", "dateFormatter"], pointDescriptionFormatter: ["point", "descriptionFormatter"],
                        pointDescriptionThreshold: ["series", "pointDescriptionEnabledThreshold"], pointNavigationThreshold: ["keyboardNavigation", "seriesNavigation", "pointNavigationEnabledThreshold"], pointValueDecimals: ["point", "valueDecimals"], pointValuePrefix: ["point", "valuePrefix"], pointValueSuffix: ["point", "valueSuffix"], screenReaderSectionFormatter: ["screenReaderSection", "beforeChartFormatter"], describeSingleSeries: ["series", "describeSingleSeries"], seriesDescriptionFormatter: ["series", "descriptionFormatter"], onTableAnchorClick: ["screenReaderSection",
                            "onViewDataTableClick"], axisRangeDateFormat: ["screenReaderSection", "axisRangeDateFormat"]
                    }); l(a, ["accessibility", "keyboardNavigation"], ["accessibility", "keyboardNavigation", "seriesNavigation"], { skipNullPoints: ["skipNullPoints"], mode: ["mode"] }); l(a, ["lang", "accessibility"], ["lang", "accessibility"], {
                        legendItem: ["legend", "legendItem"], legendLabel: ["legend", "legendLabel"], mapZoomIn: ["zoom", "mapZoomIn"], mapZoomOut: ["zoom", "mapZoomOut"], resetZoomButton: ["zoom", "resetZoomButton"], screenReaderRegionLabel: ["screenReaderSection",
                            "beforeRegionLabel"], rangeSelectorButton: ["rangeSelector", "buttonText"], rangeSelectorMaxInput: ["rangeSelector", "maxInputLabel"], rangeSelectorMinInput: ["rangeSelector", "minInputLabel"], svgContainerEnd: ["screenReaderSection", "endOfChartMarker"], viewAsDataTable: ["table", "viewAsDataTableButtonText"], tableSummary: ["table", "tableSummary"]
                    })
                }
            }); p(a, "Accessibility/A11yI18n.js", [a["Core/Globals.js"], a["Core/Utilities.js"]], function (a, f) {
                function l(a, f) {
                    var g = a.indexOf("#each("), e = a.indexOf("#plural("), d = a.indexOf("["),
                    b = a.indexOf("]"); if (-1 < g) { d = a.slice(g).indexOf(")") + g; var c = a.substring(0, g); e = a.substring(d + 1); d = a.substring(g + 6, d).split(","); g = Number(d[1]); a = ""; if (f = f[d[0]]) for (g = isNaN(g) ? f.length : g, g = 0 > g ? f.length + g : Math.min(g, f.length), d = 0; d < g; ++d)a += c + f[d] + e; return a.length ? a : "" } if (-1 < e) {
                        c = a.slice(e).indexOf(")") + e; a = a.substring(e + 8, c).split(","); switch (Number(f[a[0]])) { case 0: a = n(a[4], a[1]); break; case 1: a = n(a[2], a[1]); break; case 2: a = n(a[3], a[1]); break; default: a = a[1] }a ? (f = a, f = f.trim && f.trim() || f.replace(/^\s+|\s+$/g,
                            "")) : f = ""; return f
                    } return -1 < d ? (e = a.substring(0, d), a = Number(a.substring(d + 1, b)), f = f[e], !isNaN(a) && f && (0 > a ? (c = f[f.length + a], "undefined" === typeof c && (c = f[0])) : (c = f[a], "undefined" === typeof c && (c = f[f.length - 1]))), "undefined" !== typeof c ? c : "") : "{" + a + "}"
                } var m = f.format, n = f.pick; a.i18nFormat = function (a, f, n) {
                    var e = function (a, b) { a = a.slice(b || 0); var c = a.indexOf("{"), d = a.indexOf("}"); if (-1 < c && d > c) return { statement: a.substring(c + 1, d), begin: b + c + 1, end: b + d } }, d = [], b = 0; do {
                        var c = e(a, b); var g = a.substring(b, c && c.begin -
                            1); g.length && d.push({ value: g, type: "constant" }); c && d.push({ value: c.statement, type: "statement" }); b = c ? c.end + 1 : b + 1
                    } while (c); d.forEach(function (a) { "statement" === a.type && (a.value = l(a.value, f)) }); return m(d.reduce(function (a, b) { return a + b.value }, ""), f, n)
                }; a.Chart.prototype.langFormat = function (f, h) { f = f.split("."); for (var g = this.options.lang, e = 0; e < f.length; ++e)g = g && g[f[e]]; return "string" === typeof g ? a.i18nFormat(g, h, this) : "" }
            }); p(a, "Accessibility/FocusBorder.js", [a["Core/Globals.js"], a["Core/Renderer/SVG/SVGElement.js"],
            a["Core/Renderer/SVG/SVGLabel.js"], a["Core/Utilities.js"]], function (a, f, l, m) {
                function n(a) { if (!a.focusBorderDestroyHook) { var b = a.destroy; a.destroy = function () { var c, d; null === (d = null === (c = a.focusBorder) || void 0 === c ? void 0 : c.destroy) || void 0 === d ? void 0 : d.call(c); return b.apply(a, arguments) }; a.focusBorderDestroyHook = b } } function g(a) {
                    for (var c = [], d = 1; d < arguments.length; d++)c[d - 1] = arguments[d]; a.focusBorderUpdateHooks || (a.focusBorderUpdateHooks = {}, b.forEach(function (b) {
                        b += "Setter"; var d = a[b] || a._defaultSetter;
                        a.focusBorderUpdateHooks[b] = d; a[b] = function () { var b = d.apply(a, arguments); a.addFocusBorder.apply(a, c); return b }
                    }))
                } function h(a) { a.focusBorderUpdateHooks && (Object.keys(a.focusBorderUpdateHooks).forEach(function (b) { var c = a.focusBorderUpdateHooks[b]; c === a._defaultSetter ? delete a[b] : a[b] = c }), delete a.focusBorderUpdateHooks) } var q = m.addEvent, e = m.extend, d = m.pick, b = "x y transform width height r d stroke-width".split(" "); e(f.prototype, {
                    addFocusBorder: function (b, e) {
                    this.focusBorder && this.removeFocusBorder();
                        var c = this.getBBox(), f = d(b, 3); c.x += this.translateX ? this.translateX : 0; c.y += this.translateY ? this.translateY : 0; var h = c.x - f, k = c.y - f, m = c.width + 2 * f, q = c.height + 2 * f, p = this instanceof l; if ("text" === this.element.nodeName || p) {
                            var u = !!this.rotation; if (p) var x = { x: u ? 1 : 0, y: 0 }; else h = x = 0, "middle" === this.attr("text-anchor") ? (x = a.isFirefox && this.rotation ? .25 : .5, h = a.isFirefox && !this.rotation ? .75 : .5) : this.rotation ? x = .25 : h = .75, x = { x: x, y: h }; h = +this.attr("x") - c.width * x.x - f; k = +this.attr("y") - c.height * x.y - f; p && u && (p = m, m = q,
                                q = p, h = +this.attr("x") - c.height * x.x - f, k = +this.attr("y") - c.width * x.y - f)
                        } this.focusBorder = this.renderer.rect(h, k, m, q, parseInt((e && e.borderRadius || 0).toString(), 10)).addClass("highcharts-focus-border").attr({ zIndex: 99 }).add(this.parentGroup); this.renderer.styledMode || this.focusBorder.attr({ stroke: e && e.stroke, "stroke-width": e && e.strokeWidth }); g(this, b, e); n(this)
                    }, removeFocusBorder: function () {
                        h(this); this.focusBorderDestroyHook && (this.destroy = this.focusBorderDestroyHook, delete this.focusBorderDestroyHook);
                        this.focusBorder && (this.focusBorder.destroy(), delete this.focusBorder)
                    }
                }); a.Chart.prototype.renderFocusBorder = function () { var a = this.focusElement, b = this.options.accessibility.keyboardNavigation.focusBorder; a && (a.removeFocusBorder(), b.enabled && a.addFocusBorder(b.margin, { stroke: b.style.color, strokeWidth: b.style.lineWidth, borderRadius: b.style.borderRadius })) }; a.Chart.prototype.setFocusToElement = function (a, b) {
                    var c = this.options.accessibility.keyboardNavigation.focusBorder; (b = b || a.element) && b.focus && (b.hcEvents &&
                        b.hcEvents.focusin || q(b, "focusin", function () { }), b.focus(), c.hideBrowserFocusOutline && (b.style.outline = "none")); this.focusElement && this.focusElement.removeFocusBorder(); this.focusElement = a; this.renderFocusBorder()
                }
            }); p(a, "Accessibility/Accessibility.js", [a["Accessibility/Utils/ChartUtilities.js"], a["Core/Globals.js"], a["Accessibility/KeyboardNavigationHandler.js"], a["Core/Series/CartesianSeries.js"], a["Core/Options.js"], a["Core/Series/Point.js"], a["Core/Utilities.js"], a["Accessibility/AccessibilityComponent.js"],
            a["Accessibility/KeyboardNavigation.js"], a["Accessibility/Components/LegendComponent.js"], a["Accessibility/Components/MenuComponent.js"], a["Accessibility/Components/SeriesComponent/SeriesComponent.js"], a["Accessibility/Components/ZoomComponent.js"], a["Accessibility/Components/RangeSelectorComponent.js"], a["Accessibility/Components/InfoRegionsComponent.js"], a["Accessibility/Components/ContainerComponent.js"], a["Accessibility/HighContrastMode.js"], a["Accessibility/HighContrastTheme.js"], a["Accessibility/Options/Options.js"],
            a["Accessibility/Options/LangOptions.js"], a["Accessibility/Options/DeprecatedOptions.js"]], function (a, f, l, m, n, g, h, p, e, d, b, c, k, t, v, w, H, A, D, y, z) {
                function q(a) { this.init(a) } var r = f.doc, u = h.addEvent, F = h.extend, B = h.fireEvent, E = h.merge; E(!0, n.defaultOptions, D, { accessibility: { highContrastTheme: A }, lang: y }); f.A11yChartUtilities = a; f.KeyboardNavigationHandler = l; f.AccessibilityComponent = p; q.prototype = {
                    init: function (a) {
                    this.chart = a; r.addEventListener && a.renderer.isSVG ? (z(a), this.initComponents(), this.keyboardNavigation =
                        new e(a, this.components), this.update()) : a.renderTo.setAttribute("aria-hidden", !0)
                    }, initComponents: function () { var a = this.chart, e = a.options.accessibility; this.components = { container: new w, infoRegions: new v, legend: new d, chartMenu: new b, rangeSelector: new t, series: new c, zoom: new k }; e.customComponents && F(this.components, e.customComponents); var f = this.components; this.getComponentOrder().forEach(function (b) { f[b].initBase(a); f[b].init() }) }, getComponentOrder: function () {
                        if (!this.components) return []; if (!this.components.series) return Object.keys(this.components);
                        var a = Object.keys(this.components).filter(function (a) { return "series" !== a }); return ["series"].concat(a)
                    }, update: function () {
                        var a = this.components, b = this.chart, c = b.options.accessibility; B(b, "beforeA11yUpdate"); b.types = this.getChartTypes(); this.getComponentOrder().forEach(function (c) { a[c].onChartUpdate(); B(b, "afterA11yComponentUpdate", { name: c, component: a[c] }) }); this.keyboardNavigation.update(c.keyboardNavigation.order); !b.highContrastModeActive && H.isHighContrastModeActive() && H.setHighContrastTheme(b);
                        B(b, "afterA11yUpdate", { accessibility: this })
                    }, destroy: function () { var a = this.chart || {}, b = this.components; Object.keys(b).forEach(function (a) { b[a].destroy(); b[a].destroyBase() }); this.keyboardNavigation && this.keyboardNavigation.destroy(); a.renderTo && a.renderTo.setAttribute("aria-hidden", !0); a.focusElement && a.focusElement.removeFocusBorder() }, getChartTypes: function () { var a = {}; this.chart.series.forEach(function (b) { a[b.type] = 1 }); return Object.keys(a) }
                }; f.Chart.prototype.updateA11yEnabled = function () {
                    var a =
                        this.accessibility, b = this.options.accessibility; b && b.enabled ? a ? a.update() : this.accessibility = new q(this) : a ? (a.destroy && a.destroy(), delete this.accessibility) : this.renderTo.setAttribute("aria-hidden", !0)
                }; u(f.Chart, "render", function (a) { this.a11yDirty && this.renderTo && (delete this.a11yDirty, this.updateA11yEnabled()); var b = this.accessibility; b && b.getComponentOrder().forEach(function (a) { b.components[a].onChartRender() }) }); u(f.Chart, "update", function (a) {
                    if (a = a.options.accessibility) a.customComponents &&
                        (this.options.accessibility.customComponents = a.customComponents, delete a.customComponents), E(!0, this.options.accessibility, a), this.accessibility && this.accessibility.destroy && (this.accessibility.destroy(), delete this.accessibility); this.a11yDirty = !0
                }); u(g, "update", function () { this.series.chart.accessibility && (this.series.chart.a11yDirty = !0) });["addSeries", "init"].forEach(function (a) { u(f.Chart, a, function () { this.a11yDirty = !0 }) });["update", "updatedData", "remove"].forEach(function (a) {
                    u(m, a, function () {
                        this.chart.accessibility &&
                        (this.chart.a11yDirty = !0)
                    })
                });["afterDrilldown", "drillupall"].forEach(function (a) { u(f.Chart, a, function () { this.accessibility && this.accessibility.update() }) }); u(f.Chart, "destroy", function () { this.accessibility && this.accessibility.destroy() })
            }); p(a, "masters/modules/accessibility.src.js", [], function () { })
});
//# sourceMappingURL=accessibility.js.map