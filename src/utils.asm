struc db [data] {
	common
	. db data
	.len = $ - .
}

macro print string, len {
        match , len \{
		write STDOUT, string, string#.len
        \}
        match any, len \{
		write STDOUT, string, len
        \}
}

macro print_on_board x, y, string {
	mov al, [x]
	add al, 2

	mov bl, [y]
	add bl, 3

	move_cursor al, bl
	print string
}

macro ntos n, b {
        mov al, [n]
        xor ah, ah
        mov bl, 10
        div bl

        add al, "0"
        mov [b], al

        add ah, "0"
        mov [b+1], ah
}

; eax = number [min;max)
macro randr min, max {
	getrandom randombuf, 4
	mov eax, dword [randombuf]
	xor edx, edx
	mov ecx, max - min
	div ecx
	if min <> 0
		add edx, min
	end if
	mov eax, edx
}

