#!/bin/python3
import os
from functools import reduce

def nimGame(pile):
    return 'First' if reduce(lambda a,b:a^b,pile) else 'Second'
   
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    g = int(input())

    for g_itr in range(g):
        n = int(input())

        pile = list(map(int, input().rstrip().split()))

        result = nimGame(pile)

        fptr.write(result + '\n')

    fptr.close()