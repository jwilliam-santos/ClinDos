
ASM = nasm
CC  = gcc
LD  = gcc


CFLAGS = -m64 -ffreestanding -O2 -Wall -Wextra -fno-pie -mno-red-zone -Iinclude -MMD -MP
LDFLAGS = -T linker.ld -ffreestanding -O2 -nostdlib -no-pie

BUILD = build
KERNEL = $(BUILD)/clin-dos.bin
ISO = $(BUILD)/ClinDos.iso


C_SOURCES = $(wildcard kernel/*.c)
C_OBJECTS = $(patsubst kernel/%.c,$(BUILD)/%.o,$(C_SOURCES))

ASM_SOURCES = $(wildcard kernel/*.asm)
ASM_OBJECTS = $(patsubst kernel/%.asm,$(BUILD)/%.o,$(ASM_SOURCES))

OBJECTS = $(ASM_OBJECTS) $(C_OBJECTS)


all: $(ISO)


$(BUILD)/%.o: kernel/%.c
	mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@


$(BUILD)/%.o: kernel/%.asm
	mkdir -p $(BUILD)
	$(ASM) -f elf64 $< -o $@


$(KERNEL): $(OBJECTS) linker.ld
	mkdir -p $(BUILD)
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)


$(ISO): $(KERNEL) boot/grub/grub.cfg
	mkdir -p $(BUILD)/iso/boot/grub
	cp $(KERNEL) $(BUILD)/iso/boot/clin-dos.bin
	cp boot/grub/grub.cfg $(BUILD)/iso/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO) $(BUILD)/iso


QEMU = /mnt/c/Program\Files/qemu/qemu-system-x86_64.exe

run: $(ISO)
	$(QEMU) -cdrom $(ISO)


clean:
	rm -rf $(BUILD)


-include $(C_OBJECTS:.o=.d)