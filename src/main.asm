format ELF64 executable 3
entry _start

include "src/syscalls.asm"
include "src/terminal.asm"
include "src/utils.asm"
include "src/render.asm"

segment readable writeable

sb_label db "Strawberries: "
sb_label_len = $ - sb_label
fat_label db "Now you rly fat bnuy!"
fat_label_len = $ - fat_label

randombuf rb 4
number db 0
numberbuf rb 2
input rb 1

bunx db 9
buny db 4
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

	cmp byte [input], 'w'
	jne .skip_w
	mov al, [buny]
	cmp al, 0
	jle .skip_w
	dec byte [buny]
	.skip_w:

	cmp byte [input], 's'
	jne .skip_s
	mov al, [buny]
	cmp al, 9
	jge .skip_s
	inc byte [buny]
	.skip_s:

	cmp byte [input], 'a'
	jne .skip_a
	mov al, [bunx]
	cmp al, 0
	jle .skip_a
	dec byte [bunx]
	.skip_a:

	cmp byte [input], 'd'
	jne .skip_d
	mov al, [bunx]
	cmp al, 18
	jge .skip_d
	inc byte [bunx]
	.skip_d:

	mov al, [bunx]
	cmp al, [sbx]
	jnz .skip_eat
	mov al, [buny]
	cmp al, [sby]
	jnz .skip_eat
	inc byte [sb_count]
	call .gen_sb
	.skip_eat:

	jmp .loop

.gen_sb:
.retry:
	randr 0, 19
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

