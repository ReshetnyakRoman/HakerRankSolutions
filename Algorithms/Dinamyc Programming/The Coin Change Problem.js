function getWays(money, coins, index=0, memo={}) {
    
    //border cases
    if(money == 0){
        return 1
    }
    if(money < 0){
        return 0
    }
    if(index > coins.length){
        return 0
    }
    
    //initialization
    var moneyInCoins = 0
    var remainingMoney = money
    let ways = 0
    
    //key for our memorization
    var key = money + '-' + index
    //if this option already calculated, then just return the answer
    if(key in memo){
        return memo[key]
    }
    
    //recursive part
    while(remainingMoney > 0){
        remainingMoney = money-moneyInCoins;
        ways += getWays(remainingMoney,coins,index+1,memo)
        moneyInCoins += coins[index]
    }
    
    //updating our momorization table with just calculated ways
    memo[key] = ways
    
    return ways
}

function main() {
    
    let [money,numberOfCoins] = readLine().split(' ').map(x=>parseInt(x));
    const coins = readLine().split(' ').map(cTemp => parseInt(cTemp, 10));

    console.log(getWays(money, coins))    
}
