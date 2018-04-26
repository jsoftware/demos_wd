// linechart

"use strict"

// ---------------------------------------------------------------------
function draw_areachart(arg, wh) {
 draw_linechart1(arg, wh, true);
}

// ---------------------------------------------------------------------
function draw_linechart(arg, wh) {
 draw_linechart1(arg, wh, false);
}

// ---------------------------------------------------------------------
function draw_linechart1(arg, wh, filler) {
 var title = arg[0];
 var rws = arg[1];
 var cls = arg[2];
 var rlen = rws.length;
 var clen = cls.length;
 var dat = v2mat(arg[3], rlen, clen);
 var val = jsoncopy(dat);
 if (filler)
  val = msums(val);
 var color = [];
 var len = CB0.length;
 for (var i = 0; i < rlen; i++)
  color.push(CB0[i % len]);

 var dset = [];
 for (var i = 0; i < rlen; i++) {
  let t = {};
  t.label = rws[i];
  t.data = val[i];
  t.backgroundColor = color[i];
  t.borderColor = color[i];
  t.borderWidth = 1;
  t.fill = filler;
  dset.push(t);
 }

 var val = {};
 val.labels = cls;
 val.datasets = dset;

 var opt = {};
 opt.type = "line";
 opt.data = val;

 /* beautify preserve:start */
 opt.options = {
  animation: false,
  legend: {onClick: legend_click, position: "right"},
  maintainAspectRatio: false,
  onClick: chart_click,
  title: {display: true, text: title }}
 opt.options.scales = {xAxes: [{ticks: {autoSkip: false}}],
   yAxes: [{ticks: {beginAtZero:true, callback:chart_format} }]};
 if (filler)
  opt.options.legend = {onClick: legend_click_area, position: "right"};
 /* beautify preserve:end */

 var ctx = getclearcontext(wh);
 MyChart = new Chart(ctx, opt);
 MyChart.mydata = dat;
}
