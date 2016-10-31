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
