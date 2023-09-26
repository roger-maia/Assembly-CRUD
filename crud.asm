section .data
    array db 10, 20, 30, 40, 50     ; Example array of integers
    array_size equ 5
    new_element db 60               ; New element to be added

section .bss
    index resb 1                   ; Variable to store the index for updates and deletions

section .text
    global _start

_start:
    ; CREATE (Add an element)
    mov al, [array_size]            ; Load array size into AL
    add al, 1                       ; Increment the size
    mov [array_size], al            ; Update array size

    mov cl, al                      ; Loop counter
    mov dl, 0                       ; Index variable (0-based)
    mov al, [new_element]           ; Load the new element

add_loop:
    mov [array + dl], al            ; Add the new element to the array
    inc dl                          ; Increment index
    loop add_loop

    ; READ (Print array)
    mov dl, 0                       ; Reset index
print_loop:
    mov al, [array + dl]            ; Load an element from the array
    call print_number               ; Function to print the number
    inc dl
    cmp dl, [array_size]
    jl print_loop

    ; UPDATE (Modify an element)
    mov byte [index], 2             ; Update the element at index 2 (0-based)

    mov dl, [index]                 ; Load index into DL
    mov al, 99                      ; New value
    mov [array + dl], al

    ; DELETE (Remove an element)
    mov byte [index], 3             ; Delete the element at index 3 (0-based)

    mov dl, [index]                 ; Load index into DL
delete_loop:
    mov al, [array + dl]            ; Load an element from the array
    mov bl, [array + dl + 1]        ; Load the next element
    mov [array + dl], bl            ; Move the next element to the current position
    inc dl
    loop delete_loop

    dec byte [array_size]           ; Decrement the array size

    ; Exit the program
    mov eax, 1
    int 0x80

print_number:
    ; Function to print a single-digit number in ASCII
    add al, '0'                      ; Convert to ASCII
    mov ah, 0x0e
    mov ebx, 1
    mov ecx, number
    mov edx, 1
    int 0x80
    ret

section .data
    number resb 1

section .bss
    unused resb 1
