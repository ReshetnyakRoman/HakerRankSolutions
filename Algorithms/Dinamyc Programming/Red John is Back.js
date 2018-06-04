// Factorial function
function Fact(num)
{
    var rval=1;
    for (var i = 2; i <= num; i++)
        rval = rval * i;
    return rval;
}

//Sieve of Eratosthenes algorithm
function numberOfPrimes(n){
    n=n+1
    var upperLimit = Math.sqrt(n), output = [], A=new Array(n).fill(true)

    for(let i=2;i<upperLimit;i++){
        if(A[i]){
            for(let j=i*i;j<n;j=j+i){
                A[j]=false
            }
        }
    }

    return A.filter(x=>x==true).length-2
    
}
//count number of combinations:
function RedJohn(n) {
    var variants=0;
    for(let i=0; i<=Math.floor(n/4);i++){
        let a = i;
        let b = n-i*4;
        variants+=Fact(a+b)/(Fact(a)*Fact(b))
    }
    
    return variants
}

function main() {
    const t = parseInt(readLine(), 10);

    for (let tItr = 0; tItr < t; tItr++) {
        const n = parseInt(readLine(), 10);
        let result = RedJohn(n);
        console.log(numberOfPrimes(result))
    }

}