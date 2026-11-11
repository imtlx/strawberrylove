macro render {
	local .continue, fat
	screen_clear

	cmp byte [sb_count], 100
	jge .fat
	print sb_label
	ntos sb_count, numberbuf
	print numberbuf, 2
	jmp .continue
	.fat:	
	print fat_label
	.continue:
	print newline

	print board

	mov al, [sbx]
	add al, 2
	mov bl, [sby]
	add bl, 3
	move_cursor al, bl
	print sb

	mov al, [bunx]
	add al, 2
	mov bl, [buny]
	add bl, 3
	move_cursor al, bl
	print bun
}
