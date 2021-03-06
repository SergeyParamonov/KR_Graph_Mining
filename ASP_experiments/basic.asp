% NOGOODS_BEGIN


% NOGOODS_END


% pattern len constraint
pattern_len(N) :- N = #count{X:invar(X)}.
good_model :- pattern_len(2).
:- not good_model.


% Standard Representation

%positive constraints to ensure matching of the positive graphs

0 { positive_match(G) } 1 :- graph(G).

1 { map(G,X,V) : node(G,V) } 1 :- graph(G), invar(X).

:- used_map(G,X,V), used_map(G,Y,V), X != Y.

:- used_map(G,X,V1), used_map(G,Y,V2), t_edge(X,Y), not edge(G,V1,V2), invar(X), invar(Y).
:- used_map(G,X,V),  t_label(X,L), not label(G,V,L), invar(X).

positive_count(N) :- N = #count{G:positive_match(G)}.

used_map(G,X,V) :- positive_match(G), map(G,X,V).

:- positive_count(N), N < TO_REPLACE_WITH_VALUE.

% selects subpattern

t_path(X,Y) :- t_edge(X,Y), invar(X), invar(Y).
t_path(X,Y) :- t_edge(X,Z), t_path(Z,Y), invar(X).

:- invar(X), invar(Y), not t_path(X,Y).

0 { invar(X) } 1 :- t_node(X).


%auxilary constraints

edge(G,Y,X) :- edge(G,X,Y).
node(G,Y)   :- edge(G,Y,_).
t_edge(Y,X) :- t_edge(X,Y).
t_node(X)   :- t_edge(X,_).

#show invar/1.
#show positive_match/1.
#show positive_count/1.
#show used_map/3.
