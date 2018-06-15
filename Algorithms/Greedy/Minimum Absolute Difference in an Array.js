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

// Complete the minimumAbsoluteDifference function below.
function minimumAbsoluteDifference(n, arr) {
    arr=arr.sort()
    let min=Math.abs(arr[0]-arr[1])
    for(let i=1;i<arr.length-1;i++){
        if(Math.abs(arr[i]-arr[i+1])<min){
            min=Math.abs(arr[i]-arr[i+1]);
        }
    }
    return min
}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const n = parseInt(readLine(), 10);

    const arr = readLine().split(' ').map(arrTemp => parseInt(arrTemp, 10));

    let result = minimumAbsoluteDifference(n, arr);

    ws.write(result + "\n");

    ws.end();
}
