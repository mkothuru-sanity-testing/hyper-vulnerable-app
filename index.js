console.log("Hello from hyper-vulnerable test app!");

// Example of using some installed packages to prevent npm prune from removing them
const _ = require('lodash');
const moment = require('moment');
const bluebird = require('bluebird');

console.log("Lodash version:", _.VERSION);
console.log("Current time (moment):", moment().format());
console.log("Bluebird is ready:", typeof bluebird.Promise === 'function');

// Minimal function
function add(a, b) {
  return a + b;
}

console.log("1 + 2 =", add(1, 2));