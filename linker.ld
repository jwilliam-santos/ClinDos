OUTPUT_FORMAT(elf64-x86-64)
ENTRY(entry)

SECTIONS
{
    . = 0x1000;

    .text :
    {
        *(.text*)
    }

    .rodata :
    {
        *(.rodata*)
    }

    .data :
    {
        *(.data*)
    }

    .bss :
    {
        __bss_start = .;
        *(.bss*)
        *(COMMON)
        __bss_end = .;
    }

    /* Endereço físico fixo da IDT (ainda não alocada como seção real) */
    __idt_start__ = 0xF000;
}
