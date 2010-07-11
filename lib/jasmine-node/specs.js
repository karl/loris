require.paths.push(__dirname + "/lib");
require.paths.push("./");

var sys = require('sys');
var jasmine = require('jasmine');

for(var key in jasmine) {
  global[key] = jasmine[key];
}

var isVerbose = false;
var showColors = true;
var dir = __dirname;
process.argv.forEach(function(arg){
  switch(arg) {
  case '--color': showColors = true; break;
  case '--noColor': showColors = false; break;
  case '--verbose': isVerbose = true; break;
  default: dir = arg; break;
  }
});


jasmine.executeSpecsInFolder(dir + '/spec', function(runner, log) {
	// Cannot call process.exit, standard out and standard error do not get flushed
	// process.exit(runner.results().failedCount);
}, isVerbose, showColors);
