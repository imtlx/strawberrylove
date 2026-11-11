macro render {
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

	print_on_board sbx, sby, sb
	print_on_board bunx, buny, bun
}
