import operator
M = Matrix([[0, 3, 4, 8, 0, 0, 0, 0],
            [0, 0, 0, 0, 7, 0, 0, 0],
            [0, 3, 0, 0, 0, 2, 1, 0], 
            [0, 0, 2, 0, 0, 0, 2, 0],
            [0, 0, 0, 0, 0, 5, 0, 2],
            [0, 0, 0, 0, 0, 0, 1, 5],
            [0, 0, 0, 0, 0, 0, 0,10],
            [0, 0, 0, 0, 0, 0, 0, 0]])
G = DiGraph(M, weighted=True)
G.relabel({0:'s', 1:'a', 2:'b', 3:'c', 4:'d', 5:'e', 6:'f', 7:'t'})
s = 's'
t = 't'
milp = MixedIntegerLinearProgram(maximization=True)
y = milp.new_variable(nonnegative=True)
milp.set_objective(y[t] - y[s])
milp.add_constraint(y[s] == 0)
for edge in G.edges():
    milp.add_constraint(y[edge[1]] - y[edge[0]] <= edge[2])


print('Objective Value: {}'.format(milp.solve()))
sol = milp.get_values(y)
sol = sorted(sol.items(), key=operator.itemgetter(0))
for i, v in sol:
    print('y[%s] = %s' % (i, v))

