#!/bin/python3

import math
import os
import random
import re
import sys

n, k = [int(v) for v in input().split()]
a = [int(v) for v in input().split()]
d = {}
for idx, v in enumerate(a):
    d[v] = idx
for i, maxValue in enumerate(range(n, 0, -1)):
    if maxValue > a[i]:
        oldValue = a[i]
        newIndex = d[maxValue]
        a[i], a[newIndex] = a[newIndex], a[i]
        d[oldValue] = newIndex
        d[maxValue] = i
        k -= 1
    if k == 0:
        break
print(*a)
