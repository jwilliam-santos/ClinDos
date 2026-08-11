#include "idt.h"
extern volatile char last_key;
const char scancode_ascii[128] = {
    0,    27,  '1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9',  '0',  '-',  '=',  // 0x00 - 0x0E
  '\\',  'q',  'w',  'e',  'r',  't',  'y',  'u',  'i',  'o',  'p',  '[',  ']',  // 0x0F - 0x1C
     0,  'a',  's',  'd',  'f',  'g',  'h',  'j',  'k',  'l',  ';', '\'',  '`',        // 0x1D - 0x29
     0,   'z',  'x',  'c',  'v',  'b',  'n',  'm',  ',',  '.',  '/',    0,        // 0x2A - 0x35
   '*',    0,  ' '                                                                      // 0x36 - 0x39
};
/*EXCEÇÕES DA CPU*/
void division_error_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 0: Division Error");

    asm("cli");
    asm("hlt");
}


void debug_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 1: Debug");

    asm("cli");
    asm("hlt");
}


void nmi_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 2: Non-Maskable Interrupt");

    asm("cli");
    asm("hlt");
}


void breakpoint_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 3: Breakpoint");

    asm("cli");
    asm("hlt");
}


void overflow_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 4: Overflow");

    asm("cli");
    asm("hlt");
}


void bound_range_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 5: Bound Range Exceeded");

    asm("cli");
    asm("hlt");
}


void invalid_opcode_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 6: Invalid Opcode");

    asm("cli");
    asm("hlt");
}


void device_not_available_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 7: Device Not Available");

    asm("cli");
    asm("hlt");
}


void double_fault_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 8: Double Fault");

    asm("cli");
    asm("hlt");
}


void coprocessor_segment_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 9: Coprocessor Segment Overrun");

    asm("cli");
    asm("hlt");
}


void invalid_tss_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 10: Invalid TSS");

    asm("cli");
    asm("hlt");
}


void segment_not_present_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 11: Segment Not Present");

    asm("cli");
    asm("hlt");
}


void stack_segment_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 12: Stack-Segment Fault");

    asm("cli");
    asm("hlt");
}


void gpf_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 13: General Protection Fault");

    asm("cli");
    asm("hlt");
}


void page_fault_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 14: Page Fault");

    asm("cli");
    asm("hlt");
}


void reserved15_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 15: Reserved");

    asm("cli");
    asm("hlt");
}


void x87_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 16: x87 Floating-Point");

    asm("cli");
    asm("hlt");
}


void alignment_check_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 17: Alignment Check");

    asm("cli");
    asm("hlt");
}


void machine_check_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 18: Machine Check");

    asm("cli");
    asm("hlt");
}


void simd_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 19: SIMD Floating-Point");

    asm("cli");
    asm("hlt");
}


void virtualization_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 20: Virtualization Exception");

    asm("cli");
    asm("hlt");
}


void control_protection_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 21: Control Protection");

    asm("cli");
    asm("hlt");
}


void reserved22_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 22: Reserved");

    asm("cli");
    asm("hlt");
}


void reserved23_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 23: Reserved");

    asm("cli");
    asm("hlt");
}


void reserved24_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 24: Reserved");

    asm("cli");
    asm("hlt");
}


void reserved25_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 25: Reserved");

    asm("cli");
    asm("hlt");
}


void reserved26_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 26: Reserved");

    asm("cli");
    asm("hlt");
}


void reserved27_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 27: Reserved");

    asm("cli");
    asm("hlt");
}


void hypervisor_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 28: Hypervisor Injection");

    asm("cli");
    asm("hlt");
}


void vmm_communication_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 29: VMM Communication");

    asm("cli");
    asm("hlt");
}


void security_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 30: Security Exception");

    asm("cli");
    asm("hlt");
}


void reserved31_handler()
{
    vga_set_color(VGA_LIGHT_RED, VGA_BLACK);
    vga_print("EXCEPTION 31: Reserved");

    asm("cli");
    asm("hlt");
}


// ============================================================
// IRQs
// ============================================================

void timer_handler()
{
    // IRQ 0
}

// Altere de void para char
void  keyboard_handler(const unsigned char scancode){
    if (scancode < sizeof(scancode_ascii)) {
        last_key = scancode_ascii[scancode];
    }


    

}



void irq2_handler()
{
    // IRQ 2
}


void irq3_handler()
{
    // IRQ 3
}


void irq4_handler()
{
    // IRQ 4
}


void irq5_handler()
{
    // IRQ 5
}


void irq6_handler()
{
    // IRQ 6
}


void irq7_handler()
{
    // IRQ 7
}


void rtc_handler()
{
    // IRQ 8
}


void irq9_handler()
{
    // IRQ 9
}


void irq10_handler()
{
    // IRQ 10
}


void irq11_handler()
{
    // IRQ 11
}


void mouse_handler()
{
    // IRQ 12
}


void fpu_handler()
{
    // IRQ 13
}


void primary_ata_handler()
{
    // IRQ 14
}


void secondary_ata_handler()
{
    // IRQ 15
}
