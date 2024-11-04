section .data
    usb_dir db "/sys/bus/usb/devices/", 0   ; USB devices directory path
    buf db 256                               ; Buffer to hold file names
    newline db 10                            ; Newline character for printing

section .bss
    fd resd 1                                ; File descriptor for the directory

section .text
    global _start

_start:
    ; Open the directory /sys/bus/usb/devices/
    mov eax, 5                              ; syscall: open
    mov ebx, usb_dir                        ; directory path
    mov ecx, 0                              ; O_RDONLY
    int 0x80                                ; syscall interrupt
    mov [fd], eax                           ; store file descriptor

    ; Check if directory opened successfully
    cmp eax, 0
    js error_exit                           ; exit if error occurred

read_directory:
    ; Read directory entries
    mov eax, 141                            ; syscall: getdents
    mov ebx, [fd]                           ; file descriptor
    mov ecx, buf                            ; buffer for directory entries
    mov edx, 256                            ; size of buffer
    int 0x80                                ; syscall interrupt

    ; Check if there are no more entries
    cmp eax, 0
    jle close_and_exit                      ; exit if done reading

    ; Display each entry in the buffer
    mov esi, buf                            ; pointer to buffer
    add esi, eax                            ; calculate end of buffer

next_entry:
    ; Find and print the entry name (assuming USB devices)
    mov eax, 4                              ; syscall: write
    mov ebx, 1                              ; stdout
    mov ecx, buf                            ; buffer (entry name)
    mov edx, eax                            ; size
    int 0x80                                ; syscall interrupt

    ; Print newline after each entry
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Move to the next entry
    jmp next_entry

close_and_exit:
    ; Close directory
    mov eax, 6                              ; syscall: close
    mov ebx, [fd]                           ; file descriptor
    int 0x80

    ; Exit program
    mov eax, 1                              ; syscall: exit
    xor ebx, ebx                            ; exit code 0
    int 0x80

error_exit:
    ; Exit with error code
    mov eax, 1                              ; syscall: exit
    mov ebx, 1                              ; exit code 1
    int 0x80
