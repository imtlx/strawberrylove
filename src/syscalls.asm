SYS_read 	= 0
SYS_write	= 1
SYS_ioctl	= 16
SYS_exit	= 60
SYS_getrandom	= 318

STDIN		= 0
STDOUT		= 1
STDERR		= 2

macro syscall number {
	mov eax, number
	syscall
}
macro exit c {
	mov edi, c
	syscall SYS_exit
}

macro write fd, buffer, len {
        match , len \{
		mov edi, fd
		mov rsi, buffer
		mov edx, buffer#_len
                syscall SYS_write
        \}
        match any, len \{
		mov edi, fd
		mov rsi, buffer
		mov edx, len
                syscall SYS_write
        \}
}

macro read fd, buffer, len {
	mov edi, fd
	mov rsi, buffer
	mov edx, len
	syscall SYS_read
}

macro getrandom buffer, len {
	mov rdi, buffer
	mov esi, len
	xor edx, edx
	syscall SYS_getrandom
}

macro ioctl fd, op, argp {
	mov edi, fd
	mov esi, op
	mov rdx, argp
	syscall SYS_ioctl
}

