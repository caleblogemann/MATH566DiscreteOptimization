# MATH 566 - Minimum spanning tree algorithm
# Notes:
#  - pick any algorithm for minimum spanning three you like
#  - no need to optimize the running time
import itertools as it

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

vertexList = generate_random_vertices()
edgeList = list(it.combinations(range(10), 2))
costList = []
for edge in edgeList:
    u = vertexList[edge[0]]
    v = vertexList[edge[1]]
    costList.append(sqrt((u[0]-v[0])^2 + (u[1] - v[1])^2))

load('kruskal.sage')
edges = kruskal(vertexList, edgeList, costList)

plot_vertices_edges(vertexList, edges)
