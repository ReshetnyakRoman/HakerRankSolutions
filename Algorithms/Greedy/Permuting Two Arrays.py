#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the twoArrays function below.
def twoArrays(k, A, B):
    if (sum(A)+sum(B))/len(A)<k:
        return 'NO'
    else:
        A=sorted(A)
        B=sorted(B)
        i=0
        while i<len(A):
            if(A[i]+B[-i-1]<k):
                return 'NO'
            i+=1
        return 'YES'    

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    q = int(input())

    for q_itr in range(q):
        nk = input().split()

        n = int(nk[0])

        k = int(nk[1])

        A = list(map(int, input().rstrip().split()))

        B = list(map(int, input().rstrip().split()))

        result = twoArrays(k, A, B)

        fptr.write(result + '\n')

    fptr.close()
