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
- [ ] **Exercício 8:** Crie uma regra que verifica se um número é primo.
- [x] **Exercício 9:** Escreva uma regra que verifica se uma palavra é um palíndromo.
- [ ] **Exercício 10:** Predicado `triangle/1`.
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
