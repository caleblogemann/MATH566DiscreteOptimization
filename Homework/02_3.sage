# create linear program
p = MixedIntegerLinearProgram(maximization=False)
c = p.new_variable(integer=True, nonnegative=True)
p.set_objective(c[1] + c[2] + c[3] + c[4] + c[5] + c[6] + c[7] + c[8] + c[9] + c[10] + c[11] + c[12])
p.add_constraint(2*c[1] + c[2] + c[3] + c[4] >= 97)
p.add_constraint(c[2] + 2*c[5] + c[6] + c[7] + c[8] >= 610)
p.add_constraint(c[3] + 2*c[6] + c[7] + 3*c[9] + 2*c[10] + c[11] >= 395)
p.add_constraint(c[2] + c[3] + 3*c[4] + 2*c[5] + 2*c[7] + 4*c[8] + 2*c[10] + 4*c[11] + 7*c[12] >= 211)
# print solution
print('Objective Value: {}'.format(p.solve()))
for i, v in p.get_values(c).iteritems():
    print('c_%s = %s' % (i, int(round(v))))
