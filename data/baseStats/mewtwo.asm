db DEX_MEWTWO ; pokedex id
db 106 ; base hp
db 110 ; base attack
db 90 ; base defense
db 130 ; base speed
db 154 ; base special
db PSYCHIC ; species type 1
db WATER ; species type 2
db 3 ; catch rate
db 220 ; base exp yield
INCBIN "pic/ymon/mewtwo.pic",0,1 ; 77, sprite dimensions
dw MewtwoPicFront
dw MewtwoPicBack
; attacks known at lvl 0
db STRING_SHOT
db SURF
db SWIFT
db PSYCHIC_M
db 5 ; growth rate
; learnset
	tmlearn 1,2,3,4,5,6,7,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 17,18,19,20,21,22,23,24
	tmlearn 25,26,27,28,29,30,31,32
	tmlearn 33,34,35,36,37,38,39,40
	tmlearn 41,42,43,44,45,46,47,48
	tmlearn 49,50,51,52,53,54,55
db 0 ; padding
