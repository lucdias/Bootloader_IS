org 0x7e00
jmp 0x0000:start

 pos1 db 1
 pos2 db 5
 pos3 db 2
 pos4 db 4
 pos5 db 6
 pos6 db 3
 pos7 db 2
 pos8 db 4
 pos9 db 5
pos10 db 1
pos11 db 3 
pos12 db 6
pontoGeral dw 0
pontoP db "0"
vida db "3"
hack db 0
cont dw 0
cont2 dw 0
cont3 dw 0
cont4 dw 0
setaX dw 250
setaY dw 140
posiCX1 dw 0
posiCY1 dw 0
pdx dw 0
pdy dw 0
carta1 db 0
carta2 db 0
memo0  incbin "memorias/off.bin"
memo1  incbin "memorias/sd.bin"
memo2  incbin "memorias/mixe.bin"
memo3  incbin "memorias/hd.bin"
memo4  incbin "memorias/pendrive.bin"
memo5  incbin "memorias/flop.bin"
memo6 incbin "memorias/cloud.bin"
abertura1 db 'Memoria Jogo', 0
abertura2 db 'Jogo Da Memoria^2', 0
abertura3 db 'J  o  a M m  i ^ ', 0
guia db 'Guia Do Jogo', 13
iniciar db 'Iniciar Jogo', 13
movimentos dw 0
pontuacao db 'Pontos:',13
vidas db 'Vidas:',13
perdeu db 'You Lose!',13
ganhou db 'You Win!',13
explicacao db 'Esse jogo consiste em acertar todos os pares', 13
explicacao2 db ' de cartas iguais utilizando a sua memoria', 13
explicacao3 db ' para isso.', 13
explicacao4 db 'Para escolher uma carta basta clicar em um numero de 1-9', 13
explicacao5 db ' essa ira virar ate que outra seja selecionada.', 13
explicacao6 db 'Voce tem 3 vidas. Boa sorte.', 13
sala1 db 'Mais uma ?',13
sala2 db 'Sim',13
sala3 db 'Nao',13
putchar:
	mov ah, 0x0e ;
	int 10h ; interrupção de vídeo
	ret
prints:
	.loop1a:
		lodsb ; bota character em al
		cmp al, 0
		je .endloop1a
		call putchar
		jmp .loop1a
	.endloop1a:
	ret
reverse:
	;mov di, si
	xor cx, cx 
	.loopa1:
		lodsb
		cmp al, 0
		je .endloopa1
		inc cl
		push ax
		;call putchar
		jmp .loopa1
	.endloopa1:
	
	.loopb1:
		cmp cl, 0
		je .endloopb1
		dec cl
		pop ax
		stosb
		jmp .loopb1
	.endloopb1:
	mov ax,0
	stosb
	ret
delay:
    mov bp,350
    mov dx, 350
    delay2:
        dec bp
        nop
        jnz delay2
    dec dx
    jnz delay2
	ret
printStr:
	lodsb
    mov ah, 0xe
    mov bh, 0
    int 10h
    cmp al, 13
    jne printStr
	ret
cursorTitulo: ;setando o cursor para printar o titulo varias vezes de modos diferentes
	mov ah, 02h
    mov bh, 00h
    mov dh, 07h
    mov dl, 20h
    int 10h
	ret
printTitulo:;printa o titulo no cursor seta em cursorTitulo
	
    lodsb
    call delay
    mov ah, 0xe
    mov bh, 0
    mov bl, 0xf
    int 10h
    cmp al, 0
    jne printTitulo
	ret	
inicio_abertura:
	
	mov ah, 0
    mov al, 12h;"limpa" a tela e a transforma em branco
    int 10h
    mov ah, 0bh;colore o background com azul
    mov bx, 1
    int 10h

	call cursorTitulo
    mov si, abertura1
    call printTitulo
    call cursorTitulo
    mov si, abertura3
    call printTitulo
    call cursorTitulo
    mov si, abertura2
    call printTitulo

    mov ah, 02h;seta o cursor
    mov bh, 0
  	mov dh, 17h
  	mov dl, 10h
  	int 10h
  	mov si, guia;printa a opcao de guia
  	mov bl, 0xc
  	call printStr
  	
  	mov ah, 02h
    mov bh, 0
  	mov dh, 17h
  	mov dl, 30h
  	int 10h
  	mov si, iniciar
  	mov bl, 0xc
  	call printStr

  	mov ah, 0bh
    mov bx, 1
    int 10h

    mov ah, 02h;setando o cursor
    mov bh, 0
    mov dh, 15h
    mov dl, 15h
    int 10h

    mov al, 'V';coloca a primeira opcao como Guia
    mov ah, 0xe
    mov bh, 0
    mov bl, 7
    int 10h
    mov cl, 0 ;colocando o cl como 0 por estar na opcao de guia sendo assim 0 para guia 1 para jogo
	ret
continue:
	
	mov ah, 0
    mov al, 12h;"limpa" a tela e a transforma em branco
    int 10h
    mov ah, 0bh;colore o background com azul
    mov bx, 1
    int 10h

	mov ah, 02h
    mov bh, 00h
    mov dh, 09h
    mov dl, 20h
    int 10h
    mov bl, 0xf
    mov si,pontuacao
    call printStr

    mov ah, 02h
    mov bh, 00h
    mov dh, 09h
    mov dl, 2ah
    int 10h
    mov ax,word[pontoGeral]
    call tostring
    mov bl, 0xf
    call prints
    
    cmp byte[vida],"0"
  	je endCont

    call cursorTitulo
    mov si, sala1
    mov bl, 0xf
    call printStr
    
    mov ah, 02h;seta o cursor
    mov bh, 0
  	mov dh, 17h
  	mov dl, 15h
  	int 10h
  	mov si, sala3
  	mov bl, 0xf
  	call printStr
  	
  	mov ah, 02h
    mov bh, 0
  	mov dh, 17h
  	mov dl, 33h
  	int 10h
  	mov si, sala2
  	mov bl, 0xf
  	call printStr

  	mov ah, 0bh
    mov bx, 1
    int 10h

    mov ah, 02h;setando o cursor
    mov bh, 0
    mov dh, 15h
    mov dl, 15h
    int 10h

    mov al, 'V';coloca a primeira opcao como Guia
    mov ah, 0xe
    mov bh, 0
    mov bl, 7
    int 10h
    mov cl, 0 ;colocando o cl como 0 por estar na opcao de guia sendo assim 0 para guia 1 para jogo
	endCont:
	ret	
movimentacao_menu:
	menu_escolha:
		mov ah, 0h
		int 16h
		cmp al, 13
		je end_mov
		cmp al, 'a'
		je left
		cmp al, 'd'
		je right
	left:
		mov ah, 02h;setando o cursor
	    mov bh, 0
	    mov dh, 15h
	    mov dl, 15h
	    int 10h

	    mov cl, 0;usando cl para a posterior contaracao indicando qual parte do codigo ir
	    
	    jmp print_set
	right:
		mov ah, 02h
		mov bh, 0
		mov dh, 15h
		mov dl, 35h
		int 10h

		mov cl, 1

		jmp print_set	
	print_set:
		mov al, 'V'
		mov ah, 0xe
		mov bh, 0
		mov bl, 7
		int 10h

		cmp cl, 0;verificando onde o cursor deve estar agora
		je clear_right
		mov ah, 02h;setando o cursor
	    mov bh, 0
	    mov dh, 15h
	    mov dl, 15h
	    int 10h
	    
	    mov al, ' '
	    mov ah, 0xe
	    int 10h
	    
	    jmp menu_escolha
	    
	    clear_right:
	    	mov ah, 02h;setando o cursor
		    mov bh, 0
		    mov dh, 15h
		    mov dl, 35h
		    int 10h
		    
		    mov al, ' '
		    mov ah, 0xe
		    int 10h

	jmp menu_escolha
	end_mov:
	ret
guia_fun:
	mov ah, 0
	mov al, 12h
	int 10h

	mov ah, 0bh
	mov al, 7
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 1
	mov dl, 30
	int 10h

	mov ah, 0xe
	mov al, '-'
	int 10h

	mov si, guia
	mov bl, 0x1
	call printStr
	
	mov ah, 0xe
	mov al, '-'
	int 10h
	

	mov ah, 02h
	mov bh, 0
	mov dh, 5h
	mov dl, 10h
	int 10h

	mov si, explicacao
	mov bl, 0xe
	call printStr

	mov ah, 02h
	mov bh, 0
	mov dh, 6h
	mov dl, 10h
	int 10h
	
	mov si, explicacao2
	call printStr

	mov ah, 02h
	mov bh, 0
	mov dh, 7h
	mov dl, 10h
	int 10h

	mov si, explicacao3
	call printStr

	mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 10h
	int 10h

	mov si, explicacao4
	mov bl, 0xc
	call printStr

	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 10h
	int 10h

	mov si, explicacao5
	call printStr
	
	mov ah, 02h
	mov bh, 0
	mov dh, 15
	mov dl, 10h
	int 10h

	mov si, explicacao6
	mov bl, 0x3
	call printStr

	mov ah, 02h
	mov bh, 0
	mov dh, 25
	mov dl, 30
	int 10h

	mov si, iniciar
	mov bl, 0x4
	call printStr

		mov ah, 02h
		mov bh, 0
		mov dh, 23
		mov dl, 35
		int 10h

		mov al, 'V'
		mov ah, 0xe
		int 10h

		mov ah, 0









		int 16h
		cmp al, 13	
	ret
tostring:
	push di
	.loop1:
		cmp ax, 0
		je .endloop1
		xor dx, dx
		mov bx, 10

		div bx ; ax = 999, dx = 9
		xchg ax, dx; swap ax, dx
		add ax, 48 ; 9 + '0' = '9'
		stosb
		xchg ax, dx
		jmp .loop1
	.endloop1:
		pop si
		cmp si, di
		jne .done
		mov al, 48
		stosb
	.done:
		mov al, 0
		stosb
	call reverse
	ret
tabuleiro:
	mov al,2
	mov cx,130
	mov dx,40
	colunaJ:
	mov ah, 0Ch
	mov bh,0
	int 10h	
	push cx
	add cx,120
	int 10h
	add cx,120
	int 10h
	add cx,120
	int 10h	
	pop cx
	inc dx
	cmp dx,440	
	jne colunaJ
	
	mov cx,130
	mov dx,40
	linhaJ:
	mov ah, 0Ch
	mov bh,0
	int 10h	
	push dx
	add dx,100
	int 10h
	add dx,100
	int 10h
	add dx,100
	int 10h
	add dx,100
	int 10h	
	pop dx
	inc cx
	cmp cx,490	
	jne linhaJ
	
	ret
drawImage:
	pusha
	xor ax, ax
	mov cx,word[setaX]
	sub cx,110
	mov dx,word[setaY]
	sub dx,20
	mov word[cont],cx
	mov word[cont2],dx
	add word[cont],10
	sub word[cont2],8

	mov word[cont3],10
	mov word[cont4],8
	.loopPixelY:
		push cx
		.loopPixel:
				lodsb       ;al (color) -> next word
				.forx:
					push cx
					.fory:
						mov ah, 0xC ;write pixel at coordinate
						int 0x10 ;might "destroy" ax, si and di on some systems
						inc cx  ;decrease dx by one and set flags
						cmp cx,word[cont]
						jne .fory ;repeat for y-length
						pop cx     ;restore dx
					dec dx
					cmp dx,word[cont2]      ;decrease si by one and set flags
					jne .forx
		add cx,10
		add dx,8			
		add word[cont],10
		dec word[cont3]
		jnz .loopPixel
	pop cx
	sub dx,8
	mov word[cont],cx
	mov word[cont2],dx
	add word[cont],10
	sub word[cont2],8

	mov word[cont3],10
	dec word[cont4]
	jnz .loopPixelY
	popa
	ret
card: ; coloca na tela uma carta
	sub cx,10  ; o valor das posições são definidas antes de chamar dessa função card,
	sub dx,20	; aqui em cx e dx são as posições são colocadas no centro da posição do quadrado do seletor
	mov word[cont],dx ; contadores dos loops
	sub word[cont],60
	mov word[cont2],cx
	sub word[cont2],80
	loop1:    ; retangulo / carta
	push dx
		loop2:
			mov ah,0Ch
			mov bh,0
			int 10h	
			cmp dx,word[cont]
			je endLoop2
			dec dx
			jmp loop2
		endLoop2:
		pop dx
		cmp cx,word[cont2]
		je endLoop1
		dec cx
		jmp loop1
	endLoop1:	
	ret
SetaC: ; coloca na tela o quadrado em cima da carta seleciona
	push dx
	mov word[cont],dx
	sub word[cont],100
	coluna:         ; colunas do seletor
	mov ah, 0Ch
	mov bh,0
	int 10h	
	push cx
	inc cx
	int 10h
	inc cx
	int 10h
	sub cx,2
	sub cx,120
	int 10h	
	inc cx
	int 10h
	inc cx
	int 10h
	sub cx,2
	pop cx
	dec dx
	cmp dx,word[cont]	
	jne coluna
	
	pop dx			; linhas do seletor
	mov word[cont],cx
	sub word[cont],120
	linha:
	mov ah, 0Ch
	mov bh,0
	int 10h	
	push dx
	inc dx
	int 10h
	inc dx
	int 10h
	sub dx,2
	sub dx,100
	int 10h
	inc dx
	int 10h
	inc dx
	int 10h	
	pop dx
	dec cx
	cmp cx,word[cont]	
	jne linha

	ret
cartas:
	
	cmp al,0
	jne p1
	ret
	p1:
	cmp al,1
	jne p2
	mov si,memo1
	ret
	p2:
	cmp al,2
	jne p3
	mov si,memo2
	ret
	p3:
	cmp al,3
	jne p4
	mov si,memo3
	ret
	p4:
	cmp al,4
	jne p5
	mov si,memo4
	ret
	p5:
	cmp al,5
	jne p6
	mov si,memo5
	ret
	p6:
	cmp al,6
	jne p7
	mov si,memo6
	ret
	p7:
	ret
deck: ; Usado para manipular as cartas, tanto para pegar seu valor quando para apaga-lo
	
	c1: ;coluna 1  // contara as colunas primeiro, dai se achar a coluna ele parte para as linhas
	cmp word[setaX],250
	jne c2
	c1l1: ;coluna 1 linha 1
	cmp word[setaY],140
	jne c1l2
	mov al,byte[pos1]
	cmp ah,1
	jne end 		
	add byte[pos1],10	
	ret
	c1l2:
	cmp word[setaY],240
	jne c1l3
	mov al,byte[pos2]
	cmp ah,1
	jne end 
	add byte[pos2],10
	ret
	c1l3:
	cmp word[setaY],340
	jne c1l4
	mov al,byte[pos3]
	cmp ah,1
	jne end 
	add byte[pos3],10
	ret
	c1l4:
	mov al,byte[pos4]
	cmp ah,1
	jne end 
	add byte[pos4],10

	c2: ; coluna 2
	cmp word[setaX],370
	jne c3
	c2l1: ; coluna 2 linha 1...
	cmp word[setaY],140
	jne c2l2
	mov al,byte[pos5]
	cmp ah,1
	jne end 
	add byte[pos5],10
	ret
	c2l2:
	cmp word[setaY],240
	jne c2l3
	mov al,byte[pos6]
	cmp ah,1
	jne end 
	add byte[pos6],10
	ret
	c2l3:
	cmp word[setaY],340
	jne c2l4
	mov al,byte[pos7]
	cmp ah,1
	jne end 
	add byte[pos7],10
	ret
	c2l4:
	mov al,byte[pos8]
	cmp ah,1
	jne end 
	add byte[pos8],10
	ret
	c3:
	cmp word[setaX],490
	jne end
	c3l1:
	cmp word[setaY],140
	jne c3l2
	mov al,byte[pos9]
	cmp ah,1
	jne end 
	add byte[pos9],10
	ret
	c3l2:
	cmp word[setaY],240
	jne c3l3
	mov al,byte[pos10]
	cmp ah,1
	jne end 
	add byte[pos10],10
	ret
	c3l3:
	cmp word[setaY],340
	jne c3l4
	mov al,byte[pos11]
	cmp ah,1
	jne end 
	add byte[pos11],10
	ret
	c3l4:
	mov al,byte[pos12]
	cmp ah,1
	jne end 
	add byte[pos12],10
	end:
	ret
delayGame:
	pusha
	mov dx,1000
	mov cx,1000
	loopDel:
		loopDel1:
		dec cx
		cmp cx,0
		jne loopDel1
	dec dx
	cmp dx,0
	jne loopDel
	popa
	ret
resetePosi:
	mov cl,10
	cmp cl,byte[pos1]
	jg .k1
	sub byte[pos1],10
	.k1:
	cmp cl,byte[pos2]
	jg .k2
	sub byte[pos2],10
	.k2:
	cmp cl,byte[pos3]
	jg .k3
	sub byte[pos3],10
	.k3:
	cmp cl,byte[pos4]
	jg .k4
	sub byte[pos4],10
	.k4:
	cmp cl,byte[pos5]
	jg .k5
	sub byte[pos5],10
	.k5:
	cmp cl,byte[pos6]
	jg .k6
	sub byte[pos6],10
	.k6:
	cmp cl,byte[pos7]
	jg .k7
	sub byte[pos7],10
	.k7:
	cmp cl,byte[pos8]
	jg .k8
	sub byte[pos8],10
	.k8:
	cmp cl,byte[pos9]
	jg .k9
	sub byte[pos9],10
	.k9:
	cmp cl,byte[pos10]
	jg .k10
	sub byte[pos10],10
	.k10:
	cmp cl,byte[pos11]
	jg .k11
	sub byte[pos11],10
	.k11:
	cmp cl,byte[pos12]
	jg .k12
	sub byte[pos12],10
	.k12:
	ret
embaralha:
	pusha
	
	mov bx,word[movimentos]
	loopMov:
		mov dl,byte[pos1]
		mov cl,byte[pos12]
		mov byte[pos1],cl
		mov byte[pos12],dl
		mov dl,byte[pos2]
		mov cl,byte[pos3]
		mov byte[pos2],cl
		mov byte[pos3],dl
		mov dl,byte[pos4]
		mov cl,byte[pos5]
		mov byte[pos4],cl
		mov byte[pos5],dl
		mov dl,byte[pos6]
		mov cl,byte[pos7]
		mov byte[pos6],cl
		mov byte[pos7],dl
		mov dl,byte[pos8]
		mov cl,byte[pos9]
		mov byte[pos8],cl
		mov byte[pos9],dl
		mov dl,byte[pos10]
		mov cl,byte[pos11]
		mov byte[pos10],cl
		mov byte[pos11],dl
		dec bx
		jz endMov
		mov dl,byte[pos1]
		mov cl,byte[pos2]
		mov byte[pos1],cl
		mov byte[pos2],dl
		mov dl,byte[pos3]
		mov cl,byte[pos4]
		mov byte[pos3],cl
		mov byte[pos4],dl
		mov dl,byte[pos5]
		mov cl,byte[pos6]
		mov byte[pos5],cl
		mov byte[pos6],dl
		mov dl,byte[pos7]
		mov cl,byte[pos8]
		mov byte[pos7],cl
		mov byte[pos8],dl
		mov dl,byte[pos9]
		mov cl,byte[pos10]
		mov byte[pos9],cl
		mov byte[pos10],dl
		mov dl,byte[pos11]
		mov cl,byte[pos12]
		mov byte[pos11],cl
		mov byte[pos12],dl
		dec bx
		jnz loopMov
	endMov:
	mov bx,400
	cmp bx,word[movimentos]
	jg .sai
	mov word[movimentos],0
	.sai:
	popa
	ret
game:
    mov ah, 0
    mov al, 12h;"limpa" a tela e a transforma em branco
    mov bh, 0h
    int 10h

    mov dx,440
    mov cx,490
    mov al,15
    loop1a:    ; retangulo / carta
	push dx
		loop2a:
			mov ah,0Ch
			mov bh,0
			int 10h	
			dec dx
			cmp dx,40
			jne loop2a
		pop dx
		dec cx
		cmp cx,130
		jne loop1a
    call tabuleiro ; pinta os quadrados das posições
    mov word[setaX],250
    mesa1:
    	mov  word[setaY],140
    	mesa2:
		call deck
		call cartas
		mov dx, word[setaY]
		mov cx, word[setaX]
		call drawImage
		add word[setaY],100
		cmp word[setaY],540
		jne mesa2
		add word[setaX],120
    	cmp word[setaX],610
		jne mesa1

    call delayGame
    mov si, memo0
    mov word[setaX],250
    mesa3:
    	mov  word[setaY],140
    	mesa4:
		mov dx, word[setaY]
		mov cx, word[setaX]
		call drawImage
		add word[setaY],100
		cmp word[setaY],540
		jne mesa4
		add word[setaX],120
    	cmp word[setaX],610
		jne mesa3

	mov word[setaX],250
	mov word[setaY],140
	
   	mov cx,word[setaX] ; posição inicial do seletor
	mov dx,word[setaY]
	mov al,0
	call SetaC  ; pinta seletor na posição definida

	mov ah, 02h;seta o cursor
    mov bh, 0
  	mov dh, 29
  	mov dl, 13
  	int 10h
  	mov si,pontuacao
  	mov bl, 0xf
  	call printStr

  	mov ah, 02h;seta o cursor
    mov bh, 0
  	mov dh, 29
  	mov dl, 50
  	int 10h
  	mov si,vidas 
  	mov bl, 0xf
  	call printStr
    
    jogada:
      	
    	mov ah, 02h;setando o cursor
	    mov bh, 0
	    mov dh, 29
	    mov dl, 21
	    int 10h
	    mov al, byte[pontoP] ; mostra pontos
	    mov ah, 0xe
	    mov bl,0xf
	    int 10h
	    cmp byte[pontoP],"6" ; se pontos igual a 6, win!
    	je endWin
    	cmp byte[vida],"0" ; se vidas igual a 9, fim de jogo
    	je endLose 
    	mov ah, 02h;setando o cursor
	    mov bh, 0
	    mov dh, 29
	    mov dl, 58
	    int 10h
	    
	    mov al, byte[vida] ;motra vidas
	    mov ah, 0xe
	    mov bl,0xf
	    int 10h

    	mov ah, 0 ; pega entrada
		int 16h

		cmp al,13
		je .card

		cmp al,'w'
		je .up

		cmp al,'s'
		je .down

		cmp al,'a'
		je .left

		cmp al,'d'
		je .right

		cmp al,'b'
		je .hack
		
		xor cx,cx
		xor dx,dx
		.left:
			mov cx,word[setaX]
			mov dx,word[setaY]
	
			inc word[movimentos]
			cmp word[setaX],250 ; verifica se está em um extremo
			je jogada

			mov al,2
			call SetaC ; pinta antiga posição do seletor na cor do tabuleiro
			sub word[setaX],120
			mov cx,word[setaX]
			mov dx,word[setaY]
			mov al,0
			call SetaC ; pinta nova posição do deletor com cor branca
    	jmp jogada

    	.right:
    		mov cx,word[setaX]
			mov dx,word[setaY]
			inc word[movimentos]
			cmp word[setaX],490
			je jogada

			mov al,2
			call SetaC
			add word[setaX],120
			mov cx,word[setaX]
			mov dx,word[setaY]
			mov al,0
			call SetaC
    	jmp jogada
    	.hack:
    		mov byte[hack],1
    	jmp jogada
    	.up:
    		mov cx,word[setaX]
			mov dx,word[setaY]
	
			inc word[movimentos]
			cmp word[setaY],140
			je jogada
			
			mov al,2
			call SetaC
			sub word[setaY],100
			mov cx,word[setaX]
			mov dx,word[setaY]
			mov al,0
			call SetaC
    	jmp jogada

    	.down:
    		mov cx,word[setaX]
			mov dx,word[setaY]
	
			inc word[movimentos]
			cmp word[setaY],440
			je jogada
			
			mov al,2
			call SetaC
			add word[setaY],100
			mov cx,word[setaX]
			mov dx,word[setaY]
			mov al,0
			call SetaC
    	jmp jogada
		.card: 
			mov cx,word[setaX]
			mov dx,word[setaY]
	
			inc word[movimentos]
			call deck
			cmp al,10 ; se a carta já tiver sido encontrada com seu par essa ação não vale
			jg jogada
			call cartas
			call drawImage ; caso o carta ainda não tenha sido encontrada com seu par, ela é mostrada
			cmp byte[carta1],0; vê se a primeira carta já foi escolhida
			je keepGoing
				cmp cx,word[posiCX1] ; compara se a carta selecionada é a mesma. // vê se essa o seletor não saiu da posição
				jne ok 
				cmp dx,word[posiCY1]
				je jogada 
				ok:
				cmp byte[carta1],al	; compara primeira carta escolhida com atual
					jne Nigual
					mov ah,1  ; muda comando para apagar valor da posição, assim não permitindo mais ações com ela
					call deck ; apaga valor da posição
					mov cx,word[setaX] ; salva valores atuais, pois o cursor vai precisar ir para a atinga posição para o deck encontrar a antiga carta
					mov dx,word[setaY] ; e assim apagar o valor dela.
					push cx
					push dx
					push bx
					mov bx,word[posiCX1] 
					mov word[setaX],bx
					mov bx,word[posiCY1]
					mov word[setaY],bx
					pop bx
					mov ah,1
					call deck  ; apaga valor da primeira carta
					mov ah,0
					pop dx
					pop cx
					add word[pontoGeral],1
					add byte[pontoP],1
					mov word[setaX],cx ; volta valores para a posição atual
					mov word[setaY],dx
					mov byte[carta1],0
				jmp jogada
				Nigual: ; não é igual
					call delayGame
					mov byte[carta1],0 ; reseta primeira carta
					cmp byte[hack],1 ; permite deixar carta virada
					je jogada
					sub byte[vida],1
				    mov cx,word[setaX]
					mov dx,word[setaY]
					mov si,memo0
					call drawImage
					push bx
					mov bx,word[posiCX1]
					mov word[setaX],bx
					mov bx,word[posiCY1]
					mov word[setaY],bx
					mov si,memo0
					call drawImage
					mov word[setaX],cx
					mov word[setaY],dx
				jmp jogada
			keepGoing:
			push ax
			mov byte[carta1],al
			mov ax,word[setaY]
			mov word[posiCY1],ax
			mov ax,word[setaX]
			mov word[posiCX1],ax
			pop ax
		jmp jogada		
	endLose:
	mov ah, 0
    mov al, 12h;"limpa" a tela e a transforma em branco
    int 10h
    mov ah, 0bh
    mov bx, 8
    int 10h
    mov ah, 02h;seta o cursor
    mov bh, 0
  	mov dh, 13
  	mov dl, 33
  	int 10h
  	mov si,perdeu
  	mov bl, 0xf
  	call printStr
  	call delayGame
  	call delayGame
  	mov byte[pontoP],"0"
  	call continue
  	jmp endAll
	endWin:
	mov ah, 0
    mov al, 12h;"limpa" a tela e a transforma em branco
    int 10h
    mov ah, 0bh
    mov bx, 8
    int 10h
	mov ah, 02h;seta o cursor
    mov bh, 0
  	mov dh, 13
  	mov dl, 33
  	int 10h
  	mov si, ganhou
  	mov bl, 0xf
  	call printStr
  	call delayGame
  	call delayGame
  	mov byte[pontoP],"0"
  	mov byte[vida],"3"
  	mov byte[hack],0
	call resetePosi
	call embaralha
	jmp resetG
start:
    xor ax, ax
    mov ds, ax
    mov es, ax
   	call inicio_abertura 
    call movimentacao_menu
    cmp cl, 1
    je done
    call guia_fun
    
done:
	jmp game
	resetG:
	call continue
	call movimentacao_menu
	cmp cl,1
	je done
	endAll:
	jmp $
