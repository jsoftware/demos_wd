// help

var Page3Help = `
<h3>Report</h3>
The data is a table of 400K insurance records with values generated at random, in the form:
<pre>
┌───────┬────────┬─────────┬─────┬─────────┬───────────┬────┬───────┬──────┐
│company│division│region   │state│line     │perspective│year│quarter│value │
├───────┼────────┼─────────┼─────┼─────────┼───────────┼────┼───────┼──────┤
│beta   │div_4   │west     │WA   │comm auto│gross      │2016│q4     │ 67393│
│epsilon│div_5   │west     │CO   │travel   │net        │2015│q3     │689083│
│alpha  │div_4   │southwest│TX   │flood    │ceded      │2017│q3     │181522│
│gamma  │div_1   │southwest│LA   │health   │ceded      │2017│q2     │ 74048│
│delta  │div_3   │midwest  │IN   │flood    │ceded      │2016│q1     │106284│
└───────┴────────┴─────────┴─────┴─────────┴───────────┴────┴───────┴──────┘
</pre>

<p>The axes are shown in two rows: at the top are pages into the data,
and below are the rows and columns. Each axis may be subset, and the
axis tiles may be dragged and dropped to pivot the data. After any change,
the display data is recalculated in J and sent to the webview.<p>

<p>Page selections are subtotalled, except for <i>perspective</i> where totals allow
for gross=net+ceded.</p>


<p>The table display is an ordinary HTML table. The rendering will take a
few seconds if the entire dataset is displayed, i.e. with no pages or axis selections.</p>

<p>The charts are drawn using
<a href="http://www.chartjs.org//?external">Chart.js</a>.
On the right of each chart is a list of color/name legends:</p>

<ul>
<li>click any legend toggles its chart values on/off</li>
<li>ctrl-click any legend toggles all other chart values on/off</li>
<li>ctrl+shift+click anywhere in the chart restores all values</li>
</ul>
`

// ---------------------------------------------------------------------
function popup(txt) {
 var d = document.createElement("div");
 d.setAttribute("id", "popup");
 d.setAttribute("class", "modal");
 var c = document.createElement("div");
 c.setAttribute("id", "popup-content");
 c.setAttribute("class", "modal-content");
 var a = "<a href='#' class='close' onclick='popup_close()'>&times;</a>";
 c.innerHTML = a + txt;
 d.appendChild(c);
 document.body.appendChild(d);
 listen("popup_close", "click", popup_close);
}

// ---------------------------------------------------------------------
function popup_close() {
 var d = getid("popup");
 document.body.removeChild(d);
}
