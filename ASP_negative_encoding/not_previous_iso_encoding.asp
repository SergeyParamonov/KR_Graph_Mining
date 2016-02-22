% Saturated Representation

%negative constraints to check not matching negative graphs

map(G,X,v1) | map(G,X,v2) | map(G,X,v3) | map(G,X,v4) :- invar(X), negative(G).

map(G,X,V) :- saturated(G), t_node(X), node(G,V).

saturated(G) :- t_edge(X,Y), map(G,X,V1), map(G,Y,V2), not edge(G,V1,V2), negative(G), invar(X), invar(Y).
saturated(G) :- map(G,X,V),  map(G,Y,V), X != Y, invar(X), invar(Y). % we cannot map two different template nodes to the same 

negative_match(G) :- not saturated(G), negative(G).

negative_count(N) :- N = #count{G:negative_match(G)}.

:- negative_count(N), N > 1.


% Standard Representation

%positive constraints to ensure matching of the positive graphs

positive_match(G) | not_positive_match(G) :- positive(G).

1 { map(G,X,V) : node(G,V) } 1 :- positive(G), invar(X).

:- positive_match(G), map(G,X,V1), map(G,Y,V2), t_edge(X,Y), not edge(G,V1,V2), invar(X), invar(Y).

positive_count(N) :- N = #count{G:positive_match(G)}.

:- positive_count(N), N < 2.

% Canonicity check, template based

iso(s1,X,x1) | iso(s1,X,x2) :- invar(X).
iso(s2,X,x2) | iso(s2,X,x3) :- invar(X).

candidate_var(G,X) :- iso(G,_,X).

iso_saturated(G) :- invar(X1), invar(X2), iso(G,X1,V1), iso(G,X2,V2),     t_edge(V1,V2), not t_edge(X1,X2). 
iso_saturated(G) :- invar(X1), invar(X2), iso(G,X1,V1), iso(G,X2,V2), not t_edge(V1,V2),     t_edge(X1,X2). 
iso_saturatea(G) :- not equal(G), iso(G,_,_). 

iso(G,X,V) :- invar(X), t_node(V), iso_saturated(G).

:- not iso_saturated(G), iso(G,_,_).

d1(G,X) :-     invar(X), not candidate_var(G,X), iso(G,_,_).
d2(G,X) :- not invar(X),     candidate_var(G,X).

not_equal(G) :- d1(G,X). % check that in fact candidate is different from the pattern itself
not_equal(G) :- d2(G,X). % check that in fact candidate is different from the pattern itself

equal(G) :- not not_equal(G), iso(G,_,_).


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
#show invar/1.
#show candidate_var/2.
#show d1/2.
#show d2/2.
#show iso_saturated/1.
#show iso/3.
