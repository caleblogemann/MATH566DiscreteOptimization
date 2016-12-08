def contractVertices(graph, v, w):
    if graph.get_vertex(v) != None:
        graph.set_vertex(v, graph.get_vertex(v).union(graph.get_vertex(w)))
    for x in graph.neighbors(w):
        if x != v:
            weight = graph.edge_label(w, x)
            if x not in graph.neighbors(v):
                graph.add_edge(v, x, weight)
            elif weight != None and graph.edge_label(x, v) != None:
                graph.set_edge_label(x, v, graph.edge_label(x, v) + weight)
    graph.delete_vertex(w)

    return None
