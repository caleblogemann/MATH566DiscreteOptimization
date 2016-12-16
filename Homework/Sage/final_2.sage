d = Matrix([(3, 2, 3),
            (2, 3, 1),
            (4, 2, 2),
            (1, 5, 1)])

nI = d.nrows()
nR = d.ncols()

milp = MixedIntegerLinearProgram(maximization=True)
x = milp.new_variable(binary=True)
obj = 0
for i in range(nI):
    obj += sum([d[i,r]*x[i+1,r+1] for r in range(nR)])
milp.set_objective(obj)

for i in range(nI):
    milp.add_constraint(sum([x[i+1,r+1] for r in range(nR)]) <= 1)
for r in range(nR):
    milp.add_constraint(sum([x[i+1,r+1] for i in range(nI)]) >= 1)

con = 0
for i in range(nI):
    con += sum([x[i+1,r+1] for r in range(nR)])
milp.add_constraint(con <= 3)

print('Objective Value: {}'.format(milp.solve()))
sol = milp.get_values(x)
for i, v in sol.items():
    print('x[%s] = %s' % (i, v))
