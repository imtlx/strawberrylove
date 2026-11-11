macro exit code {
	syscall1 SYS_exit, code
}

macro print string, len {
	syscall3 SYS_write, STDOUT, string, len
}

macro read buffer, len {
	syscall3 SYS_read, STDIN, buffer, len
}
