// start

"use strict";

var qcom;
var Random;
var resizeTimer;

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
