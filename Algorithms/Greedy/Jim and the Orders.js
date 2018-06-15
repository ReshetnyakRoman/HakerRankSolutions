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

// Complete the jimOrders function below.
function jimOrders(orders) {
    let schedular=[]
    for(let i=0;i<orders.length;i++){
        schedular.push([i,orders[i]]);
    }
    schedular.sort((a,b)=>a[1]-b[1]);
    let answer=[]
    for(let item of schedular){
        answer.push(item[0]+1)
    }
    return answer
}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const n = parseInt(readLine(), 10);

    let orders = Array(n);

    for (let i = 0; i < n; i++) {
        let temp=readLine().split(' ').map(ordersTemp => parseInt(ordersTemp, 10))
        orders[i] = temp[0]+temp[1];
    }

    let result = jimOrders(orders);

    ws.write(result.join(" ") + "\n");

    ws.end();
}
