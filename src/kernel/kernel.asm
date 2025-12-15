; kernel.asm
BITS 16
ORG 0x0000

mov ah, 0x0e
mov al, 'K'
int 0x10

jmp $

