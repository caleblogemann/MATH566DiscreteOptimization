# MATH 566 - Minimum spanning tree algorithm
# Notes:
#  - pick any algorithm for minimum spanning three you like
#  - no need to optimize the running time
#

# This plots vertices as red dots and blue edges connecting them
def plot_vertices_edges(vertices, edges):
    drawing =  line([])
    for x in vertices:
        drawing = drawing + disk(x, 0.1, (0,2*pi), color='red')
    for e in edges:
        drawing =  drawing + line([vertices[e[0]], vertices[e[1]]])
    drawing.show()
       
# Generate 10 random vertices in 10x10 grid
def generate_random_vertices():
    vertices=[]
    for i in range(10):
        vertices.append((random()*10, random()*10))
    return vertices

# This is the function that you need to write
def compute_minimum_spannig_tree(vertices):
    n = len(vertices)
    edges_in_tree = [[0,1],[1,2],[5,6]]
    
    edges_in_tree = []
    vertex_components = range(n)
    
    # Write your code here please....
    return edges_in_tree
    

vertices = generate_random_vertices()
edges = compute_minimum_spannig_tree(vertices)

plot_vertices_edges(vertices, edges)
