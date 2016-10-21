
# This file was *autogenerated* from the file 06_7.sage
from sage.all_cmdline import *   # import sage library

_sage_const_3 = Integer(3); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_7 = Integer(7); _sage_const_6 = Integer(6); _sage_const_5 = Integer(5); _sage_const_4 = Integer(4); _sage_const_8 = Integer(8)
load('breadthFirstSearch.sage')
load('edmondsKarp.sage')
M = Matrix([[_sage_const_0 , _sage_const_3 , _sage_const_4 , _sage_const_8 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 ], [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_7 , _sage_const_0 , _sage_const_0 , _sage_const_0 ],
    [_sage_const_0 , _sage_const_3 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_2 , _sage_const_0 ], [_sage_const_0 , _sage_const_0 , _sage_const_2 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_4 , _sage_const_0 ],
    [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_5 , _sage_const_0 , _sage_const_2 ], [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_1 , _sage_const_8 ],
    [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_6 ], [_sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 , _sage_const_0 ]])
G = DiGraph(M, weighted=True)
s = _sage_const_0 
t = _sage_const_7 

flow = edmondsKarp(G, s, t)
print flow

