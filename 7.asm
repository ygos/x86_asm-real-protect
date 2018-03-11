    mov ax, 0xb800                ;指向文本模式的显存/显示缓冲区
    mov es, ax
    mov bx, 0                     ;递增量
    mov di, bx

    mov cx,25
put_full:
    push cx

    mov cx,40
put_char:
    mov word [es:di], 0x0761
    inc di
    inc di
    loop put_char

	mov cx,40
put_empty:
    inc di
    inc di
	loop put_empty

	pop cx
	loop put_full

infi: jmp near infi          ;无限循环

number db 0,0,0,0,0

times 203 db 0
          db 0x55,0xaa

