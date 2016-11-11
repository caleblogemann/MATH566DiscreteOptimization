def kruskal(vertexList, edgeList, costList):
    numVertices = len(vertexList)
    numEdges = len(edgeList)

    # sort edges by cost
    s = sorted(zip(edgeList, costList), key=lambda pair:pair[1])
    edgeList = [x for (x, y) in s]
    costList = [y for (x, y) in s]

    # create list of edges in tree
    treeEdgeList = []
    # create a list of ids of which tree each vertex is in
    vertexTreeIds = range(numVertices)

    for i in range(numEdges):
        # take edge of minimum cost
        edge = edgeList[i]
        u = edge[0]
        v = edge[1]
        # check if vertices are in the same subtree
        if vertexTreeIds[u] != vertexTreeIds[v]:
            treeEdgeList.append(edge)
            # update tree ids if added edge to spanning tree
            oldId = vertexTreeIds[v]
            for j in range(numVertices):
                if vertexTreeIds[j] == oldId:
                    vertexTreeIds[j] = vertexTreeIds[u]

    return treeEdgeList
