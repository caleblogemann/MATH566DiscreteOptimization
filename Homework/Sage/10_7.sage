load('contractVertices.sage')
load('edmondsBlossom.sage')

# 3D cube
graph = graphs.CubeGraph(3)
matching = edmondsBlossom(graph)
print 'Edges in matching for 3D cube'
for e in matching:
    print e

# graph from problem 3
d = {'a':['b', 'e', 'j'], 'b':['c', 'g'], 'c':['d', 'f'], 'd':['e','k','n'],
        'f':['h'], 'g':['h', 'i'], 'i':['j','l','o'], 'k':['l', 'm'], 'l':['m'],
        'n':['o', 'x'], 'o':['x']}
graph = Graph(d)
matching = edmondsBlossom(graph)

print 'Edges in matching for graph in problem 3'
for e in matching:
    print e
