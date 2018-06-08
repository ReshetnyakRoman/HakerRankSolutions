function isIncreasing(seq, mask){
    let lastElement=Number.MAX_SAFE_INTEGER;
    
    for(let i = seq.length-1;i >= 0;i--){
        
        //check that i-th element of set is allowed by mask
        if( mask & (1 << i) ){
            if(seq[i] >= lastElement){return false;}
            lastElement = seq[i];
        }
    }
    return true;
}

function winner(seq,masks,mask,isFirst){
    //if winning-status not assigned(= -1) for given mask and sequence then calculate it:    
    if(masks[mask] == -1){
        masks[mask] = isIncreasing(seq, mask); 
    }else if(masks[mask] == 0){
        return isFirst;
    }
    
    //now we check status after we calculate and assign it
    //if status become 1 this mean that sequence already in increasing order and player don't allowed make move and he loose
    if(masks[mask] == 1){
        return !isFirst;
    }
    
    
    //now we need to calculate position status for all sub-sequenses for example:
    // for {1,3,2} we should check {1,3}, {1,2} and {3,2}
    // respective bit masks: for 7(111) is 6(110),  5(101), 3{3,2}
    
    let maskCopy = mask;
    while(maskCopy){
        //calculating first bit not equal to 0, in binary representation of mask
        // for example mask=6 same as mask=110, in this case last bit second from right = 010
        let lastBit = maskCopy & (~(maskCopy-1));
        //delete last bit from mask copy to bring it finally to zero and finish the loop
        maskCopy ^= lastBit
        let newMask=mask ^ lastBit;
        
        if(winner(seq,masks,newMask,!isFirst) == isFirst){
            masks[newMask] = true;
            //this mean that there is element that player can remove to make sequence increasing
            return isFirst;
        }
    }
    masks[mask]=false;
    return !isFirst;
}


function permutationGame(seq) {
    //we create new array filled with -1 wich will be keep masks for given sequense
    //we'll start check our masks from the bigest one, which represent full sequence
    let total = Math.pow(2,seq.length)
    let masks = new Array(total).fill(-1)
    let startMask=total-1
    
    if(winner(seq,masks,startMask,true)){
        return 'Alice';
    }else{
        return 'Bob'
    }
}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const t = parseInt(readLine(), 10);

    for (let tItr = 0; tItr < t; tItr++) {
        const arrCount = parseInt(readLine(), 10);

        const arr = readLine().split(' ').map(arrTemp => parseInt(arrTemp, 10));

        let result = permutationGame(arr);

        ws.write(result + "\n");
    }

    ws.end();
}