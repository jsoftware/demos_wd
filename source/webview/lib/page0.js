// page 0

"use strict";

// ---------------------------------------------------------------------
function page0init() {
 window.onresize = null;
 overflow(true);

 document.body.innerHTML = `
 <p>This demo illustrates the J webview control included in the full Qt IDE V1.6 and later.</p>

 <p>The control is used to display web pages, which may be local or read from the internet.
 It allows building applications that have both standard Qt Desktop controls and web pages,
 as in this demo. HTML/Javascript are used to program the pages.</p>

 <p>The webview control includes the
 <a href="https://en.wikipedia.org/wiki/Blink_(web_engine)?external">Blink</a>
 web_engine, which is used in Chromium and the Google Chrome browser.</p>

 <p>The main Qt technologies used are <a href="http://doc.qt.io/qt-5/qwebengineview.html?external">QWebEngineView</a>
 for the browser page, and <a href="http://doc.qt.io/qt-5/qwebchannel.html?external">QWebChannel</a> for the interface.</p>

 <p>Note that if you click the above links, they are opened in an external browser. They could be opened in the webview control,
 but that would also replace the Javascript attached to the control, see this demo's Web page.</p>

 <p>In this demo, any webview events will be displayed in the terminal.</p>`
}
