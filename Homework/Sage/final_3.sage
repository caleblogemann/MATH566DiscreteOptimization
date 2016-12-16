load('dijkstras.sage')
#            a  b  c  d  e  f  g  h  i  v  y
M = Matrix([(0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 1), #a
            (0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2), #b
            (0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 1), #c
            (1, 0, 0, 0, 1, 2, 0, 0, 2, 0, 0), #d
            (0, 1, 2, 1, 0, 0, 2, 3, 0, 0, 0), #e
            (2, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0), #f
            (0, 0, 0, 0, 2, 0, 0, 0, 0, 5, 0), #g
            (0, 0, 0, 0, 3, 0, 0, 0, 1, 3, 0), #h
            (0, 0, 0, 2, 0, 0, 0, 1, 0, 1, 0), #i
            (0, 0, 0, 0, 0, 0, 5, 3, 1, 0, 0), #v
            (1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0)]) #y

graph = Graph(M, weighted=True)
graph.relabel({0:'a', 1:'b', 2:'c', 3:'d', 4:'e', 5:'f', 6:'g', 7:'h', 8:'i', 9:'v', 10:'y'})
graph.set_vertices({'a':3, 'b':4, 'c':2, 'd':3, 'e':2, 'f':2, 'g':4, 'h':2, 'i':1, 'v':0, 'y':0})
source = 'y'
target = 'v'

(length, parent) = dijkstras(graph, source)

path = [target]
while parent[path[-1]] != None:
    path.append(parent[path[-1]])

path.reverse()
print("Distance: %s" % length[target])
print("Shortest path: %s" % path)


