    jmp near start

message db 'KARL '
        db 0       ;本程序的过程规定以0结尾

start:
    mov ax,0x7c0   ;设置数据段的段基地址 
    mov ds,ax

    mov bx,message ;使DS:BX指向字符串
    mov al,0       ;属性初始值

    mov dh,0       ;从0行开始
    mov cx,8       ;循环8次，从0行到7行

put_0_8:         ;----------------------------外层循环

    push cx
    mov dl,0     ;列的初始值
    mov cx,16    ;循环16次，从0列到15列

put_0_F:         ;--------内层循环

    call put_string
    inc al       ;改变属性，属性值增加1
    add dl,5     ;改变列，列值增加5 
    loop put_0_F ;--------内层循环

    pop cx
    inc dh       ;改变行，行增加1  
    loop put_0_8 ;----------------------------外层循环

    jmp near $ 
;-------------------------------------  
;功能：在某位置显示字符串      
;入口参数：
;   AL=属性
;   DH=行
;   DL=列
;   DX:BX=指向字符串,字符串必须以0结尾
;出口参数：无         
put_string:

    push ax
    push bx
    push cx
    push dx
    push di
    push es

    push ax          ;AX中是属性，因为下面要用AX，所以先进栈保护起来
    mov ax,0xb800
    mov es,ax
                     ; x行y列，换算成偏移是：(x*80+y)*2
    mov al,80
    mul dh           ;ax=al*dh (计算出x*80，结果在ax中)
    xor dh,dh        ;dh清零
    add ax,dx        ;计算出(x*80+y)，结果在ax中
    shl ax,1         ;计算出(x*80+y)*2，结果在ax中

    mov di,ax        ;用di保存偏移
    pop ax           ;得到属性
;put_char:
;    mov cl,[bx]      ;取要显示的字符到cl中
;    cmp cl,0         ;和0比较
;    jz end           ;等于0则跳转
;    mov [es:di],cl   ;写字符的ASCII码到显存
;    inc di
;    mov [es:di],al   ;写字符的属性到显存
;    inc di           ;di指向显存中的下一个位置
;    inc bx           ;bx指向下一个字符
;    jmp put_char
 end:   
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax

    ret              ;返回
;-------------------------------------------

times 510-($-$$) db 0
                 db 0x55,0xaa
