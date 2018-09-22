org 0x7e00
jmp 0x0000:start

pos1 db 1
pos2 db 12
pos3 db 7
pos4 db 4
pos5 db 4
pos6 db 1
pos7 db 7
pos8 db 8
pos9 db 3
pos10 db 3
pos11 db 8 
pos12 db 12
ponto db "0"
vida db "3"
hack db 0
comp dw 0
comp2 dw 0
setaX dw 250
setaY dw 160
posiCX1 dw 0
posiCY1 dw 0
carta1 db 0
carta2 db 0

abertura1 db 'Memoria Jogo', 0
abertura2 db 'Jogo Da Memoria', 0
abertura3 db 'J  o  a M m  i ', 0
guia db 'Guia Do Jogo', 13
iniciar db 'Iniciar Jogo', 13

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
    mov bx, 9
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

	    mov cl, 0;usando cl para a posterior comparacao indicando qual parte do codigo ir
	    
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
tabuleiro:
	mov al,2
	mov cx,150
	mov dx,80
	colunaJ:
	mov ah, 0Ch
	mov bh,0
	int 10h	
	push cx
	add cx,100
	int 10h
	add cx,100
	int 10h
	add cx,100
	int 10h	
	pop cx
	inc dx
	cmp dx,400	
	jne colunaJ
	
	mov cx,150
	mov dx,80
	linhaJ:
	mov ah, 0Ch
	mov bh,0
	int 10h	
	push dx
	add dx,80
	int 10h
	add dx,80
	int 10h
	add dx,80
	int 10h
	add dx,80
	int 10h	
	pop dx
	inc cx
	cmp cx,450	
	jne linhaJ
	
	ret
card:
	pusha
	sub cx,10
	sub dx,10
	mov word[comp],dx
	sub word[comp],60
	mov word[comp2],cx
	sub word[comp2],80
	loop1:
	push dx
		loop2:
			mov ah,0Ch
			mov bh,0
			int 10h	
			cmp dx,word[comp]
			je endLoop2
			dec dx
			jmp loop2
		endLoop2:
		pop dx
		cmp cx,word[comp2]
		je endLoop1
		dec cx
		jmp loop1
	endLoop1:	
	popa
	ret
SetaC:	
	push dx
	mov word[comp],dx
	sub word[comp],80
	coluna:
	mov ah, 0Ch
	mov bh,0
	int 10h	
	push cx
	sub cx,100
	int 10h	
	pop cx
	dec dx
	cmp dx,word[comp]	
	jne coluna
	
	pop dx
	mov word[comp],cx
	sub word[comp],100
	linha:
	mov ah, 0Ch
	mov bh,0
	int 10h	
	push dx
	sub dx,80
	int 10h	
	pop dx
	dec cx
	cmp cx,word[comp]	
	jne linha

	ret
deck:
	
	c1: ;coluna 1
	cmp word[setaX],250
	jne c2
	c1l1: ;coluna 1 linha 1
	cmp word[setaY],160
	jne c1l2
	mov al,byte[pos1]
	cmp ah,1
	jne end 
	mov byte[pos1],0
	ret
	c1l2:
	cmp word[setaY],240
	jne c1l3
	mov al,byte[pos2]
	cmp ah,1
	jne end 
	mov byte[pos2],0
	ret
	c1l3:
	cmp word[setaY],320
	jne c1l4
	mov al,byte[pos3]
	cmp ah,1
	jne end 
	mov byte[pos3],0
	ret
	c1l4:
	mov al,byte[pos4]
	cmp ah,1
	jne end 
	mov byte[pos4],0

	c2:
	cmp word[setaX],350
	jne c3
	c2l1:
	cmp word[setaY],160
	jne c2l2
	mov al,byte[pos5]
	cmp ah,1
	jne end 
	mov byte[pos5],0
	ret
	c2l2:
	cmp word[setaY],240
	jne c2l3
	mov al,byte[pos6]
	cmp ah,1
	jne end 
	mov byte[pos6],0
	ret
	c2l3:
	cmp word[setaY],320
	jne c2l4
	mov al,byte[pos7]
	cmp ah,1
	jne end 
	mov byte[pos7],0
	ret
	c2l4:
	mov al,byte[pos8]
	cmp ah,1
	jne end 
	mov byte[pos8],0
	ret
	c3:
	cmp word[setaX],450
	jne end
	c3l1:
	cmp word[setaY],160
	jne c3l2
	mov al,byte[pos9]
	cmp ah,1
	jne end 
	mov byte[pos9],0
	ret
	c3l2:
	cmp word[setaY],240
	jne c3l3
	mov al,byte[pos10]
	cmp ah,1
	jne end 
	mov byte[pos10],0
	ret
	c3l3:
	cmp word[setaY],320
	jne c3l4
	mov al,byte[pos11]
	cmp ah,1
	jne end 
	mov byte[pos11],0
	ret
	c3l4:
	mov al,byte[pos12]
	cmp ah,1
	jne end 
	mov byte[pos12],0
	end:
	ret

game:

	mov ah, 0
    mov al, 12h;"limpa" a tela e a transforma em branco
    int 10h
    mov ah, 0bh
    mov bx, 8
    int 10h

    mov al,0xf
    call tabuleiro
    mov cx,250
	mov dx,160
	call card
	mov cx,350
	mov dx,160
	call card
	mov cx,450
	mov dx,160
	call card
	mov cx,250
	mov dx,240
	call card
	mov cx,350
	mov dx,240
	call card
	mov cx,450
	mov dx,240
	call card
	mov cx,250
	mov dx,320
	call card
	mov cx,350
	mov dx,320
	call card
	mov cx,450
	mov dx,320
	call card
	mov cx,250
	mov dx,400
	call card
	mov cx,350
	mov dx,400
	call card
	mov cx,450
	mov dx,400
	call card
	
   	mov cx,word[setaX]
	mov dx,word[setaY]
	mov al,0xf
	call SetaC

	mov ah, 02h;seta o cursor
    mov bh, 0
  	mov dh, 27
  	mov dl, 13
  	int 10h
  	mov si,pontuacao
  	mov bl, 0xf
  	call printStr

  	mov ah, 02h;seta o cursor
    mov bh, 0
  	mov dh, 27
  	mov dl, 50
  	int 10h
  	mov si,vidas 
  	mov bl, 0xf
  	call printStr
    	
    jogada:
      	
    	mov ah, 02h;setando o cursor
	    mov bh, 0
	    mov dh, 27
	    mov dl, 21
	    int 10h
	    mov al, byte[ponto]
	    mov ah, 0xe
	    mov bl,0xf
	    int 10h
	    cmp byte[ponto],"6"
    	je endWin
    	cmp byte[vida],"0"
    	je endLose 
    	mov ah, 02h;setando o cursor
	    mov bh, 0
	    mov dh, 27
	    mov dl, 58
	    int 10h
	    
	    mov al, byte[vida]
	    mov ah, 0xe
	    mov bl,0xf
	    int 10h

    	mov ah, 0
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
			cmp word[setaX],250
			je jogada

			mov al,2
			call SetaC
			sub word[setaX],100
			mov cx,word[setaX]
			mov dx,word[setaY]
			mov al,0xf
			call SetaC
    	jmp jogada

    	.right:
    		mov cx,word[setaX]
			mov dx,word[setaY]
			cmp word[setaX],450
			je jogada

			mov al,2
			call SetaC
			add word[setaX],100
			mov cx,word[setaX]
			mov dx,word[setaY]
			mov al,0xf
			call SetaC
    	jmp jogada
    	.hack:
    		mov byte[hack],1
    	jmp jogada
    	.up:
    		mov cx,word[setaX]
			mov dx,word[setaY]
			cmp word[setaY],160
			je jogada
			
			mov al,2
			call SetaC
			sub word[setaY],80
			mov cx,word[setaX]
			mov dx,word[setaY]
			mov al,0xf
			call SetaC
    	jmp jogada

    	.down:
    		mov cx,word[setaX]
			mov dx,word[setaY]
			cmp word[setaY],400
			je jogada
			
			mov al,2
			call SetaC
			add word[setaY],80
			mov cx,word[setaX]
			mov dx,word[setaY]
			mov al,0xf
			call SetaC
    	jmp jogada
		.card:
			mov cx,word[setaX]
			mov dx,word[setaY]
			call deck
			cmp al,0
			je jogada
			call card
			cmp byte[carta1],0
			je keepGoing
				cmp byte[hack],1
				je jogada
				cmp cx,word[posiCX1]
				jne ok 
				cmp dx,word[posiCY1]
				je jogada 
				ok:
				cmp byte[carta1],al	
					jne Nigual
					mov ah,1
					call deck
					mov cx,word[setaX]
					mov dx,word[setaY]
					push cx
					push dx
					push bx
					mov bx,word[posiCX1]
					mov word[setaX],bx
					mov bx,word[posiCY1]
					mov word[setaY],bx
					pop bx
					mov ah,1
					call deck
					mov ah,0
					pop dx
					pop cx
					add byte[ponto],1
					mov word[setaX],cx
					mov word[setaY],dx
					mov byte[carta1],0
				jmp jogada
				Nigual:
					sub byte[vida],1
				    mov al,2
				    mov cx,word[setaX]
					mov dx,word[setaY]
					call card
					mov cx,word[posiCX1]
					mov dx,word[posiCY1]
					mov byte[carta1],0
					call card
				jmp jogada
			keepGoing:
			push dx
			mov byte[carta1],al
			mov dx,word[setaY]
			mov word[posiCY1],dx
			mov dx,word[setaX]
			mov word[posiCX1],dx
			pop dx
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
    ret
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
  	ret
	endJogada:
ret
start:
    xor ax, ax
    mov ds, ax
    mov es, ax
   	call inicio_abertura 
    call movimentacao_menu
    cmp cl, 0
    jne done
    call guia_fun
    
done:
	call game
    jmp $
