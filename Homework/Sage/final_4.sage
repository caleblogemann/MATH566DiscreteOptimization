load('contractVertices.sage')
load('edmondsBlossom.sage')
#            a  b  c  d  e  f  g  h  i  j  k  l
M = Matrix([(0, 0, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0), #a
            (0, 0, 0, 0, 0, 0, 0, 0, 5, 3, 0, 0), #b
            (1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 4), #c
            (2, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0), #d
            (1, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0), #e
            (0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 2, 5), #f
            (0, 0, 0, 3, 2, 1, 0, 0, 2, 3, 0, 0), #g
            (0, 0, 2, 0, 1, 2, 0, 0, 0, 0, 0, 0), #h
            (0, 5, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0), #i
            (0, 3, 0, 0, 0, 0, 3, 0, 0, 0, 1, 0), #j
            (0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0), #k
            (0, 0, 4, 0, 0, 5, 0, 0, 0, 0, 0, 0)])

graph = Graph(M, weighted=True)
graph.relabel({0:'a',1:'b',2:'c',3:'d',4:'e',5:'f',6:'g',7:'h',8:'i',9:'j',10:'k',11:'l'})

milp = MixedIntegerLinearProgram(maximization=False)
x = milp.new_variable(binary=True)

milp.set_objective(sum([e[2]*x[e] for e in graph.edges()]))
for v in graph.vertices():
    milp.add_constraint(sum([x[e] for e in graph.edges_incident(v)]) == 1)

print('Objective Value: {}'.format(milp.solve()))
sol = milp.get_values(x)
for i, v in sol.items():
    print('x[%s] = %s' % (i, v))

milp = MixedIntegerLinearProgram(maximization=True)
y = milp.new_variable()
milp.set_objective(sum({y[v] for v in graph.vertices()}))
for e in graph.edges():
    milp.add_constraint(y[e[0]] + y[e[1]] <= e[2])

print('Objective Value: {}'.format(milp.solve()))
sol = milp.get_values(y)
for i, v in sol.items():
    print('y[%s] = %s' % (i, v))
