bits 32
section .text
        ;multiboot spec
        align 4
        dd 0x1BADB002              	;magic
        dd 0x00                    	;flags
        dd - (0x1BADB002 + 0x00)   	;checksum. m+f+c should be zero

global port_byte_in
global start
extern kmain 				;this is defined in the c file

port_byte_in:
	mov dx, word [esp + 4]
	in al, dx
	ret
start:
	cli 				;block interrupts
	mov esp, stack_space		;set stack pointer
	call kmain
	hlt 				;halt the CPU

section .bss
resb 8192				;8KB for stack
stack_space:
