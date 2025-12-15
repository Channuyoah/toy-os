; toy-os
; TAB=4
; boot.asm
BITS 16
ORG 0x7C00

    jmp short start
    nop

; ===== FAT12 BPB =====
OEMLabel        db 'TOYOS   '     ; 8 bytes
BytesPerSector dw 512
SectorsPerClus db 1
ReservedSectors dw 1
NumFATs        db 2
RootEntries    dw 224
TotalSectors16 dw 2880
Media          db 0xF0
SectorsPerFAT  dw 9
SectorsPerTrack dw 18
NumHeads       dw 2
HiddenSectors  dd 0
TotalSectors32 dd 0

DriveNumber    db 0
Reserved1      db 0
BootSignature  db 0x29
VolumeID       dd 0x12345678
VolumeLabel    db 'TOYOS      '   ; 11 bytes
FileSystem     db 'FAT12   '      ; 8 bytes
; ====================

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    ; BIOS会把启动驱动器号放在DL
    mov [boot_drive], dl

    ; 调试：证明 boot 在跑
    mov ah, 0x0e
    mov al, 'B'
    int 0x10

    ; 先设置ES
    mov ax, 0x1000 
    mov es, ax             ; loader -> 0x10000
    mov bx, 0x0000

    ; 再准备int 13参数 读 loader（假设 1 扇区）
    mov ah, 0x02
    mov al, 1              ; 扇区数
    mov ch, 0
    mov cl, 2              ; 从第 2 个扇区开始
    mov dh, 0
    mov dl, [boot_drive]

    int 0x13
    jc disk_error

    ; 调试：证明 boot 成功读取内存
    mov ah, 0x0e
    mov al, 'R'
    int 0x10

    ; 跳转到 loader
    jmp 0x1000:0x0000

disk_error:
    mov al, 'A'
    int 0x10
    jmp $

boot_drive db 0

times 510-($-$$) db 0
dw 0xAA55
