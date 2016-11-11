M = matrix([
    (0, 5, 2, 0, 3, 0, 0, 0),
    (5, 0, 3, 0, 0, 0, 0, 0),
    (2, 3, 0, 4, 0, 0, 0, 2),
    (0, 0, 4, 0, 3, 0, 2, 1),
    (3, 0, 0, 3, 0, 2, 0, 0),
    (0, 0, 0, 0, 2, 0, 6, 0),
    (0, 0, 0, 2, 0, 6, 0, 5),
    (0, 0, 2, 1, 0, 0, 5, 0)])
graph = Graph(M, weighted=True)
graph.relabel(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'])
load('nodeIdentification.sage')
load('contractVertices.sage')
s = nodeIdentification(graph)
minimum_cut = s[0]
minimum_cut_value = s[1]
print("minimum cut: " + str(minimum_cut))
print("minimum cut value: " + str(minimum_cut_value))
