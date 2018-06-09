#!/bin/python3

def flippingMatrix(a,n):
    NxN=[[0]*n for _ in range(2*n)]
    for j in range(n):
        for i in range(n):
            NxN[j][i] = max(a[j][i],a[j][2*n-1-i],a[2*n-1-j][i],a[2*n-1-j][2*n-1-i])
    return sum([sum(row) for row in NxN])


q = int(input())
for q_itr in range(q):
    n = int(input())
    matrix = [list(map(int, input().rstrip().split())) for _ in range(2*n)]
    print(flippingMatrix(matrix,n)) 