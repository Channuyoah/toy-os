# toy-os
A toy operating system built from scratch in 14 days, following the core ideas of “30 Days OS” but redesigned with modern build scripts, documentation, and clean architecture for educational and demonstrative purposes.

toy-os-project/
├── boot/                   # 引导程序 (boot sector, loader)
│   ├── boot.asm
│   ├── loader.asm
│   └── Makefile
│
├── kernel/                 # 内核代码
│   ├── asm/                # 内核部分汇编
│   │   ├── gdt.asm
│   │   ├── idt.asm
│   │   └── interrupt.asm
│   │
│   ├── c/                  # 内核 C 代码
│   │   ├── main.c
│   │   ├── memory.c
│   │   ├── graphic.c
│   │   ├── keyboard.c
│   │   └── timer.c
│   │
│   └── include/            # 内核头文件
│       ├── memory.h
│       ├── graphic.h
│       ├── interrupt.h
│       └── system.h
│
├── build/                  # 编译产物 (bin/iso/img)，不加入 gitignore 可忽略
│   ├── os.img
│   ├── kernel.bin
│   └── boot.bin
│
├── tools/                  # 构建、调试、脚本工具
│   ├── run_qemu.sh
│   ├── build.sh
│   └── write_image.py
│
├── docs/                   # 文档、设计、架构图
│   ├── lessons-learned.md
│   ├── arch-overview.md
│   └── notes/
│       ├── day1.md
│       ├── day2.md
│       └── ...
│
├── .gitignore
├── LICENSE
├── Makefile                # 顶层构建入口
└── README.md

