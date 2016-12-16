def dijkstras(graph, source):
    reached = set()
    vertexSet = set(graph.vertices())
    length = {v:Infinity for v in vertexSet}
    length[source] = graph.get_vertex(source)
    parent = {v:None for v in vertexSet}
    while reached != vertexSet:
        v = min(vertexSet - reached, key=lambda v:length[v])
        reached.add(v)
        for w in graph.neighbors(v):
            d = length[v] + graph.edge_label(v, w) + graph.get_vertex(w)
            if d < length[w]:
                length[w] = d
                parent[w] = v

    return (length, parent)
