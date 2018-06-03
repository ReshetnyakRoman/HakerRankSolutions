#!/bin/python3
import sys

#the root function will return root element for given vertex and at the same time update root element for all intermediate vertecies in the tree if their root not equal to current valid root. 
def root(vertex):
    global rootsIDs
    if rootsIDs[vertex]==vertex:
        return vertex
    else:
        while(rootsIDs[vertex]!=vertex):
            rootsIDs[vertex]=rootsIDs[rootsIDs[vertex]]
            vertex=rootsIDs[vertex]
        return vertex        
    
#this function joins two trees by connecting two given vertices X and Y (its update the root element of tree with Y and make it equal to root of tree with X)
def union(x,y):
    global rootsIDs
    Xroot=root(x)
    Yroot=root(y)
    rootsIDs[Yroot]=rootsIDs[Xroot]
    return

def Kruskal(GE):
    global rootsIDs
    minimumWeight=0
    
    for edge in GE:
        x=edge[0]
        y=edge[1]
        weight=edge[2]
        if root(x)!=root(y):
            minimumWeight+=weight
            union(x,y)
                
    return minimumWeight

if __name__ == '__main__':
    V, E = map(int, input().split())
    
    #create and fill list of GraphEges    
    GE=[] 
    for i in range(E):
        GE.append(list(map(int, input().split())))
    
    #create list of eges sorted by their weights
    GE=sorted(GE, key=lambda x:x[2])    
    
    #create set of vertices with link to it root elements(index indecate vetex number value indicate root element of the tree containing that vertex)
    rootsIDs=list(range(V+1))
    
    print(Kruskal(GE))
        
    

