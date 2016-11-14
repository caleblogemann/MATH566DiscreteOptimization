def minimumMeanCostCycle(graph):
    n = graph.order()
    p = {v:[None]*(n+1) for v in graph.vertices()}
    F = {v:[0]+[oo]*n for v in graph.vertices()}
    for k in range(1,n+1):
        for e in graph.edges():
            u = e[0]
            v = e[1]
            c = e[2]
            if F[v][k] > F[u][k-1] + c:
                F[v][k] = F[u][k-1] + c
                p[v][k] = u

    # If all are infinite then min will be infinite
    if min([F[v][n] for v in graph.vertices()]) == oo:
        print 'This graph is acyclic'
        return (None, None)

    m = {v:oo for v in graph.vertices()}
    for v in graph.vertices():
        if F[v][n] != oo:
            m[v] = max([(F[v][n] - F[v][k])/(n-k) for k in range(n)])

    x = min(m, key=m.get)
    mu = m[x]

    # create cycle
    cycle = DiGraph([graph.vertices(), []])
    v = x
    for k in range(n):
        u = v
        v = p[v][n - k]
        cycle.add_edge(v, u, graph.edge_label(v, u))

    return (cycle, mu)
