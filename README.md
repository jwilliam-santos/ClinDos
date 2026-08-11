# ClinDos

Kernel x86_64 educacional *from scratch* (long mode).

Baseado no [Laurix](https://github.com/lowwryzen/laurix) (MIT).  
Modificações ClinDos: Copyright (c) 2026 jwilliam-santos.

## Estado

- Boot BIOS → protected 32-bit → **long mode 64-bit** → C
- Saída atual: `Hello World, ClinDos x86_64!` (VGA)
- Branch de trabalho típica: `feat/bootloader-x86_64`

Documentação de planejamento, histórico e padrões:  
**[`../README.md`](../README.md)** (pasta pai `kernel/`).

## Build e run (WSL Ubuntu)

```bash
sudo apt update
sudo apt install -y make nasm qemu-system-x86 gcc binutils

cd ClinDos   # ou: cd /mnt/d/PASTASD/trabalho/kernel/ClinDos
make clean && make run
```

| Alvo | O que faz |
|------|-----------|
| `make` | Gera `build/kernel.img` (floppy 1.44MiB) |
| `make run` | `qemu-system-x86_64` com floppy (`-boot a`) |
| `make clean` | Remove `build/` |

**Não compile com MinGW no Windows** — o `ld` PE não gera o ELF que este projeto precisa.

## Layout rápido

| Arquivo | Papel |
|---------|--------|
| `core/bootloader.asm` | 16-bit, lê kernel (CHS), entra em 32-bit |
| `core/kernel_entry.asm` | Page tables + long mode + chama `kernel()` |
| `kernel.c` | Entry C |
| `include/vga.*` | Texto na VGA |
| `include/isr.asm` / `idt_*` | ISRs/IDT 64-bit (ainda não ligados no boot) |

## Licença

MIT — ver `LICENSE`.
