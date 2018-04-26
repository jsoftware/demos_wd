// barchart

"use strict"

// ---------------------------------------------------------------------
function draw_barchart(arg, wh) {
 draw_barchart1(arg, wh, false)
}

// ---------------------------------------------------------------------
function draw_stackedbarchart(arg, wh) {
 draw_barchart1(arg, wh, true)
}

// ---------------------------------------------------------------------
function draw_barchart1(arg, wh, stack) {
 var title = arg[0];
 var rws = arg[1];
 var cls = arg[2];
 var rlen = rws.length;
 var clen = cls.length;
 var dat = v2mat(arg[3], rlen, clen);

 var color = [];
 var len = CB0.length;
 for (var i = 0; i < rlen; i++)
  color.push(CB0[i % len]);

 var dset = [];
 for (var i = 0; i < rlen; i++) {
  let t = {};
  t.label = rws[i];
  t.data = dat[i];
  t.backgroundColor = color[i];
  t.borderColor = "#ddd";
  t.borderWidth = 1;
  dset.push(t);
 }

 var val = {};
 val.labels = cls;
 val.datasets = dset;

 var opt = {};
 var scales = {};
 opt.type = "bar";
 opt.data = val;

 /* beautify preserve:start */
 opt.options = {
  animation: false,
  legend: {onClick: legend_click, position: "right"},
  maintainAspectRatio: false,
  onClick: chart_click,
  title: {display: true, text: title }};

 scales={
  xAxes:[{ticks:{autoSkip:false}}],
  yAxes:[{ticks:{callback:chart_format}}]};
 /* beautify preserve:end */

 if (stack) {
  scales.xAxes[0].stacked = true;
  scales.yAxes[0].stacked = true;
 } else
  scales.yAxes[0].ticks.beginAtZero = true;

 opt.options.scales = scales;

 var ctx = getclearcontext(wh);
 MyChart = new Chart(ctx, opt);
}
