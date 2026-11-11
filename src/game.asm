check_collision:
	mov al, [bunx]
	cmp al, [sbx]
	jnz .done

	mov al, [buny]
	cmp al, [sby]
	jnz .done

	inc byte [sb_count]
	call generate_strawberry

	.done:
	ret
;check_collision end

keyboard:
	cmp byte [input], "q"
	jne .continue
	mov eax, 1
	ret

	.continue:
	cmp byte [input], "w"
	jne .skip_w
	cmp byte [buny], 0
	jle .skip_w
	dec byte [buny]
	.skip_w:

	cmp byte [input], "s"
	jne .skip_s
	cmp byte [buny], 9
	jge .skip_s
	inc byte [buny]
	.skip_s:

	cmp byte [input], "a"
	jne .skip_a
	cmp byte [bunx], 0
	jle .skip_a
	dec byte [bunx]
	.skip_a:

	cmp byte [input], "d"
	jne .skip_d
	cmp byte [bunx], 18
	jge .skip_d
	inc byte [bunx]
	.skip_d:

	xor eax, eax
	ret
;keyboard end

generate_strawberry:
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
;gen_sb end
