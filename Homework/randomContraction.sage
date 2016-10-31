import numpy as np
def randomContraction(original_graph, numTrials):
    # original graph is a Sage graph object that is undirected and whose
    # edge_labels are the weights
    # numTrials is the number of times the random contraction algorithm should
    # be run before returning the minimum cut found
    minimum_cut = None
    minimum_cut_value = None
    for i in range(numTrials):
        graph = original_graph.copy()
        graph.set_vertices(dict((v, {v}) for v in graph.vertices()))
        while graph.order() > 2:
            total_weight = sum(graph.edge_labels())
            probabilities = [e/total_weight for e in graph.edge_labels()]
            edgeNum = np.random.choice(graph.size(), p=probabilities)
            edge = graph.edges()[edgeNum]

            # contract found edge
            v = edge[0]
            w = edge[1]
            contractVertices(graph, v, w)

        cut = graph.get_vertices().values()[0]
        vertices = graph.vertices()
        cut_value = graph.edge_label(vertices[0], vertices[1])

        if cut_value < minimum_cut_value or minimum_cut_value == None:
            minimum_cut = cut
            minimum_cut_value = cut_value

    return (minimum_cut, minimum_cut_value)
