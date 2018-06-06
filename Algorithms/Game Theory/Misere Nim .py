#!/bin/python3
import os
from functools import reduce

def misereNim(s):
    if sum(s)==len(s):
        return 'First' if len(s)%2 == 0 else 'Second'
    else:
        return 'Second' if reduce(lambda a,b:a^b,s) == 0 else 'First'
 
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    t = int(input())

    for t_itr in range(t):
        n = int(input())
        s = list(map(int, input().rstrip().split()))
        fptr.write(misereNim(s) + '\n')

    fptr.close()