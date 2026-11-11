draw_ui:
	cmp byte [sb_count], 100
	jge .fat

	print sb_label
	ntos sb_count, numberbuf
	print numberbuf, 2
	ret

	.fat:
	print fat_label
	ret
;draw_ui

render:
	screen_clear
	call draw_ui
	print newline
	print board
	print_on_board sbx, sby, sb
	print_on_board bunx, buny, bun
;render end
