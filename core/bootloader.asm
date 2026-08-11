[BITS 16]
[ORG 0x7C00]

; Quantidade de setores do KERNEL a carregar (LBA lógico 1..N).
; Tem que caber no padding da build/kernel.img (Makefile).
KERNEL_SECTORS  equ 32
KERNEL_LOCATION equ 0x1000
DATA_SEG        equ 0x10
CODE_SEG        equ 0x08
; Geometria usada na conversão LBA→CHS (floppy 1.44M; ok p/ reads pequenos)
SECTORS_PER_TRACK equ 18
HEADS_PER_CYL     equ 2

; BIOS salta para 0x7C00 — a PRIMEIRA instrução precisa ser código válido.
start:
    jmp short boot_main
    nop

boot_drive db 0

boot_main:
    cli
    mov [boot_drive], dl

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    ; Fast A20
    in al, 0x92
    or al, 00000010b
    out 0x92, al

; Lê o kernel setor a setor via CHS (AH=0x02).
; AH=0x42 (LBA) falha em floppy no SeaBIOS — por isso não usamos aqui.
load_kernel:
    mov bx, KERNEL_LOCATION
    mov cx, KERNEL_SECTORS
    mov si, 1                     ; LBA atual (0 = bootloader)

.read_sector:
    push cx
    push bx

    mov ax, si
    xor dx, dx
    mov di, SECTORS_PER_TRACK
    div di                        ; AX = LBA/18, DX = LBA%18
    mov cl, dl
    inc cl                        ; sector (1..18)
    xor dx, dx
    mov di, HEADS_PER_CYL
    div di                        ; AX = cylinder, DX = head
    mov ch, al
    mov dh, dl
    mov dl, [boot_drive]

    pop bx
    push bx
    mov ax, 0x0201                ; ler 1 setor
    int 0x13
    jc load_kernel_error

    pop bx
    add bx, 512
    inc si
    pop cx
    loop .read_sector

    cli
    lgdt [gdt_descriptor]

    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODE_SEG:protected_mode_entry

gdt_start:
    dq 0

gdt_code:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00

gdt_data:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

; ---------------------------------------------------------------------------
; Protected mode 32-bit. Long mode (64-bit) é ativado em core/kernel_entry.asm.
; ---------------------------------------------------------------------------
[BITS 32]
protected_mode_entry:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov esp, 0x90000
    jmp KERNEL_LOCATION

[BITS 16]
load_kernel_error:
    mov ah, 0x0E
    mov al, '1'
    int 0x10
    jmp $

times 510 - ($ - $$) db 0
dw 0xAA55
