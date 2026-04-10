% Alex Menegatti Secco
% Bruno Betiatto Alves
% Mariana de Castro
% Vitor Rodrigues Izidoro

% Exercício 1: Crie uma regra em Prolog que verifica se um número é par. 
% número é par se ele for divisível por 2 (se resto da divisão por 2 for 0)
par(Numero) :-
    0 =:= Numero mod 2.

% Exemplo de consulta:
% ?- par(6).     --- Resultado = true
% ?- par(7).    --- Resultado = false

% ============================================================

% Exercício 2: Escreva uma regra que calcula o fatorial de um número.
% caso base: o fatorial de 0 é 1
fatorial(0, 1).

% recursão para calcular fatorial de um número N
fatorial(N, F) :-
    N > 0,                % N deve ser maior que 0
    N1 is N - 1,          % Calcula N-1
    fatorial(N1, F1),    % Chama o fatorial para N-1
    F is N * F1. 

% Exemplo de consulta:
% ?- fatorial(5, F).    --- O resultado deve ser F = 120.

% ============================================================

% Exercício 3: Crie uma regra que verifica se uma lista é vazia.
lista_vazia([]).

% Exemplo de consulta:
% ?- lista_vazia([]).   --- Resultado = true
% ?- lista_vazia([1,2,5,8]).   --- Resultado = false

% ============================================================

/* exercicio 4: Você recebe um tabuleiro N×N com um operador aritmético binário e um
operando inteiro em cada quadrado. Você começa com 0 como valor atual, e escolhe um
caminho que visita cada quadrado do tabuleiro exatamente uma vez. Para cada quadrado
visitado, você realiza a operação no quadrado com o valor atual como operando esquerdo da
operação, e o número no quadrado como operando direito, e continua com o resultado como
o valor atual. No final do caminho, seu valor atual depende do caminho escolhido; este é o
valor final do caminho. Você deve encontrar o valor final mínimo de todos os caminhos, e o
número de caminhos que têm este valor final mínimo.
Escreva um predicado board/3, que tem como primeiro argumento (entrada) o tabuleiro, e
que unifica o valor final mínimo com o segundo argumento e o número de diferentes caminhos
que têm este valor final mínimo com o terceiro argumento. Um caminho pode começar em
qualquer quadrado, e dois quadrados subsequentes em um caminho devem se tocar por um
lado dos quadrados. */

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
%   board(Tab, Minimo, Quantidade).
% 
% Tab = [[op(*,+1), op(+, 3)], 
%      [op(+, 3), op(+,2000)]],
% board(Tab, Minimo, Quantidade).


%================================================================
%exercicio 5 --Crie uma regra que verifica se uma lista é uma palíndrome.

palindrome([]).
palindrome([_]).
palindrome([H|T]) :-
    append(Miolo, [H], T),
    palindrome(Miolo).
% Exemplo de consulta:
% ?- palindrome([1, 2, 3, 2, 1]).
% ?- palindrome([r,a, d, a, r]).

%==========================================
% exercicio 6 -- Escreva uma regra que calcule o n-ésimo termo da sequência de Fibonacci.
fib(N, F) :- fib(N, 0, 1, F).

fib(0, A, _, A).
fib(N, A, B, F) :-
    N > 0,
    N1 is N - 1,
    C is A + B,
    fib(N1, B, C, F).

% Exemplo de consulta:
% ?- fib(10, F).    --- O resultado deve ser F = 55

%==============================================
% exercicio 7 -- Implemente uma regra que encontre o maior divisor comum (MDC) de dois
% números inteiros.

mdc(A, 0, A) :- A > 0.
mdc(A, B, MDC) :-
    B > 0,
    R is A mod B,
    mdc(B, R, MDC).

% Exemplo de consulta:
% ?- mdc(48, 18, MDC).    --- O resultado deve ser MDC = 6

%===============================================
%exercicio 8 --Crie uma regra que verifica se um número é primo.

primo(2).
% para qualquer número N maior que 2, SE NÃO for verdade
% que ele tem um divisor começando a testar do 2, é primo.
primo(N) :-
    N > 2,
    \+ tem_divisor(N, 2).

% --- REGRAS AUXILIARES DE DIVISÃO ---

tem_divisor(N, DivisorAtual) :-
   N mod DivisorAtual =:= 0.

% Condição 2: não dividiu? tenta o próximo número.
tem_divisor(N, DivisorAtual) :-
    % só precisa testar até a raiz quadrada de N.
    % se Divisor * Divisor ultrapassar N, não faz sentido 
    % continuar testando.
    DivisorAtual * DivisorAtual < N,
    ProximoDivisor is DivisorAtual + 1,
    tem_divisor(N, ProximoDivisor).

% Exemplo de consulta:
% ?- primo(3).  --- Resultado = true.
% ?- primo(6).  --- Resultado = false.

%======================================
%exercicio 9 -- Escreva uma regra que verifica se uma palavra é um palíndromo.

palindromo(Palavra) :-
    string_chars(Palavra, Lista),    % converte a string em % uma lista de caracteres
    reverse(Lista, Invertida),       % inverte a lista
    Lista == Invertida.              % verifica se a original é igual a lista invertida

% Exemplo de consulta:
% ?- palindromo(renner).    --- Resultado = true.
% ?- palindromo(prolog).    --- Resultado = false.


%=====================================
/* exercicio 10 -- Escreva um predicado triangle/1, cujo argumento é uma lista L de caracteres
(átomos de comprimento 1). O predicado desenha um conjunto de triângulos, que se
encaixam uns dentro dos outros, e cujas circunferências são desenhadas com o caractere
subsequente da lista L.*/

% --- Linha de subida: palíndromo simples ---
make_row_up([X], [X]) :- !.
make_row_up(Prefix, Pal) :-
    reverse(Prefix, [_ | Rev]),
    append(Prefix, Rev, Pal).

% --- Linha de descida: borda + repetição + espelho ---
make_row_down(Prefix, TotalLen, Pal) :-
    reverse(Prefix, [_ | RevTail]),
    length(Prefix, PLen),
    length(RevTail, RLen),
    MiddleCount is TotalLen - PLen - RLen,
    last(Prefix, Last),
    length(MiddleList, MiddleCount),
    maplist(=(Last), MiddleList),
    append(Prefix, MiddleList, Tmp),
    append(Tmp, RevTail, Pal).

% --- Espaços ---
print_spaces(0) :- !.
print_spaces(N) :-
    N > 0, write('-'),
    N1 is N - 1,
    print_spaces(N1).

% --- Predicado principal ---
triangle(Base) :-
    length(Base, N),
    TotalRows is 2 * N - 1,
    MaxChars is 2 * TotalRows - 1,       % chars da linha mais larga
    MaxWidth is 2 * MaxChars - 1,        % largura com espaços entre chars
    forall(between(1, TotalRows, I), (
        RowChars is 2 * I - 1,
        RowWidth is 2 * RowChars - 1,
        Spaces is (MaxWidth - RowWidth) // 2,
        ( I =< N ->
            length(Prefix, I),
            append(Prefix, _, Base),
            make_row_up(Prefix, Row)
        ;
            K is I - N,
            PrefixLen is N - K,
            length(Prefix, PrefixLen),
            append(Prefix, _, Base),
            make_row_down(Prefix, RowChars, Row)
        ),
        print_spaces(Spaces),
        atomic_list_concat(Row, ' ', Line),
        writeln(Line)
    )).

% Exemplo de consulta:
% ?- triangle([a, b, c]).
