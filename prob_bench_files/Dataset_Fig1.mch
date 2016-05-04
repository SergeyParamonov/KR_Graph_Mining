MACHINE Dataset_Fig1
SETS
  Labels = {a}; // uncoloured
  Vertices = {x1,x2,x3,x4,x5,x6,x7,x8};
  GVertices = {g1,g2,g3,g4,g5,g6}  /* this is faster than integers */
CONSTANTS
	graphs, Template, MinMatchPOS, MaxMatchNEG, MaxPatternsToFind
DEFINITIONS
    BD(x) == (x \/ x~) // bi-directional
PROPERTIES
  /* example from Fig.1 in paper */
  graphs = [
            rec(LABEL:GVertices*{a}, 
                EDGES:BD({(g1,g2),(g2,g3),(g3,g4),(g4,g5),(g5,g6),(g6,g1),
                        (g1,g4), (g3,g6)}),SIGN:"POS"),
            rec(LABEL:GVertices*{a}, 
                EDGES:{(g1,g2),(g2,g3),(g3,g4)},SIGN:"NEG")
           ] &
    

  /*This is our given template*/
  Template = rec(LABEL:Vertices*{a},
                 EDGES:BD({(x1,x2),(x2,x3),(x3,x4),(x4,x5),(x5,x6),(x6,x1),
                           (x1,x4), (x2,x5),(x3,x6),
                           (x3,x7), (x7,x8)}))
                 
    &
    
    MinMatchPOS = 1 &
    MaxMatchNEG = 0 &
    MaxPatternsToFind = 10

END
