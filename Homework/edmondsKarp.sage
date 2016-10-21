def edmondsKarp(G, s, t):
    # Find mazimal flow on G from vertex s to vertex t
    # G weighted digraph - weights represent capacities
    # s - starting/source vertex
    # t - ending/target vertex

    # create residual graph as copy of original graph
    RG = G.copy()
    for e in G.edges():
        RG.add_edge(e[1], e[0], 0)

    path = shortestPath(RG, s, t)
    while path != None:
        path.reverse()
        print path
        min_capacity = min({e[2] for e in path})
        # augment flow
        for edge in path:
            RG.add_edge(edge[0], edge[1], edge[2] - min_capacity)
            RG.add_edge(edge[1], edge[0], RG.edge_label(edge[1], edge[0]) + min_capacity)
        path = shortestPath(RG, s, t)

    # uses dictionary to store flow
    # if e is edge in G, then f[e] is flow on e
    # intialize all to have 0 flow
    flow = dict()
    for edge in G.edges():
        flow[edge] = RG.edge_label(edge[1], edge[0])

    return flow

def shortestPath(RG, source, target):
    # G is a graph
    # find the shortest path, P, from s to t or return None
    # shortest path in terms of least number of edges

    path = None
    # remove edges with 0 weight
    G = RG.copy()
    for edge in RG.edges():
        if edge[2] == 0:
            G.delete_edge(edge)
    tree = breadthFirstSearch(G, source)
    if tree.neighbors_in(target):
        path = []
        current_vertex = target
        while tree.neighbors_in(current_vertex):
            edge = tree.incoming_edges(current_vertex)[0]
            path.append(edge)
            current_vertex = edge[0]
    return path
