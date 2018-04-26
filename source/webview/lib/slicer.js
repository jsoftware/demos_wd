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
