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
