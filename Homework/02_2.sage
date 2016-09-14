# create linear program
p = MixedIntegerLinearProgram(maximization=True)
y = p.new_variable(nonnegative=True)

A = matrix([[125, 35, 0, 0, 0.275], [190, 7, 2, 7, 0.130], [110, 27, 1, 0, 0],
[50, 13, 0, 0, 0], [190, 27, 1, 4, .36], [100, 18, 1, 2, .06], [60, 9, 2, 2, .2],
[20, 4, 2, 1, .38], [70, 12, 3, 4, .37], [60, 25, 14, 2, 0.105],
[120, 2, 0, 1, 0.025], [140, 24, 1, 4, 0.44], [80, 1, 0, 8, 0.69],
[60, 0, 0, 11, 0.52], [150, 25, 1, 4, 0.025]])
b = transpose(matrix([2779, 383, 38, 60, 1.4*1.5]))
c = transpose(matrix([0.75, 0.13, 0.34, 0.13, 0.48, 0.17, 0.21, 0.21, 0.21, 0.25, 0.42, 0.26, 0.50, 1.15, 0.29]))

p.set_objective(b[0,0]*y[1] + b[1, 0]*y[2] + b[2, 0]*y[3] + b[3, 0]*y[4] + b[4,0]*y[5])
p.add_constraint(A[0,0]*y[1] + A[0,1]*y[2] + A[0,2]*y[3] + A[0,3]*y[4] + A[0,4]*y[5] <= c[0,0])
p.add_constraint(A[1,0]*y[1] + A[1,1]*y[2] + A[1,2]*y[3] + A[1,3]*y[4] + A[1,4]*y[5] <= c[1,0])
p.add_constraint(A[2,0]*y[1] + A[2,1]*y[2] + A[2,2]*y[3] + A[2,3]*y[4] + A[2,4]*y[5] <= c[2,0])
p.add_constraint(A[3,0]*y[1] + A[3,1]*y[2] + A[3,2]*y[3] + A[3,3]*y[4] + A[3,4]*y[5] <= c[3,0])
p.add_constraint(A[4,0]*y[1] + A[4,1]*y[2] + A[4,2]*y[3] + A[4,3]*y[4] + A[4,4]*y[5] <= c[4,0])
p.add_constraint(A[5,0]*y[1] + A[5,1]*y[2] + A[5,2]*y[3] + A[5,3]*y[4] + A[5,4]*y[5] <= c[5,0])
p.add_constraint(A[6,0]*y[1] + A[6,1]*y[2] + A[6,2]*y[3] + A[6,3]*y[4] + A[6,4]*y[5] <= c[6,0])
p.add_constraint(A[7,0]*y[1] + A[7,1]*y[2] + A[7,2]*y[3] + A[7,3]*y[4] + A[7,4]*y[5] <= c[7,0])
p.add_constraint(A[8,0]*y[1] + A[8,1]*y[2] + A[8,2]*y[3] + A[8,3]*y[4] + A[8,4]*y[5] <= c[8,0])
p.add_constraint(A[9,0]*y[1] + A[9,1]*y[2] + A[9,2]*y[3] + A[9,3]*y[4] + A[9,4]*y[5] <= c[9,0])
p.add_constraint(A[10,0]*y[1] + A[10,1]*y[2] + A[10,2]*y[3] + A[10,3]*y[4] + A[10,4]*y[5] <= c[10,0])
p.add_constraint(A[11,0]*y[1] + A[11,1]*y[2] + A[11,2]*y[3] + A[11,3]*y[4] + A[11,4]*y[5] <= c[11,0])
p.add_constraint(A[12,0]*y[1] + A[12,1]*y[2] + A[12,2]*y[3] + A[12,3]*y[4] + A[12,4]*y[5] <= c[12,0])
p.add_constraint(A[13,0]*y[1] + A[13,1]*y[2] + A[13,2]*y[3] + A[13,3]*y[4] + A[13,4]*y[5] <= c[13,0])
p.add_constraint(A[14,0]*y[1] + A[14,1]*y[2] + A[14,2]*y[3] + A[14,3]*y[4] + A[14,4]*y[5] <= c[14,0])

# print solution
print('Objective Value: {}'.format(p.solve()))
for i, v in p.get_values(y).iteritems():
    print('y_%s = %s' % (i, v))
