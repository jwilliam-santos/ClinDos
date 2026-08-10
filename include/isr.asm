[BITS 32]

; ============================================================
; EXCEÇÕES DA CPU
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


; ============================================================
; MACROS
; ============================================================

; Exceção SEM error code
;
; A CPU não colocou error code na stack.
; Então colocamos um artificial para padronizar.
;
%macro ISR_NO_ERROR 2

global isr%1

isr%1:
    push dword 0
    pushad

    call %2

    popad
    add esp, 4
    iret

%endmacro


; Exceção COM error code
;
; A CPU já colocou o error code na stack.
;
%macro ISR_ERROR 2

global isr%1

isr%1:
    pushad

    call %2

    popad
    add esp, 4
    iret

%endmacro


; ============================================================
; CPU EXCEPTIONS
; ============================================================

; 0  - Division Error
ISR_NO_ERROR 0, division_error_handler

; 1  - Debug
ISR_NO_ERROR 1, debug_handler

; 2  - NMI
ISR_NO_ERROR 2, nmi_handler

; 3  - Breakpoint
ISR_NO_ERROR 3, breakpoint_handler

; 4  - Overflow
ISR_NO_ERROR 4, overflow_handler

; 5  - Bound Range Exceeded
ISR_NO_ERROR 5, bound_range_handler

; 6  - Invalid Opcode
ISR_NO_ERROR 6, invalid_opcode_handler

; 7  - Device Not Available
ISR_NO_ERROR 7, device_not_available_handler

; 8  - Double Fault
ISR_ERROR 8, double_fault_handler

; 9  - Coprocessor Segment Overrun
ISR_NO_ERROR 9, coprocessor_segment_handler

; 10 - Invalid TSS
ISR_ERROR 10, invalid_tss_handler

; 11 - Segment Not Present
ISR_ERROR 11, segment_not_present_handler

; 12 - Stack-Segment Fault
ISR_ERROR 12, stack_segment_handler

; 13 - General Protection Fault
ISR_ERROR 13, gpf_handler

; 14 - Page Fault
ISR_ERROR 14, page_fault_handler

; 15 - Reserved
ISR_NO_ERROR 15, reserved15_handler

; 16 - x87 Floating-Point
ISR_NO_ERROR 16, x87_handler

; 17 - Alignment Check
ISR_ERROR 17, alignment_check_handler

; 18 - Machine Check
ISR_NO_ERROR 18, machine_check_handler

; 19 - SIMD Floating-Point
ISR_NO_ERROR 19, simd_handler

; 20 - Virtualization
ISR_NO_ERROR 20, virtualization_handler

; 21 - Control Protection
ISR_ERROR 21, control_protection_handler

; 22 - Reserved
ISR_NO_ERROR 22, reserved22_handler

; 23 - Reserved
ISR_NO_ERROR 23, reserved23_handler

; 24 - Reserved
ISR_NO_ERROR 24, reserved24_handler

; 25 - Reserved
ISR_NO_ERROR 25, reserved25_handler

; 26 - Reserved
ISR_NO_ERROR 26, reserved26_handler

; 27 - Reserved
ISR_NO_ERROR 27, reserved27_handler

; 28 - Hypervisor Injection
ISR_NO_ERROR 28, hypervisor_handler

; 29 - VMM Communication
ISR_ERROR 29, vmm_communication_handler

; 30 - Security Exception
ISR_ERROR 30, security_handler

; 31 - Reserved
ISR_NO_ERROR 31, reserved31_handler


; ============================================================
; HARDWARE IRQs
; IRQ 0-15 -> IDT 32-47
; ============================================================

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


%macro IRQ 2

global irq%1

irq%1:
    pushad

    call %2

    popad
    iret

%endmacro


; IRQ 0 -> IDT 32
IRQ 0, timer_handler

; IRQ 1 -> IDT 33
IRQ 1, keyboard_handler

; IRQ 2 -> IDT 34
IRQ 2, irq2_handler

; IRQ 3 -> IDT 35
IRQ 3, irq3_handler

; IRQ 4 -> IDT 36
IRQ 4, irq4_handler

; IRQ 5 -> IDT 37
IRQ 5, irq5_handler

; IRQ 6 -> IDT 38
IRQ 6, irq6_handler

; IRQ 7 -> IDT 39
IRQ 7, irq7_handler

; IRQ 8 -> IDT 40
IRQ 8, rtc_handler

; IRQ 9 -> IDT 41
IRQ 9, irq9_handler

; IRQ 10 -> IDT 42
IRQ 10, irq10_handler

; IRQ 11 -> IDT 43
IRQ 11, irq11_handler

; IRQ 12 -> IDT 44
IRQ 12, mouse_handler

; IRQ 13 -> IDT 45
IRQ 13, fpu_handler

; IRQ 14 -> IDT 46
IRQ 14, primary_ata_handler

; IRQ 15 -> IDT 47
IRQ 15, secondary_ata_handler