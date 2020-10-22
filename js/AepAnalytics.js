var exec = require('cordova/exec');

var PLUGIN_NAME = "AepAnalytics";

var AepAnalytics = function() {};

AepAnalytics.testStrReturn = function (arg0, success, error) {
  exec(success, error, PLUGIN_NAME, 'testStrReturn', [arg0]);
};

module.exports = AepAnalytics;