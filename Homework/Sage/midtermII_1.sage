#d = {0: [1,4,5], 1: [2,6], 2: [3,7], 3: [4,8], 4: [9], 5: [7, 8], 6: [8,9], 7: [9]}
#d = {0: [1,2,3], 1: [2], 2: [3]}
#d = {}
graph = graphs.RandomBarabasiAlbert(12,5)
graph.plot().show()
milp = MixedIntegerLinearProgram(maximization=False)
x = milp.new_variable(binary=True)

milp.set_objective(sum([x[v] for v in graph.vertices()]))

milp.add_constraint(sum([x[v] for v in graph.vertices()]) >= 3)
for v in graph.vertices():
    milp.add_constraint(sum([x[u] for u in graph.neighbors(v)]) >= 2*x[v])

print('Objective Value: {}'.format(milp.solve()))
for i, v in milp.get_values(x).iteritems():
    print('x_%s = %s' % (i, v))
