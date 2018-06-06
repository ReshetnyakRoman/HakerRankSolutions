//Sieve of Eratosthenes algorithm
function numberOfPrimes(n){
    n=n+1
    var upperLimit = Math.sqrt(n), A=new Array(n).fill(true)

    for(let i=2;i<upperLimit;i++){
        if(A[i]){
            for(let j=i*i;j<n;j=j+i){
                A[j]=false
            }
        }
    }

    return A.filter(x=>x==true).length-2;
}
    
function sillyGame(n) {
    return n < 2 ?  'Bob' :  numberOfPrimes(n)%2 == 0 ? 'Bob' : 'Alice'
}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const g = parseInt(readLine(), 10);

    for (let gItr = 0; gItr < g; gItr++) {

        const n = parseInt(readLine(), 10);
        ws.write(sillyGame(n) + "\n");

    }

    ws.end();
}