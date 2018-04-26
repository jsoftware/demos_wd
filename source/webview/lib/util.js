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
