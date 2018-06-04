#!/bin/python3

def stockmax(prices):
    i=len(prices)-1
    profit=0
    priceToSell=0
    
    while(i>=0):
        if prices[i]>=priceToSell:
            priceToSell=prices[i]
        profit+=priceToSell-prices[i]
        i-=1    

    return profit

if __name__ == '__main__':
    t = int(input())

    for t_itr in range(t):
        n = int(input())
        prices = list(map(int, input().rstrip().split()))

        print(stockmax(prices))