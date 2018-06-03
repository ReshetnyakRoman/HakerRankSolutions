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
    let arr=readLine().split(' ')
    let v=parseInt(arr[0])
    let e=parseInt(arr[1])
    
    let node={'weight':1,'root':-1}
    let trees=[]
    
    for(let i=0;i<v;i++){
        trees.push({'weight':1,'root':-1});
    }
    
    for(let i=0;i<e;i++){
        let input=readLine().split(' ');
        let vertex=parseInt(input[0]);
        let root=parseInt(input[1])
        trees[vertex-1].root=parseInt(root)-1;
    }
    
    for(let i=v-1;i>0;i--){
        if(trees[i].root>=0){
            trees[trees[i].root].weight+=trees[i].weight;
        }
    }
    let count=0;
    for(let i=0;i<v;i++){
        //console.log(trees[i])
        if(trees[i].root>=0 && trees[i].weight%2==0){
            count+=1
        }
    }
    console.log(count)
}
