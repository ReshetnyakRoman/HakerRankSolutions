import sys

def bfs(n,edges,startNode):
    #initialization: queue, graph, status of visited elements and distance

    graph=[set([]) for _ in range(n)]
    for x,y in edges:
        graph[x-1]=graph[x-1].union({y-1})
        graph[y-1]=graph[y-1].union({x-1})
    
    queue=[startNode-1]
    visitStatus=['not visited' for _ in range(n)] 
    distance=[-1 for _ in range(n)]
    distance[startNode-1]=0
        
    while(len(queue)):
        
        currentNode=queue.pop(0)
        visitStatus[currentNode]='visited'
        
        for linkedNode in graph[currentNode]:
            if visitStatus[linkedNode]=='not visited':
                visitStatus[linkedNode]='in process'
                distance[linkedNode]=distance[currentNode]+6
                queue.append(linkedNode)
                
        
    distance.remove(0) #removing distance for starting point to exclude it from output
        
    return distance           

if __name__ == "__main__":
    q=int(input())
    for _ in range(q):
        [n,m]=list(map(int,input().split()))

        edges=[]
        
        for _ in range(m):
            edge=list(map(int,input().split()))
            edges.append(edge)
        
        startNode=int(input())
        
        print(' '.join(map(str,bfs(n,edges,startNode))))