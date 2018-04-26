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
