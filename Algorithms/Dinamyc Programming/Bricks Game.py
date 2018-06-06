#!/bin/python3

import os
import sys

#
# Complete the bricksGame function below.
#
def bricksGame(stack,index, n):
    global DP
    
    # 3 base cases:
    if index == n:
        return 0
    
    if index>n:
        return float('-inf')
    
    #if less then 4 bricks left in stack we take 3 (in case of 4) or all the rest to get max score
    if n-index<=4:
        return sum(stack[index:min(n,index+3)])
        
        
    #check for solution in DP memory to avoid excessive recursive calculations.
    if DP[index]!=0:
        return DP[index]
    
    answers=[]
    
    #first player take 1,2 or 3 brick (i)
    for i in range(1,4):
        answer=float('inf')
    
        #for each i, checking 3 variants when second player take 1,2 or 3 bricks (j)
        for j in range(1,4):
            answerVariant=bricksGame(stack,index+i+j, n)
            if answerVariant != float('-inf'):
                answer=min(answer,answerVariant+sum(stack[index:index+i]))
        answers.append(answer)
    
    result=max(answers)
    
    #adding calculated solution to DP memory:
    DP[index]=result
    
    return result
        
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    t = int(input())

    for t_itr in range(t):
        n = int(input())
        
        arr = list(map(int, input().rstrip().split()))
        
        DP=[0]*n
        result = bricksGame(arr,0,n)

        fptr.write(str(result) + '\n')

    fptr.close()
