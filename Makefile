CC      = gcc
LD      = ld
AS      = nasm
OBJCOPY = objcopy

CFLAGS = -m64 -ffreestanding -fno-pic -fno-pie -fno-stack-protector \
         -nostdlib -nostartfiles -fno-asynchronous-unwind-tables -c

LDFLAGS = -m elf_x86_64 -T linker.ld -nostdlib -z max-page-size=0x1000

BUILD = build
INCLUDE = include

# Deve coincidir com KERNEL_SECTORS em core/bootloader.asm
KERNEL_SECTORS = 32

BOOTLOADER = core/bootloader.asm
KENTRY	   = core/kernel_entry.asm
KERNEL	   = kernel.c

CFILES   := $(wildcard include/*.c)
ASMFILES := $(wildcard include/*.asm)

OBJS_C   := $(patsubst include/%.c,$(BUILD)/%.o,$(CFILES))
OBJS_ASM := $(patsubst include/%.asm,$(BUILD)/%.o,$(ASMFILES))

all: compile

compile: $(BUILD)/kernel.img

$(BUILD):
	mkdir -p $(BUILD)

# Core
$(BUILD)/bootloader.bin: $(BOOTLOADER) | $(BUILD)
	$(AS) -f bin $< -o $@

$(BUILD)/kernel_entry.o: $(KENTRY) | $(BUILD)
	$(AS) -f elf64 $< -o $@

# Kernel
$(BUILD)/kernel.o: $(KERNEL) | $(BUILD)
	$(CC) $(CFLAGS) $< -o $@

# Other dependencies
$(BUILD)/%.o: include/%.c | $(BUILD)
	$(CC) $(CFLAGS) $< -o $@

$(BUILD)/%.o: include/%.asm | $(BUILD)
	$(AS) -f elf64 $< -o $@

# Mounting IMG
$(BUILD)/kernel.elf: $(BUILD)/kernel_entry.o $(BUILD)/kernel.o $(OBJS_C) $(OBJS_ASM)
	$(LD) $(LDFLAGS) $^ -o $@

$(BUILD)/kernel.bin: $(BUILD)/kernel.elf
	$(OBJCOPY) -O binary $< $@

$(BUILD)/kernel.img: $(BUILD)/bootloader.bin $(BUILD)/kernel.bin
	cat $^ > $@
	@# Imagem de floppy 1.44MiB (CHS/AH=0x02 no bootloader)
	truncate -s 1474560 $@

run: $(BUILD)/kernel.img
	qemu-system-x86_64 -machine pc -cpu qemu64 \
		-drive format=raw,file=$<,if=floppy -boot a

clean:
	rm -rf $(BUILD)
