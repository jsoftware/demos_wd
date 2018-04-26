// page 1

"use strict";

// ---------------------------------------------------------------------
function page1init() {
 window.onresize = null;
 overflow(true);

 document.body.innerHTML = `
 <p>The Window Driver <tt>wd</tt> is used to communicate with the webview control, and
has the form:</p>

 <pre> wd 'cmd w xxx'</pre>

 where <tt>w</tt> is the webview child id, and <tt>xxx</tt> is the command string sent to the control.

 <p>Exactly how the command strings are interpreted has to be programmed and will depend on the application.
 The scheme used in this demo is:</p>

 <pre>
 wd 'cmd w set name value'        set value to name
 wd 'cmd w get name'              get value of name
 wd 'cmd w call fname [parms]'    call Javascript function with optional parameters
 wd 'cmd w callr fname [parms]'   as call, but also returning the result
 wd 'cmd w eval string'           evaluate a Javascript string, returning the result</pre>

 <p>The webview page will need Javascript functions to handle the J calls. In this case,
 the functions are named with a "j" prefix, e.g. <tt>jset</tt>, <tt>jget</tt>.</p>

 <p>Any results returned from the webview are given in a wd event, so J handlers are needed for these events.
 This demo uses only a single <i>post</i> event, with corresponding <i>name</i> and <i>value</i>.
 The names include:

 <ul>
 <li>return  - result from a J command (i.e. from <i>get</i>, <i>callr</i>, <i>eval</i>)</li>
 <li>error   - an error message</li>
 <li>init    - sent by the webpage after the comms link is established
 <li>{other} - data requests
 </ul>

 <p>The value will be in Javascript string representation. This can be decoded by the convert/pjson addon.</p>

 <p>Try the examples below. You can cut and paste from this display, or open
 the following script with the examples and step through the lines:

 <pre> open '~addons/demos/wd/webview/comms.ijs'</pre>

<h3>Form controls</h3>

 <div style='display:flex;align-items:flex-start'><table>
 <tr><td>first:</td><td><input type="text" id="first" value="Anne" /></td></tr>
 <tr><td>last:</td><td><input type="text" id="last" value="Blake" /></td></tr>
 </table>
 <input style='margin-left:10px' type="button" value="send" onclick="return sendname()" /></div>

<p>The <i>set</i> command has been defined to set the corresponding input fields. Try:</p>
 <pre>
 wd 'cmd w set first Andy'       NB. set first name
 wd 'cmd w set last Burton'      NB. set last name</pre>
<p>Press the send button to send the full name back to J (in a post event).</p>

<h3>get Javascript global</h3>

<p>The <i>get</i> command has been defined to read Javascript globals. Try:</p>

 <pre>
 wd 'cmd w get Random'           NB. get a random number generated on page load
 wd 'cmd w call makeRandom'      NB. generate a new random number
 wd 'cmd w get Random'           NB. get the new random number</pre>

<h3>Function calls</h3>

<p>The <i>call</i> (no result) and <i>callr</i> (with result) commands call Javascript functions,
optionally with parameters.

The <i>eval</i> command evaluates a string as a Javascript expression and returns a result.</p>

 <pre>
 wd 'cmd w eval 2+3'             NB. evaluate a Javascript expression

 wd 'cmd w callr randomint 100'  NB. generates a random integer less than 100
 wd 'cmd w eval randomint(100)'  NB. evaluate the corresponding Javascript expression

 wd 'cmd w callr vplus "[2,3,5,7]" 10'  NB. call function to add array and single number
 wd 'cmd w eval *[2,3,5,7].reduce((a,b) => a+b,0)'  NB. expression to sum array</pre>`
}
