def edmondsBlossom(graph):
    matching = set()
    path = find_augmenting_path()
    while path != None:
        matching = augment_on_path(matching, path)
        path = find_augmenting_path()

    return matching

def find_augmenting_path(graph, matching):
    forest = graph()
    covered_vertices = set([e[0] for e in matching] + [e[1] for e in matching])
    # exposed vertices
    nodes_to_check = list(set(graph.vertices()) - covered_vertices)
    forest.add_vertices(nodes_to_check)
    node_to_root = {v:v for v in nodes_check}
    marked_edges = matching
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
                node_to_root[w] = v
                node_to_root[x] = v
            else:
                if forest.distance(w,node_to_root(w)) % 2 == 0:
                    if node_to_root(v) != node_to_root(w):
                        # found augmenting path
                        path1 = forest.shortest_path(node_to_root(v), v)
                        path2 = forest.shortest_path(w, node_to_root(w))
                        path = path1 + path2
                    else:
                        # blossom
                        path = contract_blossom(graph, matching, forest, v, w)


                    return path
                else:
                    # odd length do nothing
            marked_edges.add(e)
    return None

def augment_on_path():

    return matching

def contract_blossom(graph, matching, forest, v, w):

    blossom = forest.shortest_path(v,w)
    path = find_augmenting_path(contracted_graph, contracted_matching)

    return path

