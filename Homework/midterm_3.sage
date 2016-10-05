import itertools as it
load('breadthFirstSearch.sage')

# This plots vertices as red dots and blue edges connecting them
def plot_vertices_edges(vertices, edges):
    drawing =  line([])
    for x in vertices:
        drawing = drawing + disk(x, 0.1, (0,2*pi), color='red')
    for e in edges:
        drawing =  drawing + line([vertices[e[0]], vertices[e[1]]])
    drawing.show()
       
# Generate 10 random vertices in 10x10 grid
def generate_random_vertices():
    vertexList=[]
    for i in range(10):
        vertexList.append((random()*10, random()*10))
    return vertexList

def generateEdgeList(numVertices):
    return list(it.combinations(range(numVertices), 2))

def generateCostList(vertexList, edgeList):
    costList = []
    for edge in edgeList:
        u = vertexList[edge[0]]
        v = vertexList[edge[1]]
        costList.append(sqrt((u[0]-v[0])^2 + (u[1] - v[1])^2))
    return costList

def minimumSpanningTree(vertexList, edgeList, costList):
    numVertices = len(vertexList)
    numEdges = len(edgeList)
    
    # sort edges by cost
    s = sorted(zip(edgeList, costList), key=lambda pair:pair[1], reverse=True)
    edgeList = [x for (x, y) in s]
    costList = [y for (x, y) in s]

    treeEdgeList = list(edgeList)

    for edge in edgeList:
        treeEdgeList.remove(edge)
        # if graph without edge is not connected
        if max(breadthFirstSearch(vertexList, treeEdgeList, vertexList[0]).values()) == oo:
            # if not connected add edge back into treeEdgeList
            treeEdgeList.append(edge)

    return treeEdgeList

# generate random graph
vertexList = generate_random_vertices()
edgeList = generateEdgeList(len(vertexList))
costList = generateCostList(vertexList, edgeList)

# find minimum spanning tree
edges = minimumSpanningTree(range(10), edgeList, costList)

# plot minimum spanning tree
plot_vertices_edges(vertexList, edges)
