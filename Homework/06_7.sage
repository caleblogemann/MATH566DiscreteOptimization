load('breadthFirstSearch.sage')
load('edmondsKarp.sage')
M = Matrix([[0, 3, 4, 8, 0, 0, 0, 0], [0, 0, 0, 0, 7, 0, 0, 0],
    [0, 3, 0, 0, 0, 1, 2, 0], [0, 0, 2, 0, 0, 0, 4, 0],
    [0, 0, 0, 0, 0, 5, 0, 2], [0, 0, 0, 0, 0, 0, 1, 8],
    [0, 0, 0, 0, 0, 0, 0, 6], [0, 0, 0, 0, 0, 0, 0, 0]])
G = DiGraph(M, weighted=True)
G.relabel({0:'s', 1:'a', 2:'b', 3:'c', 4:'d', 5:'e', 6:'f', 7:'t'})
s = 's'
t = 't'

flow = edmondsKarp(G, s, t)
print flow
