segment readable writeable

number db 0
randombuf db 0,0,0,0
numberbuf db 0,0
input db 0

bunx db 9
buny db 4

sbx db 0
sby db 0
sb_count db 0

segment readable

bun db "🐇"

sb db "🍓"

sb_label db "Strawberries: "
fat_label db "Now you rly fat bnuy!"

newline db 13, 10

board db "+--------------------+",13,10,"|                    |",13,10,"|                    |",13,10,"|                    |",13,10,"|                    |",13,10,"|                    |",13,10,"|                    |",13,10,"|                    |",13,10,"|                    |",13,10,"|                    |",13,10,"|                    |",13,10,"+--------------------+"

