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
 let selall = function() {
  Selected = Array(nubcountry.length).fill(true);
 }
 if (!ifInit) {
  define_paint();
  selall();
  ifInit = true;
 } else {
  if (SelectedNms.length) {
   if (has(SelectedNms, "Show All"))
    selall();
   else
    Selected = arraymember(nubcountry, SelectedNms);
   SelectedNms = [];
  } else
  if (Selected.length !== nubcountry.length)
   selall();
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
