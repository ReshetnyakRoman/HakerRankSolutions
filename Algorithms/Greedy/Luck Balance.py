#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the luckBalance function below.
def luckBalance(k, importantCont, notImportantCont):
    if k>len(importantCont):
        return sum(importantCont)+sum(notImportantCont)
    else:
        n=len(importantCont)-k
        sortedImp=sorted(importantCont)
    
        return sum(notImportantCont)+sum(sortedImp[n:])-sum(sortedImp[0:n])

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    nk = input().split()

    n = int(nk[0])

    k = int(nk[1])

    importantCont = []
    notImportantCont = []
    for _ in range(n):
        [Li,Ti]=list(map(int, input().rstrip().split()))
        if Ti==1:
            importantCont.append(Li)
        else:
            notImportantCont.append(Li)

    result = luckBalance(k, importantCont, notImportantCont)

    fptr.write(str(result) + '\n')

    fptr.close()
