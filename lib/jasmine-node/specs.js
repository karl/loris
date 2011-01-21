require.paths.push(__dirname + "/lib");
require.paths.push("./");

var sys = require('sys');
var fs = require('fs');
var jasmine = require('jasmine');

for(var key in jasmine) {
  global[key] = jasmine[key];
}

var isVerbose = false;
var showColors = true;
var config = null;
var sourceDirectory;
var prev = null;
process.argv.forEach(function(arg){
  switch(arg) {
    case '--color': showColors = true; break;
    case '--noColor': showColors = false; break;
    case '--verbose': isVerbose = true; break;
    default:
      if (prev === '--source-directory') {
        sourceDirectory = arg;
      } else {
        config_path = arg;
      }
      break;
  }
  prev = arg;
});

var dir = config_path.substring(0, config_path.lastIndexOf('/'));

// read in config
var config = fs.readFileSync(config_path);
config = JSON.parse(config + "");

// get the spec directory (or use the default)


// add source dir to requires path (or given source dir argument)
require.paths.unshift(sourceDirectory || config.sourceDirectory);

// require all the requires files
for (var i = 0, len = config.requires.length; i < len; ++i){
  var exported = require(config.requires[i]);

  for (var key in exported) {
      var value = exported[key];
      eval(key + ' = value');
  }

}


jasmine.executeSpecsInFolder.call(this, config.specDirectory || dir + '/spec', function(runner, log) {

  if (typeof _$jscoverage === 'object') {
    reportCoverage(_$jscoverage);
  }

    // Cannot call process.exit, standard out and standard error do not get flushed
    // process.exit(runner.results().failedCount);
}, isVerbose, showColors);

function reportCoverage(cov) {
    populateCoverage(cov);
    // Stats
    sys.print('\n   [bold]{Test Coverage}\n');
    var sep = '   +------------------------------------------+----------+------+------+--------+',
        lastSep = '                                              +----------+------+------+--------+';
    sys.puts(sep);
    sys.puts('   | filename                                 | coverage | LOC  | SLOC | missed |');
    sys.puts(sep);
    for (var name in cov) {
        var file = cov[name];
        if (file instanceof Array) {
            sys.print('   | ' + rpad(name, 40));
            sys.print(' | ' + lpad(file.coverage.toFixed(2), 8));
            sys.print(' | ' + lpad(file.LOC, 4));
            sys.print(' | ' + lpad(file.SLOC, 4));
            sys.print(' | ' + lpad(file.totalMisses, 6));
            sys.print(' |\n');
        }
    }
    sys.puts(sep);
    sys.print('     ' + rpad('', 40));
    sys.print(' | ' + lpad(cov.coverage.toFixed(2), 8));
    sys.print(' | ' + lpad(cov.LOC, 4));
    sys.print(' | ' + lpad(cov.SLOC, 4));
    sys.print(' | ' + lpad(cov.totalMisses, 6));
    sys.print(' |\n');
    sys.puts(lastSep);
    // // Source
    // for (var name in cov) {
    //     if (name.match(/\.js$/)) {
    //         var file = cov[name];
    //         sys.print('\n   [bold]{' + name + '}:');
    //         sys.print(file.source);
    //         sys.print('\n');
    //     }
    // }
}

/**
 * Populate code coverage data.
 *
 * @param  {Object} cov
 * @api private
 */

function populateCoverage(cov) {
    cov.LOC =
    cov.SLOC =
    cov.totalFiles =
    cov.totalHits =
    cov.totalMisses =
    cov.coverage = 0;
    for (var name in cov) {
        var file = cov[name];
        if (file instanceof Array) {
            // Stats
            ++cov.totalFiles;
            cov.totalHits += file.totalHits = coverage(file, true);
            cov.totalMisses += file.totalMisses = coverage(file, false);
            file.totalLines = file.totalHits + file.totalMisses;
            cov.SLOC += file.SLOC = file.totalLines;
            cov.LOC += file.LOC = file.source.length;
            file.coverage = (file.totalHits / file.totalLines) * 100;
            // Source
            var width = file.source.length.toString().length;
            file.source = file.source.map(function(line, i){
                ++i;
                var hits = file[i] === 0 ? 0 : (file[i] || ' ');
                return '\n     ' + lpad(i, width) + ' | ' + hits + ' | ' + line;
            }).join('');
        }
    }
    cov.coverage = (cov.totalHits / cov.SLOC) * 100;
}

/**
 * Total coverage for the given file data.
 *
 * @param  {Array} data
 * @return {Type}
 * @api private
 */

function coverage(data, val) {
    var n = 0;
    for (var i = 0, len = data.length; i < len; ++i) {
        if (data[i] !== undefined && data[i] == val) ++n;
    }
    return n;
}

/**
 * Pad the given string to the maximum width provided.
 *
 * @param  {String} str
 * @param  {Number} width
 * @return {String}
 * @api private
 */

function lpad(str, width) {
    str = String(str);
    var n = width - str.length;
    if (n < 1) return str;
    while (n--) str = ' ' + str;
    return str;
}

/**
 * Pad the given string to the maximum width provided.
 *
 * @param  {String} str
 * @param  {Number} width
 * @return {String}
 * @api private
 */

function rpad(str, width) {
    str = String(str);
    var n = width - str.length;
    if (n < 1) return str;
    while (n--) str = str + ' ';
    return str;
}
