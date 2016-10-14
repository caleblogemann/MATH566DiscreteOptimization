import Queue
def breadthFirstSearch(vertexList, edgeList, rootVertex):
    parentDict = dict()
    distanceDict = dict()
    for vertex in vertexList:
        parentDict[vertex] = None
        distanceDict[vertex] = oo

    # create queue to hold nodes
    q = Queue.Queue()

    distanceDict[rootVertex] = 0
    q.put(rootVertex)

    while not q.empty():
        currentVertex = q.get()
        for edge in edgeList:
            if edge[0] == currentVertex:
                adjacentVertex = edge[1]
            elif edge[1] == currentVertex:
                adjacentVertex = edge[0]
            else:
                continue

            # if we haven't reached adjacentVertex yet
            if distanceDict[adjacentVertex] == oo:
                distanceDict[adjacentVertex] = distanceDict[currentVertex] + 1
                parentDict[adjacentVertex] = currentVertex
                q.put(adjacentVertex)

    return distanceDict
