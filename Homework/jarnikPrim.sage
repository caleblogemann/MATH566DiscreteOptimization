#def jarnikPrim(vertexList, edgeList, costList):

numVertices = len(vertexList)
numEdges = len(edgeList)
treeVertexList = [vertexList[randint(0,numVertices - 1)]
treeEdgeList = []

for i in range(numVertices - 1):
    minCostEdge = None
    minCost = None
    for j in range(numEdges):
        edge = edgeList[j]
        cost = costList[j]
        if cost <= minCost:
            for k in range(i+1):
            if xor(edge[0] in treeEdgeList, edge[1] in treeEdgeList)

