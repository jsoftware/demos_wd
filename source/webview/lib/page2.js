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
 ifInit = false;
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
