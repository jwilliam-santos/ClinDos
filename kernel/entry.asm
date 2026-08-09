BITS 32

section .multiboot
align 8
multiboot_header:
    dd 0xE85250D6                           
    dd 0                                    
    dd multiboot_header_end - multiboot_header ;
    dd 0x100000000 - (0xE85250D6 + 0 + (multiboot_header_end - multiboot_header))

    ; End tag
    dw 0
    dw 0
    dd 8
multiboot_header_end:


section .rodata
align 8
gdt64:
    dq 0 
.code_segment: equ $ - gdt64

    dq (1 << 43) | (1 << 44) | (1 << 47) | (1 << 53)
.pointer:
    dw $ - gdt64 - 1 
    dq gdt64        


section .bss
align 4096
; 
boot_pml4: resb 4096
boot_pdpt: resb 4096
boot_pdt:  resb 4096

align 16
stack_bottom:
    resb 16384 ; 16 KB de stack
stack_top:

;
; ENTRY POINT (32-BITS)
;
section .text
global _start
extern main

_start:
    cli                     ; Desabilita interrupções
    mov esp, stack_top      ; Configura a stack

  
    mov eax, boot_pdpt
    or eax, 0b11            
    mov [boot_pml4], eax

  
    mov eax, boot_pdt
    or eax, 0b11            ; 
    mov [boot_pdpt], eax

    ; (Mapeia 1GB de RAM)
    mov ecx, 0              
.map_pdt:
    mov eax, 0x200000       ;  2MB
    mul ecx               
    or eax, 0b10000011      
    mov [boot_pdt + ecx * 8], eax
    inc ecx
    cmp ecx, 512
    jne .map_pdt
)
    mov eax, boot_pml4
    mov cr3, eax

    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax

    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8
    wrmsr

    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax

 
    lgdt [gdt64.pointer]

    jmp gdt64.code_segment:long_mode_start

; LONG MODE (64-BITS)

BITS 64
long_mode_start:
    
    mov ax, 0
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

   
    call main

.hang:
    cli
    hlt
    jmp .hang