{- |

= Introdução

Nesta tarefa o objetivo é, dado um mapa de comprimento de pista superior a 1, converter o mesmo numa sequência
de instruções do tipo:

Type Instrucoes = [Instrucao]
data Instrucao
    = Anda [Int] Piso
    | Sobe [Int] Piso Int
    | Desce [Int] Piso Int
    | Teleporta [Int] Int
    | Repete Int Instrucoes

Como tal pretende-se implementar a função descontroi que dado um Mapa, o transforma num conjunto de instruções
que quando executadas produzem exatamento o mapa que foi desconstruído.

= Ideias

Como tal, a ideia nesta tarefa seria reconhecer padrões e implementar funções que, perante estes padrões, transformassem
os padrões em instruções. 

Tal como sugerido no enunciado há 3 tipos de padrões que podem ser reconhecidos:

- Padrões Horizontais :

  Consistem em padrões que analisam a ocorrência de peças consecutivas iguais numa mesma pista.

- Padrões Verticais :

  Consistem em analisar se em diferentes pistas existem peças iguais em posições iguais.

- Padrões Verticais Desfasados :

  Neste caso, consistem em analisar se em existem peças consecutivas iguais em pistas diferentes em posições
diferentes.

= Raciocínio

Para a realização desta tarefa optamos por começar por implementar primeiramente os padrões horizontais por 
serem os mais simples. Desta forma arranjamos uma forma de analisar um mapa pata instruções do tipo Repete, 
bem como Anda, Sobe e Desce.
De seguida, 

= Discussão e Conclusão

Nesta tarefa reconhecemos novamente que em termos que em termos de qualidade de código poderíamos ter tido um 
melhor aproveitamento.
Contudo, consideramos que nesta tarefa a maior dificuldade será analisar um mapa e tentar de certa forma 
transformá-lo num formatodiferente mas mais eficiente. A principal dificuldade é a transformação do raciocínio em código pelo facto de 
que é complicado transmitir algumas ideias quando se trata de linguagem de programação. Contudo, a implementação
de padrões horizontais e de padrões verticais permitiu uma boa desconstrução do mapa.
Novamente, nesta tarefa reconhecemos que em termos que em termos de qualidade de código poderíamos ter tido um 
melhor aproveitamento.


-}



-- | Este módulo define funções comuns da Tarefa 3 do trabalho prático.
module Tarefa3_2019li1g107 where

import LI11920
import Tarefa1_2019li1g107
import Tarefa2_2019li1g107
import Data.List
-- * Testes

-- | Testes unitários da Tarefa 3.
--
-- Cada teste é um 'Mapa'.
testesT3 :: [Mapa]
testesT3 = [(gera 2 5 1),(gera 10 20 1), [[Recta Terra 0, Recta Terra 0, Recta Terra 0,Recta Terra 0],[Recta Terra 0, Recta Boost 0, Recta Boost 0, Recta Boost 0]]]

-- * Funções principais da Tarefa 3.

-- | Desconstrói um 'Mapa' numa sequência de 'Instrucoes'.
--
-- __NB:__ Uma solução correcta deve retornar uma sequência de 'Instrucoes' tal que, para qualquer mapa válido 'm', executar as instruções '(desconstroi m)' produza o mesmo mapa 'm'.
--
-- __NB:__ Uma boa solução deve representar o 'Mapa' dado no mínimo número de 'Instrucoes', de acordo com a função 'tamanhoInstrucoes'.
desconstroi :: Mapa -> Instrucoes
desconstroi  l = if tamanhoInstrucoes (repete (padroesH 0 (map tail l))) < tamanhoInstrucoes (padroesVert (map tail l)) then repete (padroesH 0 (map tail l)) else padroesVert (map tail l)

-- **Padrões Horizontais

-- | Função que a partir das Instruções devolve as Instruções com Repete

repete :: Instrucoes -> Instrucoes
repete [] = []
repete (h:[]) = [h]
repete (h:t) | h == (head t) = Repete  v [head t]: repete (drop v (h:t))
             |otherwise = h:repete t
               where 
                v = aux 2 t
                aux :: Int -> Instrucoes -> Int
                aux x (h:[]) = x 
                aux x (h:t) | h == head t = aux (x+1) t
                            | otherwise = x

-- | Função que a partir de um mapa dá Instruções através dos padrões horizontais, peça a peça

padroesH :: Int ->  Mapa -> Instrucoes
padroesH x [] = []
padroesH x (h:t) = aux x h ++ padroesH (x+1) t
               where 
                aux :: Int -> Pista -> Instrucoes
                aux x [] = []
                aux x (h:t) = (aux2 x h):(aux x t)

                aux2 :: Int -> Peca -> Instrucao
                aux2 x (Recta y _) = Anda [x] y
                aux2 x (Rampa y a b) | a < b = Sobe [x] y (b - a)
                                     | a > b = Desce [x] y (a - b)

-- ** Padrões Verticais

-- | Função que dada uma Lista devolve uma lista com as posicões da lista

allPos :: [a] -> [Int]
allPos l = [0..x]
         where 
            x = (length l) - 1 


-- | Função que dada um mapa devolve uma lista de (Int,Peca), onde o Int corresponde à pista em que a peca se encontra
allDoubles :: Mapa -> [(Int,Peca)]
allDoubles (h:t) = makeDoubles (map head (h:t))

makeDoubles :: Pista -> [(Int,Peca)]
makeDoubles l = aux (allPos l) l
              where 
                aux :: [Int] -> Pista -> [(Int,Peca)]
                aux (h:t)(a:b) = (h,a) : aux t b 
                aux _ _ = []

-- | Função que divide uma lista de (Int,Peca) pela quantidade de colunas que tem
divEmColunas :: Int -> [(Int,Peca)] -> [(Int,Peca)]
divEmColunas x l = take x l

-- | Função que transforma uma coluna (lista de (Int,Peca)) em Instruções conforme o enunciado 
unirIguais :: [(Int,Peca)] -> Instrucoes 
unirIguais [] = []
unirIguais (h:t) = aux (snd h) ([fst h] ++ junta1peca (h:t)): unirIguais (esquece1pecas (h:t))
                 where 
                    junta1peca :: [(Int,Peca)] -> [Int]
                    junta1peca (h:[]) = []
                    junta1peca (h:v:t) | snd h == snd v = fst v: junta1peca (h:t)
                                       | otherwise = junta1peca (h:t)

                    esquece1pecas :: [(Int,Peca)] -> [(Int,Peca)]
                    esquece1pecas (h:[]) = []
                    esquece1pecas (h:v:t) | snd h == snd v = esquece1pecas (h:t)
                                          | otherwise = v : esquece1pecas (h:t)

                    aux :: Peca -> [Int] -> Instrucao 
                    aux (Recta x _) l = Anda l x
                    aux (Rampa x a b) l | a < b = Sobe l x (b - a)
                                        | a > b = Desce l x (a - b)

-- | Função que dada um Mapa devolve Instruções que desconstruído corresponde ao Mapa dado
padroesVert :: Mapa -> Instrucoes
padroesVert (h:t) | length h == 1 = unirIguais ((divEmColunas f (allDoubles (h:t))))
                  | otherwise =  unirIguais ((divEmColunas f (allDoubles (h:t)))) ++ padroesVert ((map tail) (h:t))
                where 
                  f = length (map head (h:t))

