{- |

= Introdução

Nesta tarefa o objetivo é reagir à passagem to tempo tendo em conta que o problema está dividido para a atualização
da velocidade e para a movimentação do jogador tendo em conta a velocidade atualizada.
 
= Raciocínio

Tendo em conta o enunciado da tarefa começamos por definir funções que alterassem a velocidade e funções que analisassem
as situações que estavam explicitas no enunciado para a movimentação do jogador. Para tal optamos por uma abordagem
matemática (trignométrica) das situações e transições explicitadas no enunciado. 

= Discussão e Conclusão

Nesta tarefa consideramos que o mais difícil foi compreender, visualizar e representar algumas situações e transições que
exigiam de nós uma maior compreensão de problemas em termos de análise trignométrica para os vetores velocidade.
Por outro lado a nossa qualidade de código não está como desejamos porque não simplificamos devidamente o código. 

-}

-- Este módulo define funções comuns da Tarefa 4 do trabalho prático.
module Tarefa4_2019li1g107 where

import LI11920
import Tarefa0_2019li1g107
import Tarefa2_2019li1g107
import Tarefa1_2019li1g107

-- * Testes
-- | Testes unitários da Tarefa 4.
--
-- Cada teste é um par (/tempo/,/'Mapa'/,/'Jogador'/).
testesT4 :: [(Double,Mapa,Jogador)]
testesT4 = [(1.0, [[Recta Terra 0,Recta Boost 0,Recta Lama 0,Recta Relva 0,Recta Terra 0]], Jogador 0 1 1 0 (Ar 0.5 0 1)),
            (1.0, [[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0]], Jogador 0 1.5 1 0 (Chao True)),
            (1.0, [[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0]], Jogador 0 1.5 1 0 (Ar 3 0 1)),
            (0.3, [[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0]], Jogador 0 1.5 0 0 (Morto 1.0)),
            (0.1, [[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0]], Jogador 0 1.5 1 0 (Chao True)),
            (1.0, [[Recta Terra 0, Rampa Terra 0 2, Rampa Terra 2 4, Rampa Terra 4 6]], Jogador 0 1.5 1 0 (Chao True)),
            (1.0, [[Recta Terra 0, Rampa Terra 0 2, Rampa Terra 2 4, Rampa Terra 4 6]], Jogador 0 1.5 2 0 (Ar 2 30 2)),
            (1.0, [[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0]], Jogador 0 1 1 0 (Ar 0.5 80 1)),
            (1.0, [[Recta Terra 0,Recta Terra 0,Rampa Terra 0 2, Rampa Terra 2 0, Recta Terra 0]], Jogador 0 2.5 1 0 (Chao True)),
            (1.0, [[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0]], Jogador 0 1.5 0 0 (Morto 0.8)),
            (0.1, [[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0]], Jogador 0 1.5 1 0 (Ar 3 0 1)),
            (1.0, [[Recta Terra 0,Recta Terra 0,Rampa Terra 0 2, Rampa Terra 2 0, Rampa Terra 0 2]], Jogador 0 3.7 1 0 (Chao True))]

-- * Funções principais da Tarefa 4.

-- | Avança o estado de um 'Jogador' um 'passo' em frente, durante um determinado período de tempo.
passo :: Double -- ^ O tempo decorrido.
      -> Mapa    -- ^ O mapa utilizado.
      -> Jogador -- ^ O estado anterior do 'Jogador'.
      -> Jogador -- ^ O estado do 'Jogador' após um 'passo'.
passo t m j = move t m (acelera t m j)

-- | Altera a velocidade de um 'Jogador', durante um determinado período de tempo.
acelera :: Double -- ^ O tempo decorrido.
        -> Mapa    -- ^ O mapa utilizado.
        -> Jogador -- ^ O estado anterior do 'Jogador'.
        -> Jogador -- ^ O estado do 'Jogador' após acelerar.
acelera t m j | estadoChao j == True = j {velocidadeJogador = velocidadeChao t m j}
              | estadoAr j   == True = j {velocidadeJogador= velocidadeAr t j} {estadoJogador = gravidadeAr t (estadoJogador j)}
              | otherwise            = j

-- | Altera a posição de 'Jogador', durante um determinado período de tempo.
move :: Double -- ^ O tempo decorrido.
     -> Mapa    -- ^ O mapa utilizado.
     -> Jogador -- ^ O estado anterior do 'Jogador'.
     -> Jogador -- ^ O estado do 'Jogador' após se movimentar.
move t m j | estadoChao j == True = moveChao t m j
           | estadoAr j == True = moveAr t m j
           | otherwise = moveMorto t j

-- | Função que determina a aceleração no chão
velocidadeChao :: Double -> Mapa -> Jogador -> Double 
velocidadeChao t m j = if a < 0 then 0 else a
                    where
                    v = velocidadeJogador (j)
                    a = v + ((accelMota - atrito * v) * t)
                    accelMota= if (v < 2 && accelJogador) then 1 else 0 
                    accelJogador = if (aceleraJogador) (estadoJogador (j)) == True then True else False
                    atrito = findatrito (peca j m)

-- | Função que determina o valor do atrito tendo em conta o piso
findatrito :: Peca -> Double
findatrito (Rampa piso x _) = findatrito (Recta piso x)
findatrito (Recta piso _)   = case piso of
                             Terra ->    0.25
                             Relva ->    0.75
                             Lama  ->    1.50
                             Boost -> - (0.5)
                             Cola  ->    3.0
			     Estrada -> 0

-- | Função que encontra a peça em que o jogador se encontra.
peca :: Jogador -> Mapa -> Peca
peca j m = encontraPosicaoMatriz0 (x,y) m
            where 
                x = pistaJogador (j)
                y = floor (distanciaJogador (j))

-- | Função que determina a aceleração no ar
velocidadeAr :: Double -> Jogador -> Double
velocidadeAr t j = if a < 0 then 0 else a
                   where 
                    a = v - (0.125 * v * t) -- Cálculo da aceleração tendo em conta que valor da resistência do ar = 0,125
                    v = velocidadeJogador (j)

-- | 
gravidadeAr :: Double -> EstadoJogador -> EstadoJogador
gravidadeAr t (Ar h i g) = Ar h i (g + t)
gravidadeAr _ _ = Chao True


-- | Função que dado o tempo e o Jogador vê a distância percorrida no instante de tempo dado.
distancia :: Double -> Jogador -> Double
distancia t j = v * t
              where 
               v = velocidadeJogador (j)

-- | Função geral move direcionada para quando o jogador está no chão.
moveChao :: Double -> Mapa -> Jogador -> Jogador
moveChao t m j | ficaNaPecaOuNao p y d = chaopeca p d j
               | otherwise = chaoProxPeca j m    
               where
                p = peca j m
                y = snd (properFraction (distanciaJogador (j)))
                d = distancia t j 

-- | Função que testa se o jogador fica na mesma peça ou avança.
ficaNaPecaOuNao :: Peca -> Double -> Double -> Bool
ficaNaPecaOuNao (Recta _ _) y d   | ( y + d ) < 1 = True
                                  | otherwise     = False
ficaNaPecaOuNao (Rampa p a b) y d | f + d < hip   = True
                                  | otherwise     = False  
                                    where
                                      f   = y / (cos ((inclinacao (Rampa p a b)*pi/180))) 
                                      hip = sqrt(1 + ((abs(fromIntegral(b-a)))^2))

-- | Dado um jogador e o mapa, descobre a peça atual e a peça imediatamente a seguir.
descobrirPeca :: Jogador -> Mapa -> [Peca]
descobrirPeca j m = [findPeca y (findPista x m)] ++ [findPeca (y+1) (findPista x m)]
                     where
                         y = distanciaJogador (j)
                         x = pistaJogador (j)


-- | Função que representa o caso de o jogador se manter na mesma peça mas aumentar na distância.
chaopeca :: Peca -> Double -> Jogador -> Jogador
chaopeca (Recta _ _) d j    = j {distanciaJogador = y + d} 
                    where
                      y     = distanciaJogador (j)
chaopeca (Rampa p a b) d j  = j {distanciaJogador = y + (distanciaIfRampa (Rampa p a b) d)}   
                    where
                      y     = distanciaJogador (j)

-- | Função que calcular a distância entre início e fim da rampa.
distanciaIfRampa :: Peca -> Double -> Double
distanciaIfRampa p d = cos ((inclinacao p)* pi / 180) * d 

-- | Função que calcula a inclinação da peça
inclinacao :: Peca -> Double
inclinacao (Recta _ _) = 0
inclinacao (Rampa _ a b) | a < b = ((atan(abs (fromIntegral (b - a))))*180)/pi
                         | otherwise = - (((atan(abs (fromIntegral (b - a))))*180)/pi)

-- | Função que representa o caso do jogador transitar para a peça seguinte.
chaoProxPeca :: Jogador -> Mapa -> Jogador
chaoProxPeca j m | inclinacao a > inclinacao b = j {estadoJogador = Ar (auxAltura j1 m) (inclinacao a) 0 }{distanciaJogador= fromIntegral(floor y) +1 }
                 | otherwise = j {distanciaJogador= fromIntegral(floor y) +1 }
                     where
                         j1 = j {distanciaJogador= fromIntegral(floor y) +1  }
                         a = head (descobrirPeca j m)
                         b = head (tail (descobrirPeca j m))
                         y = distanciaJogador (j)

-- | Função geral Move direcionada para quando o jogador está morto
moveMorto :: Double -> Jogador -> Jogador
moveMorto t j | k - t > 0 = j {estadoJogador= Morto (k-t)}
              | otherwise = j {velocidadeJogador= 0}{estadoJogador= Chao {aceleraJogador = False}}
                where
                k = timeoutJogador (estadoJogador (j))

-- |Função geral Move direcionada para quando o jogador está morto
moveAr :: Double -> Mapa -> Jogador -> Jogador
moveAr t m j = if compararPontosAr p m j then posicaoFinalAr r vf j else intersecaoArPeca t m j pc
             where
                r  = retaMovimento t j
                pc = pontodeColisao t j m 
                p  = distanciaTotal t j
                vf = (somaVetores (vetorPosicaoInicial j) (multiplicaVetor t (vetorFinal (transformaremVetor j))))

-- |Dado um jogador devolve uma lista de Vetor com o vetor da velocidade e o vetor da Gravidade.
transformaremVetor :: Jogador -> [Vetor]
transformaremVetor j = [Polar v i] ++ [Polar g (-90)]
                      where 
                        v = velocidadeJogador (j)
                        i = inclinacaoJogador (estadoJogador (j))
                        g = gravidadeJogador (estadoJogador(j))

-- |Soma de vetores do vetor velocidade com o vetor gravidade para dar vetor final.
vetorFinal :: [Vetor] -> Vetor
vetorFinal [] = Cartesiano 0 0 
vetorFinal (h:t) = (somaVetores (h) (head t))

-- |Dado um jogador devolve o vetor que corresponde à posição inicial do Jogador.
vetorPosicaoInicial :: Jogador -> Vetor
vetorPosicaoInicial j  = Cartesiano y a
                where
                    y = distanciaJogador j
                    a = alturaJogador $ estadoJogador j

-- |Função que dado um jogador devolve uma Reta que corresponde à Reta da trajetória efetuada pelo Jogador.                 
retaMovimento :: Double -> Jogador -> Reta
retaMovimento t j = (a,somaVetores a b)
                      where
                        a = vetorPosicaoInicial j
                        b = vetorFinal (transformaremVetor j)

-- |Função que dado um Jogador e um Mapa devolve uma Reta que corresponde à Reta do Ponto inicial da Peca com o final
retaPeca :: Jogador -> Mapa -> Reta
retaPeca j m = (Cartesiano (aux 0 y) (auxAltura j1 m), Cartesiano (aux 0 (y+1)) (auxAltura j2 m))
               where
                y = distanciaJogador (j)
                j1 = j {distanciaJogador = aux 0 y}
                j2 = j {distanciaJogador = aux 0 (y+1)}
                aux :: Double -> Double -> Double
                aux x y | y >= 1 = aux (x+1) (y-1)
                        | otherwise = x
-- |Dado o tempo e o jogador, calcula a distância total percorrida no Ar
distanciaTotal :: Double -> Jogador -> Ponto
distanciaTotal t j = somaVetores x y 
                where
                  x = vetorPosicaoInicial j
                  y = multiplicaVetor t (vetorFinal (transformaremVetor j))

-- |Dado ponto final do vetor movimento, verifica se esse valor se encontra no Ar ou "subterrado"                  
compararPontosAr :: Ponto -> Mapa -> Jogador-> Bool
compararPontosAr (Cartesiano a b) m j | b <= auxAltura j {distanciaJogador = a} m = False
                                      | otherwise = True
compararPontosAr _ _ _ = True

-- |se o jogador não colidar com o Chao, então dado a retaMovimento, o vetor Movimento e o Jogador devolve um jogador com a posição devidamente atualizada                                    
posicaoFinalAr :: Reta -> Vetor -> Jogador -> Jogador
posicaoFinalAr r (Cartesiano a b) j | (floor a) /= (floor y) = j {distanciaJogador= 1 + fromIntegral(floor y)}{estadoJogador= e1}
                                    | otherwise = j {distanciaJogador = a}{estadoJogador= e}
                                  where
                                    y = distanciaJogador (j)
                                    e = (estadoJogador (j)) {alturaJogador = b}
                                    e1 = (estadoJogador (j)) {alturaJogador = descobrirALturaAr j r} 
posicaoFinalAr _ _ j = j

-- |caso o Jogador passe para a proxima peça, então será necessário calcular a altura em que o jogador interceta o inicio da prox Peca                                   
descobrirALturaAr :: Jogador -> Reta -> Double
descobrirALturaAr j r  = t2 (intersecao r (auxReta j))
                       where
                        t2 :: Ponto -> Double
                        t2 (Cartesiano _ b) = b 
                        t2 (Polar _ _) = 0
                        auxReta :: Jogador -> Reta
                        auxReta j1 = (Cartesiano x 0, Cartesiano x 1)
                                  where
                                    x = (fromIntegral (floor y)) + 1
                                    y = distanciaJogador j1

-- |caso o Jogador colida com o Chao, então será necessário saber o sitio exato de embate tal como a nova situação do jogador                                   
intersecaoArPeca :: Double -> Mapa -> Jogador -> Ponto -> Jogador
intersecaoArPeca t m j (Cartesiano a _) = if compararInclinacaoMorto j p == True then j{distanciaJogador=a}{estadoJogador= Morto 1.0}{velocidadeJogador=0}
                                          else j {distanciaJogador=a} {estadoJogador= Chao False}{velocidadeJogador= velocidadeIfArtoChao p ij d }
                       where
                        ij = inclinacaoJogador (estadoJogador (j))
                        d = distancia t j
                        p = peca j m
intersecaoArPeca _ _ j _ = j
                        
-- |função auxiliar que dado o Tempo, um Jogador e um Mapa, devolve o Ponto de interseção de duas retas, Reta do Movimento do Jogador e a Reta da inclinação da Peca
pontodeColisao :: Double -> Jogador -> Mapa -> Ponto
pontodeColisao t j m = intersecao x y
                   where
                    x = retaMovimento t j
                    y = retaPeca j m
        
-- |função auxiliar que compara a a inclinação do Jogador com a inclinação da peça em que ele vai embater                 
compararInclinacaoMorto :: Jogador -> Peca -> Bool
compararInclinacaoMorto  j p = if (ij - ip) >= 45 || (ij - ip) <= -45  then True else False
                             where
                                ij = inclinacaoJogador (estadoJogador j)
                                ip = inclinacao p 
            
-- |velocidade do Jogador quando está no ar e embate no chão 
velocidadeIfArtoChao :: Peca -> Double -> Double -> Double
velocidadeIfArtoChao p ij d = cos ((abs(ij-inclinacao p))*pi/180) * d
