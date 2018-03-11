;---------------------------------------------------
;文件:test.asm
;介绍:一个简单的对VGA写的例子。
;现象:在屏幕上出现绿黑相间的竖直条纹。
;语言:汇编语言，使用nasm汇编器
;作者:北斗星君
;邮箱:huangxiangkui@163.com
;---------------------------------------------------

;通过BIOS设置VGA模式
mov ah,00h
mov al,12h
int 10h


;以下对VGA控制器设置

;将VGA控制器，设置为写模式2
mov dx,3ceh
mov al,5
out dx,al  ;选择 模式选择寄存器 为当前可用寄存器

mov dx,3cfh
mov al,2
out dx,al  ;将模式2设为当前写模式

;对位屏蔽寄存器设置，使传送给0a000h的八个象素中设位1的象素为有效。
mov dx,3ceh
mov al,8
out dx,al  ;选择 位屏蔽寄存器 为当前可用寄存器

mov dx,3cfh
mov al,11111111b  ;让八个象素前四个有效，后四个无效
out dx,al

;对0a000h地址进行操作
;设置初始参数
mov ax,0a000h ;段地址
mov es,ax
mov bx,00000h ;起始偏移
mov al,0eh    ;绿色
mov cx,00fffh ;循环次数

;对内存循环操作写入
jmp re
re:
 mov [es:bx],al
 inc bx
 loop re
