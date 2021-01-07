-- | Este módulo define funções genéricas sobre vetores e matrizes, que serão úteis na resolução do trabalho prático.

module Tarefa0_2019li1g107 where

-- Funções não-recursivas.


data Ponto = Cartesiano Double Double | Polar Double Angulo deriving (Show)

type Angulo = Double

-- Funções sobre vetores

type Vetor = Ponto

-- POLAR PARA CARTESIANO --

tocartesiano :: Vetor -> Vetor
tocartesiano (Cartesiano x y) = Cartesiano x y 
tocartesiano (Polar r t)      = Cartesiano (r * cos(t * pi / 180)) (r * sin(t * pi / 180))

topolar :: Vetor -> Vetor
topolar (Polar r t)      = Polar r t
topolar (Cartesiano x y) = Polar (sqrt(x^2 + y^2)) (atan (y/x))

somaVetores :: Vetor -> Vetor -> Vetor
somaVetores a b =
          let 
              (Cartesiano x1 y1) = tocartesiano a 
              (Cartesiano x2 y2) = tocartesiano b
          in 
              (Cartesiano (x1+x2) (y1+y2))


subtraiVetores :: Vetor -> Vetor -> Vetor
subtraiVetores a b =
          let 
              (Cartesiano x1 y1) = tocartesiano a 
              (Cartesiano x2 y2) = tocartesiano b
          in 
              (Cartesiano (x1-x2) (y1-y2))

multiplicaVetor :: Double -> Vetor -> Vetor
multiplicaVetor n a      = 
           let 
              (Cartesiano x y) = tocartesiano a 
           in 
              (Cartesiano (x * n) (y * n))

-- Funções sobre rectas.

type Reta = (Ponto,Ponto)

intersetam :: Reta -> Reta -> Bool
intersetam x y        = (ta >= 0 && ta <= 1) && (tb >= 0 && tb <= 1)
        where (ta,tb) = aux x y

aux :: Reta -> Reta -> (Double, Double)
aux (a,b) (c,d) = (ta,tb)
        where
            (Cartesiano x1 y1) = tocartesiano a
            (Cartesiano x2 y2) = tocartesiano b  
            (Cartesiano x3 y3) = tocartesiano c
            (Cartesiano x4 y4) = tocartesiano d
            e  = (x4-x3)*(y1-y2) - (x1-x2)*(y4-y3)
            ta = ( (y3-y4)*(x1-x3) + (x4-x3)*(y1-y3) ) / e
            tb = ( (y1-y2)*(x1-x3) + (x2-x1)*(y1-y3) ) / e
                       
intersecao :: Reta -> Reta -> Ponto
intersecao (p1,p2) r2@(p3,p4) = somaVetores p1 (multiplicaVetor ta (subtraiVetores p2 p1))
           where (ta,tb) = aux (p1,p2) r2

-- Funções sobre listas

-- Funções não disponíveis no 'Prelude', mas com grande utilidade.

eIndiceListaValido :: Int -> [a] -> Bool
eIndiceListaValido _ [] = False
eIndiceListaValido x l  | x >= 0 && x < length l = True
                        | otherwise = False

-- Funções sobre matrizes.

-- *** Funções gerais sobre matrizes.

type DimensaoMatriz = (Int,Int)

type PosicaoMatriz = (Int,Int)

type Matriz a = [[a]]


dimensaoMatriz :: Matriz a -> DimensaoMatriz
dimensaoMatriz [] = (0,0)
dimensaoMatriz ([]:xs) = (0,0)
dimensaoMatriz l = (length l, length (head l))

-- | Verifica se a posição pertence à matriz.
ePosicaoMatrizValida :: PosicaoMatriz -> Matriz a -> Bool 
ePosicaoMatrizValida (x,y) l | (length l > 0) && (x < length l) && (y < length (head l)) = True
                             | otherwise = False

-- * Funções recursivas.

-- ** Funções sobre ângulos

-- | Normaliza um ângulo na gama [0..360).
--  Um ângulo pode ser usado para representar a rotação
--  que um objecto efectua. Normalizar um ângulo na gama [0..360)
--  consiste, intuitivamente, em extrair a orientação do
--  objecto que resulta da aplicação de uma rotação. Por exemplo, é verdade que:
--
-- prop> normalizaAngulo 360 = 0
-- prop> normalizaAngulo 390 = 30
-- prop> normalizaAngulo 720 = 0
-- prop> normalizaAngulo (-30) = 330

normalizaAngulo :: Angulo -> Angulo
normalizaAngulo x | x >= 0 && x <= 359 = x
                  | x >= 360 = normalizaAngulo (x - 360)
                  | x <= 0 = normalizaAngulo (x + 360)
                  | otherwise = x

-- ** Funções sobre listas.

-- | Devolve o elemento num dado índice de uma lista.
--
-- __Sugestão:__ Não use a função (!!) :: [a] -> Int -> a :-)

encontraIndiceLista :: Int -> [a] -> a
encontraIndiceLista 0 (h:t) = h
encontraIndiceLista x (h:t) | x > 0 = encontraIndiceLista (x-1) t

-- | Modifica um elemento num dado índice.
--
-- __NB:__ Devolve a própria lista se o elemento não existir.
atualizaIndiceLista :: Int -> a -> [a] -> [a]
atualizaIndiceLista 0 x (h:t) = x:t
atualizaIndiceLista i x (h:t) = h : (atualizaIndiceLista (i-1) x t)

-- ** Funções sobre matrizes.

-- | Devolve o elemento numa dada 'Posicao' de uma 'Matriz'.
encontraPosicaoMatriz :: PosicaoMatriz -> Matriz a -> a
encontraPosicaoMatriz (x,y) l = encontraIndiceLista y (encontraIndiceLista x l)

-- | Modifica um elemento numa dada 'Posicao'
--
-- __NB:__ Devolve a própria 'Matriz' se o elemento não existir.
atualizaPosicaoMatriz :: PosicaoMatriz -> a -> Matriz a -> Matriz a
atualizaPosicaoMatriz (0,y) n (h:t) = (atualizaIndiceLista y n h):t
atualizaPosicaoMatriz (x,y) n (h:t) = h : (atualizaPosicaoMatriz (x-1,y) n t)

