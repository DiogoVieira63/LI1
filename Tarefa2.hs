{- |

= Introdução

Nesta tarefa temos como objetivo implementar funções que, perante determinada jogada determina o efeito da mesma
no estado do jogo. 

data Direcao = C | D | B | E
data Jogada = Movimenta Direcao | Acelera | Desacelera | Dispara

O estado do jogo consiste num mapa e nas informações acerca dos jogadores. 

data Estado = Estado
    { mapaEstado      :: Mapa
    , jogadoresEstado :: [Jogador] }

Cada jogador é caracterizado pelo seu índice na lista, pela pista em que se encontra, distância que percorreu,
a sua velocidade atual, as colas que pode disparar bem como o estado atual que consiste em indicar se o jogador
está vivo no chão, morto no chão ou no ar com determinada altura e inclinação.

Concluindo, nesta tarefa pretende-se definir a função jogada que, para determinado jogador e determinada jogada,
atualiza o estado. 

= Discussão e Conclusão

Nesta tarefa reconhecemos que, através dos sistemas de avaliação fornecidos pelo professor a nossa qualidade de 
código ficou muito aquém do que era esperado e do que desejaríamos por erros como redundâncias, excesso de 
condicionais e uma simplificação de código ineficiente. 


-}


-- Este módulo define funções comuns da Tarefa 2 do trabalho prático.
module Tarefa2 where

import LI11920
import Tarefa0
import Tarefa1

-- * Testes
testesT2 :: [(Int,Jogada,Estado)]
testesT2 = [(0,Dispara, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,(Movimenta C), Estado {mapaEstado = ((gera 2 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 1, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}},Jogador {pistaJogador = 0, distanciaJogador = 1.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,(Movimenta B), Estado {mapaEstado = ((gera 2 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}},Jogador {pistaJogador = 0, distanciaJogador = 1.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,Movimenta E, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Ar { alturaJogador = 1, inclinacaoJogador = 1, gravidadeJogador = 0}}]}),
           (0,Movimenta D, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Ar { alturaJogador = 1, inclinacaoJogador = 1, gravidadeJogador = 0}}]}),
           (0,Acelera, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,Desacelera, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = True}}]}),
           (0,(Movimenta B), Estado {mapaEstado = ((gera 2 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 1, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Morto {timeoutJogador = 1.0}},Jogador {pistaJogador = 0, distanciaJogador = 1.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,Movimenta E, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = True}}]}),
           (0,Movimenta D, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = True}}]}),
           (0,Dispara, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Morto {timeoutJogador = 1.0}}]}),
           (0,(Movimenta C), Estado {mapaEstado = [[Recta Terra 0, Rampa Terra 0 1, Recta Terra 1, Recta Terra 1, Recta Terra 1],[Recta Terra 0, Rampa Terra 0 2, Rampa Terra 2 0, Recta Terra 0, Recta Terra 0]] , jogadoresEstado = [Jogador {pistaJogador = 1, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = True}},Jogador {pistaJogador = 0, distanciaJogador = 1.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,Dispara, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 0, estadoJogador = Chao {aceleraJogador = True}}]}),
           (1,(Movimenta C), Estado {mapaEstado = [[Recta Terra 0, Rampa Terra 0 5, Recta Terra 5, Recta Terra 5, Recta Terra 5],[Recta Terra 0, Rampa Terra 0 2, Rampa Terra 2 0, Recta Terra 0, Recta Terra 0]] , jogadoresEstado = [Jogador {pistaJogador = 1, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = True}},Jogador {pistaJogador = 1, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (1,(Movimenta B), Estado {mapaEstado = [[Recta Terra 0, Rampa Terra 0 5, Recta Terra 5, Recta Terra 5, Recta Terra 5],[Recta Terra 0, Rampa Terra 0 2, Rampa Terra 2 0, Recta Terra 0, Recta Terra 0]] , jogadoresEstado = [Jogador {pistaJogador = 1, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = True}},Jogador {pistaJogador = 0, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,Acelera, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Morto {timeoutJogador = 1.0}}]}),
           (0,Desacelera, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Morto {timeoutJogador = 1.0}}]}),
           (0,(Movimenta B), Estado {mapaEstado = [[Recta Terra 0, Rampa Terra 0 5, Recta Terra 5, Recta Terra 5, Recta Terra 5],[Recta Terra 0, Rampa Terra 0 1, Rampa Terra 1 0, Recta Terra 0, Recta Terra 0]] , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 1.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = True}},Jogador {pistaJogador = 1, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,(Movimenta B), Estado {mapaEstado = [[Recta Terra 0, Rampa Terra 0 5, Rampa Terra 5 0, Recta Terra 0, Recta Terra 0],[Recta Terra 0, Rampa Terra 0 1, Rampa Terra 1 0, Recta Terra 0, Recta Terra 0]] , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = True}},Jogador {pistaJogador = 1, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,(Movimenta C), Estado {mapaEstado = [[Recta Terra 0, Rampa Terra 0 1, Rampa Terra 1 0, Recta Terra 0, Recta Terra 0],[Recta Terra 0, Rampa Terra 0 5, Recta Terra 5, Rampa Terra 5 0, Recta Terra 0]] , jogadoresEstado = [Jogador {pistaJogador = 1, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = True}},Jogador {pistaJogador = 0, distanciaJogador = 1.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,(Movimenta B), Estado {mapaEstado = [[Recta Terra 0, Rampa Terra 0 1, Rampa Terra 1 0, Recta Terra 0, Recta Terra 0],[Recta Terra 0, Rampa Terra 0 5, Recta Terra 5, Rampa Terra 5 0, Recta Terra 0]] , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = True}},Jogador {pistaJogador = 1, distanciaJogador = 2.5, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,Dispara, Estado {mapaEstado = [[Recta Terra 0, Rampa Terra 0 1, Rampa Terra 1 2,Rampa Terra 2 3], [Recta Terra 0, Rampa Terra 0 1, Rampa Terra 1 2,Rampa Terra 2 3]] , jogadoresEstado = [Jogador {pistaJogador = 1, distanciaJogador = 3.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,Movimenta E, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Ar { alturaJogador = 1, inclinacaoJogador = 78, gravidadeJogador = 0}}]}),
           (0,Movimenta D, Estado {mapaEstado = ((gera 1 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Ar { alturaJogador = 1, inclinacaoJogador = (-78), gravidadeJogador = 0}}]}),
           (0,Dispara, Estado {mapaEstado = (gera 1 5 1), jogadoresEstado = [Jogador {pistaJogador = 0, distanciaJogador = 0.9, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Chao {aceleraJogador = False}}]}),
           (0,(Movimenta C), Estado {mapaEstado = ((gera 2 5 1)) , jogadoresEstado = [Jogador {pistaJogador = 1, distanciaJogador = 2.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Morto {timeoutJogador = 1.0}},Jogador {pistaJogador = 0, distanciaJogador = 1.1, velocidadeJogador = 1.0, colaJogador = 5, estadoJogador = Morto {timeoutJogador= 1.0}}]})]

-- | Testes unitários da Tarefa 2.
--
-- Cada teste é um triplo (/identificador do 'Jogador'/,/'Jogada' a efetuar/,/'Estado' anterior/).
jogada :: Int -- ^ O identificador do 'Jogador' que efetua a jogada.
      -> Jogada -- ^ A 'Jogada' a efetuar.
      -> Estado -- ^ O 'Estado' anterior.
      -> Estado -- ^ O 'Estado' resultante após o jogador efetuar a jogada.
jogada x y (Estado m js) | y == Acelera = Estado m (atualizaIndiceLista x (acelera1(k)) js)
                         | y == Desacelera = Estado m (atualizaIndiceLista x (desacelera(k)) js)
                         | y == Movimenta C = Estado m (atualizaIndiceLista x (movimentaC (k) m)js)
                         | y == Movimenta B = Estado m (atualizaIndiceLista x (movimentaB (k) m)js)
                         | y == Movimenta D = Estado m (atualizaIndiceLista x (movimentalateral 1 (k))js)
                         | y == Movimenta E = Estado m (atualizaIndiceLista x (movimentalateral 0 (k))js)
                         | otherwise = Estado (if estadoChao k == True then changeMapa (k) m else m) (atualizaIndiceLista x (fdispara (k)) js) 
                          where 
                              k = mostraJogador x js

-- | Função que encontra o jogador pedido na lista de jogadores
mostraJogador :: Int -- ^ Identificador do jogador
                 -> [Jogador] -- ^ Lista de jogadores
                 -> Jogador -- ^ Jogador 
mostraJogador x (h:t) | x > 0 = mostraJogador (x-1) t
                      | otherwise = h

-- *** Estado do Jogador                      
-- | Função que analisa se o jogador está no chão.
estadoChao :: Jogador -> Bool 
estadoChao (Jogador _ _ _ _ (Chao _)) = True 
estadoChao (Jogador _ _ _ _ _) = False 

-- | Função que analisa se o jogador está no ar.
estadoAr :: Jogador -> Bool
estadoAr (Jogador _ _ _ _(Ar _ _ _)) = True
estadoAr (Jogador _ _ _ _ _) = False

-- *** Acelerar e Desacelerar
-- | Dado um jogador verifica se o jogador está no chão, se sim altera/mantém o estado do Jogador para (Chao True), se não devolve o mesmo estado.
acelera1 :: Jogador -> Jogador 
acelera1 j = if estadoChao j  == True then j {estadoJogador = Chao True}
                                     else j

-- | Dado um jogador verifica se o jogador está no chão, se sim altera/mantém o estado do Jogador para (Chao False), se não devolve o mesmo estado.
desacelera :: Jogador -> Jogador 
desacelera j = if estadoChao j == True then j {estadoJogador = Chao False} 
                                       else j
-- *** Movimentos C e Movimenta B
-- | Função que define a movimentação para cima.
movimentaC :: Jogador -> Mapa -> Jogador 
movimentaC j l = if estadoChao j == True && (x /= 0) then 
                               (if mortoOuAr 0 j l == True then 
                                           (if auxAltura j l < auxAltura j {pistaJogador = x-1} l then j {estadoJogador = Morto 1.0}{velocidadeJogador= 0}
                                                                                                  else j {pistaJogador = x-1} {estadoJogador = findInclinacao j l})
                                                           else j {pistaJogador= x-1})
                                   else j
               where 
                 x = pistaJogador (j)

-- | Função que define a movimentação para baixo. 
movimentaB :: Jogador -> Mapa -> Jogador 
movimentaB j l = if estadoChao j == True  && x /= (length l -1 )then 
                                                   (if mortoOuAr 1 j l == True then 
                                                                           (if auxAltura j l < auxAltura j {pistaJogador = x+1} l then j {velocidadeJogador = 0} {estadoJogador = Morto 1.0}
                                                                                                                                  else j {pistaJogador= x+1 }{estadoJogador= findInclinacao j l})
                                                                                                  else j {pistaJogador = x+1} )
                                                                                 else j
                where 
                 x= pistaJogador (j)
                  
-- | Função vê se o jogador morre ou fica no ar tendo em conta as condições ditas no enunciado. 

mortoOuAr :: Int -- ^ 0 para o Movimenta C, 1 para Movimenta B
              -> Jogador -> Mapa -> Bool
mortoOuAr a j l = if a == 0 then 
               (if diferencaAlturas (aux1 y) (alturaMC j l) > 0.2 then True 
                                                                    else False) 
          else (if diferencaAlturas (aux1 y) (alturaMB j l) > 0.2 then True 
                                                                 else False)
                  where
                   y = distanciaJogador (j)
                   aux1 :: Double -> Double 
                   aux1 x | x >= 1 = aux1 (x-1)
                         | otherwise = x 

-- | Função que encontra a inclinação do jogador

findInclinacao :: Jogador -> Mapa -> EstadoJogador 
findInclinacao j l   | a < b =  Ar c (g) 0
                     | a > b =  Ar c (-(g)) 0
                     | a == b = Ar c 0 0
                    where 
                      a = fst (findTudo (j) l)
                      b = snd (findTudo (j) l)
                      c = auxAltura (j) l
                      g = ((atan(abs (fromIntegral (b - a))))*180)/pi

-- *** Movimento D e Movimenta E 
-- | Função que define a movimentação lateral                       
movimentalateral :: Int -- ^ 0 para o Movimenta E, 1 para Movimenta D
                    -> Jogador -> Jogador 
movimentalateral a j | estadoAr j == True = j {estadoJogador = inclinacaofinal a p}
                     | otherwise = j
                      where 
                        p = estadoJogador (j)

-- | Função que altera a inclinação do jogador 
inclinacaofinal :: Int -> EstadoJogador -> EstadoJogador
inclinacaofinal a (Ar y i p ) | a == 0 = if x < 75 then Ar y (x + 15) p else Ar y 90 p
                              | otherwise = if x > -75 then Ar y (x - 15) p else Ar y (-90) p  
                              where 
                                x = normalizaAngulo1 i

-- | Função que normaliza o ângulo para desejado
normalizaAngulo1 :: Angulo -> Angulo
normalizaAngulo1 x | x >= -90 && x <= 90 = x
                  | x >= 270 = normalizaAngulo1 (x - 360)
                  | x <= -(270) = normalizaAngulo1 (x + 360)
                  | otherwise = x


-- *** Altura                             
-- | Função que encontra a altura do jogador
auxAltura :: Jogador -> Mapa -> Double
auxAltura j l = aux (snd(properFraction y)) (findTudo j l)
             where 
               y = distanciaJogador (j)

               aux :: Double -> (Int,Int) -> Double
               aux x (a,b) | a > b = (fromIntegral a - (x * (abs (fromIntegral(a - b)))))
                           | a < b = (fromIntegral a + (x * (abs (fromIntegral(a - b)))))
                           | otherwise = fromIntegral a 

-- | Função que encontra altura da peça atual e a peça da pista anterior
alturaMC :: Jogador -> Mapa -> [(Int,Int)]
alturaMC j l = [findTudo j l] ++ [findTudo j {pistaJogador= x - 1}  l]
              where 
               x = pistaJogador (j) 

-- | Função que encontra altura da peça atual e a peça da pista seguinte
alturaMB :: Jogador -> Mapa -> [(Int,Int)]
alturaMB j l = [findTudo j l] ++ [findTudo j {pistaJogador = x + 1 } l]
             where 
             x = pistaJogador (j)

-- | Função que junta as funções abaixo numa só 
findTudo :: Jogador -> Mapa -> (Int,Int)
findTudo j l = altura (findPeca y (findPista x l))
             where 
             y = distanciaJogador (j)
             x = pistaJogador (j)

-- | Função que identifica a pista em que nos encontramos.
findPista :: Int -> Mapa -> Pista
findPista x (h:t) | x > 0 = findPista (x-1) t
                  | otherwise = h

-- | Função que identifica na pista, em que peça nos encontramos.
findPeca :: Double -> Pista -> Peca
findPeca y (h:t) | y >= 1 = findPeca (y-1) t
                 | otherwise = h

-- | Função que devolve a altura da peça.
altura :: Peca -> (Int,Int)
altura (Recta _ x) = (x,x)
altura (Rampa _ x y) = (x,y)

-- | Função que faz a diferença de duas altiras 
diferencaAlturas :: Double -> [(Int,Int)] -> Double
diferencaAlturas x ((a,b):(c,d):t) = abs ((aux x (a,b)) - (aux x (c,d)))
               where
              aux :: Double -> (Int,Int) -> Double
              aux x (a,b) | a > b = fromIntegral a -  x * fromIntegral (a-b)
                          | a < b = fromIntegral a +  x * fromIntegral (b-a)
                          | a == b = fromIntegral a

-- | Função que, quando o jogador dispara reduz o número de colas e, caso esteja na primeira peça ou não tenha colas, não dispara. 

-- *** Dispara
-- | Função que se o jogador apresentar as condições necessárias, retira uma cola do Jogador dado
fdispara :: Jogador -> Jogador
fdispara j | t == 0 = j
           | y < 1 = j
           | estadoChao j == True = j {colaJogador = t - 1}
           | otherwise = j
            where 
           t = colaJogador (j)
           y = distanciaJogador (j)

-- | Função que altera o mapa no caso do jogador disparar. 
changeMapa :: Jogador ->  Mapa -> Mapa
changeMapa j l | t == 0 = l
               | y < 1 = l
               | otherwise = atualizaPosicaoMatriz1 k r l
  where
   x = pistaJogador (j)
   y = distanciaJogador (j)
   t = colaJogador (j)
   k = (x, (aux 0 y)-1)
   r = encontraPosicaoMatriz0 k l
   aux :: Int -> Double -> Int
   aux x y | y >= 1 = aux (x+1) (y-1)
           | otherwise = x

-- ** Funções da Tarefa 0 adaptadas à Tarefa 2
atualizaPosicaoMatriz1 :: (Int,Int) -> Peca -> Mapa -> Mapa
atualizaPosicaoMatriz1 (0,y) n (h:t) = (atualizaPeca y n h):t
atualizaPosicaoMatriz1 (x,y) n (h:t) = h : (atualizaPosicaoMatriz1 (x-1,y) n t)

atualizaPeca:: Int -> Peca -> Pista -> Pista
atualizaPeca 0 (Recta _ x) (h:t) = (Recta Cola x):t
atualizaPeca 0 (Rampa _ x y) (h:t) = (Rampa Cola x y):t
atualizaPeca i x (h:t) = h : (atualizaPeca (i-1) x t)

encontraIndiceLista0 :: Int -> Mapa-> Pista
encontraIndiceLista0 0 (h:t) = h
encontraIndiceLista0 x (h:t) | x > 0 = encontraIndiceLista0 (x-1) t

encontraIndiceLista1:: Int -> Pista-> Peca
encontraIndiceLista1 0 (h:t) = h
encontraIndiceLista1 x (h:t) | x > 0 = encontraIndiceLista1 (x-1) t

encontraPosicaoMatriz0 :: (Int,Int) -> Mapa-> Peca
encontraPosicaoMatriz0 (x,y) l = encontraIndiceLista1 y (encontraIndiceLista0 x l)


