#!/bin/python3

import math
import os
import random
import re
import sys
from itertools import combinations

# Complete the maximumPerimeterTriangle function below.
def maximumPerimeterTriangle(sticks):
    comb=set([item for item in combinations(sorted(sticks),3)])
    triangles=[item for item in comb if item[2]<item[0]+item[1]]
    answer=[-1]
    if len(triangles)>0:
        for triangle in triangles:
            if max(triangle)>max(answer) or max(triangle)==max(answer) and min(triangle)>min(answer):
                answer=triangle
    return answer                
        
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input())

    sticks = list(map(int, input().rstrip().split()))

    result = maximumPerimeterTriangle(sticks)

    fptr.write(' '.join(map(str, result)))
    fptr.write('\n')

    fptr.close()
