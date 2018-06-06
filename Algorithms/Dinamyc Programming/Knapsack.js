function bestFit(target,arr){
    if(target == 0){
        return 0;
    }
    
    let tmp1=target, tmp2=target;
    for(let i=0; i<arr.length; i++){
        if(tmp1-arr[i]==0){return 0}
        else{
            if(target-arr[i]>0){
                tmp2 = bestFit(target-arr[i],arr);
                if(tmp2 < tmp1){
                    tmp1 = tmp2
                }
            }
        }
    }
    return tmp1
}

function unboundedKnapsack(target, arr) {
    for(let i=0;i<arr.length;i++){
        if(target%arr[i] == 0){
           return target; 
        }
    }
    return target-bestFit(target,arr) 
}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const t = parseInt(readLine(), 10);
    for(let i=0;i<t;i++){
        const [n,sum] = readLine().split(' ').map(x => parseInt(x));
        const arr = readLine().split(' ').map(arrTemp => parseInt(arrTemp, 10));
                
        let result = unboundedKnapsack(sum, arr);
        ws.write(result + "\n");
    }

    ws.end();
}