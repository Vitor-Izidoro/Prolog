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
