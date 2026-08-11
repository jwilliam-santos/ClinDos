[BITS 64]

; ============================================================
; EXCEÇÕES DA CPU + IRQs (long mode)
; Sem pushad; retorno com iretq.
; ============================================================

extern division_error_handler
extern debug_handler
extern nmi_handler
extern breakpoint_handler
extern overflow_handler
extern bound_range_handler
extern invalid_opcode_handler
extern device_not_available_handler
extern double_fault_handler
extern coprocessor_segment_handler
extern invalid_tss_handler
extern segment_not_present_handler
extern stack_segment_handler
extern gpf_handler
extern page_fault_handler
extern reserved15_handler
extern x87_handler
extern alignment_check_handler
extern machine_check_handler
extern simd_handler
extern virtualization_handler
extern control_protection_handler
extern reserved22_handler
extern reserved23_handler
extern reserved24_handler
extern reserved25_handler
extern reserved26_handler
extern reserved27_handler
extern hypervisor_handler
extern vmm_communication_handler
extern security_handler
extern reserved31_handler

extern timer_handler
extern keyboard_handler
extern irq2_handler
extern irq3_handler
extern irq4_handler
extern irq5_handler
extern irq6_handler
extern irq7_handler
extern rtc_handler
extern irq9_handler
extern irq10_handler
extern irq11_handler
extern mouse_handler
extern fpu_handler
extern primary_ata_handler
extern secondary_ata_handler

; Salva registradores caller-saved / usados pelo handler
%macro PUSH_REGS 0
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push rbp
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
%endmacro

%macro POP_REGS 0
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rbp
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
%endmacro

; Exceção SEM error code — empilha 0 para alinhar a stack
%macro ISR_NO_ERROR 2
global isr%1
isr%1:
    push qword 0
    PUSH_REGS
    cld
    call %2
    POP_REGS
    add rsp, 8
    iretq
%endmacro

; Exceção COM error code (CPU já empilhou)
%macro ISR_ERROR 2
global isr%1
isr%1:
    PUSH_REGS
    cld
    call %2
    POP_REGS
    add rsp, 8
    iretq
%endmacro

%macro IRQ 2
global irq%1
irq%1:
    PUSH_REGS
    cld
    call %2
    POP_REGS
    iretq
%endmacro

; ---- CPU exceptions 0-31 ----
ISR_NO_ERROR 0,  division_error_handler
ISR_NO_ERROR 1,  debug_handler
ISR_NO_ERROR 2,  nmi_handler
ISR_NO_ERROR 3,  breakpoint_handler
ISR_NO_ERROR 4,  overflow_handler
ISR_NO_ERROR 5,  bound_range_handler
ISR_NO_ERROR 6,  invalid_opcode_handler
ISR_NO_ERROR 7,  device_not_available_handler
ISR_ERROR    8,  double_fault_handler
ISR_NO_ERROR 9,  coprocessor_segment_handler
ISR_ERROR    10, invalid_tss_handler
ISR_ERROR    11, segment_not_present_handler
ISR_ERROR    12, stack_segment_handler
ISR_ERROR    13, gpf_handler
ISR_ERROR    14, page_fault_handler
ISR_NO_ERROR 15, reserved15_handler
ISR_NO_ERROR 16, x87_handler
ISR_ERROR    17, alignment_check_handler
ISR_NO_ERROR 18, machine_check_handler
ISR_NO_ERROR 19, simd_handler
ISR_NO_ERROR 20, virtualization_handler
ISR_ERROR    21, control_protection_handler
ISR_NO_ERROR 22, reserved22_handler
ISR_NO_ERROR 23, reserved23_handler
ISR_NO_ERROR 24, reserved24_handler
ISR_NO_ERROR 25, reserved25_handler
ISR_NO_ERROR 26, reserved26_handler
ISR_NO_ERROR 27, reserved27_handler
ISR_NO_ERROR 28, hypervisor_handler
ISR_ERROR    29, vmm_communication_handler
ISR_ERROR    30, security_handler
ISR_NO_ERROR 31, reserved31_handler

; ---- Hardware IRQs (IDT 32-47) ----
IRQ 0,  timer_handler
IRQ 1,  keyboard_handler
IRQ 2,  irq2_handler
IRQ 3,  irq3_handler
IRQ 4,  irq4_handler
IRQ 5,  irq5_handler
IRQ 6,  irq6_handler
IRQ 7,  irq7_handler
IRQ 8,  rtc_handler
IRQ 9,  irq9_handler
IRQ 10, irq10_handler
IRQ 11, irq11_handler
IRQ 12, mouse_handler
IRQ 13, fpu_handler
IRQ 14, primary_ata_handler
IRQ 15, secondary_ata_handler

section .note.GNU-stack noalloc noexec nowrite progbits
