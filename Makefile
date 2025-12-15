ASM = nasm
ASMFLAGS = -f bin

BUILD = build
SRC = src

BOOT_BIN = $(BUILD)/boot.bin
LOADER_BIN = $(BUILD)/loader.bin
KERNEL_BIN = $(BUILD)/kernel.bin
IMG = $(BUILD)/os.img

.PHONY: all clean run

all: $(IMG)

$(BUILD):
	mkdir -p $(BUILD)

$(BOOT_BIN): $(SRC)/boot/boot.asm | $(BUILD)
	$(ASM) $(ASMFLAGS) $< -o $@
$(LOADER_BIN): $(SRC)/loader/loader.asm | $(BUILD)
	$(ASM) $(ASMFLAGS) $< -o $@
$(KERNEL_BIN): $(SRC)/kernel/kernel.asm | $(BUILD)
	$(ASM) $(ASMFLAGS) $< -o $@

$(IMG): $(BOOT_BIN) $(LOADER_BIN) $(KERNEL_BIN)
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$(BOOT_BIN) of=$@ bs=512 count=1 conv=notrunc
	dd if=$(LOADER_BIN) of=$@ bs=512 seek=1 conv=notrunc
	dd if=$(KERNEL_BIN) of=$@ bs=512 seek=2 conv=notrunc

run: $(IMG)
	qemu-system-i386 -fda $(IMG)

clean:
	rm -rf $(BUILD)

