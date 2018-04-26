// page 4

"use strict";

// ---------------------------------------------------------------------
function page4init() {
 window.onresize = null;
 overflow(true);

 document.body.innerHTML = `
 <p>By default, external links in webview are opened in the webview control itself. However, this
 also replaces the webview's Javascript, so J can no longer communicate with it.
 If necessary, some method would be needed to return to the original webview page.</p>

 <p>For a link to be opened in a separate browser, the url should end with either
 "?external" or "&external". This will leave the original webview page unchanged.</p>

 <p>In this demo, if a page is opened in the webview, the page buttons at top
 left no longer work. To restore the demo, click the Reload button at bottom
 left, which loads the demo again.</p>

 <p>Try:

 <ul>
 <li>this link will open in a separate browser: <a href="http://d3js.org?external">D3</a></li>
 <li>this link will open in the webview: <a href="http://d3js.org">D3</a></li>
 </ul>
`
}
