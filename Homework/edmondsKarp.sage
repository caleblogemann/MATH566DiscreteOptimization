def edmondsKarp(G, s, t):
    # Find mazimal flow on G from vertex s to vertex t
    # G weighted digraph - weights represent capacities
    # s - starting/source vertex
    # t - ending/target vertex

    # uses dictionary to store flow
    # if e is edge in G, then f[e] is flow on e
    # intialize all to have 0 flow
    f = {e:0 for e in G.edges()}

    

    return f
