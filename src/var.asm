segment readable writeable

sb_label db "Strawberries: "
sb_label_len = $ - sb_label
fat_label db "Now you rly fat bnuy!"
fat_label_len = $ - fat_label

number db 0
randombuf rb 4
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
db "+--------------------+", 13 , 10
db "|                    |", 13 , 10
db "|                    |", 13 , 10
db "|                    |", 13 , 10
db "|                    |", 13 , 10
db "|                    |", 13 , 10
db "|                    |", 13 , 10
db "|                    |", 13 , 10
db "|                    |", 13 , 10
db "|                    |", 13 , 10
db "|                    |", 13 , 10
db "+--------------------+"
board_len = $ - board

