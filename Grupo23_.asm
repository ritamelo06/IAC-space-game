; ******************************************************************************
; * IST-UL
; * Autores:   Joana Vaz, ist106078 | Pedro Tavares, ist106474 | Rita Melo ist1107294
; * Grupo:     nº23
; ******************************************************************************

; ******************************************************************************
; * Constantes
; ******************************************************************************apagar
DISPLAYS   EQU 0A000H                        ; endereço dos displays de 7 segmentos (periférico POUT-1)
TEC_LIN    EQU 0C000H                        ; endereço das linhas do teclado (periférico POUT-2)
TEC_COL    EQU 0E000H                        ; endereço das colunas do teclado (periférico PIN)
LINHA_TEST EQU 16                            ; primeira linha a testar (4ª linha, 1000b)
MASCARA    EQU 0FH                           ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado

; Comandos do Media Center:
COMANDOS                EQU 6000H            ; endereço de base dos comandos do MediaCenter

DEFINE_LINHA            EQU COMANDOS + 0AH   ; endereço do comando para definir a linha
DEFINE_COLUNA           EQU COMANDOS + 0CH   ; endereço do comando para definir a coluna
DEFINE_PIXEL            EQU COMANDOS + 12H   ; endereço do comando para escrever um pixel
APAGA_AVISO             EQU COMANDOS + 40H   ; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ              EQU COMANDOS + 02H   ; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_CENARIO_FUNDO EQU COMANDOS + 42H   ; endereço do comando para selecionar uma imagem de fundo
TOCA_SOM                EQU COMANDOS + 5AH   ; endereço do comando para tocar um som
SELECIONA_CENARIO_FONTRAL EQU COMANDOS + 46H ; endereço do comando para selecionar uma imagem de frontal
APAGA_CENARIO_FRONTAL   EQU  COMANDOS + 44H  ; endereço do comando para apagar uma imagem de frontal

; Cenários de jogo:
CENARIO_INICIO			EQU	0				; identificador do cenário do menu principal
CENARIO_JOGO			EQU	1				; identificador do cenário do fundo do durante o jogo
CENARIO_PAUSA			EQU	2				; identificador do cenário do jogo em pausa
CENARIO_FINAL			EQU	3				; identificador do cenário do final do jogo (perder o jogo)

; Sons:
SOM_TECLADO             EQU 0               ; identificador do som para começar/pause/terminar
SOM_NICE_WORK           EQU 1               ; identificador do som quando se mata um asteroide bom
SOM_EXPLOSAO            EQU 2               ; identificador do som quando se mata um asteroide mau
SOM_GAME_OVER           EQU 3               ; identificador do som de fundo quando o jogo termina

; Coordenadas do pacman:
LINHA_PACMAN            EQU 27              ; linha do pacman
COLUNA_PACMAN           EQU 27              ; coluna do pacman
COLUNA_PACMAN_DIREITA   EQU 39              ; coluna do pacmna + largura do pacman (27 + 9)

; Colunas para escolher onde os ghosts começam a cair:
COLUNA_GHOST_ESQUERDA   EQU	0               ; começa no canto esquerdo
COLUNA_GHOST_MEIO		EQU	29              ; começa no meio
COLUNA_GHOST_MEIO_D		EQU	33              ; começa no meio
COLUNA_GHOST_MEIO_E		EQU	25              ; começa no meio
COLUNA_GHOST_DIREITA    EQU	59              ; começa no canto direito

; Direções
DIRECAO_ESQUERDA        EQU -1
DIRECAO_MEIO            EQU 0
DIRECAO_DIREITA         EQU 1
DIRECAO_SONDA_ESQ       EQU -1
DIRECAO_SONDA_MEIO      EQU 0
DIRECAO_SONDA_DIR       EQU 1
    

; Coordenadas dos ghosts:		
COLUNA_ATUAL_1			EQU 0	   ; coluna atual do ghost 1 
LINHA_ATUAL_1			EQU 0	   ; linha atual do ghost 1
COLUNA_ATUAL_2			EQU 0	   ; coluna atual do ghost 2
LINHA_ATUAL_2			EQU 0	   ; linha atual do ghost 2
COLUNA_ATUAL_3			EQU 0	   ; coluna atual do ghost 3
LINHA_ATUAL_3			EQU 0	   ; linha atual do ghost 3
COLUNA_ATUAL_4			EQU 0	   ; coluna atual do ghost 4
LINHA_ATUAL_4			EQU 0	   ; linha atual do ghost 4

; Coordenadas iniciais das sondas:
LINHA_SONDA_MEIO        EQU 26     ; linha inicial da sonda do meio
COLUNA_SONDA_MEIO       EQU 31     ; coluna inicial da sonda do meio
LINHA_SONDA_DIR         EQU 26     ; linha inicial da sonda do meio
COLUNA_SONDA_DIR        EQU 37
LINHA_SONDA_ESQ         EQU 26
COLUNA_SONDA_ESQ        EQU 26

; Dimensões do pacman:
LARGURA_PACMAN          EQU 9      ; largura do pacman
ALTURA_PACMAN           EQU 5      ; altura do pacman

; Dimensões dos ghosts:
LARGURA_GHOST           EQU 5      ; largura do ghost
ALTURA_GHOST            EQU 5      ; altura do ghost

; Dimensões da sonda:
LARGURA_SONDA           EQU 1      ; largura da sonda
ALTURA_SONDA            EQU 1      ; altura da sonda

; Limites laterias do ecrã:
MIN_COLUNA              EQU 0     ; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA              EQU 63    ; número da coluna mais à direita que o objeto pode ocupar

; Limites Verticais do Ecrã:
MIN_LINHA 				EQU 0	   ; número da liknha mais acima que o objeto pode ocupar
MAX_LINHA 				EQU	31	   ; número da liknha mais abaixo que o objeto pode ocupar

FREE                    EQU 0
NOT_FREE                EQU 1


; Cores:
AZUL_GHOST              EQU 0F07DH ; cor do pixel: azul em ARGB
PRETO                   EQU 0F000H ; cor do pixel: preto em ARGB
BRANCO                  EQU 0FFFFH ; cor do pixel: branco em ARGB
VERMELHO                EQU 0FF00H ; cor do pixel: vermelho em ARGB
LARANJA                 EQU 0FF82H ; cor do pixel: laranja em ARGB
AMARELO                 EQU 0FFF5H ; cor do pixel: amarelo em ARGB
VERDE                   EQU 0F2F1H ; cor do pixel: verde em ARGB
VERDE_FLUORESCENTE      EQU 0F0F2H ; cor do pixel: verde fluoresecnte em ARGB
AZUL_CLARO              EQU 0F2EEH ; cor do pixel: azul claro em ARGB
AZUL_ESCURO             EQU 0F04FH ; cor do pixel: azul escuro em ARGB
ROXO                    EQU 0F72EH ; cor do pixel: roxo em ARGB
ROSA                    EQU 0FF2EH ; cor do pixel: rosa em ARGB
AMARELO_ESCURO          EQU 0FEB1H ; cor do pixel: amarelo escuro em ARGB

N_GHOSTS			    EQU  4	  ; número de bonecos (até 4)

TAMANHO_PILHA		    EQU 100H  ; tamanho de cada pilha, em words

ENERGIA_INICIAL         EQU 64H   ; equivalente a 100 em decimal 

ATRASO                  EQU 9999H

BOM                     EQU 0     ; identificador do tipo de ghosts bom

MAU                     EQU 1     ; identificador do tipo de ghosts mau


; Teclas para controlo do jogo:
TECLA_COMECA			EQU	0CH	  ; endereço da tecla que começca o jogo
TECLA_PAUSA				EQU	0DH	  ; endereço da tecla que pausa o jogo
TECLA_TERMINAR			EQU 0EH	  ; endereço da tecla que termina o jogo
TECLA_DISPARA_ESQUERDA  EQU 0     ; endereço da tecla que dispara a sonda para a esquerda
TECLA_DISPARA_CENTRO    EQU 1     ; endereço da tecla que dispara a sonda para o meio
TECLA_DISPARA_DIREITA   EQU 2     ; endereço da tecla que dispara a sonda para a direita

; ******************************************************************************
; * Dados
; ******************************************************************************
	PLACE       1000H
pilha:
    STACK   TAMANHO_PILHA         ; espaço reservado para a pilha
                     
SP_inicial:  

SP_teclado:						  ; Stack Pointer do Teclado
	STACK   TAMANHO_PILHA

SP_ghosts:                        ; Stack Pointer do Ghost 1
    STACK   TAMANHO_PILHA * N_GHOSTS

SP_sonda_esquerda:                ; Stack Pointer da Sonda Esquerda
    STACK   TAMANHO_PILHA

SP_sonda_centro:                  ; Stack Pointer da Sonda Centro
    STACK   TAMANHO_PILHA

SP_sonda_direita:                 ; Stack Pointer da Sonda Direita
    STACK   TAMANHO_PILHA

SP_energia:						  ; Stack Pointer da Energia
	STACK	TAMANHO_PILHA

SP_pacman:                        ; Stack Pointer do Ghosts
    STACK   TAMANHO_PILHA

                       
; Tabela das rotinas de interrupção:
tab:
	WORD rot_int_0				   ; rotina de atendimento da interrupção 0 (ghosts)
	WORD rot_int_1				   ; rotina de atendimento da interrupção 1 (sonda)
	WORD rot_int_2				   ; rotina de atendimento da interrupção 2 (energia)
    WORD rot_int_3                 ; rotina de atendimento da interrupção 3 (pacman)

evento_int:
	LOCK 0						   ; se 1, indica que a interrupção 0 ocorreu (ghosts)
	LOCK 0						   ; se 1, indica que a interrupção 1 ocorreu (sonda)
	LOCK 0						   ; se 1, indica que a interrupção 2 ocorreu (enrgia)
    LOCK 0                         ; se 1, indica que a interrupção 3 ocorreu (pacman)

tecla_carregada:
	LOCK -1				           ; tecla atualmente premida (-1 = nenhuma)

lock_tecla0:
    LOCK 0                         ; lock para a tecla de disparar a sonda para a esquerda

lock_tecla1:
    LOCK 0                         ; lock para a tecla de disparar a sonda para o centro

lock_tecla2:                       ; lock para a tecla de disparar a sonda para a direita
    LOCK 0

energia:
	WORD ENERGIA_INICIAL		   ; energia inicial (começa a 100 que se converte para 64H em base hexadecimal)

estado:
	WORD 0		                   ; estado do jogo:  0= despausado ;  1= pausado  ;  2= terminado


COLUNAS_DIREÇOES_GHOSTS:           ; estado (free ou not free), coluna inicial e direções possíveis dos ghosts
    WORD FREE, COLUNA_GHOST_ESQUERDA, DIRECAO_DIREITA
    WORD FREE, COLUNA_GHOST_DIREITA, DIRECAO_ESQUERDA
    WORD FREE, COLUNA_GHOST_MEIO, DIRECAO_MEIO
    WORD FREE, COLUNA_GHOST_MEIO_D, DIRECAO_DIREITA
    WORD FREE, COLUNA_GHOST_MEIO_E, DIRECAO_ESQUERDA


; PACMAN

DEF_PACMAN_1:            ; tabela que define o pacman(largura, altura, linha, coluna, cor pixels)
    WORD LARGURA_PACMAN
    WORD ALTURA_PACMAN
    WORD 0,VERMELHO,0,0,0,0,0,VERMELHO,0
    WORD 0,VERMELHO,VERMELHO,0,0,0,VERMELHO,VERMELHO,0
    WORD VERMELHO,VERMELHO,VERMELHO,VERMELHO,0,VERMELHO,VERMELHO,VERMELHO,VERMELHO
    WORD VERMELHO,PRETO,VERMELHO,VERMELHO,VERMELHO,VERMELHO,VERMELHO,VERMELHO,VERMELHO
    WORD VERMELHO,PRETO,PRETO,VERMELHO,VERMELHO,VERMELHO,VERMELHO,VERMELHO,VERMELHO

DEF_PACMAN_2:            ; tabela que define o pacman(largura, altura, linha, coluna, cor pixels)
    WORD LARGURA_PACMAN
    WORD ALTURA_PACMAN
    WORD 0,LARANJA,0,0,0,0,0,LARANJA,0
    WORD 0,LARANJA,LARANJA,0,0,0,LARANJA,LARANJA,0
    WORD LARANJA,LARANJA,LARANJA,LARANJA,0,LARANJA,LARANJA,LARANJA,LARANJA
    WORD LARANJA,PRETO,LARANJA,LARANJA,LARANJA,LARANJA,LARANJA,LARANJA,LARANJA
    WORD LARANJA,PRETO,PRETO,LARANJA,LARANJA,LARANJA,LARANJA,LARANJA,LARANJA

DEF_PACMAN_3:            ; tabela que define o pacman(largura, altura, linha, coluna, cor pixels)
    WORD LARGURA_PACMAN
    WORD ALTURA_PACMAN
    WORD 0,AMARELO,0,0,0,0,0,AMARELO,0
    WORD 0,AMARELO,AMARELO,0,0,0,AMARELO,AMARELO,0
    WORD AMARELO,AMARELO,AMARELO,AMARELO,0,AMARELO,AMARELO,AMARELO,AMARELO
    WORD AMARELO,PRETO,AMARELO,AMARELO,AMARELO,AMARELO,AMARELO,AMARELO,AMARELO
    WORD AMARELO,PRETO,PRETO,AMARELO,AMARELO,AMARELO,AMARELO,AMARELO,AMARELO

DEF_PACMAN_4:            ; tabela que define o pacman(largura, altura, linha, coluna, cor pixels)
    WORD LARGURA_PACMAN
    WORD ALTURA_PACMAN
    WORD 0,VERDE,0,0,0,0,0,VERDE,0
    WORD 0,VERDE,VERDE,0,0,0,VERDE,VERDE,0
    WORD VERDE,VERDE,VERDE,VERDE,0,VERDE,VERDE,VERDE,VERDE
    WORD VERDE,PRETO,VERDE,VERDE,VERDE,VERDE,VERDE,VERDE,VERDE
    WORD VERDE,PRETO,PRETO,VERDE,VERDE,VERDE,VERDE,VERDE,VERDE

DEF_PACMAN_5:            ; tabela que define o pacman(largura, altura, linha, coluna, cor pixels)
    WORD LARGURA_PACMAN
    WORD ALTURA_PACMAN
    WORD 0,AZUL_CLARO,0,0,0,0,0,AZUL_CLARO,0
    WORD 0,AZUL_CLARO,AZUL_CLARO,0,0,0,AZUL_CLARO,AZUL_CLARO,0
    WORD AZUL_CLARO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO,0,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO
    WORD AZUL_CLARO,PRETO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO
    WORD AZUL_CLARO,PRETO,PRETO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO,AZUL_CLARO

DEF_PACMAN_6:            ; tabela que define o pacman(largura, altura, linha, coluna, cor pixels)
    WORD LARGURA_PACMAN
    WORD ALTURA_PACMAN
    WORD 0,AZUL_ESCURO,0,0,0,0,0,AZUL_ESCURO,0
    WORD 0,AZUL_ESCURO,AZUL_ESCURO,0,0,0,AZUL_ESCURO,AZUL_ESCURO,0
    WORD AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO,0,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO
    WORD AZUL_ESCURO,PRETO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO
    WORD AZUL_ESCURO,PRETO,PRETO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO,AZUL_ESCURO

DEF_PACMAN_7:            ; tabela que define o pacman(largura, altura, linha, coluna, cor pixels)
    WORD LARGURA_PACMAN
    WORD ALTURA_PACMAN
    WORD 0,ROXO,0,0,0,0,0,ROXO,0
    WORD 0,ROXO,ROXO,0,0,0,ROXO,ROXO,0
    WORD ROXO,ROXO,ROXO,ROXO,0,ROXO,ROXO,ROXO,ROXO
    WORD ROXO,PRETO,ROXO,ROXO,ROXO,ROXO,ROXO,ROXO,ROXO
    WORD ROXO,PRETO,PRETO,ROXO,ROXO,ROXO,ROXO,ROXO,ROXO

DEF_PACMAN_8:            ; tabela que define o pacman(largura, altura, linha, coluna, cor pixels)
    WORD LARGURA_PACMAN
    WORD ALTURA_PACMAN
    WORD 0,ROSA,0,0,0,0,0,ROSA,0
    WORD 0,ROSA,ROSA,0,0,0,ROSA,ROSA,0
    WORD ROSA,ROSA,ROSA,ROSA,0,ROSA,ROSA,ROSA,ROSA
    WORD ROSA,PRETO,ROSA,ROSA,ROSA,ROSA,ROSA,ROSA,ROSA
    WORD ROSA,PRETO,PRETO,ROSA,ROSA,ROSA,ROSA,ROSA,ROSA

posicao_pacman:        ; tabela que define a posição do pacman
    WORD LINHA_PACMAN
    WORD COLUNA_PACMAN

; SONDA:
DEF_SONDA:             ; tabela que define a sonda(largura, altura, cor pixels)
    WORD LARGURA_SONDA
    WORD ALTURA_SONDA
    WORD VERDE

coord_atuais_sondas:   ; tabela que mantem as coordenadas atuais das sondas
    WORD LINHA_ATUAL_1, COLUNA_ATUAL_2
    WORD LINHA_ATUAL_2, COLUNA_ATUAL_2
    WORD LINHA_ATUAL_3, COLUNA_ATUAL_3

; tabela que guarda as coordenadas iniciais e a direção das sondas
posicao_sonda_esq:       
    WORD LINHA_SONDA_ESQ, COLUNA_SONDA_ESQ, DIRECAO_SONDA_ESQ
posicao_sonda_centro:
    WORD LINHA_SONDA_MEIO, COLUNA_SONDA_MEIO, DIRECAO_SONDA_MEIO
posicao_sonda_dir:
    WORD LINHA_SONDA_DIR, COLUNA_SONDA_DIR, DIRECAO_SONDA_DIR


; GHOSTS:
DEF_GHOST_MAU:         ; tabela que define o ghost mau(largura, altura, cor pixels)
    WORD LARGURA_GHOST
    WORD ALTURA_GHOST
    WORD 0, VERMELHO, VERMELHO, VERMELHO, 0
    WORD VERMELHO, PRETO, VERMELHO, PRETO, VERMELHO
    WORD VERMELHO, VERMELHO, VERMELHO, VERMELHO, VERMELHO
    WORD VERMELHO, VERMELHO, VERMELHO, VERMELHO, VERMELHO
    WORD VERMELHO, 0, VERMELHO, 0, VERMELHO
    WORD MAU

DEF_GHOST_BOM:             ; tabela que define o ghost(largura, altura, linha, coluna, cor pixels)
    WORD LARGURA_GHOST
    WORD ALTURA_GHOST
    WORD 0, AZUL_GHOST, AZUL_GHOST, AZUL_GHOST, 0
    WORD AZUL_GHOST, PRETO, AZUL_GHOST, PRETO, AZUL_GHOST
    WORD AZUL_GHOST,AZUL_GHOST,AZUL_GHOST,AZUL_GHOST,AZUL_GHOST
    WORD AZUL_GHOST, AZUL_GHOST, AZUL_GHOST, AZUL_GHOST, AZUL_GHOST
    WORD AZUL_GHOST, 0, AZUL_GHOST, 0, AZUL_GHOST
    WORD BOM

DEF_GHOST_MAU_EXPLOSAO:             ; tabela que define o ghost(largura, altura, linha, coluna, cor pixels)
    WORD LARGURA_GHOST
    WORD ALTURA_GHOST

    WORD 0, BRANCO, BRANCO, BRANCO, 0
    WORD BRANCO, PRETO, BRANCO, PRETO, BRANCO
    WORD BRANCO,BRANCO,BRANCO,BRANCO,BRANCO
    WORD BRANCO, BRANCO, BRANCO, BRANCO, BRANCO
    WORD BRANCO, 0, BRANCO, 0, BRANCO

DEF_GHOST_BOM_EXPLOSAO:
    WORD LARGURA_GHOST
    WORD ALTURA_GHOST

    WORD 0, AMARELO, AMARELO, AMARELO, 0
    WORD AMARELO, AMARELO_ESCURO, AMARELO_ESCURO, AMARELO_ESCURO, AMARELO
    WORD AMARELO_ESCURO, AMARELO, AMARELO_ESCURO, AMARELO_ESCURO, AMARELO_ESCURO
    WORD AMARELO, AMARELO_ESCURO, AMARELO_ESCURO, AMARELO_ESCURO, AMARELO
    WORD 0, AMARELO, AMARELO, AMARELO, 0

DEF_GHOST_BOM_EXPLOSAO_2:
    WORD LARGURA_GHOST
    WORD ALTURA_GHOST
    WORD 0, 0, 0, 0, 0
    WORD 0, AMARELO, AMARELO, AMARELO, 0
    WORD 0, AMARELO, AMARELO_ESCURO, AMARELO, 0
    WORD 0, AMARELO, AMARELO, AMARELO, 0
    WORD 0, 0, 0, 0, 0

DEF_GHOST_BOM_EXPLOSAO_3:
    WORD LARGURA_GHOST
    WORD ALTURA_GHOST
    WORD 0, 0, 0, 0, 0
    WORD 0, 0, 0, 0, 0
    WORD 0, AMARELO, 0
    WORD 0, 0, 0, 0, 0
    WORD 0, 0, 0, 0, 0

; ******************************************************************************
; * Código
; ******************************************************************************
    PLACE   0

inicio: 
    MOV  SP, SP_inicial                 ; inicializa o SP

    MOV  BTE, tab
    MOV  [APAGA_AVISO], R1              ; apaga o aviso de nenhum cenário selecionado 
    MOV  [APAGA_ECRÃ], R1               ; apaga todos os pixels já desenhados 
    MOV  R1, CENARIO_INICIO				; cenário do inicial do jogo
    MOV	 [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo (cenario inicial)
    MOV  R2, ENERGIA_INICIAL            ; MOV R1, 64H 
    CALL converte_p_decimal
	MOV	 [DISPLAYS], R2				    ; mete no display a energia inicial em base decimal
    EI0   
    EI1
    EI2
    EI3
    CALL teclado

    MOV R1, estado
    MOV R0, 0
    MOV [R1], R0
    MOV	R11, N_GHOSTS		; número de bonecos a usar (até 4)
loop_ghost1:
    MOV R1, estado
    MOV R0, 0
    MOV [R1], R0
	
    SUB	R11, 1			    ; próximo boneco
	CALL	ghost			; cria uma nova instância do processo boneco (o valor de R11 distingue-as)
						    ; Cada processo fica com uma cópia independente dos registos
	CMP  R11, 0			    ; já criou as instâncias todas?
     JNZ	loop_ghost1		; se não, continua

espera_start:
    MOV  R0, [tecla_carregada]         ; obtem tecla carregada
    MOV  R1, TECLA_COMECA           
    CMP  R0, R1                        ; vê se a tecla carregada foi a tecla de começar
    JNZ  espera_start                  ; repetir até a a tecla de começar ser carregada
    MOV	 R7, 0			               ; som com número de tecla
	MOV  [TOCA_SOM], R7		           ; comando para tocar o som

jogo_começou:
    MOV  R1, CENARIO_JOGO              ; obtem o endereço do ceário de jogo
    MOV  [SELECIONA_CENARIO_FUNDO], R1 ; coloca o cenário de jogo no media center
    CALL processo_energia              ; cria o processo da energia
    CALL pacman                        ; cria o processo do pacman
    CALL sonda_esquerda                ; cria o processo da sonda esquerda
    CALL sonda_centro                  ; cria o processo da sonda central
    CALL sonda_direita                 ; cria o processo da sonda direita
    EI                                 ; permite interrupções


espera_tecla:
    MOV  R0, [tecla_carregada] 

testa_dispara_esquerdo:
    MOV  R7, TECLA_DISPARA_ESQUERDA     ; obtém o endereço da tecla de disparar para a esquerda
    CMP	 R0, R7							; verifica se foi premida
    JNZ  testa_dispara_centro           ; se não foi verifica a próxima tecla
    MOV  [lock_tecla0], R4              ; bloqueia neste lock
 

testa_dispara_centro:
    MOV  R7, TECLA_DISPARA_CENTRO       ; obtém o endereço da tecla de disparar no centro
    CMP	 R0, R7							; verifica se foi premida
    JNZ  testa_dispara_direita          ; se não foi verifica a próxima tecla
    MOV  [lock_tecla1], R4              ; bloqueia neste lock
  

testa_dispara_direita:  
    MOV  R7, TECLA_DISPARA_DIREITA      ; obtém o endereço da tecla de disparar para a direita
    CMP	 R0, R7							; verifica se foi premida       
    JNZ  testa_termina_jogo             ; se não foi verifica a próxima tecla
    MOV  [lock_tecla2], R4              ; bloqueia neste lock

testa_termina_jogo:
    MOV  R7, TECLA_TERMINAR             ; obtém o endereço da tecla de terminar o jogo
    CMP  R0, R7                         ; verifica se foi premida
    JNZ  testa_pausa                    ; se não foi verifica a próxima tecla
    CALL termina_jogo                   ; chama a rotina para terminar o jogo


testa_pausa:										
	MOV	 R7, TECLA_PAUSA				; obtém o endereço da tecla de pausar o jogo
	CMP	 R0, R7							; verifica se foi premida
	JNZ	 espera_tecla					; se não foi, espera até uma tecla ser premida
    MOV	 R7, 0			                ; som com número de tecla
	MOV  [TOCA_SOM], R7		           ; comando para tocar o som
	CALL pausa_despausa					 ; chama a rotina para pausa/despausa o jogo
	JMP	 espera_tecla					; espera outra tecla ser premida


; ******************************************************************************
; ****************************** PROCESSOS *************************************	
; ******************************************************************************

; ******************************************************************************
; Processo teclado - Lê o teclado continuamente e guarda a tecla 
;					premida na memória.
; ******************************************************************************

PROCESS		SP_teclado

teclado:
	YIELD
	MOV	 R2, TEC_LIN   					 ; endereço do periférico das linhas
	MOV	 R3, TEC_COL   					 ; endereço do periférico das colunas
	MOV	 R5, MASCARA   					 ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
	MOV	 R6, LINHA_TEST                  ; começa na linha 8 (16/2)
loop_teclado:
	SHR	 R6, 1                           ; 16/2 = 8 (primeira linha a testar)
	JZ	 nenhuma						 ; se chegar ao fim do loop e nenhuma tecla for premida
	MOVB [R2], R6      					 ; a linha a ler passa a ser a do registo R6
	MOVB R0, [R3]      					 ; ler do periférico de entrada (colunas)
	
	AND	 R0, R5        					 ; elimina bits para além dos bits 0-3
	JNZ	 converte_tec_hexa				 ; se alguma tecla for premida quebra o loop
	JMP	 loop_teclado
nenhuma:
	MOV	 R0, -1							 ; quando nenhuma tecla está selecionada mete R0 a -1
	JMP	 skip
converte_tec_hexa:
	MOV	 R7, 0                           ; contador inicia a zero
n_linha:              				     ; transforma linhas de 1,2,4,8 para 0,1,2,3
   	SHR	 R6, 1
   	JZ	 nova_linha
   	ADD	 R7, 1
   	JMP	 n_linha
nova_linha:
   	MOV	 R6, R7							 ; atualiza linha
   	MOV	 R7, 0							 ; reset contador
n_coluna:								 ; transforma colunas de 1,2,4,8 para 0,1,2,3
    SHR	 R0, 1
    JZ	 nova_coluna
    ADD	 R7, 1
    JMP	 n_coluna
nova_coluna:
   	MOV	 R0, R7							 ; atualiza coluna
   	MOV	 R7, 4                           
   	MUL	 R6, R7
	ADD	 R0, R6							 ; Tecla = 4 * linha + coluna
skip:
	MOV	 [tecla_carregada], R0
	JMP	 teclado


; ******************************************************************************
; Processo Ghosts
; ******************************************************************************


PROCESS SP_ghosts
 
ghost:

    MOV	R1, TAMANHO_PILHA	           ; tamanho em palavras da pilha de cada processo
	MUL	R1, R11				           ; TAMANHO_PILHA vezes o nº da instância do "boneco"
	SUB	SP, R1		     	           ; inicializa SP deste "boneco" (antes de subtrair já tinha sido inicializado com SP_inicial_boneco)
							           ; A instância 0 fica na mesma, e as seguintes vão andando para trás,
							           ; até esgotar todo o espaço de pilha reservado para os processos "boneco"

rotina_ghost:
    MOV  R0, evento_int                ; espera pela interrupção
    MOV  R9, [R0]

    MOV  R5, [estado]                  ; obtem o estado atual do jogo
    MOV  R6, 1
    CMP  R5, R6                        ; vê se está pausado (estado = 1)
    JZ   rotina_ghost                  ; se estiver, volta ao inicio e não realiza o resto do processo

    CMP  R5, 2                         ; ver se está terminado
    JZ   ret_ghost  

    
ciclo_random:
    CALL gera_random                   ; gera dois números aleatóreos
    MOV  R9, 6                         ; tamanho de cada elemento da tabela é dois words (3 WORDS)
    MUL  R11, R9                       ; obter entrada da tabela com as posições possíveis dos ghosts 
    MOV  R0, COLUNAS_DIREÇOES_GHOSTS   ; obter a tabela com as 5 possíveis posições
    MOV  R4, [R0 + R11]                ; obter o estado atual (free ou not_free) da posição gerada
    CMP  R4, FREE                      ; se a posição já estiver ocupada, repete-se o ciclo e
    JNZ  ciclo_random                  ; voltam-se a gerar os números aleatóreos
    MOV  R4, NOT_FREE                  ; se a posição está livre, mudamos alteramos o seu estado 
    MOV  [R0 + R11], R4                ; gravamos na tabela o estado da posição respetiva
    MOV  R8, R0                        ; obtemos a tabela com as possíveis posições
    ADD  R8, 2                         ; aceder á próxima WORD da tebela
    MOV  R2, [R8 + R11]                ; obtemos a coluna do qual o ghost irá surgir 
    ADD  R8, 2                         ; aceder à próxima WORD da tabela                               
    MOV  R3, [R8 + R11]                ; obter direção do ghost (-1, 0 ou 1)

    MOV  R1, 0                         ; linha inical dos ghosts em qualquer posição
    CMP  R7, 0                         ; se o numero aleatorio for zero, será um ghost minerável (25% chance)
    JNZ  eh_inimigo 

eh_mineravel:
    MOV  R4, DEF_GHOST_BOM             ; obtem a tabela que define o ghost minerável (bom)
    CALL desenha_objeto                ; desenha o primeiro ghost
    JMP  loop_desce_ghost 

eh_inimigo:                             ; se o número aleatório for 1,2 ou 3 será inimigo (75% chance)
    MOV  R4, DEF_GHOST_MAU              ; obtem a tabela que define o ghost inimigo (mau)
    CALL desenha_objeto                 ; desenha o primeiro ghost
    JMP  loop_desce_ghost

loop_desce_ghost:
    MOV  R5, [evento_int]               ; espera pela interrupção

    MOV  R5, [estado]                   ; obtem o estado atual do jogo
    MOV  R6, 0
    CMP  R5, R6                         ; vê se está despausado (estado = 0)
    JNZ  rotina_ghost                   ; se não estiver, volta ao inicio e não realiza o resto do processo
    CALL desce_ghost                    ; chama a rotina para mover o ghost
    
    CALL ve_limites                     ; verifica se o ghost ainda está dentro dos limites do ecrã
    CMP  R10, 0                         ; se R10 tiver o valor 0, então está fora dos limites
    JZ   apaga_ultimo_ghost             ; se passa os limites, paramos de desenhar o ghost
    
    CALL ve_colisao_pacman              ; vê se o ghost atingiu o pacman
    CMP  R10, 0                         ; se R10 tiver o valor 0, então colidiu
    JZ   call_termina_jogo              ; se colidiu, acaba o jogo

    CALL ve_colisao_sonda_esq
    CMP  R10, 0
    JZ   ha_colisao

    CALL ve_colisao_sonda_centro
    CMP  R10, 0
    JZ   ha_colisao

    CALL ve_colisao_sonda_dir
    CMP  R10, 0
    JZ   ha_colisao

    JMP  loop_desce_ghost               ; volta a repetir loop enquanto está dentro dos limites

apaga_ultimo_ghost:
    CALL apaga_objeto                   
    MOV  R9, FREE                       ; muda estado da posição para FREE mno fim do ciclo
    MOV  [R0 + R11], R9                 ; gravamos o estado atual da tabela
    JMP  rotina_ghost                   

ha_colisao:
    CALL trata_colisao
    JMP  apaga_ultimo_ghost

call_termina_jogo:
    CALL  termina_jogo


ret_ghost:
    RET

; ******************************************************************************
; Processo Sonda Esquerda
; ******************************************************************************

PROCESS SP_sonda_esquerda

sonda_esquerda:
   MOV   R5, [lock_tecla0]           ; lê o lock desta tecla

   MOV	 R5, [estado]                ; obtem o estado atual do jogo
   MOV	 R6, 1                      
   CMP	 R5, R6                      ; vê se o jogo está pausado (estado=1)
   JZ	 sonda_esquerda              ; se estiver , não dispara a sonda

   CMP  R5, 2                         ; ver se está terminado
   JZ   ret_sonda_esquerda

   MOV   R10, -5                      ; retirar 5 pontos ao display de energia
   CALL   muda_energia

obtem_coordenadas_esq:
   MOV   R1, [posicao_sonda_esq]     ; obtem linha inicial da sonda esquerda
   MOV   R2, [posicao_sonda_esq + 2] ; obtem coluna inicial da sonda esquerda
   MOV   R3, [posicao_sonda_esq + 4] ; obtem direção da sonda esquerda
   MOV   R7, 12                      ; inicializa o contador a doze (apenas doze deslocamentos da sonda)

loop_sonda_esquerda:
   MOV	 R5, evento_int              ; obtem tabela de interrupções
   MOV	 R6, [R5 + 2]				 ; esperar pela interrupção

movimento_sonda_esq:
   MOV   R8, coord_atuais_sondas     ; obter a tabela que guarda as coordenadas atuais
   MOV   [R8], R1                    ; guardar na tabela a linha atual da sonda esquerda
   MOV   [R8 + 2], R2                ; guardar na tabela a coluna atual da sonda esquerda
   CALL  sobe_sonda                  ; chama a rotina para mover a sonda
   SUB   R7, 1                       ; decrementa o contador
   JZ    apaga_ultimo_pixel_esq      ; se já tiver feito todos os deslocamnetos, apaga o ultimo pixel
   JMP   loop_sonda_esquerda         ; se ainda não acabou, continua o movimento
   
apaga_ultimo_pixel_esq:
    MOV  R6, 0
    MOV  [R8], R6                    ; coloca a linha inicial a zero
    MOV  [R8 + 2], R6                ; coloca a coluna inicial a zero
    MOV  R4, DEF_SONDA               ; obter a tabela que define a sonda
    CALL apaga_objeto                ; apaga a última sonda
    JMP  sonda_esquerda              ; volta ao inicio do ciclo

ret_sonda_esquerda:
    RET

; ******************************************************************************
; Processo Sonda Centro
; ******************************************************************************

PROCESS SP_sonda_centro
   
sonda_centro:
   MOV   R5, [lock_tecla1]               ; lê o lock desta tecla

   MOV	 R5, [estado]                    ; obtem o estado atual do jogo
   MOV	 R6, 1                      
   CMP	 R5, R6                          ; vê se o jogo está pausado (estado=1)
   JZ	 sonda_centro                    ; se estiver, não dispara a sonda

   CMP  R5, 2                         ; ver se está terminado
   JZ   ret_sonda_centro

   MOV   R10, -5                          ; retirar 5 pontos ao display de energia
   CALL  muda_energia

obtem_coordenadas_centro:
   MOV   R1, [posicao_sonda_centro]      ; obtem linha inicial da sonda central       
   MOV   R2, [posicao_sonda_centro + 2]  ; obtem coluna inicial da sonda central
   MOV   R3, [posicao_sonda_centro + 4]  ; obtem direção da sonda central
   MOV   R7, 12                          ; inicializa o contador a doze (apenas doze deslocamentos da sonda)

loop_sonda_centro:
   MOV	 R5, evento_int                  ; obtem tabela de interrupções
   MOV	 R6, [R5 + 2]				     ; esperar pela interrupção

movimento_sonda_centro:
   MOV   R8, coord_atuais_sondas         ; obter a tabela que guarda as coordenadas atuais
   MOV   [R8 + 4], R1                    ; guardar na tabela a linha atual da sonda centro
   MOV   [R8 + 6], R2                    ; guardar na tabela a coluna atual da sonda centro
   CALL  sobe_sonda                      ; chama a rotina para mover a sonda
   SUB   R7, 1                           ; decrementa o contador
   JZ    apaga_ultimo_pixel_centro       ; se já tiver feito todos os deslocamnetos, apaga o ultimo pixel
   JMP   loop_sonda_centro               ; se ainda não acabou, continua o movimento

apaga_ultimo_pixel_centro:
    MOV  R6, 0
    MOV  [R8 + 4], R6                    ; coloca a linha inicial a zero
    MOV  [R8 + 6], R6                    ; coloca a coluna atual a zero
    MOV  R4, DEF_SONDA                   ; obter tabela que define sonda
    CALL apaga_objeto                    ; apaga a última sonda
    JMP  sonda_centro                    ; volta ao inicio do ciclo

ret_sonda_centro:
    RET

; ******************************************************************************
; Processo Sonda Direita
; ******************************************************************************

PROCESS SP_sonda_direita

sonda_direita:
   MOV   R5, [lock_tecla2]           ; lê o lock desta tecla

   MOV	 R5, [estado]                ; obtem o estado atual do jogo
   MOV	 R6, 1                      
   CMP	 R5, R6                      ; vê se o jogo está pausado (estado=1)
   JZ	 sonda_direita               ; es estiver, não dispara a sonda

   CMP  R5, 2                         ; ver se está terminado
    JZ   ret_sonda_direita
   
   MOV   R10, -5                       ; retirar 5 pontos ao display de energia
   CALL  muda_energia        

obtem_coordenadas_dir:
   MOV   R1, [posicao_sonda_dir]      ; obtem linha inicial da sonda direita
   MOV   R2, [posicao_sonda_dir + 2]  ; obtem coluna inicial da sonda direita
   MOV   R3, [posicao_sonda_dir + 4]  ; obtem direção da sonda direita
   MOV   R7, 12                       ; inicializa o contador a doze (apenas doze deslocamentos da sonda)

loop_sonda_direita:
   MOV	 R5, evento_int              ; obtem tabela de interrupções
   MOV	 R6, [R5 + 2]				 ; esperar pela interrupção

movimento_sonda_dir:
   MOV   R8, coord_atuais_sondas     ; obter a tabela que guarda as coordenadas atuais
   MOV   R9, 8
   MOV   [R8 + R9], R1               ; guardar na tabela a linha atual da sonda direita
   MOV   R11, 10
   MOV   [R8 + R11], R2              ; guardar na tabela a coluna atual da sonda direita
   CALL  sobe_sonda                  ; chama a rotina para mover a sonda
   SUB   R7, 1                       ; decrementa o contador
   JZ    apaga_ultimo_pixel_dir      ; se já tiver feito todos os deslocamentos, apaga o ultimo pixel
   JMP   loop_sonda_direita          ; se ainda não acabou, continua o movimento

apaga_ultimo_pixel_dir:
    MOV  R6, 0
    MOV  [R8 + R9], R6               ; coloca a linha inicial a zero
    MOV  [R8 + R11], R6              ; coloca a coluna inicial a zero
    MOV  R4, DEF_SONDA               ; obter tabela que define a sonda
    CALL apaga_objeto                ; apaga a última sonda
    JMP  sonda_direita               ; volta ao inicio do ciclo

ret_sonda_direita:
    RET

; ******************************************************************************
; Processo Energia 
; ******************************************************************************

PROCESS SP_energia

processo_energia:
    MOV  R0, evento_int              ; obtem tabela de interrupções
    MOV  R1, [R0 + 4]                ; esperar pela interrupçã

    MOV  R2, [estado]                ; obtem estado atual do jogo
    CMP  R2, 1                       ; vê se está pausado 
    JZ  processo_energia            ; se estiver repete o ciclo (não há mudança de energia)

    CMP  R2, 2                         ; ver se está terminado
    JZ   ret_processo_energia

    MOV  R10, -3 
    CALL muda_energia
    MOV  R3, [energia]               ; obtem energia atual
    CMP  R3, 0                       ; vê se a energia está a zero
    JNZ  processo_energia            ; se não a zero está repete o ciclo
    CALL termina_jogo                ; se está a zero termina o jogo

espera_start_energia:
    CMP  R5, 0
    JNZ  espera_start_energia
    JMP  processo_energia

ret_processo_energia:
    RET

; ******************************************************************************
; Processo Pacman
; ******************************************************************************

PROCESS SP_pacman

pacman:
    MOV  R0, evento_int
    MOV  R3, [R0 + 6]

    MOV  R0, [estado]                  ; obtem estado atual do jogo
    CMP  R0, 1                         ; vê se está pausado 
    JZ  pacman                        ; se estiver repete o ciclo

    CMP  R0, 2                         ; ver se está terminado
    JZ   ret_pacman

    MOV  R1, [posicao_pacman]          ; obtem linha do pacman
    MOV  R2, [posicao_pacman + 2]      ; obtem coluna do pacman
    MOV  R4, DEF_PACMAN_1              ; obtem a tabela com as caracteristicas do pacman na cor 1
    CALL desenha_objeto                ; desenha o pacman na cor 1
    
    MOV  R0, evento_int
    MOV  R3, [R0 + 6]
    MOV  R4, DEF_PACMAN_2              ; obtem a tabela com as caracteristicas do pacman na cor 2
    CALL desenha_objeto                ; desenha o pacman na cor 2
    
    MOV  R0, evento_int
    MOV  R3, [R0 + 6]
    MOV  R4, DEF_PACMAN_3              ; obtem a tabela com as caracteristicas do pacman na cor 3
    CALL desenha_objeto                ; desenha o pacman na cor 3

    MOV  R0, evento_int
    MOV  R3, [R0 + 6]
    MOV  R4, DEF_PACMAN_4              ; obtem a tabela com as caracteristicas do pacman na cor 4
    CALL desenha_objeto                ; desenha o pacman na cor 4

    MOV  R0, evento_int
    MOV  R3, [R0 + 6]
    MOV  R4, DEF_PACMAN_5              ; obtem a tabela com as caracteristicas do pacman na cor 5
    CALL desenha_objeto                ; desenha o pacman na cor 5

    MOV  R0, evento_int
    MOV  R3, [R0 + 6]
    MOV  R4, DEF_PACMAN_6              ; obtem a tabela com as caracteristicas do pacman na cor 6
    CALL desenha_objeto                ; desenha o pacman na cor 6

    MOV  R0, evento_int
    MOV  R3, [R0 + 6]
    MOV  R4, DEF_PACMAN_7              ; obtem a tabela com as caracteristicas do pacman na cor 7
    CALL desenha_objeto                ; desenha o pacman na cor 7

    MOV  R0, evento_int
    MOV  R3, [R0 + 6]
    MOV  R4, DEF_PACMAN_8              ; obtem a tabela com as caracteristicas do pacman na cor 8
    CALL desenha_objeto                ; desenha o pacman na cor 8

    JMP  pacman                        ; repete o ciclo

ret_pacman:
    RET


; ******************************************************************************
; ******************************* ROTINAS **************************************
; ******************************************************************************

;*******************************************************************************
; TRATA_COLISÃO - se a colisao foi entre sonda e ghost minerável adiciona
;                 energia, se foi entre sonda e ghost inimigo, mata-o
;
; Argumentos - R1 - linha ghost
;              R2 - coluna ghost
;              R4 - tabela que define o ghost
;
;*******************************************************************************
trata_colisao:
    PUSH R1
    PUSH R2
    PUSH R4
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R8
    PUSH R10

    MOV  R5, 54
    MOV  R10, 25
    MOV  R6, BOM
    MOV  R7, [R4 + R5]   ; [R4 + R5] corresponde à WORD ONDE está guradado o tipo do ghost
    CMP  R6 , R7         ; foi atingido um ghost minerável?
    JZ   call_muda_energia
    MOV  R7, 2
    MOV  [TOCA_SOM], R7
    CALL apaga_objeto
    MOV  R4, DEF_GHOST_MAU_EXPLOSAO
    CALL desenha_objeto
    CALL atraso
    CALL atraso
    JMP  fim_trata_colisao 

call_muda_energia:
    MOV  R7, 1
    MOV  [TOCA_SOM], R7
    CALL muda_energia
    CALL apaga_objeto
    MOV  R8, [evento_int]
    MOV  R4, DEF_GHOST_BOM_EXPLOSAO
    CALL desenha_objeto

    MOV  R8, [evento_int]
    CALL apaga_objeto
    MOV  R4, DEF_GHOST_BOM_EXPLOSAO_2
    CALL desenha_objeto

    MOV  R8, [evento_int]
    CALL apaga_objeto
    MOV  R4, DEF_GHOST_BOM_EXPLOSAO_3
    CALL desenha_objeto
    
    JMP  fim_trata_colisao

fim_trata_colisao:
    POP  R10
    POP  R8
    POP  R7
    POP  R6
    POP  R5
    POP  R4
    POP  R2
    POP  R1
    RET

;*******************************************************************************
; ATRASO - Executa um ciclo para implementar um atraso.
; Argumentos:   R11 - valor que define o atraso
;
; ******************************************************************************
atraso:
    PUSH    R11
    MOV     R11, ATRASO

ciclo_atraso:                  ; ciclo corre 500H vezes para causar um atraso no programa
    SUB        R11, 1
    JNZ        ciclo_atraso
    POP        R11
    RET


;*******************************************************************************
; VÊ_COLISÃO_SONDA_ESQ -  vê se a sonda esquerda colidiu com o ghost
;  
; Argumentos:  R1 - linha do ghost
;              R2 - coluna do ghost
;
; Retorna:     R10 - valor 1 se não colidiu e 0 se colidiu
;
;*******************************************************************************
ve_colisao_sonda_esq:
    PUSH R0
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R9

    MOV  R0, coord_atuais_sondas   ; obtem tabela que guarda as posições atuais da sonda
    MOV  R5, [R0]                  ; obtem linha da sonda esquerda
    MOV  R6, [R0 + 2]              ; obtem coluna da sonda esquerda

    CMP  R5, R1                    ; compara a linha da sonda com a linha superior do ghosts
    JLT  nao_colidiu_esq           ; se a linha da sonda for menor não colidiu
    MOV  R7, R1                    
    ADD  R7, 4                     ; obter a linha inferior do ghost
    CMP  R5, R7                    ; compara as linhas da sonda e do ghost
    JGT  nao_colidiu_esq           ; se a linha da sonda for maior não colidiu
    CMP  R6, R2                    ; compara a coluna da sonda com a coluna esquerda do ghost
    JLT  nao_colidiu_esq           ; se for menor nao colidiu

    MOV  R9, R2
    ADD  R9, 4                     ; obter coluna direita do ghost
    CMP  R6, R9                    ; compara a coluna da sonda com a coluna direita do ghost
    JGT  nao_colidiu_esq
    JMP  colidiu_esq               ; se tem todas as condições necessárias, houove colisão

colidiu_esq:
    MOV  R10, 0                    
    JMP  fim_ve_colisao_sonda_esq

nao_colidiu_esq:
    MOV  R10, 1
    JMP  fim_ve_colisao_sonda_esq

fim_ve_colisao_sonda_esq:
    POP  R9
    POP  R7
    POP  R6
    POP  R5
    POP  R0
    RET

;*******************************************************************************
; VÊ_COLISÃO_SONDA_CENTRO -  vê se a sonda central colidiu com o ghost
;  
; Argumentos:  R1 - linha do ghost
;              R2 - coluna do ghost
;
; Retorna:     R10 - valor 1 se não colidiu e 0 se colidiu
;
;*******************************************************************************
ve_colisao_sonda_centro:
    PUSH R0
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R9

    MOV  R0, coord_atuais_sondas       ; obtem tabela que guarda as posições atuais da sonda
    MOV  R5, [R0 + 4]                  ; obtem linha da sonda esquerda
    MOV  R6, [R0 + 6]                  ; obtem coluna da sonda esquerda

    CMP  R5, R1                    ; compara a linha da sonda com a linha superior do ghosts
    JLT  nao_colidiu_centro           ; se a linha da sonda for menor não colidiu
    MOV  R7, R1
    ADD  R7, 4                         ; obter a linha inferior do ghost
    CMP  R5, R7                        ; compara as linhas da sonda e do ghost
    JGT  nao_colidiu_centro            ; se a linha da sonda for menor não colidiu
    CMP  R6, R2                        ; compara a coluna da sonda com a coluna esquerda do ghost
    JLT  nao_colidiu_centro            ; se for menor nao colidiu

    MOV  R9, R2
    ADD  R9, 4                         ; obter coluna direita do ghost
    CMP  R6, R9                        ; compara a coluna da sonda com a coluna direita do ghost
    JGT  nao_colidiu_centro
    JMP  colidiu_centro                ; se tem todas as condições necessárias, houove colisão

colidiu_centro:
    MOV  R10, 0
    JMP  fim_ve_colisao_sonda_centro

nao_colidiu_centro:
    MOV  R10, 1
    JMP  fim_ve_colisao_sonda_centro

fim_ve_colisao_sonda_centro:
    POP  R9
    POP  R7
    POP  R6
    POP  R5
    POP  R0
    RET


;*******************************************************************************
; VÊ_COLISÃO_SONDA_DIR -  vê se a sonda direita colidiu com o ghost
;  
; Argumentos:  R1 - linha do ghost
;              R2 - coluna do ghost
;
; Retorna:     R10 - valor 1 se não colidiu e 0 se colidiu
;
;*******************************************************************************
ve_colisao_sonda_dir:
    PUSH R0
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R8
    PUSH R9

    MOV  R0, coord_atuais_sondas   ; obtem tabela que guarda as posições atuais da sonda
    MOV  R8, 8
    MOV  R5, [R0 + R8]                  ; obtem linha da sonda esquerda
    MOV  R8, 10
    MOV  R6, [R0 + R8]              ; obtem coluna da sonda esquerda

    CMP  R5, R1                    ; compara a linha da sonda com a linha superior do ghosts
    JLT  nao_colidiu_dir           ; se a linha da sonda for menor não colidiu
    MOV  R7, R1
    ADD  R7, 4                     ; obter a linha inferior do ghost
    CMP  R5, R7                    ; compara as linhas da sonda e do ghost
    JGT  nao_colidiu_dir           ; se a linha da sonda for menor não colidiu
    CMP  R6, R2                    ; compara a coluna da sonda com a coluna esquerda do ghost
    JLT  nao_colidiu_dir           ; se for menor nao colidiu

    MOV  R9, R2
    ADD  R9, 4                     ; obter coluna direita do ghost
    CMP  R6, R9                    ; compara a coluna da sonda com a coluna direita do ghost
    JGT  nao_colidiu_dir
    JMP  colidiu_dir              ; se tem todas as condições necessárias, houove colisão

colidiu_dir:
    MOV  R10, 0
    JMP  fim_ve_colisao_sonda_dir

nao_colidiu_dir:
    MOV  R10, 1
    JMP  fim_ve_colisao_sonda_dir

fim_ve_colisao_sonda_dir:
    POP  R9
    POP  R8
    POP  R7
    POP  R6
    POP  R5
    POP  R0
    RET



;******************************************************************************
; VÊ_COLISÃO_PACMAN - vê se o ghost colidiu com a nave
;
; Argumentos:  R1 - linha do ghost
;              R2 - coluna do ghost
;
; Retorna:     R10 - valor 1 se não colidiu e 0 se colidiu
;
;*******************************************************************************

ve_colisao_pacman:
    PUSH R0
    PUSH R5
    PUSH R6
    
    MOV  R5, R1
    ADD  R5, 4

    MOV  R6, R2
    ADD  R6, 2

    MOV  R0, LINHA_PACMAN
    CMP  R5, R0               
    JLT  nao_colidiu
    MOV  R0, COLUNA_PACMAN
    CMP  R6, R0
    JLT  nao_colidiu
    MOV  R0, COLUNA_PACMAN_DIREITA
    CMP  R6, R0
    JGT  nao_colidiu
    JMP  colidiu   

colidiu:
    MOV  R10, 0
    JMP  ve_colisao_pacman_fim

nao_colidiu:
    MOV  R10, 1
    JMP  ve_colisao_pacman_fim

ve_colisao_pacman_fim:
    POP  R6
    POP  R5
    POP  R0
    RET


;*******************************************************************************
; GERA_RANDOM - gera dois números aleatórios: um número de 0 a 4 e um número
;               de 0 a 3.
; Retorna:   R11 - número aleatório (0-4)
;            R7 - número aleatório (0-3)
;
;*******************************************************************************
gera_random:
    PUSH R0
    PUSH R2
    PUSH R4
    PUSH R8

    MOV  R0, [TEC_COL]       ; lê o periférico das colunas
    SHR	 R0, 4               ; isola os bits aleatórios
	MOV  R4, R0

    MOV R7, 4                ; Faixa do primeiro número aleatório (0 a 3)
    MOD R0, R7               ; Número aleatório de 0 a 3
    MOV R7, R0               ; guardamos o número no resgisto R7

    MOV R8, 5                ; Faixa do segundo número aleatório (0 a 4)
    MOD R4, R8               ; Número aleatório de 0 a 4
    MOV R11, R4              ; guardamos o número no resgisto R7

    POP R8
    POP R4
    POP R2
    POP R0
    RET


;*******************************************************************************
; VÊ_LIMITES - verifica se o objeto está dentro dos limites do ecrã do Media
;              Center (32x64)
;   
; Argumentos:  R1 - linha do ojeto
;              R2 - coluna do objeto
;
; Retorna:     R10 - valor 1 se está dentro dos limites e 0 se está fora
;
;*******************************************************************************

ve_limites:
    PUSH R0

    MOV  R0, MAX_LINHA
    CMP  R0, R1;
    JLT  esta_fora        ; se a linha for um valor maior que 31, passa os limites  
    MOV  R0, MIN_LINHA
    CMP  R0, R1;
    JGT   esta_fora       ; se a linha for menor que 0, passa os limites
    MOV  R0, MAX_COLUNA
    CMP  R0, R2
    JLT  esta_fora        ; se a coluna for maior que 63, passa os limites
    MOV  R0, MIN_COLUNA
    CMP  R0, R2
    JGT esta_fora         ; se a coluna for menor que 0, passa os limites

esta_dentro:
    MOV R10, 1
    JMP ve_limites_fim

esta_fora:
    MOV R10, 0
    JMP ve_limites_fim

ve_limites_fim:
    POP R0
    RET


;*******************************************************************************
; SOBE_SONDA - sobe a sonda em três direções possíveis (na diagonal esquerda,
;               na diagonal direita e no centro)
;
; Argumentos:   R1 - linha sonda
;               R2 - coluna sonda
;               R3 - direção (-1, 0, 1)
;              
;*******************************************************************************

sobe_sonda:
    PUSH R4
    MOV  R4, DEF_SONDA     ; obtem tabela que define a sonda
    CALL apaga_objeto      ; apaga a sonda
    SUB  R1, 1             ; sobe uma linha 
    ADD  R2, R3            ; R3 pode ser 1 (direita), -1 (esquerda), 0 (não se move horizontalmente)
    CALL desenha_objeto    ; desenha a sonda nas respetivas coordenadas

sobe_sonda_fim:
    POP  R4
    RET


;*******************************************************************************
; DESCE_GHOST - desce a sonda em três direções possíveis (na diagonal esquerda,
;               na diagonal direita e no centro)
;
; Argumentos:   R1 - linha ghost
;               R2 - coluna ghost
;               R3 - direção (-1, 0, 1)
;               R4 - tabela que define o ghost (pode ser minerável 
;                    ou não minerável
;              
;*******************************************************************************

desce_ghost:
    CALL apaga_objeto
    ADD  R1, 1             ; desce uma linha
    ADD  R2, R3            ; R3 pode ser 1 (direita), -1 (esquerda), 0 (não se move horizontalmente)
    CALL desenha_objeto    ; desenha o ghost nas respestivas coordenadas

desce_ghost_fim:
    RET


;*******************************************************************************
; TERMINA_JOGO - rotina para parar as interrupções e terminar o jogo 
;
;*******************************************************************************
termina_jogo:									
	PUSH R0								
	PUSH R1	
    PUSH R7						
	;DI										; desativam-se todas as interrupções
    MOV  R7 , 3                             ; obter som do GAME OVER
	MOV  [TOCA_SOM], R7		                ; comando para tocar o som

	MOV	 R0, estado						; obtém-se o estado do jogo
	MOV	 R1, 2							; muda-se para o estado terminado (2)
	MOV	 [R0], R1						; atualiza-se o estado
    MOV  [APAGA_ECRÃ], R1                ; apaga os pixeis do ecrã quando termina o jogo
	MOV	 R0, SELECIONA_CENARIO_FUNDO		; obtém-se o comando para se selecionar o fundo
	MOV	 R1, CENARIO_FINAL				; muda-se o cenário de fundo para o cenário final
	MOV	 [R0], R1						; atualiza-se o cenário de fundo

;continua_terminado:
;	MOV	 R0, [tecla_carregada]			; obtém-se a tecla premida
;	MOV	 R1, TECLA_COMECA				; Lê a tecla C para dar reset ao jogo
;	CMP	 R0, R1							; é a tecla para recomeçar?
;	JNZ	 continua_terminado				; se não é, continua terminado
;    MOV  R0, estado
;    MOV  R1, 0
;    MOV  [R0], R1
termina_jogo_fim:
    POP  R7
    POP  R1								;
	POP	 R0								; retiram-se os registos do stack
	RET										;


;*******************************************************************************
; PAUSA_DESPAUSA - pausa ou despausa o jogo
;
;*******************************************************************************
pausa_despausa:
    PUSH R5								
	PUSH R6								
	PUSH R7								
	DI			                        ; desativam-se as interrupções (geral)
    MOV	 R7, [estado]		            ; obtem o estado atual do jogo  
    CMP  R7, 0                          ; vê se o jogo já está pausado ou não (0=despausado, 1=pausado)
    JNZ  despausa                       ; se o jogo está pausado(1), vai despausar
    MOV	 R7, 1					        ; faz com que esteja pausado
	MOV	 [estado], R7			        ; atualiza-se o estado para pausado (estado = 1)
	MOV	 R7, 0					        ; põe-se R7 a 0
	MOV	 R7, CENARIO_PAUSA				; obtem o endereço do cenário de pausa
	MOV	 [SELECIONA_CENARIO_FONTRAL], R7	; seleciona o cenário de fundo da pausa
	CALL pressionada
loop_pausa:	
	MOV	 R5, [tecla_carregada]		    ; obtém-se a tecla carregada
	MOV	 R6, TECLA_PAUSA				; obtém-se o endereço da tecla da pausa do jogo
	CMP	 R5, R6							; a tecla da pausa foi premida?
	JNZ  loop_pausa				        ; se não, continua-se o ciclo até ser premida
	CALL pressionada				    
despausa:
	MOV	 R7, 0							; põe se R7 a 0 para se atualizar o estado
	MOV	 [estado], R7					; quando já estava pausado muda o estado para despausado(0)
    MOV  R7 ,1
    MOV [APAGA_CENARIO_FRONTAL], R7 
	EI									; voltam-se a ativar as interrupções
	POP	 R7								 
	POP	 R6								
	POP	 R5								 
	RET

; ******************************************************************************
; PRESSIONADA - esta rotina é um loop que só acaba quando é verificado
;				que a tecla pressionada foi largada.
;
; ******************************************************************************
pressionada:
	PUSH	R0
	PUSH	R3
	
    MOV		R3, -1
loop_pressionada:
	MOV		R0, [tecla_carregada]
	CMP		R0, R3		           ; vê se a tecla foi largada 			  
	JNZ		loop_pressionada       ; o loop mantêm-se até a tecla ser largada

	POP		R3
	POP		R0
	RET


; ******************************************************************************
; MUDA_ENERGIA - reduz ou aumenta a energia do pacman e mostra a valor da mesma
;                no display
;
; Argumentos:   R10 - valor a retirar/adicionar ao display
;
; ******************************************************************************
muda_energia:
    PUSH R0						 ; endereço do valor da energia atual
	PUSH R2						 ; valor de 
    PUSH R5
	PUSH R10						 ; ação a executar (adicionar ou remover energia)

    MOV  R0, energia             ; obter endereço da energia
    MOV  R2, [R0]                ; valor da enrgia
    CMP  R10, -3                 ; é para diminuir 3% ?
    JZ   remove_3percento  
    CMP  R10, -5                 ; é para diminuir 5%? (foi lançada sonda?)
    JZ   remove_5percento 
    MOV  R5, 25
    CMP  R10, R5                ; é para adicionar 25%? (a sonda atinge um ghost minerável)
    JZ   adiciona_25percento                     

remove_3percento:
    CMP  R2, 0                   ; vê se está a zero
    JZ   muda_energia_fim        ; se for zero, não remove energia
    ADD  R2, R10                 ; corresponde à operação: energia - 3
    CMP  R2, 0
    JLT  poe_displays_zero       ; se der um resultado negativo saimos
    JMP  muda_display

remove_5percento:
   CMP  R2, 0                    ; se der um resultado negativo saimos
   JZ   muda_energia_fim         ; se for zero, não remove energia
   ADD  R2, R10                  ; corresponde à operação: energia - 5
   CMP  R2, 0
   JLT  poe_displays_zero        ; se der um resultado negativo saimos
   JMP  muda_display    

adiciona_25percento:
    CMP R2, 0                    ; se der um resultado negativo saimos
    JZ  muda_energia_fim         ; se for zero, não remove energia
    ADD R2, R10                  ; corresponde à operação: energia + 25
    CMP R2, 0
    JLT poe_displays_zero        ; se der um resultado negativo saimos
    JMP muda_display

muda_display:
    MOV  [R0], R2                ; guarda a nova energia na memória
    CALL converte_p_decimal      ; converte o valor hexadecimal para decimal
    MOV  [DISPLAYS], R2          ; mostra o valor decimal nos displays
    JMP  muda_energia_fim

poe_displays_zero:
    MOV R2, 0
    MOV [R0], R2                  ; poe a energia a zero
    MOV [DISPLAYS], R2           ; poe os displays a zero

muda_energia_fim:
    POP  R10
    POP  R5
    POP  R2
    POP  R0
    RET

; ******************************************************************************
; CONVERTE_P_DECIMAL - Converte um número em base hexadecimal para base decimal.
;               
; Argumentos:   R2 - número em base hexadecimal
;
; Retorna:      R2 - número em base decimal
;
; ******************************************************************************
converte_p_decimal:
    PUSH R0
    PUSH R1
    PUSH R3
    MOV  R3, 10  
    MOV  R0, R2                 ; copia o primeiro dígito
    MOD  R0, R3                 ; obter o valor do primeiro dígito em base decimal
    DIV  R2, R3                 ; obter o número de vezes que o primeiro dígito excede o digito nove
    MOV  R1, R2                 ; copia o segundo dígito
    MOD  R1, R3                 ; obter o valor do segundo dígito em base decimal
    DIV  R2, R3                 ; obter o número de vezes que o segundo dígito excede o digito nove

proximo_digito:
    SHL  R2, 4                  ; desloca, para dar espaço ao novo dígito
    OR   R2, R1                 ; juntar segundo dígito
    SHL  R2, 4                  ; desloca, para dar espaço ao novo dígito
    OR   R2, R0                 ; juntar primeiro dígito
    JMP  converte_p_decimal_fim

converte_p_decimal_fim:
    POP  R3
    POP  R1
    POP  R0
    RET

; ******************************************************************************
; DESENHA_OBJETO - Desenha um objeto na linha e coluna indicadas
;			    com a forma e cor definidas na tabela indicada.
; Argumentos: R1 - linha
;             R2 - coluna
;             R4 - tabela que define o objeto
;
; ******************************************************************************
desenha_objeto:
    PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
    PUSH R6
    PUSH R7
    PUSH R8
    PUSH R9
    PUSH R10
	
    MOV	 R5, [R4]	         ; obtém a largura do boneco
    MOV  R6, [R4+2]          ; obtém a altura do objeto
	MOV  R9, R1              ; copia a linha do objeto para um registo 
    MOV  R10, R2             ; copia a coluna do objeto para um registo
    MOV  R8, 4
desenha_pixels:              ; desenha os pixels do boneco a partir da tabela
	MOV	 R3, [R4+R8]         ; obtém a cor do próximo pixel do objeto
	CALL escreve_pixel	     ; escreve cada pixel do objeto
	ADD	 R8, 2			     ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD  R10, 1               ; próxima coluna
    SUB  R5, 1			     ; menos uma coluna para tratar
    JNZ  desenha_pixels      ; continua até percorrer toda a largura do objeto
    ADD  R9, 1               ; próxima linha
    MOV  R10, R2             ; restaurar o valor da coluna
    MOV  R5, [R4]            ; restaura o valor da largura
    SUB  R6, 1               ; menos uma linha para tratar
    JNZ  desenha_pixels      ; percorre a nova linha
desenha_objeto_fim:	
    POP  R10
    POP  R9
    POP  R8
    POP  R7
    POP  R6
    POP	 R5
	POP	 R4
	POP	 R3
	POP	 R2
    POP  R1
	RET


; ******************************************************************************
; ESCREVE_PIXEL - Escreve um pixel na linha e coluna indicadas.
; Argumentos:   R9 - linha
;               R10 - coluna
;               R3 - cor do pixel (em formato ARGB de 16 bits)
;
; ******************************************************************************
escreve_pixel:
	MOV  [DEFINE_LINHA],  R9		; seleciona a linha
	MOV  [DEFINE_COLUNA], R10		; seleciona a coluna
	MOV  [DEFINE_PIXEL],  R3		; altera a cor do pixel na linha e coluna já selecionadas
	RET


; ******************************************************************************
; APAGA_OBJETO - Apaga um objeto na linha e coluna indicadas na tabela
;			  com a forma definida na tabela indicada.
; Argumentos:   R1 - linha do objeto
;               R2 - coluna do objeto
;               R4 - tabela que define o objeto
;
; ******************************************************************************
apaga_objeto:
    PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
    PUSH R6
    PUSH R7
    PUSH R9
    PUSH R10
	
    MOV	 R5, [R4]	     ; obtém a largura do boneco
    MOV  R6, [R4+2]      ; obtém a altura do objeto
	MOV  R9, R1          ; copia a linha do objeto para um registo 
    MOV  R10, R2         ; copia a coluna do objeto para um registo
apaga_pixels:            ; desenha os pixels do boneco a partir da tabela
	MOV	 R3, 0			 ; cor para apagar o próximo pixel do boneco
	CALL escreve_pixel	 ; escreve cada pixel do boneco
    ADD  R10, 1           ; próxima coluna
    SUB  R5, 1			 ; menos uma coluna para tratar
    JNZ  apaga_pixels    ; continua até percorrer toda a largura do objeto
    ADD  R9, 1           ; próxima linha
    MOV  R10, R2         ;restaurar o valor da coluna
    MOV  R5, [R4]        ; restaura o valor da largura
    SUB  R6, 1           ; menos uma linha para tratar
    JNZ  apaga_pixels      
apaga_pixels_fim:
    POP  R10
    POP  R9
    POP  R7
    POP  R6
    POP	 R5
	POP	 R4
	POP	 R3
	POP	 R2
    POP  R1
	RET


; ******************************************************************************
; ************************ ROTINAS DE INTERRUPÇÃO ******************************
; ******************************************************************************


; ******************************************************************************
; ROT_INT_0 - 	Rotina de atendimento da interrupção 0 
;			Assinala o evento na componente 0 da variavel evento_int
;
; ******************************************************************************
rot_int_0:
	PUSH R0
	PUSH R1
	MOV  R0, evento_int
	MOV  R1, 1				; assinala que houve uma interrupção 0
	MOV  [R0], R1			; na componente 0 da variavel evento_int
	POP  R1
	POP  R0
	RFE

; ******************************************************************************
; ROT_INT_1 - 	Rotina de atendimento da interrupção 1
;			Assinala o evento na componente 1 da variavel evento_int
;
; ******************************************************************************
rot_int_1:
	PUSH R0
	PUSH R1
	MOV  R0, evento_int
	MOV  R1, 1				; assinala que houve uma interrupção 0
	MOV  [R0+2], R1			; na componente 1 da variavel evento_int
							; Usa-se 2 porque cada word tem 2 bytes
	POP  R1
	POP  R0
	RFE

; ******************************************************************************
; ROT_INT_2 - 	Rotina de atendimento da interrupção 1
;			Assinala o evento na componente 1 da variavel evento_int
;
; ******************************************************************************
rot_int_2:
	PUSH R0
	PUSH R1
	MOV  R0, evento_int
	MOV  R1, 1				; assinala que houve uma interrupção 0
	MOV  [R0+4], R1			; na componente 1 da variavel evento_int
							; Usa-se 2 porque cada word tem 2 bytes
	POP  R1
	POP  R0
	RFE
    ; ******************************************************************************
; ROT_INT_3 - 	Rotina de atendimento da interrupção 1
;			Assinala o evento na componente 1 da variavel evento_int
;
; ******************************************************************************
rot_int_3:
	PUSH R0
	PUSH R1
	MOV  R0, evento_int
	MOV  R1, 1				; assinala que houve uma interrupção 0
	MOV  [R0+6], R1			; na componente 1 da variavel evento_int
							; Usa-se 2 porque cada word tem 2 bytes
	POP  R1
	POP  R0
	RFE