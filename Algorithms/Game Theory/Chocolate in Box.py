#!/bin/python3
from functools import reduce

def chocolateInBox(arr):
    XORall=reduce(lambda a,b:a^b,arr)
    return sum([ chocolates^XORall < chocolates for chocolates in arr])
    
arr_count = int(input())
arr = list(map(int, input().rstrip().split()))

print(chocolateInBox(arr))