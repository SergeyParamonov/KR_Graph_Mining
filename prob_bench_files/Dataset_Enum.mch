MACHINE Dataset_Enum
SETS
  Labels = {a,b,c,d,e,f,g,k};
  Vertices = {x1,x2,x3,x4,x5,x6,x7,x8};
  GVertices = {g1,g2,g3,g4,g5,g6,g7,g8}  /* this is faster than integers */
CONSTANTS
	graphs, Template, MinMatchPOS, MaxMatchNEG
PROPERTIES
  /*graphs : {struct(LABEL:node+->Labels, EDGES:node<->node),SIGN:sign} &*/ /*DOM:{node}*/
  graphs = [
            rec(LABEL:{(g1,a),(g2,a),(g3,b),(g4,a),(g5,a),(g6,a),(g7,a),(g8,a)}, 
                EDGES:{(g1,g2),(g2,g3),(g3,g4)},SIGN:"POS"),
            rec(LABEL:{(g1,a),(g2,a),(g3,a),(g4,a),(g5,a),(g6,a),(g7,a),(g8,a)}, 
                EDGES:{(g1,g2),(g2,g3),(g3,g4)},SIGN:"POS")
           ] &
    

  /*This is our given template*/
  Template = rec(LABEL:{(x1,a),(x2,a),(x3,b),(x4,a),(x5,a),(x6,a),(x7,a),(x8,a)},
                 EDGES:{(x1,x2),(x2,x3),(x3,x4),(x4,x5),(x5,x6),(x6,x7),(x7,x8)})
                 
    &
    
    MinMatchPOS = 1 &
    MaxMatchNEG = 0

END
