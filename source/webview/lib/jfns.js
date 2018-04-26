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
