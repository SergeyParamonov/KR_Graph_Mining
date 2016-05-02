t_edge(Y,X) :- t_edge(X,Y).
node(X)     :- t_edge(X,_).

1 { map(X,V) : node(V) } 1 :- solution(X).

:- map(X,V), map(Y,V), X != Y.

:-     t_edge(X,Y), map(X,V), map(Y,W), not t_edge(V,W).
:- not t_edge(X,Y), map(X,V), map(Y,W),     t_edge(V,W).

#show map/2.
