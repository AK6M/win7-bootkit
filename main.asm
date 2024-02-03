use16   ; FASM option. Compile in .bin file

org 0x7c00 ; MBR address at memory

mov ax, cx

cli ; interrupt off

mov ss, ax
mov es, ax
mov ds, ax

sti ; interrupt

mov ax, 03

int 0x10

mov ah, 0x13    ; Cursor position 

xor al, al

mov bx, 00001111b   ; Text color

xor dx, dx 

mov cx, boot-msg

call boot

msg db "[Error | try agin | TM|rev3rse_enginer]"

boot:

pop bp  ; Save stack

int 0x10    ; BIOS interrupt

jmp $ ; Create loop

times 510-($-$$) db 0 ; Get null bytes, because  original MBR = 512 bytes [GENERAL PART]{446 bytes} + [Partition Table]{4 sectors - 16 bytes -> 16 * 4 - 64 } + {Signature}{2 bytes}

dw 0xAA55 ; 2 MBR bytes 