% NOGOODS_BEGIN







 :- invar(10),invar(11),invar(12),invar(13),invar(18),invar(14),invar(15),invar(16).
 :- invar(10),invar(11),invar(12),invar(13),invar(18),invar(14),invar(15),invar(17).

 :- invar(10),invar(11),invar(12),invar(13),invar(14),invar(15),invar(16),invar(17).
 :- invar(10),invar(11),invar(12),invar(13),invar(14),invar(15),invar(16),invar(17).

 :- invar(9),invar(7),invar(8),invar(10),invar(11),invar(12),invar(13),invar(18).
 :- invar(1),invar(9),invar(5),invar(10),invar(11),invar(12),invar(13),invar(18).
 :- invar(1),invar(9),invar(2),invar(10),invar(11),invar(12),invar(13),invar(18).

 :- invar(11),invar(12),invar(13),invar(18),invar(14),invar(15),invar(16),invar(17).
 :- invar(11),invar(12),invar(13),invar(18),invar(14),invar(15),invar(16),invar(17).

 :- invar(1),invar(9),invar(2),invar(3),invar(4),invar(6),invar(7),invar(8).
 :- invar(1),invar(2),invar(5),invar(3),invar(4),invar(6),invar(7),invar(8).
 :- invar(1),invar(9),invar(2),invar(3),invar(4),invar(6),invar(7),invar(8).
 :- invar(1),invar(2),invar(5),invar(3),invar(4),invar(6),invar(7),invar(8).
% NOGOODS_END


% pattern len constraint
pattern_len(N) :- N = #count{X:invar(X)}.
good_model :- pattern_len(8).
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

:- positive_count(N), N < 14.

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

#show invar/1.
#show positive_match/1.
#show positive_count/1.
#show used_map/3.





































































































