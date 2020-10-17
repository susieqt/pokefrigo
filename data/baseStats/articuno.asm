db DEX_ARTICUNO ; pokedex id
db 50 ; base hp
db 64 ; base attack
db 50 ; base defense
db 41 ; base speed
db 95 ; base special
db ROCK ; species type 1
db GROUND ; species type 2
db 45 ; catch rate
db 215 ; base exp yield
INCBIN "pic/ymon/articuno.pic",0,1 ; 77, sprite dimensions
dw ArticunoPicFront
dw ArticunoPicBack
; attacks known at lvl 0
db BITE
db LEER
db 0
db 0
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
