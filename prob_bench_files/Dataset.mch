MACHINE Dataset
SETS
  Labels = {a,b,c,d,e,f,g,k};
  Vertices = {x1,x2,x3,x4,x5,x6,x7,x8}
CONSTANTS
	graphs, Template, MinMatchPOS, MaxMatchNEG, MaxPatternsToFind
PROPERTIES
  /*graphs : {struct(LABEL:node+->Labels, EDGES:node<->node),SIGN:sign} &*/ /*DOM:{node}*/
  graphs = [
            rec(LABEL:{(1,a),(2,a),(3,b),(4,a),(5,a),(6,a),(7,a),(8,a)}, EDGES:{(1,2),(2,3),(3,4)},SIGN:"POS"),
            rec(LABEL:{(1,a),(2,a),(3,a),(4,a),(5,a),(6,a),(7,a),(8,a)}, EDGES:{(1,2),(2,3),(3,4)},SIGN:"POS")
           ] &
    

  /*This is our given template*/
  Template = rec(LABEL:{(x1,a),(x2,a),(x3,b),(x4,a),(x5,a),(x6,a),(x7,a),(x8,a)},
                 EDGES:{(x1,x2),(x2,x3),(x3,x4),(x4,x5),(x5,x6),(x6,x7),(x7,x8)})
                 
    &
    
    MinMatchPOS = 1 &
    MaxMatchNEG = 0 &
    MaxPatternsToFind = 6

END
