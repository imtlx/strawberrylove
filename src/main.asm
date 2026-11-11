format ELF64 executable 3
entry _start

include "src/syscalls.asm"
include "src/terminal.asm"
include "src/utils.asm"
include "src/render.asm"
include "src/game.asm"

include "src/var.asm"

segment readable executable

_start:
	term_init
	call generate_strawberry
	call render
.loop:
	read input, 1
	test rax, rax
	jle .exit

	call keyboard
	test eax, eax
	jnz .exit

	call check_collision

	call render
	jmp .loop

.exit:
	term_cleanup
	exit 0

