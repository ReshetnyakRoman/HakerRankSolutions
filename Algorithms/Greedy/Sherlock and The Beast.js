'use strict';

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



function main() {
    const t = parseInt(readLine(), 10);

    for (let tItr = 0; tItr < t; tItr++) {
        const l = parseInt(readLine(), 10);
        let z=l;
        while(z%3!=0){
            z-=5
            if(z<0){
                break;
            }
        }
        z>=0 ? console.log('5'.repeat(z)+'3'.repeat(l-z)) : console.log(-1)
    }
 
}
