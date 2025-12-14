ASM = nasm
ASMFLAGS = -f bin

BUILD = build
SRC = src

BOOT_BIN = $(BUILD)/boot.bin
IMG = $(BUILD)/os.img

.PHONY: all clean run

all: $(IMG)

$(BUILD):
	mkdir -p $(BUILD)

$(BOOT_BIN): $(SRC)/boot/boot.asm | $(BUILD)
	$(ASM) $(ASMFLAGS) $< -o $@

$(IMG): $(BOOT_BIN)
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$(BOOT_BIN) of=$@ bs=512 count=1 conv=notrunc

run: $(IMG)
	qemu-system-i386 -fda $(IMG) -boot a

clean:
	rm -rf $(BUILD)

