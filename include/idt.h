#ifndef IDT_H
#define IDT_H

#include "utypes.h"
#include "vga.h"
extern void load_IDT(void);
extern void set_idt_entry(void *isr, uint8_t flags, uint8_t index);

// ==============================
// Exceções da CPU (0 - 31)
// ==============================

extern void isr0(void);   // #DE - Division Error
extern void isr1(void);   // #DB - Debug
extern void isr2(void);   // NMI
extern void isr3(void);   // #BP - Breakpoint
extern void isr4(void);   // #OF - Overflow
extern void isr5(void);   // #BR - Bound Range Exceeded
extern void isr6(void);   // #UD - Invalid Opcode
extern void isr7(void);   // #NM - Device Not Available
extern void isr8(void);   // #DF - Double Fault
extern void isr9(void);   // Coprocessor Segment Overrun
extern void isr10(void);  // #TS - Invalid TSS
extern void isr11(void);  // #NP - Segment Not Present
extern void isr12(void);  // #SS - Stack-Segment Fault
extern void isr13(void);  // #GP - General Protection Fault
extern void isr14(void);  // #PF - Page Fault
extern void isr15(void);  // Reserved
extern void isr16(void);  // #MF - x87 Floating-Point Exception
extern void isr17(void);  // #AC - Alignment Check
extern void isr18(void);  // #MC - Machine Check
extern void isr19(void);  // #XM/#XF - SIMD Floating-Point
extern void isr20(void);  // #VE - Virtualization Exception
extern void isr21(void);  // #CP - Control Protection Exception
extern void isr22(void);  // Reserved
extern void isr23(void);  // Reserved
extern void isr24(void);  // Reserved
extern void isr25(void);  // Reserved
extern void isr26(void);  // Reserved
extern void isr27(void);  // Reserved
extern void isr28(void);  // #HV - Hypervisor Injection Exception
extern void isr29(void);  // #VC - VMM Communication Exception
extern void isr30(void);  // #SX - Security Exception
extern void isr31(void);  // Reserved


// ==============================
// Interrupções de Hardware / IRQ
// 32 - 47
// ==============================

extern void irq0(void);   // Timer
extern void irq1(void);   // Teclado
extern void irq2(void);
extern void irq3(void);
extern void irq4(void);
extern void irq5(void);
extern void irq6(void);
extern void irq7(void);
extern void irq8(void);
extern void irq9(void);
extern void irq10(void);
extern void irq11(void);
extern void irq12(void);
extern void irq13(void);
extern void irq14(void);
extern void irq15(void);
// ==============================
// Exceções da CPU
// ==============================

void division_error_handler(void);
void debug_handler(void);
void nmi_handler(void);
void breakpoint_handler(void);
void overflow_handler(void);
void bound_range_handler(void);
void invalid_opcode_handler(void);
void device_not_available_handler(void);
void double_fault_handler(void);
void coprocessor_segment_handler(void);
void invalid_tss_handler(void);
void segment_not_present_handler(void);
void stack_segment_handler(void);
void gpf_handler(void);
void page_fault_handler(void);
void reserved15_handler(void);
void x87_handler(void);
void alignment_check_handler(void);
void machine_check_handler(void);
void simd_handler(void);
void virtualization_handler(void);
void control_protection_handler(void);
void reserved22_handler(void);
void reserved23_handler(void);
void reserved24_handler(void);
void reserved25_handler(void);
void reserved26_handler(void);
void reserved27_handler(void);
void hypervisor_handler(void);
void vmm_communication_handler(void);
void security_handler(void);
void reserved31_handler(void);


// ==============================
// IRQs
// ==============================

void timer_handler(void);
void keyboard_handler(void);
void irq2_handler(void);
void irq3_handler(void);
void irq4_handler(void);
void irq5_handler(void);
void irq6_handler(void);
void irq7_handler(void);
void rtc_handler(void);
void irq9_handler(void);
void irq10_handler(void);
void irq11_handler(void);
void mouse_handler(void);
void fpu_handler(void);
void primary_ata_handler(void);
void secondary_ata_handler(void);
// ==============================
// Exceções da CPU
// ==============================

void division_error_handler(void);
void debug_handler(void);
void nmi_handler(void);
void breakpoint_handler(void);
void overflow_handler(void);
void bound_range_handler(void);
void invalid_opcode_handler(void);
void device_not_available_handler(void);
void double_fault_handler(void);
void coprocessor_segment_handler(void);
void invalid_tss_handler(void);
void segment_not_present_handler(void);
void stack_segment_handler(void);
void gpf_handler(void);
void page_fault_handler(void);
void reserved15_handler(void);
void x87_handler(void);
void alignment_check_handler(void);
void machine_check_handler(void);
void simd_handler(void);
void virtualization_handler(void);
void control_protection_handler(void);
void reserved22_handler(void);
void reserved23_handler(void);
void reserved24_handler(void);
void reserved25_handler(void);
void reserved26_handler(void);
void reserved27_handler(void);
void hypervisor_handler(void);
void vmm_communication_handler(void);
void security_handler(void);
void reserved31_handler(void);


// ==============================
// IRQs
// ==============================

void timer_handler(void);
void keyboard_handler(void);
void irq2_handler(void);
void irq3_handler(void);
void irq4_handler(void);
void irq5_handler(void);
void irq6_handler(void);
void irq7_handler(void);
void rtc_handler(void);
void irq9_handler(void);
void irq10_handler(void);
void irq11_handler(void);
void mouse_handler(void);
void fpu_handler(void);
void primary_ata_handler(void);
void secondary_ata_handler(void);
#endif