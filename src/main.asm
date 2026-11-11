format ELF64 executable 3
entry _start

include 'src/syscalls.asm'
include 'src/terminal.asm'
include 'src/utils.asm'
include 'src/render.asm'

segment readable writeable

sb_label db 'Strawberries: '
sb_label_len = $ - sb_label

randombuf rb 4
number db 0
numberbuf rb 2
input rb 1

segment readable executable

_start:
	term_init
	call .randnum

.loop:
	render

	read input, 1
	test rax, rax
	jle .exit

	cmp byte [input], ' '
	jne .space_skip
	call .randnum
	.space_skip:

	cmp byte [input], 'q'
	je .exit

	jmp .loop

.randnum: ; random number in range 0..99
	randr 0, 100
	mov [number], al
	ret

.exit:
	term_cleanup
	exit 0
.error:
	exit 1

