m = matrix([
    (0, 3, 0, 0, 0 ,2),
    (3, 0, 1, 2, 0, 2),
    (0, 1, 0, 1, 0, 0),
    (0, 2, 1, 0, 3, 1),
    (0, 0, 0, 3, 0, 1),
    (2, 2, 0, 1, 1, 0)])
graph = Graph(m, weighted=True)
graph.relabel({0:'a', 1:'b', 2:'c', 3:'d', 4:'e', 5:'f'})
gomory_hu_tree = graph.gomory_hu_tree()
gomory_hu_tree.plot(edge_labels=True, layout='tree').show()
