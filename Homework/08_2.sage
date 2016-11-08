import operator
#                a   b   c   d   e   f   g   h
costs = Matrix([[0, -2,  0,  0,  0,  0,  0, -3], #a
                [0,  0,  0,  0,  5,  0,  0,  0], #b
                [0,  0,  0,  2,  0,  0,  0,  0], #c
                [2,  0,  0,  0,  0,  0,  0,  0], #d
                [5,  0,  0,  0,  0,  2,  0, -1], #e
                [0,  1,  1,  0,  0,  0,  0,  0], #f
                [0,  0,  4,  0,  0,  1,  0, -2], #g
                [0,  0,  0,  0,  0,  0,  0,  0]])#h

#                     a  b  c  d  e  f  g  h
capacities = Matrix([[0, 4, 0, 0, 0, 0, 0, 2], #a
                     [0, 0, 0, 0, 2, 0, 0, 0], #b
                     [0, 4, 0, 4, 0, 0, 0, 0], #c
                     [2, 0, 0, 0, 0, 0, 0, 0], #d
                     [3, 0, 0, 0, 0, 6, 0, 4], #e
                     [0, 3, 3, 0, 0, 0, 0, 0], #f
                     [0, 0, 3, 3, 0, 2, 0, 2], #g
                     [0, 0, 0, 0, 0, 0, 0, 0]])#h

# sources/sinks
b = {'a':1, 'b':-3, 'c':2, 'd':-4, 'e':'4', 'f':0, 'g':3, 'h':-3}
G = DiGraph(capacities, weighted=True)

indexToVertex = {0:'a', 1:'b', 2:'c', 3:'d', 4:'e', 5:'f', 6:'g', 7:'h'}
vertexToIndex = {v: k for k, v in indexToVertex.iteritems()}
G.relabel(indexToVertex)
milp = MixedIntegerLinearProgram(maximization=False)
f = milp.new_variable(nonnegative=True)

milp.set_objective(sum([costs[vertexToIndex[e[0]], vertexToIndex[e[1]]]*f[e[0], e[1]] for e in G.edges()]))

# Flows less than capacities
for edge in G.edges():
    # edge[2] is weight or label of edge
    milp.add_constraint(f[edge[0], edge[1]] <= edge[2])

# Flows into and out of vertices must be equal to source or sink
for vertex in G.vertices():
    flow_in = sum([f[v, vertex] for v in G.neighbors_in(vertex)])
    flow_out = sum([f[vertex, v] for v in G.neighbors_out(vertex)])
    milp.add_constraint(flow_out - flow_in == b[vertex])

print('Objective Value: {}'.format(milp.solve()))
sol = milp.get_values(f)
sol = sorted(sol.items(), key=operator.itemgetter(0))
for i, v in sol:
    print('f[%s] = %s' % (i, v))
