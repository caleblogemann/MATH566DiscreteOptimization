# https://wiki.sagemath.org/quickref?action=AttachFile&do=get&target=quickref-linalg.pdf

# I also suggest to google itertools.combinations
#
# This HW is about writing a program that solves linear programming problems where
# the input is A,b,c and you want to find x >= 0 that minimizes c^Tx if Ax = b.
#
# You should write a solver that enumerates all basic feasible solutions and picks
# the best one. Recall that you get a basic feasible solution by picking m columns
# of A that are linearly independent and solve for x.
#
# The same is also implemented using sage solver so you can check if your program
# produced the correct result.
#
import itertools as it

# This is where you will write your program
def solve_linear_program(A,b,c):
    m = len(b)
    n = len(c)
    if A.nrows() != m or A.ncols() != n or m > n:
        print "Invalid input"
        return [None,None]

    min_value = None
    min_x     = None

    # get all possible combinations of columns
    combinations = list(it.combinations(range(n), m))
    for v in combinations:
        # vector of zeroes
        x = vector(QQ, n)
        # solve subsystem
        if A[:,v].is_invertible():
            u = A[:,v]\b
            # use constraint that all variables must be nonnegative
            if min(u) >= 0:
                # put nonzero values into zeros vector
                for i in range(m):
                    x[v[i]] = u[i]
                # calculate value of objective function
                value = c.dot_product(x)
                # test if better than previous minimum value
                if value < min_value or min_value == None:
                    min_value = value
                    min_x = x

    return [min_value,min_x]

# This is solver using sage
def solve_using_sage(A,b,c):
    m = len(b)
    n = len(c)
    p = MixedIntegerLinearProgram(maximization=False);
    x = p.new_variable(nonnegative=True);
    for i in range(m):
        p.add_constraint( b[i] == sum([A[i,j]*x[j] for j in range(n)]) )
    p.set_objective(sum( [ c[j]*x[j] for j in range(n)] ))
    return p.solve()

# This is running your and also sage solver and prints the results
def test_solver(A,b,c):
    min_value, min_x = solve_linear_program(A,b,c)
    min_value_sage = solve_using_sage(A,b,c)
    print "Optimal solution has value", min_value_sage," You computed",min_value," for x=",min_x

######### Several test data

# Input
A = matrix(QQ,[[1,0,1,0,0],[1,1,0,1,0],[-1,1,0,0,1]])
b = vector(QQ,[4,5,1])
c = vector(QQ,[-1,-2,0,0,0])

test_solver(A,b,c)


# Input
A = matrix(QQ,[[1,-2,1,0,0],[1,1,0,1,0],[-1,1,0,0,1]])
b = vector(QQ,[4,2,4])
c = vector(QQ,[-1,2,0,0,0])

test_solver(A,b,c)


# Input
A = matrix(QQ,[[1,-2,6,6,1,1,0,0],[1,1,2,2,-2,0,1,0],[-1,1,3,3,6,0,0,1]])
b = vector(QQ,[4,2,5])
c = vector(QQ,[-1,2,-2,-2,1,0,0,0])

test_solver(A,b,c)
