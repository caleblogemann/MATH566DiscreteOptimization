#d = {'x': ['a', 'd'], 'a': ['b'], 'b': ['g'], 'g': ['f', 'h'], 'h': ['i'], 'd': ['f']}
#            x, a, b, d, f, g, h, i
m = Matrix([(0, 1, 0, 4, 0, 0, 0, 0),
            (1, 0, 4, 0, 0, 0, 0, 0),
            (0, 4, 0, 0, 0, 5, 0, 0),
            (4, 0, 0, 0, 2, 0, 0, 0),
            (0, 0, 0, 2, 0, 4, 0, 6),
            (0, 0, 5, 0, 4, 0, 4, 0),
            (0, 0, 0, 0, 0, 4, 0, 3),
            (0, 0, 0, 0, 6, 0, 3, 0)])

graph = Graph(m, weighted=True)
graph.relabel({0:'x', 1:'a', 2:'b', 3:'d', 4:'f', 5:'g', 6:'h', 7:'i'})
milp = MixedIntegerLinearProgram(maximization=False)
x = milp.new_variable(binary=True)
milp.set_objective(sum([e[2]*x[e] for e in graph.edges()]))
for v in graph.vertices():
    milp.add_constraint(sum([x[e] for e in graph.edges_incident(v)]) == 1)

print('Objective Value: {}'.format(milp.solve()))
sol = milp.get_values(x)
for i, v in sol.items():
    print('x[%s] = %s' % (i, v))
