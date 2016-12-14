# MATH 566 - Implement Minimum Mean Cycle
#
# Implement Minimum Mean Cycle algorithm and use it on few test cases
#
# It might be useful to look at the following links when looking for
# help with dealing with directed graphs
#
# http://doc.sagemath.org/html/en/reference/graphs/sage/graphs/generic_graph.html
# http://doc.sagemath.org/html/en/reference/graphs/sage/graphs/digraph.html
#

# For a directed graph G find a Minimum Mean Cycle. Returns
# a subgraph corresponding to the cycle and mu.
#
def MeanCostCycle(G):
    # number of vertices
    n = G.order() 

    # This will serve as a copy, where we return only edges of the smallest
    # cycle, or we return empty graph if no cycle found
    min_mean_cycle = copy(G)
    min_mean_cycle.delete_edges(G.edge_iterator())
    
    # Prepare matrix to store Fk
    Fk = [dict() for x in range(n+1)]
    for k in range(n+1):
        for v in G:
            if k == 0:
                Fk[k][v] = 0
            else:
                Fk[k][v] = Infinity

    # Might be usefull to look at Fk if you are trying to implement the algorithm
    # print Fk

    # prepare storage for Pk
    Pk = [dict() for x in range(n+1)]
    
    # compute all Fk (and Pk)
    # TODO

    
    # test if Fk[n] contains all infinities 
    # TODO

        
    # if Fk[n-1] does not contain all infinities get the minium mean cycle
    # TODO
        
    # Return graph that is a subgraph of G, contains only edges of
    # the Minimum Mean Cycle and also return mu 
    return [min_mean_cycle, mu]


# creating a directed graph graph
# the third number is edge label, in our case we use it as
# a cost of the edge
# Try all 3 test cases

g = DiGraph([(1,2,1), (2,3,2), (3,4,-1), (4,1,1), (4,2,2) ])
g.show(edge_labels=True)
[cycle,mu] =  MeanCostCycle(g)
print "Mu=",mu
cycle.show(edge_labels=True)


g = DiGraph([(1,2,3), (1,3,2), (2,4,-1), (3,4,1), (4,5,0), (5,6,1), (5,7,2), (6,8,1), (7,8,3), (8,1,2) ])
g.show(edge_labels=True)
[cycle,mu] =  MeanCostCycle(g)
print "Mu=",mu
cycle.show(edge_labels=True)


g = DiGraph([(1,2,1), (2,3,1), (3,4,1), (1,4,1), (4,5,2) ])
g.show(edge_labels=True)
[cycle,mu] =  MeanCostCycle(g)
print "Mu=",mu
cycle.show(edge_labels=True)
