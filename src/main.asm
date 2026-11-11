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

bunx db 9
buny db 4
bundx db 0
bundy db 0
bun db "🐇"
bun_len = $ - bun

sb db "🍓"
sb_len = $ - sb
sbx db 0
sby db 0
sb_count db 0

newline db 13, 10
newline_len = $ - newline
board:
db '+--------------------+', 13 , 10
db '|                    |', 13 , 10
db '|                    |', 13 , 10
db '|                    |', 13 , 10
db '|                    |', 13 , 10
db '|                    |', 13 , 10
db '|                    |', 13 , 10
db '|                    |', 13 , 10
db '|                    |', 13 , 10
db '|                    |', 13 , 10
db '|                    |', 13 , 10
db '+--------------------+'
board_len = $ - board

segment readable executable

_start:
	term_init
	call .gen_sb
.loop:
	render

	read input, 1
	test rax, rax
	jle .exit

	cmp byte [input], 'q'
	je .exit

	call .gen_sb
	jmp .loop

.gen_sb:
.retry:
	randr 0, 20
	mov [sbx], al
	randr 0, 10
	mov [sby], al
	mov al, [sbx]
	cmp al, [bunx]
	jne .done
	mov al, [sby]
	cmp al, [buny]
	je .retry
.done:
	ret

.exit:
	term_cleanup
	exit 0
.error:
	exit 1

