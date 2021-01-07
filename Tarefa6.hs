{- |

= Introdução

Nesta tarefa o objetivo é implementar um bot no jogo Excite Bike através de estratégias definidas pelo grupo.

= Raciocínio

Tendo por base o enunciado desta tarefa, ou seja, considerando que o bot recebe o Estado de jogo de 0.2 segundos
em 0.2 segundos e que o jogo termina passados 40s decidimos optar por tentar implementar algumas estratégias como
por exemplo comparar o piso das peças acima e a abaixo da peça do jogador para decidir a melhor opção. Por outro
lado pretendiamos implementar função que tomasse decisões para o bot quando este se encontra no ar. 

Desta forma, dividimos as decisões do bot para o caso deste estar no ar ou no chão. Caso o bot esteja no chão ele
pode optar por escolher a peça mais vantajosa. Atribuímos a cada piso um valor conforme o quão vantajoso é para o
bot. No caso do bot se encontrar no ar, o bot pode diminuir ou aumentar a inclinação para evitar que este morra. 

Utilizamos nesta tarefa algumas funções definidas noutras tarefas e definimos algumas para decidir jogadas e para
verificar se a inclinação é favorável ou não para o bot.


= Discussão e Conclusão

Esta tarefa foi uma tarefa que não conseguimos explorar como pretendíamos porque não conseguimos tirar proveito
das colas do bot nem tomar decisões para o uso da mesma. Consideramos que definir algumas condições para o bot
sem que este se prejudique é bastante complexo. Contudo, consideramos que esta tarefa desenvolveu o nosso 
raciocínio e a nossa capacidade de analisar estratégias e situações vantajosas e desvantajosas para um jogador.

-}

-- Este módulo define funções comuns da Tarefa 6 do trabalho prático.
module Tarefa6 where
import Tarefa0
import Tarefa1
import Tarefa2
import Tarefa3
import Tarefa4
import LI11920

-- * Funções principais da Tarefa 6.

-- | Define um ro'bot' capaz de jogar autonomamente o jogo.
bot :: Int          -- ^ O identificador do 'Jogador' associado ao ro'bot'.
    -> Estado       -- ^ O 'Estado' para o qual o ro'bot' deve tomar uma decisão.
    -> Maybe Jogada -- ^ Uma possível 'Jogada' a efetuar pelo ro'bot'.
bot x (Estado m js) | estadoChao j = movimento a j
                    | otherwise    = decisaoar j m 
                    where m' = esquecercolunas j m
                          j  = mostraJogador x js
                          a  = melhorpista (comparapiso m' l) y
                          l  = pecacomparavel m' j
                          y  = valor (pecatopiso l)
 
-- Função que esquece as colunas para trás da posição do jogador
esquecercolunas :: Jogador -> Mapa -> Mapa
esquecercolunas j m = map (drop y) m
                    where y = (floor (distanciaJogador j)) - 1

-- Função que dá o piso de uma peça
pecatopiso :: [Peca] -> [Piso]
pecatopiso [] = []
pecatopiso ((Rampa p x y):t) = p : pecatopiso t
pecatopiso ((Recta p x):t)   = p : pecatopiso t

-- Função que atribui valores ao piso conforme a vantagem que confere ao jogador.
valor :: [Piso] -> [Int]
valor [] = []
valor (p:t) = case p of Terra ->  1 : valor t
                        Relva ->  0 : valor t
                        Lama  -> -1 : valor t
                        Boost ->  3 : valor t
                        Cola  -> -3 : valor t
                        Estrada -> 2 : valor t

-- Função que vai buscar as peças que tem de comparar 
pecacomparavel :: Mapa -> Jogador -> [Peca]
pecacomparavel [] _ = []
pecacomparavel (h:t) j = (take y h) ++ (pecacomparavel t j)
                     where y = pistaJogador j 

-- Função que compara colunas conforme o piso
comparapiso :: Mapa -> [Peca] -> Int
comparapiso m []    = 0
comparapiso m l = compara (valor (pecatopiso l))

-- Função que compara valor dos pisos das peças selecionadas
compara :: [Int] -> Int
compara [x] = x
compara [x,y]    | x > y                          = x
                 | otherwise                      = y
compara (x:y:z)  | (x < y) && (y > compara (y:z)) = y
                 | (x > y) && (x > compara (x:z)) = x
                 | otherwise                      = compara z

-- Função que analisa a posição da melhor pista

melhorpista :: Int -> [Int] -> Int -- ^ Melhor pista
melhorpista a [] = 0
melhorpista a (h:t) | a == h    = 0 
                    | otherwise = 1 + melhorpista a t

-- Função que tendo em conta a melhor pista, decide a jogada que o bot deverá fazer.
movimento :: Int -> Jogador -> Maybe Jogada
movimento x j | x == 0    = Just Acelera
              | otherwise = movimentoaux x y 
              where y  = pistaJogador j

-- Função que determina a jogada que o bot deverá fazer tendo em conta a diferença entre a posição do jogador
-- e a melhor pista.

movimentoaux :: Int -> Int -> Maybe Jogada
movimentoaux x y | x - y > 0 = Just (Movimenta C)
                 | x - y < 0 = Just (Movimenta B)
                 | x - y == 0 = Just Acelera 

-- Função que, tendo em conta o enunciado da tarefa 4, toma decisões do jogador no ar.
decisaoar :: Jogador -> Mapa -> Maybe Jogada
decisaoar j m | i - (inclinacao p) < 15   = Just (Movimenta E)
              | i - (inclinacao p) > 15   = Just (Movimenta D)
              | otherwise                 = Nothing 
              where i = inclinacaoJogador (estadoJogador j)
                    p = peca j m
