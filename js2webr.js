const jsObject = { a: 10, b: 20 };

// JS object reformat into an env
const options = {
  env: {
    a: jsObject.a,
    b: jsObject.b
  }
};


const result = await webR.evalR(`
  a + b
`, options);


const sum = await result.toJs();
console.log('Sum of a and b:', sum);