format ELF64 executable 3
entry _start

include 'src/syscalls.asm'
include 'src/terminal.asm'
include 'src/utils.asm'
include 'src/render.asm'

segment readable writeable

message db 'Bnuy! Strawberry!', 10
message_len = $ - message

number db '0'
input rb 1

segment readable executable

_start:
	term_init
	print message, message_len

.loop:
	read input, 1
	test rax, rax
	jle .exit

	cmp byte [input], ' '
	jne .space_skip
	inc byte [number]
	.space_skip:

	cmp byte [input], 'q'
	je .exit

	render
	jmp .loop

.exit:
	term_cleanup
	exit 0
.error:
	exit 1

