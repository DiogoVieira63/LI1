{- |

= Introdução

A tarefa 5 consiste na implementação do gráfico usando a biblioteca Gloss, tendo em conta todas as tarefas precedentes
bem como a tarefa 6 (implementação do bot).

= Objetivos

Tendo em conta que o Excite Bike foi um jogo que, por ter sido criado numa geração diferente, não fez parte da nossa 
geração pretendíamos adaptá-lo para algo que nos recordasse dos jogos que jogávamos quando mais novos. Assim, adotamos
um tema mais próximo de jogos como os presentes em MiniClip.com.

Para a concretização deste design mais apelativo e próximo de traços de cartoon que apreciamos optamos por usar menos
texto, um tipo de letra mais atual e com traços diferentes dos do Excite Bike original e imagens que por si só refletem
esta escolha temática. 

Tentamos implementar uma interface intuitiva de forma a que o jogador não tenha que ler grandes quantidades de texto ou 
perder muito tempo em torno do jogo para entender como este funciona.
Para cumprir tal objetivo implementamos menús distintos como o Main Menu, um menú para a escolha do mapa e outro para a
escolha dos jogadores.

Tal como referimos anteriormente, pretendiamos que o nosso jogo, de certa forma se distanciasse do Excite Bike e para isso
decidimos optar também pela implementação de mini-jogos. 

= Extras do nosso jogo

No nosso jogo implementamos:

- Menús de início de jogo e menús para fim de jogo;
- Opções de escolha de jogadores;
- Mapas temáticos com opções de comprimento;
- Opção de Single Player e MultiPlayer;
- Implementação de mini-jogos (e níveis de dificuldades);

= Mapas

No nosso jogo decidimos optar por ter mapas temáticos. Neste sentido, escolhemos quatro temas que foram: a cidade, o deserto,
a montanha e a savana. Todos os mapas têm opções de comprimento de pista de 25, 50 ou 75 peças.  

- A cidade 
    Os mapas da cidade são constituídos maioritariamente por boost e estrada (piso com atrito 0)

- O deserto
    Os mapas do deserto são constituídos maioritariamente por terra, boost e cola (representando a areia)

- A montanha 
    Os mapas da montanha são constituídos maioritariamente por terra, relva e lama.

- A savana
    Os mapas da savana são constituídos maioritariamente por terra e relva e lama.

= Mini-Jogos

Os mini-jogos que decidimos implementar foram: Go Fast or Die Tryin', Portal Run e Space Jump. Cada um destes mini-jogos
tem quatro níveis de dificuldade: Fácil, Médio, Difícil e Hardcore.

O Go Fast or Die Tryin' consiste num mini-jogo em que criamos um novo tipo de piso - lava - que no caso de o jogador tocar
morre. Neste jogo, quanto maior o nível de dificuldade maior a quantidade de peças com o piso em lava.

O Space Jump consiste num jogo em que o jogador se encontra no espaço e pretende alcançar a distância definida por nível.
Neste caso, um maior nível de dificuldade representa um objetivo de distância maior e/ou o uso de colas para dificultar o
aumento de velocidade. 

No caso do Portal Run o jogo consiste num jogo futurístico em que criamos um novo piso - o teleporte - que no caso de o 
jogador estar em contacto com ele, teleporta o mesmo para outra zona do mapa. O aumento de dificuldade representa um aumento
de peças teleporta desfavoráveis para o jogador. 

= Imagens e recursos

Neste jogos optamos por métodos diferentes de obter e construir imagens. Maioritariamente optamos pelo uso de imagens
destinadas a uso académico ou sem fins comerciais devido aos direitos de autor. Obtemos essas imagens em sites como o 
FreePik. Por outro lado consideramos importante referir que o nosso tipo de letra foi obtido online, no website Flaming
Text. O jogo inclui também imagens editadas pelos membros do grupo através de ferramentas como Microsoft Word e Paint.
As referências às imagens foram feitas no menú de créditos (opção no menú inicial do jogo)

= Discussão e conclusão

Consideramos que conseguimos desenvolver o jogo de forma positiva e concretizar grande parte das ideias que tínhamos em
mente. Contudo, vemos no jogo potenciais funcionalidades que enriqueceriam o jogo. 

Nesta tarefa ultrapassamos algumas dificuldades que foram essencialmente a utilização da biblioteca Gloss que, inicialmente, 
foi desafiante e também problemas técnicos do uso desta biblioteca no Macbook.

Em conclusão, esta tarefa foi bastante desafiante e interessante porque permitiu que transformássemos o nosso jogo tal como
desejávamos que ele estivesse e nos desenvolveu capacidades criativas. -}


-- Este módulo define funções comuns da Tarefa 5 do trabalho prático.
module Main where
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Juicy
import LI11920
import Tarefa1
import Tarefa2
import Tarefa4
import Tarefa0
import Mapas
import Data.Digits
import Data.Maybe
import Tarefa6
-- | Função principal da Tarefa 5.
-- | __NB:__ Esta Tarefa é completamente livre. Deve utilizar a biblioteca <http://hackage.haskell.org/package/gloss gloss> para animar o jogo, e reutilizar __de forma completa__ as funções das tarefas anteriores.
main :: IO ()
main = do
    Just gfdd <- loadJuicyPNG "imagens/gofast/gfdd.png"
    Just credn <- loadJuicyPNG "imagens/others/jogopor.png"
    Just cred1 <- loadJuicyPNG "imagens/others/creditos.png"
    Just d2 <- loadJuicy "imagens/others/dados2.jpeg"
    Just d1 <- loadJuicy "imagens/others/dados1.jpeg"
    Just trof <- loadJuicyPNG "imagens/others/trofeu.png"
    Just sjoH <- loadJuicyPNG "imagens/spacejump/sjo100.png"
    Just sjoD <- loadJuicyPNG "imagens/spacejump/sjo60.png"
    Just sjoM <- loadJuicyPNG "imagens/spacejump/sjo50.png"
    Just sjo <- loadJuicyPNG "imagens/spacejump/sjo40.png"
    Just prt2b <- loadJuicyPNG "imagens/portalrun/prtime2b.png"
    Just prt <- loadJuicyPNG "imagens/portalrun/prtime.png"
    Just twoplb <- loadJuicyPNG "imagens/nomes/twoplayersb.png"
    Just twopl <- loadJuicyPNG "imagens/nomes/twoplayers.png" 
    Just oneplb <- loadJuicyPNG "imagens/nomes/oneplayerb.png"
    Just onepl <- loadJuicyPNG "imagens/nomes/oneplayer.png" 
    Just pr9 <- loadJuicyPNG "imagens/portalrun/spn9.png"
    Just pr8 <- loadJuicyPNG "imagens/portalrun/spn8.png" 
    Just pr7 <- loadJuicyPNG "imagens/portalrun/spn7.png" 
    Just pr6 <- loadJuicyPNG "imagens/portalrun/spn6.png" 
    Just pr5 <- loadJuicyPNG "imagens/portalrun/spn5.png" 
    Just pr4 <- loadJuicyPNG "imagens/portalrun/spn4.png" 
    Just pr3 <- loadJuicyPNG "imagens/portalrun/spn3.png" 
    Just pr2 <- loadJuicyPNG "imagens/portalrun/spn2.png" 
    Just pr1 <- loadJuicyPNG "imagens/portalrun/spn1.png" 
    Just pr0 <- loadJuicyPNG "imagens/portalrun/spn0.png" 
    Just prp2 <- loadJuicyPNG "imagens/portalrun/spn2p.png"
    Just tam <- loadJuicyPNG "imagens/nomes/tamanho.png"
    Just t100 <- loadJuicyPNG "imagens/others/100.png"
    Just t75 <- loadJuicyPNG "imagens/others/75.png"
    Just t50 <- loadJuicyPNG "imagens/others/50.png"
    Just t25 <- loadJuicyPNG "imagens/others/25.png"
    Just c9 <-loadJuicyPNG "imagens/others/nr9.png"
    Just c8 <-loadJuicyPNG "imagens/others/nr8.png"
    Just c7 <-loadJuicyPNG "imagens/others/nr7.png"
    Just c6 <-loadJuicyPNG "imagens/others/nr6.png"
    Just c5 <-loadJuicyPNG "imagens/others/nr5.png"
    Just c4 <-loadJuicyPNG "imagens/others/nr4.png"
    Just c3 <-loadJuicyPNG "imagens/others/nr3.png"
    Just c2 <-loadJuicyPNG "imagens/others/nr2.png"
    Just c1 <-loadJuicyPNG "imagens/others/nr1.png"
    Just c0 <-loadJuicyPNG "imagens/others/nr0.png"
    Just p2 <- loadJuicyPNG "imagens/others/n2p.png"
    Just qet <- loadJuicyPNG "imagens/others/qET.png"
    Just savr <- loadJuicyJPG "imagens/bg/Savannar.jpg"
    Just sav <- loadJuicyJPG "imagens/bg/Savanna.jpg" 
    Just natr <- loadJuicyJPG "imagens/bg/naturer.jpg"
    Just nat <- loadJuicyJPG "imagens/bg/nature.jpg" 
    Just desr <- loadJuicyJPG "imagens/bg/desertor.jpg" 
    Just des <- loadJuicyJPG "imagens/bg/deserto.jpg" 
    Just cityr <- loadJuicyJPG "imagens/bg/cityr.jpg"  
    Just city <- loadJuicyJPG "imagens/bg/city.jpg" 
    Just pvu <- loadJuicyPNG "imagens/gofast/pistalava.png" 
    Just por <- loadJuicyPNG "imagens/portalrun/portal.png" 
    Just prunr <- loadJuicyJPG "imagens/portalrun/pRunr.jpg" 
    Just prun <- loadJuicyJPG "imagens/portalrun/pRun.jpg" 
    Just vulcaor <- loadJuicyJPG "imagens/gofast/vulcanor.jpg" 
    Just vulcao <- loadJuicyJPG "imagens/gofast/vulcano.jpg" 
    Just skyrv <- loadJuicyJPG "imagens/spacejump/skyrv.jpg" 
    Just skyv <- loadJuicyJPG "imagens/spacejump/skyv.jpg" 
    Just skyr <- loadJuicyJPG "imagens/spacejump/skyr.jpg" 
    Just sky <- loadJuicyJPG "imagens/spacejump/sky.jpg" 
    Just s100 <- loadJuicyPNG "imagens/others/sinal9.png" 
    Just s90 <- loadJuicyPNG "imagens/others/sinal8.png" 
    Just s80 <- loadJuicyPNG "imagens/others/sinal7.png" 
    Just s70 <- loadJuicyPNG "imagens/others/sinal6.png" 
    Just s60 <- loadJuicyPNG "imagens/others/sinal5.png" 
    Just s50 <- loadJuicyPNG "imagens/others/sinal4.png" 
    Just s40 <- loadJuicyPNG "imagens/others/sinal3.png" 
    Just s30 <- loadJuicyPNG "imagens/others/sinal2.png" 
    Just s20 <- loadJuicyPNG "imagens/others/sinal1.png" 
    s10 <- loadBMP "imagens/others/sinal0.bmp" 
    Just pl4 <- loadJuicyPNG "imagens/nomes/player4.png" 
    Just pl3 <- loadJuicyPNG "imagens/nomes/player3.png" 
    Just pl2 <- loadJuicyPNG "imagens/nomes/player2.png" 
    Just pl1 <- loadJuicyPNG "imagens/nomes/player1.png" 
    Just fundo2 <- loadJuicy "imagens/bg/fundo2.jpeg" 
    Just fundo1r <- loadJuicyPNG "imagens/bg/fundo1r.png" 
    Just fundo1 <- loadJuicyJPG "imagens/bg/fundo1.jpg" 
    Just fundo <- loadJuicy "imagens/bg/fundo.jpeg" 
    Just tripr <- loadJuicyPNG "imagens/portalrun/tripr.png" 
    Just tri <- loadJuicyPNG "imagens/others/cursor1.png" 
    Just n46b <- loadJuicyPNG "imagens/spacejump/sjpnb.png" 
    Just n46 <- loadJuicyPNG "imagens/spacejump/sjpn.png" 
    Just n45 <- loadJuicyPNG "imagens/spacejump/sjnc.png" 
    Just n44b <- loadJuicyPNG "imagens/portalrun/prpnb.png" 
    Just n44 <- loadJuicyPNG "imagens/portalrun/prpn.png" 
    Just n43 <- loadJuicyPNG "imagens/portalrun/prnc.png" 
    Just n42b <- loadJuicyPNG "imagens/gofast/gfpnb.png" 
    Just n42 <- loadJuicyPNG "imagens/gofast/gfpn.png" 
    Just n41 <- loadJuicyPNG "imagens/gofast/gfnc.png" 
    Just n40 <- loadJuicyPNG "imagens/nomes/escolhertema.png" 
    Just n39b <- loadJuicyPNG "imagens/gofast/gfhb.png" 
    Just n39 <- loadJuicyPNG "imagens/gofast/gfh.png"
    Just n38b <- loadJuicyPNG "imagens/gofast/gfdb.png"
    Just n38 <- loadJuicyPNG "imagens/gofast/gfd.png"
    Just n37b <- loadJuicyPNG "imagens/gofast/gfmb.png"
    Just n37 <- loadJuicyPNG "imagens/gofast/gfm.png"
    Just n36b <- loadJuicyPNG "imagens/gofast/gffb.png"
    Just n36 <- loadJuicyPNG "imagens/gofast/gff.png"
    Just n35 <- loadJuicyPNG "imagens/gofast/gfef.png"
    Just n34b <- loadJuicyPNG "imagens/portalrun/prhb.png"
    Just n34 <- loadJuicyPNG "imagens/portalrun/prh.png"
    Just n33b <- loadJuicyPNG "imagens/portalrun/prdb.png"
    Just n33 <- loadJuicyPNG "imagens/portalrun/prd.png"
    Just n32b <- loadJuicyPNG "imagens/portalrun/prmb.png"
    Just n32 <- loadJuicyPNG "imagens/portalrun/prm.png"
    Just n31b <- loadJuicyPNG "imagens/portalrun/prfb.png"
    Just n31 <- loadJuicyPNG "imagens/portalrun/prf.png"
    Just n30 <- loadJuicyPNG "imagens/portalrun/pred.png"
    Just n29 <-loadJuicyPNG "imagens/spacejump/sjed.png"
    Just n28b <- loadJuicyPNG "imagens/spacejump/sjhb.png"
    Just n28 <- loadJuicyPNG "imagens/spacejump/sjh.png"
    Just n27b <- loadJuicyPNG "imagens/spacejump/sjdb.png"
    Just n27 <- loadJuicyPNG "imagens/spacejump/sjd.png"
    Just n26b <- loadJuicyPNG "imagens/spacejump/sjmb.png"
    Just n26 <- loadJuicyPNG "imagens/spacejump/sjm.png"
    Just n25b <- loadJuicyPNG "imagens/spacejump/sjfb.png"
    Just n25 <- loadJuicyPNG "imagens/spacejump/sjf.png"
    Just n24b <- loadJuicyPNG "imagens/spacejump/vmsjb.png"
    Just n24 <- loadJuicyPNG "imagens/spacejump/vmsj.png"
    Just n23b <- loadJuicyPNG "imagens/spacejump/jnsjb.png"
    Just n23 <- loadJuicyPNG "imagens/spacejump/jnsj.png"
    Just n22 <- loadJuicyPNG "imagens/spacejump/gosj.png"
    Just n21b <- loadJuicyPNG "imagens/gofast/VMGFB.png"
    Just n21 <- loadJuicyPNG "imagens/gofast/VMGF.png"
    Just n20 <- loadJuicyPNG "imagens/gofast/GOGF.png"
    Just n19b <- loadJuicyPNG "imagens/gofast/JNGFB.png"
    Just n19 <- loadJuicyPNG "imagens/gofast/JNGF.png"
    Just n18b <- loadJuicyPNG "imagens/portalrun/vmprb.png"
    Just n18 <- loadJuicyPNG "imagens/portalrun/vmpr.png"
    Just n17b <- loadJuicyPNG "imagens/portalrun/jnprb.png"
    Just n17 <- loadJuicyPNG "imagens/portalrun/jnpr.png"
    Just n16 <- loadJuicyPNG "imagens/portalrun/gopr.png"
    Just n15 <- loadJuicyPNG "imagens/nomes/go.png"
    Just n14b <- loadJuicyPNG "imagens/nomes/voltarmenub.png"
    Just n14 <- loadJuicyPNG "imagens/nomes/voltarmenu.png"
    Just n13b <- loadJuicyPNG "imagens/nomes/jogarnb.png"
    Just n13 <- loadJuicyPNG "imagens/nomes/jogarn.png"
    Just n12b <- loadJuicyPNG "imagens/portalrun/portalrunb.png"
    Just n12 <- loadJuicyPNG "imagens/portalrun/portalrun.png"
    Just n11b <- loadJuicyPNG "imagens/spacejump/spacejump.png"
    Just n11 <- loadJuicyPNG "imagens/spacejump/sjump.png"
    Just n10b <- loadJuicyPNG "imagens/gofast/GFTB.png"
    Just n10 <- loadJuicyPNG "imagens/gofast/GFT.png"
    Just n9t <- loadJuicyPNG "imagens/nomes/titulomj.png"
    Just n9b <- loadJuicyPNG "imagens/nomes/minijogosb.png"
    Just n9 <- loadJuicyPNG "imagens/nomes/minijogos.png"
    Just n8b <- loadJuicyPNG "imagens/nomes/voltarb.png"
    Just n8 <- loadJuicyPNG "imagens/nomes/voltar.png"
    Just n7b <- loadJuicyPNG "imagens/nomes/vistageralb.png"
    Just n7 <- loadJuicyPNG "imagens/nomes/vistageral.png"
    Just death <- loadJuicyPNG "imagens/others/death.png"
    Just n6b <- loadJuicyPNG "imagens/nomes/creditosb.png"
    Just n6 <- loadJuicyPNG "imagens/nomes/creditos.png"
    Just n5t <- loadJuicyPNG "imagens/nomes/tituloej.png"
    Just n5b <- loadJuicyPNG "imagens/nomes/escolherjogadorb.png"
    Just n5 <- loadJuicyPNG "imagens/nomes/escolherjogador.png"
    Just n4b <- loadJuicyPNG "imagens/nomes/jogarb.png"
    Just n4 <- loadJuicyPNG "imagens/nomes/jogar.png"
    Just n3t <- loadJuicyPNG "imagens/nomes/tituloem.png"
    Just n3b <- loadJuicyPNG "imagens/nomes/escolhermapab.png"
    Just n3 <- loadJuicyPNG "imagens/nomes/escolhermapa.png"
    Just n2b <- loadJuicyPNG "imagens/nomes/iniciarjogob.png"
    Just n2 <- loadJuicyPNG "imagens/nomes/iniciarjogo.png"
    Just n1 <- loadJuicyPNG "imagens/nomes/titulo.png"
    Just bike7 <- loadJuicyPNG "imagens/bikes/bikespec.png"
    Just bike6 <- loadJuicyPNG "imagens/bikes/bikered.png"
    Just bike5 <- loadJuicyPNG "imagens/bikes/bikepurple.png"
    Just bike4 <- loadJuicyPNG "imagens/bikes/bikeorange.png"
    Just bike3 <- loadJuicyPNG "imagens/bikes/bikegrey.png"
    Just bike2 <- loadJuicyPNG "imagens/bikes/bikegreen.png"
    Just bike1 <- loadJuicyPNG "imagens/bikes/bikebrown.png"
    Just bike0 <- loadJuicyPNG "imagens/bikes/bikeblue.png"
    Just start <- loadJuicyJPG "imagens/others/start.jpg" 
    play dm                       -- | janela onde irá correr o jogo
        white             -- | côr do fundo da janela
        fr                      -- | frame rate
        (estadoGlossInicial [fundo,fundo1,fundo1r,fundo2,sky,skyr,skyv,skyrv,vulcao,vulcaor,pvu,prun,prunr,por,city,cityr,des,desr,nat,natr,sav,savr,bike0,bike1,bike2,bike3,bike4,bike5,bike6,bike7,start,n1,n2,n2b,n3,n3b,n3t,n4,n4b,n5,n5b,n5t,n6,n6b,n7,n7b,n8,n8b,n9,n9b,n9t,n10,n10b,n11,n11b,n12,n12b,n13,n13b,n14,n14b,n15,n16,n17,n17b,n18,n18b,n19,n19b,n20,n21,n21b,n22,n23,n23b,n24,n24b,n25,n25b,n26,n26b,n27,n27b,n28,n28b,n29,n30,n31,n31b,n32,n32b,n33,n33b,n34,n34b,n35,n36,n36b,n37,n37b,n38,n38b,n39,n39b,n40,n41,n42,n42b,n43,n44,n44b,n45,n46,n46b,pl1,pl2,pl3,pl4,s10,s20,s30,s40,s50,s60,s70,s80,s90,s100,death,qet,tri,tripr,p2,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,pr0,pr1,pr2,pr3,pr4,pr5,pr6,pr7,pr8,pr9,prp2,t25,t50,t75,t100,tam,onepl,oneplb,twopl,twoplb,prt,prt2b,sjo,sjoM,sjoD,sjoH,trof,d1,d2,cred1,credn,gfdd]) -- | estado inicial
        desenhaEstadoGloss -- | desenha o estado do jogo
        reageEventoGloss          -- | reage a um evento
        reageTempoGloss           -- | reage ao passar do tempo





data EstadoGloss = EstadoGloss 
    { tempo :: Int -- | O tempo usado para desenhar o  crómetro do jogo
    , isBot :: Bool -- | Saber se o player 2 é bot ou não
    , jsSelected :: [Int]  -- | Cor dos jogadores selcionados, por ordem
    , estado :: Estado    -- | O 'Estado' do jogo. 
    , menuAtual :: Menu  -- | Menu Atual do Jogo
    , subMenu :: Int                  -- | Sub Menu
    , opcao :: Opcoes             -- | a opçao atualmente selecionada
    , imagens :: [Picture] -- | lista de imagens a utilizar
    } deriving Show

data Menu = MainMenu | MenuMapa | PlayerMenu | Game | GameOver | PlayMenu | MTema| MenuMiniJogos | MGoFast | MPortalRun | MSpaceJump | MenuBot | MenuCreditos deriving (Eq, Show)

data Opcoes = Jogar | IniciarJogo | Creditos | Jogo | EscolherMapa | EscolherJogador | Start
                    | Player1 | Player2 
                    | Mapa1 | Mapa2 | Mapa3 | Mapa4
                    | VistaGeral | Voltar |JogarNovamente| VoltarAoMenu | ProximoNivel
                    | MiniJogos | GoFast | SpaceJump | PortalRun
                    | PlayerBlue | PlayerRed | PlayerOrange | PLayerPurple | PlayerBrown | PlayerGreen | PlayerGrey | PlayerSpec
                    | Facil | Medio | Dificil | Hardcore  
                    | City | Desert | Nature | Savana deriving (Eq, Show)


-- | Função que reage a eventos do Teclado

reageEvento :: Event -> EstadoGloss -> EstadoGloss
-- MainMenu
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ _ MainMenu _ Jogar _) = estado{menuAtual=PlayMenu,opcao=IniciarJogo}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ MainMenu _ Jogar _) = estado{opcao=Creditos}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ MainMenu _ Creditos _) = estado{opcao=Jogar}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ _ MainMenu _ Creditos _) = estado{menuAtual=MenuCreditos}
--MenuCreditos
reageEvento (EventKey _ Down _ _) estado@(EstadoGloss _ _ _ _ MenuCreditos _ _ _) = estado{menuAtual=MainMenu,opcao=Jogar}
-- MenuBot 
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ MenuBot _ Player1 _) =estado{menuAtual=MenuBot,opcao=Player2}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ MenuBot _ Player1 _) =estado{menuAtual=MenuBot,opcao=Player2}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ MenuBot _ Player2 _) =estado{menuAtual=MenuBot,opcao=Player1}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ MenuBot _ Player2 _) =estado{menuAtual=MenuBot,opcao=Player1}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuBot _ Player2 _) =estado{menuAtual=Game,opcao=Start,tempo=(-79),subMenu=checkMapa (mapaEstado e),isBot=False}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuBot _ Player1 _) =estado{menuAtual=Game,opcao=Start,tempo=(-79),subMenu=checkMapa (mapaEstado e),isBot=True}
-- PlayMenu
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e PlayMenu _ IniciarJogo _) =estado{menuAtual=MenuBot,opcao=Player1}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ PlayMenu _ IniciarJogo _) = estado{opcao=EscolherMapa}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ PlayMenu _ EscolherMapa _) =estado{opcao=EscolherJogador}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ PlayMenu _ EscolherJogador _) =estado{opcao=EscolherMapa} 
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ PlayMenu _ EscolherMapa _)= estado{opcao=IniciarJogo}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ _ PlayMenu _ EscolherMapa _)= estado{menuAtual=MTema,opcao=City}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ PlayMenu _ EscolherJogador _)= estado{opcao=MiniJogos}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ _ PlayMenu _ EscolherJogador _)= estado{menuAtual=PlayerMenu,opcao=PlayerBlue,subMenu=1}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ PlayMenu _ MiniJogos _)= estado{opcao=EscolherJogador}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ _ PlayMenu _ MiniJogos _)= estado{menuAtual=MenuMiniJogos,opcao=GoFast}
-- MenuMapa
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 1 Mapa1 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaCt1}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 1 Mapa2 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaCt2}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 1 Mapa3 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaCt3}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 2 Mapa1 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaDs1}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 2 Mapa2 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaDs2}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 2 Mapa3 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaDs3}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 3 Mapa1 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaNt1}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 3 Mapa2 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaNt2}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 3 Mapa3 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaNt3}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 4 Mapa1 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaSv1}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 4 Mapa2 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaSv2}}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMapa 4 Mapa3 _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=e{mapaEstado=mapaSv3}}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMapa _ Mapa1 _)= estado{opcao=Mapa2}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMapa _ Mapa2 _)= estado{opcao=Mapa3}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMapa _ Mapa2 _)= estado{opcao=Mapa1}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMapa _ Mapa3 _)= estado{opcao=Mapa2}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMapa _ Voltar _)= estado{opcao=Mapa1}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMapa _ VistaGeral _)= estado{opcao=Voltar}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMapa _ VistaGeral _)= estado{opcao=Mapa1}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMapa _ Voltar _)= estado
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMapa _ Voltar _)= estado{opcao=VistaGeral}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMapa _ _ _)= estado{opcao=VistaGeral}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ _ _ _ Voltar _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo}
-- MTema 
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ City _)= estado{opcao=Desert}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ City _)= estado{opcao=Nature}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ Desert _)= estado{opcao=Savana}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ Desert _)= estado{opcao=City}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ Nature _)= estado{opcao=City}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ Nature _)= estado{opcao=Savana}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ Savana _)= estado{opcao=Nature}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ Savana _)= estado{opcao=Desert}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ City _)= estado{menuAtual=MenuMapa,opcao=Mapa1,subMenu=1}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ Desert _)= estado{menuAtual=MenuMapa,opcao=Mapa1,subMenu=2}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ Nature _)= estado{menuAtual=MenuMapa,opcao=Mapa1,subMenu=3}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ _ MTema _ Savana _)= estado{menuAtual=MenuMapa,opcao=Mapa1,subMenu=4}
-- GameOver
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e GameOver x ProximoNivel _) | x == 51 = estado {menuAtual=Game,opcao=GoFast,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=whatMapa (mapaEstado e)},subMenu=5}
                                                                                                             | x == 61 =estado{menuAtual=Game,subMenu=6,opcao=Start,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=whatMapa (mapaEstado e)},tempo=(-79)}
                                                                                                             | x == 71 =estado{menuAtual=Game,opcao=SpaceJump,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=whatMapa (mapaEstado e)},subMenu=7}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ GameOver x ProximoNivel _)= if x > 10 then estado{opcao=VoltarAoMenu} else estado
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ GameOver x VoltarAoMenu _)= if x > 10  && x < 100 then estado{opcao=ProximoNivel} else estado
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e GameOver x JogarNovamente _) | x < 5 = estado{estado=e{jogadoresEstado=estadoJogadoresInicial},menuAtual=Game,opcao=Start,tempo=(-79)}
                                                                                                             | x == 5 = estado{estado=e{jogadoresEstado=estadoJogadoresInicial},menuAtual=Game,opcao=GoFast,tempo=0}
                                                                                                             | x == 6 = estado{estado=e{jogadoresEstado=estadoJogadoresInicial},menuAtual=Game,opcao=Start,tempo=(-79)}
                                                                                                             | x == 7 = estado{estado=e{jogadoresEstado=estadoJogadoresInicial},menuAtual=Game,opcao=SpaceJump,tempo=0} 
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ GameOver x JogarNovamente _)= if x < 10 then estado{opcao=VoltarAoMenu} else estado
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ GameOver x VoltarAoMenu _)= if x < 10 then estado{opcao=JogarNovamente} else estado
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e GameOver x VoltarAoMenu _)= estado{menuAtual=PlayMenu,opcao=IniciarJogo,estado=estadoInicial1,subMenu=0}
-- Game
reageEvento _ estado@(EstadoGloss _ _ _ e Game _ Start _) = estado
reageEvento (EventKey (SpecialKey KeyUp)    Down _ _) estado@(EstadoGloss _ ib _ e Game _ _ _) = if ib then estado else estado{estado=jogada 1 (Movimenta C) e}
reageEvento (EventKey (SpecialKey KeyDown)  Down _ _) estado@(EstadoGloss _ ib _ e Game _ _ _)=  if ib then estado else estado{estado=jogada 1 (Movimenta B) e}
reageEvento (EventKey (SpecialKey KeyLeft)  Down _ _) estado@(EstadoGloss _ ib _ e Game _ _ _) = if ib then estado else estado{estado=jogada 1 (Movimenta E) e}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ ib _ e Game _ _ _) = if ib then estado else estado{estado=jogada 1 (Movimenta D) e}
reageEvento (EventKey (Char '.') Down _ _) estado@(EstadoGloss _ ib _ e Game _ _ _) = if ib then estado else estado{estado=jogada 1 (Acelera) e}
reageEvento (EventKey (Char '.') Up _ _) estado@(EstadoGloss _ ib _ e Game _ _ _) = if ib then estado else estado{estado=jogada 1 (Desacelera) e}
reageEvento (EventKey (Char '-') Up _ _) estado@(EstadoGloss _ ib _ e Game _ _ _) = if ib then estado else estado{estado=jogada 1 (Dispara) e}
reageEvento (EventKey (Char 'w') Down _ _) estado@(EstadoGloss _ _ _ e Game _ _ _)= estado{estado=jogada 0 (Movimenta C) e}
reageEvento (EventKey (Char 's') Down _ _) estado@(EstadoGloss _ _ _ e Game _ _ _) = estado{estado=jogada 0 (Movimenta B) e}
reageEvento (EventKey (Char 'a') Down _ _) estado@(EstadoGloss _ _ _ e Game _ _ _) = estado{estado=jogada 0 (Movimenta E) e}
reageEvento (EventKey (Char 'd') Down _ _) estado@(EstadoGloss _ _ _ e Game _ _ _)= estado{estado=jogada 0 (Movimenta D) e}
reageEvento (EventKey (Char 'x') Down _ _) estado@(EstadoGloss _ _ _ e Game _ _ _) = estado{estado=jogada 0 (Acelera) e}
reageEvento (EventKey (Char 'x') Up _ _) estado@(EstadoGloss _ _ _ e Game _ _ _) = estado{estado=jogada 0 (Desacelera) e}
reageEvento (EventKey (Char 'q') Down _ _) estado@(EstadoGloss _ _ _ e Game _ _ _) = estado{estado=jogada 0 (Dispara) e}
-- PlayerMenu
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ _ _)= estado{opcao=VistaGeral}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ Voltar _)= estado{opcao=PlayerBlue}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ VistaGeral _)= estado{opcao=PlayerBlue}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ Voltar _)= estado{opcao=VistaGeral}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ VistaGeral _)= estado{opcao=Voltar}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerBlue _)= estado{opcao=PlayerBrown}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerBlue _)= estado{opcao=PlayerSpec}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerBrown _)= estado{opcao=PlayerGreen}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerBrown _)= estado{opcao=PlayerBlue}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerGreen _)= estado{opcao=PlayerGrey}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerGreen _)= estado{opcao=PlayerBrown}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerGrey _)= estado{opcao=PlayerOrange}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerGrey _)= estado{opcao=PlayerGreen}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerOrange _)= estado{opcao=PLayerPurple}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerOrange _)= estado{opcao=PlayerGrey}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PLayerPurple _)= estado{opcao=PlayerRed}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PLayerPurple _)= estado{opcao=PlayerOrange}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerRed _)= estado{opcao=PlayerSpec}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerRed _)= estado{opcao=PLayerPurple}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerSpec _)= estado{opcao=PlayerRed}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) estado@(EstadoGloss _ _ _ _ PlayerMenu _ PlayerSpec _)= estado{opcao=PlayerBlue}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ l _ PlayerMenu y VistaGeral _)= estado
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ l _ PlayerMenu 4 x _)= estado{subMenu= 0,menuAtual=PlayMenu,opcao=IniciarJogo,jsSelected=changeJs 4 x l}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ l _ PlayerMenu y x _)= estado{subMenu=y+1,opcao=PlayerBlue,jsSelected=changeJs y x l}
-- MenuMiniJogos
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMiniJogos _ GoFast _)= estado{opcao=PortalRun}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMiniJogos _ SpaceJump _)= estado{opcao=PortalRun}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMiniJogos _ SpaceJump _)= estado{menuAtual=MSpaceJump,opcao=Facil}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMiniJogos _ SpaceJump _)= estado{opcao=Voltar}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMiniJogos _ PortalRun _)= estado{opcao=SpaceJump}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMiniJogos _ PortalRun _)= estado{opcao=GoFast}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ _ MenuMiniJogos _ Voltar _)= estado{opcao=SpaceJump}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMiniJogos _ GoFast _)= estado{menuAtual=MGoFast,opcao=Facil}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MenuMiniJogos _ PortalRun _)= estado{menuAtual=MPortalRun,opcao=Facil}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ e _ _ Facil _)= estado{opcao=Medio}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ e _ _ Medio _)= estado{opcao=Dificil}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ e _ _ Medio _)= estado{opcao=Facil}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) estado@(EstadoGloss _ _ _ e _ _ Dificil _)= estado{opcao=Hardcore}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ e _ _ Dificil _)= estado{opcao=Medio}
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) estado@(EstadoGloss _ _ _ e _ _ Hardcore _)= estado{opcao=Dificil}
-- MSpaceJump
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MSpaceJump _ Facil _)= estado{menuAtual=Game,opcao=SpaceJump,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaSJF},subMenu=7}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MSpaceJump _ Medio _)= estado{menuAtual=Game,opcao=SpaceJump,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaSJM},subMenu=7}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MSpaceJump _ Dificil _)= estado{menuAtual=Game,opcao=SpaceJump,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaSJD},subMenu=7}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MSpaceJump _ Hardcore _)= estado{menuAtual=Game,opcao=SpaceJump,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaSJH},subMenu=7}
-- MPortalRun
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MPortalRun _ Facil _)= estado{menuAtual=Game,subMenu=6,opcao=Start,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaPRF},tempo=(-79)}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MPortalRun _ Medio _)= estado{menuAtual=Game,subMenu=6,opcao=Start,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaPRM},tempo=(-79)}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MPortalRun _ Dificil _)= estado{menuAtual=Game,subMenu=6,opcao=Start,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaPRD},tempo=(-79)}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MPortalRun _ Hardcore _)= estado{menuAtual=Game,subMenu=6,opcao=Start,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaPRH},tempo=(-79)}
-- MGoFast
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MGoFast _ Facil _)= estado{menuAtual=Game,opcao=GoFast,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaGFF},subMenu=5}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MGoFast _ Medio _)= estado{menuAtual=Game,opcao=GoFast,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaGFM},subMenu=5}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MGoFast _ Dificil _)= estado{menuAtual=Game,opcao=GoFast,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaGFD},subMenu=5}
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) estado@(EstadoGloss _ _ _ e MGoFast _ Hardcore _)= estado{menuAtual=Game,opcao=GoFast,estado=e{jogadoresEstado=[j1,j1,j1,j1],mapaEstado=mapaGFH},subMenu=5}
reageEvento _ s = s -- ignora qualquer outro evento

-- | Função que reage ao passar do Tempo
reageTempo :: Float -> Estado -> Estado
reageTempo n (Estado m js) = (Estado m ([encontraIndiceLista 0 a]++[encontraIndiceLista 1 b]++[encontraIndiceLista 2 c]++[encontraIndiceLista 3 d]))
                           where
                               a = atualizaIndiceLista 0(passo (realToFrac n) m (encontraIndiceLista 0 js)) js 
                               b = atualizaIndiceLista 1(passo (realToFrac n) m (encontraIndiceLista 1 js)) js 
                               c = atualizaIndiceLista 2(passo (realToFrac n) m (encontraIndiceLista 2 js)) js 
                               d = atualizaIndiceLista 3(passo (realToFrac n) m (encontraIndiceLista 3 js)) js

-- | Função que Atualiza a cor do Jogador para a selecionada
changeJs :: Int -> Opcoes -> [Int] -> [Int]
changeJs x (PlayerBlue) l = atualizaIndiceLista (x-1) 0 l 
changeJs x (PlayerBrown) l = atualizaIndiceLista (x-1) 1 l 
changeJs x (PlayerGreen) l = atualizaIndiceLista (x-1) 2 l 
changeJs x (PlayerGrey) l = atualizaIndiceLista (x-1) 3 l 
changeJs x (PlayerOrange) l = atualizaIndiceLista (x-1) 4 l 
changeJs x (PLayerPurple) l = atualizaIndiceLista (x-1) 5 l 
changeJs x (PlayerRed) l = atualizaIndiceLista (x-1) 6 l 
changeJs x (PlayerSpec) l = atualizaIndiceLista (x-1) 7 l 

-- | Função que verifica que mapa foi selecionada para saber qual fundo selecionar
checkMapa :: Mapa -> Int
checkMapa m | m == mapaCt1 || m == mapaCt2 || m == mapaCt3 = 1
            | m == mapaDs1 || m == mapaDs2 || m == mapaDs3 = 2
            | m == mapaNt1 || m == mapaNt2 || m == mapaNt3 = 3
            | m == mapaSv1 || m == mapaSv2 || m == mapaSv3 = 4
whatMapa :: Mapa -> Mapa
whatMapa m | m == mapaGFF = mapaGFM
           | m == mapaGFM = mapaGFD
           | m == mapaGFD = mapaGFH
           | m == mapaPRF = mapaPRM
           | m == mapaPRM = mapaPRD
           | m == mapaPRD = mapaPRH
           | m == mapaSJF = mapaSJM
           | m == mapaSJM = mapaSJD
           | m == mapaSJD = mapaSJH
-- | Estado Incial que corresponde aos Jogadores no início da Pista com 5 colas cada um
estadoInicial1 :: Estado
estadoInicial1 = Estado (mapaCt1) [(Jogador 0 0 0 5 (Chao False)),(Jogador 1 0 0 5 (Chao False)),(Jogador 2 0 0 5 (Chao False)),(Jogador 3 0 0 5 (Chao False))]

-- | Função que encontra oIndice Lista de uma Lista
ei :: Int -> [Picture] -> Picture
ei x l = encontraIndiceLista x l 

-- |Posicão do Titulo Principal no MainMenu
titulo :: Picture -> Picture
titulo x =(Translate 0 410 x)
-- |Posição da opção Jogar no Main MEenu
nJogar:: Picture -> Picture
nJogar x = (Translate (-500) 45 x)
-- |Posição da opção iniciar Jogo no PlayMenu
nIJ :: Picture -> Picture
nIJ x = (Translate (-325) 46 x)
-- |Posição da opção EscolherMapa no PlayMenu
nEM :: Picture -> Picture
nEM x = (Translate (-250) (-105) x)
-- |Posição da opção EscolherJogador no PlayMenu
nEJ :: Picture -> Picture
nEJ x =(Translate (-150) (-260) x)
-- |Posição da opção EscolherJogador no PlayMenu (quando selecionada)
nEJb :: Picture -> Picture
nEJb x =(Translate (-170) (-260) x)
-- |Posição da opção Créditos no MainMenu
nC :: Picture -> Picture
nC x = (Translate (-450) (-155) x)
-- |Posição dos Mapas quando estão a ser vistos no MenuMapa
nr :: Picture -> Picture
nr x = Translate 0 (-25)(Scale 0.3 0.3 x)
-- |Posição dos Mapas quando estão a ser vistos no MenuMapa quando tem 25 peças
nr25 :: Picture -> Picture
nr25 x = Translate (-200) 0 (Scale 0.56 0.56 x)
-- |Posição dos Mapas quando estão a ser vistos no MenuMapa quando tem 50 peças
nr50:: Picture -> Picture
nr50 x = Translate (-435) 0 (Scale 0.28 0.28 x)
-- |Posição dos Mapas quando estão a ser vistos no MenuMapa quando tem 25 peças
nr75:: Picture -> Picture
nr75 x = Translate (-510) 0 (Scale 0.19 0.19 x)
-- |Posição dos Mapas quando estão a ser vistos no MenuMapa quando tem 25 peças
nr100 :: Picture -> Picture
nr100 x = Translate (-435) 0 (Scale 0.14 0.14 x)
-- |Posição do Mapa1 na Opção Vista Geral e Voltar do MenuMapa
nr1 :: Picture -> Picture
nr1 x = Scale 0.3 0.3 (Translate (-1000) 815 x)
-- |Posição do Mapa2 na Opção Vista Geral e Voltar do MenuMapa
nr2 :: Picture -> Picture
nr2 x = Scale 0.3 0.3 (Translate 1000 815 x)
-- |Posição do Mapa3 na Opção Vista Geral e Voltar do MenuMapa
nr3:: Picture -> Picture
nr3 x = Scale 0.3 0.3 (Translate (-1000) (-850) x)
-- |Posição do Mapa4 na Opção Vista Geral e Voltar do MenuMapa
nr4 :: Picture -> Picture
nr4 x = Scale 0.3 0.3 (Translate 1000 (-850) x)
-- |Posição da Opção Vista Geral
vg :: Picture -> Picture
vg x =(Translate (-225) (-425) x)
-- |Posição da Opção Voltar 
vo :: Picture -> Picture
vo x = (Translate (450) (-425) x)
-- |Posição Inicial do Triângulo Vermelho
pt :: Picture -> Picture
pt x = (Translate (-750) (50) (Scale 0.55 0.55 x)) 
-- |Posição Inicial do Triângulo Azul-esverdeado
ptr :: Picture -> Picture
ptr x = (Translate (-770) (-150) (Scale 0.4 0.4 x)) 
-- |Posição do Player 0 na vista geral do Player Menu
p0 :: Picture -> Picture
p0 x = Translate (-600) 200 (Scale 0.2 0.2 x)
-- |Posição do Player 1 na vista geral do Player Menu
p1 :: Picture -> Picture
p1 x = Translate (-350) 200 (Scale 0.2 0.2 x)
-- |Posição do Player 2 na vista geral do Player Menu
p2 :: Picture -> Picture
p2 x = Translate (-100) 200 (Scale 0.2 0.2 x)
-- |Posição do Player 3 na vista geral do Player Menu
p3 :: Picture -> Picture
p3 x = Translate (150) 200 (Scale 0.2 0.2 x)
-- |Posição do Player 4 na vista geral do Player Menu
p4 :: Picture -> Picture
p4 x = Translate (-600) 0 (Scale 0.2 0.2 x) 
-- |Posição do Player 5 na vista geral do Player Menu
p5 :: Picture -> Picture
p5 x = Translate (-350) 0 (Scale 0.2 0.2 x) 
-- |Posição do Player 6 na vista geral do Player Menu
p6 :: Picture -> Picture
p6 x = Translate (-100) 0 (Scale 0.2 0.2 x) 
-- |Posição do Player 7 na vista geral do Player Menu
p7 :: Picture -> Picture
p7 x = Translate 150 0 (Scale 0.2 0.2 x)
-- |Posição do titulo MiniJogos no PlayMenu
nMJ :: Picture -> Picture
nMJ x = Translate (-350) (-425) x
-- |Posição do titulo Go Fast no MenuMiniJogos
gf :: Picture -> Picture
gf x = Translate (-150) (150) (Scale 0.8 0.8 x)
-- |Posição do titulo Space Jump no MenuMiniJogos
lj :: Picture -> Picture
lj x = Translate (-270) (-150) x
-- |Posição do titulo PortalRun no MenuMiniJogs
pr :: Picture -> Picture 
pr x = Translate (-340) 0 x
-- | Posição Incial do Jogador quando se encontra nos Minijogos
j1 :: Jogador
j1 = Jogador 0 0 0 0 (Chao False)
-- |Escala do fundo 1
f :: Picture -> Picture
f x = Scale 2 1.6 x
-- |Escala do fundo 1 sem o boneco
f2 :: Picture -> Picture
f2 x = Scale 1 0.795 x
-- |Posição e escala do biker
bi :: Picture -> Picture
bi x = Translate 0 20(Scale 0.12 0.12 x)
-- |Posição do Jogar Novamente
jg :: Picture -> Picture
jg x = Translate (-400) (-200) x
-- |Posição do Próximo Nível
pn :: Picture -> Picture
pn x = Translate (300) (-200) x
-- |Posição do Voltar Ao Menu
vm :: Picture -> Picture
vm x = Translate (400) (-200) x
-- |Escala do Biker quando está a ser escolhido
bEJ :: Picture -> Picture
bEJ x = Scale 0.5 0.5 x
-- |Posição do Escolher Dificuldade
ned :: Picture -> Picture
ned x = Translate 0 450 x
-- |Posição do Facil
nf :: Picture -> Picture
nf x = Translate 0 200 x 
-- |Posição do Medio
nm :: Picture -> Picture
nm x = Translate 0 0 x 
-- |Posição do Dificil
nd:: Picture -> Picture
nd x = Translate 0 (-200) x 
-- |Posição do Hardcore
nh :: Picture -> Picture
nh x = Translate 0 (-400) x 
-- |Posição para o Tamanho
tm :: Picture -> Picture
tm x = Translate (-800) (450) x
-- |Posição para os numeros do Tamanho
t1 :: Picture -> Picture
t1 = Translate (-800) (300)
t2 :: Picture -> Picture
t2 = Translate (-800) (100)
t3 :: Picture -> Picture
t3 = Translate (-800) (-100)
-- |Posição do tema selecionado quando na escolha do Mapa
pct :: Picture -> Picture
pct x = Translate 0 (300) (Scale 0.3 0.3 x)

npl1 :: Picture -> Picture
npl1 x = Translate 0 100 x
npl2 :: Picture -> Picture
npl2 x = Translate 0 (-100) x
-- |Posição do Cronometro
relog :: Picture -> Picture
relog x = Translate (-150) (400) x

triPlayerMenu :: Picture -> Picture
triPlayerMenu x = Pictures [(Translate (1050) (-100) x),(Translate (-1100) (0) (Rotate 180 x))]
-- | Função que na Escolha do Jogador diz se se trata do Player 1/2/3/4
whatPlayer :: Int -> [Picture] -> Picture
whatPlayer x (pl1:pl2:pl3:pl4:[]) | x == 1 = Translate 0 (-300) pl1 
                                  | x == 2 = Translate 0 (-300) pl2
                                  | x == 3 = Translate 0 (-300) pl3
                                  | x == 4 = Translate 0 (-300) pl4  

-- | Função que posiona os sinais no Mapa no Mini Jogo "Space Jump"
sinais :: [Picture]-> Picture
sinais x = Translate 2660 100 (Pictures (doSinais 0 x))
-- | Função complementar da sinais
doSinais :: Float -> [Picture] -> [Picture]
doSinais _ [] = [Blank]
doSinais x (h:t) =  [Translate x 0 (Scale 0.5 0.5 h)] ++ (doSinais (x+1000) t )

-- | Jogadores todos no início da Pista para quando for selecionado o "Jogar Novamente"
estadoJogadoresInicial :: [Jogador]
estadoJogadoresInicial = [(Jogador 0 0 0 5 (Chao False)),(Jogador 1 0 0 5 (Chao False)),(Jogador 2 0 0 5 (Chao False)),(Jogador 3 0 0 5 (Chao False))]
-- | O estadoGlossInicial
estadoGlossInicial :: [Picture]-> EstadoGloss
estadoGlossInicial (fundo:fundo1:fundo1r:fundo2:sky:skyr:skyv:skyrv:vu:vur:pvu:prun:prunr:por:ct:ctr:ds:dsr:nt:ntr:sv:svr:b0:b1:b2:b3:b4:b5:b6:b7:start:n1:n2:n2b:n3:n3b:n3t:n4:n4b:n5:n5b:n5t:n6:n6b:n7:n7b:n8:n8b:n9:n9b:n9t:n10:n10b:n11:n11b:n12:n12b:n13:n13b:n14:n14b:n15:n16:n17:n17b:n18:n18b:n19:n19b:n20:n21:n21b:n22:n23:n23b:n24:n24b:n25:n25b:n26:n26b:n27:n27b:n28:n28b:n29:n30:n31:n31b:n32:n32b:n33:n33b:n34:n34b:n35:n36:n36b:n37:n37b:n38:n38b:n39:n39b:n40:n41:n42:n42b:n43:n44:n44b:n45:n46:n46b:pl1:pl2:pl3:pl4:s10:s20:s30:s40:s50:s60:s70:s80:s90:s100:death:qet:tri:tripr:c2p:c0:c1:c2:c3:c4:c5:c6:c7:c8:c9:pr0:pr1:pr2:pr3:pr4:pr5:pr6:pr7:pr8:pr9:prp2:t25:t50:t75:t100:tam:onepl:oneplb:twopl:twoplb:prt:prt2b:sjo:sjoM:sjoD:sjoH:trof:d1:d2:cred1:credn:gfdd:[]) = (EstadoGloss 0 False [0,2,5,6] estadoInicial1 MainMenu 1 Jogar [fundo,fundo1,fundo1r,fundo2,sky,skyr,skyv,skyrv,vu,vur,pvu,prun,prunr,por,ct,ctr,ds,dsr,nt,ntr,sv,svr,(whereStart start),b0,b1,b2,b3,b4,b5,b6,b7,titulo n1,n2,n2b,n3,n3b,n3t,nJogar n4,nJogar n4b,n5,n5b,n5t,n6,n6b,n7,n7b,n8,n8b,n9,n9b,n9t,n10,n10b,n11,n11b,n12,n12b,n13,n13b,n14,n14b,n15,n16,n17,n17b,n18,n18b,n19,n19b,n20,n21,n21b,n22,n23,n23b,n24,n24b,n25,n25b,n26,n26b,n27,n27b,n28,n28b,n29,n30,n31,n31b,n32,n32b,n33,n33b,n34,n34b,n35,n36,n36b,n37,n37b,n38,n38b,n39,n39b,n40,n41,n42,n42b,n43,n44,n44b,n45,n46,n46b,pl1,pl2,pl3,pl4,s10,s20,s30,s40,s50,s60,s70,s80,s90,s100,(Scale 0.02 0.02 death),qet,pt tri,ptr tripr,c2p,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,pr0,pr1,pr2,pr3,pr4,pr5,pr6,pr7,pr8,pr9,prp2,t25,t50,t75,t100,tam,tam,onepl,oneplb,twopl,twoplb,prt,prt2b,sjo,sjoM,sjoD,sjoH,trof,d1,d2,cred1,credn,gfdd])

-- | Função que desenha o EstadoGloss conforme os seus argumentos
desenhaEstadoGloss :: EstadoGloss -> Picture
-- |MAIN MENU
desenhaEstadoGloss (EstadoGloss t ib l e MainMenu _ x li ) | x == Jogar = Pictures [f (ei 0 li),(ei 31 li),(ei 38 li),nC (ei 42 li),(ei 130 li)]
                                                           | x == Creditos = Pictures [f (ei 0li),(ei 31 li),(ei 37 li),nC (ei 43 li),Translate 0 (-200)(ei 130 li)]
-- |MENUCREDITOS
desenhaEstadoGloss (EstadoGloss _ _ _ _ MenuCreditos _ _ li ) = Pictures [f (ei 0 li),Translate 0 400 (ei 42 li),Translate (-200) (-100) (ei 173 li),Translate 600 350(ei 174 li)]
-- | MENUBOT
desenhaEstadoGloss (EstadoGloss t ib l e MenuBot _ x li )  | x == Player1 = Pictures [f (ei 0 li),(ei 31 li),npl1(ei 161 li),npl2(ei 162 li),Translate 400 70 (ei 130 li),Translate (-700) 100 (ei 171 li)]
                                                           | x == Player2 = Pictures [f (ei 0 li),(ei 31 li),npl1(ei 160 li),npl2(ei 163 li),Translate 400 (-130) (ei 130 li),Translate (-700) 100 (ei 171 li),Translate (-700) (-200) (ei 172 li)]
-- |PLAYMENU
desenhaEstadoGloss (EstadoGloss t ib l e PlayMenu _ x li) | x == IniciarJogo =  Pictures [f (ei 0 li),(ei 31 li),nIJ (ei 33 li),nEM (ei 34 li),nEJ (ei 39 li),nMJ (ei 48 li),(ei 130 li)]
                                                       | x == EscolherMapa = Pictures [f (ei 0 li),(ei 31 li),nIJ (ei 32 li),nEM (ei 35 li),nEJ (ei 39 li),nMJ (ei 48 li),Translate 0 (-150) (ei 130 li)]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
                                                       | x == EscolherJogador = Pictures [f (ei 0 li),(ei 31 li),nIJ (ei 32 li),nEM (ei 34 li),nEJb (ei 40 li),nMJ (ei 48 li),Translate 0 (-300)(ei 130 li)] 
                                                       | x == MiniJogos = Pictures [f (ei 0 li),(ei 31 li),nIJ (ei 32 li),nEM (ei 34 li),nEJ (ei 39 li),nMJ (ei 49 li),Translate 0 (-450)(ei 130 li)] 

-- |MENUMAPA
-- |City
desenhaEstadoGloss (EstadoGloss t ib l e MenuMapa 1 x li) | x == Mapa1 = Pictures [f2 (ei 1 li),nr25 (doMapa mapaCt1),vo (ei 46 li),vg (ei 44 li),(Translate 1600 (-75) (ei 130 li)),pct (ei 14 li)]
                                                       | x == Mapa2 = Pictures [f2 (ei 1 li),nr50 (doMapa mapaCt2),vo (ei 46 li),vg (ei 44 li),(Translate 1600 (-75) (ei 130 li)),(Translate (-1600) (25) (Rotate 180 (ei 130 li))),pct (ei 14  li)]
                                                       | x == Mapa3 = Pictures [f2 (ei 1 li),nr75 (doMapa mapaCt3),vo (ei 46 li),vg (ei 44 li),(Translate (-1600) (25) (Rotate 180 (ei 130 li))),pct (ei 14  li)] -- | mapaCt3: fazer
                                                       | x == Voltar = Pictures [f2 (ei 1 li),Translate 0 300(nr25(doMapa mapaCt1)),Translate 0 100 (nr50(doMapa mapaCt2)),Translate 0 (-100) (nr75(doMapa mapaCt3)),vg (ei 44 li),vo (ei 47 li),(Translate 950(-470)(ei 130 li)),tm (ei 158 li),t1 (ei 154 li), t2 (ei 155 li),t3 (ei 156 li)]
                                                       | x == VistaGeral = Pictures [f2 (ei 1 li),Translate 0 300(nr25(doMapa mapaCt1)),Translate 0 100 (nr50(doMapa mapaCt2)),Translate 0 (-100) (nr75(doMapa mapaCt3)),vg (ei 45 li),vo (ei 46 li),(Translate 150(-470)(ei 130 li)),tm (ei 158 li),t1 (ei 154 li), t2 (ei 155 li),t3 (ei 156 li)]
-- |Desert
desenhaEstadoGloss (EstadoGloss t ib l e MenuMapa 2 x li)  | x == Mapa1 = Pictures [f2 (ei 1 li),nr25 (doMapa mapaDs1),vo (ei 46 li),vg (ei 44 li),(Translate 1600 (-75) (ei 130 li)),pct (ei 16 li)]
                                                        | x == Mapa2 = Pictures [f2 (ei 1 li),nr50 (doMapa mapaDs2),vo (ei 46 li),vg (ei 44 li),(Translate 1600 (-75) (ei 130 li)),(Translate (-1600) (25) (Rotate 180 (ei 130 li))),pct (ei 16 li)]
                                                        | x == Mapa3 = Pictures [f2 (ei 1 li),nr75 (doMapa mapaDs3),vo (ei 46 li),vg (ei 44 li),(Translate (-1600) (25) (Rotate 180 (ei 130 li))),pct (ei 16 li)] 
                                                        | x == Voltar = Pictures [f2 (ei 1 li),Translate 0 300(nr25(doMapa mapaDs1)),Translate 0 100 (nr50(doMapa mapaDs2)),Translate 0 (-100) (nr75(doMapa mapaDs3)),vg (ei 44 li),vo (ei 47 li),(Translate 950(-470)(ei 130 li)),tm (ei 158 li),t1 (ei 154 li), t2 (ei 155 li),t3 (ei 156 li)]
                                                        | x == VistaGeral = Pictures [f2 (ei 1 li),Translate 0 300(nr25(doMapa mapaDs1)),Translate 0 100 (nr50(doMapa mapaDs2)),Translate 0 (-100) (nr75(doMapa mapaDs3)),vg (ei 45 li),vo (ei 46 li),(Translate 150(-470)(ei 130 li)),tm (ei 158 li),t1 (ei 154 li), t2 (ei 155 li),t3 (ei 156 li)]
-- |Nature
desenhaEstadoGloss (EstadoGloss t ib l e MenuMapa 3 x li) | x == Mapa1 = Pictures [f2 (ei 1 li),nr25 (doMapa mapaNt1),vo (ei 46 li),vg (ei 44 li),(Translate 1600 (-75) (ei 130 li)),pct (ei 18 li)]
                                                       | x == Mapa2 = Pictures [f2 (ei 1 li),nr50 (doMapa mapaNt2),vo (ei 46 li),vg (ei 44 li),(Translate 1600 (-75) (ei 130 li)),(Translate (-1600) (25) (Rotate 180 (ei 130 li))),pct (ei 18 li)]
                                                       | x == Mapa3 = Pictures [f2 (ei 1 li),nr75 (doMapa mapaNt3),vo (ei 46 li),vg (ei 44 li),(Translate (-1600) (25) (Rotate 180 (ei 130 li))),pct (ei 18 li)]
                                                       | x == Voltar = Pictures [f2 (ei 1 li),Translate 0 300(nr25(doMapa mapaNt1)),Translate 0 100 (nr50(doMapa mapaNt2)),Translate 0 (-100) (nr75(doMapa mapaNt3)),vo (ei 47 li),vg (ei 44 li),(Translate 950(-470)(ei 130 li)),tm (ei 158 li),t1 (ei 154 li), t2 (ei 155 li),t3 (ei 156 li)]
                                                       | x == VistaGeral = Pictures [f2 (ei 1 li),Translate 0 300(nr25(doMapa mapaNt1)),Translate 0 100 (nr50(doMapa mapaNt2)),Translate 0 (-100) (nr75(doMapa mapaNt3)),vg (ei 45 li),vo (ei 46 li),(Translate 150(-470)(ei 130 li)),tm (ei 158 li),t1 (ei 154 li), t2 (ei 155 li),t3 (ei 156 li)]
-- |Savana
desenhaEstadoGloss (EstadoGloss t ib l e MenuMapa 4 x li) | x == Mapa1 = Pictures [f2 (ei 1 li),nr25 (doMapa mapaSv1),vo (ei 46 li),vg (ei 44 li),(Translate 1600 (-75) (ei 130 li)),pct (ei 20 li)]
                                                       | x == Mapa2 = Pictures [f2 (ei 1 li),nr50 (doMapa mapaSv2),vo (ei 46 li),vg (ei 44 li),(Translate 1600 (-75) (ei 130 li)),(Translate (-1600) (25) (Rotate 180 (ei 130 li))),pct (ei 20 li)]
                                                       | x == Mapa3 = Pictures [f2 (ei 1 li),nr75 (doMapa mapaSv3),vo (ei 46 li),vg (ei 44 li),(Translate 1600 (-75) (ei 130 li)),(Translate (-1600) (25) (Rotate 180 (ei 130 li))),pct (ei 20 li)]
                                                       | x == Voltar = Pictures [f2 (ei 1 li),Translate 0 300(nr25(doMapa mapaSv1)),Translate 0 100 (nr50(doMapa mapaSv2)),Translate 0 (-100) (nr75(doMapa mapaSv3)),vo (ei 47 li),vg (ei 44 li),(Translate 950(-470)(ei 130 li)),tm (ei 158 li),t1 (ei 154 li), t2 (ei 155 li),t3 (ei 156 li)]
                                                       | x == VistaGeral = Pictures [f2 (ei 1 li),Translate 0 300(nr25(doMapa mapaSv1)),Translate 0 100 (nr50(doMapa mapaSv2)),Translate 0 (-100) (nr75(doMapa mapaSv3)),vg (ei 45 li),vo (ei 46 li),(Translate 150(-470)(ei 130 li)),tm (ei 158 li),t1 (ei 154 li), t2 (ei 155 li),t3 (ei 156 li)]
{-BASE
desenhaEstadoGloss (EstadoGloss t ib l e MenuMapa _ Mapa1 li) = Pictures [f2 (ei 1 li),nr(doMapa mapa1),vg (ei 44 li),vo (ei 46 li),(Translate 1200 (-100)(ei 130 li))]
desenhaEstadoGloss (EstadoGloss t ib l e MenuMapa _ Mapa2 li) = Pictures [f2 (ei 1 li),nr(doMapa mapa2),vg (ei 44 li),vo (ei 46 li),(Translate 1200 (-100)(ei 130 li)), (Translate (-1250) 0 (Rotate 180 (ei 130 li)))]
desenhaEstadoGloss (EstadoGloss t ib l e MenuMapa _ Mapa3 li) = Pictures [f2 (ei 1 li),nr(doMapa mapa3),vg (ei 44 li),vo (ei 46 li),(Translate 1200 (-100)(ei 130 li)), (Translate (-1250) 0 (Rotate 180 (ei 130 li)))]
desenhaEstadoGloss (EstadoGloss t ib l e MenuMapa _ Mapa4 li) = Pictures [f2 (ei 1 li),nr(doMapa mapa4),vg (ei 44 li),vo (ei 46 li),(Translate (-1250) (0) (Rotate 180 (ei 130 li)))]
desenhaEstadoGloss (EstadoGloss t ib l e MenuMapa _ Voltar li) = Pictures [f2 (ei 1 li),nr1(doMapa mapa1),nr2(doMapa mapa2),nr3(doMapa mapa3),nr4(doMapa mapa4),vo (ei 47 li),(Translate 950(-470)(ei 130 li))]-}

-- |GAME
desenhaEstadoGloss estado@(EstadoGloss t ib l e Game 1 x li) | x == Jogo = Pictures [Translate ((-100) * realToFrac (snd(takeMenoreMaiorDist (jogadoresEstado e)))) 0 (background (ei 14  li) (ei 15 li)),(titulo (ei 31 li)),Translate 600 (-380) (desenhaEstado (takeMenoreMaiorDist (jogadoresEstado e)) e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),(ei 22 li)] (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[]))),relog(doCronometro t ((ei 133 li):(ei 134 li):(ei 135 li):(ei 136 li):(ei 137 li):(ei 138 li):(ei 139 li):(ei 140 li):(ei 141 li):(ei 142 li):(ei 132 li):[]))]
                                                          | x == Start = desenhaEstadoGloss estado{opcao=Jogo}

desenhaEstadoGloss estado@(EstadoGloss t ib l e Game 2 x li) | x == Jogo = Pictures [Translate ((-100) * realToFrac (snd(takeMenoreMaiorDist (jogadoresEstado e)))) 0 (background (ei 16 li) (ei 17 li)),(titulo (ei 31 li)),Translate 600 (-380) (desenhaEstado (takeMenoreMaiorDist (jogadoresEstado e)) e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),(ei 22 li)] (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[]))),relog (doCronometro t ((ei 133 li):(ei 134 li):(ei 135 li):(ei 136 li):(ei 137 li):(ei 138 li):(ei 139 li):(ei 140 li):(ei 141 li):(ei 142 li):(ei 132 li):[]))]
                                                          | x == Start = desenhaEstadoGloss estado{opcao=Jogo}

desenhaEstadoGloss estado@(EstadoGloss t ib l e Game 3 x li) | x == Jogo= Pictures [Translate ((-100) * realToFrac (snd(takeMenoreMaiorDist (jogadoresEstado e)))) 0 (background (ei 18 li) (ei 19 li)),(titulo (ei 31 li)),Translate 600 (-315) (desenhaEstado (takeMenoreMaiorDist (jogadoresEstado e)) e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),(ei 22 li)] (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[]))),relog (doCronometro t ((ei 133 li):(ei 134 li):(ei 135 li):(ei 136 li):(ei 137 li):(ei 138 li):(ei 139 li):(ei 140 li):(ei 141 li):(ei 142 li):(ei 132 li):[]))]
                                                          | x == Start = desenhaEstadoGloss estado{opcao=Jogo}

desenhaEstadoGloss estado@(EstadoGloss t ib l e Game 4 x li) | x == Jogo =  Pictures [Translate ((-100) * realToFrac (snd(takeMenoreMaiorDist (jogadoresEstado e)))) 0 (background (ei 20 li) (ei 21 li)),(titulo (ei 31 li)),Translate 600 (-380) (desenhaEstado (takeMenoreMaiorDist (jogadoresEstado e)) e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),(ei 22 li)] (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[]))),relog (doCronometro t ((ei 133 li):(ei 134 li):(ei 135 li):(ei 136 li):(ei 137 li):(ei 138 li):(ei 139 li):(ei 140 li):(ei 141 li):(ei 142 li):(ei 132 li):[]))]
                                                          | x == Start = desenhaEstadoGloss estado{opcao=Jogo}
desenhaEstadoGloss (EstadoGloss t ib l e Game _ Jogo li) = Pictures [Translate ((-100) * realToFrac (snd(takeMenoreMaiorDist (jogadoresEstado e)))) 0 (background (f2 (ei 1 li)) (f2 (ei 2 li))),(Translate 0 (-800)(ei 31 li)),Translate 600 0 (desenhaEstado (takeMenoreMaiorDist (jogadoresEstado e)) e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),(ei 22 li)] (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[])))]
desenhaEstadoGloss (EstadoGloss t ib l e Game _ SpaceJump li) | mapaEstado e == mapaSJF || mapaEstado e == mapaSJH = Pictures[Scale (sc a) (sc a) (Pictures [ b (Pictures[(background1 ((ei 4 li):(ei 5 li):(ei 6  li):(ei 7  li):[])),sinais ((ei 118 li):(ei 119 li):(ei 120 li):(ei 121 li):(ei 122 li):(ei 123 li):(ei 124 li):(ei 125 li):(ei 126 li):(ei 127 li):[])]),Translate 600 0 (desenhaEstado c e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),(ei 22 li)] [head (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[])),Blank,Blank,Blank])]),Translate 0 (-300) (ei 53 li),(Translate (-600) 400 (ei 166 li))]
                                                              | otherwise = Pictures[Scale (sc a) (sc a) (Pictures [ b (Pictures[(background1 ((ei 4 li):(ei 5 li):(ei 6  li):(ei 7  li):[])),sinais ((ei 118 li):(ei 119 li):(ei 120 li):(ei 121 li):(ei 122 li):(ei 123 li):(ei 124 li):(ei 125 li):(ei 126 li):(ei 127 li):[])]),Translate 600 0 (desenhaEstado c e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),(ei 22 li)] [head (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[])),Blank,Blank,Blank])]),Translate 0 (-300) (ei 53 li),(Translate (-600) 400 (ei 167 li))]
                                                            where
                                                            a = alturaMax (jogadoresEstado e) (mapaEstado e)
                                                            b = Translate ((-100)  * realToFrac (snd(takeMenoreMaiorDist (jogadoresEstado e)))) 0 
                                                            c = takeMenoreMaiorDist (jogadoresEstado e)
{-desenhaEstadoGloss (EstadoGloss t ib l e Game _ SpaceJump li) = Translate 0 (realToFrac a) (Pictures [ b (Pictures[(background (ei 4 li) (ei 4 li)),sinais ((ei 118 li):(ei 119 li):(ei 120 li):(ei 121 li):(ei 122 li):(ei 123 li):(ei 124 li):(ei 125 li):(ei 126 li):(ei 127 li):[])]), Translate 0 (-800) (ei 31 li) ,Translate 600 0 (desenhaEstado c e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),Translate 1550 0 (ei 22 li)] [head (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[])),Blank,Blank,Blank])])
                                                                                                                                                                                                                                         where
                                                                                                                                                                                                                                             a = (maximum (takeAlturas d f )) * (-100)
                                                                                                                                                                                                                                             b = Translate ((-100)  * realToFrac (snd(takeMenoreMaiorDist d ))) 0
                                                                                                                                                                                                                                             c = takeMenoreMaiorDist d  
                                                                                                                                                                                                                                             d = jogadoresEstado e
                                                                                                                                                                                                                                             f = mapaEstado e    -}                                               
desenhaEstadoGloss (EstadoGloss t ib l e Game _ GoFast li) = Pictures [Translate ((-100) * realToFrac (snd(takeMenoreMaiorDist (jogadoresEstado e)))) 0 (backgroundlava (ei 8  li) (ei 9  li)),Translate (420+a) (-400) (plava (ei 10  li)),Translate 300 (-350) (desenhaEstado b e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),(ei 22 li)] [head (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[])),Blank,Blank,Blank]),Translate 500 300(ei 175 li)]
                                                        where
                                                        a = (-(realToFrac (snd b) * 100))
                                                        b = (takeMenoreMaiorDist (jogadoresEstado e))

desenhaEstadoGloss (EstadoGloss t ib l e Game _ PortalRun li) = Pictures [Translate ((-100) * realToFrac (snd(takeMenoreMaiorDist (jogadoresEstado e)))) 0 (Pictures[ (backgroundlava (ei 11  li) (ei 12  li)),Translate (-292) (-345) (doPortal (ei 13  li) (mapaEstado e))]) ,Translate 500 (-370) (desenhaEstado b e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),(ei 22 li)] [head (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[])),Blank,Blank,Blank]),Translate 300 350(doCronometro t ((ei 143 li):(ei 144 li):(ei 145 li):(ei 146 li):(ei 147 li):(ei 148 li):(ei 149 li):(ei 150 li):(ei 151 li):(ei 152 li):(ei 153 li):[])),Translate (-600) 350 (doCronometro 200 ((ei 143 li):(ei 144 li):(ei 145 li):(ei 146 li):(ei 147 li):(ei 148 li):(ei 149 li):(ei 150 li):(ei 151 li):(ei 152 li):(ei 153 li):[])),Translate (-400) 450 (ei 165 li),Translate 400 450(ei 164 li)]
                                                            where
                                                            a = (-(realToFrac (snd b) * 100))
                                                            b = (takeMenoreMaiorDist (jogadoresEstado e))
desenhaEstadoGloss (EstadoGloss t ib l e Game 6 Start li) = Pictures [ (backgroundlava (ei 11  li) (ei 12  li)),Translate (-292) (-345) (doPortal (ei 13  li) (mapaEstado e)),Translate 500 (-370) (desenhaEstado b e [doMapa (mapaEstado e),(ei 22 li),(ei 128 li),(ei 22 li)] [head (knowPlayer l ((ei 23 li):(ei 24 li):(ei 25 li):(ei 26 li):(ei 27 li):(ei 28 li):(ei 29 li):(ei 30 li):[])),Blank,Blank,Blank]),Translate 300 350 (doCronometro t ((ei 143 li):(ei 144 li):(ei 145 li):(ei 146 li):(ei 147 li):(ei 148 li):(ei 149 li):(ei 150 li):(ei 151 li):(ei 152 li):(ei 153 li):[])),Translate (-600) 350 (doCronometro 200 ((ei 143 li):(ei 144 li):(ei 145 li):(ei 146 li):(ei 147 li):(ei 148 li):(ei 149 li):(ei 150 li):(ei 151 li):(ei 152 li):(ei 153 li):[])),Translate (-400) 450 (ei 165 li),Translate 400 450 (ei 164 li)]
                                                        where
                                                        a = (-(realToFrac (snd b) * 100))
                                                        b = (takeMenoreMaiorDist (jogadoresEstado e))                                                                                                            
                                                                                                                                                                                                                                                                                                            
-- |PLAYER MENU
desenhaEstadoGloss (EstadoGloss t ib l e PlayerMenu y x li) | x == PlayerBlue = Pictures [f (ei 0 li),bEJ (ei 23 li),vg (ei 44 li),vo (ei 46 li),Translate 0 410 (ei 41 li),triPlayerMenu (ei 130 li),whatPlayer y ((ei 114 li):(ei 115 li):(ei 116 li):(ei 117 li):[])]
                                                         | x == PlayerBrown = Pictures [f (ei 0 li),bEJ (ei 24 li),vg (ei 44 li),vo (ei 46 li),Translate 0 410 (ei 41 li),triPlayerMenu (ei 130 li),whatPlayer y ((ei 114 li):(ei 115 li):(ei 116 li):(ei 117 li):[])]
                                                         | x == PlayerGreen = Pictures [f (ei 0 li),bEJ (ei 25 li),vg (ei 44 li),vo (ei 46 li),Translate 0 410 (ei 41 li),triPlayerMenu (ei 130 li),whatPlayer y ((ei 114 li):(ei 115 li):(ei 116 li):(ei 117 li):[])]
                                                         | x == PlayerGrey = Pictures [f (ei 0 li),bEJ (ei 26 li),vg (ei 44 li),vo (ei 46 li),Translate 0 410 (ei 41 li),triPlayerMenu (ei 130 li),whatPlayer y ((ei 114 li):(ei 115 li):(ei 116 li):(ei 117 li):[])]                                                                                                                                                                                                                          
                                                         | x == PlayerOrange = Pictures [f (ei 0 li),bEJ (ei 27 li),vg (ei 44 li),vo (ei 46 li),Translate 0 410 (ei 41 li),triPlayerMenu (ei 130 li),whatPlayer y ((ei 114 li):(ei 115 li):(ei 116 li):(ei 117 li):[])]
                                                         | x == PLayerPurple = Pictures [f (ei 0 li),bEJ (ei 28 li),vg (ei 44 li),vo (ei 46 li),Translate 0 410 (ei 41 li),triPlayerMenu (ei 130 li),whatPlayer y ((ei 114 li):(ei 115 li):(ei 116 li):(ei 117 li):[])]
                                                         | x == PlayerRed = Pictures [f (ei 0 li),bEJ (ei 29 li),vg (ei 44 li),vo (ei 46 li),Translate 0 410 (ei 41 li),triPlayerMenu (ei 130 li),whatPlayer y ((ei 114 li):(ei 115 li):(ei 116 li):(ei 117 li):[])]
                                                         | x == PlayerSpec = Pictures [f (ei 0 li),bEJ (ei 30 li),vg (ei 44 li),vo (ei 46 li),Translate 0 410 (ei 41 li),triPlayerMenu (ei 130 li),whatPlayer y ((ei 114 li):(ei 115 li):(ei 116 li):(ei 117 li):[])]
                                                         | x == VistaGeral = Pictures [f (ei 0 li),p0 (ei 23 li), p1 (ei 24 li),p2 (ei 25 li),p3 (ei 26 li),p4 (ei 27 li),p5 (ei 28 li),p6 (ei 29 li),p7 (ei 30 li),vg (ei 45 li),vo (ei 46 li),(Translate 150(-470)(ei 130 li)),Translate 0 410 (ei 41 li)]
                                                         | x == Voltar = Pictures [f (ei 0 li),p0 (ei 23 li),p1 (ei 24 li),p2 (ei 25 li),p3 (ei 26 li),p4 (ei 27 li),p5 (ei 28 li),p6 (ei 29 li),p7 (ei 30 li),vg (ei 44 li),vo (ei 47 li),(Translate 950(-470)(ei 130 li)),Translate 0 410 (ei 41 li)]
-- |GAME OVER          
-- |portal run
desenhaEstadoGloss (EstadoGloss t ib l e GameOver 6 x li) | x == JogarNovamente = Pictures [(ei 11  li),Translate 0 (-200) (jg (ei 64 li)),Translate 0 (-200) (vm (ei 65 li)),Translate (-100) (-250)(ei 131 li),Translate 0 400 (ei 62 li)]
                                                          | x == VoltarAoMenu = Pictures [(ei 11  li),Translate 0 (-200)(jg (ei 63 li)),Translate 0 (-200)(vm (ei 66 li)),Translate (780) (-250)(ei 131 li),Translate 0 400 (ei 62 li)]

desenhaEstadoGloss (EstadoGloss t ib l e GameOver 61 x li) | x == ProximoNivel = Pictures [(ei 11  li),pn (ei 110 li),Translate (100) (-250) (vm (ei 65 li)),Translate (600) (-50) (ei 131 li),Translate 0 400 (ei 108 li)]
                                                           | x == VoltarAoMenu = Pictures [(ei 11  li),pn (ei 109 li),Translate (100) (-250) (vm (ei 66 li)),Translate (850) (-300) (ei 131 li),Translate 0 400 (ei 108 li)]

desenhaEstadoGloss (EstadoGloss t ib l e GameOver 611 x li) | x == VoltarAoMenu = Pictures [(ei 11  li),Translate (100) (-250) (vm (ei 66 li)),Translate (850) (-300) (ei 131 li),Translate 0 400 (ei 108 li)]
-- |go fast
desenhaEstadoGloss (EstadoGloss t ib l e GameOver 5 x li) | x == JogarNovamente = Pictures [(ei 8  li),Translate 0 (-250) (jg (ei 68 li)),Translate (100) (-250) (vm (ei 70 li)),Translate (-320) (-500)(Scale 0.7 0.7 (ei 130 li)),Translate 200 200 (ei 69 li)]
                                                          | x == VoltarAoMenu =  Pictures [(ei 8  li),Translate 0 (-250)(jg (ei 67 li)),Translate (100) (-250)(vm (ei 71 li)),Translate (600) (-500)(Scale 0.7 0.7 (ei 130 li)),Translate 200 200 (ei 69 li)]

desenhaEstadoGloss (EstadoGloss t ib l e GameOver 51 x li) | x == ProximoNivel =  Pictures [(ei 8  li),pn (ei 107 li),Translate (100) (-250) (vm (ei 70 li)),Translate (400) (-250)(Scale 0.7 0.7 (ei 130 li)),Translate 200 200 (ei 105 li)]
                                                           | x == VoltarAoMenu = Pictures [(ei 8  li),pn (ei 106 li),Translate (100) (-250)(vm (ei 71 li)),Translate (600) (-500)(Scale 0.7 0.7 (ei 130 li)),Translate 200 200 (ei 105 li)]

desenhaEstadoGloss (EstadoGloss t ib l e GameOver 511 x li) | x == VoltarAoMenu = Pictures [(ei 8  li),Translate (100) (-250)(vm (ei 71 li)),Translate (600) (-500)(Scale 0.7 0.7 (ei 130 li)),Translate 200 200 (ei 105 li)]
-- |spacejump
desenhaEstadoGloss (EstadoGloss t ib l e GameOver 7 x li) | x == JogarNovamente = Pictures [(ei 4 li),Translate 0 (-250) (jg (ei 74 li)),Translate (100) (-250) (vm (ei 75 li)),Translate (-320) (-480)(Scale 0.7 0.7 (ei 130 li)),Translate 0 300 (ei 72 li)]
                                                          | x == VoltarAoMenu = Pictures [(ei 4 li),Translate 0 (-250)(jg (ei 73 li)),Translate (100) (-250)(vm (ei 76 li)),Translate (620) (-480)(Scale 0.7 0.7 (ei 130 li)),Translate 0 300 (ei 72 li)]

desenhaEstadoGloss (EstadoGloss t ib l e GameOver 71 x li) | x == ProximoNivel = Pictures [(ei 4 li),pn (ei 113 li),Translate (100) (-250) (vm (ei 75 li)),Translate (400) (-230)(Scale 0.7 0.7 (ei 130 li)),Translate 0 300 (ei 111 li)]
                                                           | x == VoltarAoMenu = Pictures [(ei 4 li),pn (ei 112 li),Translate (100) (-250)(vm (ei 76 li)),Translate (620) (-480)(Scale 0.7 0.7 (ei 130 li)),Translate 0 300 (ei 111 li)]

desenhaEstadoGloss (EstadoGloss t ib l e GameOver 711 x li) | x == VoltarAoMenu = Pictures [(ei 4 li),Translate (100) (-250)(vm (ei 76 li)),Translate (620) (-480)(Scale 0.7 0.7 (ei 130 li)),Translate 0 300 (ei 111 li)]



desenhaEstadoGloss (EstadoGloss t ib l e GameOver y x li) | x == JogarNovamente = Pictures [f2 (ei 1 li),(Translate 0 (-800)(ei 31 li)),Translate (-20) 0(jg (ei 58 li)),vm (ei 59 li),Translate (-100) (-250)(ei 130 li),Translate 0 400 (ei 61 li),Translate 0 300 (whatPlayer ((seeW e)+1) ((ei 114 li):(ei 115 li):(ei 116 li):(ei 117 li):[])),Translate 0 200(ei 170 li)]
                                                          | x == VoltarAoMenu = Pictures [f2 (ei 1 li),(Translate 0 (-800)(ei 31 li)),jg (ei 57 li),vm (ei 60 li),Translate (780) (-250)(ei 130 li),Translate 0 400 (ei 61 li),Translate 0 300 (whatPlayer((seeW e)+1) ((ei 114 li):(ei 115 li):(ei 116 li):(ei 117 li):[])),Translate 0 200(ei 170 li)]

-- |MINIJOGOS
desenhaEstadoGloss (EstadoGloss t ib l e MenuMiniJogos _ x li) | x == GoFast = Pictures [f2 (ei 3 li),vo (ei 46 li),Translate 0 400 (ei 50 li),gf (ei 52 li),lj (ei 53 li),pr (ei 55 li),Translate 25 115 (ei 130 li)]
                                                            | x == PortalRun = Pictures [f2 (ei 3 li),vo (ei 46 li),Translate 0 400 (ei 50 li),gf (ei 51 li),lj (ei 53 li),(pr (ei 56 li)),Translate 25 (-50) (ei 130 li)]
                                                            | x == SpaceJump = Pictures [f2 (ei 3 li),vo (ei 46 li),Translate 0 400 (ei 50 li),gf (ei 51 li),lj (ei 54 li),pr (ei 55 li),Translate 25 (-215) (ei 130 li)]
                                                            | x == Voltar = Pictures [f2 (ei 3 li),vo (ei 47 li),Translate 0 400 (ei 50 li),gf (ei 51 li),lj (ei 53 li),pr (ei 55 li),Translate 900 (-470) (ei 130 li)]
-- |MSpaceJump
desenhaEstadoGloss (EstadoGloss t ib l e MSpaceJump _ x li) | x == Facil = Pictures [(ei 4 li),ned (ei 85 li),nf (ei 78 li),nm (ei 79 li),nd (ei 81  li),nh (ei 83 li),Translate 550 150 (ei 130 li)]
                                                         | x == Medio = Pictures [(ei 4 li),ned (ei 85 li),nf (ei 77 li),nm (ei 80 li),nd (ei 81  li),nh (ei 83 li),Translate 500 (-50) (ei 130 li)]
                                                         | x == Dificil = Pictures [(ei 4 li),ned (ei 85 li),nf (ei 77 li),nm (ei 79 li),nd (ei 82  li),nh (ei 83 li),Translate 520 (-250) (ei 130 li)]
                                                         | x == Hardcore = Pictures [(ei 4 li),ned (ei 85 li),nf (ei 77 li),nm (ei 79 li),nd (ei 81  li),nh (ei 84 li),Translate 410 (-450) (ei 130 li)]

-- |MPortalRun
desenhaEstadoGloss (EstadoGloss t ib l e MPortalRun _ x li) | x == Facil = Pictures [(ei 11  li),ned (ei 86 li),nf (ei 88 li),nm (ei 89 li),nd (ei 91 li),nh (ei 93 li),Translate 550 350 (ei 131 li)]
                                                         | x == Medio = Pictures [(ei 11  li),ned (ei 86 li),nf (ei 87 li),nm (ei 90 li),nd (ei 91 li),nh (ei 93 li),Translate 550 150 (ei 131 li)]
                                                         | x == Dificil =  Pictures [(ei 11  li),ned (ei 86 li),nf (ei 87 li),nm (ei 89 li),nd (ei 92 li),nh (ei 93 li),Translate 550 (-50) (ei 131 li)]
                                                         | x == Hardcore = Pictures [(ei 11  li),ned (ei 86 li),nf (ei 87 li),nm (ei 89 li),nd (ei 91 li),nh (ei 94 li),Translate 460 (-250) (ei 131 li)]

-- |MGoFast
desenhaEstadoGloss (EstadoGloss t ib l e MGoFast _ x li) | x == Facil = Pictures [(ei 8  li),ned (ei 95 li),nf (ei 97 li),nm (ei 98 li),nd (ei 100 li),nh (ei 102 li),Translate 550 150 (ei 130 li)]
                                                      | x == Medio = Pictures [(ei 8  li),ned (ei 95 li),nf (ei 96 li),nm (ei 99 li),nd (ei 100 li),nh (ei 102 li),Translate 550 (-50) (ei 130 li)]
                                                      | x == Dificil = Pictures [(ei 8  li),ned (ei 95 li),nf (ei 96 li),nm (ei 98 li),nd (ei 101 li),nh (ei 102 li),Translate 550 (-250) (ei 130 li)]
                                                      | x == Hardcore = Pictures [(ei 8  li),ned (ei 95 li),nf (ei 96 li),nm (ei 98 li),nd (ei 100 li),nh (ei 103 li),Translate 460 (-450) (ei 130 li)]
-- |MTema 
desenhaEstadoGloss (EstadoGloss t ib l e MTema _ x li) | x == City = Pictures [f2 (ei 1 li),titulo (ei 104 li),Translate 0 (-150)(nr1 (ei 14  li)),Translate 0 (-150)(nr2 (ei 16 li)),nr3 (ei 18 li),nr4 (ei 20 li),Translate (-300) (95) (ei 129 li)]
                                                    | x == Desert = Pictures [f2 (ei 1 li),titulo (ei 104 li),Translate 0 (-150)(nr1 (ei 14  li)),Translate 0 (-150)(nr2 (ei 16 li)),nr3 (ei 18 li),nr4 (ei 20 li),Translate (300) (95) (ei 129 li)]
                                                    | x == Nature = Pictures [f2 (ei 1 li),titulo (ei 104 li),Translate 0 (-150)(nr1 (ei 14  li)),Translate 0 (-150)(nr2 (ei 16 li)),nr3 (ei 18 li),nr4 (ei 20 li),Translate (-300) (-255) (ei 129 li)]
                                                    | x == Savana = Pictures [f2 (ei 1 li),titulo (ei 104 li),Translate 0 (-150)(nr1 (ei 14  li)),Translate 0 (-150)(nr2 (ei 16 li)),nr3 (ei 18 li),nr4 (ei 20 li),Translate (300) (-255) (ei 129 li)]
-- | Função que coloca os Portais no MiniJogo "PortalRun"
doPortal :: Picture -> Mapa -> Picture
doPortal x l = Pictures (drawPortal 0 x l)
-- | Função complementar da doPortal
drawPortal :: Float -> Picture -> Mapa -> [Picture] 
drawPortal _ _ [] = [Blank]
drawPortal a p (h:t) = (doLinha a l p) ++ (drawPortal (a-50) p t)
                   where
                     l = findTele 0 h
-- | Função complementar da drawPortal
doLinha :: Float -> [Int] -> Picture -> [Picture]
doLinha _ [] _ = [Blank]
doLinha a (h:t) p =  [Translate (100 *(realToFrac h)) a p] ++ (doLinha a t p)
-- | Função complementar da doLinha
findTele :: Int -> Pista -> [Int]
findTele x [] = []
findTele x (h:t) | sayPiso h == 0 = [x] ++ (findTele (x+1) t)
                 | otherwise = findTele (x+1) t
-- | Função que diz qual foi o jogador que ganhou
seeW :: Estado -> Int
seeW (Estado m js) = pmaior (takedistancias js)
                  where
                      pmaior :: Ord a => [a] -> Int
                      pmaior (h:[]) = 0
                      pmaior (h:t) | h > (head t) = pmaior (h: (tail t))
                                   | otherwise = 1 + pmaior t

plava :: Picture -> Picture
plava x = Pictures [x, Translate 1920 0 x, Translate 2080 0 x]
-- | Função para saber quais os jogadores selcionados para desenhar o Estado
knowPlayer :: [Int] -> [Picture] -> [Picture]
knowPlayer [] _ = [Blank]
knowPlayer (h:t) (b0:b1:b2:b3:b4:b5:b6:b7:[]) | h == 0 = [bi b0] ++ (knowPlayer t (b0:b1:b2:b3:b4:b5:b6:b7:[])) 
                                              | h == 1 = [bi b1] ++ (knowPlayer t (b0:b1:b2:b3:b4:b5:b6:b7:[])) 
                                              | h == 2 = [bi b2] ++ (knowPlayer t (b0:b1:b2:b3:b4:b5:b6:b7:[])) 
                                              | h == 3 = [bi b3] ++ (knowPlayer t (b0:b1:b2:b3:b4:b5:b6:b7:[])) 
                                              | h == 4 = [bi b4] ++ (knowPlayer t (b0:b1:b2:b3:b4:b5:b6:b7:[])) 
                                              | h == 5 = [bi b5] ++ (knowPlayer t (b0:b1:b2:b3:b4:b5:b6:b7:[])) 
                                              | h == 6 = [bi b6] ++ (knowPlayer t (b0:b1:b2:b3:b4:b5:b6:b7:[])) 
                                              | h == 7 = [bi b7] ++ (knowPlayer t (b0:b1:b2:b3:b4:b5:b6:b7:[])) 
-- | Função que junta as iamgens do Backgrund no SpaceJump
background1 :: [Picture] -> Picture
background1 l = Pictures (dotudo 0 10000 l)

dotudo :: Int -> Float -> [Picture] -> [Picture]
dotudo _ (-11600) _  = [Blank]
dotudo n m (x:y:a:b:[]) | n == 0 = [Translate 0 m (linhabackground x y)] ++ (dotudo 1 (m-1080) (x:y:a:b:[]))
                        | otherwise = [Translate 0 m (linhabackground a b)] ++ (dotudo 0 (m-1080) (x:y:a:b:[]))

linhabackground :: Picture -> Picture -> Picture
linhabackground x y = Pictures (doBackground1 0 ((-10000),0) x y)

doBackground1 :: Int -> Coordenadas -> Picture -> Picture -> [Picture]
doBackground1 20 _ _ _ = [Blank]
doBackground1 a (b,c) x y | mod a 2 == 0 = [Translate b c x] ++ (doBackground1 (a+1) (b+1920,c) x y)
                          | otherwise = [Translate b c y] ++ (doBackground1 (a+1) (b+1920,c) x y)

background :: Picture -> Picture -> Picture
background x y = Pictures (doBackground 0 (0,0) x y)

doBackground :: Int -> Coordenadas -> Picture -> Picture -> [Picture]
doBackground 7 _ _ _ = [Blank]
doBackground a (b,c) x y | mod a 2 == 0 = [Translate b c x] ++ (doBackground (a+1) (b+1920,c) x y)
                         | otherwise = [Translate b c y] ++ (doBackground (a+1) (b+1920,c) x y)

backgroundlava :: Picture -> Picture -> Picture
backgroundlava x y = Pictures (blava 0 (0,0) x y)

blava :: Int -> Coordenadas -> Picture -> Picture -> [Picture] 
blava 5 _ _ _ = [Blank]
blava a (b,c) x y | mod a 2 == 0 = [Translate b c (Scale 1 1.005 x)] ++ (blava (a+1) (b+1920,c) x y)
                  | otherwise = [Translate b c (Scale 1 1.005 y)] ++ (blava (a+1) (b+1920,c) x y)

finalPista ::Int -> Estado -> Bool
finalPista 4 _ = False 
finalPista x (Estado m js) | (fromIntegral(length (head m)))-1 <= (distanciaJogador (encontraIndiceLista x js)) = True
                           | otherwise = finalPista (x+1) (Estado m js)

-- | Função que desenha o Estado 
desenhaEstado :: (Double,Double) -> Estado-> [Picture] -> [Picture] -> Picture
desenhaEstado (x,y) (Estado m (j1:j2:j3:j4:[])) (map:start:de:end:[]) (pj1:pj2:pj3:pj4:t) = Translate (-(realToFrac y *100)) 0 (Pictures [map,start,whereEnd m end,(desenhaJogador(j1,pj1,de) m),(desenhaJogador(j2,pj2,de) m),(desenhaJogador(j3,pj3,de) m),(desenhaJogador(j4,pj4,de) m)])
-- | Função que chama a Função reageEvento
reageEventoGloss :: Event -> EstadoGloss -> EstadoGloss
reageEventoGloss ev e@(EstadoGloss x ib l (Estado m js) menu sm o li) = reageEvento ev e
-- | Função que reage à passagem do tempo
reageTempoGloss :: Float -> EstadoGloss -> EstadoGloss
reageTempoGloss t e@(EstadoGloss te ib  l estado@(Estado m js )  Game sm PortalRun li) | te == 200 = e{menuAtual=GameOver,opcao=JogarNovamente,subMenu=6}
                                                                                       | finalPista 0 (Estado m js) == True && (mapaEstado estado)== mapaPRH = e{menuAtual=GameOver,opcao=VoltarAoMenu,subMenu=611}
                                                                                       | finalPista 0 (Estado m js) == True = e{menuAtual=GameOver,opcao=ProximoNivel,subMenu=61}
                                                                                       | otherwise = if sayPiso(peca j m) == 0 then e{estado=estado{jogadoresEstado=atualizaIndiceLista 0 ja js}}
                                                                                                               else EstadoGloss  (te+1) ib l (reageTempo t estado) Game sm PortalRun li
                                                                                       where
                                                                                           j = encontraIndiceLista 0 js
                                                                                           ja = j{distanciaJogador=y+b,pistaJogador=x+a}
                                                                                           y = distanciaJogador (j)
                                                                                           x = pistaJogador (j)
                                                                                           a = fst (sayInts ((peca(encontraIndiceLista 0 js)m)))
                                                                                           b = snd (sayInts ((peca(encontraIndiceLista 0 js)m)))
                                                                                
reageTempoGloss t e@(EstadoGloss te ib  l estado@(Estado m js) menu sm  o li)  | o==GoFast && finalPista 0 (Estado m js) == True && (mapaEstado estado)==mapaGFH = e{menuAtual=GameOver,opcao=VoltarAoMenu,subMenu=511}
                                                                               | o==GoFast && finalPista 0 (Estado m js) == True = e{menuAtual=GameOver,opcao=ProximoNivel,subMenu=51}
                                                                               | finalPista 0 (Estado m js) == True && menu == Game = e{menuAtual=GameOver,opcao=JogarNovamente}
                                                                               | menu == GameOver = e
                                                                               | o==GoFast && (peca (encontraIndiceLista 0 js) m)== Recta Lava 0 = e{menuAtual=GameOver,opcao=JogarNovamente,subMenu=5}
                                                                               | o== SpaceJump && estadoChao (encontraIndiceLista 0 js)== True && snd(takeMenoreMaiorDist js) > 60 && (mapaEstado estado) == mapaSJH = e{menuAtual=GameOver,opcao=VoltarAoMenu,subMenu=711}
                                                                               | o== SpaceJump && estadoChao (encontraIndiceLista 0 js)== True && (mapaEstado estado) == mapaSJF && snd(takeMenoreMaiorDist js) > 60 = e{menuAtual=GameOver,opcao=ProximoNivel,subMenu=71}
                                                                               | o== SpaceJump && estadoChao (encontraIndiceLista 0 js)== True && snd(takeMenoreMaiorDist js) > 70 = e{menuAtual=GameOver,opcao=ProximoNivel,subMenu=71}
                                                                               | o== SpaceJump && estadoChao (encontraIndiceLista 0 js)== True && snd(takeMenoreMaiorDist js) > 20 = e{menuAtual=GameOver,opcao=JogarNovamente,subMenu=7}
                                                                               | o == Start && te >= 0 && sm == 6 = e{opcao=PortalRun,tempo=0}
                                                                               | o == Start && te >= 0 = e{opcao=Jogo,tempo=0}
                                                                               | o == Jogo = EstadoGloss  (te+1) ib l (reageTempo t (moveBots ib estado)) menu sm o li 
                                                                               | otherwise = EstadoGloss  (te+1) ib l (reageTempo t estado) menu sm o li 
--Função que faz mover os Bots
moveBots :: Bool -> Estado -> Estado
moveBots True e@(Estado m js) = c
                           where
                               a = if (isNothing (bot 1 e)) then e else  jogada 1 (fromJust(bot 1 e)) e
                               b = if (isNothing (bot 2 e)) then e else jogada 2 (fromJust(bot 2 a)) a
                               c = if (isNothing (bot 3 e)) then e else jogada 3 (fromJust(bot 3 b)) b
moveBots False e@(Estado m js) = b
                                where
                                  a = if (isNothing (bot 2 e)) then e else jogada 2 (fromJust(bot 2 a)) a
                                  b = if (isNothing (bot 3 e)) then e else jogada 3 (fromJust(bot 3 b)) b


-- | Função que diz os Ints da Peca Teletransporta
sayInts :: Peca -> (Int,Double)
sayInts (Teletransporta a b) = (a,fromIntegral b)

-- | Os FrameRates do Jogo
fr :: Int
fr = 20
-- | A Dimensão do jogo
dm :: Display
dm = FullScreen
--dm = InWindow "Bike" (1920,1080) (0,0)
-- | Função que posiciona a Imagem Start no incio do Mapa
whereStart :: Picture -> Picture
whereStart x = Translate (-817) (-50) (scale 0.4 0.41 (Rotate (-90) x))
-- | Função que posiciona a Imagem Start no fim do Mapa
whereEnd :: Mapa -> Picture -> Picture
whereEnd l p = Translate (-50) 0 (Translate (a*100) 0 p)
             where
                 a = realToFrac(length (head l))
sayPiso :: Peca -> Int
sayPiso (Teletransporta _ _) = 0
sayPiso (Rampa x a b)= sayPiso (Recta x a)
sayPiso (Recta Lava _) = 10
sayPiso (Recta Terra _) = 1
sayPiso (Recta Relva _) = 2
sayPiso (Recta Lama _) = 3
sayPiso (Recta Cola _) = 4
sayPiso (Recta Boost _) = 5
sayPiso (Recta Estrada _)= 9



{- IDEIAS TAREFA 5: 

Eu ainda não sei bem trabalhar com o Gloss,estive a ver os tutorias e a meter algumas cenas num ficheiro à parte só para treinar mas não está nada de jeito, tenho que me dedicar a sério para começar a perceber mas uma cena que eu estive a pensar foi o seguinte:

    - Podiamos usar a ideia inicial que tinhamos do Rally com as equipas e tudo isso mas trocavamos os humanos por stickman porque depois seria muito mais facíl de manipular
    uma vez que bastava criar um de base e dps era só editar os capecetes ou whatever o que quisessemos meter. E depois na escolha das equipas em vez de metermos só foto das equipas, metíamos tipo o Stickman de pé com o capacete da equipa ou assim.  
    
    -Uma cena que vai ser complicado vai ser fazer as rampas, visto que teríamos que ter muitas imagens pré-definidas, disseram me que os stores meteram no site uma cena chamada (Exemplo de Manipulação de Imagens usando o JuicyPixels (Avançado) para ajudar nisso mesmo mas não sei bem como funciona.
    
    -Se adotar-mos a ideia dos Stickman também podiamos fazer o Mapa a desenhar polígonos em vez de ir buscar imagens para tornar mais fácil.

    - IDEIAS PARA MODOS DE JOGO: 
    - Modo de jogo que em vez de ser uma corrida era tipo, o máximo de distância que conseguia percorrer num determinado período de tempo. Ou seja, tinha que repetir várias vezes a mm pista. (Corrida contra o cronómetro basicamente)

    - Modo de Jogo Hardcore, em que adicionamos um novo tipo de piso, tipo Lava, que se o jogador tocasse morria imediatamente.
    
    Estou só a lançar ideias para o ar, é quase impossível ter tempo para isto tudo mas analisa, dá outras ideais para decidir-mos mais ou menos o que fazer!-}

type Coordenadas = (Float,Float) -- | Coordenas do Ecrã (x,y)

-- | Função que desenha o Jogador 
desenhaJogador :: (Jogador,Picture,Picture) -> Mapa -> Picture
desenhaJogador (Jogador x y o t (Morto h),biker,de) l  = if (inclinacao (peca (Jogador x y o t (Morto h))l)) /= 0 then  (Translate (a-840) (b+75) (Rotate (-i) de)) else (Translate (a-840) (b+50) (Rotate (-i) de))
                                   where
                                    a =(fromIntegral(fst(properFraction y))*100) + (realToFrac(snd(properFraction y))*100)
                                    b =(realToFrac(auxAltura (Jogador x y o t (Morto h)) l)*100) + fromIntegral(x*(-50))
                                    i = realToFrac (inclinacao (peca (Jogador x y o t (Morto h)) l))

desenhaJogador (j@(Jogador x y o t (Ar a i g)), biker,de) l = if i /= 0 then Translate (f-840) (b+75) (Rotate (realToFrac(-i)) biker) else (if isReta (peca (j{distanciaJogador=y-1})l) == True then  (Translate (f-840)(b+60) (Rotate (realToFrac(-i)) biker)) else (Translate (f-840)(b+65) (Rotate (realToFrac(-i)) biker)))
                                                     where
                                                        f = (fromIntegral(fst(properFraction y))*100) + (realToFrac(snd(properFraction y))*100)
                                                        b = (realToFrac(a)*100) + fromIntegral(x*(-50))
desenhaJogador (j@(Jogador x y o t (Chao h)),biker,de) l = if (inclinacao (peca j l)) /= 0 then  (Translate (a-840) (b+75) (Rotate (-i) biker)) else (Translate (a-840) (b+50) (Rotate (-i) biker))
                                   where
                                    a =(fromIntegral(fst(properFraction y))*100) + (realToFrac(snd(properFraction y))*100)
                                    b =(realToFrac(auxAltura j l)*100) + fromIntegral(x*(-50))
                                    i = realToFrac (inclinacao (peca j l))
                                    -- |i = if estadoAr j == True then realToFrac(inclinacaoJogador (estadoJogador j)) else realToFrac(inclinacao (peca j l))

-- ** LISTA DE CORES
-- | TRANSPARENTES
transp :: [Color]
transp = [cinzaT,relvaT,terraT,lamaT,colaT,pretoT]
-- |OPACOS
opacos :: [Color]
opacos = [cinza,relva,terra,lama,cola,preto]

-- ** COLORS
-- |Parte Morta
cinza :: Color 
cinza = (makeColorI 128 128 128 255)            
cinzaT :: Color
cinzaT = (makeColorI 128 128 128 100)

-- |Relva
relva :: Color
relva = (makeColorI 34 139 34 255)
relvaT :: Color
relvaT=(makeColorI 34 139 34 100)
-- |Terra
terra :: Color
terra = (makeColorI 112 72 60 255)
terraT :: Color
terraT = (makeColorI 112 72 60 100)
-- |Lama
lama :: Color
lama = (makeColorI 155 118 83 255)
lamaT :: Color
lamaT = (makeColorI 155 118 83 100)
-- |Cola
cola :: Color 
cola = (makeColorI 250 239 225 255)
colaT :: Color
colaT = (makeColorI 250 239 225 100)
-- |Boost
preto :: Color 
preto = (makeColorI 0 0 0 255)
pretoT = (makeColorI 0 0 0 100)

-- | Função que dá os argumentos e junta a [Picture] resultante da DesenharMapa
doMapa :: Mapa -> Picture
doMapa m = Pictures (desenharMapa m (-842,50))
-- | Função que desenha o Mapa
desenharMapa :: Mapa -> Coordenadas -> [Picture]
desenharMapa l (x,y) | length (head l) == 1 = [doColuna (map head l)(x,y)]
                     | otherwise = [doColuna (map head l)(x,y)] ++ (desenharMapa (map tail l) (x+100,y))
-- | Função que dá os argumentos e junta a [Picture] resultante da desenharColuna
doColuna :: Pista -> Coordenadas -> Picture
doColuna l (x,y) = Pictures (desenharColuna (reverse (corColuna l)) (x,y))
-- | Função para saber se a cor vai ser Transparente ou não
corColuna :: Pista -> [(Peca,Bool)]
corColuna [] = []
corColuna l = (last l, comparar (reverse (reversing 1 (takeNrs l)))):corColuna (init l)
-- | Função que Compara as alturas 
comparar :: [(Int,Int)] -> Bool
comparar ((a,b):[]) = False
comparar ((a,b):(c,d):t) | a-c >= b-d = True
                         | otherwise = comparar ((a,b):t)    
-- | Função que desenha uma Coluna do Maopa
desenharColuna :: [(Peca,Bool)] -> Coordenadas -> [Picture]
desenharColuna [] _ = [Blank]
desenharColuna ((a,b):t) (x,y) = desenharPeca (a,b) (x,y):desenharColuna t (x,y-50)
-- | Função auxiliar que junta as alturas a Ints
reversing :: Int -> [Int] -> [(Int,Int)]
reversing _ [] = []
reversing x (h:t) = (h,x) : reversing (x+1) t
-- | Função auxilar que dada uma Pista devolve as Alturas de todas as Pecas
takeNrs :: Pista -> [Int]
takeNrs [] = []
takeNrs ((Teletransporta _ _):t) = [0] ++ takeNrs t 
takeNrs ((Recta _ x):t)= [x] ++ takeNrs t
takeNrs ((Rampa _ x y):t) = [max x y] ++ takeNrs t
-- | Função que diz se a cor da Peca vai ser transparente ou não
isTransparent :: [(Int,Int)] -> Bool
isTransparent ((a,b):[]) = False
isTransparent ((a,b):(c,d):t) | c-a > d-b = True
                              | otherwise = isTransparent ((a,b):t)
-- | Função que desenha a Peca
desenharPeca :: (Peca,Bool) -> Coordenadas -> Picture
desenharPeca (Teletransporta f g,c) (x,y) = Translate x y (Pictures [(Color preto (Polygon [(0,-3), (0,3), (100,3),(100,-3)])),(Color preto (Polygon [(0,-53), (0,-47), (100,-47),(100,-53)]))])
                                  where
                                      a = (makeColorI 153 255 204 255)
desenharPeca ((Rampa p a b),c) (x,y)| c == True = desenharRampa (transp) (x,y)(Rampa p a b)
                                    | otherwise = desenharRampa (opacos)(x,y)(Rampa p a b)
desenharPeca ((Recta p a),c) (x,y) | c == True = desenharRecta (transp)(x,y)(Recta p a)
                                   | otherwise = desenharRecta (opacos)(x,y)(Recta p a)


-- | Função que desenha a Peca caso seja Recta
desenharRecta :: [Color] -> Coordenadas -> Peca -> Picture
desenharRecta l (x,y) (Recta p a) | a > 0 = Pictures [(Translate x (aux a y) (doReta l p)), (Translate x (aux a y) (Color (head l) (Polygon [(0,-53),(100,-53),(100,c-53),(0,c-53)])))]
                                  | otherwise = Translate x (aux a y) (doReta l p)
                                 where
                                    c = (fromIntegral a) * (-100)
                                    aux :: Int -> Float -> Float
                                    aux a y | a > 0 = aux (a-1)(y+100)
                                            | otherwise = y                             
-- | Função complementar da desenharRecta 
doReta :: [Color] -> Piso -> Picture 
doReta (ci:r:t:l:c:p:[]) ps| ps == Relva = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,3),(100,-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47),(100,-53)])), (Color r (Polygon [(0,-47), (0,-3), (100,-3),(100,-47)]))]
                           | ps == Terra = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,3),(100,-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47),(100,-53)])), (Color t (Polygon [(0,-47), (0,-3), (100,-3),(100,-47)]))]
                           | ps == Boost = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,3),(100,-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47),(100,-53)])), (Color ci (Polygon [(0,-47), (0,-3), (100,-3),(100,-47)])),(Color p (Polygon [(10,-10),(20,-25),(10,-40),(15,-40),(25,-25),(15,-10)])),(Color p (Polygon [(30,-10),(40,-25),(30,-40),(35,-40),(45,-25),(35,-10)])),(Color p (Polygon [(50,-10),(55,-10),(65,-25),(55,-40),(50,-40),(60,-25)])),(Color p (Polygon [(70,-10),(75,-10),(85,-25),(75,-40),(70,-40),(80,-25)]))]
                           | ps == Cola =  Pictures [(Color p (Polygon [(0,-3), (0,3), (100,3),(100,-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47),(100,-53)])), (Color c (Polygon [(0,-47), (0,-3), (100,-3),(100,-47)]))]
                           | ps == Lama =  Pictures [(Color p (Polygon [(0,-3), (0,3), (100,3),(100,-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47),(100,-53)])), (Color l (Polygon [(0,-47), (0,-3), (100,-3),(100,-47)]))]
                           | ps == Lava =  Pictures [(Color p (Polygon [(0,-3), (0,3), (100,3),(100,-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47),(100,-53)]))]
                           | ps == Estrada = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,3),(100,-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47),(100,-53)])), (Color ci (Polygon [(0,-47), (0,-3), (100,-3),(100,-47)]))]
-- | Função que desenha a Peca caso seja Rampa
desenharRampa :: [Color] -> Coordenadas -> Peca -> Picture
desenharRampa l (x,y) (Rampa p a b) = Translate x (aux a y)(doRampa l (Rampa p a b) a b)
                                  where
                                    aux :: Int -> Float -> Float
                                    aux a y | a > 0 = aux (a-1) (y+100)
                                            | otherwise = y
-- | Função complementar da desenharRampa
doRampa :: [Color] -> Peca -> Int -> Int -> Picture
doRampa l p a b | b > a = doRampaSubir l p c
                | otherwise = doRampaDescer l p c
            where
                c = abs (a-b)
-- | Função que desenha a Peca caso seja uma Rampa a Subir
doRampaSubir :: [Color] -> Peca -> Int -> Picture
doRampaSubir  (ci:r:t:l:co:p:[]) (Rampa ps a b ) x | ps == Relva = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color r (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color (ci) (Polygon [(0,-53), (100,-53),(100,c-53)])),(Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)]))]
                                                   | ps == Terra = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color t (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color (ci) (Polygon [(0,-53), (100,-53),(100,c-53)])),(Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)]))]
                                                   | ps == Lama = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color l (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color (ci) (Polygon [(0,-53), (100,-53),(100,c-53)])),(Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)]))]
                                                   | ps == Cola = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color co (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color (ci) (Polygon [(0,-53), (100,-53),(100,c-53)])),(Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)]))]
                                                   | ps == Boost = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,(c-3))])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])), (Color ci (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Translate 5 0 (Color p (Polygon [(10,-10+(c*0.2)),(20,-25+(c*0.2)),(10,-40+(c*0.2)),(15,-40+(c*0.2)),(25,-25+(c*0.2)),(15,-10+(c*0.2))]))),Translate 5 0 (Color p (Polygon [(30,-10+(c*0.4)),(40,-25+(c*0.4)),(30,-40+(c*0.4)),(35,-40+(c*0.4)),(45,-25+(c*0.4)),(35,-10+(c*0.4))])),Translate 5 0  (Color p (Polygon [(50,-10+(c*0.6)),(55,-10+(c*0.6)),(65,-25+(c*0.6)),(55,-40+(c*0.6)),(50,-40+(c*0.6)),(60,-25+(c*0.6))])),Translate 5 0  (Color p (Polygon [(70,-10+(c*0.8)),(75,-10+(c*0.8)),(85,-25+(c*0.8)),(75,-40+(c*0.8)),(70,-40+(c*0.8)),(80,-25+(c*0.8))])),(Color (ci) (Polygon [(0,-53), (100,-53),(100,c-53)])),(Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)]))]
                                                   | ps == Estrada = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color ci (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color (ci) (Polygon [(0,-53), (100,-53),(100,c-53)])),(Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)]))]
          where
            i = (atan(abs (fromIntegral x ))*180)/(-pi)
            c = fromIntegral(x*100)
            d = fromIntegral(a*(-100))
-- | Função que desenha a Peca caso seja uma Rampa a Descer
doRampaDescer :: [Color] -> Peca -> Int -> Picture
doRampaDescer (ci:r:t:l:co:p:[]) (Rampa ps a b) x | ps == Relva = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color r (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color ci (Polygon [(0,-53), (0,c-53),(100,c-53)])),Translate 0 e ((Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)])))]
                                              | ps == Terra = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color t (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color ci (Polygon [(0,-53), (0,c-53),(100,c-53)])),Translate 0 e ((Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)])))]
                                              | ps == Lama = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color l (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color ci (Polygon [(0,-53), (0,c-53),(100,c-53)])),Translate 0 e ((Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)])))]
                                              | ps == Cola = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color co (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color ci (Polygon [(0,-53), (0,c-53),(100,c-53)])),Translate 0 e ((Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)])))]
                                              | ps == Boost = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color p (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color ci (Polygon [(0,-53), (0,c-53),(100,c-53)])),Translate 0 e ((Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)])))]
                                              | ps == Estrada = Pictures [(Color p (Polygon [(0,-3), (0,3), (100,(c+3)),(100,c-3)])),(Color p (Polygon [(0,-53), (0,-47), (100,-47+c),(100,-53+c)])),(Color ci (Polygon [(0,-47), (0,-3), (100,c-3),(100,c-47)])),(Color ci (Polygon [(0,-53), (0,c-53),(100,c-53)])),Translate 0 e ((Color ci (Polygon [(0,-53),(100,-53),(100,d-53),(0,d-53)])))]
                where
            c = fromIntegral(x*(-100))
            d = fromIntegral(b*(-100))
            e = if abs (a-b) > 1 then  fromIntegral(abs(a-b))*(-100) else - 100
-- | Função que diz se é uma Reta ou não
isReta :: Peca -> Bool 
isReta (Recta _ _) = True
isReta _ = False  
-- | Função que dada uma lista de Jogadores devolve uma lista com as Distancias de cada Jogador
takedistancias :: [Jogador] -> [Double]
takedistancias [] = []
takedistancias (h:t) = [y] ++ (takedistancias t)
                     where
                         y = distanciaJogador (h)
-- | Função que dada uma Lista de Jogadores devolve a Menor e a Maior distância
takeMenoreMaiorDist :: [Jogador] -> (Double,Double)
takeMenoreMaiorDist l = (minimum x,maximum x)
                      where
                        x = takedistancias l
-- | Função usada no MiniJogo "Space Jump" que nos diz a Altura do Jogador
alturaMax :: [Jogador] -> Mapa -> Double
alturaMax js l | maximum (takeAlturas js l) <= 4 = 4
               | otherwise =  maximum (takeAlturas js l)
-- | Função que dada uma Lista de Jogadores e um mapa devolve uma Lista com todas as Alturas dos Jogadores
takeAlturas :: [Jogador] -> Mapa -> [Double]
takeAlturas [] _ = []
takeAlturas (h:t) l | estadoAr h == True = [alturaJogador (estadoJogador (h))] ++ (takeAlturas t l )
                    | otherwise = [auxAltura h l] ++ (takeAlturas t l)
-- | Funçãoq que dada um Double devolve um Float usado para a função Scale 
sc :: Double -> Float
sc x = realToFrac ((/) 4 x)

-- | Função que faz o Cronómetro usado no Jogo
doCronometro :: Int -> [Picture] -> Picture
doCronometro t l | t < 0 = doContagem (aux (div (abs t) 20)) l
                 | otherwise = doNumber (aux (div t 20) ) l
                 where
                     aux :: Int -> [Int]
                     aux 0 = []
                     aux t | length (digits 60 t) == 2 && last(digits 60 t) == 0 = [head (digits 60 t)] ++ [0] ++ [0]
                           | length (digits 60 t) == 2 && last(digits 60 t) < 10 = [head (digits 60 t)] ++ [0] ++ [last(digits 60 t)]
                           | length (digits 60 t) == 2 = [head (digits 60 t)] ++ (digits 10 (last (digits 60 t) ))
                           | otherwise = digits 10 (head(digits 60 t))

-- | Função que faz corresponder uma lista de Ints à sua respetiva imagem
doNumber :: [Int] -> [Picture] -> Picture
doNumber [] l = Pictures [Translate 0 0 (ei 0 l),Translate 80 0 (ei 0 l),Translate 150 0 (last l), Translate 200 0 (ei 0 l), Translate 280 0 (ei 0 l)]
doNumber (a:[]) l = Pictures [Translate 0 0 (ei 0 l),Translate 80 0 (ei 0 l),Translate 150 0 (last l), Translate 200 0 (ei 0 l), Translate 280 0 (ei a l)]
doNumber (a:b:[]) l = Pictures [Translate 0 0 (ei 0 l),Translate 80 0 (ei 0 l),Translate 150 0 (last l), Translate 200 0 (ei a l), Translate 280 0 (ei b l)]
doNumber (a:b:c:[]) l = Pictures [Translate 0 0 (ei 0 l),Translate 80 0 (ei a l),Translate 150 0 (last l), Translate 200 0 (ei b l), Translate 280 0 (ei c l)]
doNumber (a:b:c:d:[]) l = Pictures [Translate 0 0 (ei a l),Translate 80 0 (ei b l),Translate 150 0 (last l), Translate 200 0 (ei c l), Translate 280 0 (ei d l)]

-- | Função que faz a Contagem para o Jogo Começar
doContagem :: [Int] -> [Picture] -> Picture
doContagem [3] l = (encontraIndiceLista 3 l)
doContagem [2] l = (encontraIndiceLista 2 l)
doContagem [1] l = (encontraIndiceLista 1 l)
doContagem x l   = (encontraIndiceLista 1 l)