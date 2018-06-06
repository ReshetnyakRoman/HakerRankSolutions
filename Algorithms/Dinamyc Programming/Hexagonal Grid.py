#!/bin/python3

def isBlocked(n, first,second):
    blocked_cells = sum(first) + sum(second)
    if blocked_cells % 2 == 1:
        return True
 
    if blocked_cells == 2*n:
        return False
    sum_so_far = 0
    for i in range(0,n):
        sum_so_far += (1 - first[i])
        if i > 0 and first[i] and second[i-1]:
            if sum_so_far % 2 == 1:
                return True
            sum_so_far = 0
        if first[i] and second[i] and sum_so_far % 2 == 1:
            return True
        sum_so_far += (1 - second[i])
    return False

T = int(input().strip())
for t in range(T):
    n = int(input().strip())
    first,second = [list(map(int,list(input()))) for _ in range(2)]
    if isBlocked(n,first,second):
        print('NO')
    else:
        print('YES')