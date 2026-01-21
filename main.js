function fibonacci(n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

function computeIntensive() {
  const start = Date.now();
  const result = fibonacci(40);
  const end = Date.now();
  console.log(`Fibonacci(40) = ${result}`);
  console.log(`Time taken: ${end - start}ms`);
}

computeIntensive();