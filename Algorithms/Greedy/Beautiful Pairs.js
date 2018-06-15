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

// Complete the beautifulPairs function below.
function beautifulPairs(A, B) {
    let counter=0

    for(let element of A){
        if (B.indexOf(element)!=-1){
            B.splice(B.indexOf(element),1)
            counter+=1
        }
    }
    
    if (B.length>0){
        counter+=1;
    }else if (B.length==0){
        counter-=1;
    }
    return counter

}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const n = parseInt(readLine(), 10);

    const A = readLine().split(' ').map(ATemp => parseInt(ATemp, 10));

    const B = readLine().split(' ').map(BTemp => parseInt(BTemp, 10));

    let result = beautifulPairs(A, B);

    ws.write(result + "\n");

    ws.end();
}
