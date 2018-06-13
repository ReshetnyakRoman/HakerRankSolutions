#!/bin/python3
import math

edges = []
[P,Q] = list(map(int,input().split()))

def findFactors(forest, P): 
    min=100
    tree=[0]*3
    
    for k in range(1,30):
        for l in range(1,30):
            for m in range(1,30):
                if k*l*m == P and k+l+m<min:
                    tree = [k,l,m]
                    min=k+l+m
    if sum(tree):
        forest.append(tree)
    return forest

def combinations(n):
    return n*(n-1)*(n-2)//6

def splitTreesForTwo(P):
    forest = []

    while P > 0: 
        if P<4:
            forest.append(3)
            P=P-1
        else:    
            for i in range(P,2,-1):
                if combinations(i) <= P and P - combinations(i) >= 0:
                    forest.append(i)
                    break;

            P = P - combinations(i)
    return forest

def splitToTrees(P,memo={}):
    forest=[]
    reminder = 0
    
    if P in memo:
        return memo[P]
    
    while len(forest) == 0 and reminder <= P/2:
        forest = findFactors(forest, P-reminder)
        if len(forest) > 0:
            break
        else:
            reminder +=1
    #memorization step1
    memo[P-reminder] = forest
    
    if reminder > 0:
        forest += splitToTrees(reminder, memo)
    #memorization step2
    memo[P] = forest
    
    return forest

def makeRoot(Q,lastNodeNumber=0):
    if Q%2 == 0:
        Nroot = (3*Q)//2-3 #number of nodes in root
        for i in range(1,Nroot+1):
            if i < 4:
                edges.append((1+lastNodeNumber,i+1+lastNodeNumber))
            else:
                edges.append((i-2+lastNodeNumber,i+1+lastNodeNumber))
    else:
        Nroot = (Q+1)*3//2-3 #number of nodes in root
        for i in range(1,Nroot+1):
            if i < 4:
                edges.append((i+lastNodeNumber,(i+1)%3+1+lastNodeNumber))
            else:
                edges.append((i-3+lastNodeNumber,i+lastNodeNumber))

def makeLeafs(tree, Q,lastNodeNumber=0):
    if Q%2 == 0:
        Nroot = (3*Q)//2-2 #number of nodes in root
        lastNodeNumber = Nroot + lastNodeNumber #number of last node in forest
    else:
        Nroot = (Q+1)*3//2-3 #number of nodes in root
        lastNodeNumber = Nroot + lastNodeNumber #number of last node in forest
    
    #start nodes - nodes to wich leafs will be added to form full tree
    starNodes = [lastNodeNumber-2,lastNodeNumber-1,lastNodeNumber]
    
    for i in range(0,3):
        for _ in range(1,tree[i]+1):
            edges.append((starNodes[i],lastNodeNumber+1))
            lastNodeNumber += 1
    
    return  lastNodeNumber


def solve(P,Q):
    if Q>2:
        if Q%2 == 0:
            Nroot = (3*Q)//2-2 #number of nodes in root
            Eroot = (3*Q)//2-3 #number of edges in root
        else:
            Nroot = (Q+1)*3//2-3 #number of nodes in root
            Eroot= Nroot #number of edges in root

        forest = splitToTrees(P)
        numberOfTrees = len(forest)
        numberOfLeafs = sum(map(sum, forest))
        lastNodeNumber = 0
        
        #adding number of Nodes and Edges:
        edges.append((Nroot*numberOfTrees + numberOfLeafs, Eroot*numberOfTrees + numberOfLeafs))

        for tree in forest:
            makeRoot(Q,lastNodeNumber)
            lastNodeNumber = makeLeafs(tree,Q,lastNodeNumber)

    else: 
        forest = splitTreesForTwo(P)
        numberOfTrees = len(forest)
        numberOfLeafs = sum(forest)
        rootNodeNumber = 1
        
        edges.append((numberOfTrees + numberOfLeafs,numberOfLeafs))
        
        for tree in forest:
            for leaf in range(1,tree+1):
                edges.append((rootNodeNumber,rootNodeNumber+leaf))
            
            rootNodeNumber += tree + 1
    
    for item in edges:
            print(*item)
solve(P,Q)