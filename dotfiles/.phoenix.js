// Move windows between monitors, taken from jakemcc's config

function moveToScreen(win, screen) {
  if (!screen) {
    return;
  }

  var frame = win.frame();
  var oldScreenRect = win.screen().frameWithoutDockOrMenu();
  var newScreenRect = screen.frameWithoutDockOrMenu();

  var xRatio = newScreenRect.width / oldScreenRect.width;
  var yRatio = newScreenRect.height / oldScreenRect.height;

  win.setFrame({
    x: (Math.round(frame.x - oldScreenRect.x) * xRatio) + newScreenRect.x,
    y: (Math.round(frame.y - oldScreenRect.y) * yRatio) + newScreenRect.y,
    width: Math.round(frame.width * xRatio),
    height: Math.round(frame.height * yRatio)
  });
}

function circularLookup(array, index) {
  if (index < 0)
    return array[array.length + (index % array.length)];
  return array[index % array.length];
}

function rotateMonitors(offset) {
  var win = Window.focusedWindow();
  var currentScreen = win.screen();
  var screens = [currentScreen];
  for (var x = currentScreen.previousScreen(); x != win.screen(); x = x.previousScreen()) {
    screens.push(x);
  }

  screens = _(screens).sortBy(function(s) { return s.frameWithoutDockOrMenu().x; });
  var currentIndex = _(screens).indexOf(currentScreen);
  moveToScreen(win, circularLookup(screens, currentIndex + offset));
}

function leftOneMonitor() {
  rotateMonitors(-1);
}

function rightOneMonitor() {
  rotateMonitors(1);
}


// My additions to Window

Window.prototype.push = function(dir) {
  var topLeft = this.topLeft();
  var screenFrame = this.screen().frameWithoutDockOrMenu();

  if (dir == 'left') {
    topLeft.x = screenFrame.x;
  } else if (dir == 'right') {
    topLeft.x = (screenFrame.x + screenFrame.width) - this.size().width;
  } else if (dir == 'top') {
    topLeft.y = screenFrame.y;
  } else if (dir == 'bottom') {
    topLeft.y = (screenFrame.y + screenFrame.height) - this.size().height;
  } else {
    api.alert("Unknown direction " + dir);
  }
  this.setTopLeft(topLeft);

  return this;
}

Window.prototype.toGrid = function(x, y, width, height) {
  var screen = this.screen().frameWithoutDockOrMenu();
  var padding = 0;

  this.setFrame({
    x:      Math.round(x * screen.width) + padding + screen.x,
    y:      Math.round(y * screen.height) + padding + screen.y,
    width:  Math.round(width * screen.width) - (2 * padding),
    height: Math.round(height * screen.height) - (2 * padding)
  });

  return this;
}

Window.prototype.shift = function(pctX, pctY) {
  var topLeft = this.topLeft();
  var screen = this.screen().frameWithoutDockOrMenu();

  topLeft.x += Math.round(pctX * screen.width);
  topLeft.y += Math.round(pctY * screen.height);
  this.setTopLeft(topLeft);
}

Window.prototype.resize = function(pctX, pctY, anchorX, anchorY) {
  var frame = this.frame();
  var screen = this.screen().frameWithoutDockOrMenu();

  var adjX = Math.round(pctX * screen.width);
  var adjY = Math.round(pctY * screen.height);
  frame.width += adjX;
  frame.height += adjY;

  if (anchorX == 'right') {
    frame.x -= adjX;
  }
  if (anchorY == 'bottom') {
    frame.y -= adjY;
  }

  this.setFrame(frame);
  return this;
}

function rectEq(r1, r2) {
  if (!r1 || !r2) return false;
  return r1.x == r2.x && r1.y == r2.y && r1.width == r2.width && r1.height == r2.height;
}

var fullscreenInfo = [];
Window.prototype.toggleFullscreen = function() {
  var this_ = this;
  var screen = this.screen().frameWithoutDockOrMenu();

  // Extract and remove saved info we have on this window
  var info = _(fullscreenInfo).find(function(i){return this_.equals(i.win)});
  fullscreenInfo = _(fullscreenInfo).without(info);
  if (!info) info = {win: this};

  if (!rectEq(this.frame(), screen) && !rectEq(this.frame(), info.fullFrame)) {
    info.restoreFrame = this.frame();
    this.setFrame(screen);
    info.fullFrame = this.frame();  // some windows don't expand the full width

    // Remember this window
    fullscreenInfo.push(info);
  } else {
    var rect = info.restoreFrame;
    if (rect) this.setFrame(rect);
    // Forget the window
  }
}

Window.prototype.forceFocusWindow = function() {
  // If the window is on another screen and another window from the same app is on this screen,
  // OSX will focus the window on this screen. Once focused, another invocation will go to the
  // correct window, however. This forces the correct behavior.
  // Unfortunately it's also a giant hack. At least give us setTimeout!
  var success = false;
  for (var i = 0; i < 250; i++) {
    if (this.equals(Window.focusedWindow())) { success = true; break; }
    this.focusWindow();
  }
  if (!success) api.alert("Couldn't find target", 0.5);
  return success;
}

Window.prototype.equals = function(other) {
  if (!other) return false;
  return this.title() == other.title() && _.isEqual(this.frame(), other.frame());
}


// Marks

markBindings = [];
markBindingsEnabled = false;
function createMarkBindings() {
  var NAMES = "abcdefghijklmnopqrstuvwxyz'1234567890-=,./[]";

  markBindings = _.flatten(_.map(NAMES, function(name) {
    var binding = api.bind(name, [], function() { markCallback(name); });
    // Make it so you can hold alt down when describing the mark; only works if the binding isn't
    // already taken.
    var bindingAlt = api.bind(name, ['alt'], function() { markCallback(name); });

    // Handle shift, too.
    var upperName = name.toUpperCase();
    if (name != upperName) {
      var bindingShift = api.bind(name, ['shift'], function() { markCallback(upperName); });
      var bindingShiftAlt = api.bind(name, ['shift', 'alt'], function() { markCallback(upperName); });
      return [binding, bindingAlt, bindingShift, bindingShiftAlt];
    } else {
      return [binding, bindingAlt];
    }
  }));
  markBindings.push(api.bind('escape', [], cancelMarkOp));

  markBindingsEnabled = true;
  disableMarkBindings();
}


function enableMarkBindings() {
  if (markBindingsEnabled) return;  // work around bug where enabling twice enables permanently.
  _.each(markBindings, function(binding) { binding.enable(); });
  markBindingsEnabled = true;
}
function disableMarkBindings() {
  _.each(markBindings, function(binding) { binding.disable(); });
  markBindingsEnabled = false;
}

markOp = null;
marks = {};
lastMarkedWindowFocused = null;
previousWindow = null;

function beginMarkOp(opName, keyName) {
  // Handle a doubled command by assuming that keyName is actually the name of the mark for this op.
  if (markOp == opName) {
    markCallback(keyName);
    return;
  }
  markOp = opName;
  enableMarkBindings();
}
function cancelMarkOp() {
  markOp = null;
  disableMarkBindings();
}
function markCallback(name) {
  disableMarkBindings();

  if (markOp == 'name') {
    nameMark(name);
  } else if (markOp == 'focus') {
    focusMark(name);
  }

  markOp = null;
}

function nameMark(name) {
  var win = Window.focusedWindow();
  marks[name] = win;
  api.alert(win.app().title() + " / " + win.title() + " → " + name, 0.8);
}
function focusMark(name) {
  api.alert(name);
  if (name == "'") {
    focus(lastWindow());
  } else {
    var win = marks[name];
    if (win) focus(win);
  }
}
function focus(win) {
  var cur = Window.focusedWindow();

  win.forceFocusWindow();

  previousWindow = cur;
  lastMarkedWindowFocused = win;
}
function lastWindow() {
  // If still on same screen as the last time we used marks to focus a window, use our own history
  // to determine which window to focus. This works around the problem of "illegitimate focusings"
  // that happen during forceFocusWindow being focused as the last window.
  var win = Window.focusedWindow();
  var shouldUseHistory = function() {
    if (!win || !lastMarkedWindowFocused) return false;

    if (win.equals(lastMarkedWindowFocused)) return true;
    return _(win.otherWindowsOnSameScreen()).any(function(w){ return w.equals(lastMarkedWindowFocused); })
  }

  if (shouldUseHistory()) {
    return previousWindow;
  } else {
    // Use system history.
    return Window.visibleWindowsMostRecentFirst()[1];
  }
}

// Returns the window from the list of windows with the title title, if that title is unique.
// Otherwise, returns undefined.
// function findByUniqueTitle(windows, title) {
//   var results = _.find(windows, function(w){ return w.title() == title; });
//   if (results.length != 1) return undefined;
//   return results[0];
// }
// Window.findByUniqueTitle = function(title) {
//   return findByUniqueTitle(Window.allWindows(), title);
// }

// function nameMark(name) {
//   var win = Window.focusedWindow();
//   marks[name] = {
//     app:     win.app().title(),
//     title:   win.title(),
//     topLeft: win.topLeft(),
//     size:    win.size()
//   };
//   api.alert(name + ": " + win.app().title() + " / " + win.title());
// }
// function focusMark(name) {
//   mark = marks[name];
//   if (!mark) return;

//   var app = _.find(App.runningApps(), function(app){ return app.title() == mark.app; });
//   if (!app) return;
//   var windows = app.allWindows();

//   // First try to match by title, then by location, then by window size.
//   var          result = findByUniqueTitle(windows, mark.title);
//   if (!result) result = _.find(windows, function(w){ return _.isEqual(w.topLeft(), mark.topLeft); });
//   if (!result) result = _.find(windows, function(w){ return _.isEqual(w.size(), mark.size); });

//   if (result) {
//     // If the window is on another screen and another window from the same app is on this screen,
//     // OSX will focus the window on this screen. Once focused, another invocation will go to the
//     // correct window, however. This forces the correct behavior.
//     while (!windowEq(Window.focusedWindow(), result)) result.focusWindow();
//   }
// }


// Scratchpad
var scratchpad = [null];
var scratchpadIdx = 0;
var beforeScratchpad = null;

function moveToScratchpad() {
  var win = Window.focusedWindow();

  var removed = _(scratchpad).reject(function(w){ return win.equals(w); });
  if (removed.length < scratchpad.length) {
    // win was already in scratchpad, now removing
    scratchpad = removed;
  } else {
    scratchpad.push(win);
    win.minimize();
  }
}
function cycleScratchpad() {
  if (scratchpad[scratchpadIdx]) {
    scratchpad[scratchpadIdx].minimize();
  } else {
    beforeScratchpad = Window.focusedWindow();
  }

  scratchpadIdx++;
  if (scratchpadIdx >= scratchpad.length) scratchpadIdx = 0;

  if (scratchpad[scratchpadIdx]) {
    scratchpad[scratchpadIdx].unMinimize();
    var success = scratchpad[scratchpadIdx].forceFocusWindow();
    if (!success) {
      // Window may not exist anymore, remove it from the list.
      scratchpad.splice(scratchpadIdx, 1);
    }
  } else {
    // if (beforeScratchpad) beforeScratchpad.forceFocusWindow();
  }
}


// Bindings

function win() { return Window.focusedWindow(); }

var big = 0.10;
var sml = 0.05;

// Focus

// api.bind('h', ['alt'], function(){ win().focusWindowLeft(); });
// api.bind('l', ['alt'], function(){ win().focusWindowRight(); });
// api.bind('k', ['alt'], function(){ win().focusWindowUp(); });
// api.bind('j', ['alt'], function(){ win().focusWindowDown(); });

// Movement

// api.bind('h', ['alt', 'shift'], function(){ win().shift(-sml, 0); })
// api.bind('l', ['alt', 'shift'], function(){ win().shift(+sml, 0); })
// api.bind('k', ['alt', 'shift'], function(){ win().shift(0, -sml); })
// api.bind('j', ['alt', 'shift'], function(){ win().shift(0, +sml); })

api.bind('h', ['alt', 'shift', 'cmd'], function(){ win().push('left') });
api.bind('l', ['alt', 'shift', 'cmd'], function(){ win().push('right') });
api.bind('k', ['alt', 'shift', 'cmd'], function(){ win().push('top') });
api.bind('j', ['alt', 'shift', 'cmd'], function(){ win().push('bottom') });

api.bind('h', ['alt', 'shift', 'ctrl'], function(){ win().toGrid(0.0, 0.0, 0.5, 1.0) });
api.bind('l', ['alt', 'shift', 'ctrl'], function(){ win().toGrid(0.5, 0.0, 0.5, 1.0) });
api.bind('y', ['alt', 'shift', 'ctrl'], function(){ win().toGrid(0.0, 0.0, 0.5, 0.5) });
api.bind('p', ['alt', 'shift', 'ctrl'], function(){ win().toGrid(0.5, 0.0, 0.5, 0.5) });
api.bind('.', ['alt', 'shift', 'ctrl'], function(){ win().toGrid(0.5, 0.5, 0.5, 0.5) });
api.bind('b', ['alt', 'shift', 'ctrl'], function(){ win().toGrid(0.0, 0.5, 0.5, 0.5) });

api.bind('h', ['alt', 'shift', 'cmd', 'ctrl'], leftOneMonitor);
api.bind('l', ['alt', 'shift', 'cmd', 'ctrl'], rightOneMonitor);

// Resizing

// top/left edges
api.bind('left',  ['alt', 'ctrl'], function(){ win().resize(+big, 0.0, 'right', 'bottom') });
api.bind('right', ['alt', 'ctrl'], function(){ win().resize(-big, 0.0, 'right', 'bottom') });
api.bind('up',    ['alt', 'ctrl'], function(){ win().resize(0.0, +big, 'right', 'bottom') });
api.bind('down',  ['alt', 'ctrl'], function(){ win().resize(0.0, -big, 'right', 'bottom') });
api.bind('left',  ['alt', 'ctrl', 'shift'], function(){ win().resize(+sml, 0.0, 'right', 'bottom') });
api.bind('right', ['alt', 'ctrl', 'shift'], function(){ win().resize(-sml, 0.0, 'right', 'bottom') });
api.bind('up',    ['alt', 'ctrl', 'shift'], function(){ win().resize(0.0, +sml, 'right', 'bottom') });
api.bind('down',  ['alt', 'ctrl', 'shift'], function(){ win().resize(0.0, -sml, 'right', 'bottom') });

// bottom/right edges
api.bind('left',  ['alt', 'cmd'], function(){ win().resize(-big, 0.0, 'left', 'top') });
api.bind('right', ['alt', 'cmd'], function(){ win().resize(+big, 0.0, 'left', 'top') });
api.bind('up',    ['alt', 'cmd'], function(){ win().resize(0.0, -big, 'left', 'top') });
api.bind('down',  ['alt', 'cmd'], function(){ win().resize(0.0, +big, 'left', 'top') });
api.bind('left',  ['alt', 'cmd', 'shift'], function(){ win().resize(-sml, 0.0, 'left', 'top') });
api.bind('right', ['alt', 'cmd', 'shift'], function(){ win().resize(+sml, 0.0, 'left', 'top') });
api.bind('up',    ['alt', 'cmd', 'shift'], function(){ win().resize(0.0, -sml, 'left', 'top') });
api.bind('down',  ['alt', 'cmd', 'shift'], function(){ win().resize(0.0, +sml, 'left', 'top') });

// Misc

// api.bind('f', ['alt'], function(){ win().toggleFullscreen() });

api.bind('enter', ['alt'], function(){ api.launch('iTerm') });

// Marks
api.bind('m', ['alt'], function(){ beginMarkOp('name', 'm') });
api.bind("'", ['alt'], function(){ beginMarkOp('focus', "'") });
api.bind('m', ['cmd'], function(){ beginMarkOp('name', 'm') });
api.bind("'", ['cmd'], function(){ beginMarkOp('focus', "'") });

// Scratchpad
api.bind('s', ['alt', 'cmd'], moveToScratchpad);
api.bind('s', ['alt', 'ctrl'], cycleScratchpad);

createMarkBindings();

// TODO
// scratchpad
// 'jigsaw' move
// remember mouse position
