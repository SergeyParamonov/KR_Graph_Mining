t_edge(Y,X) :- t_edge(X,Y).
node(X)     :- t_edge(X,_).

1 { map(X,V) : node(V) } 1 :- solution(X).

:- map(X,V), map(Y,V), X != Y.

:-     t_edge(X,Y), map(X,V), map(Y,W), not t_edge(V,W).
:- not t_edge(X,Y), map(X,V), map(Y,W),     t_edge(V,W).

:-  map(X,V), t_label(X,L), not t_label(V,L).

#show map/2.
