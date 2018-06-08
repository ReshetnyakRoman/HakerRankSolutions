
function GrudyNumber(tree){
    //function will return GrudyNumber (nimber) for given tree
    return (tree == 0 || tree == 2) ? 0 : (tree-1)%2+1
}

function bobAndBen(forest) {
    let GrudyNumers = []
    
    //find GrudyNumber(nimbers) for each tree
    for(let tree of forest){
        GrudyNumers.push(GrudyNumber(tree[0]))
    }
    
    //return XOR (also known as nim-sum) of all Grundy numbers
    return GrudyNumers.reduce((a,b)=>a^b) != 0 ? 'BOB' : 'BEN'
}

function main() {
    const g = parseInt(readLine(), 10);

    for (let gItr = 0; gItr < g; gItr++) {
        const n = parseInt(readLine(), 10);
        let forest = Array(n);

        for (let i = 0; i < n; i++) {
            forest[i] = readLine().split(' ').map(trees => parseInt(trees, 10));
        }
        console.log(bobAndBen(forest))
    }
}

//Tree example for k=2:
//
//                   1
//                 /   \
//                2     3
//               / \    / \
//              4   5  6   7
//             / \ / \/ \ / \
//            8   9..............  