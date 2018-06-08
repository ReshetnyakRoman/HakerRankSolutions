#!/bin/python3

import os
from functools import reduce

def nimbleGame(s):
    Gn=[]
    for i in range(len(s)):
        if s[i]%2 == 0:
            item = 0
        else:
            item = i
        Gn.append(item)
    return 'First' if reduce(lambda a,b:a^b,Gn) != 0 else 'Second'

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    t = int(input())

    for t_itr in range(t):
        n = int(input())

        s = list(map(int, input().rstrip().split()))

        result = nimbleGame(s)

        fptr.write(result + '\n')

    fptr.close()