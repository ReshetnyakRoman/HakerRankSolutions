function processData(input) {
    let InputArr = input.split("\n").map(x=>x.split(' ').map(x=>parseInt(x)))
    let [n,m] = InputArr.splice(0,1)[0]
    
    //Creating and populating our graph
    let graph = {}
    for(let i=1;i<=n;i++){
        graph[i] = [] 
    }
    
    for(let edge of InputArr){
       if(!graph[edge[0]].includes(edge[1])){
           graph[edge[0]].push(edge[1])
       }
       if(!graph[edge[1]].includes(edge[0])){
           graph[edge[1]].push(edge[0])
       }
    }

    
    //function return node with minimum connections with neighbours to find starting node
    function minNode(graph,currentNode=0){
        let minConnections=100001, minNode
        for(let node in graph){
            if(graph[node].length < minConnections && node != currentNode){
                minConnections = graph[node].length
                minNode = node
            }
        }
        return minNode        
    }
    
    //function choose from all neighbors of current node, the one with minimum connections
    function nextNodes(graph,nodeNeighbors){
        let minConnections=100001, nextNode
        for(let node of nodeNeighbors){
            if(graph[node].length < minConnections){
                minConnections = graph[node].length
                nextNode = node
            }
        }
        return nextNode        
    }
   
    //main function, moves from node to connected node with minimum neighbors 
    function findPath(graph,currentNode, way=[]){
        
        
        while(graph[currentNode].length != 0){
            let currentNodeNeighbors = graph[currentNode]
            let nextNode = nextNodes(graph,currentNodeNeighbors)

            way.push(currentNode)
            graph[currentNode].splice(graph[currentNode].indexOf(nextNode),1)
            graph[nextNode].splice(graph[nextNode].indexOf(currentNode),1)
            currentNode = nextNode
        
        }
        
        return way
    }
    
    //solution
    let startNode =  minNode(graph);
    var way = findPath(graph,1);
    
    console.log(way.length)
    console.log(...way)
} 

process.stdin.resume();
process.stdin.setEncoding("ascii");
_input = "";
process.stdin.on("data", function (input) {
    _input += input;
});

process.stdin.on("end", function () {
   processData(_input);
});
