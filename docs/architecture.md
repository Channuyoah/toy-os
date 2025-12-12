# Architecture Document

## 1. Architecture Overview
This document describes the internal architecture of the operating system.  
The OS follows a layered, modular design to keep each subsystem isolated and easy to understand.

The system consists of the following layers:

1. Hardware & BIOS
2. Bootloader (Real Mode)
3. Kernel Initialization (Protected Mode)
4. Core Kernel Services
5. User-Level Programs (Optional)

---

## 2. Architecture Diagram (Text Version)

Boot Flow:
BIOS → MBR → boot.asm → loader.asm → GDT → Protected Mode → kernel/main.c

Subsystems:
- Bootloader
- GDT/IDT
- Interrupts (ISR/IRQ)
- PIC/PIT
- Drivers
- Memory management
- Scheduler
- User program loader

---

## 3. Detailed Components

### 3.1 Bootloader
Responsible for:
- Entering Real Mode
- Loading kernel to memory
- Preparing GDT descriptor
- Switching to Protected Mode using LGDT and CR0 manipulation
- Passing control to kernel

Output: 32-bit environment ready for kernel execution.

---

### 3.2 GDT (Global Descriptor Table)
Defines:
- Code segment
- Data segment
- Stack segment
- Null descriptor

Design: Flat memory model (base = 0, limit = 4GB)

---

### 3.3 IDT (Interrupt Descriptor Table)
Defines mappings of:
- CPU exception handlers (0–31)
- Hardware interrupts (32–47)

Each entry includes:
- Offset
- Selector
- Flags

---

### 3.4 Interrupt Handling Framework

#### 3.4.1 ISR (Interrupt Service Routines)
Handles CPU exceptions:
- Divide-by-zero
- Page fault
- General protection fault

#### 3.4.2 IRQ (Hardware Interrupts)
Triggered by PIC:
- Timer (IRQ0)
- Keyboard (IRQ1)

Interrupt flow:
PIC → IDT → ISR → C handler → EOI → return

---

### 3.5 Memory Management
Two layers:

#### 3.5.1 Physical Memory Detector
Uses BIOS memory map (if applicable) or manual detection.

#### 3.5.2 Simple Allocator
Bitmap or first-fit block allocator.

---

### 3.6 Task Scheduler
Cooperative model:
- Tasks yield explicitly
- Context switch saves:
  - EIP
  - ESP/EBP
  - General registers

Data structure: TCB (Task Control Block)

---

### 3.7 Device Drivers
#### 3.7.1 Keyboard Driver
- Uses IRQ1
- Reads scancode from 0x60
- Converts to ASCII

#### 3.7.2 Timer Driver
- Configures PIT for periodic interrupts
- Drives task scheduler

#### 3.7.3 VGA Driver
- Provides basic pixel/character draw
- Uses framebuffer or VGA text mode

---

### 3.8 File System Support
Simple FAT12 reader:
- Read root directory
- Locate file clusters
- Load program to memory

---

### 3.9 User Program Loader
Custom format:
- Header (magic + entry)
- Code segment
- Data segment

Kernel maps it into memory and jumps to entry.

---

## 4. Coding Conventions
- C style: K&R or Linux-style braces
- Inline assembly only in central points
- Each subsystem isolated in its module directory

---

## 5. Performance Considerations
- No paging (initially)
- Minimal context switch overhead
- No dynamic memory fragmentation concerns yet

---

## 6. Security Considerations
- No privilege separation
- No memory protection
- No user/kernel mode distinction (for simplicity)

---

## 7. Future Architecture Extensions
- Introduce paging and virtual memory
- Implement syscall interface
- Introduce ring3 user mode
- ELF loader
- Multi-level scheduler

---

## 8. Appendix: Register Usage
- EAX: return value
- EBX/ECX/EDX: caller-saved
- ESI/EDI/EBP: preserved
- ESP: stack pointer

