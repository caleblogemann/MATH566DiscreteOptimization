import numpy as np

s = matrix([[0,0,0,1,0,1,0,1,0,0,1,0,1,0,0,1,1,1,1,1,1,1,1,0,1,1,1,1,0,0,1,0,0,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,0,1,0,1,0,0],
    [1,1,1,1,0,1,0,1,0,0,0,1,1,1,0,0,0,0,0,0,1,0,1,0,0,0,0,0,1,1,0,1,0,0,1,0,0,0,1,0,1,0,1,0,0,0,0,1,0,0,1,1,1,0],
    [1,0,1,0,1,0,1,0,1,1,1,1,0,0,1,1,1,1,1,1,0,0,0,1,1,1,0,1,0,0,0,1,0,0,1,1,0,1,1,1,0,1,1,1,1,1,0,0,0,1,1,0,0,0],
    [0,0,1,0,0,0,1,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,1,1,0,0,0,0],
    [1,0,0,1,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0,1,0,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0],
    [0,1,1,1,1,0,0,0,1,1,1,1,1,0,1,0,1,1,0,1,0,0,0,0,0,1,0,0,0,1,1,0,0,1,1,0,1,1,1,1,0,0,0,1,1,1,1,0,0,1,0,1,0,1],
    [0,0,1,1,0,1,1,0,0,1,1,1,0,1,1,0,1,1,0,1,0,1,1,0,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1,1,0,1,1,0,0,1,0,1,1,0],
    [1,0,0,0,0,1,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,1,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,1,0,1,0,1,0,0,0,0,0],
    [0,1,0,0,0,1,1,0,1,0,1,0,0,0,0,1,1,1,0,1,0,1,1,1,1,1,0,0,0,0,1,0,1,0,0,0,1,0,1,1,0,0,1,1,1,0,1,0,0,0,0,1,0,1],
    [1,1,1,1,0,1,0,1,0,0,0,1,1,1,0,0,0,0,0,0,1,0,1,0,0,0,0,0,1,1,0,1,0,0,1,0,0,0,1,0,1,0,1,0,0,0,0,1,0,0,1,1,1,0],
    [1,0,1,0,1,0,1,0,1,1,1,1,0,0,1,1,1,1,1,1,0,0,0,0,1,1,0,1,0,0,0,1,0,0,1,1,0,1,1,1,0,1,1,1,1,1,0,0,0,1,1,0,0,0],
    [0,0,1,0,0,0,1,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,1,1,0,0,0,0],
    [1,0,0,1,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0]])

nStudents = s.ncols()
nClasses = s.nrows()
nTimeSlots = 3
f(x) = min_symbolic(x, nTimeSlots)
# for each student take the minimum of desired courses and nTimeSlots
maxNumClasses = vector(map(f, sum(A)))

milp = MixedIntegerLinearProgram(maximization=True)
# variable to store what period each class is being held
# c[i,j] = 1 if class i is scheduled for time slot j, 0 otherwise
c = milp.new_variable(binary=True)
# w[i,j] = 1 if student i wants to take at least one class in period j
# w[i,j] = 0 otherwise, student doesn't want to take any classes
# offered in period j
w = milp.new_variable(binary=True)

# objective function will minimize difference of maximum possible
# courses and number classes actually taken
# sum of all w variables
W = 0
for i in range(nStudents):
    W = W + milp.sum([w[i,j] for j in range(nTimeSlots)])
milp.set_objective(W)

for i in range(nClasses):
    milp.add_constraint(milp.sum([c[i,j] for j in range(nTimeSlots)]) == 1)

# sufficiently large number, number larger than largest possible,
# nij, number of classes student i wants to take in period j.
M = nClasses + 1
for i in range(nStudents - 1):
    for j in range(nTimeSlots):
        nij = milp.sum([s[k,i]*c[k,j] for k in range(nClasses)])
        # for w[i,j] = 1  if nij >= 1
        milp.add_constraint(nij <= M*w[i,j])
        # for w[i,j] = 0 if nij = 0
        milp.add_constraint(w[i,j] <= nij)

print(str(int(milp.solve())) + ' out of ' + str(sum(maxNumClasses)))
c = milp.get_values(c)
for j in range(nTimeSlots):
    S = str(j+1) + ': '
    for i in range(nClasses):
        if c[i,j] >= 1:
            S = S + 'Class ' + str(i+1) + ', '
    S = S[:-2]
    print(S)
