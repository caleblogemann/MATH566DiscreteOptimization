def edmondsBlossom(graph):
    matching = set()
    path = find_augmenting_path(graph, matching)
    while path != None:
        matching = augment_on_path(graph, matching, path)
        path = find_augmenting_path(graph, matching)
    return matching

def find_augmenting_path(graph, matching):
    forest = Graph()
    covered_vertices = set([e[0] for e in matching] + [e[1] for e in matching])
    # exposed vertices
    nodes_to_check = list(set(graph.vertices()) - covered_vertices)
    forest.add_vertices(nodes_to_check)
    node_to_root = {v:v for v in nodes_to_check}
    marked_edges = matching.copy()
    for v in nodes_to_check:
        unmarked_incident_edges = set(graph.edges_incident(v)) - marked_edges
        for e in unmarked_incident_edges:
            if e[0] == v:
                w = e[1]
            else:
                w = e[0]

            if w not in forest.vertices():
                # grow forest
                matched_edge_w = [edge for edge in matching if w in edge][0]
                if matched_edge_w[0] == w:
                    x = matched_edge_w[1]
                else:
                    x = matched_edge_w[0]

                forest.add_vertices([w, x])
                forest.add_edges([e, matched_edge_w])
                nodes_to_check.append(x)
                node_to_root[w] = node_to_root[v]
                node_to_root[x] = node_to_root[v]

            else:
                if forest.distance(w,node_to_root[w]) % 2 == 0:
                    if node_to_root[v] != node_to_root[w]:
                        # found augmenting path
                        path1 = forest.shortest_path(node_to_root[v], v)
                        path2 = forest.shortest_path(w, node_to_root[w])
                        path = path1 + path2
                    else:
                        # blossom
                        path = contract_blossom(graph, matching, forest, v, w)
                    return path
            marked_edges.add(e)
    return None

def augment_on_path(graph, matching, path):
    edges = {(path[i],path[i+1],graph.edge_label(path[i],path[i+1])) for i in range(len(path)-1)}

    for e in edges:
        if e in matching:
            matching.remove(e)
        elif (e[1], e[0], e[2]) in matching:
            matching.remove((e[1], e[0], e[2]))
        else:
            matching.add(e)
    return matching

def contract_blossom(graph, matching, forest, v, w):
    blossom = forest.shortest_path(v,w)
    matched_edges_in_blossom = set()
    for e in matching:
        if e[0] in blossom and e[1] in blossom:
            matched_edges_in_blossom.add(e)
    base_vertex = list(set(blossom) - set([e[0] for e in matched_edges_in_blossom] + [e[1] for e in matched_edges_in_blossom]))[0]
    #print base_vertex
    contracted_graph = graph.copy()
    for x in blossom:
        if x != base_vertex:
            contractVertices(contracted_graph, base_vertex, x)
    contracted_matching = set()
    for e in matching:
        if e[0] in blossom and e[1] not in blossom:
            contracted_matching.add((base_vertex, e[1], e[2]))
        elif e[1] in blossom and e[0] not in blossom:
            contracted_matching.add((e[0], base_vertex, e[2]))
        elif e[0] not in blossom and e[1] not in blossom:
            contracted_matching.add(e)
    #contracted_graph.plot().show()
    path = find_augmenting_path(contracted_graph, contracted_matching)
    if path != None and base_vertex in path:
        i = path.index(base_vertex)
        path1 = path[:i]
        path2 = path[i+1:]
        # need alternating path from base_vertex to path2[0]
        for x in blossom:
            if path2[0] in graph.neighbors(x):
                starting_vertex = x

        blossom_path = [starting_vertex]
        while blossom_path[-1] != base_vertex:
            matched_edge = [edge for edge in matching if blossom_path[-1] in edge][0]
            # add vertex incident with matched edge
            if matched_edge[0] == blossom_path[-1]:
                blossom_path.append(matched_edge[1])
            else:
                blossom_path.append(matched_edge[0])

            # add next vertex in blossom
            j = blossom.index(blossom_path[-1])
            if j == 0:
                jminus = len(blossom) - 1
            else:
                jminus = j - 1

            if j== len(blossom)-1:
                jplus = 0
            else:
                jplus = j + 1

            if blossom[jminus] == blossom_path[-2]:
                blossom_path.append(blossom[jplus])
            else:
                blossom_path.append(blossom[jminus])
        blossom_path.reverse()
        path = path1 + blossom_path + path2
    return path
