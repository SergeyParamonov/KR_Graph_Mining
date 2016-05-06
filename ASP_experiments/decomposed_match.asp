1 { map(X,V) : node(V) } 1 :- invar(X).

:- map(X,V), map(Y,V), X != Y.

:- map(X,V1), map(Y,V2), t_edge(X,Y), not edge(V1,V2), invar(X), invar(Y).
:- map(X,V),  t_label(X,L), not label(V,L), invar(X).

node(Y)   :- edge(Y,_).
edge(Y,X) :- edge(X,Y).

t_edge(Y,X) :- t_edge(X,Y).
t_node(X)   :- t_edge(X,_).
