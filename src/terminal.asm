segment readable writable
struc termios {

	.c_iflag dd ?
	.c_oflag dd ?
	.c_cflag dd ?
	.c_lflag dd ?
	.c_line  db ?
	.c_cc    rb 19
}

TCGETS = 0x5401
TCSETS = 0x5402

VMIN  = 6
VTIME = 5

original_termios termios
raw_termios termios

alt_enter db 27, '[?1049h'
alt_enter_len = $ - alt_enter

alt_leave db 27, '[?1049l'
alt_leave_len = $ - alt_leave

screen_clear db 27, '[2J', 27, '[H'
screen_clear_len = $ - screen_clear

cursor_hide db 27, '[?25l'
cursor_hide_len = $ - cursor_hide

cursor_show db 27, '[?25h'
cursor_show_len = $ - cursor_show

segment readable executable

macro enter_alt_screen {
	syscall3 SYS_write, STDOUT, alt_enter, alt_enter_len
}

macro leave_alt_screen {
	syscall3 SYS_write, STDOUT, alt_leave, alt_leave_len
}

macro clear_screen {
	syscall3 SYS_write, STDOUT, screen_clear, screen_clear_len
}

macro hide_cursor {
	syscall3 SYS_write, STDOUT, cursor_hide, cursor_hide_len
}

macro show_cursor {
	syscall3 SYS_write, STDOUT, cursor_show, cursor_show_len
}

macro term_init {
	syscall3 SYS_ioctl, STDIN, TCGETS, original_termios
	test rax, rax
	js .error

	cld
	mov rsi, original_termios
	mov rdi, raw_termios
	mov ecx, 36
	rep movsb

; c_lflag: ~(ICANON | ECHO | ISIG | IEXTEN)
	and dword [raw_termios.c_lflag], 0xffff7ff4
; c_iflag: ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR | IGNCR | ICRNL | IXON)
	and dword [raw_termios.c_iflag], 0xfffff4cd
; c_oflag: ~OPOST
	and dword [raw_termios.c_oflag], 0xfffffffe

	mov byte [raw_termios.c_cc + VMIN], 1
	mov byte [raw_termios.c_cc + VTIME], 0

	syscall3 SYS_ioctl, STDIN, TCSETS, raw_termios

	enter_alt_screen
	clear_screen
	hide_cursor
}

macro term_cleanup {
	show_cursor
	syscall3 SYS_ioctl, STDIN, TCSETS, original_termios
	leave_alt_screen
}
