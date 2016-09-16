import numpy as np
# initialize data
x = vector([53, 55, 59, 61.5, 61.5])
y = vector([90, 94, 95, 100, 105])
n = x.length()

# create linear program
milp = MixedIntegerLinearProgram(maximization=False)
u = milp.new_variable(nonnegative=True)
a = milp.new_variable(nonnegative=False)
b = milp.new_variable(nonnegative=False)

# set objective and constraints
ones = matrix(np.full((1,n), 1))
milp.set_objective((ones*u)[0])
milp.add_constraint(identity_matrix(n)*u + b[0] + a[0]*x >= y)
milp.add_constraint(-identity_matrix(n)*u + b[0] + a[0]*x <= y)

print('Objective Value: {}'.format(milp.solve()))
a1 = milp.get_values(a[0])
b1 = milp.get_values(b[0])
print('a = {}'.format(a1))
print('b = {}'.format(b1))
print('Errors')
for i, v in milp.get_values(u).iteritems():
    print('u_%s = %s' % (i, v))

sp = scatter_plot(zip(x, y))
z = var('z')
lp = plot(a1*z + b1, (z, min(x), max(x)))
show(sp + lp)
