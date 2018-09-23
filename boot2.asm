org 0x500
jmp 0x0000:start

msg1 db '> Loading structures for the kernel...', 0Dh, 0x0A, 0
msg2 db '> Setting up protected mode...', 0Dh, 0x0A, 0
msg3 db '> Loading kernel in memory...', 0Dh, 0x0A, 0
msg4 db '> Running kernel...', 0Dh, 0x0A, 0
meme db 'MEME...',0Dh, 0x0A,0

clear:
	mov dx, 0
    mov bh, 0      
    mov ah, 0x2
    int 10h
  
    mov cx, 2000 
    mov bh, 0
    mov al, 0x20 
    mov ah, 0x9
    int 10h
    
ret

temp: 
	mov bp, dx
	temp_:
	dec bp
	nop
	jnz temp_
	dec dx
	cmp dx,0    
	jne temp_
ret

puts:
    lodsb
	cmp al, 0
	je end_puts
    mov dx, 100
    call temp
	mov ah, 0x0e
	int 10h	
    jmp puts

end_puts:
ret

putmeme:
    lodsb
	cmp al, 0
	je end_putmeme
    mov dx, 500
    call temp
	mov ah, 0x0e
	int 10h	
    jmp putmeme

end_putmeme:
ret

putchar:
    mov ah, 0x0e
    int 10h
ret

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
	
    xor ax, ax
    mov ds, ax
    mov es, ax
    xor cx, cx

    mov bl, 3
    call clear

    mov si, msg1
    call puts

    mov si, msg2
    call puts

    mov si, msg3
    call puts

    mov si, msg4
    call puts


    xor cx, cx
    memes:
    mov al, 10
    call putchar
    inc cx
    cmp cx, 0x13
    je end_memes
    jmp memes
    end_memes:
    
    xor cx, cx
    memes_:
        mov al, 0x20
        call putchar
        inc cx
        cmp cx, 0x40
        je end_memes_
        jmp memes_
    end_memes_:

    mov si, meme
    call putmeme

    mov ax, 0x7e0 ;0x7e0<<1 = 0x7e00 (início de kernel.asm)
    mov es, ax
    xor bx, bx    ;posição es<<1+bx

    jmp reset

reset:
    mov ah, 00h ;reseta o controlador de disco
    mov dl, 0   ;floppy disk
    int 13h

    jc reset    ;se o acesso falhar, tenta novamente

    jmp load

load:
    mov ah, 02h ;lê um setor do disco
    mov al, 20  ;quantidade de setores ocupados pelo kernel
    mov ch, 0   ;track 0
    mov cl, 3   ;sector 3
    mov dh, 0   ;head 0
    mov dl, 0   ;drive 0
    int 13h

    jc load     ;se o acesso falhar, tenta novamente

    jmp 0x7e00  ;pula para o setor de endereco 0x7e00 (start do boot2)
