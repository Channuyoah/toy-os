; loader.asm
BITS 16
ORG 0x0000

start:
    cli
    mov ax, 0x1000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0xFFFE
    sti

    ; 显示 L
    mov ah, 0x0e
    mov al, 'L'
    mov bx, 0x000f
    int 0x10
    
    ; 先设置ES
    mov bx, 0x0000
    mov ax, 0x2000
    mov es, ax             ; kernel -> 0x20000

    ; 读 kernel（假设从 LBA2 开始，2 个扇区）
    mov ah, 0x02
    mov al, 2
    mov ch, 0
    mov cl, 3              ; 第 3 个扇区
    mov dh, 0
    mov dl, 0x00
    int 0x13

    jc disk_error

    ; 跳转 kernel
    jmp 0x2000:0x0000

disk_error:
    mov al, 'E'
    int 0x10
    jmp $

times 512-($-$$) db 0

