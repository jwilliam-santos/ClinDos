; ClinDos kernel entry
; Bootloader chega aqui em 32-bit protected mode (CPU ainda NÃO está em 64-bit).
; Sequência: page tables → PAE → EFER.LME → paging → GDT64 → long mode → C.

[BITS 32]
global entry
extern kernel
extern __bss_start
extern __bss_end

; Page tables em RAM baixa (não colidir com kernel em 0x1000 nem stack 0x90000)
PML4_ADDR equ 0x70000
PDPT_ADDR equ 0x71000
PD_ADDR   equ 0x72000

entry:
    cli

    ; --------------------------------------------------
    ; 1) Zerar PML4, PDPT e PD (3 páginas)
    ; --------------------------------------------------
    mov edi, PML4_ADDR
    xor eax, eax
    mov ecx, (4096 * 3) / 4
    rep stosd

    ; --------------------------------------------------
    ; 2) Identity map dos primeiros 1 GiB com páginas de 2 MiB
    ;    PML4[0] -> PDPT -> PD[0..511]
    ; --------------------------------------------------
    mov eax, PDPT_ADDR | 0x03
    mov dword [PML4_ADDR], eax
    mov dword [PML4_ADDR + 4], 0

    mov eax, PD_ADDR | 0x03
    mov dword [PDPT_ADDR], eax
    mov dword [PDPT_ADDR + 4], 0

    mov edi, PD_ADDR
    mov ebx, 0x00000083                       ; present + writable + PS (2MiB)
    mov ecx, 512
.map_pd:
    mov dword [edi], ebx
    mov dword [edi + 4], 0
    add ebx, 0x200000
    add edi, 8
    loop .map_pd

    ; --------------------------------------------------
    ; 3) CR3 = PML4
    ; --------------------------------------------------
    mov eax, PML4_ADDR
    mov cr3, eax

    ; --------------------------------------------------
    ; 4) Ligar PAE (CR4.bit5)
    ; --------------------------------------------------
    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax

    ; --------------------------------------------------
    ; 5) Ligar Long Mode (EFER.LME, MSR 0xC0000080 bit 8)
    ; --------------------------------------------------
    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8
    wrmsr

    ; --------------------------------------------------
    ; 6) Ligar paging (CR0.PG) → compatibility mode até o far jump
    ; --------------------------------------------------
    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax

    lgdt [gdt64_ptr]
    jmp 0x08:long_mode_entry

; GDT 64-bit: null + code (L=1) + data
align 16
gdt64:
    dq 0
gdt64_code:
    dw 0x0000
    dw 0x0000
    db 0x00
    db 10011010b
    db 00100000b
    db 0x00
gdt64_data:
    dw 0x0000
    dw 0x0000
    db 0x00
    db 10010010b
    db 00000000b
    db 0x00
gdt64_end:

gdt64_ptr:
    dw gdt64_end - gdt64 - 1
    dd gdt64

; ============================================================
[BITS 64]
long_mode_entry:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax

    mov rsp, 0x90000

    ; Zerar BSS (variáveis C não inicializadas)
    mov rdi, __bss_start
    mov rcx, __bss_end
    sub rcx, rdi
    xor eax, eax
    cld
    rep stosb

    call kernel

.hang:
    cli
    hlt
    jmp .hang
