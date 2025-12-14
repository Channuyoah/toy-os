; toy-os
; TAB=4

ORG   0x7c00        ;指明程序的装载地址
JMP   short entry
NOP

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

; 程序核心
entry:
    XOR   AX,AX        ;初始化寄存器
    MOV   DS,AX
    MOV   ES,AX
    MOV   SS,AX
    MOV   SP,0x7c00

    MOV   SI,msg
putloop:
    MOV   AL,[SI]
    INC   SI
    CMP   AL,0
    JE    fin

    MOV   AH,0x0e     ; 显示一个文字
    MOV   BX,0x000f      ; 指定字符颜色
    INT   0x10        ; 调用显卡BIOS
    JMP   putloop
fin:
    HLT               ; 让CPU停止 (等待指令)
    JMP   fin         ; 无限循环

msg:
    DB    0x0a,0x0a   ; 换行2次
    DB    "Hello, World!"
    DB    0x0a        ; 换行
    DB    0

times 510-($-$$) db 0
dw  0xaa55
