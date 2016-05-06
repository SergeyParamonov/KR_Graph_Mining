% NOGOODS_BEGIN


% NOGOODS_END

pattern_len(N) :- N = #count{X:invar(X)}.
good_model :- pattern_len(2).
:- not good_model.

t_path(X,Y) :- t_edge(X,Y), invar(X), invar(Y).
t_path(X,Y) :- t_edge(X,Z), t_path(Z,Y), invar(X).

:- invar(X), invar(Y), not t_path(X,Y).

0 { invar(X) } 1 :- t_node(X).

t_edge(Y,X) :- t_edge(X,Y).
t_node(X)   :- t_edge(X,_).

#show invar/1.
