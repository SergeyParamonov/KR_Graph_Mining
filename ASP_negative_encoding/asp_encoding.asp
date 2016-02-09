%negative constraints to check not matching negative graphs

map(G,X,v1) | map(G,X,v2) | map(G,X,v3) | map(G,X,v4) :- t_node(X), negative(G).

:- negative(G), not saturated(G), map(G,X,V), map(G,Y,V), X != Y.  % we cannot map two different template nodes to the same 

map(G,X,V) :- saturated(G), t_node(X), node(G,V).

saturated(G) :- t_edge(X,Y), map(G,X,V1), map(G,Y,V2), not edge(G,V1,V2), negative(G).

negative_match(G) :- not saturated(G), negative(G).

negative_count(N) :- N = #count{G:negative_match(G)}.

:- negative_count(N), N > 1.


%positive constraints to ensure matching of the positive graphs

positive_match(G) | not_positive_match(G) :- positive(G).

1 { map(G,X,V) : node(G,V) } 1 :- positive(G), t_node(X).

:- positive_match(G), map(G,X,V1), map(G,Y,V2), t_edge(X,Y), not edge(G,V1,V2).

positive_count(N) :- N = #count{G:positive_match(G)}.

:- positive_count(N), N < 2.


%auxilary constraints


edge(G,Y,X) :- edge(G,X,Y).
t_edge(Y,X) :- t_edge(X,Y).
node(G,Y)   :- edge(G,Y,_).
t_node(X)   :- t_edge(X,_).

t_edge(x1,x2).
t_edge(x2,x3).
t_edge(x3,x1).

negative(g1).
negative(g2).
negative(g3).

positive(g4).
positive(g5).
positive(g6).


edge(g1, v1, v2). 
edge(g1, v2, v3). 
edge(g1, v3, v4). 
edge(g1, v3, v1). 
edge(g1, v2, v4). 
edge(g1, v3, v4). 

edge(g2, v1, v2). 
edge(g2, v2, v3). 
edge(g2, v3, v4). 

edge(g3, v1, v2). 
edge(g3, v1, v3). 
edge(g3, v1, v4). 

edge(g4, v1, v2). 
edge(g4, v1, v3). 
edge(g4, v1, v4). 

edge(g5, v1, v2). 
edge(g5, v2, v3). 
edge(g5, v3, v4). 
edge(g5, v3, v1). 
edge(g5, v2, v4). 
edge(g5, v3, v4). 

edge(g6, v1, v2). 
edge(g6, v2, v3). 
edge(g6, v3, v1). 

%#show map/3.
#show saturated/1.
#show negative_match/1.
#show negative_count/1.
#show positive_count/1.
#show positive_match/1.

