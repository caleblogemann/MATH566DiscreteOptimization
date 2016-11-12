load('minimumMeanCostCycle.sage')
g = DiGraph([(1,2,1), (2,3,2), (3,4,-1), (4,1,1), (4,2,2) ])
g.show(edge_labels=True)
(cycle,mu) = minimumMeanCostCycle(g)
if cycle != None:
    print "Mu=",mu
    cycle.show(edge_labels=True)


g = DiGraph([(1,2,3), (1,3,2), (2,4,-1), (3,4,1), (4,5,0), (5,6,1), (5,7,2), (6,8,1), (7,8,3), (8,1,2) ])
g.show(edge_labels=True)
(cycle,mu) = minimumMeanCostCycle(g)
if cycle != None:
    print "Mu=",mu
    cycle.show(edge_labels=True)


g = DiGraph([(1,2,1), (2,3,1), (3,4,1), (1,4,1), (4,5,2) ])
g.show(edge_labels=True)
(cycle,mu) = minimumMeanCostCycle(g)
if cycle != None:
    print "Mu=",mu
    cycle.show(edge_labels=True)
