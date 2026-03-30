% Exercício 1: Crie uma regra em Prolog que verifica se um número é par. 
============================================================
% REGRA: VERIFICA SE UM NÚMERO É PAR
% ============================================================

% par(Numero)
% Um número é par se o resto da sua divisão por 2 for exatamente 0.
par(Numero) :-
    0 =:= Numero mod 2.

% Exemplo de consulta:
% ?- par(6).     --- Resultado = true
% ?- par(7).    --- Resultado = false

% ============================================================

% Exercício 2: Escreva uma regra que calcula o fatorial de um número.
% Caso base: o fatorial de 0 é 1
fatorial(0, 1).

% Recursão para calcular fatorial de um número N
fatorial(N, F) :-
    N > 0,                % N deve ser maior que 0
    N1 is N - 1,          % Calcula N-1
    fatorial(N1, F1),    % Chama o fatorial para N-1
    F is N * F1. 

% Exemplo de consulta:
% ?- fatorial(5, F).    --- O resultado deve ser F = 120.

% ============================================================

% Exercício 3: Crie uma regra que verifica se uma lista é vazia.
% NÃO SEI SE TA CERTO, PARECE SIMPLES DEMAIS
lista_vazia([]).

% Exemplo de consulta:
% ?- lista_vazia([]).   --- Resultado = true
% ?- lista_vazia([1,2,5,8]).   --- Resultado = false

% ============================================================

% exercicio 4

% --- Predicado Principal ---
% --- Operações ---
aplicar(V1, op(+, V2), R) :- R is V1 + V2.
aplicar(V1, op(-, V2), R) :- R is V1 - V2.
aplicar(V1, op(*, V2), R) :- R is V1 * V2.

% --- Matriz ---
get_cell(B, R, C, V) :-
    nth1(R, B, L),
    nth1(C, L, V).

% --- Vizinhança (Reescrita sem espaços problemáticos) ---
vizinho(R, C, NR, NC, N) :-
    (   NR is R + 1, NC = C
    ;   NR is R - 1, NC = C
    ;   NR = R, NC is C + 1
    ;   NR = R, NC is C - 1
    ),
    NR >= 1,
    NR =< N,   
    NC >= 1,
    NC =< N.
% --- Caminho ---
caminho_hamiltoniano(_, N, Vis, _, _, Val, Val) :-
    Total is N * N,
    length(Vis, Total).

caminho_hamiltoniano(B, N, Vis, R, C, VAcum, VFin) :-
    vizinho(R, C, NR, NC, N),
    \+ member((NR, NC), Vis),
    get_cell(B, NR, NC, Op),
    aplicar(VAcum, Op, NV),
    caminho_hamiltoniano(B, N, [(NR, NC)|Vis], NR, NC, NV, VFin).

% --- Principal ---
board(B, Min, Qtd) :-
    length(B, N),
    findall(V, (
        between(1, N, R), between(1, N, C),
        get_cell(B, R, C, op(Op, Val)),
        aplicar(0, op(Op, Val), VI),
        caminho_hamiltoniano(B, N, [(R, C)], R, C, VI, V)
    ), L),
    min_list(L, Min),
    aggregate_all(count, (member(X, L), X =:= Min), Qtd).

% Versão que mostra o caminho exato
board_com_caminho(Board, Minimo, Qtd, ExemploCaminho) :-
    length(Board, N),
    findall([VFinal, CaminhoReverso], (
        between(1, N, R), between(1, N, C),
        get_cell(Board, R, C, op(Op, Val)),
        aplicar(0, op(Op, Val), VInit),
        caminho_hamiltoniano(Board, N, [(R, C)], R, C, VInit, VFinal),
        CaminhoReverso = [(R, C)|_] % Pega a lista de visitados
    ), Resultados),
    
    % Encontra o minimo apenas nos valores (primeiro elemento da lista [V, C])
    findall(V, member([V, _], Resultados), ApenasValores),
    min_list(ApenasValores, Minimo),
    
    % Filtra os caminhos que batem com o minimo
    findall(C, member([Minimo, C], Resultados), TodosCaminhos),
    length(TodosCaminhos, Qtd),
    nth1(1, TodosCaminhos, ExemploCaminho). % Mostra o primeiro dos dois caminhos



%  consulta 

% Tab = [[op(*,+1), op(+, 3), op(+,555), op(+, 3)],
%          [op(+, 3), op(+,2000), op(*,133), op(+,555)],
%          [op(*, 0), op(*, 133), op(+, 2), op(+, 19)],
%          [op(+, 3), op(+,1000), op(+, 2), op(*, 3)]],
%   board_com_caminho(Tab, Minimo, Quantidade, CAMINHO).
