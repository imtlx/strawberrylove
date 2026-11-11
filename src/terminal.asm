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

cursorx rb 1
cursory rb 1
cursorbuf rb 32

segment readable executable

macro enter_alt_screen {
	print alt_enter
}

macro leave_alt_screen {
	print alt_leave
}

macro clear_screen {
	print screen_clear
}

macro hide_cursor {
	print cursor_hide
}

macro show_cursor {
	print cursor_show
}

macro screen_clear {
	print screen_clear
}

macro move_cursor x, y {
        mov byte [cursorx], x
        mov byte [cursory], y

        mov byte [cursorbuf], 27
        mov byte [cursorbuf+1], '['

        ntos cursory, numberbuf
        mov al, [numberbuf]
        mov [cursorbuf+2], al
        mov al, [numberbuf+1]
        mov [cursorbuf+3], al

        mov byte [cursorbuf+4], ';'

        ntos cursorx, numberbuf
        mov al, [numberbuf]
        mov [cursorbuf+5], al
        mov al, [numberbuf+1]
        mov [cursorbuf+6], al

        mov byte [cursorbuf+7], 'H'

        print cursorbuf, 8
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
