macro exit code {
	syscall1 SYS_exit, code
}

macro print string, len {
	match , len \{
		syscall3 SYS_write, STDOUT, string, string#_len
	\}
	match any, len \{
		syscall3 SYS_write, STDOUT, string, len
	\}
}

macro ntos n, b {
        mov al, [n]
        xor ah, ah
        mov bl, 10
        div bl

        add al, '0'
        mov [b], al

        add ah, '0'
        mov [b+1], ah
}

macro read buffer, len {
	syscall3 SYS_read, STDIN, buffer, len
}

macro random {
	syscall3 SYS_getrandom, randombuf, 4, 0
}

; eax = number [min;max)
macro randr min, max {
	random
	mov eax, dword [randombuf]
	xor edx, edx
	mov ecx, max - min
	div ecx
	if min <> 0
		add edx, min
	end if
	mov eax, edx
}
