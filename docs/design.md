# Design Document

## 1. Project Overview
This project implements a minimal x86 operating system from scratch.  
The purpose is educational and demonstrative: to explore low-level OS concepts and to provide a clean, well-structured codebase suitable for learning and evaluation.

The OS is designed with simplicity as the top priority.  
Key components include:
- Custom bootloader
- Protected mode kernel
- Interrupt handling
- Memory management
- Cooperative multitasking
- Primitive graphics
- Simple file system parser

---

## 2. Objectives
### 2.1 Technical Objectives
- Understand x86 boot flow (BIOS → MBR → Real Mode → Protected Mode)
- Implement a functional kernel in C/Assembly
- Build essential subsystems:
  - GDT/IDT
  - PIC/PIT interrupts
  - Keyboard driver
  - Physical memory management
  - Task switching
- Provide minimal UI and user program loading

### 2.2 Engineering Objectives
- Maintain a clean and modular directory structure
- Create readable and maintainable code
- Provide clear documentation for each subsystem
- Ensure repeatable builds using Makefile and optional scripts

---

## 3. System Requirements
### 3.1 Build Environment
- Linux or macOS preferred
- NASM assembler
- GCC cross-compiler for i686
- QEMU emulator

### 3.2 Runtime Environment
- x86 real machine or emulator  
- VGA-compatible display mode

---

## 4. High-Level Design
The OS is divided into several layers:

### 4.1 Boot Layer
- Runs in Real Mode
- Loads GDT and enters Protected Mode
- Jump to 32-bit kernel entry

### 4.2 Kernel Layer
- Initializes segmentation (flat memory model)
- Sets up IDT and interrupt service routines
- Configures PIC and PIT
- Provides core functionalities:
  - Memory allocator
  - Task scheduling
  - Basic graphics API
  - Simple drivers

### 4.3 User Layer
- Minimal ELF-like format (custom)
- Loaded via a simple FS loader
- Cooperative multitasking between user programs

---

## 5. Module Breakdown
### 5.1 boot/
- boot.asm
- loader.asm
- gdt initialization
- pm32 switch

### 5.2 kernel/
- main.c
- gdt/
- idt/
- interrupt/
- mm/ (memory manager)
- sched/ (task scheduler)
- drivers/
  - keyboard.c
  - timer.c
  - vga.c

### 5.3 user/
- Simple test programs such as:
  - print
  - loop
  - graphics demo

### 5.4 tools/
- Disk image builder
- FS pack/unpack utilities

---

## 6. Error Handling & Debugging
- QEMU monitor and `info registers`
- Use Bochs for instruction-level debugging
- Kernel panic handler prints:
  - EIP
  - error code
  - interrupt number

---

## 7. Future Extensions
- Preemptive multitasking
- Simple shell
- Paging and virtual memory
- More advanced graphics
- Dynamic memory allocator
- FAT16/FAT32 support

---

## 8. Revision History
| Date | Author | Description |
|------|---------|-------------|
| 2025-12-12 | cc | 0.1 |
