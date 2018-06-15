#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the getMinimumCost function below.
def getMinimumCost(n, k, c):
    purchasesCount=[0]*k
    numberOfFlouwers=0
    moneySpent=0
    i=len(c)-1
    c=sorted(c)
    j=0
    while numberOfFlouwers<n:
        moneySpent+=c[i]*(purchasesCount[j]+1)
        purchasesCount[j]+=1
        i-=1
        print(purchasesCount)
        numberOfFlouwers+=1
        if j==k-1:
            j=0
        else:
            j+=1
    return moneySpent
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    nk = input().split()

    n = int(nk[0])

    k = int(nk[1])

    c = list(map(int, input().rstrip().split()))

    minimumCost = getMinimumCost(n, k, c)

    fptr.write(str(minimumCost) + '\n')

    fptr.close()
