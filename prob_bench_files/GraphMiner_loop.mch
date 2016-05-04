MACHINE GraphMiner
// A version where we add the patterns one at a time
// you can use different datasets by changing the INCLUDES section
// This version requires ProB 1.6.0 maybe even 1.6.1-beta to parse LET and IF-THEN-ELSE predicates
INCLUDES
  Dataset_Enum // we find 6 graphs in under a second
  //MutaDataset // currently finds 6 graphs; cannot yet deal with negative examples : TO DO : investigate why


DEFINITIONS

  SET_PREF_TIME_OUT == 70000; SET_PREF_MAX_INITIALISATIONS == 2; SET_PREF_MAX_OPERATIONS == 1; 
  CUSTOM_GRAPH_EDGES == UNION(p).(p:Patterns|p'EDGES);
  CUSTOM_GRAPH_NODES == Vertices; // dom(pattern'EDGES) \/ ran(pattern'EDGES);

  /* The (most general, i.e. ternary) definition of homomorphism. Note ' is the property accessor for records*/
  homomorph_with(FromGraph, iso, ToGraph) == (
    iso : vertices(FromGraph'EDGES) >-> vertices(ToGraph'EDGES) &
    !x.( x:vertices(FromGraph'EDGES) => FromGraph'LABEL(x) = ToGraph'LABEL(iso(x))) &
    // derived constraint for efficiency:
    // !l.(l:ran(ToGraph'LABEL) => card({x|x:Vertices & x|->l : FromGraph'LABEL}) = card({y|y|->l:ToGraph'LABEL})) &
    
    !(x,y).( x|->y : FromGraph'EDGES
         => iso(x)|->iso(y) : ToGraph'EDGES) 
    // does not seem to gain anyting:
    //& !(x,y).( x:dom(ToGraph'LABEL) & y:dom(ToGraph'LABEL) & x|->y /: ToGraph'EDGES 
     //    => !(v,w).(v|->x:iso & w|->y:iso => v|->w /: FromGraph'EDGES))
  );

  /* The (most general, i.e. ternary) definition of isomorphism*/
  isomorphic1(FirstGraph, iso, SecondGraph) == (  
    LET V1,V2 BE
      V1 = vertices(FirstGraph'EDGES) &
      V2 = vertices(SecondGraph'EDGES) 
    IN
		iso : V1 >->> V2 &
		!x.( x:V1 => FirstGraph'LABEL(x) = SecondGraph'LABEL(iso(x))) &
	
		// derived constraint for efficiency:
		//!l.(l:ran(SecondGraph'LABEL) => card({x|x|->l : FirstGraph'LABEL}) = card({y|y:Vertices & y|->l:SecondGraph'LABEL})) &
	
		!(x,y).( x|->y: FirstGraph'EDGES
			=> iso(x)|->iso(y) : SecondGraph'EDGES) &
		!(x,y).( x|->y: SecondGraph'EDGES
			=> iso~(x)|->iso~(y) : FirstGraph'EDGES)
    END
  );
  
  vertices(EdgeRelation) == (dom(EdgeRelation)  \/ ran(EdgeRelation));
  
  ValidPattern(pat) == (
       pat : (struct(LABEL:Vertices-->Labels, EDGES:Vertices<->Vertices)) &
       pat'EDGES <: Template'EDGES &
       pat'LABEL = Template'LABEL & // we fix the labeling
        IF MinMatchPOS=1 THEN
          #p.(p:ran(graphs) & p'SIGN="POS" & #isop.(homomorph_with(pat, isop, p))) 
        ELSE 
       
          // maybe what we need is to reify existential quantifier #isop to be able to reify card
          card({p|p:ran(graphs) & p'SIGN="POS" & #isop.(homomorph_with(pat, isop, p))}) >= MinMatchPOS
        END 
      &
        IF MaxMatchNEG=0 THEN
          not(#p.(p:ran(graphs) & p'SIGN="NEG" & #isop.(homomorph_with(pat, isop, p))))
        ELSE
          card({p|p:ran(graphs) & p'SIGN="NEG" & #isop.(homomorph_with(pat, isop, p))}) <= MaxMatchNEG
        END
     )

VARIABLES
  Patterns
INVARIANT
  Patterns <: (struct(LABEL:Vertices-->Labels, EDGES:Vertices<->Vertices))
INITIALISATION
  //Patterns := {rec(LABEL:{(x1,a),(x2,b),(x3,a),(x4,a),(x5,a),(x6,a),(x7,a),(x8,a)}, EDGES:{(x1,x2),(x2,x3)})}
  Patterns := {}
OPERATIONS
   AddNewPattern(n,pat) = SELECT n=1+card(Patterns) & n<=6 & 
                                 ValidPattern(pat) &
                                !(p1).(p1:Patterns =>
                                      (p1 /= pat
                                         & not (#iso.(isomorphic1(p1, iso, pat)))
                                      ))
                        THEN
        Patterns := Patterns \/ {pat}
   END
END
