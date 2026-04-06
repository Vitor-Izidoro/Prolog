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
aplicar(VALUE1, op(+, VALUE2), RESULTADO) :- RESULTADO is VALUE1 + VALUE2.
aplicar(VALUE1, op(-, VALUE2), RESULTADO) :- RESULTADO is VALUE1 - VALUE2.
aplicar(VALUE1, op(*, VALUE2), RESULTADO) :- RESULTADO is VALUE1 * VALUE2.

% --- Matriz ---
get_cell(B, ROW, COLUMN, VALUE) :-
    nth1(ROW, B, LIST),
    nth1(COLUMN, LIST, VALUE).

% --- Vizinhança ------
vizinho(ROW, COLUMN, NEW_ROW, NEW_COLUMN, NUMBER_OF_LINES) :-
    (   NEW_ROW is ROW + 1, NEW_COLUMN = COLUMN
    ;   NEW_ROW is ROW - 1, NEW_COLUMN = COLUMN
    ;   NEW_ROW = ROW, NEW_COLUMN is COLUMN + 1
    ;   NEW_ROW = ROW, NEW_COLUMN is COLUMN - 1
    ),
    NEW_ROW >= 1,
    NEW_ROW =< NUMBER_OF_LINES,   
    NEW_COLUMN >= 1,
    NEW_COLUMN =< NUMBER_OF_LINES.
% --- Caminho ---
caminho_hamiltoniano(_, NUMBER_OF_LINES, VISITATED, _, _, VALUE, VALUE) :-
    Total is NUMBER_OF_LINES * NUMBER_OF_LINES,
    length(VISITATED, Total).

caminho_hamiltoniano(B, NUMBER_OF_LINES, VISITATED, ROW, COLUMN, VAcum, VFin) :-
    vizinho(ROW, COLUMN, NEW_ROW, NEW_COLUMN, NUMBER_OF_LINES),
    \+ member((NEW_ROW, NEW_COLUMN), VISITATED),
    get_cell(B, NEW_ROW, NEW_COLUMN, Op),
    aplicar(VAcum, Op, NV),
    caminho_hamiltoniano(B, NUMBER_OF_LINES, [(NEW_ROW, NEW_COLUMN)|VISITATED], NEW_ROW, NEW_COLUMN, NV, VFin).

% --- Principal ---
board(B, Min, Qtd) :-
    length(B, NUMBER_OF_LINES),
    findall(VALUE, (
        between(1, NUMBER_OF_LINES, ROW), between(1, NUMBER_OF_LINES, COLUMN),
        get_cell(B, ROW, COLUMN, op(Op, Val)),
        aplicar(0, op(Op, Val), INICIAL_VALUE),
        caminho_hamiltoniano(B, NUMBER_OF_LINES, [(ROW, COLUMN)], ROW, COLUMN, INICIAL_VALUE, VALUE)
    ), LIST),
    min_list(LIST, Min),
    aggregate_all(count, (member(X, LIST), X =:= Min), Qtd).



%  consulta 

% Tab = [[op(*,+1), op(+, 3), op(+,555), op(+, 3)],
%          [op(+, 3), op(+,2000), op(*,133), op(+,555)],
%          [op(*, 0), op(*, 133), op(+, 2), op(+, 19)],
%          [op(+, 3), op(+,1000), op(+, 2), op(*, 3)]],
%   board_com_caminho(Tab, Minimo, Quantidade, CAMINHO).


%exercicio 5 --palindrome

palindrome([]).
palindrome([_]).
palindrome([H|T]) :-
    append(Miolo, [H], T),
    palindrome(Miolo).
% Exemplo de consulta:
% ?- palindrome([1, 2, 3, 2, 1]).
% ?- palindrome([r,a, d, a, r]).

% exercicio 6 -- fibonacci
fib(N, F) :- fib(N, 0, 1, F).

fib(0, A, _, A).
fib(N, A, B, F) :-
    N > 0,
    N1 is N - 1,
    C is A + B,
    fib(N1, B, C, F).

% Exemplo de consulta:
% ?- fib(10, F).    --- O resultado deve ser F = 55

% exercicio 7 -- mdc

mdc(A, 0, A) :- A > 0.
mdc(A, B, MDC) :-
    B > 0,
    R is A mod B,
    mdc(B, R, MDC).

% Exemplo de consulta:
% ?- mdc(48, 18, MDC).    --- O resultado deve ser MDC = 6