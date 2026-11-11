SYS_read 	= 0
SYS_write	= 1
SYS_ioctl	= 16
SYS_exit	= 60
SYS_getrandom	= 318

STDIN		= 0
STDOUT		= 1
STDERR		= 2

macro syscall0 number {
	mov eax, number
	syscall
}

macro syscall1 number, arg1 {
	mov eax, number
	mov rdi, arg1
	syscall
}

macro syscall2 number, arg1, arg2 {
	mov eax, number
	mov rdi, arg1
	mov rsi, arg2
	syscall
}

macro syscall3 number, arg1, arg2, arg3 {
	mov eax, number
	mov rdi, arg1
	mov rsi, arg2
	mov rdx, arg3
	syscall
}

macro syscall4 number, arg1, arg2, arg3, arg4 {
	mov eax, number
	mov rdi, arg1
	mov rsi, arg2
	mov rdx, arg3
	mov r10, arg4
	syscall
}

macro syscall5 number, arg1, arg2, arg3, arg4, arg5 {
	mov eax, number
	mov rdi, arg1
	mov rsi, arg2
	mov rdx, arg3
	mov r10, arg4
	mov r8, arg5
	syscall
}

macro syscall6 number, arg1, arg2, arg3, arg4, arg5, arg6 {
	mov eax, number
	mov rdi, arg1
	mov rsi, arg2
	mov rdx, arg3
	mov r10, arg4
	mov r8, arg5
	mov r9, arg6
	syscall
}

