org 0x7e00
jmp 0x0000:start

pos1 db '1'
pos2 db '2'
pos3 db '3'
pos4 db '4'
pos5 db '5'
pos6 db '6'
pos7 db '7'
pos8 db '8'
pos9 db '9'
pos10 db '10'
pos11 db '11'
pos12 db '12'
setaX db 7
setaY db 25

abertura1 db 'Memoria Jogo', 0
abertura2 db 'Jogo Da Memoria', 0
abertura3 db 'J  o  a M m  i ', 0
guia db 'Guia Do Jogo', 13
iniciar db 'Iniciar Jogo', 13

explicacao db 'Esse jogo consiste em acertar todos os pares', 13
explicacao2 db ' de cartas iguais utilizando a sua memoria', 13
explicacao3 db ' para isso.', 13
explicacao4 db 'Para escolher uma carta basta clicar em um numero de 1-9', 13
explicacao5 db ' essa ira virar ate que outra seja selecionada.', 13
explicacao6 db 'Voce tem 3 vidas. Boa sorte.', 13
delay:
    mov bp, 350
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
cards:
	mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 25
	int 10h

	mov al,'0'
	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 37
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 49
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 25
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 37
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 49
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 17
	mov dl, 25
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 17
	mov dl, 37
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 17
	mov dl, 49
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 22
	mov dl, 25
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 22
	mov dl, 37
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, 22
	mov dl, 49
	int 10h

	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h
ret
SetaCard:	

	mov ah, 02h
	mov bh, 0
	mov dh, ch
	mov dl, cl
	int 10h

	mov al,'0'
	mov ah, 0xe
	mov bh, 0
	mov bl, 15
	int 10h

	mov ah, 02h
	mov bh, 0
	mov dh, byte[setaX]
	mov dl, byte[setaY]
	int 10h

	mov al,'0'
	mov ah, 0xe
	mov bh, 0
	mov bl, 1
	int 10h

ret
game:
	mov ah, 0
    mov al, 12h;"limpa" a tela e a transforma em branco
    int 10h
    mov ah, 0bh
    mov bx, 12
    int 10h
    call cards ; cartas viradas
    mov ch,byte[setaX]
	mov cl,byte[setaY]
	call SetaCard
    jogada:
    	mov ah, 0
		int 16h
		
		cmp al,'w'
		je .up

		cmp al,'s'
		je .down

		cmp al,'a'
		je .left

		cmp al,'d'
		je .right
		
		.up:
			mov ch,byte[setaX]
			mov cl,byte[setaY]
			cmp byte[setaX],7
			je jogada
			sub byte[setaX],5
			call SetaCard
    	jmp jogada

    	.down:
    		mov ch,byte[setaX]
			mov cl,byte[setaY]
			cmp byte[setaX],22
			je jogada
			add byte[setaX],5
			call SetaCard
    	jmp jogada
    	.left:
    		mov ch,byte[setaX]
			mov cl,byte[setaY]
			cmp byte[setaY],25
			je jogada
			sub byte[setaY],12
			call SetaCard
    	jmp jogada

    	.right:
    		mov ch,byte[setaX]
			mov cl,byte[setaY]
			cmp byte[setaY],49
			je jogada
			add byte[setaY],12
			call SetaCard
    	jmp jogada

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
