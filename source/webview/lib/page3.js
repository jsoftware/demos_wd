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
