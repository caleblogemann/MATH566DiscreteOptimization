#def kruskal(vertexList, edgeList, costList)
import itertools as it
vertexList=[]
for i in range(10):
    vertexList.append(vector([random()*10, random()*10]))

edgeList = list(it.combinations(range(10), 2))
numVertices = len(vertexList)
numEdges = len(edgeList)

costList = []
for i in range(numEdges):
    u = vertexList[edgeList[i][0]]
    v = vertexList[edgeList[i][1]]
    costList.append(norm(u - v))

# sort edges by cost
s = sorted(zip(edgeList, costList), key=lambda pair:pair[1])
edgeList = [x for (x, y) in s]
costList = [y for (x, y) in s]

treeEdgeList = []
#treeSet = {set(x) for x in vertexList}

for i in range(numEdges):
    if True:
        treeEdgeList.append(edgeList[i])

#return 
