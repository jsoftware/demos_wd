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
