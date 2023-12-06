const jmespath = require('jmespath');
const readline = require('readline');
const { stdin: input, stdout: output } = require('process');

const args = process.argv.slice(2);

if (args.length < 1) {
    console.error("Usage: node jmespath-cli.js '<jmespath-query>' [n invocations] ['json-string']");
    process.exit(1);
}

const query = args[0];
let n = 0;
let jsonInput = '';

if (args.length >= 3) {
    n = parseInt(args[1], 10);
    jsonInput = args[2];
    processQuery();
} else if (args.length === 2) {
    n = parseInt(args[1], 10);
    readInputAndProcess();
} else {
    readInputAndProcess();
}

function readInputAndProcess() {
    const rl = readline.createInterface({ input, output, terminal: false }); // set terminal to false
    let inputData = '';

    rl.on('line', (line) => {
        inputData += line + '\n'; // Append newline character
    });

    rl.on('close', () => {
        jsonInput = inputData.trim(); // Trim trailing newlines
        processQuery();
    });
}

function processQuery() {
    if (n > 0) {
        console.error(`Input JSON: ${jsonInput.substring(0, 1024)}`);
        console.error(`Query: ${query}`);
        console.error(`n: ${n}`);
    }

    try {
        const jsonData = JSON.parse(jsonInput);
        const startTime = process.hrtime.bigint();

        for (let i = 0; i < n; i++) {
            jmespath.search(jsonData, query);
        }

        const endTime = process.hrtime.bigint();
        const result = jmespath.search(jsonData, query);

        console.log(`Result: ${JSON.stringify(result)}`);

        if (n > 0) {
            const timeTaken = (endTime - startTime) / BigInt(1e6); // Convert nanoseconds to milliseconds
            console.log(`${(Number(timeTaken) / 1000).toFixed(4)}`);
        }
    } catch (e) {
        console.error("Error parsing JSON input:", e);
    }
}
