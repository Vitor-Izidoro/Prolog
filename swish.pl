% ============================================================
% REGRA: VERIFICA SE UM NÚMERO É PAR
% ============================================================

% par(Numero)
% Um número é par se o resto da sua divisão por 2 for exatamente 0.
par(Numero) :-
    0 =:= Numero mod 2.