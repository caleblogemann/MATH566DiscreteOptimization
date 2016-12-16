load('travelingSalesman.sage')

pointList = [[0,0], [9,0], [1,1], [8,1], [0,2], [9,2], [4,3], [5,3], \
             [0,4], [1,4], [2,4], [3,4], [6,4], [7,4], [8,4], [9,4], \
             [0,5], [1,5], [3,5], [2,5], [6,5], [7,5], [8,5], [9,5], \
             [4,6], [5,6], [0,7], [9,7], [1,8], [8,8], [0,9], [9,9]]


cycle, total_distance = nearestNeighbor(pointList)
print 'Nearest Neighbor'
print('Distance: %s' % total_distance)
plotCycle(cycle)

cycle, total_distance = cheapestInsertion(pointList)
print 'Cheapest Insertion'
print('Distance: %s' % total_distance)
plotCycle(cycle)

cycle, total_distance = furthestInsertion(pointList)
print 'Furthest Insertion'
print('Distance: %s' % total_distance)
plotCycle(cycle)

LB = lowerBound(pointList)
print('Lower Bound: %s' % LB)
