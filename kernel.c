#include "include/vga.h"




void kernel() {
    vga_print("Hello World, ClinDos x86_64!");

    while (1) {
        __asm__ volatile ("hlt");
    }
}
