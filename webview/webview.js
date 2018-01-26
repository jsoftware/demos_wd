// util

"use strict";

var AA, BB;
var O = console.log;

// ----------------------------------------------------------------------
function arrayexcept(arr, sel) {
 if ("object" !== typeof sel)
  sel = [sel];
 return arr.filter((item) => {
  return -1 === sel.indexOf(item);
 })
}

// ---------------------------------------------------------------------
function arraymask(a, mask) {
 var r = [];
 for (var i = 0; i < a.length; i++)
  if (mask[i]) r.push(a[i]);
 return r;
}

// ---------------------------------------------------------------------
// max over array
function arraymax(a) {
 return Math.max.apply(null, a);
}

// ---------------------------------------------------------------------
function arraymember(arr, list) {
 var r = [];
 for (var i = 0; i < arr.length; i++)
  r.push(-1 < list.indexOf(arr[i]));
 return r;
}

// ---------------------------------------------------------------------
// min over array
function arraymin(a) {
 return Math.min.apply(null, a);
}

// ----------------------------------------------------------------------
function arraymovelast(a, e) {
 a = arrayrem1(a, e);
 a.push(e);
 return a;
}

// ----------------------------------------------------------------------
// remove element from array
function arrayrem1(a, e) {
 var i = a.indexOf(e);
 if (i !== -1)
  a.splice(i, 1);
 return a;
}

// ----------------------------------------------------------------------
function arrayremlast(a) {
 return a.splice(a.length - 1, 1)[0];
}

// ---------------------------------------------------------------------
function arrayunique(arr) {
 var a = [];
 var o = {};
 var n = arr.length;
 for (var i = 0; i < n; ++i)
  o[arr[i]] = arr[i];
 for (i in o)
  a.push(o[i]);
 return a;
};

// ---------------------------------------------------------------------
function getclass(e) {
 return document.getElementsByClassName(e);
}

// ---------------------------------------------------------------------
function getid(e) {
 return document.getElementById(e);
}

// ---------------------------------------------------------------------
function getrect(e) {
 if ("string" === typeof e)
  return getid(e).getBoundingClientRect();
 else
  return e.getBoundingClientRect();
}

// ---------------------------------------------------------------------
function has(array, element) {
 return -1 < array.indexOf(element);
}

// ---------------------------------------------------------------------
function jsoncopy(v) {
 return JSON.parse(JSON.stringify(v));
}

// ---------------------------------------------------------------------
function listen(cls, event, fn) {
 if ("string" === typeof cls)
  cls = getclass(cls);
 for (var i = 0; i < cls.length; i++)
  cls[i].addEventListener(event, fn);
}

// ---------------------------------------------------------------------
// match items as JSON strings
function matches(a, b) {
 return JSON.stringify(a) === JSON.stringify(b);
}

// ---------------------------------------------------------------------
var mbinfo = alert;

// ---------------------------------------------------------------------
// cumulative sum matrix
function msums(a) {
 var r = [a[0]];
 for (var i = 1; i < a.length; i++)
  r.push(vadd(r[i - 1], a[i]));
 return r;
}

// ---------------------------------------------------------------------
// set on for text, off for plots
function overflow(b) {
 document.body.style.overflow = (b ? "auto" : "hidden");
}

// ---------------------------------------------------------------------
function qextentcan(array) {
 var ctx = getid("qextcan").getContext("2d");
 ctx.font = "15px serif";
 var wid = 0;
 for (var i = 0; i < array.length; i++)
  wid = Math.max(wid, ctx.measureText(array[i]).width);
 return wid;
}

// ---------------------------------------------------------------------
function qextentkey(array, classid) {
 var w = []
 var v = d3.select("body").append("svg")
 var p = v.append("text").attr("x", -1000).attr("y", -1000).attr("class", classid);
 for (var i = 0; i < array.length; i++) {
  p.text(array[i])
  w.push(28 + p.node().getComputedTextLength())
 }
 v.remove()
 return w
}

// ---------------------------------------------------------------------
function qextentw(text, classid) {
 var v = d3.select("body").append("svg")
 var p = v.append("text").attr("x", -1000).attr("y", -1000).attr("class", classid);
 p.text(text)
 var r = p.node().getComputedTextLength()
 v.remove()
 return r
}

// ---------------------------------------------------------------------
// timing in milliseconds
// overhead is ~ 0.05ms
// also console.time("id"), console.timeEnd("id");
function timex(exp, reps) {
 if (reps === undefined) reps = 1;
 var t1 = performance.now();
 for (var i = 0; i < reps; i++)
  eval(exp);
 var t2 = performance.now();
 var s = (t2 - t1).toFixed(3);
 console.log(s);
}

// ---------------------------------------------------------------------
function transpose(a) {
 return a[0].map(function(_, c) {
  return a.map(function(r) {
   return r[c];
  });
 });
}

// ---------------------------------------------------------------------
function v2mat(dat, rws, cls) {
 var r = [];
 for (var i = 0; i < rws; i++)
  r.push(dat.slice(i * cls, cls + i * cls));
 return r;
}

// ---------------------------------------------------------------------
function vadd(a1, a2) {
 var r = [];
 for (var i = 0; i < a1.length; i++)
  r.push(a1[i] + a2[i]);
 return r;
}
// jfns - handle J communication

"use strict";

// ---------------------------------------------------------------------
function jcall(s) {
 jcall_do(s, false);
}

// ---------------------------------------------------------------------
function jcallr(s) {
 jcall_do(s, true);
}

// ---------------------------------------------------------------------
function jcall_do(s, ret) {
 var f = s.shift();
 if (window[f] === undefined)
  return jerror("function not found: " + f);
 var r;
 try {
  r = window[f](s);
  if (ret)
   jreturn(JSON.stringify(r));
 } catch (error) {
  jerror("call error: " + error);
 }
}

// ---------------------------------------------------------------------
function jerror(msg) {
 jpost("error", msg);
}

// ---------------------------------------------------------------------
function jeval(s) {
 var r;
 try {
  r = eval(s[0]);
  return jreturn(JSON.stringify(r));
 } catch (error) {
  return jerror("eval error: " + error);
 }
}

// ---------------------------------------------------------------------
function jget(s) {
 if (window[s] === undefined)
  return jerror("name not found: " + s);
 return jreturn(JSON.stringify(window[s]));
}

// ---------------------------------------------------------------------
function jnotify(s) {
 var f = "j" + s.shift();
 if (window[f] === undefined)
  return jerror("function not found: " + f);
 window[f](s);
}

// ---------------------------------------------------------------------
function jpost(name, val) {
 qcom.qPost(["post", name, val]);
}

// ---------------------------------------------------------------------
function jreturn(msg) {
 jpost("return", msg);
}

// ---------------------------------------------------------------------
function jset(s) {
 var e = s.shift();
 if (window[e] === undefined)
  return jerror("id not found: " + e);
 window[e].value = s[0];
}
// barchart

"use strict"

// ---------------------------------------------------------------------
function draw_barchart(arg, wh) {
 draw_barchart1(arg, wh, false)
}

// ---------------------------------------------------------------------
function draw_stackedbarchart(arg, wh) {
 draw_barchart1(arg, wh, true)
}

// ---------------------------------------------------------------------
function draw_barchart1(arg, wh, stack) {
 var title = arg[0];
 var rws = arg[1];
 var cls = arg[2];
 var rlen = rws.length;
 var clen = cls.length;
 var dat = v2mat(arg[3], rlen, clen);

 var color = [];
 var len = CB0.length;
 for (var i = 0; i < rlen; i++)
  color.push(CB0[i % len]);

 var dset = [];
 for (var i = 0; i < rlen; i++) {
  let t = {};
  t.label = rws[i];
  t.data = dat[i];
  t.backgroundColor = color[i];
  t.borderColor = "#ddd";
  t.borderWidth = 1;
  dset.push(t);
 }

 var val = {};
 val.labels = cls;
 val.datasets = dset;

 var opt = {};
 var scales = {};
 opt.type = "bar";
 opt.data = val;

 /* beautify preserve:start */
 opt.options = {
  animation: false,
  legend: {onClick: legend_click, position: "right"},
  maintainAspectRatio: false,
  onClick: chart_click,
  title: {display: true, text: title }};

 scales={
  xAxes:[{ticks:{autoSkip:false}}],
  yAxes:[{ticks:{callback:chart_format}}]};
 /* beautify preserve:end */

 if (stack) {
  scales.xAxes[0].stacked = true;
  scales.yAxes[0].stacked = true;
 } else
  scales.yAxes[0].ticks.beginAtZero = true;

 opt.options.scales = scales;

 var ctx = getclearcontext(wh);
 MyChart = new Chart(ctx, opt);
}
// chart utils

// ---------------------------------------------------------------------
function getclearcontext(wh) {
 Chart.defaults.global.defaultFontColor = "#222";
 if (MyChart !== undefined)
  MyChart.destroy();
 var pvs = getid("mychartp");
 pvs.style.width = wh[0] + "px";
 pvs.style.height = wh[1] + "px";
 return getid("mychart").getContext("2d");
}

// ---------------------------------------------------------------------
function chart_click(e) {
 if (!(e.ctrlKey && e.shiftKey)) return;
 var c = MyChart;
 var len = c.legend.legendItems.length;
 for (var i = 0; i < len; i++)
  c.getDatasetMeta(i).hidden = null;
 c.update();
}

// ---------------------------------------------------------------------
var chart_format = d3.format(".2s");

// ---------------------------------------------------------------------
function legend_click(e, t) {
 legend_click1(e, t);
 MyChart.update();
}

// ---------------------------------------------------------------------
function legend_click1(e, t) {
 var ndx = t.datasetIndex;
 var c = MyChart;
 if (e.ctrlKey) {
  var len = c.legend.legendItems.length;
  for (var i = 0; i < len; i++)
   if (ndx !== i)
    legend_toggle(c, i);
 } else
  legend_toggle(c, ndx);
}

// ---------------------------------------------------------------------
function legend_click_area(e, t) {
 legend_click1(e, t);
 var c = MyChart;
 var len = c.legend.legendItems.length;
 var dat = c.mydata;
 var val = new Array(len).fill(0)
 for (var i = 0; i < len; i++) {
  if (!c.getDatasetMeta(i).hidden)
   val = vadd(val, dat[i]);
  c.data.datasets[i].data = val;
 }
 c.update();
}

// ---------------------------------------------------------------------
function legend_toggle(c, ndx) {
 var meta = c.getDatasetMeta(ndx);
 meta.hidden = meta.hidden === null ? !c.data.datasets[ndx].hidden : null;
}
// help

var Page3Help = `
<h3>Report</h3>
The data is a table of 400K insurance records with values generated at random, in the form:
<pre>
┌───────┬────────┬─────────┬─────┬─────────┬───────────┬────┬───────┬──────┐
│company│division│region   │state│line     │perspective│year│quarter│value │
├───────┼────────┼─────────┼─────┼─────────┼───────────┼────┼───────┼──────┤
│beta   │div_4   │west     │WA   │comm auto│gross      │2016│q4     │ 67393│
│epsilon│div_5   │west     │CO   │travel   │net        │2015│q3     │689083│
│alpha  │div_4   │southwest│TX   │flood    │ceded      │2017│q3     │181522│
│gamma  │div_1   │southwest│LA   │health   │ceded      │2017│q2     │ 74048│
│delta  │div_3   │midwest  │IN   │flood    │ceded      │2016│q1     │106284│
└───────┴────────┴─────────┴─────┴─────────┴───────────┴────┴───────┴──────┘
</pre>

<p>The axes are shown in two rows: at the top are pages into the data,
and below are the rows and columns. Each axis may be subset, and the
axis tiles may be dragged and dropped to pivot the data.</p>

<p>Page selections are subtotalled, except for <i>perspective</i> where totals allow
for gross=net+ceded.</p>

<p>The table display is an ordinary HTML table. The rendering will take a
few seconds if the entire dataset is displayed, i.e. with no pages or axis selections.</p>

<p>The charts are drawn using
<a href="http://www.chartjs.org//?external">Chart.js</a>.
On the right of each chart is a list of color/name legends:</p>

<ul>
<li>click any legend toggles its chart values on/off</li>
<li>ctrl-click any legend toggles all other chart values on/off</li>
<li>ctrl+shift+click anywhere in the chart restores all values</li>
</ul>
`

// ---------------------------------------------------------------------
function popup(txt) {
 var d = document.createElement("div");
 d.setAttribute("id", "popup");
 d.setAttribute("class", "modal");
 var c = document.createElement("div");
 c.setAttribute("id", "popup-content");
 c.setAttribute("class", "modal-content");
 var a = "<a href='#' class='close' onclick='popup_close()'>&times;</a>";
 c.innerHTML = a + txt;
 d.appendChild(c);
 document.body.appendChild(d);
 listen("popup_close", "click", popup_close);
}

// ---------------------------------------------------------------------
function popup_close() {
 var d = getid("popup");
 document.body.removeChild(d);
}
// linechart

"use strict"

// ---------------------------------------------------------------------
function draw_areachart(arg, wh) {
 draw_linechart1(arg, wh, true);
}

// ---------------------------------------------------------------------
function draw_linechart(arg, wh) {
 draw_linechart1(arg, wh, false);
}

// ---------------------------------------------------------------------
function draw_linechart1(arg, wh, filler) {
 var title = arg[0];
 var rws = arg[1];
 var cls = arg[2];
 var rlen = rws.length;
 var clen = cls.length;
 var dat = v2mat(arg[3], rlen, clen);
 var val = jsoncopy(dat);
 if (filler)
  val = msums(val);
 var color = [];
 var len = CB0.length;
 for (var i = 0; i < rlen; i++)
  color.push(CB0[i % len]);

 var dset = [];
 for (var i = 0; i < rlen; i++) {
  let t = {};
  t.label = rws[i];
  t.data = val[i];
  t.backgroundColor = color[i];
  t.borderColor = color[i];
  t.borderWidth = 1;
  t.fill = filler;
  dset.push(t);
 }

 var val = {};
 val.labels = cls;
 val.datasets = dset;

 var opt = {};
 opt.type = "line";
 opt.data = val;

 /* beautify preserve:start */
 opt.options = {
  animation: false,
  legend: {onClick: legend_click, position: "right"},
  maintainAspectRatio: false,
  onClick: chart_click,
  title: {display: true, text: title }}
 opt.options.scales = {xAxes: [{ticks: {autoSkip: false}}],
   yAxes: [{ticks: {beginAtZero:true, callback:chart_format} }]};
 if (filler)
  opt.options.legend = {onClick: legend_click_area, position: "right"};
 /* beautify preserve:end */

 var ctx = getclearcontext(wh);
 MyChart = new Chart(ctx, opt);
 MyChart.mydata = dat;
}
// page 0

"use strict";

// ---------------------------------------------------------------------
function page0init() {
 window.onresize = null;
 overflow(true);

 document.body.innerHTML = `
 <p>This demo illustrates the J webview control included in the full Qt IDE V1.6 and later.</p>

 <p>The control is used to display web pages, which may be local or read from the internet.
 It allows building applications that have both standard Qt Desktop controls and web pages,
 as in this demo. HTML/Javascript are used to program the pages.</p>

 <p>The webview control includes the
 <a href="https://en.wikipedia.org/wiki/Blink_(web_engine)?external">Blink</a>
 web_engine, which is used in Chromium and the Google Chrome browser.</p>

 <p>The main Qt technologies used are <a href="http://doc.qt.io/qt-5/qwebengineview.html?external">QWebEngineView</a>
 for the browser page, and <a href="http://doc.qt.io/qt-5/qwebchannel.html?external">QWebChannel</a> for the interface.</p>

 <p>Note that if you click the above links, they are opened in an external browser. They could be opened in the webview control,
 but that would also replace the Javascript attached to the control, see this demo's Web page.</p>

 <p>In this demo, any webview events will be displayed in the terminal.</p>`
}
// page 1

"use strict";

// ---------------------------------------------------------------------
function page1init() {
 window.onresize = null;
 overflow(true);

 document.body.innerHTML = `
 <p>The Window Driver <tt>wd</tt> is used to communicate with the webview control, and
has the form:</p>

 <pre> wd 'cmd w xxx'</pre>

 where <tt>w</tt> is the webview child id, and <tt>xxx</tt> is the command string sent to the control.

 <p>Exactly how the command strings are interpreted has to be programmed and will depend on the application.
 The scheme used in this demo is:</p>

 <pre>
 wd 'cmd w set name value'        set value to name
 wd 'cmd w get name'              get value of name
 wd 'cmd w call fname [parms]'    call Javascript function with optional parameters
 wd 'cmd w callr fname [parms]'   as call, but also returning the result
 wd 'cmd w eval string'           evaluate a Javascript string, returning the result</pre>

 <p>The webview page will need Javascript functions to handle the J calls. In this case,
 the functions are named with a "j" prefix, e.g. <tt>jset</tt>, <tt>jget</tt>.</p>

 <p>Any results returned from the webview are given in a wd event, so J handlers are needed for these events.
 This demo uses only a single <i>post</i> event, with corresponding <i>name</i> and <i>value</i>.
 The names include:

 <ul>
 <li>return  - result from a J command (i.e. from <i>get</i>, <i>callr</i>, <i>eval</i>)</li>
 <li>error   - an error message</li>
 <li>init    - sent by the webpage after the comms link is established
 <li>{other} - data requests
 </ul>

 <p>The value will be in Javascript string representation. This can be decoded by the convert/pjson addon.</p>

 <p>Try the examples below. You can cut and paste from this display, or open
 the following script with the examples and step through the lines:

 <pre> open '~addons/demos/wd/webview/comms.ijs'</pre>

<h3>Form controls</h3>

 <div style='display:flex;align-items:flex-start'><table>
 <tr><td>first:</td><td><input type="text" id="first" value="Anne" /></td></tr>
 <tr><td>last:</td><td><input type="text" id="last" value="Blake" /></td></tr>
 </table>
 <input style='margin-left:10px' type="button" value="send" onclick="return sendname()" /></div>

<p>The <i>set</i> command has been defined to set the corresponding input fields. Try:</p>
 <pre>
 wd 'cmd w set first Andy'       NB. set first name
 wd 'cmd w set last Burton'      NB. set last name</pre>
<p>Press the send button to send the full name back to J (in a post event).</p>

<h3>get Javascript global</h3>

<p>The <i>get</i> command has been defined to read Javascript globals. Try:</p>

 <pre>
 wd 'cmd w get Random'           NB. get a random number generated on page load
 wd 'cmd w call makeRandom'      NB. generate a new random number
 wd 'cmd w get Random'           NB. get the new random number</pre>

<h3>Function calls</h3>

<p>The <i>call</i> (no result) and <i>callr</i> (with result) commands call Javascript functions,
optionally with parameters.

The <i>eval</i> command evaluates a string as a Javascript expression and returns a result.</p>

 <pre>
 wd 'cmd w eval 2+3'             NB. evaluate a Javascript expression

 wd 'cmd w callr randomint 100'  NB. generates a random integer less than 100
 wd 'cmd w eval randomint(100)'  NB. evaluate the corresponding Javascript expression

 wd 'cmd w callr vplus "[2,3,5,7]" 10'  NB. call function to add array and single number
 wd 'cmd w eval *[2,3,5,7].reduce((a,b) => a+b,0)'  NB. expression to sum array</pre>`
}
// page 2

"use strict";

var d3draw;
var d3name = "price";

// ---------------------------------------------------------------------
function page2init() {
 overflow(false);
 document.body.innerHTML = `
 <div style='height:100%;display:flex;flex-direction:column;margin:0px;padding:0px;'>
 <div style='flex-grow:0'>
 <p>This demo shows plots using the <a href="https://d3js.org/?external">D3</a>
 visualization library, with data generated at random in J.</p>
 <p>Plot selection and the <i>new data</i> button are standard HTML controls which
  trigger J events. Any mouseover events are handled by D3, e.g. hover over the stock or city names.</p>
  <div style='display:flex;'>
  <select id="page2select" style="margin:0 10px 0 10px;" onchange="page2selected()">
  <option>stock prices</option>
  <option>scatter plot</option></select>
  <button onclick="page2rerun()">new data</button>
  </div>
 </div>
  <div id="plot" style='display:flex;flex-grow:1;'>
  <div id="draw" style="flex;flex-grow:1;"></div>
  <div id="select"></div>
  </div>
 </div>
`
 plotinit();
 window.onresize = page2resize;
}

// ---------------------------------------------------------------------
function d3plot(s) {
 dates = datx = datv = daty = key = label = type = '';
 eval(s[0]);
 plotpaint();
}

// ---------------------------------------------------------------------
function plotinit() {
 getid("page2select").selectedIndex = ((d3name === "price") ? 0 : 1);
 d3draw = getid("draw");
 jpost("d3plot", d3name);
}

// ---------------------------------------------------------------------
function plotpaint() {
 var p = d3name === "price";
 getid("select").style.display = p ? "none" : "block";
 if (p)
  paint_price();
 else
  paint_scatter();
}

// ---------------------------------------------------------------------
function page2selected() {
 var ndx = getid("page2select").selectedIndex;
 d3name = ["price", "scatter"][ndx];
 jpost("d3plot", d3name);
}

// ---------------------------------------------------------------------
function page2rerun() {
 if (d3name === "scatter")
  SelectedNms = arraymask(nubcountry, Selected);
 jpost("d3plot", d3name);
}

// ---------------------------------------------------------------------
function page2resize() {
 clearTimeout(resizeTimer)
 resizeTimer = setTimeout(plotpaint, 100)
}
// page 3

"use strict";

var Page3Formats = ["table", "barchart", "stackedbarchart", "linechart", "areachart"];

// ---------------------------------------------------------------------
function page3init() {
 overflow(true);
 window.onresize = null;
 document.body.innerHTML = `
 <p>This report is a pivot view into J data, see the help for more information.</p>
 <div style='display:flex;margin-top:-.5em'>
  <select id="page3select" style="margin:0 10px 0px 0px;" onchange="page3selected()">
  <option>Table</option><option>Bar Chart</option><option>Stacked Bar Chart</option>
  <option>Line Chart</option><option>Area Chart</option></select>
  <span style="flex-grow:1"></span>
  <button style="margin-right:10px;" onclick="page3flip()">flip xy axes</button>
  <button style="margin-right:10px;" onclick="page3rerun()">new data</button>
  <button onclick="page3help()">help</button>
  </div></div><div style="height:5px"></div>
 <div id="report"></div><canvas id="qextcan" hidden></canvas>`
 getid("page3select").selectedIndex = Page3Formats.indexOf(Cube.format);
 reportinit();
}

// ---------------------------------------------------------------------
function report(s) {
 AA = s[0];
 eval(s[0]);
 Axis.orderold = jsoncopy(Axis.order);
 getid("page3select").selectedIndex = Page3Formats.indexOf(Cube.format);
 drawreport();
}

// ---------------------------------------------------------------------
function reportinit() {
 jpost("report", "");
}

// ---------------------------------------------------------------------
function page3flip() {
 var rws = Axis.order[1];
 Axis.order[1] = Axis.order[0];
 Axis.order[0] = rws;
 showorder();
}

// ---------------------------------------------------------------------
function page3help() {
 popup(Page3Help);
}

// ---------------------------------------------------------------------
function page3rerun() {
 jpost("newdata", "");
}

// ---------------------------------------------------------------------
function page3resizer() {
 if (Cube.format !== "table")
  return drawchart(true);
}

// ---------------------------------------------------------------------
function page3resize() {
 clearTimeout(resizeTimer)
 resizeTimer = setTimeout(page3resizer, 100)
}

// ---------------------------------------------------------------------
function page3selected() {
 var f = Page3Formats[getid("page3select").selectedIndex];
 if (f !== Cube.format)
  jpost("setformat", f);
}
// page 4

"use strict";

// ---------------------------------------------------------------------
function page4init() {
 window.onresize = null;
 overflow(true);

 document.body.innerHTML = `
 <p>By default, external links in webview are opened in the webview control itself. However, this
 also replaces the webview's Javascript, so J can no longer communicate with it.
 If necessary, some method would be needed to return to the original webview page.</p>

 <p>For a link to be opened in a separate browser, the url should end with either
 "?external" or "&external". This will leave the original webview page unchanged.</p>

 <p>In this demo, if a page is opened in the webview, the page buttons at top
 left no longer work. To restore the demo, click the Reload button at bottom
 left, which loads the demo again.</p>

 <p>Try:

 <ul>
 <li>this link will open in a separate browser: <a href="http://d3js.org?external">D3</a></li>
 <li>this link will open in the webview: <a href="http://d3js.org">D3</a></li>
 </ul>
`
}
// init

"use strict";

var x, y;
var ay, vay, vy;
var ax, dx, vx;
var voff, vstep, vwid;
var ifVolume;
var color, legendHeight, selectWidth, svg, tip;
var datefmt, dates, datx, datv, daty, key, label, type;
var kh, kr, ks, ky, mx, my, mr, ms;
var Dx, Dy, Dr, Ds, Px, Py, Pr, Ps, Vx, Vy, Vr, Vs, Sx, Sy, Sr, Ss;

// ---------------------------------------------------------------------
// cut numeric list into matrix, zero padded
function cut(n, a) {
 var r = [],
  i, len = a.length;
 if (len == 0) return r;
 var rws = Math.ceil(len / n)
 var s = a.slice(0);
 for (i = 0; i < n; i++) s.push(0)
 for (i = 0; i < len; i += n) r.push(s.slice(i, n + i))
 return r
}

// ---------------------------------------------------------------------
// max over list, leaving 0 unchanged
function pmax(a) {
 var r = [],
  m = d3.max(a);
 for (var i = 0; i < a.length; i++)
  r.push(a[i] > 0 ? m : 0)
 return r
}

// ---------------------------------------------------------------------
function reshape(len, pos) {
 var p = pos.length,
  r = [];
 for (var i = 0; i < len; i++)
  r.push(pos[i % p])
 return r
}

// ---------------------------------------------------------------------
function rowindex(rws, cls) {
 var r = [];
 for (var i = 0; i < rws; i++)
  for (var j = 0; j < cls; j++)
   r.push(i)
 return r
}

// ---------------------------------------------------------------------
function setdxyrs(x, y, r, s) {
 Dx = x
 Dy = y
 Dr = r
 Ds = s
}

// ---------------------------------------------------------------------
function setpxyrs(x, y, r, s) {
 Px = x;
 Py = y;
 Pr = r;
 Ps = s;
 setsxyrs(x, y, r, s);
 setdxyrs(0, 0, 0, 0);
 setvxyrs(0, 0, 0, 0);
}

// ---------------------------------------------------------------------
function setsxyrs(x, y, r, s) {
 Sx = x;
 Sy = y;
 Sr = r;
 Ss = s;
}

// ---------------------------------------------------------------------
function setvxyrs(x, y, r, s) {
 Vx = x;
 Vy = y;
 Vr = r;
 Vs = s;
}

// ---------------------------------------------------------------------
// spread keys into max width, return col widths
function spread(max, a) {
 var len = a.length
 var c = spreadmax(max, a);
 if (c == a.length) return vsumsr(a)
 do {
  if (c == 1) return [d3.max(a)]
  var r = spreadcol(c, a);
  if (max >= r[0]) return r
 } while (c--)
}

// ---------------------------------------------------------------------
function spreadcol(cls, a) {
 var r = []
 var m = d3.transpose(cut(cls, a));
 for (var i = m.length - 1; i >= 0; i--) {
  m[i] = pmax(m[i])
  r.unshift(d3.max(m[i]));
  if (i)
   m[i - 1] = vsum(m[i], m[i - 1])
 }
 return r
}

// ---------------------------------------------------------------------
function spreadmax(max, a) {
 var i = 0,
  w = 0;
 while (i < a.length && max >= w + a[i]) w += a[i++]
 return Math.max(i, 1)
}

// ---------------------------------------------------------------------
// sum two lists
function vsum(a, b) {
 var r = [];
 for (var i = 0; i < a.length; i++)
  r.push(a[i] + b[i])
 return r
}

// ---------------------------------------------------------------------
// cumulative sum list
function vsums(a) {
 if (a.length == 0) return [];
 var r = [a[0]];
 for (var i = 1; i < a.length; i++)
  r.push(a[i] + r[i - 1])
 return r
}

// ---------------------------------------------------------------------
// reverse cumulative sum list
function vsumsr(a) {
 var r = a.slice(0);
 return vsums(r.reverse()).reverse()
}

// ---------------------------------------------------------------------
function drawlayout() {
 var ext, min, max, p, t;

 setdxyrs(Sx + mx, Sy + my, Sr - mr, Ss - ms)

 var len = daty[0].length;
 var yticks = 4;

 // adjust for top labels and bottom axis:
 if (ifVolume) {
  var h = Ds - Dy
  var h0 = h - Math.min(h * 0.25, screen.height / 8)
  setvxyrs(Dx, Dy + h0 + my + ms, Dr, Ds)
  Ds = Dy + h0 - my
 }

 // scales
 ext = d3.extent(d3.merge(daty))
 min = Math.floor(ext[0] * 0.99)
 max = Math.ceil(ext[1] * 1.01)
 y = d3.scaleLinear().domain([min, max]).range([Ds, Dy]).nice()

 ay = d3.axisLeft(y).ticks(yticks);

 if (ifVolume)
  ay.tickFormat(d3.format("s"))

 t = svg.append("g").call(ay)
 p = -t.node().getBBox().x
 Dx = Sx + mx + p
 t.remove()

 var s = (Dr - Dx) / len
 vwid = Math.max(Math.min(6, s), s * 0.75)
 vstep = 0.5 + (Dr - Dx) / len
 voff = vstep / 2

 // volume scales
 if (ifVolume) {
  max = Math.ceil(d3.max(datv) * 1.05)
  min = 0
  vy = d3.scaleLinear().domain([min, max]).range([Vs, Vy]).nice()

  vay = d3.axisLeft().scale(vy).ticks(3).tickSize(Dx - Dr)
   .tickFormat(d3.format(".3s"))

  t = svg.append("g").call(vay)
  p = -t.node().getBBox().x
  Dx = Math.max(Dx, Sx + mx + p)
  Vx = Dx
  t.remove()
 }

 ay = d3.axisLeft().scale(y).ticks(4).tickSize(Dx - Dr)

 ext = d3.extent(dates)
 min = ext[0]
 max = ext[1]
 x = d3.scaleTime().domain([0, len - 1]).range([Dx + voff, Dr - voff])
 dx = d3.scaleTime().domain([min, max]).range([Dx + voff, Dr - voff])
 ax = d3.axisBottom(dx).tickSize(Dy - Ds)
  .ticks(Math.min(5, len - 1)).tickFormat(d3.timeFormat(datefmt))
}

// ---------------------------------------------------------------------
function drawlegend() {
 var tw = 0
 if (label.length)
  tw = qextentw(label, "label")

 var lr = Pr - mr - kr
 var lw = Math.max(200, Pr - Px - mx - mr - tw - 125)

 var pos = spread(lw, qextentkey(key))
 var cls = pos.length
 var rws = Math.ceil(key.length / cls)
 var px = reshape(key.length, pos)
 var py = rowindex(rws, cls)

 var res = ky + kh * rws;

 if (!key) return res;

 var s = svg.selectAll("g.legend").data(key).enter().append("g")
  .attr("class", "key")
  .on('mouseover', legendMouseover)
  .on('mouseout', legendMouseout)

 s.append("circle")
  .attr("class", "legend")
  .attr("r", 5)
  .attr("fill", function(d, i) {
   return color(i)
  })

 s.append("text")
  .attr("class", "legend")
  .attr("dx", 8)
  .attr("dy", ".32em")
  .text(function(d, i) {
   return key[i]
  })

 s.attr("transform", function(d, i) {
  return "translate(" + (lr - px[i]) + "," + (Py + my + ky + kh * py[i]) + ")"
 })

 return res;
}

// ---------------------------------------------------------------------

function legendMouseover(d, i) {
 d3.select("#d" + i).classed("hover", true)
}

// ---------------------------------------------------------------------
function legendMouseout(d, i) {
 d3.select("#d" + i).classed("hover", false)
}

// ---------------------------------------------------------------------
function drawlabel() {
 if (label.length == 0) return
 svg.append('text').text(label)
  .attr("class", "label")
  .attr('x', Dx + 2)
  .attr('y', Dy - 5)
}

// ---------------------------------------------------------------------
function drawaxis(x, y, a, s) {
 svg.append("g")
  .attr("class", s + " axis")
  .attr("transform", "translate(" + x + "," + y + ")")
  .call(a)
}

// ---------------------------------------------------------------------
function drawprice() {

 var line = d3.line()
  .x(function(d, i) {
   return x(i)
  })
  .y(function(d) {
   return y(d)
  })

 var s = svg.selectAll("g.line").data(daty).enter()
  .append("path")
  .attr("id", function(d, i) {
   return "d" + i
  })
  .attr("class", "line")
  .attr("stroke", function(d, i) {
   return color(i)
  })
  .attr("d", line)

 drawtrim()

}

// ---------------------------------------------------------------------
function drawtrim() {
 drawlabel()
 drawaxis(0, Ds, ax, "")
 drawaxis(Dx, 0, ay, "y")
 svg.append("line")
  .attr("class", "raxis")
  .attr("x1", Dr)
  .attr("x2", Dr)
  .attr("y1", Dy)
  .attr("y2", Ds)
}

// ---------------------------------------------------------------------
function drawvolume() {
 var vx = Vx + (vstep - vwid) / 2

 var s = svg.selectAll("g.volume").data(datv).enter()
  .append("rect")
  .attr("class", "bar")
  .attr("x", function(d, i) {
   return vx + vstep * i
  })
  .attr("width", vwid)
  .attr("y", function(d) {
   return vy(d)
  })
  .attr("height", function(d) {
   return Math.max(0, Vs - vy(d))
  })

 // ---------------------------------------------------------------------
 svg.append('text').text("volume")
  .attr("class", "label")
  .attr('x', Vx + 2)
  .attr('y', Vy - 5)

 // ---------------------------------------------------------------------
 ax.tickSize(Vy - Vs)

 svg.append("g")
  .attr("class", "axis")
  .attr("transform", "translate(0," + Vs + ")")
  .call(ax)

 // ---------------------------------------------------------------------
 svg.append("g")
  .attr("class", "y axis")
  .attr("transform", "translate(" + Vx + ",0)")
  .call(vay)

 // ---------------------------------------------------------------------
 svg.append("line")
  .attr("class", "raxis")
  .attr("x1", Dr)
  .attr("x2", Dr)
  .attr("y1", Vy)
  .attr("y2", Vs)

}

// ---------------------------------------------------------------------
function getplotheight() {
 return getid("plot").clientHeight;
}

// ---------------------------------------------------------------------
function getplotwidth() {
 return getid("plot").clientWidth;
}

// ---------------------------------------------------------------------
function paint_price() {
 var h, p, w;
 voff = vstep = vwid = 0

 // default margins
 mx = 15
 my = 10
 mr = 10
 ms = 10

 // key row height, right, top margins
 kh = 18
 kr = 0
 ky = 10

 document.title = type

 ifVolume = datv.length > 0;
 color = d3.scaleOrdinal(d3.schemeCategory10);

 w = Math.max(100, getplotwidth())
 h = Math.max(100, getplotheight())

 setpxyrs(0, 0, w - 10, h - 10)

 // ---------------------------------------------------------------------
 svg = d3.select("#draw").html("").append("svg")
  .attr("class", "svg")
  .attr("id", "plot")
  .attr("width", Pr)
  .attr("height", Ps)

 // ---------------------------------------------------------------------
 p = drawlegend();
 setsxyrs(Sx, Sy + p, Sr, Ss)
 drawlayout()
 window["draw" + type]()

 if (ifVolume)
  drawvolume()
}
// report

"use strict";

var Axis = {};
var Cube = {};
var SliceMH = 0;
var MyChart;
var CB0 = [
 "#1f78b4", "#f34c4c", "#33a02c", "#ff7f00", "#6a3d9a", "#b15928",
 "#a6cee3", "#fb9a99", "#b2df8a", "#fdbf6f", "#cab2d6", "#ffff99",
 "#8da0cb", "#fc8d62", "#66c2a5", "#e78ac3", "#a6d854", "#ffd92f", "#e5c494", "#b3b3b3"
];

// ---------------------------------------------------------------------
function drawreport() {
 var h = "<div id='cubepane'>" +
  "<div class='cubehdrtop'>" + makeslices() + makerwscls() + "</div>" +
  "<div style='height:5px'></div>" + maketab() + "</div>";
 getid("report").innerHTML = h;
 setsliceheight();
 listen("btndrag", "click", click);
 listen("btndrag", "dragstart", dragstart);
 var d = getclass("btndrop");
 listen(d, "drop", drop);
 listen(d, "dragend", dragend);
 listen(d, "dragover", dragover);
 window.onresize = page3resize;
 if (Cube.format !== "table")
  drawchart(false);
}

// ---------------------------------------------------------------------
function drawchart(resize) {
 var b = getrect("tabrws").bottom;
 var w = window.innerWidth - 30;
 var h = window.innerHeight - b - 22;
 if (resize) {
  var e = getid("mychartp");
  e.style.width = w + "px";
  e.style.height = h + "px";
 } else {
  var f = "draw_" + Cube.format;
  window[f](Cube.chart, [w, h]);
 }
}

// ---------------------------------------------------------------------
function drawgrid() {
 var h = "<div id='cubepane'><div class='cubehdrtop'>" +
  makeslices() + makerwscls() + "</div>" +
  "<div style='height:5px'></div>" + maketab() + "</div>";
 getid("report").innerHTML = h;
}

// ---------------------------------------------------------------------
function makecls() {
 var h = "<div id='tabcls' class='btndrop cubehdr cubehdrcls'>";
 return h + makeselects("cls", Axis.order[1]) + "</div>";
}

// ---------------------------------------------------------------------
function makerws() {
 var h = "<div id='tabrws' class='btndrop cubehdr cubehdrrws'>";
 return h + makeselects("rws", Axis.order[0]) + "</div>";
}

// ---------------------------------------------------------------------
function makerwscls() {
 return "<div style='display:flex;flex-shrink:0'>" + makerws() + makecls() + "</div>";
}

// ---------------------------------------------------------------------
function makeselects(tag, ind) {
 var h = "";
 for (var i = 0; i < ind.length; i++) {
  var j = ind[i];
  h += makeslicer("btn" + tag + "_" + j, Axis.names[j], Axis.labels[j], Axis.order[3][j]);
 }
 return h;
}

// ---------------------------------------------------------------------
function makeslices() {
 var h = "<div id='tabndx' class='btndrop cubehdr cubehdrslice'>";
 return h + makeselects("ndx", Axis.order[2]) + "</div>";
}

// ---------------------------------------------------------------------
function maketab() {
 if (Cube.format === "table")
  return "<div id='cubetab' class='cubeall'>" + Cube.html + "</div>";
 return "<div id='mychartp' style='position:relative;'>" +
  "<canvas id='mychart'></canvas></div>";

}

// ---------------------------------------------------------------------
function showorder() {
 if (matches(Axis.order, Axis.orderold)) return;
 jpost("setorder", JSON.stringify(Axis.order));
}

// ---------------------------------------------------------------------
function showtarget(e) {
 var s = e ? "#e8e8e0" : "";
 ["tabcls", "tabrws", "tabndx"].map(function(e) {
  getid(e).style.background = s;
 })
}

// ---------------------------------------------------------------------
function click(e) {
 if (e.target.className !== "btnslicerarrow") return;
 var id = e.target.parentElement.id;
 var ndx = Number(id.slice(7));
 var cap = Axis.names[ndx];
 var names = Axis.labels[ndx];
 var sel = Axis.order[3][ndx];
 slicer_select(id, ndx, cap, names, sel, click_cb);
}

// ---------------------------------------------------------------------
function click_cb(ndx, sel) {
 Axis.order[3][ndx] = sel;
 showAxisorder("click_cb");
 showorder();
}

// ---------------------------------------------------------------------
function dragstart(ev) {
 var d = ev.target.id + " " + ev.x + " " + ev.y
 ev.dataTransfer.setData("text", d);
 showtarget(true);
}

// ---------------------------------------------------------------------
function dragend(e) {
 showtarget(false);
}

// ---------------------------------------------------------------------
function dragover(e) {
 e.preventDefault();
}

// ---------------------------------------------------------------------
function drop(e) {
 e.preventDefault();

 var tgt = e.target.id.slice(3, 6);
 if (tgt.length === 0) return;

 var dat = e.dataTransfer.getData("text").split(" ");
 if (70 > Math.abs(e.x - dat[1]) && 20 > Math.abs(e.y - dat[2]))
  return;

 var txt = dat[0];
 var src = txt.slice(3, 6);
 var mov = Number(txt.slice(7));

 if (src === tgt)
  return dropsame(src, mov);

 var rws = Axis.order[0];
 var cls = Axis.order[1];
 var ndx = Axis.order[2];
 var sel = Axis.order[3];

 var mov;

 if (src === "rws") {
  rws = arrayexcept(rws, mov);
  if (rws.length === 0)
   if (tgt === "ndx" && ndx.length > 0)
    rws.push(arrayremlast(ndx));
   else
    rws.push(arrayremlast(cls));
 } else if (src === "cls") {
  cls = arrayexcept(cls, mov);
  if (cls.length === 0)
   if (tgt === "ndx" && ndx.length > 0)
    cls.push(arrayremlast(ndx));
   else
    cls.push(arrayremlast(rws));
 } else if (src === "ndx")
  ndx = arrayexcept(ndx, mov);

 if (tgt === "rws")
  rws.push(mov);
 else if (tgt === "cls")
  cls.push(mov);
 else if (tgt === "ndx") {
  ndx.push(mov);
 }

 Axis.order = [rws, cls, ndx, sel];
 showAxisorder("drop");
 showorder();
}

// ---------------------------------------------------------------------
function dropsame(src, mov) {
 if (src === "rws")
  arraymovelast(Axis.order[0], mov);
 else if (src === "cls")
  arraymovelast(Axis.order[1], mov);
 else if (src === "ndx")
  arraymovelast(Axis.order[2], mov);
 showAxisorder("dropsame");
 showorder();
}

// ---------------------------------------------------------------------
function selectslice(e) {
 alert("selectslice");
 var p = Number(e.target.id.slice(7));
 var n = e.target.selectedIndex;
 Axis.order[3][p] = n;
 showAxisorder("selectslice");
 showorder();
}

// ---------------------------------------------------------------------
// ensure two rows have same visible heights
function setsliceheight() {
 if (SliceMH === 0)
  SliceMH = Math.max(getrect("tabndx").height, getrect("tabrws").height);
 getid("tabndx").style.minHeight = SliceMH + "px";
 getid("tabrws").style.minHeight = (SliceMH - 1) + "px";
}

// ---------------------------------------------------------------------
// for debugging...
function showAxisorder(s) {
 return;
 var a = s + " " + Axis.order[0] + ";" + Axis.order[1] + ";" + Axis.order[2] + ";(";
 for (var i = 0; i < Axis.order[3].length; i++)
  a += Axis.order[3][i] + "|";
 a += ")";
 O(a);
}
// scatter

"use strict";

var Selectids = [];
var Selected = [];
var SelectedNms = [];

var showLabels = true;
var ifInit = false;
var tipwidth, xmax, ymax, xval, yval;
var city, country, continent, continents, nubcountry, population;
var fxval, fyval, fcity, fcountry, fcontinent, fpopulation;
var key = "";
var label = "";
var ycaption = "Cabling 2014-2017 (%)";

// ---------------------------------------------------------------------
function drawdots() {

 var d = svg.append("g")
  .attr("width", Dr - Dx)
  .attr("height", Ds - Dy)
  .attr("transform", "translate(" + Dx + "," + Dy + ")");

 var x = d3.scaleLinear().range([0, Dr - Dx]).domain([0, xmax]).nice();
 var y = d3.scaleLinear().range([Ds - Dy, 0]).domain([0, ymax]).nice();

 // x axis
 var ax = d.append("g")
  .attr("class", "axis")
  .attr("transform", "translate(0," + (Ds - Dy) + ")")
  .call(d3.axisBottom(x).ticks(8).tickSize(Dy - Ds));

 ax.selectAll("g")
  .filter(function(d) {
   return (d > 0) && (d < xmax);
  })
  .classed("minor", true);

 // y axis
 var ay = d.append("g")
  .attr("class", "axis")
  .call(d3.axisLeft(y).ticks(5).tickSize(Dx - Dr));

 ay.selectAll("g")
  .filter(function(d) {
   return (d > 0) && (d < ymax);
  })
  .classed("minor", true);

 // dots
 var node = d.selectAll("dot").data(fxval);

 node.enter()
  .append("circle")
  .attr("r", 5)
  .attr("cx", function(d) {
   return x(d);
  })
  .attr("cy", function(d, i) {
   return y(fyval[i]);
  })
  .attr("fill", function(d, i) {
   return color(i);
  })
  .attr("class", "dots")
  .attr("id", function(d, i) {
   return "dd" + i;
  })
  .on("mouseover", function(d, i) {
   tip.transition()
    .duration(200)
    .style("opacity", .9);
   tip.html(tipper(d, i))
    .style("width", tipwidth)
    .style("left", (d3.event.pageX - 40) + "px")
    .style("top", (d3.event.pageY - 60) + "px");
  })
  .on("mouseout", function(d) {
   tip.transition()
    .duration(500)
    .style("opacity", 0);
  });

 if (showLabels) {
  node.enter()
   .append("text")
   .attr("text-anchor", "middle")
   .attr("x", function(d, i) {
    return x(d);
   })
   .attr("y", function(d, i) {
    return y(fyval[i]) - 8;
   })
   .attr("class", "dots")
   .attr("id", function(d, i) {
    return "dt" + i;
   })
   .text(function(d, i) {
    return fcity[i];
   });
 }
}

// ---------------------------------------------------------------------
function drawnames() {

 if (!key) return 0;

 // allow for top line label:
 var tw = 5;
 if (label.length)
  tw = qextentw(label, "label");

 var lr = Pr - mr - kr;
 var lw = Math.max(200, Pr - Px - mx - mr - tw);

 var pos = spread(lw, qextentkey(key));
 var cls = pos.length;
 var rws = Math.ceil(key.length / cls);
 var px = reshape(key.length, pos);
 var py = rowindex(rws, cls);


 var s = svg.selectAll("g.legend").data(key).enter().append("g")
  .attr("class", "key")
  .on('mouseover', nameMouseover)
  .on('mouseout', nameMouseout);

 s.append("circle")
  .attr("class", "legend")
  .attr("r", 5)
  .attr("fill", function(d, i) {
   return color(i)
  });

 s.append("text")
  .attr("class", "legend")
  .attr("dx", 8)
  .attr("dy", ".32em")
  .text(function(d, i) {
   return key[i]
  });

 s.attr("transform", function(d, i) {
  return "translate(" + (lr - px[i]) + "," + (Sy + my + ky + kh * py[i]) + ")"
 });

 return ks + my + ky + kh * rws;
}

// ---------------------------------------------------------------------
function filter_data() {
 fxval = [];
 fyval = [];
 fcity = [];
 fcountry = [];
 fcontinent = [];
 fpopulation = [];

 var val = arraymask(nubcountry, Selected);
 var len = country.length;
 for (var i = 0; i < len; i++)
  if (has(val, country[i])) {
   fxval.push(xval[i]);
   fyval.push(yval[i]);
   fcity.push(city[i]);
   fcountry.push(country[i]);
   fcontinent.push(continent[i]);
   fpopulation.push(population[i]);
  }
}

// ---------------------------------------------------------------------
function nameMouseover(d, i) {
 d3.select("#dd" + i).classed("active", true);
 d3.select("#dt" + i).classed("active", true);
}

// ---------------------------------------------------------------------
function nameMouseout(d, i) {
 d3.select("#dd" + i).classed("active", false);
 d3.select("#dt" + i).classed("active", false);
}

// ---------------------------------------------------------------------
function define_paint() {
 color = d3.scaleOrdinal(d3.schemeCategory20);
 selectWidth = 10 + Math.ceil(arraymax(qextentkey(nubcountry, "fsmaller")));
 getid("select").style.width = selectWidth;
 tip = d3.select("body").append("tip")
  .attr("class", "tooltip")
  .style("opacity", 0);
}

// ---------------------------------------------------------------------
function paint_scatter() {
 if (!ifInit) {
  define_paint();
  Selected = Array(nubcountry.length).fill(true);
  ifInit = true;
 } else {
  if (SelectedNms.length) {
   if (has(SelectedNms, "Show All"))
    Selected = Array(nubcountry.length).fill(true);
   else
    Selected = arraymember(nubcountry, SelectedNms);
   SelectedNms = [];
  }
 }

 filter_data();
 // default margins
 mx = 60;
 my = 10;
 mr = 25;
 ms = 15;

 // key row height, right, bottom, top margins:
 kh = 18;
 kr = 0;
 ks = 5;
 ky = 10;

 key = fcity;

 var w = Math.max(100, getplotwidth() - selectWidth);
 var h = Math.max(100, getplotheight());

 setpxyrs(0, 0, w, h);

 d3.select("svg").remove();

 svg = d3.select("#draw").append("svg")
  .attr("width", Pr - Px)
  .attr("height", Ps - Py);

 legendHeight = drawnames();
 setsxyrs(Sx, Sy + legendHeight, Sr, Ss)
 drawselect();
 setdxyrs(Sx + mx, Sy + my, Sr - mr, Ss - ms);
 drawborder();
 drawdots();
}

// ---------------------------------------------------------------------
function drawselect() {
 var first = Selectids.length === 0;
 Selectids = [];
 var len = nubcountry.length;

 var h = "<div style='margin-top:" + (legendHeight + 5) + "px;'></div>" +
  "<table id='selectab' class='fsmaller tdb' style='height:" + (Ss - Sy - 5) + "px;'><tr><td>"
 for (var i = 0; i < len; i++)
  h += drawselector(nubcountry[i]);
 h += "</td></tr><tr><td style='height:100%;'></td></tr>";
 h += "<tr><td style='text-align:center'>" +
  "<input type='checkbox' id='cblabel'>Labels</input>" +
  "</td></tr><tr><td style='height:5px'></td></tr>" +
  "<tr><td style='height:5px'></td></tr></table>";
 getid("select").innerHTML = h;

 if (first)
  select_all(true, false);
 else
  select_refresh(false);

 for (var i = 0; i < len; i++)
  getid(Selectids[i])
  .addEventListener("click", select_event);

 getid("cblabel").addEventListener("change", cblabel_event);
 getid("cblabel").checked = showLabels;
}

// ---------------------------------------------------------------------
function cblabel_event() {
 showLabels = !showLabels;
 paint_scatter();
}

// ---------------------------------------------------------------------
function drawselector(name) {
 var id = "sel" + getpid(name);
 Selectids.push(id);
 return "<input type='checkbox' id='" + id + "'>" + name + "</input><br/>";
}

// ---------------------------------------------------------------------
function findpid(array, id) {
 for (var i = 0; i < array.length; i++)
  if (id === getpid(array[i])) return i;
 return -1;
}

// ---------------------------------------------------------------------
function getpid(id) {
 var p = id.toLowerCase();
 p = p.replace(/ & /g, "_").replace(/ /g, "_").replace(/-/g, "");
 return p;
}

// ---------------------------------------------------------------------
// click on show all
function select_all(state, redraw) {
 Selected = Array(Selectids.length).fill(state);
 select_refresh(redraw);
}

// ---------------------------------------------------------------------
function select_event(e) {
 var id = e.target.id.substring(3);
 var ndx = findpid(nubcountry, id);
 if (ndx === 0)
  select_all(!Selected[0], true);
 else
  select_other(ndx);
}

// ---------------------------------------------------------------------
function select_other(ndx) {
 Selected[ndx] = !Selected[ndx];
 Selected[0] = true;
 for (var i = 1; i < Selected.length; i++)
  if (!Selected[i]) Selected[0] = false;
 select_refresh(true);
}

// ---------------------------------------------------------------------
function select_refresh(redraw) {
 for (var i = 0; i < Selected.length; i++)
  getid(Selectids[i]).checked = Selected[i];
 if (!redraw) return;
 filter_data();
 paint_scatter();
}

// ---------------------------------------------------------------------
function drawborder() {
 svg.append("text")
  .attr("x", -(Dy + Ds) / 2)
  .attr("y", 25)
  .attr("text-anchor", "middle")
  .attr("transform", "rotate(-90)")
  .text(ycaption);
}

// ---------------------------------------------------------------------
function tipper(d, i) {
 var cont = continents[fcontinent[i]];
 var h = fcity[i] + ", " + fcountry[i] + ", " + cont;
 var p = "Population: " + fpopulation[i] + "m.";
 tipwidth = 24 + Math.max(qextentw(h, "fsmaller"), qextentw(p, "fs"));
 return h + "</br>" + p;
}
// slicer

"use strict";

// ---------------------------------------------------------------------
function makeslicer(id, cap, names, sel) {
 var sid;
 var len = sel.length;
 if (len === 0)
  sid = "[none selected]";
 else if (has(sel, -1) || len === names.length)
  sid = "[all]";
 else if (len === 1)
  sid = names[sel[0]];
 else
  sid = "[" + len + " selected]";
 var h = "<button id='" + id + "' class='btnslicer btndrag'" +
  " draggable='true'><span class='btnslicertext'>" + cap + ":&nbsp;" + sid +
  "</span><span class='btnslicerarrow'>&nbsp;&#x25BE&nbsp;</span></button>";
 return h;
}

// ---------------------------------------------------------------------
function slicer_select(id, ndx, cap, names, sel, cb) {
 var pos = getrect(id);
 var m = document.createElement("dialog");
 m.setAttribute("id", "slicersel");
 var pw = window.innerWidth - 10;
 var ph = window.innerHeight - 10;
 var w = Math.min(pw, Math.max(225, 100 + qextentcan(names)));
 var h = Math.min(Math.min(396, ph), 120 + 23 * names.length);
 var x = Math.max(5, Math.min(pos.right - 10, pw - w));
 var y = Math.max(5, Math.min(pos.bottom - 10, ph - h));
 m.style.left = x + "px";
 m.style.top = y + "px";
 m.style.minWidth = w + "px";
 m.style.height = h + "px";
 document.body.appendChild(m);

 // ---------------------------------------------------------------------
 function draw(s) {
  if (s !== undefined)
   sel = s;
  var h = "<div id='slicerseltop'><div style='padding-bottom:10px;'>" +
   "<span class='bold'>" + cap + "</span> (" + names.length + ")</div>" +
   "<button class='slicerselbtn'>Select All</button>&nbsp;" +
   "<button class='slicerselbtn'>Select None</button></div>" +
   "<div id='slicerselmid'>";
  var all = has(sel, -1);
  for (var i = 0; i < names.length; i++) {
   h += "<div style='margin-bottom:3px'><input id='" + id + i + "' " +
    ((all || has(sel, i)) ? "checked " : "") + "type='checkbox'/>&nbsp;" + names[i] + "</div>";
  }
  h += "</div><div id='slicerselend'>" +
   "<button class='slicerselbtn'>Apply</button>&nbsp;<button class='slicerselbtn'>Cancel</button></div>";
  m.innerHTML = h;
  var btn = m.getElementsByTagName("button");
  for (var i = 0; i < btn.length; i++)
   btn[i].addEventListener("click", click);
 }

 // ---------------------------------------------------------------------
 function click(e) {
  switch (e.target.innerText) {
   case "Select All":
    return draw([-1]);
   case "Select None":
    return draw([]);
   case "Cancel":
    return close(false);
   case "Apply":
    return close(true);
  }
 }

 // ---------------------------------------------------------------------
 function close(b) {
  if (b) {
   var s = [];
   var inp = getid("slicerselmid").getElementsByTagName("input")
   for (var i = 0; i < inp.length; i++)
    if (inp[i].checked) s.push(i);
   if (s.length === 0)
    return mbinfo("At least one selection should be made");
   if (s.length === names.length)
    s = [-1];
   cb(ndx, s);
  }
  m.remove();
 }

 // ---------------------------------------------------------------------
 draw();
 m.showModal();
}
// start

"use strict";

var qcom;
var Random;
var resizeTimer;
var resizer;

// ---------------------------------------------------------------------
function initpage(n) {
 window["page" + n + "init"]();
}

// ---------------------------------------------------------------------
function makeRandom() {
 Random = randomint(1e9);
}

// ---------------------------------------------------------------------
function randomint(size) {
 return Math.floor(Math.random() * size);
}

// ---------------------------------------------------------------------
function sendname() {
 jpost("name", first.value + " " + last.value);
}

// ---------------------------------------------------------------------
function vplus(s) {
 var a = eval(s[0]);
 var t = eval(s[1])
 return a.map(e => e + t);
}

// ---------------------------------------------------------------------
window.onload = function() {
 makeRandom();
 new QWebChannel(qt.webChannelTransport, function(channel) {
  qcom = channel.objects.qcom;
  qcom.qNotify.connect(jnotify);
  jpost("init", "");
 });
}
