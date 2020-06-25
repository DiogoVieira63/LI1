{- |

= Introdução

Nesta tarefa o objetivo é gerar um mapa tendo em conta o número de pistas, o comprimento das mesmas e um número
gerador pseudo-aleatório. 

O número aleatório é dado por uma função previamente definida que recebe o número de elementos a gerar, uma semente,
e produz uma lista de valores pseudo aleatórios com valores entre 0 e 9.

Neste jogo o mapa será interpretado e construído como uma matriz de peças em que cada peça poderá ser do tipo Recta
ou Rampa. No caso da Recta esta terá altitude constante e no caso da rampa esta apresentará altura inicial e final.

type Mapa = [Pista]
type Pista = [Peca]
data Peca = Recta Piso Int | Rampa Piso Int Int
data Piso = Terra | Relva | Lama | Boost | Cola

Para a implementação da função geradora forma atribuídas no enunciado algumas condições que validam um mapa, tal como:

- Todas as pistas começam com Recta Terra 0;
- Todas as pistas têm o mesmo comprimento;
- Não há alturas negativas;
- As alturas inicial e final de peças adjacentes na mesma pista são iguais.

= Raciocínio

Primeiramente definimos uma função que analisa quantos números aleatórios deverão ser gerados tendo em conta o comprimento
do mapa e o número de pistas que pretendemos obter (tendo por base o enunciado e a forma como os aleatórios são organizados).
De seguida definimos funções que traduzissem o que o enunciado pretendia em termos de interpretação de aleatórios para o piso
e para as alturas das rampas. 

= Discussão e Conclusão

Consideramos que esta tarefa foi crucial por ser o nosso primeiro contacto com o jogo, com novos tipos como o exemplo do Peca
e do Piso. Por outro lado, a Tarefa 1 foi a nossa primeira tentativa de interpretar enunciados e transcrever os mesmos
em linguagem de programção propriamente dita. 

Nesta tarefa a parte mais desafiante foi a implementação da função que perante um número aleatório nos retornava retas
com pisos de peças anteriores pelo facto de ser o nosso primeiro contacto concreto com acumuladores. No entanto, consideramos
que conseguimos responder ao que nos era pedido.

-}




--- | Este módulo define funções comuns da Tarefa 1 do trabalho prático.

module Tarefa1_2019li1g107 where

import LI11920
import System.Random


-- * Testes

-- | Testes unitários da Tarefa 1.
--
-- Cada teste é um triplo (/número de 'Pista's/,/comprimento de cada 'Pista' do 'Mapa'/,/semente de aleatoriedades/).

testesT1 :: [(Int,Int,Int)]
testesT1 = [(2,5,4),(3,2,(-7)),(100,20,1),(100,3,0),(1,10,2),(1,1,1),(2,2,0),(0,1,3),(5,1,1)]

-- * Funções pré-definidas da Tarefa 1.

geraAleatorios :: Int -> Int -> [Int]
geraAleatorios n seed = take n (randomRs (0,9) (mkStdGen seed))

-- * Funções principais da Tarefa 1.

{- | Função que gera um mapa sabendo que n é o número de aleatórios gerado em geraALeatorios,
npistas é o número de pistas que é formado partindo desse n -}

gera :: Int -> Int -> Int -> Mapa
gera npistas comprimento semente | comprimento == 1 = aux npistas
                                 | otherwise = geraMapa(toMatriz n npistas (fmatrizmapa matrizmapa))
    where
        n = ((npistas * comprimento)-npistas) * 2 
        matrizmapa = geraAleatorios n semente

-- | Função auxiliar que, no caso de o comprimento ser 1 gera npistas com Piso Terra
aux :: Int -> Mapa
aux 0 = []
aux x = [Recta Terra 0] : aux (x-1)

-- | Função que gera mapa através da função geraPeca

geraMapa:: [[(Int,Int)]] -> Mapa
geraMapa [] = []
geraMapa l = geraPeca (head l): geraMapa (tail l)

-- |Função que dada uma lista de inteiros, a organiza numa lista de pares de inteiros 
fmatrizmapa :: [Int] -> [(Int,Int)]
fmatrizmapa [] = []
fmatrizmapa (x:y:[])= [(x,y)]
fmatrizmapa (x:y:z) = (x, y) : (fmatrizmapa z)


-- |Função que organiza a lista de pares de inteiros em matrizes e as divide em pistas
toMatriz :: Int -> Int -> [(Int,Int)] -> [[(Int,Int)]]
toMatriz _ _ [] = []
toMatriz n npistas ((a,b):xs) = take ((n `div` 2) `div` npistas) ((a,b):xs)  : toMatriz n npistas (drop ((n `div` 2) `div` npistas) ((a,b):xs))

-- | Função que define o piso conforme a primeira componente do par resultante de fmatrizmapa
geraPiso :: [(Int,Int)] -> [(Piso,Int)]
geraPiso l = pisoanterior Terra l


-- | Função que partindo do piso anterior gera uma lista em que a primeira componente do par é um piso e a segunda um inteiro.

-- Esta função baseia-se nas condições definidas no enunciado para cada valor.

pisoanterior :: Piso -> [(Int,Int)] -> [(Piso,Int)]
pisoanterior _ [] = []
pisoanterior a ((x,y):t) | x >= 0 && x <= 1 = (Terra,y) : (pisoanterior Terra t)
                         | x >= 2 && x <= 3 = (Relva,y) : (pisoanterior Relva t)
                         | x == 4           = (Lama,y) : (pisoanterior Lama t)
                         | x == 5           = (Boost,y) : (pisoanterior Boost t)
                         | x >= 6 && x <= 9 = (a,y) : (pisoanterior a t)

-- |Função que, usando a convertertoTipo da lista geraPiso, gera uma pista (lista de peças)

-- Tendo em conta que todas as pistas têm início em Recta Terra 0, a primeira peça é Recta Terra 0.

geraPeca :: [(Int,Int)] -> Pista
geraPeca l = [Recta Terra 0] ++ convertertoTipo 0 (geraPiso l)

-- | Função que define o tipo de Recta/Rampa, gerando uma pista conforme a segunda componente de um par

convertertoTipo :: Int -> [(Piso,Int)] -> Pista
convertertoTipo _ [] = []
convertertoTipo x ((p,b):t) | b >= 0 && b <= 1 = Rampa p x (x+(b+1)) : convertertoTipo (x+(b+1)) t
                            | b >= 2 && b <= 5 = if x == 0 && (x-(b-1)) < 0 then Recta p 0:convertertoTipo 0 t 
                                                     else (if (x-(b-1)) < 0 then Rampa p x 0 : convertertoTipo 0 t
                                                     else Rampa p x (x-(b-1)) : convertertoTipo  (x-(b-1)) t)  
                                | b >= 6 && b <= 9 = Recta p x : convertertoTipo x t