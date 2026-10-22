'use strict';
// FX-BEGIN JS-C01
// Clean control: no security-relevant behaviour.
function add(a, b) {
  return a + b;
}

function greet(name) {
  return `Hello, ${name}`;
}

module.exports = { add, greet };
// FX-END JS-C01
