import Queue
def breadthFirstSearch(G, s):
    # G is a graph
    # s is the starting vertex
    #parentDict = {v:None for v in G.vertices()}
    #distanceDict = {v:oo for v in G.vertices()}

    # create empty tree
    T = DiGraph([G.vertices(),[]])
    R = {s}

    # create queue to hold nodes
    q = Queue.Queue()

    #distanceDict[s] = 0
    q.put(s)

    while not q.empty():
        currentVertex = q.get()
        # iterate over edges incident to currentVertex
        # if G is directed only includes edges going out from currentVertex
        #print("Current Vertex:" + currentVertex)
        for e in G.edges_incident(currentVertex):
            adjacentVertex = e[1]
            #print("Adjacent Vertex:" + adjacentVertex)
            # if we haven't reached adjacentVertex yet
            # if distanceDict[adjacentVertex] == oo:
                # distanceDict[adjacentVertex] = distanceDict[currentVertex] + 1
                # parentDict[adjacentVertex] = currentVertex
                # q.put(adjacentVertex)

            if adjacentVertex not in R:
                q.put(adjacentVertex)
                R.add(adjacentVertex)
                T.add_edge(e)
    return T
