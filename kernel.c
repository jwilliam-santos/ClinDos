#include "include/vga.h"
#include "include/idt.h"
volatile char last_key = 0;


void kernel() {
    vga_print("Hello World, ClinDos x86_64!");
   

    while(1){
            if (last_key != 0) {
            vga_putchar(last_key);
            last_key = 0;
        }

    }
 
}
