# Lista de Exercícios: Prolog

Repositório destinado à resolução da lista de exercícios de programação em Prolog.
link para o site do prolog: https://swish.swi-prolog.org/example/swish_tutorials.swinb

## Status dos Exercícios

- [x] **Exercício 1:** Crie uma regra em Prolog que verifica se um número é par.
- [x] **Exercício 2:** Escreva uma regra que calcula o fatorial de um número.
- [x] **Exercício 3:** Crie uma regra que verifica se uma lista é vazia.
- [x] **Exercício 4:** Caminho de Valor Mínimo em Tabuleiro N×N.
  > **Detalhes:** Você recebe um tabuleiro N×N com um operador aritmético binário e um operando inteiro em cada quadrado. Você começa com 0 como valor atual, e escolhe um caminho que visita cada quadrado do tabuleiro exatamente uma vez. Para cada quadrado visitado, você realiza a operação no quadrado com o valor atual como operando esquerdo da operação, e o número no quadrado como operando direito, e continua com o resultado como o valor atual. No final do caminho, seu valor atual depende do caminho escolhido; este é o valor final do caminho. Você deve encontrar o valor final mínimo de todos os caminhos, e o número de caminhos que têm este valor final mínimo. 
  > *Objetivo:* Escreva um predicado `board/3`, que tem como primeiro argumento (entrada) o tabuleiro, e que unifica o valor final mínimo com o segundo argumento e o número de diferentes caminhos que têm este valor final mínimo com o terceiro argumento. Um caminho pode começar em qualquer quadrado, e dois quadrados subsequentes em um caminho devem se tocar por um lado dos quadrados.
- [x] **Exercício 5:** Crie uma regra que verifica se uma lista é uma palíndrome.
- [x] **Exercício 6:** Escreva uma regra que calcule o n-ésimo termo da sequência de Fibonacci.
- [x] **Exercício 7:** Implemente uma regra que encontre o maior divisor comum (MDC) de dois números inteiros.
- [x] **Exercício 8:** Crie uma regra que verifica se um número é primo.
- [x] **Exercício 9:** Escreva uma regra que verifica se uma palavra é um palíndromo.
- [x] **Exercício 10:** Predicado `triangle/1`.
  > **Detalhes:** O argumento é uma lista `L` de caracteres (átomos de comprimento 1). O predicado desenha um conjunto de triângulos, que se encaixam uns dentro dos outros, e cujas circunferências são desenhadas com o caractere subsequente da lista `L`.

---

## Critérios de Avaliação

As notas serão atribuídas segundo as seguintes regras:

| Condição | Nota |
| :--- | :---: |
| Os códigos funcionam corretamente e estão perfeitamente comentados. | **10,0** |
| Os códigos funcionam corretamente, mas existe pelo menos um erro nos comentários. | **8,0** |
| Cada código que não rodar corretamente, de acordo com o solicitado no enunciado. | **-0,8** (por código) |
| Não foi possível acessar os códigos, ou os códigos não rodam. | **0,0** (Zero) |

---

## Cuidados e Avisos Importantes

* **Prazos:** As regras de perda de ponto por entrega fora do prazo, constantes no plano de ensino, se aplicam a este trabalho. 
* **Acessibilidade do Código:** Certifique-se de que o seu código pode ser acessado por alguém além de você. 
  * *Dica:* Acesse os links usando outra identidade no seu navegador, uma página anônima, ou peça para algum colega testar seus links. 
* **Atenção:** Programas com código inacessível serão sumariamente **zerados**.


# Exercício 4: Caminho Hamiltoniano em Tabuleiro com Operações

Dado um tabuleiro N×N onde cada célula contém uma operação matemática (`op(+,V)`, `op(-,V)`, `op(*,V)`), o programa encontra todos os **caminhos hamiltonianos** caminhos que visitam cada célula exatamente uma vez e retorna o **menor valor acumulado** possível ao longo do percurso, e quantas vezes esse valor ocorre.

---

## Predicados

| Predicado | Papel |
|---|---|
| `aplicar/3` | Aplica uma operação `op(+,-,*)` ao valor acumulado |
| `get_cell/4` | Lê o valor de uma célula `(ROW, COLUMN)` na matriz |
| `vizinho/5` | Gera um vizinho válido dentro dos limites do tabuleiro |
| `caminho_hamiltoniano/7` | Percorre todas as células sem repetição, acumulando o valor |
| `board/3` | Predicado principal encontra o menor valor e quantas vezes ele ocorre |

---

## 1. `aplicar/3` — operações

```prolog
aplicar(VALUE1, op(+, VALUE2), RESULTADO) :- RESULTADO is VALUE1 + VALUE2.
aplicar(VALUE1, op(-, VALUE2), RESULTADO) :- RESULTADO is VALUE1 - VALUE2.
aplicar(VALUE1, op(*, VALUE2), RESULTADO) :- RESULTADO is VALUE1 * VALUE2.
```

Três cláusulas, uma para cada operação. Recebe o valor atual, a operação da célula e retorna o resultado.

```prolog
% Exemplo
?- aplicar(5, op(+, 3), R).
R = 8.
```

---

## 2. `get_cell/4` — leitura da matriz

```prolog
get_cell(B, ROW, COLUMN, VALUE) :-
    nth1(ROW, B, LIST),
    nth1(COLUMN, LIST, VALUE).
```

Usa `nth1` duas vezes: primeiro pega a linha, depois pega o elemento na coluna. Índices começam em 1.

```prolog
% Exemplo num tabuleiro 2x2
B = [[op(+,1), op(*,2)],
     [op(-,1), op(+,3)]].

?- get_cell(B, 1, 2, V).
V = op(*,2).   % linha 1, coluna 2
```

---

## 3. `vizinho/5` — movimentos válidos

```prolog
vizinho(ROW, COLUMN, NEW_ROW, NEW_COLUMN, NUMBER_OF_LINES) :-
    (   NEW_ROW is ROW + 1, NEW_COLUMN = COLUMN   % baixo
    ;   NEW_ROW is ROW - 1, NEW_COLUMN = COLUMN   % cima
    ;   NEW_ROW = ROW, NEW_COLUMN is COLUMN + 1   % direita
    ;   NEW_ROW = ROW, NEW_COLUMN is COLUMN - 1   % esquerda
    ),
    NEW_ROW >= 1,
    NEW_ROW =< NUMBER_OF_LINES,
    NEW_COLUMN >= 1,
    NEW_COLUMN =< NUMBER_OF_LINES.
```

Gera os 4 vizinhos possíveis via **backtracking** (o `;` é "ou"). As verificações finais garantem que o vizinho está dentro do tabuleiro.

```prolog
% Exemplo: vizinhos da célula (1,1) num tabuleiro 2x2
?- vizinho(1, 1, NR, NC, 2).
NR=2, NC=1 ;   % baixo
NR=1, NC=2 .   % direita (cima e esquerda seriam inválidos)
```

---

## 4. `caminho_hamiltoniano/7` — o coração do algoritmo

```prolog
% Caso base: todas as células foram visitadas
caminho_hamiltoniano(_, NUMBER_OF_LINES, VISITATED, _, _, VALUE, VALUE) :-
    Total is NUMBER_OF_LINES * NUMBER_OF_LINES,
    length(VISITATED, Total).

% Caso recursivo: visita um vizinho ainda não visitado
caminho_hamiltoniano(B, NUMBER_OF_LINES, VISITATED, ROW, COLUMN, VAcum, VFin) :-
    vizinho(ROW, COLUMN, NEW_ROW, NEW_COLUMN, NUMBER_OF_LINES),
    \+ member((NEW_ROW, NEW_COLUMN), VISITATED),
    get_cell(B, NEW_ROW, NEW_COLUMN, Op),
    aplicar(VAcum, Op, NV),
    caminho_hamiltoniano(B, NUMBER_OF_LINES, [(NEW_ROW, NEW_COLUMN)|VISITATED], NEW_ROW, NEW_COLUMN, NV, VFin).
```

### Argumentos

| Argumento | Significado |
|---|---|
| `B` | O tabuleiro (matriz) |
| `NUMBER_OF_LINES` | Tamanho N do tabuleiro |
| `VISITATED` | Lista de células já visitadas |
| `ROW, COLUMN` | Posição atual |
| `VAcum` | Valor acumulado até agora |
| `VFin` | Valor final (resultado do caminho completo) |

### Como funciona

- **Caso base**: quando `VISITATED` tem N² células, o caminho está completo. `VALUE` é unificado consigo mesmo — o resultado acumulado vira o resultado final.
- **Caso recursivo**: gera um vizinho, verifica que não foi visitado (`\+`), aplica a operação e chama recursivamente.
- O Prolog usa **backtracking** para explorar todos os caminhos possíveis automaticamente.

---

## 5. `board/3` — predicado principal

```prolog
board(B, Min, Qtd) :-
    length(B, NUMBER_OF_LINES),
    findall(VALUE, (
        between(1, NUMBER_OF_LINES, ROW),
        between(1, NUMBER_OF_LINES, COLUMN),
        get_cell(B, ROW, COLUMN, op(Op, Val)),
        aplicar(0, op(Op, Val), INICIAL_VALUE),
        caminho_hamiltoniano(B, NUMBER_OF_LINES, [(ROW, COLUMN)], ROW, COLUMN, INICIAL_VALUE, VALUE)
    ), LIST),
    min_list(LIST, Min),
    aggregate_all(count, (member(X, LIST), X =:= Min), Qtd).
```

### Passo a passo

1. `length(B, N)` — descobre o tamanho N do tabuleiro.
2. `findall` — coleta os valores de **todos** os caminhos hamiltonianos partindo de **cada célula** como ponto de início.
3. `aplicar(0, op(Op,Val), INICIAL_VALUE)` — a operação da célula inicial é aplicada sobre `0` para definir o valor de partida.
4. `min_list(LIST, Min)` — encontra o menor valor entre todos os caminhos.
5. `aggregate_all count` — conta quantos caminhos atingiram exatamente esse valor mínimo.

---

## Exemplo de uso

```prolog
B = [[op(+,2), op(*,3)],
     [op(-,1), op(+,1)]].

?- board(B, Min, Qtd).
Min = ...,   % menor valor acumulado encontrado
Qtd = ...    % quantos caminhos chegaram a esse valor
```

---

## Fluxo resumido

```
1. Para cada célula do tabuleiro como ponto de partida
2.   Aplica a operação inicial sobre 0
3.   Explora todos os caminhos hamiltonianos via backtracking
4.   Coleta todos os valores finais numa lista
5. Retorna o mínimo e quantas vezes ele aparece
```

---

## Conceitos-chave usados

| Conceito | Onde aparece |
|---|---|
| Backtracking | `vizinho/5` gera alternativas; `\+` poda caminhos inválidos |
| Recursão | `caminho_hamiltoniano` chama a si mesmo a cada passo |
| `findall` | Coleta todos os resultados sem parar no primeiro |
| `\+ member` | Garante que nenhuma célula é visitada duas vezes |
| Acumulador | `VAcum` carrega o valor ao longo de toda a recursão |



# Exercício 10 — Triângulo Palíndromo em Pirâmide

Dado uma lista de átomos como entrada, o programa constrói e imprime uma pirâmide onde cada linha é formada por palíndromos crescentes até o pico, e depois por expansão da penúltima letra na descida.

```prolog
?- triangle([a,b,c,d]).

            a
          a b a
        a b c b a
      a b c d c b a
    a b c c c c c b a
  a b b b b b b b b b a
a a a a a a a a a a a a a
```

---

## Predicados

| Predicado | Papel |
|---|---|
| `make_row_up/2` | Constrói um palíndromo a partir de um prefixo (subida) |
| `make_row_down/3` | Constrói uma linha com repetição no meio (descida) |
| `print_spaces/1` | Imprime N espaços para centralizar a linha |
| `triangle/1` | Predicado principal — recebe a lista e imprime a pirâmide |

---

## 1. `make_row_up/2` — subida (palíndromo)

```prolog
make_row_up([X], [X]) :- !.
make_row_up(Prefix, Pal) :-
    reverse(Prefix, [_ | Rev]),
    append(Prefix, Rev, Pal).
```

Recebe um prefixo da lista e constrói um palíndromo descartando o elemento central ao inverter.

```
Prefix = [a,b,c]
reverse([a,b,c]) = [c,b,a]
descarta o centro: [_ | Rev] → Rev = [b,a]
append([a,b,c], [b,a]) = [a,b,c,b,a]
```

| Prefixo | Resultado |
|---|---|
| `[a]` | `[a]` |
| `[a,b]` | `[a,b,a]` |
| `[a,b,c]` | `[a,b,c,b,a]` |
| `[a,b,c,d]` | `[a,b,c,d,c,b,a]` |

---

## 2. `make_row_down/3` — descida (expansão)

```prolog
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
```

Na descida o prefixo **encolhe** (perde a última letra) e o espaço do meio é preenchido pela nova última letra.

```
Pico (linha 4):  Prefix=[a,b,c,d] → a b c d c b a  (7 letras)
Linha 5:         Prefix=[a,b,c]   → precisa ter 9 letras
  PLen=3, RLen=1 (RevTail=[b,a] sem o centro → [b,a] descarta → [b,a]... 
  espera: reverse([a,b,c])=[c,b,a], [_|RevTail] → RevTail=[b,a]
  MiddleCount = 9 - 3 - 2 = 4
  Last = c
  MiddleList = [c,c,c,c]
  Pal = [a,b,c] ++ [c,c,c,c] ++ [b,a] = [a,b,c,c,c,c,c,b,a]
```

| Linha | Prefixo | Resultado |
|---|---|---|
| 5 | `[a,b,c]` | `a b c c c c c b a` |
| 6 | `[a,b]` | `a b b b b b b b b b a` |
| 7 | `[a]` | `a a a a a a a a a a a a a` |

---

## 3. `print_spaces/1` — recuo

```prolog
print_spaces(0) :- !.
print_spaces(N) :-
    N > 0, write(' '),
    N1 is N - 1,
    print_spaces(N1).
```

Predicado recursivo simples que imprime `N` espaços. O `!` (cut) no caso base evita backtracking desnecessário quando `N=0`.

---

## 4. `triangle/1` — predicado principal

```prolog
triangle(Base) :-
    length(Base, N),
    TotalRows is 2 * N - 1,
    MaxChars is 2 * TotalRows - 1,
    MaxWidth is 2 * MaxChars - 1,
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
```

### Passo a passo com `[a,b,c,d]` (N=4)

```
TotalRows = 2*4 - 1 = 7      (linhas totais da pirâmide)
MaxChars  = 2*7 - 1 = 13     (letras na linha mais larga)
MaxWidth  = 2*13 - 1 = 25    (largura visual com espaços entre letras)
```

### Cálculo de cada linha

| I | RowChars | RowWidth | Spaces | Tipo | Prefixo |
|---|---|---|---|---|---|
| 1 | 1 | 1 | 12 | subida | `[a]` |
| 2 | 3 | 5 | 10 | subida | `[a,b]` |
| 3 | 5 | 9 | 8 | subida | `[a,b,c]` |
| 4 | 7 | 13 | 6 | subida | `[a,b,c,d]` ← pico |
| 5 | 9 | 17 | 4 | descida | `[a,b,c]` |
| 6 | 11 | 21 | 2 | descida | `[a,b]` |
| 7 | 13 | 25 | 0 | descida | `[a]` |

### Decisão subida/descida

```prolog
( I =< N ->
    % SUBIDA: pega prefixo de tamanho I e faz palíndromo
    make_row_up(Prefix, Row)
;
    % DESCIDA: calcula qual prefixo usar (encolhe 1 a cada linha)
    K is I - N,           % quantas linhas após o pico
    PrefixLen is N - K,   % tamanho do prefixo diminui
    make_row_down(Prefix, RowChars, Row)
)
```

### Impressão

```prolog
print_spaces(Spaces),              % recuo à esquerda
atomic_list_concat(Row, ' ', Line), % junta letras com espaço
writeln(Line)                       % imprime a linha
```

`atomic_list_concat([a,b,c], ' ', Line)` → `Line = 'a b c'`

---

## Por que a pirâmide tem duas metades?

As duas metades seguem regras completamente diferentes:

**Subida** — cada linha cresce adicionando uma letra **no centro**:
```
a  →  a b a  →  a b c b a  →  a b c d c b a
```

**Descida** — cada linha cresce adicionando letras **no meio** para manter a expansão:
```
a b c d c b a   (7 letras)
a b c c c c c b a   (9 letras)  ← d saiu, c preenche
a b b b b b b b b a   (11 letras)  ← c saiu, b preenche
a a a a a a a a a a a a a   (13 letras)  ← b saiu, a preenche
```

Se usássemos `make_row_up` na descida, a pirâmide viraria um **losango** (encolheria após o pico). A descida precisa **continuar crescendo** para manter a forma triangular.

---

## Conceitos-chave usados

| Conceito | Onde aparece |
|---|---|
| `reverse/2` + `append/3` | Construção do palíndromo em `make_row_up` |
| `maplist(=(Last), List)` | Preenche o meio com a última letra em `make_row_down` |
| `forall` + `between` | Itera sobre cada linha sem recursão manual |
| `->` (if-then) | Decide entre subida e descida |
| `atomic_list_concat` | Junta a lista de átomos com espaço para impressão |
| `//` (divisão inteira) | Calcula o recuo de centralização |