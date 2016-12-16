import itertools as it
load('kruskal.sage')
def nearestNeighbor(points):
    pointList = list(points)
    n = len(pointList)
    cycle = [pointList.pop()]
    total_distance = 0
    for i in range(n-1):
        j = min(enumerate(pointList), key=lambda x:distance(cycle[-1], x[1]))[0]
        cycle.append(pointList.pop(j))
        total_distance += distance(cycle[-1], cycle[-2])

    total_distance+=distance(cycle[0], cycle[-1])
    return (cycle, N(total_distance))

def cheapestInsertion(points):
    pointList = list(points)
    n = len(pointList)
    cycle = [pointList.pop(), pointList.pop()]
    total_distance = distance(cycle[0], cycle[1])
    for i in range(n-2):
        minVertexIndex = None
        minDistance = None
        # find vertex not in cycle closest to vertex in cycle
        for j in range(len(pointList)):
            d = min([distance(pointList[j], x) for x in cycle])
            if d < minDistance or minDistance == None:
                minVertexIndex = j
                minDistance = d

        # find place to insert in cycle that minimizes increase in total length
        minCycleIndex = None
        minDistanceChange = None
        for j in range(len(cycle)):
            if j == len(cycle) - 1:
                jPlus = 0
            else:
                jPlus = j + 1
            d = distance(cycle[j], pointList[minVertexIndex]) \
                + distance(cycle[jPlus], pointList[minVertexIndex]) \
                - distance(cycle[j], cycle[jPlus])
            if d < minDistanceChange or minDistanceChange == None:
                minDistanceChange = d
                minCycleIndex = j
        total_distance += minDistanceChange
        cycle.insert(minCycleIndex+1, pointList.pop(minVertexIndex))

    total_distance += distance(cycle[0], cycle[-1])
    return (cycle, N(total_distance))

def furthestInsertion(points):
    pointList = list(points)
    n = len(pointList)
    # find initial max distance
    maxDistance = None
    maxIndexA = None
    maxIndexB = None
    for a in range(n-1):
        b = max(enumerate(pointList[a+1:]), key=lambda x:distance(pointList[a], x[1]))[0] + a + 1
        d = distance(pointList[a], pointList[b])
        if d > maxDistance or maxDistance == None:
            maxDistance = d
            maxIndexA = a
            maxIndexB = b

    pointA = pointList[maxIndexA]
    pointB = pointList[maxIndexB]
    cycle = [pointA, pointB]
    pointList.remove(pointA)
    pointList.remove(pointB)
    total_distance = 2*distance(cycle[0], cycle[1])
    for i in range(n-2):
        maxVertexIndex = None
        maxDistance = None
        # find vertex not in cycle farthest from vertex in cycle
        for j in range(len(pointList)):
            d = max([distance(pointList[j], x) for x in cycle])
            if d > maxDistance or maxDistance == None:
                maxVertexIndex = j
                maxDistance = d

        minCycleIndex = None
        minDistanceChange = None
        for j in range(len(cycle)):
            if j == len(cycle) - 1:
                jPlus = 0
            else:
                jPlus = j + 1
            d = distance(cycle[j], pointList[maxVertexIndex]) \
                + distance(cycle[jPlus], pointList[maxVertexIndex]) \
                - distance(cycle[j], cycle[jPlus])
            if d < minDistanceChange or minDistanceChange == None:
                minDistanceChange = d
                minCycleIndex = j
        total_distance += minDistanceChange
        cycle.insert(minCycleIndex+1, pointList.pop(maxVertexIndex))
    return (cycle, N(total_distance))

def lowerBound(points):
    LB = 0
    for v in points:
        vertexList = list(points)
        vertexList.remove(v)
        n = len(vertexList)
        edgeList = list(it.combinations(range(n), 2))
        costList = []
        for edge in edgeList:
            u = vertexList[edge[0]]
            v = vertexList[edge[1]]
            costList.append(distance(u, v))
        treeEdges = kruskal(vertexList, edgeList, costList)
        bound = sum([distance(vertexList[e[0]], vertexList[e[1]]) for e in treeEdges])
        w = min(vertexList, key=lambda x:distance(x,v))
        bound += distance(v,w)
        vertexList.remove(w)
        u = min(vertexList, key=lambda x:distance(x,v))
        bound += distance(v,u)
        if bound > LB:
            LB = bound
    return LB

def plotCycle(cycle):
    plot = line([])
    for i in range(len(cycle)):
        plot += disk(cycle[i], 0.1, (0,2*pi), color='red')
        if i < len(cycle)-1:
            plot += line([cycle[i], cycle[i+1]])
        else:
            plot += line([cycle[i], cycle[0]])
    plot.show()

def distance(a, b):
    diff = [i - j for i,j in zip(a, b)]
    squares = [x^2 for x in diff]
    return sqrt(sum(squares))

def computeTotalDistance(cycle):
    total = 0
    for i in range(len(cycle) - 1):
        total += distance(cycle[i], cycle[i+1])
    total += distance(cycle[0], cycle[-1])
    return N(total)
