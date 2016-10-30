def nodeIdentification(original_graph):
    # original graph is a Sage graph object that is undirected and whose
    # edge_labels are the weights
    graph = original_graph.copy()
    graph.set_vertices(dict((v, {v}) for v in graph.vertices()))
    minimum_cut = None
    minimum_cut_value = None
    while graph.order() > 1:
        legal_ordering = findLegalOrdering(graph)
        cut = graph.get_vertex(legal_ordering[-1])
        cut_value = 0
        for edge in original_graph.edges():
            if edge[0] in cut and edge[1] not in cut:
                cut_value += edge[2]
            elif edge[1] in cut and edge[0] not in cut:
                cut_value += edge[2]

        if cut_value < minimum_cut_value or minimum_cut_value == None:
            minimum_cut = cut
            minimum_cut_value = cut_value

        contractVertices(graph, legal_ordering[-1], legal_ordering[-2])

    return (minimum_cut, minimum_cut_value)

def findLegalOrdering(graph):
    vertices = graph.vertices()
    legal_ordering = [vertices[0]]
    vertices_remaining = vertices[1:]
    for i in range(len(vertices_remaining)):
        max_capacity = None
        max_capacity_vertex = None
        for v in vertices_remaining:
            capacity = 0
            for w in legal_ordering:
                if v in graph.neighbors(w):
                    capacity += graph.edge_label(v, w)

            if capacity > max_capacity or max_capacity == None:
                max_capacity = capacity
                max_capacity_vertex = v

        legal_ordering.append(max_capacity_vertex)

    return legal_ordering

