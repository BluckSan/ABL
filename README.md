# Android Boot Loader (ABL)

A professional-grade Android-style boot loader for x86 systems, written in pure assembly language. This implementation provides a complete boot environment with graphical interface, multi-OS support, and hardware initialization capabilities.

## Key Features

- **Android-style Boot Interface** - Faithful recreation of Android's bootloader UI
- **Multi-OS Support** - Boot Android, Linux, or other systems
- **Hardware Initialization** - Full hardware detection and setup
- **Graphics Support** - VESA graphics mode with custom UI rendering
- **File System Support** - FAT32 file system access for kernel loading
- **Secure Boot** - Optional secure boot implementation
- **Recovery Mode** - Built-in recovery environment

## Technical Specifications

- **Architecture**: x86 32-bit protected mode
- **Memory Management**: Paging enabled with 4GB address space
- **File Systems**: FAT32, EXT2/3/4 support
- **Graphics**: VESA 2.0+ compatible, 32-bit color support
- **Protocols**: Multiboot2, ACPI, SMBIOS support
- **Security**: SHA-256 verification, secure boot options

## Building from Source

### Prerequisites

- NASM 2.15+ (assembler)
- GNU Make 4.3+
- GCC (for toolchain utilities)
- QEMU 6.0+ (for testing)

### Installation (Ubuntu/Debian)

```bash
sudo apt-get update
sudo apt-get install nasm make gcc qemu-system-x86 xorriso grub-common
```

### Installation (Fedora/RHEL)

```bash
sudo dnf install nasm make gcc qemu-system-x86 xorriso grub2-efi
```

### Build Process

```bash
git clone https://github.com/FMZNkdv/ABL.git
cd ABL
make all
```

This will generate:
- `build/abl.bin` - Raw binary image
- `build/abl.img` - Floppy disk image
- `build/abl.iso` - Bootable ISO image
- `build/abl.efi` - UEFI application (if supported)

## Deployment

### Testing with QEMU

```bash
make qemu
make qemu-uefi
make qemu-vga
```

### Installation on Physical Hardware

```bash
sudo make install-usb DEVICE=/dev/sdX
make iso && cdrecord dev=/dev/sr0 build/abl.iso
```
