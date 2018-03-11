;硬盘主引导扇区代码
    mov ax, 0xb870                ;指向文本模式的显存/显示缓冲区
    mov es,ax
    
    ;显示字符串"hello"
    mov byte [es:0x00], 'h'
    mov byte [es:0x01], 0x87
    mov byte [es:0x02], 'e'
    mov byte [es:0x03], 0x87
    mov byte [es:0x04], 'l'
    mov byte [es:0x05], 0x87
    mov byte [es:0x06], 'l'
    mov byte [es:0x07], 0x87
    mov byte [es:0x08], 'o'
    mov byte [es:0x09], 0x87
    
    mov ax,number           ;取得标号number
    mov bx,10
    
    ;设置数据段的基地址
    mov cx,cs
    mov ds,cx
    
    ;求个位上 的数字
    mov dx,0
    div bx
    mov [0x7c00+number+0x00],dl       ;保存个位上的数字
    
    ;求十位上的数字
    xor dx,dx
    div bx
    mov [0x7c00+number+0x01],dl       ;保存十位上的数字
    
    ;求百位上 的数字
    xor dx,dx
    div bx
    mov [0x7c00+number+0x02],dl       ;保存百位上的数字
    
    ;求千位上的数字
    xor dx,dx
    div bx
    mov [0x7c00+number+0x03],dl       ;保存千位上的数字
    
    ;求万位上的数字
    xor dx,dx
    div bx
    mov [0x7c00+number+0x04],dl       ;保存万位上的数字
    
    ;以下用下进制显示标号的偏移地址
    mov al,[0x7c00+number+0x04]
    add al,0x30
    mov [es:0x1a], al
    mov byte [es:0x1b], 0x04
    
    mov al,[0x7c00+number+0x03]
    add al,0x30
    mov [es:0x1c], al
    mov byte [es:0x1d], 0x04
    
    mov al,[0x7c00+number+0x02]
    add al,0x30
    mov [es:0x1e], al
    mov byte [es:0x1f], 0x04
    
    mov al,[0x7c00+number+0x01]
    add al,0x30
    mov [es:0x20], al
    mov byte [es:0x21], 0x04
    
    mov al,[0x7c00+number+0x00]
    add al,0x30
    mov [es:0x22], al
    mov byte [es:0x23], 0x04
    
    mov byte [es:0x24], 'D'
    mov byte [es:0x25], 0x07

infi: jmp near infi          ;无限循环

number db 0,0,0,0,0

times 203 db 0
          db 0x55,0xaa


