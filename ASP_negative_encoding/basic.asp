% No-goods
:- invar(x1), invar(x2).

not_empty :- invar(X).
:- not not_empty.

% Standard Representation

%positive constraints to ensure matching of the positive graphs

positive_match(G) | not_positive_match(G) :- positive(G).

1 { map(G,X,V) : node(G,V) } 1 :- positive(G), invar(X).

:- positive_match(G), map(G,X,V1), map(G,Y,V2), t_edge(X,Y), not edge(G,V1,V2), invar(X), invar(Y).

positive_count(N) :- N = #count{G:positive_match(G)}.

:- positive_count(N), N < 2.

% selects subpattern

t_path(X,Y) :- t_edge(X,Y), invar(X), invar(Y).
t_path(X,Y) :- t_edge(X,Z), t_path(Z,Y), invar(X).

:- invar(X), invar(Y), not t_path(X,Y).

0 { invar(X) } 1 :- t_node(X).


%auxilary constraints


edge(G,Y,X) :- edge(G,X,Y).
t_edge(Y,X) :- t_edge(X,Y).
node(G,Y)   :- edge(G,Y,_).
t_node(X)   :- t_edge(X,_).

t_edge(x1,x2).
t_edge(x2,x3).
t_edge(x3,x1).
t_edge(x4,x1).
t_edge(x4,x2).

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
#show invar/1.
