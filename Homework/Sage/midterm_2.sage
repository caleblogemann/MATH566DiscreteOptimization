milp = MixedIntegerLinearProgram(maximization=True)
x = milp.new_variable(nonnegative=True)
milp.set_objective(x[1] + x[2])
milp.add_constraint(x[1] <= 1)
milp.add_constraint(-x[1] + x[2] <= 1)
print('Objective Value: {}'.format(milp.solve()))
for i, v in milp.get_values(x).iteritems():
    print('x_%s = %s' % (i, v))
