format ELF64 executable 3
segment readable executable
entry $
	mov rax, 60
	xor rdi, rdi
	syscall
