'use strict';

const fs = require('fs');

process.stdin.resume();
process.stdin.setEncoding('utf-8');

let inputString = '';
let currentLine = 0;

process.stdin.on('data', inputStdin => {
    inputString += inputStdin;
});

process.stdin.on('end', _ => {
    inputString = inputString.replace(/\s*$/, '')
        .split('\n')
        .map(str => str.replace(/\s*$/, ''));

    main();
});

function readLine() {
    return inputString[currentLine++];
}

// Complete the prims function below.
function prims(n, edges, start) {


}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const nm = readLine().split(' ');

    const n = parseInt(nm[0], 10);

    const m = parseInt(nm[1], 10);

    let edges = Array(m);

    for (let i = 0; i < m; i++) {
        edges[i] = readLine().split(' ').map(edgesTemp => parseInt(edgesTemp, 10));
    }

    const start = parseInt(readLine(), 10);

    let result = prims(n, edges, start);

    ws.write(result + "\n");

    ws.end();
}
