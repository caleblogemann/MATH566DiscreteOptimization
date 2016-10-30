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

        cut = graph.get_vertices().values()[1]
        cut_value = 0
        for edge in original_graph.edges():
            if edge[0] in cut and edge[1] not in cut:
                cut_value += edge[2]
            elif edge[1] in cut and edge[0] not in cut:
                cut_value += edge[2]

        if cut_value < minimum_cut_value or minimum_cut_value == None:
            minimum_cut = cut
            minimum_cut_value = cut_value

    return (minimum_cut, minimum_cut_value)

def contractVertices(graph, v, w):
    graph.set_vertex(v, graph.get_vertex(v).union(graph.get_vertex(w)))
    for x in graph.neighbors(w):
        if x != v:
            weight = graph.edge_label(w, x)
            if x in graph.neighbors(v):
                graph.set_edge_label(x, v, graph.edge_label(x, v) + weight)
            else:
                graph.add_edge(v, x, weight)

    graph.delete_vertex(w)

    return None

