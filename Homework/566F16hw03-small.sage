

slots=3


##################

print "Using",slots,"timeslots"

preferences=[[0,0,0,1,0,1,0,1,0,0,1,0,1,0,0,1,1,1,1,1,1,1,1,0,1,1,1,1,0,0,1,0,0,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,0,1,0,1,0,0],
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
             [1,0,0,1,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0]]



#print matrix(preferences).str()

problems=len(preferences)
participants=len(preferences[0])

print "Got",problems,"problems and",participants,"participants"

# Now we create a weighted conflict map

'''
conflicts= [ [ 0  for y in range(problems)   ]  for x in range(problems)]
for pa in range(participants):
    # compute weight of conflict for participant
    x = max(sum([ preferences[i][pa] for i in range(problems)]),2)
    weight = 2/(x*(x-1))
    for p1 in range(problems-1):
        for p2 in range(p1+1,problems):
            if preferences[p1][pa] == 1 and preferences[p2][pa] == 1:
                conflicts[p1][p2] += weight
                conflicts[p2][p1] += weight
'''

Pm=matrix(preferences)
conflicts=Pm*Pm.transpose()


# This gives a total conflict matrix
print "Matrix of conflicts"
print matrix(conflicts).str()




# We will be minimizing # of conflicts
# The default solver is GLPK, which works fine for smaller instances
# We use GUROBI, which can be installed in sage using:
# http://doc.sagemath.org/html/en/thematic_tutorials/linear_programming.html#solvers
p = MixedIntegerLinearProgram(maximization=False,solver="GLPK");


# We build the following program
#   One problem (say numeber 0) needs a timeslot (total 4 timeslots). We make:
#    sched['00'] + sched['01'] + sched['02'] + sched['03'] = 1
#    sched[] in {0,1}
#
#   And then we have variables conf that detect if two problems are in conflict. Say problems 0 and 1: (conf may be real)
#    1 + conf['01']  >= sched['00'] + sched['10']     # both problems scheduled to slot 0
#    1 + conf['01']  >= sched['01'] + sched['11']     # both problems scheduled to slot 1
#    1 + conf['01']  >= sched['02'] + sched['12']     # both problems scheduled to slot 2
#    1 + conf['01']  >= sched['03'] + sched['13']     # both problems scheduled to slot 3
#
#  Finally the objective function is just sum of conlicf variables * weight of conflict
#
#  minimize  Sum_{i<j}  conflicts[i][j]*conf['ij']
#

sched = p.new_variable(binary=True); # about who is where
conf  = p.new_variable(binary=True); # indicator for conflicts
#conf  = p.new_variable(); # indicator for conflicts


# every problem is scheduled in one timeslot
#    sched['00'] + sched['01'] + sched['02'] + sched['03'] = 1
for i in range(problems):
    p.add_constraint( 1 ==  sum([sched['{}{}'.format(i,s)] for s in range(slots)]))


# This is for better iteration over all pairs of problems
pairs=[]
for i in range(problems-1):
    for j in range(i+1,problems):
        pairs.append([i,j])


# add conflict detection constraints such as
#    1 + conf['01']  >= sched['03'] + sched['13']     # both problems 0 and a scheduled to slot 3
for i,j in pairs:
    for s in range(slots):
        p.add_constraint(1+ conf['{}{}'.format(i,j)]  >= sched['{}{}'.format(i,s)]+sched['{}{}'.format(j,s)])


# add objective function for minimizing conflicts
# Sum_{i<j}  conflicts[i][j]*conf['ij']
p.set_objective(sum( [ conflicts[i][j] * conf['{}{}'.format(i,j)] for i,j in pairs] ));


#p.show()
print 'Solving program',p
print 'Conflict value:',p.solve()


# Solution prinntout.... for every problem x find which of
# sched['x0'], sched['x1'], sched['x2'],... is == 1 
print 'Time slot allocation:'
v = p.get_values(sched);


problem_slot=[0]*problems

for i in range(problems):
    for s in range(slots):
        if (v['{}{}'.format(i,s)] == 1):
            problem_slot[i] = s

for slot in range(slots):
    print
    print "In slot",slot+1
    for p in range(problems):
        if problem_slot[p] == slot:
            print p
print

