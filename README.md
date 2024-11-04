# USB Device Lister in Assembly (Linux)

This is a simple assembly program (x86 NASM) that lists USB devices connected to a Linux system by reading entries from the `/sys/bus/usb/devices/` directory.

## How It Works

The program:
1. Uses system calls to open and read the `/sys/bus/usb/devices/` directory.
2. Reads each entry in the directory using the `getdents` syscall.
3. Prints the name of each entry (representing a USB device or related directory entry) to standard output.

## Requirements

- **Linux** system (this code relies on Linux syscalls and directory structure).
- **NASM** (Netwide Assembler) for assembling the code.
- **LD** (Linker) for linking the assembled code.

## Usage

1. **Clone or Download** this repository and navigate to the folder containing the assembly file (`list_usb.asm`).

2. **Assemble and Link** the code:

    ```bash
    nasm -f elf32 list_usb.asm -o list_usb.o
    ld -m elf_i386 list_usb.o -o list_usb
    ```

3. **Run the Program**:

    ```bash
    ./list_usb
    ```

4. **Output**:

    The program will display a list of entries from `/sys/bus/usb/devices/`, which should include USB devices connected to your system.

    ```
    Connected USB devices:
    Device: usb1
    Device: usb2
    Device: 1-1
    Device: 2-1
    ```

    Each entry represents a USB device or a related directory entry.

## Code Explanation

### System Calls Used

- **`open` (syscall 5)**: Opens the `/sys/bus/usb/devices/` directory for reading.
- **`getdents` (syscall 141)**: Reads directory entries into a buffer.
- **`write` (syscall 4)**: Outputs directory entry names to the console.
- **`close` (syscall 6)**: Closes the directory when finished.

### Program Flow

- **Open Directory**: The program starts by opening the `/sys/bus/usb/devices/` directory.
- **Read Entries**: Using `getdents`, it reads entries into a buffer.
- **Display Entries**: For each entry in the buffer, the program writes the name to the console.
- **Close Directory**: After all entries are displayed, the directory is closed, and the program exits.

## Notes

- This program is for **educational purposes** and demonstrates low-level programming and syscall usage in assembly.
- It lists all entries in the `/sys/bus/usb/devices/` directory, which may include symbolic links and non-USB files depending on the system configuration.
- To retrieve detailed information about each device, consider using higher-level tools or programs, as assembly does not interpret device metadata.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

Happy low-level programming!
