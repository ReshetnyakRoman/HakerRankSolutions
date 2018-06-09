function gamingArray(arr) {
    let n = arr.length, counter = 1, max = arr[0]
    
    for(let i=0; i<n; i++){
        if(arr[i] > max){
            max = arr[i];
            counter += 1;
        }
    }

    return counter%2 != 0 ? 'BOB' : 'ANDY';
}

function main() {
    const g = parseInt(readLine(), 10);

    for (let gItr = 0; gItr < g; gItr++) {
        const arrCount = parseInt(readLine(), 10);
        const arr = readLine().split(' ').map(arrTemp => parseInt(arrTemp, 10));
        
        console.log(gamingArray(arr));
    }
}