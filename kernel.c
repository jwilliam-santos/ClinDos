#include "include/vga.h"
#include "include/idt.h"
volatile char last_key = 0;


extern void idt_init(void);

void kernel() {
    idt_init();
    vga_clear();
    vga_set_color(VGA_WHITE, VGA_BLACK);
    vga_print(">");
    vga_set_color(VGA_LIGHT_GREEN, VGA_BLACK);

    while (1) {
        __asm__ volatile("hlt");
        if (last_key != 0) {
            vga_putchar(last_key);
            last_key = 0;
        }
    }
}
