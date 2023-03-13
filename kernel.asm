; Define the global section
section .data
message db 'Hello, World!', 0
new_line db 0Ah, 0

section .bss
; Reserve space for the stack
stack_space resb 16384
; Reserve space for the IDT
idt resb 256 * 8

section .text
; Set up the stack
mov esp, stack_space + 16384
; Set up the IDT
cli
call set_idt
; Print the message
mov eax, 4
mov ebx, 1
mov ecx, message
mov edx, 13
int 0x80
; Print a new line
mov eax, 4
mov ebx, 1
mov ecx, new_line
mov edx, 2
int 0x80
; Halt the system
mov eax, 1
xor ebx, ebx
int 0x80

; Set up the IDT
set_idt:
mov eax, idt_descriptor
lidt [eax]
sti
retf

; The IDT descriptor
idt_descriptor:
dw 256 * 8 - 1
dd idt

; The IDT
idt:
times 256 * 8 db 0
