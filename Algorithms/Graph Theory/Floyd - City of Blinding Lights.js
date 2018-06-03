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

function floyd(distanceMatrix){
    let matrix = distanceMatrix.slice();
    let n = matrix.length;
    
    //Floyd–Warshall algorithm:
    for(let k=0;k<n;k++){
        for(let i=0;i<n;i++){
            let dist_ik = matrix[i][k];
            if(dist_ik == NaN){
                continue;
            }else{
                for(let j=0;j<n;j++){
                    let dist_kj = matrix[k][j];
                    if(dist_kj == NaN){
                        continue;
                    }else{
                        let dist_ij = matrix[i][j];
                        if(dist_ij.toString() == 'NaN' || dist_ij > dist_ik+dist_kj){
                            matrix[i][j] = dist_ik+dist_kj;
                        }
                    }
                }
            }
        }
    }
    return matrix
}

function main() {
    let [n,m] = readLine().split(' ').map(a=>parseInt(a))
    
    //Createing distance matrix
    let distanceMatrix = []
    for(let i=0;i<n;i++){
        distanceMatrix.push(new Array(n).fill(NaN))
        distanceMatrix[i][i] = 0
    }
    
    for(let i=0;i<m;i++){
        let [x,y,r] = readLine().split(' ').map(a=>parseInt(a))
        distanceMatrix[x-1][y-1] = r
    }
    
    //upgrade our matrix of distances by Floyd–Warshall function
    distanceMatrix = floyd(distanceMatrix)
    
    let testCases=parseInt(readLine())
    
    for(let i=0;i<testCases;i++){
        let [x,y] = readLine().split(' ').map(a=>parseInt(a));
        if(distanceMatrix[x-1][y-1].toString() == 'NaN'){
            console.log(-1);
        }else{
            console.log(distanceMatrix[x-1][y-1]);
        }
    }
}
