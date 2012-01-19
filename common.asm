INCLUDE "constants.asm"

; the rst vectors are unused
SECTION "rst00",HOME[0]
	db $FF
SECTION "rst08",HOME[8]
	db $FF
SECTION "rst10",HOME[$10]
	db $FF
SECTION "rst18",HOME[$18]
	db $FF
SECTION "rst20",HOME[$20]
	db $FF
SECTION "rst28",HOME[$28]
	db $FF
SECTION "rst30",HOME[$30]
	db $FF
SECTION "rst38",HOME[$38]
	db $FF

; interrupts
SECTION "vblank",HOME[$40]
	jp $2024
SECTION "lcdc",HOME[$48]
	db $FF
SECTION "timer",HOME[$50]
	jp $2306
SECTION "serial",HOME[$58]
	jp $2125
SECTION "joypad",HOME[$60]
	reti

SECTION "bank0",HOME[$61]
DisableLCD:
;$0061
	xor a
	ld [$ff0f],a
	ld a,[$ffff]
	ld b,a
	res 0,a
	ld [$ffff],a
.jr0\@
	ld a,[$ff44]
	cp a,$91
	jr nz,.jr0\@
	ld a,[$ff40]
	and a,$7f	; res 7,a
	ld [$ff40],a
	ld a,b
	ld [$ffff],a
	ret

EnableLCD:
;$007b
	ld a,[$ff40]
	set 7,a
	ld [$ff40],a
	ret

CleanLCD_OAM:
;$0082
	xor a
	ld hl,$c300
	ld b,$a0
.jr0\@
	ld [hli],a
	dec b
	jr nz,.jr0\@
	ret

ResetLCD_OAM:
;$008d
	ld a,$a0
	ld hl,$c300
	ld de,$0004
	ld b,$28
.jr0\@
	ld [hl],a
	add hl,de
	dec b
	jr nz,.jr0\@
	ret

FarCopyData: ; 009D
; copy bc bytes of data from a:hl to de
	ld [$CEE9],a ; save future bank # for later
	ld a,[$FFB8] ; get current bank #
	push af
	ld a,[$CEE9] ; get future bank #, switch
	ld [$FFB8],a
	ld [$2000],a
	call CopyData
	pop af       ; okay, done, time to switch back
	ld [$FFB8],a
	ld [$2000],a
	ret
CopyData: ; 00B5
; copy bc bytes of data from hl to de
	ld a,[hli]
	ld [de],a
	inc de
	dec bc
	ld a,c
	or b
	jr nz,CopyData
	ret

SECTION "romheader",HOME[$100]
nop
jp Start

Section "start",HOME[$150]
Start:

INCBIN "baserom.gbc",$150,$1AE - $150
; see also MapHeaderBanks
MapHeaderPointers: ; $01AE
	dw PalletTown_h
	dw ViridianCity_h
	dw PewterCity_h
	dw CeruleanCity_h
	dw LavenderTown_h
	dw VermilionCity_h
	dw CeladonCity_h
	dw FuchsiaCity_h
	dw CinnabarIsland_h
	dw IndigoPlateau_h
	dw SaffronCity_h
	dw SaffronCity_h
	dw Route1_h
	dw Route2_h
	dw Route3_h
	dw Route4_h
	dw Route5_h
	dw Route6_h
	dw Route7_h
	dw Route8_h
	dw Route9_h
	dw Route10_h
	dw Route11_h
	dw Route12_h
	dw Route13_h
	dw Route14_h
	dw Route15_h
	dw Route16_h
	dw Route17_h
	dw Route18_h
	dw Route19_h
	dw Route20_h
	dw Route21_h
	dw Route22_h
	dw Route23_h
	dw Route24_h
	dw Route25_h
	dw RedsHouse1F_h
	dw RedsHouse2F_h
	dw BluesHouse_h
	dw OaksLab_h ;id=40
	dw ViridianPokecenter_h
	dw ViridianMart_h
	dw School_h
	dw ViridianHouse_h
	dw ViridianGym_h
	dw DiglettsCaveRoute2_h
	dw ViridianForestexit_h
	dw Route2House_h
	dw Route2Gate_h
	dw ViridianForestEntrance_h ;id=50
	dw ViridianForest_h
	dw MuseumF1_h
	dw MuseumF2_h
	dw PewterGym_h
	dw PewterHouse1_h
	dw PewterMart_h
	dw PewterHouse2_h
	dw PewterPokecenter_h
	dw MtMoon1_h
	dw MtMoon2_h ;id=60
	dw MtMoon3_h
	dw CeruleanHouseTrashed_h
	dw CeruleanHouse2_h
	dw CeruleanPokecenter_h
	dw CeruleanGym_h
	dw BikeShop_h
	dw CeruleanMart_h
	dw MtMoonPokecenter_h
	dw CeruleanHouseTrashed_h ; copy
	dw Route5Gate_h
	dw UndergroundTunnelEntranceRoute5_h
	dw DayCareM_h
	dw Route6Gate_h
	dw UndergroundTunnelEntranceRoute6_h
	dw UndergroundTunnelEntranceRoute6_h ; unused
	dw Route7Gate_h
	dw UndergroundPathEntranceRoute7_h
	dw $575d
	dw Route8Gate_h
	dw UndergroundPathEntranceRoute8_h ;id=80
	dw RockTunnelPokecenter_h
	dw RockTunnel1_h
	dw PowerPlant_h
	dw Route11Gate_h
	dw DiglettsCaveEntranceRoute11_h
	dw Route11GateUpstairs_h
	dw Route12Gate_h
	dw BillsHouse_h
	dw VermilionPokecenter_h
	dw FanClub_h ;id=90
	dw VermilionMart_h
	dw VermilionGym_h
	dw VermilionHouse1_h
	dw VermilionDock_h
	dw SSAnne1_h
	dw SSAnne2_h
	dw SSAnne3_h
	dw SSAnne4_h
	dw SSAnne5_h
	dw SSAnne6_h ;id=100
	dw SSAnne7_h
	dw SSAnne8_h
	dw SSAnne9_h
	dw SSAnne10_h
	dw Lance_h ; unused
	dw Lance_h ; unused
	dw Lance_h ; unused
	dw VictoryRoad1_h
	dw Lance_h ; unused
	dw Lance_h ; unused ;id=110
	dw Lance_h ; unused
	dw Lance_h ; unused
	dw Lance_h
	dw Lance_h ; unused
	dw Lance_h ; unused
	dw Lance_h ; unused
	dw Lance_h ; unused
	dw HallofFameRoom_h
	dw UndergroundPathNS_h
	dw Gary_h ;id=120
	dw UndergroundPathWE_h
	dw CeladonMart1_h
	dw CeladonMart2_h
	dw CeladonMart3_h
	dw CeladonMart4_h
	dw CeladonMartRoof_h
	dw CeladonMartElevator_h
	dw CeladonMansion1_h
	dw CeladonMansion2_h
	dw CeladonMansion3_h ;id=130
	dw CeladonMansion4_h
	dw CeladonMansion5_h
	dw CeladonPokecenter_h
	dw CeladonGym_h
	dw CeladonGameCorner_h
	dw CeladonMart5_h
	dw CeladonPrizeRoom_h
	dw CeladonDiner_h
	dw CeladonHouse_h
	dw CeladonHotel_h ;id=140
	dw LavenderPokecenter_h
	dw PokemonTower1_h
	dw PokemonTower2_h
	dw PokemonTower3_h
	dw PokemonTower4_h
	dw PokemonTower5_h
	dw PokemonTower6_h
	dw PokemonTower7_h
	dw LavenderHouse1_h
	dw LavenderMart_h ;id=150
	dw LavenderHouse2_h
	dw FuchsiaMart_h
	dw FuchsiaHouse1_h
	dw FuchsiaPokecenter_h
	dw FuchsiaHouse2_h
	dw SafariZoneEntrance_h
	dw FuchsiaGym_h
	dw FuchsiaMeetingRoom_h
	dw SeafoamIslands2_h
	dw SeafoamIslands3_h ;id=160
	dw SeafoamIslands4_h
	dw SeafoamIslands5_h
	dw VermilionHouse2_h
	dw FuchsiaHouse3_h
	dw Mansion1_h
	dw CinnabarGym_h
	dw Lab1_h
	dw Lab2_h
	dw Lab3_h
	dw Lab4_h ;id=170
	dw CinnabarPokecenter_h
	dw CinnabarMart_h
	dw CinnabarMart_h ; unused
	dw IndigoPlateauLobby_h
	dw CopycatsHouseF1_h
	dw CopycatsHouseF2_h
	dw FightingDojo_h
	dw SaffronGym_h
	dw SaffronHouse1_h
	dw SaffronMart_h ;id=180
	dw SilphCo1_h
	dw SaffronPokecenter_h
	dw SaffronHouse2_h
	dw Route15Gate_h
	dw $563e
	dw Route16GateMap_h
	dw Route16GateUpstairs_h
	dw Route16House_h
	dw Route12House_h
	dw Route18Gate_h ;id=190
	dw Route18GateHeader_h
	dw SeafoamIslands1_h
	dw Route22Gate_h
	dw VictoryRoad2_h
	dw Route12GateUpstairs_h
	dw VermilionHouse3_h
	dw DiglettsCave_h
	dw VictoryRoad3_h
	dw RocketHideout1_h
	dw RocketHideout2_h ;200
	dw RocketHideout3_h
	dw RocketHideout4_h
	dw RocketHideoutElevator_h
	dw RocketHideoutElevator_h ; unused
	dw RocketHideoutElevator_h ; unused
	dw RocketHideoutElevator_h ; unused
	dw SilphCo2_h
	dw SilphCo3_h
	dw SilphCo4_h
	dw SilphCo5_h ;210
	dw SilphCo6_h
	dw SilphCo7_h
	dw SilphCo8_h
	dw Mansion2_h
	dw Mansion3_h
	dw Mansion4_h
	dw SafariZoneEast_h
	dw SafariZoneNorth_h
	dw SafariZoneWest_h
	dw SafariZoneCenter_h ;220
	dw SafariZoneRestHouse1_h
	dw SafariZoneSecretHouse_h
	dw SafariZoneRestHouse2_h
	dw SafariZoneRestHouse3_h
	dw SafariZoneRestHouse4_h
	dw UnknownDungeon2_h
	dw UnknownDungeon3_h
	dw UnknownDungeon1_h
	dw NameRater_h
	dw CeruleanHouse3_h
	dw Route16GateMap_h ; unused
	dw RockTunnel2_h
	dw SilphCo9_h
	dw SilphCo10_h
	dw SilphCo11_h
	dw SilphCoElevator_h
	dw SilphCo2_h ; unused
	dw SilphCo2_h ; unused
	dw BattleCenterM_h
	dw TradeCenterM_h
	dw SilphCo2_h ; unused
	dw SilphCo2_h ; unused
	dw SilphCo2_h ; unused
	dw SilphCo2_h ; unused
	dw Lorelei_h
	dw Bruno_h
	dw Agatha_h ;247

INCBIN "baserom.gbc",$39E,$1627 - $39E

;XXX what does this do
;XXX what points to this
; offset 1627
	ld bc,$D0B8
	add hl,bc
	ld a,[hli]
	ld [$D0AB],a
	ld a,[hl]
	ld [$D0AC],a

; offset 1633
; define (by index number) the bank that a pokemon's image is in
; index = Mew, bank 1
; index = Kabutops fossil, bank $B
;	index < $1F, bank 9
; $1F ≤ index < $4A, bank $A
; $4A ≤ index < $74, bank $B
; $74 ≤ index < $99, bank $C
; $99 ≤ index,       bank $D
	ld a,[$CF91] ; XXX name for this ram location
	ld b,a
	cp $15
	ld a,$01
	jr z,.GotBank\@
	ld a,b
	cp $B6
	ld a,$0B
	jr z,.GotBank\@
	ld a,b
	cp $1F
	ld a,$09
	jr c,.GotBank\@
	ld a,b
	cp $4A
	ld a,$0A
	jr c,.GotBank\@
	ld a,b
	cp $74
	ld a,$0B
	jr c,.GotBank\@
	ld a,b
	cp $99
	ld a,$0C
	jr c,.GotBank\@
	ld a,$0D
.GotBank\@
	jp $24FD

INCBIN "baserom.gbc",$1665,$172F - $1665

Tset0B_Coll:
	INCBIN "baserom.gbc",$172F,$1735-$172F
Tset00_Coll:
	INCBIN "baserom.gbc",$1735,$1749-$1735
Tset01_Coll:
	INCBIN "baserom.gbc",$1749,$1753-$1749
Tset02_Coll:
	INCBIN "baserom.gbc",$1753,$1759-$1753
Tset05_Coll:
	INCBIN "baserom.gbc",$1759,$1765-$1759
Tset03_Coll:
	INCBIN "baserom.gbc",$1765,$1775-$1765
Tset08_Coll:
	INCBIN "baserom.gbc",$1775,$177F-$1775
Tset09_Coll:
	INCBIN "baserom.gbc",$177F,$178A-$177F
Tset0D_Coll:
	INCBIN "baserom.gbc",$178A,$1795-$178A
Tset0E_Coll:
	INCBIN "baserom.gbc",$1795,$179A-$1795
Tset0F_Coll:
	INCBIN "baserom.gbc",$179A,$17A2-$179A
Tset10_Coll:
	INCBIN "baserom.gbc",$17A2,$17AC-$17A2
Tset11_Coll:
	INCBIN "baserom.gbc",$17AC,$17B8-$17AC
Tset12_Coll:
	INCBIN "baserom.gbc",$17B8,$17C0-$17B8
Tset13_Coll:
	INCBIN "baserom.gbc",$17C0,$17CA-$17C0
Tset14_Coll:
	INCBIN "baserom.gbc",$17CA,$17D1-$17CA
Tset15_Coll:
	INCBIN "baserom.gbc",$17D1,$17DD-$17D1
Tset16_Coll:
	INCBIN "baserom.gbc",$17DD,$17F0-$17DD
Tset17_Coll:
	INCBIN "baserom.gbc",$17F0,$190F-$17F0

ClearScreen: ; 190F
; clears all tiles in the tilemap,
; then wait three frames
	ld bc,$0168 ; tilemap size
	inc b
	ld hl,$C3A0 ; TILEMAP_START
	ld a,$7F    ; $7F is blank tile
.loop\@
	ld [hli],a
	dec c
	jr nz,.loop\@
	dec b
	jr nz,.loop\@
	jp Delay3

TextBoxBorder: ; 1922
; draw a text box
; upper-left corner at coordinates hl
; height b
; width c

	; first row
	push hl
	ld a,"┌"
	ld [hli],a
	inc a    ; horizontal border ─
	call NPlaceChar
	inc a    ; upper-right border ┐
	ld [hl],a

	; middle rows
	pop hl
	ld de,20
	add hl,de ; skip the top row

.PlaceRow\@
	push hl
	ld a,"│"
	ld [hli],a
	ld a," "
	call NPlaceChar
	ld [hl],"│"

	pop hl
	ld de,20
	add hl,de ; move to next row
	dec b
	jr nz,.PlaceRow\@

	; bottom row
	ld a,"└"
	ld [hli],a
	ld a,"─"
	call NPlaceChar
	ld [hl],"┘"
	ret
;
NPlaceChar:
; place a row of width c of identical characters
	ld d,c
.loop\@
	ld [hli],a
	dec d
	jr nz,.loop\@
	ret

PlaceString: ; 1955
	push hl
PlaceNextChar: ; 1956
	ld a,[de]

	cp "@"
	jr nz,.PlaceText\@
	ld b,h
	ld c,l
	pop hl
	ret

.PlaceText\@
	cp $4E
	jr nz,.next\@
	ld bc,$0028
	ld a,[$FFF6]
	bit 2,a
	jr z,.next2\@
	ld bc,$14
.next2\@
	pop hl
	add hl,bc
	push hl
	jp Next19E8

.next\@
	cp $4F
	jr nz,.next3\@
	pop hl
	ld hl,$C4E1
	push hl
	jp Next19E8

.next3\@ ; Check against a dictionary
	and a
	jp z,Char00
	cp $4C
	jp z,$1B0A
	cp $4B
	jp z,Char4B
	cp $51
	jp z,Char51
	cp $49
	jp z,Char49
	cp $52
	jp z,Char52
	cp $53
	jp z,Char53
	cp $54
	jp z,Char54
	cp $5B
	jp z,Char5B
	cp $5E
	jp z,Char5E
	cp $5C
	jp z,Char5C
	cp $5D
	jp z,Char5D
	cp $55
	jp z,$1A7C
	cp $56
	jp z,Char56
	cp $57
	jp z,$1AAD
	cp $58
	jp z,Char58
	cp $4A
	jp z,Char4A
	cp $5F
	jp z,Char5F
	cp $59
	jp z,Char59
	cp $5A
	jp z,Char5A
	ld [hli],a
	call $38D3
Next19E8:
	inc de
	jp PlaceNextChar

Char00:
	ld b,h
	ld c,l
	pop hl
	ld de,Char00Text
	dec de
	ret

Char00Text: ; “%d ERROR.”
	TX_FAR _Char00Text
	db "@"

Char52: ; player’s name
	push de
	ld de,W_PLAYERNAME
	jr FinishDTE

Char53: ; rival’s name
	push de
	ld de,W_RIVALNAME
	jr FinishDTE

Char5D: ; TRAINER
	push de
	ld de,Char5DText
	jr FinishDTE

Char5C: ; TM
	push de
	ld de,Char5CText
	jr FinishDTE

Char5B: ; PC
	push de
	ld de,Char5BText
	jr FinishDTE

Char5E: ; ROCKET
	push de
	ld de,Char5EText
	jr FinishDTE

Char54: ; POKé
	push de
	ld de,Char54Text
	jr FinishDTE

Char56: ; ……
	push de
	ld de,Char56Text
	jr FinishDTE

Char4A: ; PKMN
	push de
	ld de,Char4AText
	jr FinishDTE

Char59:
; depending on whose turn it is, print
; enemy active monster’s name, prefixed with “Enemy ”
; or
; player active monster’s name
; (like Char5A but flipped)
	ld a,[H_WHOSETURN]
	xor 1
	jr MonsterNameCharsCommon

Char5A:
; depending on whose turn it is, print
; player active monster’s name
; or
; enemy active monster’s name, prefixed with “Enemy ”
	ld a,[H_WHOSETURN]
MonsterNameCharsCommon:
	push de
	and a
	jr nz,.Enemy\@
	ld de,$D009 ; player active monster name
	jr FinishDTE

.Enemy\@ ; 1A40
	; print “Enemy ”
	ld de,Char5AText
	call PlaceString

	ld h,b
	ld l,c
	ld de,$CFDA ; enemy active monster name

FinishDTE:
	call PlaceString
	ld h,b
	ld l,c
	pop de
	inc de
	jp PlaceNextChar

Char5CText:
	db "TM@"
Char5DText:
	db "TRAINER@"
Char5BText:
	db "PC@"
Char5EText:
	db "ROCKET@"
Char54Text:
	db "POKé@"
Char56Text:
	db "……@"
Char5AText:
	db "Enemy @"
Char4AText:
	db $E1,$E2,"@" ; PKMN

Char55:
	push de
	ld b,h
	ld c,l
	ld hl,Char55Text
	call $1B40
	ld h,b
	ld l,c
	pop de
	inc de
	jp PlaceNextChar

Char55Text:
; equivalent to Char4B
	TX_FAR _Char55Text
	db "@"

Char5F:
; ends a Pokédex entry
	ld [hl],"."
	pop hl
	ret

Char58:
	ld a,[$D12B]
	cp 4
	jp z,Next1AA2
	ld a,$EE
	ld [$C4F2],a
Next1AA2:
	call ProtectedDelay3
	call $3898
	ld a,$7F
	ld [$C4F2],a
	pop hl
	ld de,Char58Text
	dec de
	ret

Char58Text:
	db "@"

Char51:
	push de
	ld a,$EE
	ld [$C4F2],a
	call ProtectedDelay3
	call $3898
	ld hl,$C4A5
	ld bc,$0412
	call $18C4
	ld c,$14
	call DelayFrames
	pop de
	ld hl,$C4B9
	jp Next19E8

Char49:
	push de
	ld a,$EE
	ld [$C4F2],a
	call ProtectedDelay3
	call $3898
	ld hl,$C469
	ld bc,$0712
	call $18C4
	ld c,$14
	call DelayFrames
	pop de
	pop hl
	ld hl,$C47D
	push hl
	jp Next19E8

Char4B:
	ld a,$EE
	ld [$C4F2],a
	call ProtectedDelay3
	push de
	call $3898
	pop de
	ld a,$7F
	ld [$C4F2],a
	push de
	call Next1B18
	call Next1B18
	ld hl,$C4E1
	pop de
	jp Next19E8

Next1B18:
	ld hl,$C4B8
	ld de,$C4A4
	ld b,$3C
.next\@
	ld a,[hli]
	ld [de],a
	inc de
	dec b
	jr nz,.next\@
	ld hl,$C4E1
	ld a,$7F
	ld b,$12
.next2\@
	ld [hli],a
	dec b
	jr nz,.next2\@

	; wait five frames
	ld b,5
.WaitFrame\@
	call DelayFrame
	dec b
	jr nz,.WaitFrame\@

	ret

ProtectedDelay3:
	push bc
	call Delay3
	pop bc
	ret

INCBIN "baserom.gbc",$1B40,$20AF - $1B40

DelayFrame: ; 20AF
; delay for one frame
	ld a,1
	ld [$FFD6],a

; wait for the next Vblank, halting to conserve battery
.halt\@
	db $76 ; XXX this is a hack--rgbasm adds a nop after this instr
	       ; even when ints are enabled
	ld a,[$FFD6]
	and a
	jr nz,.halt\@

	ret

; These routines manage gradual fading
; (e.g., entering a doorway)
LoadGBPal: ; 20BA
	ld a,[$d35d]		;tells if cur.map is dark
	ld b,a			;(requires HM5_FLASH?)
	ld hl,GBPalTable_00	;16
	ld a,l
	sub b
	ld l,a
	jr nc,.jr0\@
	dec h
.jr0\@
	ld a,[hli]
	ld [rBGP],a
	ld a,[hli]
	ld [rOBP0],a
	ld a,[hli]
	ld [rOBP1],a
	ret

GBFadeOut1: ; 20D1
	ld hl,IncGradGBPalTable_01	;0d
	ld b,$04
	jr GBFadeOutCommon

GBFadeOut2: ; 20D8
	ld hl,IncGradGBPalTable_02	;1c
	ld b,$03

GBFadeOutCommon:
	ld a,[hli]
	ld [rBGP],a
	ld a,[hli]
	ld [rOBP0],a
	ld a,[hli]
	ld [rOBP1],a
	ld c,8
	call DelayFrames
	dec b
	jr nz,GBFadeOutCommon
	ret

GBFadeIn1: ; 20EF
	ld hl,DecGradGBPalTable_01	;18
	ld b,$04
	jr GBFadeInCommon

GBFadeIn2: ; 20F6
	ld hl,DecGradGBPalTable_02	;21
	ld b,$03

GBFadeInCommon:
	ld a,[hld]
	ld [rOBP1],a
	ld a,[hld]
	ld [rOBP0],a
	ld a,[hld]
	ld [rBGP],a
	ld c,8
	call DelayFrames
	dec b
	jr nz,GBFadeInCommon
	ret

IncGradGBPalTable_01: ; 210D
	db %11111111	;BG Pal
	db %11111111	;OBJ Pal 1
	db %11111111	;OBJ Pal 2
			;and so on...
	db %11111110
	db %11111110
	db %11111000

	db %11111001
	db %11100100
	db %11100100
GBPalTable_00:		;16
	db %11100100
	db %11010000
DecGradGBPalTable_01:	;18
	db %11100000
	;19
	db %11100100
	db %11010000
	db %11100000
IncGradGBPalTable_02:	;1c
	db %10010000
	db %10000000
	db %10010000

	db %01000000
	db %01000000
DecGradGBPalTable_02:	;21
	db %01000000

	db %00000000
	db %00000000
	db %00000000

INCBIN "baserom.gbc",$2125,$2442 - $2125

; XXX where is the pointer to this data?
MartInventories: ; 2442
	; first byte $FE, next byte # of items, last byte $FF

; Viridian
ViridianMartText4: ; XXX confirm
	db $FE,4,POKE_BALL,ANTIDOTE,PARLYZ_HEAL,BURN_HEAL,$FF

; Pewter
PewterMartText1:
	db $FE,7,POKE_BALL,POTION,ESCAPE_ROPE,ANTIDOTE,BURN_HEAL,AWAKENING
	db PARLYZ_HEAL,$FF

; Cerulean
CeruleanMartText1:
	db $FE,7,POKE_BALL,POTION,REPEL,ANTIDOTE,BURN_HEAL,AWAKENING
	db PARLYZ_HEAL,$FF

; Bike shop
	db $FE,1,BICYCLE,$FF

; Vermilion
VermilionMartText1:
	db $FE,6,POKE_BALL,SUPER_POTION,ICE_HEAL,AWAKENING,PARLYZ_HEAL
	db REPEL,$FF

; Lavender
LavenderMartText1:
	db $FE,9,GREAT_BALL,SUPER_POTION,REVIVE,ESCAPE_ROPE,SUPER_REPEL
	db ANTIDOTE,BURN_HEAL,ICE_HEAL,PARLYZ_HEAL,$FF

; Celadon Dept. Store 2F (1)
CeladonMart2Text1:
	db $FE,9,GREAT_BALL,SUPER_POTION,REVIVE,SUPER_REPEL,ANTIDOTE
	db BURN_HEAL,ICE_HEAL,AWAKENING,PARLYZ_HEAL,$FF

; Celadon Dept. Store 2F (2)
CeladonMart2Text2:
	db $FE,9,TM_32,TM_33,TM_02,TM_07,TM_37,TM_01,TM_05,TM_09,TM_17,$FF

; Celadon Dept. Store 4F
CeladonMart4Text1:
	db $FE,5,POKE_DOLL,FIRE_STONE,THUNDER_STONE,WATER_STONE,LEAF_STONE,$FF

; Celadon Dept. Store 5F (1)
CeladonMart5Text3:
	db $FE,7,X_ACCURACY,GUARD_SPEC_,DIRE_HIT,X_ATTACK,X_DEFEND,X_SPEED
	db X_SPECIAL,$FF

; Celadon Dept. Store 5F (2)
CeladonMart5Text4:
	db $FE,5,HP_UP,PROTEIN,IRON,CARBOS,CALCIUM,$FF

; Fuchsia
FuchsiaMartText1:
	db $FE,6,ULTRA_BALL,GREAT_BALL,SUPER_POTION,REVIVE,FULL_HEAL
	db SUPER_REPEL,$FF

; unused?
	db $FE,5,GREAT_BALL,HYPER_POTION,SUPER_POTION,FULL_HEAL,REVIVE,$FF

; Cinnabar
CinnabarMartText1:
	db $FE,7,ULTRA_BALL,GREAT_BALL,HYPER_POTION,MAX_REPEL,ESCAPE_ROPE
	db FULL_HEAL,REVIVE,$FF

; Saffron
SaffronMartText1:
	db $FE,6,GREAT_BALL,HYPER_POTION,MAX_REPEL,ESCAPE_ROPE,FULL_HEAL
	db REVIVE,$FF

; Indigo
IndigoPlateauLobbyText4:
	db $FE,7,ULTRA_BALL,GREAT_BALL,FULL_RESTORE,MAX_POTION,FULL_HEAL
	db REVIVE,MAX_REPEL,$FF

TextScriptEndingChar:
        db "@"
TextScriptEnd: ; 24D7 24d7
        ld hl,TextScriptEndingChar
        ret

UnnamedText_24db: ; 0x24db
    TX_FAR _UnnamedText_24db
    db $50
; 0x24db + 5 bytes

UnnamedText_24e0: ; 0x24e0
    TX_FAR _UnnamedText_24e0
    db $50
; 0x24e0 + 5 bytes

VictoryRoad3Text10:
VictoryRoad3Text9:
VictoryRoad3Text8:
VictoryRoad3Text7:
VictoryRoad2Text13:
VictoryRoad2Text12:
VictoryRoad2Text11:
SeafoamIslands1Text2:
SeafoamIslands1Text1:
SeafoamIslands5Text2:
SeafoamIslands5Text1:
SeafoamIslands4Text6:
SeafoamIslands4Text5:
SeafoamIslands4Text4:
SeafoamIslands4Text3:
SeafoamIslands4Text2:
SeafoamIslands4Text1:
SeafoamIslands3Text2:
SeafoamIslands3Text1:
SeafoamIslands2Text2:
SeafoamIslands2Text1:
FuchsiaHouse2Text3:
VictoryRoad1Text7:
VictoryRoad1Text6: ; _VictoryRoad1Text6
VictoryRoad1Text5: ; 0x24e5
    TX_FAR _VictoryRoad1Text5
    db $50

SaffronCityText19:
CinnabarIslandText4:
FuchsiaCityText14:
VermilionCityText9:
LavenderTownText6:
CeruleanCityText14:
PewterCityText8:
ViridianCityText11: ; 0x24ea
    TX_FAR _ViridianCityText11
    db $50

PewterCityText9:
CeruleanCityText15:
LavenderTownText7:
VermilionCityText10:
CeladonCityText12:
FuchsiaCityText15:
CinnabarIslandText5:
SaffronCityText23:
Route4Text4:
Route10Text8:
ViridianCityText12: ; 0x24ef
    TX_FAR _ViridianCityText12
    db $50

Route2Text1:
Route4Text3:
Route9Text10:
Route12Text9:
Route12Text10:
Route15Text11:
Route24Text8:
Route25Text10:
ViridianGymText11:
ViridianForestText5:
ViridianForestText6:
ViridianForestText7:
MtMoon1Text8:
MtMoon1Text9:
MtMoon1Text10:
MtMoon1Text11:
MtMoon1Text12:
MtMoon1Text13:
MtMoon3Text8:
MtMoon3Text9:
PowerPlantText10:
PowerPlantText11:
PowerPlantText12:
PowerPlantText13:
PowerPlantText14:
SSAnne8Text10:
SSAnne9Text6:
SSAnne9Text9:
SSAnne10Text9:
SSAnne10Text10:
SSAnne10Text11:
VictoryRoad1Text3:
VictoryRoad1Text4:
PokemonTower3Text4:
PokemonTower4Text4:
PokemonTower4Text5:
PokemonTower4Text6:
PokemonTower5Text6:
PokemonTower6Text4:
PokemonTower6Text5:
FuchsiaHouse2Text2:
VictoryRoad2Text7:
VictoryRoad2Text8:
VictoryRoad2Text9:
VictoryRoad2Text10:
VictoryRoad3Text5:
VictoryRoad3Text6:
RocketHideout1Text6:
RocketHideout1Text7:
RocketHideout2Text2:
RocketHideout2Text3:
RocketHideout2Text4:
RocketHideout2Text5:
RocketHideout3Text3:
RocketHideout3Text4:
RocketHideout4Text5:
RocketHideout4Text6:
RocketHideout4Text7:
RocketHideout4Text8:
RocketHideout4Text9:
SilphCo3Text4:
SilphCo4Text5:
SilphCo4Text6:
SilphCo4Text7:
SilphCo5Text6:
SilphCo5Text7:
SilphCo5Text8:
SilphCo6Text9:
SilphCo6Text10:
SilphCo7Text10:
SilphCo7Text11:
SilphCo7Text12:
Mansion1Text2:
Mansion1Text3:
Mansion2Text2:
Mansion3Text3:
Mansion3Text4:
Mansion4Text3:
Mansion4Text4:
Mansion4Text5:
Mansion4Text6:
Mansion4Text8:
SafariZoneEastText1:
SafariZoneEastText2:
SafariZoneEastText3:
SafariZoneEastText4:
SafariZoneNorthText1:
SafariZoneNorthText2:
SafariZoneWestText1:
SafariZoneWestText2:
SafariZoneWestText3:
SafariZoneWestText4:
SafariZoneCenterText1:
UnknownDungeon2Text1:
UnknownDungeon2Text2:
UnknownDungeon2Text3:
UnknownDungeon3Text2:
UnknownDungeon3Text3:
UnknownDungeon1Text1:
UnknownDungeon1Text2:
UnknownDungeon1Text3:
SilphCo10Text4:
SilphCo10Text5:
SilphCo10Text6:
Route2Text2: ; 24f4 0x424f4
    db $08 ; asm
    ld a, $5c
    call Predef
    jp $24d7

INCBIN "baserom.gbc",$24fd,$2a55 - $24fd

UnnamedText_2a55: ; 0x2a55
    TX_FAR _UnnamedText_2a55
    db $50
; 0x2a55 + 5 bytes

INCBIN "baserom.gbc",$2a5a,$2aa4 - $2a5a

UnnamedText_2aa4: ; 0x2aa4
    TX_FAR _UnnamedText_2aa4
    db $50
; 0x2aa4 + 5 bytes

INCBIN "baserom.gbc",$2aa9,$2aba - $2aa9

UnnamedText_2aba: ; 0x2aba
    TX_FAR _UnnamedText_2aba
    db $50
; 0x2aba + 5 bytes

INCBIN "baserom.gbc",$2abf,$2ac8 - $2abf

UnnamedText_2ac8: ; 0x2ac8
    TX_FAR _UnnamedText_2ac8
    db $50
; 0x2ac8 + 5 bytes

INCBIN "baserom.gbc",$2acd,$4d1

GetMonName: ; 2F9E
	push hl
	ld a,[$ffb8]
	push af
	ld a,BANK(MonsterNames) ; 07
	ld [$ffb8],a
	ld [$2000],a
	ld a,[$d11e]
	dec a
	ld hl,MonsterNames ; 421E
	ld c,10
	ld b,0
	call AddNTimes
	ld de,$cd6d
	push de
	ld bc,10
	call CopyData
	ld hl,$cd77
	ld [hl],$50
	pop de
	pop af
	ld [$ffb8],a
	ld [$2000],a
	pop hl
	ret

GetItemName: ; 2FCF
; given an item ID at [$D11E], store the name of the item into a string
;     starting at $CD6D
	push hl
	push bc
	ld a,[$D11E]
	cp HM_01 ; is this a TM/HM?
	jr nc,.Machine\@

	ld [$D0B5],a
	ld a,ITEM_NAME
	ld [$D0B6],a
	ld a,BANK(ItemNames)
	ld [$D0B7],a
	call GetName
	jr .Finish\@

.Machine\@
	call GetMachineName
.Finish\@
	ld de,$CD6D ; pointer to where item name is stored in RAM
	pop bc
	pop hl
	ret

GetMachineName:
; copies the name of the TM/HM in [$D11E] to $CD6D
	push hl
	push de
	push bc
	ld a,[$D11E]
	push af
	cp TM_01 ; is this a TM? [not HM]
	jr nc,.WriteTM\@
; if HM, then write "HM" and add 5 to the item ID, so we can reuse the
; TM printing code
	add 5
	ld [$D11E],a
	ld hl,HiddenPrefix ; points to "HM"
	ld bc,2
	jr .WriteMachinePrefix\@
.WriteTM\@
	ld hl,TechnicalPrefix ; points to "TM"
	ld bc,2
.WriteMachinePrefix\@
	ld de,$CD6D
	call CopyData

; now get the machine number and convert it to text
	ld a,[$D11E]
	sub TM_01 - 1
	ld b,$F6 ; "0"
.FirstDigit\@
	sub 10
	jr c,.SecondDigit\@
	inc b
	jr .FirstDigit\@
.SecondDigit\@
	add 10
	push af
	ld a,b
	ld [de],a
	inc de
	pop af
	ld b,$F6 ; "0"
	add b
	ld [de],a
	inc de
	ld a,"@"
	ld [de],a

	pop af
	ld [$D11E],a
	pop bc
	pop de
	pop hl
	ret

TechnicalPrefix:
	db "TM"
HiddenPrefix:
	db "HM"

INCBIN "baserom.gbc",$3040,$31cc - $3040

LoadTrainerHeader: ; 0x31cc
    call $3157
    xor a
    call $3193
    ld a, $2
    call $3193
    ld a, [$cc55]
    ld c, a
    ld b, $2
    call $31c7
    ld a, c
    and a
    jr z, .asm_c2964 ; 0x31e3 $8
    ld a, $6
    call $3193
    jp PrintText
.asm_c2964 ; 0x31ed
    ld a, $4
    call $3193
    call PrintText
    ld a, $a
    call $3193
    push de
    ld a, $8
    call $3193
    pop de
    call $3354
    ld hl, $d733
    set 4, [hl]
    ld hl, $cd60
    bit 0, [hl]
    ret nz
    call $336a
    ld hl, $da39
    inc [hl]
    jp $325d
    call $3306
    ld a, [$cf13]
    cp $ff
    jr nz, .asm_76c22 ; 0x3221 $8
    xor a
    ld [$cf13], a
    ld [$cc55], a
    ret
.asm_76c22 ; 0x322b
    ld hl, $d733
    set 3, [hl]
    ld [$cd4f], a
    xor a
    ld [$cd50], a
    ld a, $4c
    call Predef
    ld a, $f0
    ld [$cd6b], a
    xor a
    ldh [$b4], a
    call $32cf
    ld hl, $da39
    inc [hl]
    ret

INCBIN "baserom.gbc",$324c,$3474 - $324c

FuncTX_F7: ; 3474
; XXX find a better name for this function
; special_F7
        ld b,BANK(CeladonPrizeMenu)
        ld hl,CeladonPrizeMenu
        call Bankswitch
        jp $29DF        ; continue to main text-engine function

INCBIN "baserom.gbc",$347F,$3493 - $347F

IsItemInBag: ; 3493
; given an item_id in b
; set zero flag if item isn't in player's bag
; else reset zero flag
; related to Pokémon Tower and ghosts
	ld a,$1C
	call Predef
	ld a,b
	and a
	ret

INCBIN "baserom.gbc",$349B,$3541 - $349B

Function3541: ; 3541
; XXX what do these three functions do
	push hl
	call Function354E
	ld [hl],$FF
	call Function3558
	ld [hl],$FF ; prevent person from walking?
	pop hl
	ret

Function354E: ; 354E
	ld h,$C2
	ld a,[$FF8C] ; the sprite to move
	swap a
	add a,6
	ld l,a
	ret

Function3558: ; 3558
	push de
	ld hl,W_PEOPLEMOVEPERMISSIONS
	ld a,[$FF8C] ; the sprite to move
	dec a
	add a
	ld d,0
	ld e,a
	add hl,de
	pop de
	ret

INCBIN "baserom.gbc",$3566,$35BC - $3566

BankswitchHome: ; 35BC
; switches to bank # in a
; Only use this when in the home bank!
	ld [$CF09],a
	ld a,[$FFB8]
	ld [$CF08],a
	ld a,[$CF09]
	ld [$FFB8],a
	ld [$2000],a
	ret

BankswitchBack: ; 35CD
; returns from BankswitchHome
	ld a,[$CF08]
	ld [$FFB8],a
	ld [$2000],a
	ret

Bankswitch: ; 35D6
; self-contained bankswitch, use this when not in the home bank
; switches to the bank in b
	ld a,[$FFB8]
	push af
	ld a,b
	ld [$FFB8],a
	ld [$2000],a
	ld bc,.Return\@
	push bc
	jp [hl]
.Return\@
	pop bc
	ld a,b
	ld [$FFB8],a
	ld [$2000],a
	ret

INCBIN "baserom.gbc",$35EC,$363A - $35EC

MoveSprite: ; 363A
; move the sprite [$FF8C] with the movement pointed to by de
; actually only copies the movement data to $CC5B for later
	call Function3541
	push hl
	push bc
	call Function354E
	xor a
	ld [hl],a
	ld hl,$CC5B
	ld c,0

.loop\@
	ld a,[de]
	ldi [hl],a
	inc de
	inc c
	cp a,$FF ; have we reached the end of the movement data?
	jr nz,.loop\@

	ld a,c
	ld [$CF0F],a ; number of steps taken

	pop bc
	ld hl,$D730
	set 0,[hl]
	pop hl
	xor a
	ld [$CD3B],a
	ld [$CCD3],a
	dec a
	ld [$CD6B],a
	ld [$CD3A],a
	ret

INCBIN "baserom.gbc",$366B,$3739 - $366B

DelayFrames: ; 3739
; wait n frames, where n is the value in c
	call DelayFrame
	dec c
	jr nz,DelayFrames
	ret

INCBIN "baserom.gbc",$3740,$375D - $3740

NamePointers: ; 375D
	dw MonsterNames
	dw MoveNames
	dw UnusedNames
	dw ItemNames
	dw $D273 ; player's OT names list
	dw $D9AC ; enemy's OT names list
	dw TrainerNames

GetName: ; 376B
; arguments:
; [$D0B5] = which name
; [$D0B6] = which list
; [$D0B7] = bank of list
;
; returns pointer to name in de
	ld a,[$d0b5]
	ld [$d11e],a
	cp a,$C4        ;it's TM/HM
	jp nc,GetMachineName
	ld a,[$ffb8]
	push af
	push hl
	push bc
	push de
	ld a,[$d0b6]    ;List3759_entrySelector
	dec a
	jr nz,.otherEntries\@
	;1 = MON_NAMES
	call GetMonName
	ld hl,11
	add hl,de
	ld e,l
	ld d,h
	jr .gotPtr\@
.otherEntries\@ ;$378d
	;2-7 = OTHER ENTRIES
	ld a,[$d0b7]
	ld [$ffb8],a
	ld [$2000],a
	ld a,[$d0b6]    ;VariousNames' entryID
	dec a
	add a
	ld d,0
	ld e,a
	jr nc,.skip\@
	inc d
.skip\@ ;$37a0
	ld hl,NamePointers
	add hl,de
	ld a,[hli]
	ld [$ff96],a
	ld a,[hl]
	ld [$ff95],a
	ld a,[$ff95]
	ld h,a
	ld a,[$ff96]
	ld l,a
	ld a,[$d0b5]
	ld b,a
	ld c,0
.nextName\@
	ld d,h
	ld e,l
.nextChar\@
	ld a,[hli]
	cp a,$50
	jr nz,.nextChar\@
	inc c           ;entry counter
	ld a,b          ;wanted entry
	cp c
	jr nz,.nextName\@
	ld h,d
	ld l,e
	ld de,$cd6d
	ld bc,$0014
	call CopyData
.gotPtr\@       ;$37cd
	ld a,e
	ld [$cf8d],a
	ld a,d
	ld [$cf8e],a
	pop de
	pop bc
	pop hl
	pop af
	ld [$ffb8],a
	ld [$2000],a
	ret

INCBIN "baserom.gbc",$37df,$3927 - $37df

AddPokemonToParty: ; 0x3927
    push hl
    push de
    push bc
    ld b, $3 ; BANK(MyFunction)
    ld hl, $72e5 ; MyFunction
    call Bankswitch
    pop bc
    pop de
    pop hl
    ret

INCBIN "baserom.gbc",$3936,$3A87 - $3936

AddNTimes: ; 3A87
; add bc to hl a times
	and a
	ret z
.loop\@
	add hl,bc
	dec a
	jr nz,.loop\@
	ret

INCBIN "baserom.gbc",$3A8E,$3C49 - $3A8E

PrintText: ; 3C49
; given a pointer in hl, print the text there
	push hl
	ld a,1
	ld [$D125],a
	call $30E8
	call $2429
	call Delay3
	pop hl
        FuncCoord 1,14
	ld bc,Coord ;$C4B9
	jp $1B40

Func3C5F: ; 3C5F
	push bc
	xor a
	ld [$FF95],a
	ld [$FF96],a
	ld [$FF97],a
	ld a,b
	and $F
	cp 1
	jr z,.next\@
	cp 2
	jr z,.next2\@
	ld a,[de]
	ld [$FF96],a
	inc de
	ld a,[de]
	ld [$FF97],a
	inc de
	ld a,[de]
	ld [$FF98],a
	jr .next3\@

.next2\@
	ld a,[de]
	ld [$FF97],a
	inc de
	ld a,[de]
	ld [$FF98],a
	jr .next3\@

.next\@
	ld a,[de]
	ld [$FF98],a

.next3\@
	push de
	ld d,b
	ld a,c
	ld b,a
	xor a
	ld c,a
	ld a,b
	cp 2
	jr z,.next4\@
	cp 3
	jr z,.next5\@
	cp 4
	jr z,.next6\@
	cp 5
	jr z,.next7\@
	cp 6
	jr z,.next8\@
	ld a,$F
	ld [$FF99],a
	ld a,$42
	ld [$FF9A],a
	ld a,$40
	ld [$FF9B],a
	call $3D25
	call $3D89
.next8\@
	ld a,1
	ld [$FF99],a
	ld a,$86
	ld [$FF9A],a
	ld a,$A0
	ld [$FF9B],a
	call $3D25
	call $3D89
.next7\@
	xor a
	ld [$FF99],a
	ld a,$27
	ld [$FF9A],a
	ld a,$10
	ld [$FF9B],a
	call $3D25
	call $3D89
.next6\@
	xor a
	ld [$FF99],a
	ld a,3
	ld [$FF9A],a
	ld a,$E8
	ld [$FF9B],a
	call $3D25
	call $3D89
.next5\@
	xor a
	ld [$FF99],a
	xor a
	ld [$FF9A],a
	ld a,$64
	ld [$FF9B],a
	call $3D25
	call $3D89
.next4\@
	ld c,0
	ld a,[$FF98]
.next10\@
	cp $A
	jr c,.next9\@
	sub $A
	inc c
	jr .next10\@
.next9\@
	ld b,a
	ld a,[$FF95]
	or c
	ld [$FF95],a
	jr nz,.next11\@
	call $3D83
	jr .next12\@
.next11\@
	ld a,$F6
	add a,c
	ld [hl],a
.next12\@
	call $3D89
	ld a,$F6
	add a,b
	ld [hli],a
	pop de
	dec de
	pop bc
	ret

INCBIN "baserom.gbc",$3D25,$3DAB - $3D25

IsInArray: ; 3DAB
; searches an array at hl for the value in a.
; skips (de − 1) bytes between reads, so to check every byte, de should be 1.
; if found, returns count in b and sets carry.
	ld b,0
	ld c,a
.loop\@
	ld a,[hl]
	cp a,$FF
	jr z,.NotInArray\@
	cp c
	jr z,.InArray\@
	inc b
	add hl,de
	jr .loop\@
.NotInArray\@
	and a
	ret
.InArray\@
	scf
	ret

INCBIN "baserom.gbc",$3DBE,$3DD7 - $3DBE

Delay3: ; 3DD7
; call Delay with a parameter of 3
	ld c,3
	jp DelayFrames

INCBIN "baserom.gbc",$3DDC,$3DED - $3DDC

GoPAL_SET_CF1C:	; 3ded
	ld b,$ff
GoPAL_SET: 	; 3def
	ld a,[$cf1b]
	and a
	ret z
	ld a,$45
	jp Predef

INCBIN "baserom.gbc",$3df9,$3e2e - $3df9

GiveItem: ; 0x3e2e
    ld a, b
    ld [$d11e], a
    ld [$cf91], a
    ld a, c
    ld [$cf96], a
    ld hl,W_NUMBAGITEMS
    call $2bcf
    ret nc
    call GetItemName ; $2fcf
    call $3826
    scf
    ret

GivePokemon: ; 0x3e48
    ld a, b
    ld [$cf91], a
    ld a, c
    ld [$d127], a
    xor a
    ld [$cc49], a
    ld b, $13
    ld hl, $7da5
    jp Bankswitch

GenRandom: ; 3E5C
; store a random 8-bit value in a
	push hl
	push de
	push bc
	ld b,BANK(GenRandom_)
	ld hl,GenRandom_
	call Bankswitch
	ld a,[H_RAND1]
	pop bc
	pop de
	pop hl
	ret

Predef: ; 3E6D
; runs a predefined ASM command, where the command ID is read from $D0B7
; $3E6D grabs the ath pointer from PredefPointers and executes it

	ld [$CC4E],a ; save the predef routine's ID for later

	ld a,[$FFB8]
	ld [$CF12],a

	; save bank and call 13:7E49
	push af
	ld a,BANK(GetPredefPointer)
	ld [$FFB8],a
	ld [$2000],a
	call GetPredefPointer

	; call the predef function
	; ($D0B7 has the bank of the predef routine)
	ld a,[$D0B7]
	ld [$FFB8],a
	ld [$2000],a
	ld de,.Return\@
	push de
	jp [hl]
	; after the predefined function finishes it returns here
.Return\@
	pop af
	ld [$FFB8],a
	ld [$2000],a
	ret

INCBIN "baserom.gbc",$3E94,$4000 - $3E94

SECTION "bank1",DATA,BANK[$1]

INCBIN "baserom.gbc",$4000,$112

MewPicFront:
	INCBIN "pic/bmon/mew.pic"
MewPicBack:
	INCBIN "pic/monback/mewb.pic"

INCBIN "baserom.gbc",$425b,$42a7 - $425b

UnnamedText_42a7: ; 0x42a7
    TX_FAR SafariZoneEatingText
    db $50
; 0x42a7 + 5 bytes

UnnamedText_42ac: ; 0x42ac
    TX_FAR SafariZoneAngryText
    db $50
; 0x42ac + 5 bytes

INCBIN "baserom.gbc",$42b1,$84

IF _RED
	ld de,$9600 ; where to put redgreenversion.2bpp in the VRAM
	ld bc,$50 ; how big that file is
ENDC
IF _BLUE
	ld de,$9610 ; where to put blueversion.2bpp in the VRAM
	ld bc,$40 ; how big that file is
ENDC

INCBIN "baserom.gbc",$433B,$4398-$433B

IF _RED
	ld a,CHARMANDER ; which Pokemon to show first on the title screen
ENDC
IF _BLUE
	ld a,SQUIRTLE ; which Pokemon to show first on the title screen
ENDC

INCBIN "baserom.gbc",$439A,$4588-$439A

TitleMons: ; 4588
; mons on the title screen are randomly chosen from here
IF _RED
	db CHARMANDER
	db SQUIRTLE
	db BULBASAUR
	db WEEDLE
	db NIDORAN_M
	db SCYTHER
	db PIKACHU
	db CLEFAIRY
	db RHYDON
	db ABRA
	db GASTLY
	db DITTO
	db PIDGEOTTO
	db ONIX
	db PONYTA
	db MAGIKARP
ENDC
IF _GREEN
	db BULBASAUR
	db CHARMANDER
	db SQUIRTLE
	db CATERPIE
	db NIDORAN_F
	db PINSIR
	db PIKACHU
	db CLEFAIRY
	db RHYDON
	db ABRA
	db GASTLY
	db DITTO
	db PIDGEOTTO
	db ONIX
	db PONYTA
	db MAGIKARP
ENDC
IF _BLUE
	db SQUIRTLE
	db CHARMANDER
	db BULBASAUR
	db MANKEY
	db HITMONLEE
	db VULPIX
	db CHANSEY
	db AERODACTYL
	db JOLTEON
	db SNORLAX
	db GLOOM
	db POLIWAG
	db DODUO
	db PORYGON
	db GENGAR
	db RAICHU
ENDC

INCBIN "baserom.gbc",$4598,$45A1-$4598

; xxx Version tilemap on the title screen
IF _RED
	db $60,$61,$7F,$65,$66,$67,$68,$69,$50
ENDC
IF _BLUE
	db $61,$62,$63,$64,$65,$66,$67,$68,$50
ENDC

INCBIN "baserom.gbc",$45AA,$472B-$45AA

ItemNames: ; 472B
	db "MASTER BALL@"
	db "ULTRA BALL@"
	db "GREAT BALL@"
	db "POKé BALL@"
	db "TOWN MAP@"
	db "BICYCLE@"
	db "?????@"
	db "SAFARI BALL@"
	db "POKéDEX@"
	db "MOON STONE@"
	db "ANTIDOTE@"
	db "BURN HEAL@"
	db "ICE HEAL@"
	db "AWAKENING@"
	db "PARLYZ HEAL@"
	db "FULL RESTORE@"
	db "MAX POTION@"
	db "HYPER POTION@"
	db "SUPER POTION@"
	db "POTION@"
	db "BOULDERBADGE@"
	db "CASCADEBADGE@"
	db "THUNDERBADGE@"
	db "RAINBOWBADGE@"
	db "SOULBADGE@"
	db "MARSHBADGE@"
	db "VOLCANOBADGE@"
	db "EARTHBADGE@"
	db "ESCAPE ROPE@"
	db "REPEL@"
	db "OLD AMBER@"
	db "FIRE STONE@"
	db "THUNDERSTONE@"
	db "WATER STONE@"
	db "HP UP@"
	db "PROTEIN@"
	db "IRON@"
	db "CARBOS@"
	db "CALCIUM@"
	db "RARE CANDY@"
	db "DOME FOSSIL@"
	db "HELIX FOSSIL@"
	db "SECRET KEY@"
	db "?????@"
	db "BIKE VOUCHER@"
	db "X ACCURACY@"
	db "LEAF STONE@"
	db "CARD KEY@"
	db "NUGGET@"
	db "PP UP@"
	db "POKé DOLL@"
	db "FULL HEAL@"
	db "REVIVE@"
	db "MAX REVIVE@"
	db "GUARD SPEC.@"
	db "SUPER REPEL@"
	db "MAX REPEL@"
	db "DIRE HIT@"
	db "COIN@"
	db "FRESH WATER@"
	db "SODA POP@"
	db "LEMONADE@"
	db "S.S.TICKET@"
	db "GOLD TEETH@"
	db "X ATTACK@"
	db "X DEFEND@"
	db "X SPEED@"
	db "X SPECIAL@"
	db "COIN CASE@"
	db "OAK's PARCEL@"
	db "ITEMFINDER@"
	db "SILPH SCOPE@"
	db "POKé FLUTE@"
	db "LIFT KEY@"
	db "EXP.ALL@"
	db "OLD ROD@"
	db "GOOD ROD@"
	db "SUPER ROD@"
	db "PP UP@"
	db "ETHER@"
	db "MAX ETHER@"
	db "ELIXER@"
	db "MAX ELIXER@"
	db "B2F@"
	db "B1F@"
	db "1F@"
	db "2F@"
	db "3F@"
	db "4F@"
	db "5F@"
	db "6F@"
	db "7F@"
	db "8F@"
	db "9F@"
	db "10F@"
	db "11F@"
	db "B4F@"

UnusedNames: ; 4A92
	db "かみなりバッヂ@"
	db "かいがらバッヂ@"
	db "おじぞうバッヂ@"
	db "はやぶさバッヂ@"
	db "ひんやりバッヂ@"
	db "なかよしバッヂ@"
	db "バラバッヂ@"
	db "ひのたまバッヂ@"
	db "ゴールドバッヂ@"
	db "たまご@"
	db "ひよこ@"
	db "ブロンズ@"
	db "シルバー@"
	db "ゴールド@"
	db "プチキャプテン@"
	db "キャプテン@"
	db "プチマスター@"
	db "マスター@"

INCBIN "baserom.gbc",$4b09,$4e2c - $4b09

UnnamedText_4e2c: ; 0x4e2c
    TX_FAR _UnnamedText_4e2c
    db $50
; 0x4e2c + 5 bytes

INCBIN "baserom.gbc",$4e31,$5a24 - $4e31

UnnamedText_5a24: ; 0x5a24
    TX_FAR _UnnamedText_5a24
    db $50
; 0x5a24 + 5 bytes

INCBIN "baserom.gbc",$5a29,$c9

MainMenu:
; Check save file
	call Func_5bff
	xor a
	ld [$D08A],a
	inc a
	ld [$D088],a
	call $609E
	jr nc,.next0\@

	; Predef 52 loads the save from SRAM to RAM
	ld a,$52
	call Predef

.next0\@
	ld c,20
	call DelayFrames
	xor a
	ld [$D12B],a
	ld hl,$CC2B
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld [$D07C],a
	ld hl,$D72E
	res 6,[hl]
	call ClearScreen
	call $3DED
	call $36A0 ; load some graphics in VRAM
	call $3680 ; load fonts in VRAM
	ld hl,$D730
	set 6,[hl]
	ld a,[$D088]
	cp a,1
	jr z,.next1\@
	FuncCoord 0,0
	ld hl,Coord
	ld b,6
	ld c,13
	call TextBoxBorder
	FuncCoord 2,2
	ld hl,Coord
	ld de,$5D7E
	call PlaceString
	jr .next2\@
.next1\@
	FuncCoord 0,0
	ld hl,Coord
	ld b,4
	ld c,13
	call TextBoxBorder
	FuncCoord 2,2
	ld hl,Coord
	ld de,$5D87
	call PlaceString
.next2\@
	ld hl,$D730
	res 6,[hl]
	call $2429 ; OAM?
	xor a
	ld [$CC26],a
	ld [$CC2A],a
	ld [$CC34],a
	inc a
	ld [$CC25],a
	inc a
	ld [$CC24],a
	ld a,$B
	ld [$CC29],a
	ld a,[$D088]
	ld [$CC28],a
	call $3ABE
	bit 1,a
	jp nz,$42DD ; load title screen (gfx and arrangement)
	ld c,20
	call DelayFrames
	ld a,[$CC26]
	ld b,a
	ld a,[$D088]
	cp a,2
	jp z,.next3\@
	inc b ; adjust MenuArrow_Counter
.next3\@
	ld a,b
	and a
	jr z,.next4\@ ; if press_A on Continue
	cp a,1
	jp z,$5D52 ; if press_A on NewGame
	call $5E8A ; if press_a on Options
	ld a,1
	ld [$D08A],a
	jp .next0\@
.next4\@
	call $5DB5
	ld hl,$D126
	set 5,[hl]
.next6\@
	xor a
	ld [$FFB3],a
	ld [$FFB2],a
	ld [$FFB4],a
	call $19A
	ld a,[$FFB4]
	bit 0,a
	jr nz,.next5\@
	bit 1,a
	jp nz,.next0\@
	jr .next6\@
.next5\@
	call $3DD4
	call ClearScreen
	ld a,4
	ld [$D52A],a
	ld c,10
	call DelayFrames
	ld a,[$D5A2]
	and a
	jp z,$5D5F
	ld a,[W_CURMAP] ; map ID
	cp a,$76 ; Hall of Fame
	jp nz,$5D5F
	xor a
	ld [$D71A],a
	ld hl,$D732
	set 2,[hl]
	call $62CE
	jp $5D5F
Func_5bff:
	ld a,1
	ld [$D358],a
	ld a,3
	ld [$D355],a
	ret

INCBIN "baserom.gbc",$5c0a,$5d43 - $5c0a

UnnamedText_5d43: ; 0x5d43
    TX_FAR _UnnamedText_5d43
    db $50
; 0x5d43 + 5 bytes

UnnamedText_5d48: ; 0x5d48
    TX_FAR _UnnamedText_5d48
    db $50
; 0x5d48 + 5 bytes

UnnamedText_5d4d: ; 0x5d4d
    TX_FAR _UnnamedText_5d4d
    db $50
; 0x5d4d + 5 bytes

INCBIN "baserom.gbc",$5d52,$3c3

OakSpeech: ; 6115
	ld a,$FF
	call $23B1 ; stop music
	ld a,2     ; bank of song
	ld c,a
	ld a,$EF    ; song #
	call $23A1  ; plays music
	call ClearScreen
	call $36A0
	call $60CA
	ld a,$18
	call Predef
	ld hl,$D53A
	ld a,$14
	ld [$CF91],a
	ld a,1
	ld [$CF96],a
	call $2BCF
	ld a,[$D07C]
	ld [$D71A],a
	call Function62CE
	xor a
	ld [$FFD7],a
	ld a,[$D732]
	bit 1,a ; XXX when is bit 1 set?
	jp nz,Function61BC ; easter egg: skip the intro
	ld de,$615F
	ld bc,$1300
	call IntroPredef3B   ; displays Oak pic?
	call FadeInIntroPic
	ld hl,OakSpeechText1
	call PrintText      ; prints text box
	call GBFadeOut2
	call ClearScreen
	ld a,NIDORINO
	ld [$D0B5],a    ; pic displayed is stored at this location
	ld [$CF91],a
	call $1537      ; this is also related to the pic
	ld hl,$C3F6     ; position on tilemap the pic is displayed
	call $1384      ; displays pic?
	call MovePicLeft
	ld hl,OakSpeechText2
	call PrintText      ; Prints text box
	call GBFadeOut2
	call ClearScreen
	ld de,$6EDE
	ld bc,$0400     ; affects the position of the player pic
	call IntroPredef3B      ; displays player pic?
	call MovePicLeft
	ld hl,IntroducePlayerText
	call PrintText
	call $695D ; brings up NewName/Red/etc menu
	call GBFadeOut2
	call ClearScreen
	ld de,$6049
	ld bc,$1300
	call IntroPredef3B ; displays rival pic
	call FadeInIntroPic
	ld hl,IntroduceRivalText
	call PrintText
	call $69A4
Function61BC:
	call GBFadeOut2
	call ClearScreen
	ld de,$6EDE
	ld bc,$0400
	call IntroPredef3B
	call GBFadeIn2
	ld a,[$D72D]
	and a
	jr nz,.next\@
	ld hl,OakSpeechText3
	call PrintText
.next\@	ld a,[$FFB8]
	push af
	ld a,$9C
	call $23B1
	pop af
	ld [$FFB8],a
	ld [$2000],a
	ld c,4
	call DelayFrames
	ld de,$4180
	ld hl,$8000
	ld bc,$050C
	call $1848
	ld de,$6FE8
	ld bc,$0400
	call IntroPredef3B
	ld c,4
	call DelayFrames
	ld de,$7042
	ld bc,$0400
	call IntroPredef3B
	call $28A6
	ld a,[$FFB8]
	push af
	ld a,2
	ld [$C0EF],a
	ld [$C0F0],a
	ld a,$A
	ld [$CFC7],a
	ld a,$FF
	ld [$C0EE],a
	call $23B1 ; stop music
	pop af
	ld [$FFB8],a
	ld [$2000],a
	ld c,$14
	call DelayFrames
	ld hl,$C40A
	ld b,7
	ld c,7
	call $18C4
	call $36A0
	ld a,1
	ld [$CFCB],a
	ld c,$32
	call DelayFrames
	call GBFadeOut2
	jp ClearScreen
OakSpeechText1:
	TX_FAR _OakSpeechText1
	db "@"
OakSpeechText2:
	TX_FAR _OakSpeechText2A
	db $14
	TX_FAR _OakSpeechText2B
	db "@"
IntroducePlayerText:
	TX_FAR _IntroducePlayerText
	db "@"
IntroduceRivalText:
	TX_FAR _IntroduceRivalText
	db "@"
OakSpeechText3:
	TX_FAR _OakSpeechText3
	db "@"

FadeInIntroPic:
	ld hl,IntroFadePalettes
	ld b,6
.next\@
	ld a,[hli]
	ld [rBGP],a
	ld c,10
	call DelayFrames
	dec b
	jr nz,.next\@
	ret

IntroFadePalettes:
	db %01010100
	db %10101000
	db %11111100
	db %11111000
	db %11110100
	db %11100100

MovePicLeft:
	ld a,119
	ld [$FF4B],a
	call DelayFrame

	ld a,$E4
	ld [rBGP],a
.next\@
	call DelayFrame
	ld a,[$FF4B]
	sub 8
	cp $FF
	ret z
	ld [$FF4B],a
	jr .next\@

Predef3B: ; 62A1
	call $3E94
IntroPredef3B: ; 62A4
	push bc
	ld a,b
	call $36EB
	ld hl,$A188
	ld de,$A000
	ld bc,$0310
	call CopyData
	ld de,$9000
	call $16EA
	pop bc
	ld a,c
	and a
	ld hl,$C3C3
	jr nz,.next\@
	ld hl,$C3F6
.next\@
	xor a
	ld [$FFE1],a
	ld a,1
	jp $3E6D

Function62CE: ; 62CE, XXX called by 4B2 948 989 5BF9 5D15
	call $62FF
	ld a,$19
	call $3E6D
	ld hl,$D732
	bit 2,[hl]
	res 2,[hl]
	jr z,.next\@
	ld a,[$D71A]
	jr .next2\@
.next\@
	bit 1,[hl]
	jr z,.next3\@
	call $64EA
.next3\@
	ld a,0
.next2\@
	ld b,a
	ld a,[$D72D]
	and a
	jr nz,.next4\@
	ld a,b
.next4\@
	ld hl,$D732
	bit 4,[hl]
	ret nz
	ld [$D365],a
	ret

INCBIN "baserom.gbc",$62FF,$6420-$62FF

FirstMapSpec:
	db $26 ; RedHouse1F
; Original Format:
;   [Event Displacement][Y-block][X-block][Y-sub_block][X-sub_block]
; Macro Format:
;   FLYWARP_DATA [Map Width][Y-pos][X-pos]
	FLYWARP_DATA 4,6,3
	db $04		;Tileset_id

INCBIN "baserom.gbc",$6428,$6448-$6428

FlyWarpDataPtr:
	db $00,0
        dw Map00FlyWarp
	db $01,0
        dw Map01FlyWarp
	db $02,0
        dw Map02FlyWarp
	db $03,0
        dw Map03FlyWarp
	db $04,0
        dw Map04FlyWarp
	db $05,0
        dw Map05FlyWarp
	db $06,0
        dw Map06FlyWarp
	db $07,0
        dw Map07FlyWarp
	db $08,0
        dw Map08FlyWarp
	db $09,0
        dw Map09FlyWarp
	db $0A,0
        dw Map0aFlyWarp
	db $0F,0
        dw Map0fFlyWarp
	db $15,0
        dw Map15FlyWarp

; Original Format:
;   [Event Displacement][Y-block][X-block][Y-sub_block][X-sub_block]
; Macro Format:
;   FLYWARP_DATA [Map Width][Y-pos][X-pos]
Map00FlyWarp:
	FLYWARP_DATA 10,6,5
Map01FlyWarp:
	FLYWARP_DATA 20,26,23
Map02FlyWarp:
	FLYWARP_DATA 20,26,13
Map03FlyWarp:
	FLYWARP_DATA 20,18,19
Map04FlyWarp:
	FLYWARP_DATA 10,6,3
Map05FlyWarp:
	FLYWARP_DATA 20,4,11
Map06FlyWarp:
	FLYWARP_DATA 25,10,41
Map07FlyWarp:
	FLYWARP_DATA 20,28,19
Map08FlyWarp:
	FLYWARP_DATA 10,12,11
Map09FlyWarp:
	FLYWARP_DATA 10,6,9
Map0aFlyWarp:
	FLYWARP_DATA 20,30,9
Map0fFlyWarp:
	FLYWARP_DATA 45,6,11
Map15FlyWarp:
	FLYWARP_DATA 10,20,11

INCBIN "baserom.gbc",$64ca,$6557 - $64ca

UnnamedText_6557: ; 0x6557
    TX_FAR _UnnamedText_6557
    db $50
; 0x6557 + 5 bytes

INCBIN "baserom.gbc",$655c,$699f - $655c

UnnamedText_699f: ; 0x699f
    TX_FAR _UnnamedText_699f
    db $50
; 0x699f + 5 bytes

INCBIN "baserom.gbc",$69a4,$3

ld de,DefaultNamesRival

INCBIN "baserom.gbc",$69AA,$69B3 - $69AA

ld hl,DefaultNamesRivalList

INCBIN "baserom.gbc",$69b6,$69e7 - $69b6

UnnamedText_69e7: ; 0x69e7
    TX_FAR _UnnamedText_69e7
    db $50
; 0x69e7 + 5 bytes

INCBIN "baserom.gbc",$69ec,$bc

IF _RED
DefaultNamesPlayer:
	db "NEW NAME",$4E,"RED",$4E,"ASH",$4E,"JACK@"
DefaultNamesRival:
	db "NEW NAME",$4E,"BLUE",$4E,"GARY",$4E,"JOHN@"
ENDC
IF _BLUE
DefaultNamesPlayer:
	db "NEW NAME",$4E,"BLUE",$4E,"GARY",$4E,"JOHN@"
DefaultNamesRival:
	db "NEW NAME",$4E,"RED",$4E,"ASH",$4E,"JACK@"
ENDC

INCBIN "baserom.gbc",$6AD6,$6AF2 - $6AD6

IF _RED
DefaultNamesPlayerList:
	db "NEW NAME@RED@ASH@JACK@"
DefaultNamesRivalList:
	db "NEW NAME@BLUE@GARY@JOHN@@"
ENDC
IF _BLUE
DefaultNamesPlayerList:
	db "NEW NAME@BLUE@GARY@JOHN@"
DefaultNamesRivalList:
	db "NEW NAME@RED@ASH@JACK@@"
ENDC

INCBIN "baserom.gbc",$6b21,$6e0c - $6b21

UnnamedText_6e0c: ; 0x6e0c
    TX_FAR _UnnamedText_6e0c
    db $50
; 0x6e0c + 5 bytes

UnnamedText_6e11: ; 0x6e11
    TX_FAR _UnnamedText_6e11
    db $50
; 0x6e11 + 5 bytes

UnnamedText_6e16: ; 0x6e16
    TX_FAR _UnnamedText_6e16
    db $50
; 0x6e16 + 5 bytes

UnnamedText_6e1b: ; 0x6e1b
    TX_FAR _UnnamedText_6e1b
    db $50
; 0x6e1b + 5 bytes

UnnamedText_6e20: ; 0x6e20
    TX_FAR _UnnamedText_6e20
    db $50
; 0x6e20 + 5 bytes

UnnamedText_6e25: ; 0x6e25
    TX_FAR _UnnamedText_6e25
    db $50
; 0x6e25 + 5 bytes

UnnamedText_6e2a: ; 0x6e2a
    TX_FAR _UnnamedText_6e2a
    db $50
; 0x6e2a + 5 bytes

UnnamedText_6e2f: ; 0x6e2f
    TX_FAR _UnnamedText_6e2f
    db $50
; 0x6e2f + 5 bytes

UnnamedText_6e34: ; 0x6e34
    TX_FAR _UnnamedText_6e34
    db $50
; 0x6e34 + 5 bytes

UnnamedText_6e39: ; 0x6e39
    TX_FAR _UnnamedText_6e39
    db $50
; 0x6e39 + 5 bytes

UnnamedText_6e3e: ; 0x6e3e
    TX_FAR _UnnamedText_6e3e
    db $50
; 0x6e3e + 5 bytes

INCBIN "baserom.gbc",$6e43,$6fb4 - $6e43

UnnamedText_6fb4: ; 0x6fb4
    TX_FAR _UnnamedText_6fb4
    db $50
; 0x6fb4 + 5 bytes

UnnamedText_6fb9: ; 0x6fb9
    TX_FAR _UnnamedText_6fb9
    db $50
; 0x6fb9 + 5 bytes

UnnamedText_6fbe: ; 0x6fbe
    TX_FAR _UnnamedText_6fbe
    db $50
; 0x6fbe + 5 bytes

UnnamedText_6fc3: ; 0x6fc3
    TX_FAR _UnnamedText_6fc3
    db $50
; 0x6fc3 + 5 bytes

INCBIN "baserom.gbc",$6fc8,$6fdc - $6fc8

UnnamedText_6fdc: ; 0x6fdc
    TX_FAR _UnnamedText_6fdc
    db $50
; 0x6fdc + 5 bytes

UnnamedText_6fe1: ; 0x6fe1
    TX_FAR _UnnamedText_6fe1
    db $50
; 0x6fe1 + 5 bytes

INCBIN "baserom.gbc",$6fe6,$705d - $6fe6

UnnamedText_705d: ; 0x705d
    TX_FAR _UnnamedText_705d
    db $50
; 0x705d + 5 bytes

INCBIN "baserom.gbc",$7062,$7063 - $7062

UnnamedText_7063: ; 0x7063
    TX_FAR _UnnamedText_7063
    db $50
; 0x7063 + 5 bytes

UnnamedText_7068: ; 0x7068
    TX_FAR _UnnamedText_7068
    db $50
; 0x7068 + 5 bytes

UnnamedText_706d: ; 0x706d
    TX_FAR _UnnamedText_706d
    db $50
; 0x706d + 5 bytes

INCBIN "baserom.gbc",$7072,$7073 - $7072

UnnamedText_7073: ; 0x7073
    TX_FAR _UnnamedText_7073
    db $50
; 0x7073 + 5 bytes

INCBIN "baserom.gbc",$7078,$72b3 - $7078

UnnamedText_72b3: ; 0x72b3
    TX_FAR _UnnamedText_72b3
    db $50
; 0x72b3 + 5 bytes

UnnamedText_72b8: ; 0x72b8
    TX_FAR _UnnamedText_72b8
    db $50
; 0x72b8 + 5 bytes

UnnamedText_72bd: ; 0x72bd
    TX_FAR _UnnamedText_72bd
    db $50
; 0x72bd + 5 bytes

INCBIN "baserom.gbc",$72c2,$72c8 - $72c2

UnnamedText_72c8: ; 0x72c8
    TX_FAR _UnnamedText_72c8
    db $50
; 0x72c8 + 5 bytes

UnnamedText_72cd: ; 0x72cd
    TX_FAR _UnnamedText_72cd
    db $50
; 0x72cd + 5 bytes

UnnamedText_72d2: ; 0x72d2
    TX_FAR _UnnamedText_72d2
    db $50
; 0x72d2 + 5 bytes

INCBIN "baserom.gbc",$72d7,$4b6

FieldMoveNames: ; 778D
	db "CUT@"
	db "FLY@"
	db "@"
	db "SURF@"
	db "STRENGTH@"
	db "FLASH@"
	db "DIG@"
	db "TELEPORT@"
	db "SOFTBOILED@"

PokemonMenuEntries: ; 77C2
	db "STATS",$4E
	db "SWITCH",$4E
	db "CANCEL@"

INCBIN "baserom.gbc",$77d6,$78dc - $77d6

UnnamedText_78dc: ; 0x78dc
    TX_FAR _UnnamedText_78dc
    db $50
; 0x78dc + 5 bytes

UnnamedText_78e1: ; 0x78e1
    TX_FAR _UnnamedText_78e1
    db $50
; 0x78e1 + 5 bytes

INCBIN "baserom.gbc",$78e6,$20f

PlayersPCMenuEntries: ; 7AF5
	db "WITHDRAW ITEM",$4E
	db "DEPOSIT ITEM",$4E
	db "TOSS ITEM",$4E
	db "LOG OFF@"

UnnamedText_7b22: ; 0x7b22
    TX_FAR _UnnamedText_7b22
    db $50
; 0x7b22 + 5 bytes

UnnamedText_7b27: ; 0x7b27
    TX_FAR _UnnamedText_7b27
    db $50
; 0x7b27 + 5 bytes

UnnamedText_7b2c: ; 0x7b2c
    TX_FAR _UnnamedText_7b2c
    db $50
; 0x7b2c + 5 bytes

UnnamedText_7b31: ; 0x7b31
    TX_FAR _UnnamedText_7b31
    db $50
; 0x7b31 + 5 bytes

UnnamedText_7b36: ; 0x7b36
    TX_FAR _UnnamedText_7b36
    db $50
; 0x7b36 + 5 bytes

UnnamedText_7b3b: ; 0x7b3b
    TX_FAR _UnnamedText_7b3b
    db $50
; 0x7b3b + 5 bytes

UnnamedText_7b40: ; 0x7b40
    TX_FAR _UnnamedText_7b40
    db $50
; 0x7b40 + 5 bytes

UnnamedText_7b45: ; 0x7b45
    TX_FAR _UnnamedText_7b45
    db $50
; 0x7b45 + 5 bytes

UnnamedText_7b4a: ; 0x7b4a
    TX_FAR _UnnamedText_7b4a
    db $50
; 0x7b4a + 5 bytes

UnnamedText_7b4f: ; 0x7b4f
    TX_FAR _UnnamedText_7b4f
    db $50
; 0x7b4f + 5 bytes

UnnamedText_7b54: ; 0x7b54
    TX_FAR _UnnamedText_7b54
    db $50
; 0x7b54 + 5 bytes

UnnamedText_7b59: ; 0x7b59
    TX_FAR _UnnamedText_7b59
    db $50
; 0x7b59 + 5 bytes

UnnamedText_7b5e: ; 0x7b5e
    TX_FAR _UnnamedText_7b5e
    db $50
; 0x7b5e + 5 bytes

UnnamedText_7b63: ; 0x7b63
    TX_FAR _UnnamedText_7b63
    db $50
; 0x7b63 + 5 bytes

INCBIN "baserom.gbc",$7b68,$e1

SECTION "bank2",DATA,BANK[$2]

INCBIN "baserom.gbc",$8000,$4000

SECTION "bank3",DATA,BANK[$3]

INCBIN "baserom.gbc",$C000,$C23D - $C000

; see also MapHeaderPointers
MapHeaderBanks: ; 423D
	db BANK(PalletTown_h) ;PALLET_TOWN
	db BANK(ViridianCity_h) ; VIRIDIAN_CITY
	db BANK(PewterCity_h) ; PEWTER_CITY
	db BANK(CeruleanCity_h) ; CERULEAN_CITY
	db BANK(LavenderTown_h) ; LAVENDER_TOWN
	db BANK(VermilionCity_h) ; VERMILION_CITY
	db BANK(CeladonCity_h) ; CELADON_CITY
	db BANK(FuchsiaCity_h) ; FUCHSIA_CITY
	db BANK(CinnabarIsland_h) ; CINNABAR_ISLAND
	db BANK(IndigoPlateau_h) ; INDIGO_PLATEAU
	db BANK(SaffronCity_h) ; SAFFRON_CITY
	db $1 ; unused
	db BANK(Route1_h) ; ROUTE_1
	db BANK(Route2_h) ; ROUTE_2
	db BANK(Route3_h) ; ROUTE_3
	db BANK(Route4_h) ; ROUTE_4
	db BANK(Route5_h) ; ROUTE_5
	db BANK(Route6_h) ; ROUTE_6
	db BANK(Route7_h) ; ROUTE_7
    db BANK(Route8_h) ; ROUTE_8
    db BANK(Route9_h) ; ROUTE_9
    db BANK(Route10_h) ; ROUTE_10
    db BANK(Route11_h) ; ROUTE_11
    db BANK(Route12_h) ; ROUTE_12
    db BANK(Route13_h) ; ROUTE_13
    db BANK(Route14_h) ; ROUTE_14
    db BANK(Route15_h) ; ROUTE_15
    db BANK(Route16_h) ; ROUTE_16
    db BANK(Route17_h) ; ROUTE_17
    db BANK(Route18_h) ; ROUTE_18
    db BANK(Route19_h) ; ROUTE_19
    db BANK(Route20_h) ; ROUTE_20
    db BANK(Route21_h) ; ROUTE_21
    db BANK(Route22_h) ; ROUTE_22
    db BANK(Route23_h) ; ROUTE_23
    db BANK(Route24_h) ; ROUTE_24
    db BANK(Route25_h) ; ROUTE_25
	db BANK(RedsHouse1F_h)
	db BANK(RedsHouse2F_h)
	db BANK(BluesHouse_h)
	db BANK(OaksLab_h)
	db BANK(ViridianPokecenter_h)
	db BANK(ViridianMart_h)
	db BANK(School_h)
	db BANK(ViridianHouse_h)
	db BANK(ViridianGym_h)
	db BANK(DiglettsCaveRoute2_h)
	db BANK(ViridianForestexit_h)
	db BANK(Route2House_h)
	db BANK(Route2Gate_h)
	db BANK(ViridianForestEntrance_h)
	db BANK(ViridianForest_h)
	db BANK(MuseumF1_h)
	db BANK(MuseumF2_h)
	db BANK(PewterGym_h)
	db BANK(PewterHouse1_h)
	db BANK(PewterMart_h)
	db BANK(PewterHouse2_h)
	db BANK(PewterPokecenter_h)
	db BANK(MtMoon1_h)
	db BANK(MtMoon2_h)
	db BANK(MtMoon3_h)
	db BANK(CeruleanHouseTrashed_h)
	db BANK(CeruleanHouse2_h)
	db BANK(CeruleanPokecenter_h)
	db BANK(CeruleanGym_h)
	db BANK(BikeShop_h)
	db BANK(CeruleanMart_h)
	db BANK(MtMoonPokecenter_h)
	db BANK(CeruleanHouseTrashed_h)
	db BANK(Route5Gate_h)
	db BANK(UndergroundTunnelEntranceRoute5_h)
	db BANK(DayCareM_h)
	db BANK(Route6Gate_h)
	db BANK(UndergroundTunnelEntranceRoute6_h)
	db $17 ;FREEZE
	db BANK(Route7Gate_h)
	db BANK(UndergroundPathEntranceRoute7_h)
	db $17 ;FREEZE
	db BANK(Route8Gate_h)
	db BANK(UndergroundPathEntranceRoute8_h)
	db BANK(RockTunnelPokecenter_h)
	db BANK(RockTunnel1_h)
	db BANK(PowerPlant_h)
	db BANK(Route11Gate_h)
	db BANK(DiglettsCaveEntranceRoute11_h)
	db BANK(Route11GateUpstairs_h)
	db BANK(Route12Gate_h)
	db BANK(BillsHouse_h)
	db BANK(VermilionPokecenter_h)
	db BANK(FanClub_h)
	db BANK(VermilionMart_h)
	db BANK(VermilionGym_h)
	db BANK(VermilionHouse1_h)
	db BANK(VermilionDock_h)
	db BANK(SSAnne1_h)
	db BANK(SSAnne2_h)
	db BANK(SSAnne3_h)
	db BANK(SSAnne4_h)
	db BANK(SSAnne5_h)
	db BANK(SSAnne6_h)
	db BANK(SSAnne7_h)
	db BANK(SSAnne8_h)
	db BANK(SSAnne9_h)
	db BANK(SSAnne10_h)
	db $1D ;unused
	db $1D ;unused
	db $1D ;unused
	db BANK(VictoryRoad1_h)
	db $1D ;unused
	db $1D ;unused
	db $1D ;unused
	db $1D ;unused
	db BANK(Lance_h)
	db $1D ;unused
	db $1D ;unused
	db $1D ;unused
	db $1D ;unused
	db BANK(HallofFameRoom_h)
	db BANK(UndergroundPathNS_h)
	db BANK(Gary_h)
	db BANK(UndergroundPathWE_h)
	db BANK(CeladonMart1_h)
	db BANK(CeladonMart2_h)
	db BANK(CeladonMart3_h)
	db BANK(CeladonMart4_h)
	db BANK(CeladonMartRoof_h)
	db BANK(CeladonMartElevator_h)
	db BANK(CeladonMansion1_h)
	db BANK(CeladonMansion2_h)
	db BANK(CeladonMansion3_h)
	db BANK(CeladonMansion4_h)
	db BANK(CeladonMansion5_h)
	db BANK(CeladonPokecenter_h)
	db BANK(CeladonGym_h)
	db BANK(CeladonGameCorner_h)
	db BANK(CeladonMart5_h)
	db BANK(CeladonPrizeRoom_h)
	db BANK(CeladonDiner_h)
	db BANK(CeladonHouse_h)
	db BANK(CeladonHotel_h)
	db BANK(LavenderPokecenter_h)
	db BANK(PokemonTower1_h)
	db BANK(PokemonTower2_h)
	db BANK(PokemonTower3_h)
	db BANK(PokemonTower4_h)
	db BANK(PokemonTower5_h)
	db BANK(PokemonTower6_h)
	db BANK(PokemonTower7_h)
	db BANK(LavenderHouse1_h)
	db BANK(LavenderMart_h)
	db BANK(LavenderHouse2_h)
	db BANK(FuchsiaMart_h)
	db BANK(FuchsiaHouse1_h)
	db BANK(FuchsiaPokecenter_h)
	db BANK(FuchsiaHouse2_h)
	db BANK(SafariZoneEntrance_h)
	db BANK(FuchsiaGym_h)
	db BANK(FuchsiaMeetingRoom_h)
	db BANK(SeafoamIslands2_h)
	db BANK(SeafoamIslands3_h)
	db BANK(SeafoamIslands4_h)
	db BANK(SeafoamIslands5_h)
	db BANK(VermilionHouse2_h)
	db BANK(FuchsiaHouse3_h)
	db BANK(Mansion1_h)
	db BANK(CinnabarGym_h)
	db BANK(Lab1_h)
	db BANK(Lab2_h)
	db BANK(Lab3_h)
	db BANK(Lab4_h)
	db BANK(CinnabarPokecenter_h)
	db BANK(CinnabarMart_h)
	db $1D
	db BANK(IndigoPlateauLobby_h)
	db BANK(CopycatsHouseF1_h)
	db BANK(CopycatsHouseF2_h)
	db BANK(FightingDojo_h)
	db BANK(SaffronGym_h)
	db BANK(SaffronHouse1_h)
	db BANK(SaffronMart_h)
	db BANK(SilphCo1_h)
	db BANK(SaffronPokecenter_h)
	db BANK(SaffronHouse2_h)
	db BANK(Route15Gate_h)
	db $12
	db BANK(Route16GateMap_h)
	db BANK(Route16GateUpstairs_h)
	db BANK(Route16House_h)
	db BANK(Route12House_h)
	db BANK(Route18Gate_h)
	db BANK(Route18GateHeader_h)
	db BANK(SeafoamIslands1_h)
	db BANK(Route22Gate_h)
	db BANK(VictoryRoad2_h)
	db BANK(Route12GateUpstairs_h)
	db BANK(VermilionHouse3_h)
	db BANK(DiglettsCave_h)
	db BANK(VictoryRoad3_h)
	db BANK(RocketHideout1_h)
	db BANK(RocketHideout2_h)
	db BANK(RocketHideout3_h)
	db BANK(RocketHideout4_h)
	db BANK(RocketHideoutElevator_h)
	db $01
	db $01
	db $01
	db BANK(SilphCo2_h)
	db BANK(SilphCo3_h)
	db BANK(SilphCo4_h)
	db BANK(SilphCo5_h)
	db BANK(SilphCo6_h)
	db BANK(SilphCo7_h)
	db BANK(SilphCo8_h)
	db BANK(Mansion2_h)
	db BANK(Mansion3_h)
	db BANK(Mansion4_h)
	db BANK(SafariZoneEast_h)
	db BANK(SafariZoneNorth_h)
	db BANK(SafariZoneWest_h)
	db BANK(SafariZoneCenter_h)
	db BANK(SafariZoneRestHouse1_h)
	db BANK(SafariZoneSecretHouse_h)
	db BANK(SafariZoneRestHouse2_h)
	db BANK(SafariZoneRestHouse3_h)
	db BANK(SafariZoneRestHouse4_h)
	db BANK(UnknownDungeon2_h)
	db BANK(UnknownDungeon3_h)
	db BANK(UnknownDungeon1_h)
	db BANK(NameRater_h)
	db BANK(CeruleanHouse3_h)
	db $01
	db BANK(RockTunnel2_h)
	db BANK(SilphCo9_h)
	db BANK(SilphCo10_h)
	db BANK(SilphCo11_h)
	db BANK(SilphCoElevator_h)
	db $11
	db $11
	db BANK(BattleCenterM_h)
	db BANK(TradeCenterM_h)
	db $11
	db $11
	db $11
	db $11
	db BANK(Lorelei_h)
	db BANK(Bruno_h)
	db BANK(Agatha_h)

INCBIN "baserom.gbc",$C335,$C766-$C335
	ld hl,TilesetsHeadPtr

INCBIN "baserom.gbc",$C769,$C7BE-$C769

TilesetsHeadPtr:
	TSETHEAD Tset00_Block,Tset00_GFX,Tset00_Coll,$FF,$FF,$FF,$52,2
	TSETHEAD Tset01_Block,Tset01_GFX,Tset01_Coll,$FF,$FF,$FF,$FF,0
	TSETHEAD Tset02_Block,Tset02_GFX,Tset02_Coll,$18,$19,$1E,$FF,0
	TSETHEAD Tset03_Block,Tset03_GFX,Tset03_Coll,$FF,$FF,$FF,$20,1
	TSETHEAD Tset01_Block,Tset01_GFX,Tset01_Coll,$FF,$FF,$FF,$FF,0
	TSETHEAD Tset05_Block,Tset05_GFX,Tset05_Coll,$3A,$FF,$FF,$FF,2
	TSETHEAD Tset02_Block,Tset02_GFX,Tset02_Coll,$18,$19,$1E,$FF,0
	TSETHEAD Tset05_Block,Tset05_GFX,Tset05_Coll,$3A,$FF,$FF,$FF,2
	TSETHEAD Tset08_Block,Tset08_GFX,Tset08_Coll,$FF,$FF,$FF,$FF,0
	TSETHEAD Tset09_Block,Tset09_GFX,Tset09_Coll,$17,$32,$FF,$FF,0
	TSETHEAD Tset09_Block,Tset09_GFX,Tset09_Coll,$17,$32,$FF,$FF,0
	TSETHEAD Tset0B_Block,Tset0B_GFX,Tset0B_Coll,$FF,$FF,$FF,$FF,0
	TSETHEAD Tset09_Block,Tset09_GFX,Tset09_Coll,$17,$32,$FF,$FF,0
	TSETHEAD Tset0D_Block,Tset0D_GFX,Tset0D_Coll,$FF,$FF,$FF,$FF,1
	TSETHEAD Tset0E_Block,Tset0E_GFX,Tset0E_Coll,$FF,$FF,$FF,$FF,1
	TSETHEAD Tset0F_Block,Tset0F_GFX,Tset0F_Coll,$12,$FF,$FF,$FF,0
	TSETHEAD Tset10_Block,Tset10_GFX,Tset10_Coll,$FF,$FF,$FF,$FF,0
	TSETHEAD Tset11_Block,Tset11_GFX,Tset11_Coll,$FF,$FF,$FF,$FF,1
	TSETHEAD Tset12_Block,Tset12_GFX,Tset12_Coll,$15,$36,$FF,$FF,0
	TSETHEAD Tset13_Block,Tset13_GFX,Tset13_Coll,$FF,$FF,$FF,$FF,0
	TSETHEAD Tset14_Block,Tset14_GFX,Tset14_Coll,$FF,$FF,$FF,$FF,0
	TSETHEAD Tset15_Block,Tset15_GFX,Tset15_Coll,$07,$17,$FF,$FF,0
	TSETHEAD Tset16_Block,Tset16_GFX,Tset16_Coll,$12,$FF,$FF,$FF,1
	TSETHEAD Tset17_Block,Tset17_GFX,Tset17_Coll,$FF,$FF,$FF,$45,1

INCBIN "baserom.gbc",$C8DE,$C8F5-$C8DE

; data for default hidden/shown
; objects for each map ($00-$F8)

; Table of 2-Byte pointers, one pointer per map,
; goes up to Map_F7, ends with $FFFF.
MapHSPointers: ; 48F5
	dw MapHS00
	dw MapHS01
	dw MapHS02
	dw MapHS03
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS0A
	dw MapHSXX
	dw MapHSXX
	dw MapHS0D
	dw MapHSXX
	dw MapHS0F
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS14
	dw MapHSXX
	dw MapHSXX
	dw MapHS17
	dw MapHSXX
	dw MapHSXX
	dw MapHS1A
	dw MapHS1B
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS21
	dw MapHSXX
	dw MapHS23
	dw MapHS24
	dw MapHSXX
	dw MapHSXX
	dw MapHS27
	dw MapHS28
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS2D
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS33
	dw MapHS34
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS3B
	dw MapHSXX
	dw MapHS3D
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS53
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS58
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS60
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS66
	dw MapHS67
	dw MapHS68
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS6C
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS78
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS84
	dw MapHSXX
	dw MapHSXX
	dw MapHS87
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS8F
	dw MapHS90
	dw MapHS91
	dw MapHS92
	dw MapHS93
	dw MapHS94
	dw MapHS95
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS9B
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHS9F
	dw MapHSA0
	dw MapHSA1
	dw MapHSA2
	dw MapHSXX
	dw MapHSXX
	dw MapHSA5
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSB1
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSB5
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSC0
	dw MapHSXX
	dw MapHSC2
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSC6
	dw MapHSC7
	dw MapHSC8
	dw MapHSC9
	dw MapHSCA
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSCF
	dw MapHSD0
	dw MapHSD1
	dw MapHSD2
	dw MapHSD3
	dw MapHSD4
	dw MapHSD5
	dw MapHSD6
	dw MapHSD7
	dw MapHSD8
	dw MapHSD9
	dw MapHSDA
	dw MapHSDB
	dw MapHSDC
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSE2
	dw MapHSE3
	dw MapHSE4
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSE9
	dw MapHSEA
	dw MapHSEB
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw MapHSF4
	dw MapHSXX
	dw MapHSXX
	dw MapHSXX
	dw $FFFF

; Structure:
; 3 bytes per object
; [Map_ID][Object_ID][H/S]
;
; Program stops reading when either:
; a) Map_ID = $FF
; b) Map_ID ≠ currentMapID
;
; This Data is loaded into RAM at $D5CE-$D5F?.

; These constants come from the bytes for Predef functions:
Hide	equ $11
Show	equ $15

MapHSXX:
	db $FF,$FF,$FF
MapHS00:
	db $00,$01,Hide
MapHS01:
	db $01,$05,Show
	db $01,$07,Hide
MapHS02:
	db $02,$03,Show
	db $02,$05,Show
MapHS03:
	db $03,$01,Hide
	db $03,$02,Show
	db $03,$06,Hide
	db $03,$0A,Show
	db $03,$0B,Show
MapHS0A:
	db $0A,$01,Show
	db $0A,$02,Show
	db $0A,$03,Show
	db $0A,$04,Show
	db $0A,$05,Show
	db $0A,$06,Show
	db $0A,$07,Show
	db $0A,$08,Hide
	db $0A,$09,Hide
	db $0A,$0A,Hide
	db $0A,$0B,Hide
	db $0A,$0C,Hide
	db $0A,$0D,Hide
	db $0A,$0E,Show
	db $0A,$0F,Hide
MapHS0D:
	db $0D,$01,Show
	db $0D,$02,Show
MapHS0F:
	db $0F,$03,Show
MapHS14:
	db $14,$0A,Show
MapHS17:
	db $17,$01,Show
	db $17,$09,Show
	db $17,$0A,Show
MapHS1A:
	db $1A,$0B,Show
MapHS1B:
	db $1B,$07,Show
MapHS21:
	db $21,$01,Hide
	db $21,$02,Hide
MapHS23:
	db $23,$01,Show
	db $23,$08,Show
MapHS24:
	db $24,$0A,Show
MapHS27:
	db $27,$01,Show
	db $27,$02,Hide
	db $27,$03,Show
MapHS28:
	db $28,$01,Show
	db $28,$02,Show
	db $28,$03,Show
	db $28,$04,Show
	db $28,$05,Hide
	db $28,$06,Show
	db $28,$07,Show
	db $28,$08,Hide
MapHS2D:
	db $2D,$01,Show
	db $2D,$0B,Show
MapHS34:
	db $34,$05,Show
MapHSE4:
	db $E4,$01,Show
	db $E4,$02,Show
	db $E4,$03,Show
MapHS8F:
	db $8F,$01,Show
MapHS90:
	db $90,$04,Show
MapHS91:
	db $91,$04,Show
	db $91,$05,Show
	db $91,$06,Show
MapHS92:
	db $92,$06,Show
MapHS93:
	db $93,$04,Show
	db $93,$05,Show
MapHS94:
	db $94,$01,Show
	db $94,$02,Show
	db $94,$03,Show
	db $94,$04,Show
MapHS95:
	db $95,$05,Hide
MapHS84:
	db $84,$02,Show
MapHS87:
	db $87,$0B,Show
MapHS9B:
	db $9B,$02,Show
MapHSA5:
	db $A5,$02,Show
	db $A5,$03,Show
MapHSB1:
	db $B1,$06,Show
	db $B1,$07,Show
MapHSB5:
	db $B5,$01,Hide
MapHS53:
	db $53,$01,Show
	db $53,$02,Show
	db $53,$03,Show
	db $53,$04,Show
	db $53,$05,Show
	db $53,$06,Show
	db $53,$07,Show
	db $53,$08,Show
	db $53,$09,Show
	db $53,$0A,Show
	db $53,$0B,Show
	db $53,$0C,Show
	db $53,$0D,Show
	db $53,$0E,Show
MapHSC2:
	db $C2,$06,Show
	db $C2,$07,Show
	db $C2,$08,Show
	db $C2,$09,Show
	db $C2,$0A,Show
	db $C2,$0D,Show
MapHS58:
	db $58,$01,Show
	db $58,$02,Hide
	db $58,$03,Hide
MapHS33:
	db $33,$05,Show
	db $33,$06,Show
	db $33,$07,Show
MapHS3B:
	db $3B,$08,Show
	db $3B,$09,Show
	db $3B,$0A,Show
	db $3B,$0B,Show
	db $3B,$0C,Show
	db $3B,$0D,Show
MapHS3D:
	db $3D,$06,Show
	db $3D,$07,Show
	db $3D,$08,Show
	db $3D,$09,Show
MapHS60:
	db $60,$02,Hide
MapHS66:
	db $66,$0A,Show
MapHS67:
	db $67,$06,Show
	db $67,$09,Show
MapHS68:
	db $68,$09,Show
	db $68,$0A,Show
	db $68,$0B,Show
MapHSC6:
	db $C6,$05,Show
	db $C6,$06,Show
	db $C6,$0A,Show
MapHSC7:
	db $C7,$06,Show
	db $C7,$07,Show
MapHSC8:
	db $C8,$02,Show
	db $C8,$03,Show
	db $C8,$04,Show
	db $C8,$05,Show
MapHSC9:
	db $C9,$03,Show
	db $C9,$04,Show
MapHSCA:
	db $CA,$01,Show
	db $CA,$05,Show
	db $CA,$06,Show
	db $CA,$07,Show
	db $CA,$08,Hide
	db $CA,$09,Hide
MapHSCF:
	db $CF,$01,Show
	db $CF,$02,Show
	db $CF,$03,Show
	db $CF,$04,Show
	db $CF,$05,Show
MapHSD0:
	db $D0,$02,Show
	db $D0,$03,Show
	db $D0,$04,Show
MapHSD1:
	db $D1,$02,Show
	db $D1,$03,Show
	db $D1,$04,Show
	db $D1,$05,Show
	db $D1,$06,Show
	db $D1,$07,Show
MapHSD2:
	db $D2,$02,Show
	db $D2,$03,Show
	db $D2,$04,Show
	db $D2,$05,Show
	db $D2,$06,Show
	db $D2,$07,Show
	db $D2,$08,Show
MapHSD3:
	db $D3,$06,Show
	db $D3,$07,Show
	db $D3,$08,Show
	db $D3,$09,Show
	db $D3,$0A,Show
MapHSD4:
	db $D4,$05,Show
	db $D4,$06,Show
	db $D4,$07,Show
	db $D4,$08,Show
	db $D4,$09,Show
	db $D4,$0A,Show
	db $D4,$0B,Show
	db $D4,$0C,Show
MapHSD5:
	db $D5,$02,Show
	db $D5,$03,Show
	db $D5,$04,Show
MapHSE9:
	db $E9,$02,Show
	db $E9,$03,Show
	db $E9,$04,Show
MapHSEA:
	db $EA,$01,Show
	db $EA,$02,Show
	db $EA,$03,Show
	db $EA,$04,Show
	db $EA,$05,Show
	db $EA,$06,Show
MapHSEB:
	db $EB,$03,Show
	db $EB,$04,Show
	db $EB,$05,Show
MapHSF4:
	db $F4,$02,Show
MapHSD6:
	db $D6,$02,Show
MapHSD7:
	db $D7,$03,Show
	db $D7,$04,Show
MapHSD8:
	db $D8,$03,Show
	db $D8,$04,Show
	db $D8,$05,Show
	db $D8,$06,Show
	db $D8,$08,Show
MapHSD9:
	db $D9,$01,Show
	db $D9,$02,Show
	db $D9,$03,Show
	db $D9,$04,Show
MapHSDA:
	db $DA,$01,Show
	db $DA,$02,Show
MapHSDB:
	db $DB,$01,Show
	db $DB,$02,Show
	db $DB,$03,Show
	db $DB,$04,Show
MapHSDC:
	db $DC,$01,Show
MapHSE2:
	db $E2,$01,Show
	db $E2,$02,Show
	db $E2,$03,Show
MapHSE3:
	db $E3,$01,Show
	db $E3,$02,Show
	db $E3,$03,Show
MapHS6C:
	db $6C,$03,Show
	db $6C,$04,Show
MapHS78:
	db $78,$02,Hide
MapHSC0:
	db $C0,$01,Show
	db $C0,$02,Show
MapHS9F:
	db $9F,$01,Hide
	db $9F,$02,Hide
MapHSA0:
	db $A0,$01,Hide
	db $A0,$02,Hide
MapHSA1:
	db $A1,$02,Show
	db $A1,$03,Show
	db $A1,$05,Hide
	db $A1,$06,Hide
MapHSA2:
	db $A2,$01,Hide
	db $A2,$02,Hide
	db $A2,$03,Show

	db $FF

INCBIN "baserom.gbc",$cd97,$cdbb - $cd97

UnnamedText_cdbb: ; 0xcdbb
    TX_FAR _UnnamedText_cdbb
    db $50
; 0xcdbb + 5 bytes

INCBIN "baserom.gbc",$cdc0,$cdfa - $cdc0

UnnamedText_cdfa: ; 0xcdfa
    TX_FAR _UnnamedText_cdfa
    db $50
; 0xcdfa + 5 bytes

UnnamedText_cdff: ; 0xcdff
    TX_FAR _UnnamedText_cdff
    db $50
; 0xcdff + 5 bytes

INCBIN "baserom.gbc",$ce04,$b4

; wild pokemon data: from 4EB8 to 55C7

LoadWildData: ; 4EB8
	ld hl,WildDataPointers
	ld a,[W_CURMAP]

	; get wild data for current map
	ld c,a
	ld b,0
	add hl,bc
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a       ; hl now points to wild data for current map
	ld a,[hli]
	ld [W_GRASSRATE],a
	and a
	jr z,.NoGrassData\@ ; if no grass data, skip to surfing data
	push hl
	ld de,W_GRASSMONS ; otherwise, load grass data
	ld bc,$0014
	call CopyData
	pop hl
	ld bc,$0014
	add hl,bc
.NoGrassData\@
	ld a,[hli]
	ld [W_WATERRATE],a
	and a
	ret z        ; if no water data, we're done
	ld de,W_WATERMONS  ; otherwise, load surfing data
	ld bc,$0014
	jp CopyData

WildDataPointers: ; 4EEB
	dw NoMons      ; PALLET_TOWN
	dw NoMons      ; VIRIDIAN_CITY
	dw NoMons      ; PEWTER_CITY
	dw NoMons      ; CERULEAN_CITY
	dw NoMons      ; LAVENDER_TOWN
	dw NoMons      ; VERMILION_CITY
	dw NoMons      ; CELADON_CITY
	dw NoMons      ; FUCHSIA_CITY
	dw NoMons      ; CINNABAR_ISLAND
	dw NoMons      ; INDIGO_PLATEAU
	dw NoMons      ; SAFFRON_CITY
	dw NoMons      ; unused
	dw Route1Mons  ; ROUTE_1
	dw Route2Mons  ; ROUTE_2
	dw Route3Mons  ; ROUTE_3
	dw Route4Mons  ; ROUTE_4
	dw Route5Mons  ; ROUTE_5
	dw Route6Mons  ; ROUTE_6
	dw Route7Mons  ; ROUTE_7
	dw Route8Mons  ; ROUTE_8
	dw Route9Mons  ; ROUTE_9
	dw Route10Mons ; ROUTE_10
	dw Route11Mons ; ROUTE_11
	dw Route12Mons ; ROUTE_12
	dw Route13Mons ; ROUTE_13
	dw Route14Mons ; ROUTE_14
	dw Route15Mons ; ROUTE_15
	dw Route16Mons ; ROUTE_16
	dw Route17Mons ; ROUTE_17
	dw Route18Mons ; ROUTE_18
	dw WaterMons   ; ROUTE_19
	dw WaterMons   ; ROUTE_20
	dw Route21Mons ; ROUTE_21
	dw Route22Mons ; ROUTE_22
	dw Route23Mons ; ROUTE_23
	dw Route24Mons ; ROUTE_24
	dw Route25Mons ; ROUTE_25
	dw NoMons      ; REDS_HOUSE_1F
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw ForestMons ; ViridianForest
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw MoonMons1
	dw MoonMonsB1
	dw MoonMonsB2
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw TunnelMonsB1
	dw PowerPlantMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw PlateauMons1
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw TowerMons1
	dw TowerMons2
	dw TowerMons3
	dw TowerMons4
	dw TowerMons5
	dw TowerMons6
	dw TowerMons7
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw IslandMonsB1
	dw IslandMonsB2
	dw IslandMonsB3
	dw IslandMonsB4
	dw NoMons
	dw NoMons
	dw MansionMons1
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw IslandMons1
	dw NoMons
	dw PlateauMons2
	dw NoMons
	dw NoMons
	dw CaveMons
	dw PlateauMons3
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw MansionMons2
	dw MansionMons3
	dw MansionMonsB1
	dw ZoneMons1
	dw ZoneMons2
	dw ZoneMons3
	dw ZoneMonsCenter
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw DungeonMons2
	dw DungeonMonsB1
	dw DungeonMons1
	dw NoMons
	dw NoMons
	dw NoMons
	dw TunnelMonsB2
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw NoMons
	dw $FFFF

; wild pokemon data is divided into two parts.
; first part:  pokemon found in grass
; second part: pokemon found while surfing
; each part goes as follows:
	; if first byte == 00, then
		; no wild pokemon on this map
	; if first byte != 00, then
		; first byte is encounter rate
		; followed by 20 bytes:
		; level, species (ten times)

IF _RED
NoMons:
	db $00

	db $00

Route1Mons:
	db $19
	db 3,PIDGEY
	db 3,RATTATA
	db 3,RATTATA
	db 2,RATTATA
	db 2,PIDGEY
	db 3,PIDGEY
	db 3,PIDGEY
	db 4,RATTATA
	db 4,PIDGEY
	db 5,PIDGEY

	db $00

Route2Mons:
	db $19
	db 3,RATTATA
	db 3,PIDGEY
	db 4,PIDGEY
	db 4,RATTATA
	db 5,PIDGEY
	db 3,WEEDLE
	db 2,RATTATA
	db 5,RATTATA
	db 4,WEEDLE
	db 5,WEEDLE

	db $00

Route22Mons:
	db $19
	db 3,RATTATA
	db 3,NIDORAN_M
	db 4,RATTATA
	db 4,NIDORAN_M
	db 2,RATTATA
	db 2,NIDORAN_M
	db 3,SPEAROW
	db 5,SPEAROW
	db 3,NIDORAN_F
	db 4,NIDORAN_F

	db $00

ForestMons:
	db $08
	db 4,WEEDLE
	db 5,KAKUNA
	db 3,WEEDLE
	db 5,WEEDLE
	db 4,KAKUNA
	db 6,KAKUNA
	db 4,METAPOD
	db 3,CATERPIE
	db 3,PIKACHU
	db 5,PIKACHU

	db $00

Route3Mons:
	db $14
	db 6,PIDGEY
	db 5,SPEAROW
	db 7,PIDGEY
	db 6,SPEAROW
	db 7,SPEAROW
	db 8,PIDGEY
	db 8,SPEAROW
	db 3,JIGGLYPUFF
	db 5,JIGGLYPUFF
	db 7,JIGGLYPUFF

	db $00

MoonMons1:
	db $0A
	db 8,ZUBAT
	db 7,ZUBAT
	db 9,ZUBAT
	db 8,GEODUDE
	db 6,ZUBAT
	db 10,ZUBAT
	db 10,GEODUDE
	db 8,PARAS
	db 11,ZUBAT
	db 8,CLEFAIRY

	db $00

MoonMonsB1:
	db $0A
	db 8,ZUBAT
	db 7,ZUBAT
	db 7,GEODUDE
	db 8,GEODUDE
	db 9,ZUBAT
	db 10,PARAS
	db 10,ZUBAT
	db 11,ZUBAT
	db 9,CLEFAIRY
	db 9,GEODUDE

	db $00

MoonMonsB2:
	db $0A
	db 9,ZUBAT
	db 9,GEODUDE
	db 10,ZUBAT
	db 10,GEODUDE
	db 11,ZUBAT
	db 10,PARAS
	db 12,PARAS
	db 10,CLEFAIRY
	db 12,ZUBAT
	db 12,CLEFAIRY

	db $00

Route4Mons:
	db $14
	db 10,RATTATA
	db 10,SPEAROW
	db 8,RATTATA
	db 6,EKANS
	db 8,SPEAROW
	db 10,EKANS
	db 12,RATTATA
	db 12,SPEAROW
	db 8,EKANS
	db 12,EKANS

	db $00

Route24Mons:
	db $19
	db 7,WEEDLE
	db 8,KAKUNA
	db 12,PIDGEY
	db 12,ODDISH
	db 13,ODDISH
	db 10,ABRA
	db 14,ODDISH
	db 13,PIDGEY
	db 8,ABRA
	db 12,ABRA

	db $00

Route25Mons:
	db $0F
	db 8,WEEDLE
	db 9,KAKUNA
	db 13,PIDGEY
	db 12,ODDISH
	db 13,ODDISH
	db 12,ABRA
	db 14,ODDISH
	db 10,ABRA
	db 7,METAPOD
	db 8,CATERPIE

	db $00

Route9Mons:
	db $0F
	db 16,RATTATA
	db 16,SPEAROW
	db 14,RATTATA
	db 11,EKANS
	db 13,SPEAROW
	db 15,EKANS
	db 17,RATTATA
	db 17,SPEAROW
	db 13,EKANS
	db 17,EKANS

	db $00

Route5Mons:
	db $0F
	db 13,ODDISH
	db 13,PIDGEY
	db 15,PIDGEY
	db 10,MANKEY
	db 12,MANKEY
	db 15,ODDISH
	db 16,ODDISH
	db 16,PIDGEY
	db 14,MANKEY
	db 16,MANKEY

	db $00

Route6Mons:
	db $0F
	db 13,ODDISH
	db 13,PIDGEY
	db 15,PIDGEY
	db 10,MANKEY
	db 12,MANKEY
	db 15,ODDISH
	db 16,ODDISH
	db 16,PIDGEY
	db 14,MANKEY
	db 16,MANKEY

	db $00

Route11Mons:
	db $0F
	db 14,EKANS
	db 15,SPEAROW
	db 12,EKANS
	db 9,DROWZEE
	db 13,SPEAROW
	db 13,DROWZEE
	db 15,EKANS
	db 17,SPEAROW
	db 11,DROWZEE
	db 15,DROWZEE

	db $00

TunnelMonsB1:
	db $0F
	db 16,ZUBAT
	db 17,ZUBAT
	db 17,GEODUDE
	db 15,MACHOP
	db 16,GEODUDE
	db 18,ZUBAT
	db 15,ZUBAT
	db 17,MACHOP
	db 13,ONIX
	db 15,ONIX

	db $00

TunnelMonsB2:
	db $0F
	db 16,ZUBAT
	db 17,ZUBAT
	db 17,GEODUDE
	db 15,MACHOP
	db 16,GEODUDE
	db 18,ZUBAT
	db 17,MACHOP
	db 17,ONIX
	db 13,ONIX
	db 18,GEODUDE

	db $00

Route10Mons:
	db $0F
	db 16,VOLTORB
	db 16,SPEAROW
	db 14,VOLTORB
	db 11,EKANS
	db 13,SPEAROW
	db 15,EKANS
	db 17,VOLTORB
	db 17,SPEAROW
	db 13,EKANS
	db 17,EKANS

	db $00

Route12Mons:
	db $0F
	db 24,ODDISH
	db 25,PIDGEY
	db 23,PIDGEY
	db 24,VENONAT
	db 22,ODDISH
	db 26,VENONAT
	db 26,ODDISH
	db 27,PIDGEY
	db 28,GLOOM
	db 30,GLOOM

	db $00

Route8Mons:
	db $0F
	db 18,PIDGEY
	db 18,MANKEY
	db 17,EKANS
	db 16,GROWLITHE
	db 20,PIDGEY
	db 20,MANKEY
	db 19,EKANS
	db 17,GROWLITHE
	db 15,GROWLITHE
	db 18,GROWLITHE

	db $00

Route7Mons:
	db $0F
	db 19,PIDGEY
	db 19,ODDISH
	db 17,MANKEY
	db 22,ODDISH
	db 22,PIDGEY
	db 18,MANKEY
	db 18,GROWLITHE
	db 20,GROWLITHE
	db 19,MANKEY
	db 20,MANKEY

	db $00

TowerMons1:
	db $00

	db $00

TowerMons2:
	db $00

	db $00

TowerMons3:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 24,GASTLY
	db 20,CUBONE
	db 22,CUBONE
	db 25,HAUNTER

	db $00

TowerMons4:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 25,HAUNTER
	db 20,CUBONE
	db 22,CUBONE
	db 24,GASTLY

	db $00

TowerMons5:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 25,HAUNTER
	db 20,CUBONE
	db 22,CUBONE
	db 24,GASTLY

	db $00

TowerMons6:
	db $0F
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 20,GASTLY
	db 19,GASTLY
	db 26,HAUNTER
	db 22,CUBONE
	db 24,CUBONE
	db 28,HAUNTER

	db $00

TowerMons7:
	db $0F
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 20,GASTLY
	db 28,HAUNTER
	db 22,CUBONE
	db 24,CUBONE
	db 28,HAUNTER
	db 30,HAUNTER

	db $00

Route13Mons:
	db $14
	db 24,ODDISH
	db 25,PIDGEY
	db 27,PIDGEY
	db 24,VENONAT
	db 22,ODDISH
	db 26,VENONAT
	db 26,ODDISH
	db 25,DITTO
	db 28,GLOOM
	db 30,GLOOM

	db $00

Route14Mons:
	db $0F
	db 24,ODDISH
	db 26,PIDGEY
	db 23,DITTO
	db 24,VENONAT
	db 22,ODDISH
	db 26,VENONAT
	db 26,ODDISH
	db 30,GLOOM
	db 28,PIDGEOTTO
	db 30,PIDGEOTTO

	db $00

Route15Mons:
	db $0F
	db 24,ODDISH
	db 26,DITTO
	db 23,PIDGEY
	db 26,VENONAT
	db 22,ODDISH
	db 28,VENONAT
	db 26,ODDISH
	db 30,GLOOM
	db 28,PIDGEOTTO
	db 30,PIDGEOTTO

	db $00

Route16Mons:
	db $19
	db 20,SPEAROW
	db 22,SPEAROW
	db 18,RATTATA
	db 20,DODUO
	db 20,RATTATA
	db 18,DODUO
	db 22,DODUO
	db 22,RATTATA
	db 23,RATICATE
	db 25,RATICATE

	db $00

Route17Mons:
	db $19
	db 20,SPEAROW
	db 22,SPEAROW
	db 25,RATICATE
	db 24,DODUO
	db 27,RATICATE
	db 26,DODUO
	db 28,DODUO
	db 29,RATICATE
	db 25,FEAROW
	db 27,FEAROW

	db $00

Route18Mons:
	db $19
	db 20,SPEAROW
	db 22,SPEAROW
	db 25,RATICATE
	db 24,DODUO
	db 25,FEAROW
	db 26,DODUO
	db 28,DODUO
	db 29,RATICATE
	db 27,FEAROW
	db 29,FEAROW

	db $00

ZoneMonsCenter:
	db $1E
	db 22,NIDORAN_M
	db 25,RHYHORN
	db 22,VENONAT
	db 24,EXEGGCUTE
	db 31,NIDORINO
	db 25,EXEGGCUTE
	db 31,NIDORINA
	db 30,PARASECT
	db 23,SCYTHER
	db 23,CHANSEY

	db $00

ZoneMons1:
	db $1E
	db 24,NIDORAN_M
	db 26,DODUO
	db 22,PARAS
	db 25,EXEGGCUTE
	db 33,NIDORINO
	db 23,EXEGGCUTE
	db 24,NIDORAN_F
	db 25,PARASECT
	db 25,KANGASKHAN
	db 28,SCYTHER

	db $00

ZoneMons2:
	db $1E
	db 22,NIDORAN_M
	db 26,RHYHORN
	db 23,PARAS
	db 25,EXEGGCUTE
	db 30,NIDORINO
	db 27,EXEGGCUTE
	db 30,NIDORINA
	db 32,VENOMOTH
	db 26,CHANSEY
	db 28,TAUROS

	db $00

ZoneMons3:
	db $1E
	db 25,NIDORAN_M
	db 26,DODUO
	db 23,VENONAT
	db 24,EXEGGCUTE
	db 33,NIDORINO
	db 26,EXEGGCUTE
	db 25,NIDORAN_F
	db 31,VENOMOTH
	db 26,TAUROS
	db 28,KANGASKHAN

	db $00

WaterMons:
	db $00

	db $05
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 20,TENTACOOL
	db 30,TENTACOOL
	db 35,TENTACOOL
	db 40,TENTACOOL

IslandMons1:
	db $0F
	db 30,SEEL
	db 30,SLOWPOKE
	db 30,SHELLDER
	db 30,HORSEA
	db 28,HORSEA
	db 21,ZUBAT
	db 29,GOLBAT
	db 28,PSYDUCK
	db 28,SHELLDER
	db 38,GOLDUCK

	db $00

IslandMonsB1:
	db $0A
	db 30,STARYU
	db 30,HORSEA
	db 32,SHELLDER
	db 32,HORSEA
	db 28,SLOWPOKE
	db 30,SEEL
	db 30,SLOWPOKE
	db 28,SEEL
	db 38,DEWGONG
	db 37,SEADRA

	db $00

IslandMonsB2:
	db $0A
	db 30,SEEL
	db 30,SLOWPOKE
	db 32,SEEL
	db 32,SLOWPOKE
	db 28,HORSEA
	db 30,STARYU
	db 30,HORSEA
	db 28,SHELLDER
	db 30,GOLBAT
	db 37,SLOWBRO

	db $00

IslandMonsB3:
	db $0A
	db 31,SLOWPOKE
	db 31,SEEL
	db 33,SLOWPOKE
	db 33,SEEL
	db 29,HORSEA
	db 31,SHELLDER
	db 31,HORSEA
	db 29,SHELLDER
	db 39,SEADRA
	db 37,DEWGONG

	db $00

IslandMonsB4:
	db $0A
	db 31,HORSEA
	db 31,SHELLDER
	db 33,HORSEA
	db 33,SHELLDER
	db 29,SLOWPOKE
	db 31,SEEL
	db 31,SLOWPOKE
	db 29,SEEL
	db 39,SLOWBRO
	db 32,GOLBAT

	db $00

MansionMons1:
	db $0A
	db 32,KOFFING
	db 30,KOFFING
	db 34,PONYTA
	db 30,PONYTA
	db 34,GROWLITHE
	db 32,PONYTA
	db 30,GRIMER
	db 28,PONYTA
	db 37,WEEZING
	db 39,MUK

	db $00

MansionMons2:
	db $0A
	db 32,GROWLITHE
	db 34,KOFFING
	db 34,KOFFING
	db 30,PONYTA
	db 30,KOFFING
	db 32,PONYTA
	db 30,GRIMER
	db 28,PONYTA
	db 39,WEEZING
	db 37,MUK

	db $00

MansionMons3:
	db $0A
	db 31,KOFFING
	db 33,GROWLITHE
	db 35,KOFFING
	db 32,PONYTA
	db 34,PONYTA
	db 40,WEEZING
	db 34,GRIMER
	db 38,WEEZING
	db 36,PONYTA
	db 42,MUK

	db $00

MansionMonsB1:
	db $0A
	db 33,KOFFING
	db 31,KOFFING
	db 35,GROWLITHE
	db 32,PONYTA
	db 31,KOFFING
	db 40,WEEZING
	db 34,PONYTA
	db 35,GRIMER
	db 42,WEEZING
	db 42,MUK

	db $00

Route21Mons:
	db $19
	db 21,RATTATA
	db 23,PIDGEY
	db 30,RATICATE
	db 23,RATTATA
	db 21,PIDGEY
	db 30,PIDGEOTTO
	db 32,PIDGEOTTO
	db 28,TANGELA
	db 30,TANGELA
	db 32,TANGELA

	db $05
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 20,TENTACOOL
	db 30,TENTACOOL
	db 35,TENTACOOL
	db 40,TENTACOOL

DungeonMons1:
	db $0A
	db 46,GOLBAT
	db 46,HYPNO
	db 46,MAGNETON
	db 49,DODRIO
	db 49,VENOMOTH
	db 52,ARBOK
	db 49,KADABRA
	db 52,PARASECT
	db 53,RAICHU
	db 53,DITTO

	db $00

DungeonMons2:
	db $0F
	db 51,DODRIO
	db 51,VENOMOTH
	db 51,KADABRA
	db 52,RHYDON
	db 52,MAROWAK
	db 52,ELECTRODE
	db 56,CHANSEY
	db 54,WIGGLYTUFF
	db 55,DITTO
	db 60,DITTO

	db $00

DungeonMonsB1:
	db $19
	db 55,RHYDON
	db 55,MAROWAK
	db 55,ELECTRODE
	db 64,CHANSEY
	db 64,PARASECT
	db 64,RAICHU
	db 57,ARBOK
	db 65,DITTO
	db 63,DITTO
	db 67,DITTO

	db $00

PowerPlantMons:
	db $0A
	db 21,VOLTORB
	db 21,MAGNEMITE
	db 20,PIKACHU
	db 24,PIKACHU
	db 23,MAGNEMITE
	db 23,VOLTORB
	db 32,MAGNETON
	db 35,MAGNETON
	db 33,ELECTABUZZ
	db 36,ELECTABUZZ

	db $00

Route23Mons:
	db $0A
	db 26,EKANS
	db 33,DITTO
	db 26,SPEAROW
	db 38,FEAROW
	db 38,DITTO
	db 38,FEAROW
	db 41,ARBOK
	db 43,DITTO
	db 41,FEAROW
	db 43,FEAROW

	db $00

PlateauMons2:
	db $0A
	db 22,MACHOP
	db 24,GEODUDE
	db 26,ZUBAT
	db 36,ONIX
	db 39,ONIX
	db 42,ONIX
	db 41,MACHOKE
	db 40,GOLBAT
	db 40,MAROWAK
	db 43,GRAVELER

	db $00

PlateauMons3:
	db $0F
	db 24,MACHOP
	db 26,GEODUDE
	db 22,ZUBAT
	db 42,ONIX
	db 40,VENOMOTH
	db 45,ONIX
	db 43,GRAVELER
	db 41,GOLBAT
	db 42,MACHOKE
	db 45,MACHOKE

	db $00

PlateauMons1:
	db $0F
	db 24,MACHOP
	db 26,GEODUDE
	db 22,ZUBAT
	db 36,ONIX
	db 39,ONIX
	db 42,ONIX
	db 41,GRAVELER
	db 41,GOLBAT
	db 42,MACHOKE
	db 43,MAROWAK

	db $00

CaveMons:
	db $14
	db 18,DIGLETT
	db 19,DIGLETT
	db 17,DIGLETT
	db 20,DIGLETT
	db 16,DIGLETT
	db 15,DIGLETT
	db 21,DIGLETT
	db 22,DIGLETT
	db 29,DUGTRIO
	db 31,DUGTRIO

	db $00

ENDC
IF _GREEN || !_JAPAN && _BLUE
NoMons:
	db $00

	db $00

Route1Mons:
	db $19
	db 3,PIDGEY
	db 3,RATTATA
	db 3,RATTATA
	db 2,RATTATA
	db 2,PIDGEY
	db 3,PIDGEY
	db 3,PIDGEY
	db 4,RATTATA
	db 4,PIDGEY
	db 5,PIDGEY

	db $00

Route2Mons:
	db $19
	db 3,RATTATA
	db 3,PIDGEY
	db 4,PIDGEY
	db 4,RATTATA
	db 5,PIDGEY
	db 3,CATERPIE
	db 2,RATTATA
	db 5,RATTATA
	db 4,CATERPIE
	db 5,CATERPIE

	db $00

Route22Mons:
	db $19
	db 3,RATTATA
	db 3,NIDORAN_F
	db 4,RATTATA
	db 4,NIDORAN_F
	db 2,RATTATA
	db 2,NIDORAN_F
	db 3,SPEAROW
	db 5,SPEAROW
	db 3,NIDORAN_M
	db 4,NIDORAN_M

	db $00

ForestMons:
	db $08
	db 4,CATERPIE
	db 5,METAPOD
	db 3,CATERPIE
	db 5,CATERPIE
	db 4,METAPOD
	db 6,METAPOD
	db 4,KAKUNA
	db 3,WEEDLE
	db 3,PIKACHU
	db 5,PIKACHU

	db $00

Route3Mons:
	db $14
	db 6,PIDGEY
	db 5,SPEAROW
	db 7,PIDGEY
	db 6,SPEAROW
	db 7,SPEAROW
	db 8,PIDGEY
	db 8,SPEAROW
	db 3,JIGGLYPUFF
	db 5,JIGGLYPUFF
	db 7,JIGGLYPUFF

	db $00

MoonMons1:
	db $0A
	db 8,ZUBAT
	db 7,ZUBAT
	db 9,ZUBAT
	db 8,GEODUDE
	db 6,ZUBAT
	db 10,ZUBAT
	db 10,GEODUDE
	db 8,PARAS
	db 11,ZUBAT
	db 8,CLEFAIRY

	db $00

MoonMonsB1:
	db $0A
	db 8,ZUBAT
	db 7,ZUBAT
	db 7,GEODUDE
	db 8,GEODUDE
	db 9,ZUBAT
	db 10,PARAS
	db 10,ZUBAT
	db 11,ZUBAT
	db 9,CLEFAIRY
	db 9,GEODUDE

	db $00

MoonMonsB2:
	db $0A
	db 9,ZUBAT
	db 9,GEODUDE
	db 10,ZUBAT
	db 10,GEODUDE
	db 11,ZUBAT
	db 10,PARAS
	db 12,PARAS
	db 10,CLEFAIRY
	db 12,ZUBAT
	db 12,CLEFAIRY

	db $00

Route4Mons:
	db $14
	db 10,RATTATA
	db 10,SPEAROW
	db 8,RATTATA
	db 6,SANDSHREW
	db 8,SPEAROW
	db 10,SANDSHREW
	db 12,RATTATA
	db 12,SPEAROW
	db 8,SANDSHREW
	db 12,SANDSHREW

	db $00

Route24Mons:
	db $19
	db 7,CATERPIE
	db 8,METAPOD
	db 12,PIDGEY
	db 12,BELLSPROUT
	db 13,BELLSPROUT
	db 10,ABRA
	db 14,BELLSPROUT
	db 13,PIDGEY
	db 8,ABRA
	db 12,ABRA

	db $00

Route25Mons:
	db $0F
	db 8,CATERPIE
	db 9,METAPOD
	db 13,PIDGEY
	db 12,BELLSPROUT
	db 13,BELLSPROUT
	db 12,ABRA
	db 14,BELLSPROUT
	db 10,ABRA
	db 7,KAKUNA
	db 8,WEEDLE

	db $00

Route9Mons:
	db $0F
	db 16,RATTATA
	db 16,SPEAROW
	db 14,RATTATA
	db 11,SANDSHREW
	db 13,SPEAROW
	db 15,SANDSHREW
	db 17,RATTATA
	db 17,SPEAROW
	db 13,SANDSHREW
	db 17,SANDSHREW

	db $00

Route5Mons:
	db $0F
	db 13,BELLSPROUT
	db 13,PIDGEY
	db 15,PIDGEY
	db 10,MEOWTH
	db 12,MEOWTH
	db 15,BELLSPROUT
	db 16,BELLSPROUT
	db 16,PIDGEY
	db 14,MEOWTH
	db 16,MEOWTH

	db $00

Route6Mons:
	db $0F
	db 13,BELLSPROUT
	db 13,PIDGEY
	db 15,PIDGEY
	db 10,MEOWTH
	db 12,MEOWTH
	db 15,BELLSPROUT
	db 16,BELLSPROUT
	db 16,PIDGEY
	db 14,MEOWTH
	db 16,MEOWTH

	db $00

Route11Mons:
	db $0F
	db 14,SANDSHREW
	db 15,SPEAROW
	db 12,SANDSHREW
	db 9,DROWZEE
	db 13,SPEAROW
	db 13,DROWZEE
	db 15,SANDSHREW
	db 17,SPEAROW
	db 11,DROWZEE
	db 15,DROWZEE

	db $00

TunnelMonsB1:
	db $0F
	db 16,ZUBAT
	db 17,ZUBAT
	db 17,GEODUDE
	db 15,MACHOP
	db 16,GEODUDE
	db 18,ZUBAT
	db 15,ZUBAT
	db 17,MACHOP
	db 13,ONIX
	db 15,ONIX

	db $00

TunnelMonsB2:
	db $0F
	db 16,ZUBAT
	db 17,ZUBAT
	db 17,GEODUDE
	db 15,MACHOP
	db 16,GEODUDE
	db 18,ZUBAT
	db 17,MACHOP
	db 17,ONIX
	db 13,ONIX
	db 18,GEODUDE

	db $00

Route10Mons:
	db $0F
	db 16,VOLTORB
	db 16,SPEAROW
	db 14,VOLTORB
	db 11,SANDSHREW
	db 13,SPEAROW
	db 15,SANDSHREW
	db 17,VOLTORB
	db 17,SPEAROW
	db 13,SANDSHREW
	db 17,SANDSHREW

	db $00

Route12Mons:
	db $0F
	db 24,BELLSPROUT
	db 25,PIDGEY
	db 23,PIDGEY
	db 24,VENONAT
	db 22,BELLSPROUT
	db 26,VENONAT
	db 26,BELLSPROUT
	db 27,PIDGEY
	db 28,WEEPINBELL
	db 30,WEEPINBELL

	db $00

Route8Mons:
	db $0F
	db 18,PIDGEY
	db 18,MEOWTH
	db 17,SANDSHREW
	db 16,VULPIX
	db 20,PIDGEY
	db 20,MEOWTH
	db 19,SANDSHREW
	db 17,VULPIX
	db 15,VULPIX
	db 18,VULPIX

	db $00

Route7Mons:
	db $0F
	db 19,PIDGEY
	db 19,BELLSPROUT
	db 17,MEOWTH
	db 22,BELLSPROUT
	db 22,PIDGEY
	db 18,MEOWTH
	db 18,VULPIX
	db 20,VULPIX
	db 19,MEOWTH
	db 20,MEOWTH

	db $00

TowerMons1:
	db $00

	db $00

TowerMons2:
	db $00

	db $00

TowerMons3:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 24,GASTLY
	db 20,CUBONE
	db 22,CUBONE
	db 25,HAUNTER

	db $00

TowerMons4:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 25,HAUNTER
	db 20,CUBONE
	db 22,CUBONE
	db 24,GASTLY

	db $00

TowerMons5:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 25,HAUNTER
	db 20,CUBONE
	db 22,CUBONE
	db 24,GASTLY

	db $00

TowerMons6:
	db $0F
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 20,GASTLY
	db 19,GASTLY
	db 26,HAUNTER
	db 22,CUBONE
	db 24,CUBONE
	db 28,HAUNTER

	db $00

TowerMons7:
	db $0F
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 20,GASTLY
	db 28,HAUNTER
	db 22,CUBONE
	db 24,CUBONE
	db 28,HAUNTER
	db 30,HAUNTER

	db $00

Route13Mons:
	db $14
	db 24,BELLSPROUT
	db 25,PIDGEY
	db 27,PIDGEY
	db 24,VENONAT
	db 22,BELLSPROUT
	db 26,VENONAT
	db 26,BELLSPROUT
	db 25,DITTO
	db 28,WEEPINBELL
	db 30,WEEPINBELL

	db $00

Route14Mons:
	db $0F
	db 24,BELLSPROUT
	db 26,PIDGEY
	db 23,DITTO
	db 24,VENONAT
	db 22,BELLSPROUT
	db 26,VENONAT
	db 26,BELLSPROUT
	db 30,WEEPINBELL
	db 28,PIDGEOTTO
	db 30,PIDGEOTTO

	db $00

Route15Mons:
	db $0F
	db 24,BELLSPROUT
	db 26,DITTO
	db 23,PIDGEY
	db 26,VENONAT
	db 22,BELLSPROUT
	db 28,VENONAT
	db 26,BELLSPROUT
	db 30,WEEPINBELL
	db 28,PIDGEOTTO
	db 30,PIDGEOTTO

	db $00

Route16Mons:
	db $19
	db 20,SPEAROW
	db 22,SPEAROW
	db 18,RATTATA
	db 20,DODUO
	db 20,RATTATA
	db 18,DODUO
	db 22,DODUO
	db 22,RATTATA
	db 23,RATICATE
	db 25,RATICATE

	db $00

Route17Mons:
	db $19
	db 20,SPEAROW
	db 22,SPEAROW
	db 25,RATICATE
	db 24,DODUO
	db 27,RATICATE
	db 26,DODUO
	db 28,DODUO
	db 29,RATICATE
	db 25,FEAROW
	db 27,FEAROW

	db $00

Route18Mons:
	db $19
	db 20,SPEAROW
	db 22,SPEAROW
	db 25,RATICATE
	db 24,DODUO
	db 25,FEAROW
	db 26,DODUO
	db 28,DODUO
	db 29,RATICATE
	db 27,FEAROW
	db 29,FEAROW

	db $00

ZoneMonsCenter:
	db $1E
	db 22,NIDORAN_F
	db 25,RHYHORN
	db 22,VENONAT
	db 24,EXEGGCUTE
	db 31,NIDORINA
	db 25,EXEGGCUTE
	db 31,NIDORINO
	db 30,PARASECT
	db 23,PINSIR
	db 23,CHANSEY

	db $00

ZoneMons1:
	db $1E
	db 24,NIDORAN_F
	db 26,DODUO
	db 22,PARAS
	db 25,EXEGGCUTE
	db 33,NIDORINA
	db 23,EXEGGCUTE
	db 24,NIDORAN_M
	db 25,PARASECT
	db 25,KANGASKHAN
	db 28,PINSIR

	db $00

ZoneMons2:
	db $1E
	db 22,NIDORAN_F
	db 26,RHYHORN
	db 23,PARAS
	db 25,EXEGGCUTE
	db 30,NIDORINA
	db 27,EXEGGCUTE
	db 30,NIDORINO
	db 32,VENOMOTH
	db 26,CHANSEY
	db 28,TAUROS

	db $00

ZoneMons3:
	db $1E
	db 25,NIDORAN_F
	db 26,DODUO
	db 23,VENONAT
	db 24,EXEGGCUTE
	db 33,NIDORINA
	db 26,EXEGGCUTE
	db 25,NIDORAN_M
	db 31,VENOMOTH
	db 26,TAUROS
	db 28,KANGASKHAN

	db $00

WaterMons:
	db $00

	db $05
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 20,TENTACOOL
	db 30,TENTACOOL
	db 35,TENTACOOL
	db 40,TENTACOOL

IslandMons1:
	db $0F
	db 30,SEEL
	db 30,PSYDUCK
	db 30,STARYU
	db 30,KRABBY
	db 28,KRABBY
	db 21,ZUBAT
	db 29,GOLBAT
	db 28,SLOWPOKE
	db 28,STARYU
	db 38,SLOWBRO

	db $00

IslandMonsB1:
	db $0A
	db 30,SHELLDER
	db 30,KRABBY
	db 32,STARYU
	db 32,KRABBY
	db 28,PSYDUCK
	db 30,SEEL
	db 30,PSYDUCK
	db 28,SEEL
	db 38,DEWGONG
	db 37,KINGLER

	db $00

IslandMonsB2:
	db $0A
	db 30,SEEL
	db 30,PSYDUCK
	db 32,SEEL
	db 32,PSYDUCK
	db 28,KRABBY
	db 30,SHELLDER
	db 30,KRABBY
	db 28,STARYU
	db 30,GOLBAT
	db 37,GOLDUCK

	db $00

IslandMonsB3:
	db $0A
	db 31,PSYDUCK
	db 31,SEEL
	db 33,PSYDUCK
	db 33,SEEL
	db 29,KRABBY
	db 31,STARYU
	db 31,KRABBY
	db 29,STARYU
	db 39,KINGLER
	db 37,DEWGONG

	db $00

IslandMonsB4:
	db $0A
	db 31,KRABBY
	db 31,STARYU
	db 33,KRABBY
	db 33,STARYU
	db 29,PSYDUCK
	db 31,SEEL
	db 31,PSYDUCK
	db 29,SEEL
	db 39,GOLDUCK
	db 32,GOLBAT

	db $00

MansionMons1:
	db $0A
	db 32,GRIMER
	db 30,GRIMER
	db 34,PONYTA
	db 30,PONYTA
	db 34,VULPIX
	db 32,PONYTA
	db 30,KOFFING
	db 28,PONYTA
	db 37,MUK
	db 39,WEEZING

	db $00

MansionMons2:
	db $0A
	db 32,VULPIX
	db 34,GRIMER
	db 34,GRIMER
	db 30,PONYTA
	db 30,GRIMER
	db 32,PONYTA
	db 30,KOFFING
	db 28,PONYTA
	db 39,MUK
	db 37,WEEZING

	db $00

MansionMons3:
	db $0A
	db 31,GRIMER
	db 33,VULPIX
	db 35,GRIMER
	db 32,PONYTA
	db 34,MAGMAR
	db 40,MUK
	db 34,KOFFING
	db 38,MUK
	db 36,PONYTA
	db 42,WEEZING

	db $00

MansionMonsB1:
	db $0A
	db 33,GRIMER
	db 31,GRIMER
	db 35,VULPIX
	db 32,PONYTA
	db 31,GRIMER
	db 40,MUK
	db 34,PONYTA
	db 35,KOFFING
	db 38,MAGMAR
	db 42,WEEZING

	db $00

Route21Mons:
	db $19
	db 21,RATTATA
	db 23,PIDGEY
	db 30,RATICATE
	db 23,RATTATA
	db 21,PIDGEY
	db 30,PIDGEOTTO
	db 32,PIDGEOTTO
	db 28,TANGELA
	db 30,TANGELA
	db 32,TANGELA

	db $05
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 20,TENTACOOL
	db 30,TENTACOOL
	db 35,TENTACOOL
	db 40,TENTACOOL

DungeonMons1:
	db $0A
	db 46,GOLBAT
	db 46,HYPNO
	db 46,MAGNETON
	db 49,DODRIO
	db 49,VENOMOTH
	db 52,SANDSLASH
	db 49,KADABRA
	db 52,PARASECT
	db 53,RAICHU
	db 53,DITTO

	db $00

DungeonMons2:
	db $0F
	db 51,DODRIO
	db 51,VENOMOTH
	db 51,KADABRA
	db 52,RHYDON
	db 52,MAROWAK
	db 52,ELECTRODE
	db 56,CHANSEY
	db 54,WIGGLYTUFF
	db 55,DITTO
	db 60,DITTO

	db $00

DungeonMonsB1:
	db $19
	db 55,RHYDON
	db 55,MAROWAK
	db 55,ELECTRODE
	db 64,CHANSEY
	db 64,PARASECT
	db 64,RAICHU
	db 57,SANDSLASH
	db 65,DITTO
	db 63,DITTO
	db 67,DITTO

	db $00

PowerPlantMons:
	db $0A
	db 21,VOLTORB
	db 21,MAGNEMITE
	db 20,PIKACHU
	db 24,PIKACHU
	db 23,MAGNEMITE
	db 23,VOLTORB
	db 32,MAGNETON
	db 35,MAGNETON
	db 33,RAICHU
	db 36,RAICHU

	db $00

Route23Mons:
	db $0A
	db 26,SANDSHREW
	db 33,DITTO
	db 26,SPEAROW
	db 38,FEAROW
	db 38,DITTO
	db 38,FEAROW
	db 41,SANDSLASH
	db 43,DITTO
	db 41,FEAROW
	db 43,FEAROW

	db $00

PlateauMons2:
	db $0A
	db 22,MACHOP
	db 24,GEODUDE
	db 26,ZUBAT
	db 36,ONIX
	db 39,ONIX
	db 42,ONIX
	db 41,MACHOKE
	db 40,GOLBAT
	db 40,MAROWAK
	db 43,GRAVELER

	db $00

PlateauMons3:
	db $0F
	db 24,MACHOP
	db 26,GEODUDE
	db 22,ZUBAT
	db 42,ONIX
	db 40,VENOMOTH
	db 45,ONIX
	db 43,GRAVELER
	db 41,GOLBAT
	db 42,MACHOKE
	db 45,MACHOKE

	db $00

PlateauMons1:
	db $0F
	db 24,MACHOP
	db 26,GEODUDE
	db 22,ZUBAT
	db 36,ONIX
	db 39,ONIX
	db 42,ONIX
	db 41,GRAVELER
	db 41,GOLBAT
	db 42,MACHOKE
	db 43,MAROWAK

	db $00

CaveMons:
	db $14
	db 18,DIGLETT
	db 19,DIGLETT
	db 17,DIGLETT
	db 20,DIGLETT
	db 16,DIGLETT
	db 15,DIGLETT
	db 21,DIGLETT
	db 22,DIGLETT
	db 29,DUGTRIO
	db 31,DUGTRIO

	db $00

ENDC
IF _JAPAN && _BLUE
NoMons:
	db $00

	db $00

Route1Mons:
	db $19
	db 3,PIDGEY
	db 3,RATTATA
	db 3,RATTATA
	db 2,RATTATA
	db 2,PIDGEY
	db 3,PIDGEY
	db 3,PIDGEY
	db 4,RATTATA
	db 4,PIDGEY
	db 5,PIDGEY

	db $00

Route2Mons:
	db $19
	db 3,RATTATA
	db 3,PIDGEY
	db 4,PIDGEY
	db 4,RATTATA
	db 5,PIDGEY
	db 3,CATERPIE
	db 2,RATTATA
	db 5,RATTATA
	db 4,CATERPIE
	db 5,CATERPIE

	db $00

Route22Mons:
	db $19
	db 3,RATTATA
	db 3,NIDORAN_M
	db 4,RATTATA
	db 4,NIDORAN_M
	db 2,RATTATA
	db 2,NIDORAN_M
	db 3,SPEAROW
	db 5,SPEAROW
	db 3,NIDORAN_F
	db 4,NIDORAN_F

	db $00

ForestMons:
	db $08
	db 4,CATERPIE
	db 5,METAPOD
	db 3,CATERPIE
	db 5,CATERPIE
	db 4,METAPOD
	db 6,METAPOD
	db 4,KAKUNA
	db 3,WEEDLE
	db 3,PIKACHU
	db 5,PIKACHU

	db $00

Route3Mons:
	db $14
	db 6,PIDGEY
	db 5,SPEAROW
	db 7,PIDGEY
	db 6,SPEAROW
	db 7,SPEAROW
	db 8,PIDGEY
	db 8,SPEAROW
	db 3,JIGGLYPUFF
	db 5,JIGGLYPUFF
	db 7,JIGGLYPUFF

	db $00

MoonMons1:
	db $0A
	db 8,ZUBAT
	db 7,ZUBAT
	db 9,ZUBAT
	db 8,GEODUDE
	db 6,ZUBAT
	db 10,ZUBAT
	db 10,GEODUDE
	db 8,PARAS
	db 11,ZUBAT
	db 8,CLEFAIRY

	db $00

MoonMonsB1:
	db $0A
	db 8,ZUBAT
	db 7,ZUBAT
	db 7,GEODUDE
	db 8,GEODUDE
	db 9,ZUBAT
	db 10,PARAS
	db 10,ZUBAT
	db 11,ZUBAT
	db 9,CLEFAIRY
	db 9,GEODUDE

	db $00

MoonMonsB2:
	db $0A
	db 9,ZUBAT
	db 9,GEODUDE
	db 10,ZUBAT
	db 10,GEODUDE
	db 11,ZUBAT
	db 10,PARAS
	db 12,PARAS
	db 10,CLEFAIRY
	db 12,ZUBAT
	db 12,CLEFAIRY

	db $00

Route4Mons:
	db $14
	db 10,RATTATA
	db 10,SPEAROW
	db 8,RATTATA
	db 6,SANDSHREW
	db 8,SPEAROW
	db 10,SANDSHREW
	db 12,RATTATA
	db 12,SPEAROW
	db 8,SANDSHREW
	db 12,SANDSHREW

	db $00

Route24Mons:
	db $19
	db 7,CATERPIE
	db 8,METAPOD
	db 12,PIDGEY
	db 12,ODDISH
	db 13,ODDISH
	db 10,ABRA
	db 14,ODDISH
	db 13,PIDGEY
	db 8,ABRA
	db 12,ABRA

	db $00

Route25Mons:
	db $0F
	db 8,CATERPIE
	db 9,METAPOD
	db 13,PIDGEY
	db 12,ODDISH
	db 13,ODDISH
	db 12,ABRA
	db 14,ODDISH
	db 10,ABRA
	db 7,KAKUNA
	db 8,WEEDLE

	db $00

Route9Mons:
	db $0F
	db 16,RATTATA
	db 16,SPEAROW
	db 14,RATTATA
	db 11,SANDSHREW
	db 13,SPEAROW
	db 15,SANDSHREW
	db 17,RATTATA
	db 17,SPEAROW
	db 13,SANDSHREW
	db 17,SANDSHREW

	db $00

Route5Mons:
	db $0F
	db 13,ODDISH
	db 13,PIDGEY
	db 15,PIDGEY
	db 10,MEOWTH
	db 12,MEOWTH
	db 15,ODDISH
	db 16,ODDISH
	db 16,PIDGEY
	db 14,MEOWTH
	db 16,MEOWTH

	db $00

Route6Mons:
	db $0F
	db 13,ODDISH
	db 13,PIDGEY
	db 15,PIDGEY
	db 10,MEOWTH
	db 12,MEOWTH
	db 15,ODDISH
	db 16,ODDISH
	db 16,PIDGEY
	db 14,MEOWTH
	db 16,MEOWTH

	db $00

Route11Mons:
	db $0F
	db 14,SANDSHREW
	db 15,SPEAROW
	db 12,SANDSHREW
	db 9,DROWZEE
	db 13,SPEAROW
	db 13,DROWZEE
	db 15,SANDSHREW
	db 17,SPEAROW
	db 11,DROWZEE
	db 15,DROWZEE

	db $00

TunnelMonsB1:
	db $0F
	db 16,ZUBAT
	db 17,ZUBAT
	db 17,GEODUDE
	db 15,MACHOP
	db 16,GEODUDE
	db 18,DITTO
	db 15,ZUBAT
	db 17,MACHOP
	db 13,ONIX
	db 15,ONIX

	db $00

TunnelMonsB2:
	db $0F
	db 16,ZUBAT
	db 17,ZUBAT
	db 17,GEODUDE
	db 15,MACHOP
	db 16,GEODUDE
	db 18,DITTO
	db 17,MACHOP
	db 17,ONIX
	db 13,ONIX
	db 18,GEODUDE

	db $00

Route10Mons:
	db $0F
	db 16,VOLTORB
	db 16,SPEAROW
	db 14,VOLTORB
	db 11,SANDSHREW
	db 13,SPEAROW
	db 15,SANDSHREW
	db 17,VOLTORB
	db 17,SPEAROW
	db 13,SANDSHREW
	db 17,SANDSHREW

	db $00

Route12Mons:
	db $0F
	db 24,ODDISH
	db 25,PIDGEY
	db 23,PIDGEY
	db 24,VENONAT
	db 22,ODDISH
	db 26,VENONAT
	db 26,ODDISH
	db 27,PIDGEY
	db 28,GLOOM
	db 30,GLOOM

	db $00

Route8Mons:
	db $0F
	db 18,PIDGEY
	db 18,MEOWTH
	db 17,SANDSHREW
	db 16,GROWLITHE
	db 20,PIDGEY
	db 20,MEOWTH
	db 19,SANDSHREW
	db 17,GROWLITHE
	db 15,GROWLITHE
	db 18,GROWLITHE

	db $00

Route7Mons:
	db $0F
	db 19,PIDGEY
	db 19,ODDISH
	db 17,MEOWTH
	db 22,ODDISH
	db 22,PIDGEY
	db 18,MEOWTH
	db 18,GROWLITHE
	db 20,GROWLITHE
	db 19,MEOWTH
	db 20,MEOWTH

	db $00

TowerMons1:
	db $00

	db $00

TowerMons2:
	db $00

	db $00

TowerMons3:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 24,GASTLY
	db 20,CUBONE
	db 22,CUBONE
	db 25,HAUNTER

	db $00

TowerMons4:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 25,HAUNTER
	db 20,CUBONE
	db 22,CUBONE
	db 24,GASTLY

	db $00

TowerMons5:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 25,HAUNTER
	db 20,CUBONE
	db 22,CUBONE
	db 24,GASTLY

	db $00

TowerMons6:
	db $0F
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 20,GASTLY
	db 19,GASTLY
	db 26,HAUNTER
	db 22,CUBONE
	db 24,CUBONE
	db 28,HAUNTER

	db $00

TowerMons7:
	db $0F
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 20,GASTLY
	db 28,HAUNTER
	db 22,CUBONE
	db 24,CUBONE
	db 28,HAUNTER
	db 30,HAUNTER

	db $00

Route13Mons:
	db $14
	db 24,ODDISH
	db 25,PIDGEY
	db 27,PIDGEY
	db 24,VENONAT
	db 22,ODDISH
	db 26,VENONAT
	db 26,ODDISH
	db 25,DITTO
	db 28,GLOOM
	db 30,GLOOM

	db $00

Route14Mons:
	db $0F
	db 24,ODDISH
	db 26,PIDGEY
	db 23,DITTO
	db 24,VENONAT
	db 22,ODDISH
	db 26,VENONAT
	db 26,ODDISH
	db 30,GLOOM
	db 28,PIDGEOTTO
	db 30,PIDGEOTTO

	db $00

Route15Mons:
	db $0F
	db 24,ODDISH
	db 26,DITTO
	db 23,PIDGEY
	db 26,VENONAT
	db 22,ODDISH
	db 28,VENONAT
	db 26,ODDISH
	db 30,GLOOM
	db 28,PIDGEOTTO
	db 30,PIDGEOTTO

	db $00

Route16Mons:
	db $19
	db 20,SPEAROW
	db 22,SPEAROW
	db 18,RATTATA
	db 20,DODUO
	db 20,RATTATA
	db 18,DODUO
	db 22,DODUO
	db 22,RATTATA
	db 23,RATICATE
	db 25,RATICATE

	db $00

Route17Mons:
	db $19
	db 20,SPEAROW
	db 22,SPEAROW
	db 25,RATICATE
	db 24,DODUO
	db 27,RATICATE
	db 26,DODUO
	db 28,DODUO
	db 29,RATICATE
	db 25,FEAROW
	db 27,FEAROW

	db $00

Route18Mons:
	db $19
	db 20,SPEAROW
	db 22,SPEAROW
	db 25,RATICATE
	db 24,DODUO
	db 25,FEAROW
	db 26,DODUO
	db 28,DODUO
	db 29,RATICATE
	db 27,FEAROW
	db 29,FEAROW

	db $00

ZoneMonsCenter:
	db $1E
	db 22,NIDORAN_M
	db 25,RHYHORN
	db 22,VENONAT
	db 24,EXEGGCUTE
	db 31,NIDORINO
	db 25,EXEGGCUTE
	db 31,NIDORINA
	db 30,PARASECT
	db 23,SCYTHER
	db 23,CHANSEY

	db $00

ZoneMons1:
	db $1E
	db 24,NIDORAN_M
	db 26,DODUO
	db 22,PARAS
	db 25,EXEGGCUTE
	db 33,NIDORINO
	db 23,EXEGGCUTE
	db 24,NIDORAN_F
	db 25,PARASECT
	db 25,LICKITUNG
	db 28,SCYTHER

	db $00

ZoneMons2:
	db $1E
	db 22,NIDORAN_M
	db 26,RHYHORN
	db 23,PARAS
	db 25,EXEGGCUTE
	db 30,NIDORINO
	db 27,EXEGGCUTE
	db 30,NIDORINA
	db 32,VENOMOTH
	db 26,CHANSEY
	db 28,PINSIR

	db $00

ZoneMons3:
	db $1E
	db 25,NIDORAN_M
	db 26,DODUO
	db 23,VENONAT
	db 24,EXEGGCUTE
	db 33,NIDORINO
	db 26,EXEGGCUTE
	db 25,NIDORAN_F
	db 31,VENOMOTH
	db 26,PINSIR
	db 28,LICKITUNG

	db $00

WaterMons:
	db $00

	db $05
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 20,TENTACOOL
	db 30,TENTACOOL
	db 35,TENTACOOL
	db 40,TENTACOOL

WaterMons:
	db $00

	db $05
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 20,TENTACOOL
	db 30,TENTACOOL
	db 35,TENTACOOL
	db 40,TENTACOOL

IslandMons1:
	db $0F
	db 30,SEEL
	db 30,HORSEA
	db 30,STARYU
	db 30,KRABBY
	db 28,KRABBY
	db 21,ZUBAT
	db 29,GOLBAT
	db 28,SLOWPOKE
	db 28,STARYU
	db 38,SLOWBRO

	db $00

IslandMonsB1:
	db $0A
	db 30,SHELLDER
	db 30,KRABBY
	db 32,STARYU
	db 32,KRABBY
	db 28,HORSEA
	db 30,SEEL
	db 30,HORSEA
	db 28,SEEL
	db 38,DEWGONG
	db 37,KINGLER

	db $00

IslandMonsB2:
	db $0A
	db 30,SEEL
	db 30,HORSEA
	db 32,SEEL
	db 32,HORSEA
	db 28,KRABBY
	db 30,SHELLDER
	db 30,KRABBY
	db 28,STARYU
	db 30,GOLBAT
	db 37,JYNX

	db $00

IslandMonsB3:
	db $0A
	db 31,HORSEA
	db 31,SEEL
	db 33,HORSEA
	db 33,SEEL
	db 29,KRABBY
	db 31,STARYU
	db 31,KRABBY
	db 29,STARYU
	db 39,KINGLER
	db 37,DEWGONG

	db $00

IslandMonsB4:
	db $0A
	db 31,KRABBY
	db 31,STARYU
	db 33,KRABBY
	db 33,STARYU
	db 29,HORSEA
	db 31,SEEL
	db 31,HORSEA
	db 29,SEEL
	db 39,JYNX
	db 32,GOLBAT

	db $00

MansionMons1:
	db $0A
	db 32,GRIMER
	db 30,GRIMER
	db 34,PONYTA
	db 30,PONYTA
	db 34,GROWLITHE
	db 32,PONYTA
	db 30,KOFFING
	db 28,PONYTA
	db 37,MUK
	db 39,WEEZING

	db $00

MansionMons2:
	db $0A
	db 32,GROWLITHE
	db 34,GRIMER
	db 34,GRIMER
	db 30,PONYTA
	db 30,GRIMER
	db 32,PONYTA
	db 30,KOFFING
	db 28,PONYTA
	db 39,MUK
	db 37,WEEZING

	db $00

MansionMons3:
	db $0A
	db 31,GRIMER
	db 33,GROWLITHE
	db 35,GRIMER
	db 32,PONYTA
	db 34,PONYTA
	db 40,MUK
	db 34,KOFFING
	db 38,MUK
	db 36,PONYTA
	db 42,WEEZING

	db $00

MansionMonsB1:
	db $0A
	db 33,GRIMER
	db 31,GRIMER
	db 35,GROWLITHE
	db 32,PONYTA
	db 31,GRIMER
	db 40,MUK
	db 34,PONYTA
	db 35,KOFFING
	db 38,MUK
	db 42,WEEZING

	db $00

Route21Mons:
	db $19
	db 21,RATTATA
	db 23,PIDGEY
	db 30,RATICATE
	db 23,RATTATA
	db 21,PIDGEY
	db 30,PIDGEOTTO
	db 32,PIDGEOTTO
	db 28,TANGELA
	db 30,TANGELA
	db 32,TANGELA

	db $05
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 20,TENTACOOL
	db 30,TENTACOOL
	db 35,TENTACOOL
	db 40,TENTACOOL

DungeonMons1:
	db $0A
	db 46,GOLBAT
	db 46,HYPNO
	db 46,MAGNETON
	db 49,RAPIDASH
	db 49,VENOMOTH
	db 52,SANDSLASH
	db 49,KADABRA
	db 52,PARASECT
	db 53,RAICHU
	db 53,DITTO

	db $00

DungeonMons2:
	db $0F
	db 51,DODRIO
	db 51,VENOMOTH
	db 51,KADABRA
	db 52,RHYDON
	db 52,RATICATE
	db 52,ELECTRODE
	db 56,CHANSEY
	db 54,WIGGLYTUFF
	db 55,DITTO
	db 60,DITTO

	db $00

DungeonMonsB1:
	db $19
	db 55,RHYDON
	db 55,MAROWAK
	db 55,ELECTRODE
	db 64,CLEFAIRY
	db 64,PARASECT
	db 64,RAICHU
	db 57,SANDSLASH
	db 65,DITTO
	db 63,DITTO
	db 67,DITTO

	db $00

PowerPlantMons:
	db $0A
	db 21,VOLTORB
	db 21,MAGNEMITE
	db 20,PIKACHU
	db 24,PIKACHU
	db 23,MAGNEMITE
	db 23,VOLTORB
	db 32,MAGNETON
	db 35,MAGNETON
	db 33,RAICHU
	db 36,RAICHU

	db $00

Route23Mons:
	db $0A
	db 26,SANDSHREW
	db 33,DITTO
	db 26,SPEAROW
	db 38,FEAROW
	db 38,DITTO
	db 38,FEAROW
	db 41,SANDSLASH
	db 43,DITTO
	db 41,FEAROW
	db 43,FEAROW

	db $00

PlateauMons2:
	db $0A
	db 22,MACHOP
	db 24,GEODUDE
	db 26,ZUBAT
	db 36,ONIX
	db 39,ONIX
	db 42,ONIX
	db 41,MACHOKE
	db 40,GOLBAT
	db 40,MAROWAK
	db 43,GRAVELER

	db $00

PlateauMons3:
	db $0F
	db 24,MACHOP
	db 26,GEODUDE
	db 22,ZUBAT
	db 42,ONIX
	db 40,VENOMOTH
	db 45,ONIX
	db 43,GRAVELER
	db 41,GOLBAT
	db 42,MACHOKE
	db 45,MACHOKE

	db $00

PlateauMons1:
	db $0F
	db 24,MACHOP
	db 26,GEODUDE
	db 22,ZUBAT
	db 36,ONIX
	db 39,ONIX
	db 42,ONIX
	db 41,GRAVELER
	db 41,GOLBAT
	db 42,MACHOKE
	db 43,MAROWAK

	db $00

CaveMons:
	db $14
	db 18,DIGLETT
	db 19,DIGLETT
	db 17,DIGLETT
	db 20,DIGLETT
	db 16,DIGLETT
	db 15,DIGLETT
	db 21,DIGLETT
	db 22,DIGLETT
	db 29,DUGTRIO
	db 31,DUGTRIO

	db $00

ENDC
IF _YELLOW
NoMons:
	db $00

	db $00

Route1Mons:
	db $19
	db 3,PIDGEY
	db 4,PIDGEY
	db 2,RATTATA
	db 3,RATTATA
	db 2,PIDGEY
	db 3,PIDGEY
	db 5,PIDGEY
	db 4,RATTATA
	db 6,PIDGEY
	db 7,PIDGEY

	db $00

Route2Mons:
	db $19
	db 3,RATTATA
	db 3,PIDGEY
	db 4,RATTATA
	db 4,NIDORAN_M
	db 4,NIDORAN_F
	db 5,PIDGEY
	db 6,NIDORAN_M
	db 6,NIDORAN_F
	db 7,PIDGEY
	db 7,PIDGEY

	db $00

Route22Mons:
	db $19
	db 2,NIDORAN_M
	db 2,NIDORAN_F
	db 3,MANKEY
	db 3,RATTATA
	db 4,NIDORAN_M
	db 4,NIDORAN_F
	db 5,MANKEY
	db 2,SPEAROW
	db 4,SPEAROW
	db 6,SPEAROW

	db $00

ForestMons:
	db $19
	db 3,CATERPIE
	db 4,METAPOD
	db 4,CATERPIE
	db 5,CATERPIE
	db 4,PIDGEY
	db 6,PIDGEY
	db 6,CATERPIE
	db 6,METAPOD
	db 8,PIDGEY
	db 9,PIDGEOTTO

	db $00

Route3Mons:
	db $14
	db 8,SPEAROW
	db 9,SPEAROW
	db 9,MANKEY
	db 10,SPEAROW
	db 8,SANDSHREW
	db 10,RATTATA
	db 10,SANDSHREW
	db 12,RATTATA
	db 11,SPEAROW
	db 12,SPEAROW

	db $00

MoonMons1:
	db $0A
	db 8,ZUBAT
	db 9,ZUBAT
	db 10,GEODUDE
	db 6,ZUBAT
	db 7,ZUBAT
	db 10,ZUBAT
	db 10,GEODUDE
	db 11,ZUBAT
	db 12,SANDSHREW
	db 11,CLEFAIRY

	db $00

MoonMonsB1:
	db $0A
	db 8,ZUBAT
	db 9,ZUBAT
	db 10,ZUBAT
	db 10,GEODUDE
	db 11,GEODUDE
	db 11,ZUBAT
	db 9,PARAS
	db 11,PARAS
	db 10,CLEFAIRY
	db 12,CLEFAIRY

	db $00

MoonMonsB2:
	db $0A
	db 10,ZUBAT
	db 11,GEODUDE
	db 13,PARAS
	db 11,ZUBAT
	db 11,ZUBAT
	db 12,ZUBAT
	db 13,ZUBAT
	db 9,CLEFAIRY
	db 11,CLEFAIRY
	db 13,CLEFAIRY

	db $00

Route4Mons:
	db $14
	db 8,SPEAROW
	db 9,SPEAROW
	db 9,MANKEY
	db 10,SPEAROW
	db 8,SANDSHREW
	db 10,RATTATA
	db 10,SANDSHREW
	db 12,RATTATA
	db 11,SPEAROW
	db 12,SPEAROW

	db $00

Route24Mons:
	db $19
	db 12,ODDISH
	db 12,BELLSPROUT
	db 13,PIDGEY
	db 14,ODDISH
	db 14,BELLSPROUT
	db 15,PIDGEY
	db 13,VENONAT
	db 16,VENONAT
	db 17,PIDGEY
	db 17,PIDGEOTTO

	db $00

Route25Mons:
	db $0F
	db 12,ODDISH
	db 12,BELLSPROUT
	db 13,PIDGEY
	db 14,ODDISH
	db 14,BELLSPROUT
	db 15,PIDGEY
	db 13,VENONAT
	db 16,VENONAT
	db 17,PIDGEY
	db 17,PIDGEOTTO

	db $00

Route9Mons:
	db $0F
	db 16,NIDORAN_M
	db 16,NIDORAN_F
	db 18,RATTATA
	db 18,NIDORAN_M
	db 18,NIDORAN_F
	db 17,SPEAROW
	db 18,NIDORINO
	db 18,NIDORINA
	db 20,RATICATE
	db 19,FEAROW

	db $00

Route5Mons:
	db $0F
	db 15,PIDGEY
	db 14,RATTATA
	db 7,ABRA
	db 16,PIDGEY
	db 16,RATTATA
	db 17,PIDGEY
	db 17,PIDGEOTTO
	db 3,JIGGLYPUFF
	db 5,JIGGLYPUFF
	db 7,JIGGLYPUFF

	db $00

Route6Mons:
	db $0F
	db 15,PIDGEY
	db 14,RATTATA
	db 7,ABRA
	db 16,PIDGEY
	db 16,RATTATA
	db 17,PIDGEY
	db 17,PIDGEOTTO
	db 3,JIGGLYPUFF
	db 5,JIGGLYPUFF
	db 7,JIGGLYPUFF

	db $03
	db 15,PSYDUCK
	db 15,PSYDUCK
	db 15,PSYDUCK
	db 15,PSYDUCK
	db 15,PSYDUCK
	db 15,PSYDUCK
	db 15,PSYDUCK
	db 15,PSYDUCK
	db 15,GOLDUCK
	db 20,GOLDUCK

Route11Mons:
	db $0F
	db 16,PIDGEY
	db 15,RATTATA
	db 18,PIDGEY
	db 15,DROWZEE
	db 17,RATTATA
	db 17,DROWZEE
	db 18,PIDGEOTTO
	db 20,PIDGEOTTO
	db 19,DROWZEE
	db 17,RATICATE

	db $00

TunnelMonsB1:
	db $0F
	db 15,ZUBAT
	db 16,GEODUDE
	db 17,ZUBAT
	db 19,ZUBAT
	db 18,GEODUDE
	db 20,GEODUDE
	db 21,ZUBAT
	db 17,MACHOP
	db 19,MACHOP
	db 21,MACHOP

	db $00

TunnelMonsB2:
	db $0F
	db 20,ZUBAT
	db 17,GEODUDE
	db 18,MACHOP
	db 21,ZUBAT
	db 22,ZUBAT
	db 21,GEODUDE
	db 20,MACHOP
	db 14,ONIX
	db 18,ONIX
	db 22,ONIX

	db $00

Route10Mons:
	db $0F
	db 16,MAGNEMITE
	db 18,RATTATA
	db 18,MAGNEMITE
	db 20,MAGNEMITE
	db 17,NIDORAN_M
	db 17,NIDORAN_F
	db 22,MAGNEMITE
	db 20,RATICATE
	db 16,MACHOP
	db 18,MACHOP

	db $00

Route12Mons:
	db $0F
	db 25,ODDISH
	db 25,BELLSPROUT
	db 28,PIDGEY
	db 28,PIDGEOTTO
	db 27,ODDISH
	db 27,BELLSPROUT
	db 29,GLOOM
	db 29,WEEPINBELL
	db 26,FARFETCH_D
	db 31,FARFETCH_D

	db $03
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWBRO
	db 20,SLOWBRO

Route8Mons:
	db $0F
	db 20,PIDGEY
	db 22,PIDGEY
	db 20,RATTATA
	db 15,ABRA
	db 19,ABRA
	db 24,PIDGEOTTO
	db 19,JIGGLYPUFF
	db 24,JIGGLYPUFF
	db 20,KADABRA
	db 27,KADABRA

	db $00

Route7Mons:
	db $0F
	db 20,PIDGEY
	db 22,PIDGEY
	db 20,RATTATA
	db 15,ABRA
	db 19,ABRA
	db 24,PIDGEOTTO
	db 26,ABRA
	db 19,JIGGLYPUFF
	db 24,JIGGLYPUFF
	db 24,JIGGLYPUFF

	db $00

TowerMons1:
	db $00

	db $00

TowerMons2:
	db $00

	db $00

TowerMons3:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 25,GASTLY
	db 20,HAUNTER
	db 25,HAUNTER

	db $00

TowerMons4:
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 19,GASTLY
	db 18,GASTLY
	db 25,GASTLY
	db 20,HAUNTER
	db 25,HAUNTER

	db $00

TowerMons5:
	db $0F
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 25,GASTLY
	db 26,GASTLY
	db 21,GASTLY
	db 20,CUBONE
	db 27,GASTLY
	db 22,HAUNTER
	db 27,HAUNTER

	db $00

TowerMons6:
	db $0F
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 25,GASTLY
	db 26,GASTLY
	db 21,GASTLY
	db 22,CUBONE
	db 27,GASTLY
	db 22,HAUNTER
	db 27,HAUNTER

	db $00

TowerMons7:
	db $14
	db 24,GASTLY
	db 25,GASTLY
	db 26,GASTLY
	db 27,GASTLY
	db 28,GASTLY
	db 23,GASTLY
	db 24,CUBONE
	db 29,GASTLY
	db 24,HAUNTER
	db 29,HAUNTER

	db $00

Route13Mons:
	db $0F
	db 25,ODDISH
	db 25,BELLSPROUT
	db 28,PIDGEOTTO
	db 28,PIDGEY
	db 27,ODDISH
	db 27,BELLSPROUT
	db 29,GLOOM
	db 29,WEEPINBELL
	db 26,FARFETCH_D
	db 31,FARFETCH_D

	db $03
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWPOKE
	db 15,SLOWBRO
	db 20,SLOWBRO

Route14Mons:
	db $0F
	db 26,ODDISH
	db 26,BELLSPROUT
	db 24,VENONAT
	db 30,PIDGEOTTO
	db 28,ODDISH
	db 28,BELLSPROUT
	db 30,GLOOM
	db 30,WEEPINBELL
	db 27,VENONAT
	db 30,VENOMOTH

	db $00

Route15Mons:
	db $0F
	db 26,ODDISH
	db 26,BELLSPROUT
	db 24,VENONAT
	db 32,PIDGEOTTO
	db 28,ODDISH
	db 28,BELLSPROUT
	db 30,GLOOM
	db 30,WEEPINBELL
	db 27,VENONAT
	db 30,VENOMOTH

	db $00

Route16Mons:
	db $19
	db 22,SPEAROW
	db 22,DODUO
	db 23,RATTATA
	db 24,DODUO
	db 24,RATTATA
	db 26,DODUO
	db 23,SPEAROW
	db 24,FEAROW
	db 25,RATICATE
	db 26,RATICATE

	db $00

Route17Mons:
	db $19
	db 26,DODUO
	db 27,FEAROW
	db 27,DODUO
	db 28,DODUO
	db 28,PONYTA
	db 30,PONYTA
	db 29,FEAROW
	db 28,DODUO
	db 32,PONYTA
	db 29,DODRIO

	db $00

Route18Mons:
	db $19
	db 22,SPEAROW
	db 22,DODUO
	db 23,RATTATA
	db 24,DODUO
	db 24,RATTATA
	db 26,DODUO
	db 23,SPEAROW
	db 24,FEAROW
	db 25,RATICATE
	db 26,RATICATE

	db $00

ZoneMonsCenter:
	db $1E
	db 14,NIDORAN_M
	db 36,NIDORAN_F
	db 24,EXEGGCUTE
	db 20,RHYHORN
	db 23,NIDORINO
	db 27,PARASECT
	db 27,PARAS
	db 32,PARASECT
	db 22,TANGELA
	db 7,CHANSEY

	db $00

ZoneMons1:
	db $1E
	db 21,NIDORAN_M
	db 29,NIDORAN_F
	db 22,EXEGGCUTE
	db 21,TAUROS
	db 32,NIDORINA
	db 19,CUBONE
	db 26,EXEGGCUTE
	db 24,MAROWAK
	db 21,CHANSEY
	db 15,SCYTHER

	db $00

ZoneMons2:
	db $1E
	db 36,NIDORAN_M
	db 14,NIDORAN_F
	db 20,EXEGGCUTE
	db 25,RHYHORN
	db 23,NIDORINA
	db 28,KANGASKHAN
	db 16,CUBONE
	db 33,KANGASKHAN
	db 25,SCYTHER
	db 15,PINSIR

	db $00

ZoneMons3:
	db $1E
	db 29,NIDORAN_M
	db 21,NIDORAN_F
	db 22,EXEGGCUTE
	db 21,TAUROS
	db 32,NIDORINO
	db 19,CUBONE
	db 26,EXEGGCUTE
	db 24,MAROWAK
	db 25,PINSIR
	db 27,TANGELA

	db $00

WaterMons:
	db $00

	db $05
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 20,TENTACOOL
	db 30,TENTACOOL
	db 35,TENTACOOL
	db 40,TENTACOOL

WaterMons:
	db $00

	db $05
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 20,TENTACOOL
	db 30,TENTACOOL
	db 35,TENTACOOL
	db 40,TENTACOOL

IslandMons1:
	db $0F
	db 18,ZUBAT
	db 25,KRABBY
	db 27,KRABBY
	db 27,ZUBAT
	db 36,ZUBAT
	db 28,SLOWPOKE
	db 30,SLOWPOKE
	db 9,ZUBAT
	db 27,GOLBAT
	db 36,GOLBAT

	db $00

IslandMonsB1:
	db $0A
	db 27,ZUBAT
	db 26,KRABBY
	db 36,ZUBAT
	db 28,KRABBY
	db 27,GOLBAT
	db 29,SLOWPOKE
	db 18,ZUBAT
	db 28,KINGLER
	db 22,SEEL
	db 26,SEEL

	db $00

IslandMonsB2:
	db $0A
	db 27,ZUBAT
	db 27,KRABBY
	db 36,ZUBAT
	db 27,GOLBAT
	db 28,KINGLER
	db 24,SEEL
	db 29,KRABBY
	db 36,GOLBAT
	db 31,SLOWPOKE
	db 31,SLOWBRO

	db $00

IslandMonsB3:
	db $0A
	db 27,GOLBAT
	db 36,ZUBAT
	db 29,KRABBY
	db 27,ZUBAT
	db 30,KINGLER
	db 26,SEEL
	db 31,KRABBY
	db 30,SEEL
	db 28,DEWGONG
	db 32,DEWGONG

	db $05
	db 25,TENTACOOL
	db 30,TENTACOOL
	db 20,TENTACOOL
	db 30,STARYU
	db 35,TENTACOOL
	db 30,STARYU
	db 40,TENTACOOL
	db 30,STARYU
	db 30,STARYU
	db 30,STARYU

IslandMonsB4:
	db $0A
	db 36,GOLBAT
	db 36,ZUBAT
	db 30,KRABBY
	db 32,KINGLER
	db 28,SEEL
	db 32,SEEL
	db 27,GOLBAT
	db 45,ZUBAT
	db 30,DEWGONG
	db 34,DEWGONG

	db $05
	db 25,TENTACOOL
	db 30,TENTACOOL
	db 20,TENTACOOL
	db 30,STARYU
	db 35,TENTACOOL
	db 30,STARYU
	db 40,TENTACOOL
	db 30,STARYU
	db 30,STARYU
	db 30,STARYU

MansionMons1:
	db $0A
	db 34,RATTATA
	db 34,RATICATE
	db 23,GRIMER
	db 26,GROWLITHE
	db 37,RATTATA
	db 37,RATICATE
	db 30,GROWLITHE
	db 26,GRIMER
	db 34,GROWLITHE
	db 38,GROWLITHE

	db $00

MansionMons2:
	db $0A
	db 37,RATTATA
	db 37,RATICATE
	db 26,GRIMER
	db 29,GRIMER
	db 40,RATTATA
	db 40,RATICATE
	db 32,GRIMER
	db 35,GRIMER
	db 35,MUK
	db 38,MUK

	db $00

MansionMons3:
	db $0A
	db 40,RATTATA
	db 40,RATICATE
	db 32,GRIMER
	db 35,GRIMER
	db 43,RATTATA
	db 43,RATICATE
	db 38,GRIMER
	db 38,GRIMER
	db 38,MUK
	db 41,MUK

	db $00

MansionMonsB1:
	db $0A
	db 35,GRIMER
	db 38,GRIMER
	db 37,RATICATE
	db 40,RATICATE
	db 41,MUK
	db 43,RATICATE
	db 24,DITTO
	db 46,RATICATE
	db 18,DITTO
	db 12,DITTO

	db $00

Route21Mons:
	db $19
	db 15,PIDGEY
	db 13,RATTATA
	db 13,PIDGEY
	db 11,PIDGEY
	db 17,PIDGEY
	db 15,RATTATA
	db 15,RATICATE
	db 17,PIDGEOTTO
	db 19,PIDGEOTTO
	db 15,PIDGEOTTO

	db $05
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 5,TENTACOOL
	db 10,TENTACOOL
	db 15,TENTACOOL
	db 20,TENTACOOL
	db 30,TENTACOOL
	db 35,TENTACOOL
	db 40,TENTACOOL

DungeonMons1:
	db $0A
	db 50,GOLBAT
	db 55,GOLBAT
	db 45,GRAVELER
	db 55,GLOOM
	db 55,WEEPINBELL
	db 52,SANDSLASH
	db 54,VENOMOTH
	db 54,PARASECT
	db 55,DITTO
	db 60,DITTO

	db $00

DungeonMons2:
	db $0F
	db 52,GOLBAT
	db 57,GOLBAT
	db 50,GRAVELER
	db 56,SANDSLASH
	db 50,RHYHORN
	db 60,DITTO
	db 58,GLOOM
	db 58,WEEPINBELL
	db 60,RHYDON
	db 58,RHYDON

	db $00

DungeonMonsB1:
	db $19
	db 54,GOLBAT
	db 59,GOLBAT
	db 55,GRAVELER
	db 52,RHYHORN
	db 62,RHYDON
	db 60,DITTO
	db 56,CHANSEY
	db 65,DITTO
	db 55,LICKITUNG
	db 50,LICKITUNG

	db $00

PowerPlantMons:
	db $0A
	db 30,MAGNEMITE
	db 35,MAGNEMITE
	db 33,MAGNETON
	db 33,VOLTORB
	db 37,VOLTORB
	db 33,GRIMER
	db 37,GRIMER
	db 38,MAGNETON
	db 33,MUK
	db 37,MUK

	db $00

Route23Mons:
	db $0A
	db 41,NIDORINO
	db 41,NIDORINA
	db 36,MANKEY
	db 44,NIDORINO
	db 44,NIDORINA
	db 40,FEAROW
	db 41,MANKEY
	db 45,FEAROW
	db 41,PRIMEAPE
	db 46,PRIMEAPE

	db $00

PlateauMons2:
	db $0A
	db 31,GEODUDE
	db 36,GEODUDE
	db 41,GEODUDE
	db 44,ZUBAT
	db 39,GOLBAT
	db 44,GRAVELER
	db 45,ONIX
	db 47,ONIX
	db 39,MACHOKE
	db 42,MACHOKE

	db $00

PlateauMons3:
	db $0F
	db 36,GEODUDE
	db 44,GOLBAT
	db 41,GEODUDE
	db 49,ONIX
	db 46,GEODUDE
	db 41,GRAVELER
	db 42,MACHOKE
	db 45,MACHOKE
	db 47,GRAVELER
	db 47,GRAVELER

	db $00

PlateauMons1:
	db $0F
	db 26,GEODUDE
	db 31,GEODUDE
	db 36,GEODUDE
	db 39,ZUBAT
	db 44,ZUBAT
	db 41,GEODUDE
	db 43,ONIX
	db 45,ONIX
	db 41,GRAVELER
	db 47,GRAVELER

	db $00

CaveMons:
	db $14
	db 18,DIGLETT
	db 19,DIGLETT
	db 17,DIGLETT
	db 20,DIGLETT
	db 16,DIGLETT
	db 15,DIGLETT
	db 21,DIGLETT
	db 22,DIGLETT
	db 29,DUGTRIO
	db 31,DUGTRIO

	db $00

ENDC

GetItemUse:		;$D5C7
	ld a,1
	ld [$cd6a],a
	ld a,[$cf91]	;contains item_ID
	cp a,HM_01
	jp nc,ItemUseTMHM
	ld hl,ItemUsePtrTable
	dec a
	add a
	ld c,a
	ld b,0
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp [hl]

ItemUsePtrTable:	;$D5E1
	dw ItemUseBall		;$5687 masterball
	dw ItemUseBall		;$5687 ultraball
	dw ItemUseBall		;$5687 greatball
	dw ItemUseBall		;$5687 pokeball
	dw ItemUseTownMap	;$5968 TownMap
	dw $5977            ;ItemUseBicycle
	dw $59B4            ;ItemUseSurfBoard (UNUSED, glitchy!)
	dw ItemUseBall		;$5687 Safariball
	dw ItemUsePokedex   ;$DA56 pokedex
	dw $5A5B            ; MOON_STONE
	dw $5ABB            ; ANTIDOTE
	dw $5ABB            ; BURN_HEAL
	dw $5ABB            ; ICE_HEAL
	dw $5ABB            ; AWAKENING
	dw $5ABB            ; PARLYZ_HEAL
	dw $5ABB            ; FULL_RESTORE
	dw $5ABB            ; MAX_POTION
	dw $5ABB            ; HYPER_POTION
	dw $5ABB            ; SUPER_POTION
	dw $5ABB            ; POTION
	dw $5F52            ; BOULDERBADGE
	dw $5F67            ; CASCADEBADGE
	dw $6476            ; THUNDERBADGE
	dw $6476            ; RAINBOWBADGE
	dw $6476            ; SOULBADGE
	dw $6476            ; MARSHBADGE
	dw $6476            ; VOLCANOBADGE
	dw $6476            ; EARTHBADGE
	dw $5FAF            ; ESCAPE_ROPE
	dw $6003            ; REPEL
	dw $6476            ; OLD_AMBER
	dw $5A5B            ; FIRE_STONE
	dw $5A5B            ; THUNDER_STONE
	dw $5A5B            ; WATER_STONE
	dw $5AB4            ; HP_UP
	dw $5AB4            ; PROTEIN
	dw $5AB4            ; IRON
	dw $5AB4            ; CARBOS
	dw $5AB4            ; CALCIUM
	dw $5AB4            ; RARE_CANDY
	dw $6476            ; DOME_FOSSIL
	dw $6476            ; HELIX_FOSSIL
	dw $6476            ; SECRET_KEY
	dw $6476
	dw $6476            ; BIKE_VOUCHER
	dw $6013            ; X_ACCURACY
	dw $5A5B            ; LEAF_STONE
	dw $6022            ; CARD_KEY
	dw $6476            ; NUGGET
	dw $6476            ; ??? PP_UP
	dw $60CD            ; POKE_DOLL
	dw $5ABB            ; FULL_HEAL
	dw $5ABB            ; REVIVE
	dw $5ABB            ; MAX_REVIVE
	dw $60DC            ; GUARD_SPEC_
	dw $60EB            ; SUPER_REPL
	dw $60F0            ; MAX_REPEL
	dw $60F5            ; DIRE_HIT
	dw $6476            ; COIN
	dw $5ABB            ; FRESH_WATER
	dw $5ABB            ; SODA_POP
	dw $5ABB            ; LEMONADE
	dw $6476            ; S_S__TICKET
	dw $6476            ; GOLD_TEETH
	dw $6104            ; X_ATTACK
	dw $6104            ; X_DEFEND
	dw $6104            ; X_SPEED
	dw $6104            ; X_SPECIAL
	dw $623A            ; COIN_CASE
	dw $62DE            ; OAKS_PARCEL
	dw $62E1            ; ITEMFINDER
	dw $6476            ; SILPH_SCOPE
	dw $6140            ; POKE_FLUTE
	dw $6476            ; LIFT_KEY
	dw $6476            ; EXP__ALL
	dw $624C            ; OLD_ROD
	dw GoodRodCode ;$6259
	dw $6283            ; SUPER_ROD
	dw $6317            ; PP_UP (see other?)
	dw $631E            ; ETHER
	dw $631E            ; MAX_ETHER
	dw $631E            ; ELIXER
	dw $631E            ; MAX_ELIXER

ItemUseBall:	;03:5687
	ld a,[W_ISINBATTLE]
	and a
	jp z,ItemUseNotTime ; not in battle
	dec a
	jp nz,$658b ; in trainer battle
	ld a,[W_BATTLETYPE]
	dec a
	jr z,.UseBall\@
	ld a,[W_NUMINPARTY]	;is Party full?
	cp a,6
	jr nz,.UseBall\@
	ld a,[W_NUMINBOX]	;is Box full?
	cp a,20
	jp z,$65b1
.UseBall\@	;$56a7
;ok, you can use a ball
	xor a
	ld [$d11c],a
	ld a,[W_BATTLETYPE]
	cp a,2		;SafariBattle
	jr nz,.next2\@
	; remove a Safari Ball from inventory
	ld hl,W_NUMSAFARIBALLS
	dec [hl]
.next2\@	;$56b6
	call GoPAL_SET_CF1C
	ld a,$43
	ld [$d11e],a
	call $3725	;restore screenBuffer from Backup
	ld hl,ItemUseText00
	call PrintText
	ld hl,$583a
	ld b,$0f
	call Bankswitch
	ld b,$10
	jp z,$5801
	ld a,[W_BATTLETYPE]
	dec a
	jr nz,.next3\@
	ld hl,W_GRASSRATE	;backups wildMon data
	ld de,W_PLAYERNAME
	ld bc,11
	call CopyData
	jp .BallSuccess\@	;$578b
.next3\@	;$56e9
	ld a,[W_CURMAP]
	cp a,$93	;MonTower 6F
	jr nz,.next4\@
	ld a,[$cfd8]
	cp a,MAROWAK
	ld b,$10
	jp z,$5801
.next4\@	;$56fa
	call $3e5c	;GetRandom
	ld b,a
	ld hl,$cf91
	ld a,[hl]
	cp a,MASTER_BALL;1
	jp z,.BallSuccess\@	;$578b
	cp a,POKE_BALL	;4
	jr z,.next5\@
	ld a,200
        cp b
	jr c,.next4\@	;get only numbers < 200
	ld a,[hl]
	cp a,GREAT_BALL	;3
	jr z,.next5\@
	ld a,150	;get only numbers < 150
	cp b
	jr c,.next4\@
.next5\@	;$571a
	ld a,[$cfe9]	;status ailments
	and a
	jr z,.next6\@
	and a,(FRZ + SLP)	;is frozen and/or asleep?
	ld c,12
	jr z,.noAilments\@
	ld c,25
.noAilments\@	;$5728
	ld a,b
	sub c
	jp c,.BallSuccess\@	;$578b
	ld b,a
.next6\@	;$572e
	push bc		;save RANDOM number
	xor a
	ld [$ff96],a
	ld hl,$cff4	;enemy: Max HP
	ld a,[hli]
	ld [$ff97],a
	ld a,[hl]
	ld [$ff98],a
	ld a,255
	ld [$ff99],a
	call $38ac	;Multiply: MaxHP * 255
	ld a,[$cf91]
	cp a,GREAT_BALL
	ld a,12		;any other BallFactor
	jr nz,.next7\@
	ld a,8
.next7\@	;$574d
	ld [$ff99],a
	ld b,4		;GreatBall's BallFactor
	call $38b9	;Divide
	ld hl,$cfe6	;currentHP
	ld a,[hli]
	ld b,a
	ld a,[hl]
	srl b		;explanation:
	rr a		;we have a 16 bit value
	srl b		;equal to [b << 8 | a].
	rr a		;This number is divided
	and a		;by 4. The result is
	jr nz,.next8\@	;8 bit (reg. a). Always
	inc a		;bigger than zero.
.next8\@	;$5766
	ld [$ff99],a
	ld b,4
	call $38b9	;Divide
	ld a,[$ff97]
	and a
	jr z,.next9\@
	ld a,255
	ld [$ff98],a
.next9\@	;$5776
	pop bc
	ld a,[$d007]	;enemy: Catch Rate
	cp b
	jr c,.next10\@
        ld a,[$ff97]
        and a
        jr nz,.BallSuccess\@
	call $3e5c	;get random number
	ld b,a
	ld a,[$ff98]
	cp b
	jr c,.next10\@
.BallSuccess\@	;$578b
	jr .BallSuccess2\@
.next10\@	;$578d
	ld a,[$ff98]
	ld [$d11e],a
	xor a
	ld [$ff96],a
	ld [$ff97],a
	ld a,[$d007]	;enemy: Catch Rate
	ld [$ff98],a
	ld a,100
	ld [$ff99],a
	call $38ac	;Multiply: CatchRate * 100
	ld a,[$cf91]
	ld b,255
	cp a,POKE_BALL
	jr z,.next11\@
	ld b,200
	cp a,GREAT_BALL
	jr z,.next11\@
	ld b,150
	cp a,ULTRA_BALL
	jr z,.next11\@
.next11\@	;$57b8
	ld a,b
	ld [$ff99],a
	ld b,4
	call $38b9	;Divide
	ld a,[$ff97]
	and a
	ld b,$63
	jr nz,.next12\@
	ld a,[$d11e]
	ld [$ff99],a
	call $38ac
	ld a,255
	ld [$ff99],a
	ld b,4
	call $38b9
	ld a,[$cfe9]	;status ailments
	and a
	jr z,.next13\@
	and a,(FRZ + SLP)
	ld b,5
	jr z,.next14\@
	ld b,10
.next14\@	;$57e6
	ld a,[$ff98]
	add b
	ld [$ff98],a
.next13\@	;$57eb
	ld a,[$ff98]
	cp a,10
	ld b,$20
	jr c,.next12\@
	cp a,30
	ld b,$61
	jr c,.next12\@
	cp a,70
	ld b,$62
	jr c,.next12\@
	ld b,$63
.next12\@	;$5801
	ld a,b
	ld [$d11e],a
.BallSuccess2\@	;$5805
	ld c,20
	call DelayFrames
	ld a,$c1
	ld [$d07c],a
	xor a
	ld [$fff3],a
	ld [$cc5b],a
	ld [$d05b],a
	ld a,[$cf92]
	push af
	ld a,[$cf91]
	push af
	ld a,$08	;probably animations
	call Predef
	pop af
	ld [$cf91],a
	pop af
	ld [$cf92],a
	ld a,[$d11e]
	cp a,$10
	ld hl,ItemUseBallText00
	jp z,.printText0\@
	cp a,$20
	ld hl,ItemUseBallText01
	jp z,.printText0\@
	cp a,$61
	ld hl,ItemUseBallText02
	jp z,.printText0\@
	cp a,$62
	ld hl,ItemUseBallText03
	jp z,.printText0\@
	cp a,$63
	ld hl,ItemUseBallText04
	jp z,.printText0\@
	ld hl,$cfe6	;current HP
	ld a,[hli]
	push af
	ld a,[hli]
	push af		;backup currentHP...
	inc hl
	ld a,[hl]
	push af		;...and status ailments
	push hl
	ld hl,$d069
	bit 3,[hl]
	jr z,.next15\@
	ld a,$4c
	ld [$cfd8],a
	jr .next16\@
.next15\@	;$5871
	set 3,[hl]
	ld hl,$cceb
	ld a,[$cff1]
	ld [hli],a
	ld a,[$cff2]
	ld [hl],a
.next16\@	;$587e
	ld a,[$cf91]
	push af
	ld a,[$cfd8]
	ld [$cf91],a
	ld a,[$cff3]
	ld [$d127],a
	ld hl,$6b01
	ld b,$0f
	call Bankswitch
	pop af
	ld [$cf91],a
	pop hl
	pop af
	ld [hld],a
	dec hl
	pop af
	ld [hld],a
	pop af
	ld [hl],a
	ld a,[$cfe5]	;enemy
	ld [$d11c],a
	ld [$cf91],a
	ld [$d11e],a
	ld a,[W_BATTLETYPE]
	dec a
	jr z,.printText1\@
	ld hl,ItemUseBallText05
	call PrintText
	ld a,$3a	;convert order: Internal->Dex
	call Predef
	ld a,[$d11e]
	dec a
	ld c,a
	ld b,2
	ld hl,$d2f7	;Dex_own_flags (pokemon)
	ld a,$10
	call Predef	;check Dex flag (own already or not)
	ld a,c
	push af
	ld a,[$d11e]
	dec a
	ld c,a
	ld b,1
	ld a,$10	;set Dex_own_flag?
	call Predef
	pop af
	and a
	jr nz,.checkParty\@
	ld hl,ItemUseBallText06
	call PrintText
	call CleanLCD_OAM
	ld a,[$cfe5]	;caught mon_ID
	ld [$d11e],a
	ld a,$3d
	call Predef
.checkParty\@	;$58f4
	ld a,[W_NUMINPARTY]
	cp a,6		;is party full?
	jr z,.sendToBox\@
	xor a
	ld [$cc49],a
	call CleanLCD_OAM
	call AddPokemonToParty	;add mon to Party
	jr .End\@
.sendToBox\@	;$5907
	call CleanLCD_OAM
	call $67a4
	ld hl,ItemUseBallText07
	ld a,[$d7f1]
	bit 0,a		;already met Bill?
	jr nz,.sendToBox2\@
	ld hl,ItemUseBallText08
.sendToBox2\@	;$591a
	call PrintText
	jr .End\@
.printText1\@	;$591f
	ld hl,ItemUseBallText05
.printText0\@	;$5922
	call PrintText
	call CleanLCD_OAM
.End\@	;$5928
	ld a,[W_BATTLETYPE]
	and a
	ret nz
	ld hl,$d31d
	inc a
	ld [$cf96],a
	jp $2bbb	;remove ITEM (XXX)
ItemUseBallText00:
;"It dodged the thrown ball!"
;"This pokemon can't be caught"
	TX_FAR _ItemUseBallText00
	db "@"
ItemUseBallText01:
;"You missed the pokemon!"
	TX_FAR _ItemUseBallText01
	db "@"
ItemUseBallText02:
;"Darn! The pokemon broke free!"
	TX_FAR _ItemUseBallText02
	db "@"
ItemUseBallText03:
;"Aww! It appeared to be caught!"
	TX_FAR _ItemUseBallText03
	db "@"
ItemUseBallText04:
;"Shoot! It was so close too!"
	TX_FAR _ItemUseBallText04
	db "@"
ItemUseBallText05:
;"All right! {MonName} was caught!"
;play sound
	TX_FAR _ItemUseBallText05
	db $12,$06
	db "@"
ItemUseBallText07:
;"X was transferred to Bill's PC"
	TX_FAR _ItemUseBallText07
	db "@"
ItemUseBallText08:
;"X was transferred to someone's PC"
	TX_FAR _ItemUseBallText08
	db "@"

ItemUseBallText06:
;"New DEX data will be added..."
;play sound
	TX_FAR _ItemUseBallText06
	db $13,$06
	db "@"

ItemUseTownMap:	;03:5968
	ld a,[W_ISINBATTLE]	;in-battle or outside
	and a
	jp nz,ItemUseNotTime	;OAK: "this isn't the time..."

INCBIN "baserom.gbc",$d96f,$da4c - $d96f

UnnamedText_da4c: ; 0xda4c
    TX_FAR _UnnamedText_da4c
    db $50
; 0xda4c + 5 bytes

UnnamedText_da51: ; 0xda51
    TX_FAR _UnnamedText_da51
    db $50
; 0xda51 + 5 bytes

ItemUsePokedex: ; 0xda56 5A56
    ld a, $29
    jp $3e6d
; 0xda5b

INCBIN "baserom.gbc",$da5b,$df24 - $da5b

UnnamedText_df24: ; 0xdf24
    TX_FAR _UnnamedText_df24
    db $50
; 0xdf24 + 5 bytes

UnnamedText_df29: ; 0xdf29
    TX_FAR _UnnamedText_df29
    db $50
; 0xdf29 + 5 bytes

INCBIN "baserom.gbc",$df2e,$dfa5 - $df2e

UnnamedText_dfa5: ; 0xdfa5
    TX_FAR _UnnamedText_dfa5
    db $50
; 0xdfa5 + 5 bytes

UnnamedText_dfaa: ; 0xdfaa
    TX_FAR _UnnamedText_dfaa
    db $50
; 0xdfaa + 5 bytes

INCBIN "baserom.gbc",$dfaf,$e20b - $dfaf

UnnamedText_e20b: ; 0xe20b
    TX_FAR _UnnamedText_e20b
    db $50
; 0xe20b + 5 bytes

UnnamedText_e210: ; 0xe210
    TX_FAR _UnnamedText_e210
    db $50
; 0xe210 + 5 bytes

INCBIN "baserom.gbc",$e215,$e247 - $e215

UnnamedText_e247: ; 0xe247
    TX_FAR _UnnamedText_e247
    db $50
; 0xe247 + 5 bytes

INCBIN "baserom.gbc",$e24c,$d

GoodRodCode: ; 6259 0xe259
	call $62B4
	jp c,ItemUseNotTime
Next625F:
	call GenRandom
	srl a
	jr c,Next6278
	and 3
	cp 2
	jr nc,Next625F
	; choose which monster appears
	ld hl,GoodRodMons
	add a,a
	ld c,a
	ld b,0
	add hl,bc
	ld b,[hl]
	inc hl
	ld c,[hl]
	and a
Next6278:
	ld a,0
	rla
	xor 1
	jr Next628E

GoodRodMons:
	db 10,GOLDEEN
	db 10,POLIWAG

Next6283:
	call $62B4
	jp c,ItemUseNotTime
Next6289:
	call $68EA
	ld a,e
Next628E:
	ld [$CD3D],a
	dec a
	jr nz,.next\@
	ld a,1
	ld [$D05F],a
	ld a,b
	ld [$D127],a
	ld a,c
	ld [$D059],a
.next\@
	ld hl,$D700
	ld a,[hl]
	push af
	push hl
	ld [hl],0
	ld b,$1C
	ld hl,$47B6
	call Bankswitch
	pop hl
	pop af
	ld [hl],a
	ret

INCBIN "baserom.gbc",$e2b4,$e30d - $e2b4

UnnamedText_e30d: ; 0xe30d
    TX_FAR _UnnamedText_e30d
    db $50
; 0xe30d + 5 bytes

UnnamedText_e312: ; 0xe312
    TX_FAR _UnnamedText_e312
    db $50
; 0xe312 + 5 bytes

INCBIN "baserom.gbc",$e317,$e45d - $e317

UnnamedText_e45d: ; 0xe45d
    TX_FAR _UnnamedText_e45d
    db $50
; 0xe45d + 5 bytes

UnnamedText_e462: ; 0xe462
    TX_FAR _UnnamedText_e462
    db $50
; 0xe462 + 5 bytes

UnnamedText_e467: ; 0xe467
    TX_FAR _UnnamedText_e467
    db $50
; 0xe467 + 5 bytes

UnnamedText_e46c: ; 0xe46c
    TX_FAR _UnnamedText_e46c
    db $50
; 0xe46c + 5 bytes

UnnamedText_e471: ; 0xe471
    TX_FAR _UnnamedText_e471
    db $50
; 0xe471 + 5 bytes

INCBIN "baserom.gbc",$e476,$3

ItemUseTMHM:	;03:6479
    	INCBIN "baserom.gbc",$E479,$E581 - $E479
ItemUseNotTime:	;03:6581
    	INCBIN "baserom.gbc",$E581,$E5E8 - $E581
;ItemUseTexts:	;03:65e8
ItemUseText00:	;03:65e8
	TX_FAR _ItemUseText001
        db $05
	TX_FAR _ItemUseText002
	db "@"

INCBIN "baserom.gbc",$e5f2,$e5f7 - $e5f2

UnnamedText_e5f7: ; 0xe5f7
    TX_FAR _UnnamedText_e5f7
    db $50
; 0xe5f7 + 5 bytes

INCBIN "baserom.gbc",$e5fc,$e601 - $e5fc

UnnamedText_e601: ; 0xe601
    TX_FAR _UnnamedText_e601
    db $50
; 0xe601 + 5 bytes

INCBIN "baserom.gbc",$e606,$e755 - $e606

UnnamedText_e755: ; 0xe755
    TX_FAR _UnnamedText_e755
    db $50
; 0xe755 + 5 bytes

UnnamedText_e75a: ; 0xe75a
    TX_FAR _UnnamedText_e75a
    db $50
; 0xe75a + 5 bytes

UnnamedText_e75f: ; 0xe75f
    TX_FAR _UnnamedText_e75f
    db $50
; 0xe75f + 5 bytes

INCBIN "baserom.gbc",$e764,$1b5

; super rod data
; map, pointer to fishing group
SuperRodData: ; 6919
	dbw $00,FishingGroup1
	dbw $01,FishingGroup1
	dbw $03,FishingGroup3
	dbw $05,FishingGroup4
	dbw $06,FishingGroup5
	dbw $07,FishingGroup10
	dbw $08,FishingGroup8
	dbw $0F,FishingGroup3
	dbw $11,FishingGroup4
	dbw $15,FishingGroup5
	dbw $16,FishingGroup4
	dbw $17,FishingGroup7
	dbw $18,FishingGroup7
	dbw $1C,FishingGroup7
	dbw $1D,FishingGroup7
	dbw $1E,FishingGroup8
	dbw $1F,FishingGroup8
	dbw $20,FishingGroup8
	dbw $21,FishingGroup2
	dbw $22,FishingGroup9
	dbw $23,FishingGroup3
	dbw $24,FishingGroup3
	dbw $41,FishingGroup3
	dbw $5E,FishingGroup4
	dbw $A1,FishingGroup8
	dbw $A2,FishingGroup8
	dbw $D9,FishingGroup6
	dbw $DA,FishingGroup6
	dbw $DB,FishingGroup6
	dbw $DC,FishingGroup6
	dbw $E2,FishingGroup9
	dbw $E3,FishingGroup9
	dbw $E4,FishingGroup9
	db $FF

; fishing groups
; number of monsters, followed by level/monster pairs
FishingGroup1:
	db 2
	db 15,TENTACOOL
	db 15,POLIWAG

FishingGroup2:
	db 2
	db 15,GOLDEEN
	db 15,POLIWAG

FishingGroup3:
	db 3
	db 15,PSYDUCK
	db 15,GOLDEEN
	db 15,KRABBY

FishingGroup4:
	db 2
	db 15,KRABBY
	db 15,SHELLDER

FishingGroup5:
	db 2
	db 23,POLIWHIRL
	db 15,SLOWPOKE

FishingGroup6:
	db 4
	db 15,DRATINI
	db 15,KRABBY
	db 15,PSYDUCK
	db 15,SLOWPOKE

FishingGroup7:
	db 4
	db 5,TENTACOOL
	db 15,KRABBY
	db 15,GOLDEEN
	db 15,MAGIKARP

FishingGroup8:
	db 4
	db 15,STARYU
	db 15,HORSEA
	db 15,SHELLDER
	db 15,GOLDEEN

FishingGroup9:
	db 4
	db 23,SLOWBRO
	db 23,SEAKING
	db 23,KINGLER
	db 23,SEADRA

FishingGroup10:
	db 4
	db 23,SEAKING
	db 15,KRABBY
	db 15,GOLDEEN
	db 15,MAGIKARP

INCBIN "baserom.gbc",$E9C5,$ef7d - $E9C5

_UnnamedText_ef7d: ; 0xef7d
    db $17, $f8, $42, $2a
    db $50
; 0xef7d + 5 bytes

INCBIN "baserom.gbc",$ef82,$fbd9 - $ef82

UnnamedText_fbd9: ; 0xfbd9
    TX_FAR _UnnamedText_fbd9
    db $50
; 0xfbd9 + 5 bytes

UnnamedText_fbde: ; 0xfbde
    TX_FAR _UnnamedText_fbde
    db $50
; 0xfbde + 5 bytes

UnnamedText_fbe3: ; 0xfbe3
    TX_FAR _UnnamedText_fbe3
    db $50
; 0xfbe3 + 5 bytes

INCBIN "baserom.gbc",$fbe8,$fc03 - $fbe8

UnnamedText_fc03: ; 0xfc03
    TX_FAR _UnnamedText_fc03
    db $50
; 0xfc03 + 5 bytes

UnnamedText_fc08: ; 0xfc08
    TX_FAR _UnnamedText_fc08
    db $50
; 0xfc08 + 5 bytes

UnnamedText_fc0d: ; 0xfc0d
    TX_FAR _UnnamedText_fc0d
    db $50
; 0xfc0d + 5 bytes

INCBIN "baserom.gbc",$fc12,$fc45 - $fc12

UnnamedText_fc45: ; 0xfc45
    TX_FAR _UnnamedText_fc45
    db $50
; 0xfc45 + 5 bytes

INCBIN "baserom.gbc",$fc4a,$3b6

SECTION "bank4",DATA,BANK[$4]

INCBIN "baserom.gbc",$10000,$12e7f - $10000

UnnamedText_12e7f: ; 0x12e7f
    TX_FAR _UnnamedText_12e7f
    db $50
; 0x12e7f + 5 bytes

UnnamedText_12e84: ; 0x12e84
    TX_FAR _UnnamedText_12e84
    db $50
; 0x12e84 + 5 bytes

UnnamedText_12e89: ; 0x12e89
    TX_FAR _UnnamedText_12e89
    db $50
; 0x12e89 + 5 bytes

UnnamedText_12e8e: ; 0x12e8e
    TX_FAR _UnnamedText_12e8e
    db $50
; 0x12e8e + 5 bytes

UnnamedText_12e93: ; 0x12e93
    TX_FAR _UnnamedText_12e93
    db $50
; 0x12e93 + 5 bytes

UnnamedText_12e98: ; 0x12e98
    TX_FAR _UnnamedText_12e98
    db $50
; 0x12e98 + 5 bytes

UnnamedText_12e9d: ; 0x12e9d
    TX_FAR _UnnamedText_12e9d
    db $50
; 0x12e9d + 5 bytes

UnnamedText_12ea2: ; 0x12ea2
    TX_FAR _UnnamedText_12ea2
    db $50
; 0x12ea2 + 5 bytes

UnnamedText_12ea7: ; 0x12ea7
    TX_FAR _UnnamedText_12ea7
    db $50
; 0x12ea7 + 5 bytes

UnnamedText_12eac: ; 0x12eac
    TX_FAR _UnnamedText_12eac
    db $50
; 0x12eac + 5 bytes

UnnamedText_12eb1: ; 0x12eb1
    TX_FAR _UnnamedText_12eb1
    db $50
; 0x12eb1 + 5 bytes

UnnamedText_12eb6: ; 0x12eb6
    TX_FAR _UnnamedText_12eb6
    db $50
; 0x12eb6 + 5 bytes

UnnamedText_12ebb: ; 0x12ebb
    TX_FAR _UnnamedText_12ebb
    db $50
; 0x12ebb + 5 bytes

INCBIN "baserom.gbc",$12ec0,$1e

RedPicFront:
	INCBIN "pic/trainer/red.pic"
ShrinkPic1:
	INCBIN "pic/trainer/shrink1.pic"
ShrinkPic2:
	INCBIN "pic/trainer/shrink2.pic"

INCBIN "baserom.gbc",$13074,$13228 - $13074

UnnamedText_13228: ; 0x13228
    TX_FAR _UnnamedText_13228
    db $50
; 0x13228 + 5 bytes

INCBIN "baserom.gbc",$1322d,$1327b - $1322d

UnnamedText_1327b: ; 0x1327b
    TX_FAR _UnnamedText_1327b
    db $50
; 0x1327b + 5 bytes

UnnamedText_13280: ; 0x13280
    TX_FAR _UnnamedText_13280
    db $50
; 0x13280 + 5 bytes

UnnamedText_13285: ; 0x13285
    TX_FAR _UnnamedText_13285
    db $50
; 0x13285 + 5 bytes

INCBIN "baserom.gbc",$1328a,$132d4 - $1328a

UnnamedText_132d4: ; 0x132d4
    TX_FAR _UnnamedText_132d4
    db $50
; 0x132d4 + 5 bytes

INCBIN "baserom.gbc",$132d9,$132e8 - $132d9

UnnamedText_132e8: ; 0x132e8
    TX_FAR _UnnamedText_132e8
    db $50
; 0x132e8 + 5 bytes

INCBIN "baserom.gbc",$132ed,$1342a - $132ed

UnnamedText_1342a: ; 0x1342a
    TX_FAR _UnnamedText_1342a
    db $50
; 0x1342a + 5 bytes

UnnamedText_1342f: ; 0x1342f
    TX_FAR _UnnamedText_1342f
    db $50
; 0x1342f + 5 bytes

INCBIN "baserom.gbc",$13434,$1386b - $13434

UnnamedText_1386b: ; 0x1386b
    TX_FAR _UnnamedText_1386b
    db $50
; 0x1386b + 5 bytes

INCBIN "baserom.gbc",$13870,$1399e - $13870

UnnamedText_1399e: ; 0x1399e
    TX_FAR _UnnamedText_1399e
    db $50
; 0x1399e + 5 bytes

INCBIN "baserom.gbc",$139a3,$139cd - $139a3

UnnamedText_139cd: ; 0x139cd
    TX_FAR _UnnamedText_139cd
    db $50
; 0x139cd + 5 bytes

INCBIN "baserom.gbc",$139d2,$13a53 - $139d2

UnnamedText_13a53: ; 0x13a53
    TX_FAR _UnnamedText_13a53
    db $50
; 0x13a53 + 5 bytes

INCBIN "baserom.gbc",$13a58,$37

GenRandom_: ; 7A8F
; generate a random 16-bit integer and store it at $FFD3,$FFD4
	ld a,[rDIV]
	ld b,a
	ld a,[H_RAND1]
	adc b
	ld [H_RAND1],a
	ld a,[rDIV]
	ld b,a
	ld a,[H_RAND2]
	sbc b
	ld [H_RAND2],a
	ret

SECTION "bank5",DATA,BANK[$5]

INCBIN "baserom.gbc",$14000,$17e1d - $14000

UnnamedText_17e1d: ; 0x17e1d
    TX_FAR _UnnamedText_17e1d
    db $50
; 0x17e1d + 5 bytes

UnnamedText_17e22: ; 0x17e22
    TX_FAR _UnnamedText_17e22
    db $50
; 0x17e22 + 5 bytes

UnnamedText_17e27: ; 0x17e27
    TX_FAR _UnnamedText_17e27
    db $50
; 0x17e27 + 5 bytes

INCBIN "baserom.gbc",$17e2c,$17f23 - $17e2c

UnnamedText_17f23: ; 0x17f23
    TX_FAR _UnnamedText_17f23
    db $50
; 0x17f23 + 5 bytes

UnnamedText_17f28: ; 0x17f28
    TX_FAR _UnnamedText_17f28
    db $50
; 0x17f28 + 5 bytes

UnnamedText_17f2d: ; 0x17f2d
    TX_FAR _UnnamedText_17f2d
    db $50
; 0x17f2d + 5 bytes

UnnamedText_17f32: ; 0x17f32
    TX_FAR _UnnamedText_17f32
    db $50
; 0x17f32 + 5 bytes

INCBIN "baserom.gbc",$17f37,$c9

SECTION "bank6",DATA,BANK[$6]

CeladonCity_h: ; 0x18000
    db $00 ; tileset
    db CELADON_CITY_HEIGHT, CELADON_CITY_WIDTH ; dimensions (y, x)
    dw CeladonCityBlocks, CeladonCityTexts, CeladonCityScript ; blocks, texts, scripts
    db WEST | EAST ; connections

    ; connections data

	db ROUTE_16
    dw $4B95, $C7C1 ; pointers (connected, current) (strip)
    db $09, $14 ; bigness, width
    db $F8, $27 ; alignments (y, x)
    dw $C716 ; window

	db ROUTE_7
    dw $4051, $C7DD ; pointers (connected, current) (strip)
    db $09, $0A ; bigness, width
    db $F8, $00 ; alignments (y, x)
    dw $C6F9 ; window

    ; end connections data

    dw CeladonCityObject ; objects

CeladonCityObject: ; 0x18022 (size=189)
    db $f ; border tile

    db $d ; warps
    db $d, $8, $0, CELADON_MART_1
    db $d, $a, $2, CELADON_MART_1
    db $9, $18, $0, CELADON_MANSION_1
    db $3, $18, $2, CELADON_MANSION_1
    db $3, $19, $2, CELADON_MANSION_1
    db $9, $29, $0, CELADON_POKECENTER
    db $1b, $c, $0, CELADON_GYM
    db $13, $1c, $0, GAME_CORNER
    db $13, $27, $0, CELADON_MART_5
    db $13, $21, $0, CELADONPRIZE_ROOM
    db $1b, $1f, $0, CELADON_DINER
    db $1b, $23, $0, CELADON_HOUSE
    db $1b, $2b, $0, CELADON_HOTEL

    db $9 ; signs
    db $f, $1b, $a ; CeladonCityText10
    db $f, $13, $b ; CeladonCityText11
    db $9, $2a, $c ; CeladonCityText12
    db $1d, $d, $d ; CeladonCityText13
    db $9, $15, $e ; CeladonCityText14
    db $d, $c, $f ; CeladonCityText15
    db $15, $27, $10 ; CeladonCityText16
    db $15, $21, $11 ; CeladonCityText17
    db $15, $1b, $12 ; CeladonCityText18

    db $9 ; people
    db SPRITE_LITTLE_GIRL, $11 + 4, $8 + 4, $fe, $0, $1 ; person
    db SPRITE_OLD_PERSON, $1c + 4, $b + 4, $ff, $d1, $2 ; person
    db SPRITE_GIRL, $13 + 4, $e + 4, $fe, $1, $3 ; person
    db SPRITE_OLD_PERSON, $16 + 4, $19 + 4, $ff, $d0, $4 ; person
    db SPRITE_OLD_PERSON, $10 + 4, $16 + 4, $ff, $d0, $5 ; person
    db SPRITE_FISHER2, $c + 4, $20 + 4, $ff, $d2, $6 ; person
    db SPRITE_SLOWBRO, $c + 4, $1e + 4, $ff, $d3, $7 ; person
    db SPRITE_ROCKET, $1d + 4, $20 + 4, $fe, $2, $8 ; person
    db SPRITE_ROCKET, $e + 4, $2a + 4, $fe, $2, $9 ; person

    ; warp-to
    EVENT_DISP $19, $d, $8 ; CELADON_MART_1
    EVENT_DISP $19, $d, $a ; CELADON_MART_1
    EVENT_DISP $19, $9, $18 ; CELADON_MANSION_1
    EVENT_DISP $19, $3, $18 ; CELADON_MANSION_1
    EVENT_DISP $19, $3, $19 ; CELADON_MANSION_1
    EVENT_DISP $19, $9, $29 ; CELADON_POKECENTER
    EVENT_DISP $19, $1b, $c ; CELADON_GYM
    EVENT_DISP $19, $13, $1c ; GAME_CORNER
    EVENT_DISP $19, $13, $27 ; CELADON_MART_5
    EVENT_DISP $19, $13, $21 ; CELADONPRIZE_ROOM
    EVENT_DISP $19, $1b, $1f ; CELADON_DINER
    EVENT_DISP $19, $1b, $23 ; CELADON_HOUSE
    EVENT_DISP $19, $1b, $2b ; CELADON_HOTEL

CeladonCityBlocks: ; 450
    INCBIN "maps/celadoncity.blk"

PalletTown_h:
	db $00 ; tileset
	db PALLET_TOWN_HEIGHT, PALLET_TOWN_WIDTH ; dimensions
	dw PalletTownBlocks, PalletTownTexts, PalletTownScript
	db NORTH | SOUTH ; connections

	db ROUTE_1
	dw Route1Blocks + ((ROUTE_1_WIDTH * 15) + 0) ;y, x Strip Starting Point
	dw $C6EB + 0 ;Strip X-Offset to current map
	db ROUTE_1_WIDTH ;"Bigness" (Unsure) ;Something to do with MapData
	db ROUTE_1_WIDTH ;"Map Width" (Unsure) ;Something to do with TileSet
	db (ROUTE_1_HEIGHT * 2) - 1 ;Player's new Y-Coordinates
	db (0 * -2) ;Player's new X-Coordinates
	dw $C6E9 + ROUTE_1_HEIGHT * (ROUTE_1_WIDTH + 6) ;New UL Block Pos (Window)

	db ROUTE_21
	dw Route21Blocks,$C7AB ; pointers
	db $0A,$0A ; bigness, width
	db $00,$00 ; alignments
	dw $C6F9 ; window

	dw PalletTownObject

PalletTownObject: ; 0x182c3 (size=58)
    db $b ; border tile

    db $3 ; warps
    db $5, $5, $0, REDS_HOUSE_1F
    db $5, $d, $0, BLUES_HOUSE
    db $b, $c, $1, OAKS_LAB

    db $4 ; signs
    db $d, $d, $4 ; PalletTownText4
    db $9, $7, $5 ; PalletTownText5
    db $5, $3, $6 ; PalletTownText6
    db $5, $b, $7 ; PalletTownText7

    db $3 ; people
    db SPRITE_OAK, $5 + 4, $8 + 4, $ff, $ff, $1 ; person
    db SPRITE_GIRL, $8 + 4, $3 + 4, $fe, $0, $2 ; person
    db SPRITE_FISHER2, $e + 4, $b + 4, $fe, $0, $3 ; person

    ; warp-to
    EVENT_DISP $a, $5, $5 ; REDS_HOUSE_1F
    EVENT_DISP $a, $5, $d ; BLUES_HOUSE
    EVENT_DISP $a, $b, $c ; OAKS_LAB

PalletTownBlocks: ; 0x182fd
	INCBIN "maps/pallettown.blk"

ViridianCity_h: ; 0x18357 to 0x18384 (45 bytes) (bank=6) (id=1)
    db $00 ; tileset
    db VIRIDIAN_CITY_HEIGHT, VIRIDIAN_CITY_WIDTH ; dimensions (y, x)
    dw ViridianCityBlocks, ViridianCityTexts, ViridianCityScript ; blocks, texts, scripts
    db NORTH | SOUTH | WEST ; connections

    ; connections data

	db ROUTE_2
    dw Route2Blocks + (ROUTE_2_HEIGHT - 3) * ROUTE_2_WIDTH ; connection strip location
    dw $C6EB + 5 ; current map position
    db ROUTE_2_WIDTH, ROUTE_2_WIDTH ; bigness, width
    db (ROUTE_2_HEIGHT * 2) - 1, (5 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_2_HEIGHT * (ROUTE_2_WIDTH + 6) ; window

	db ROUTE_1
    dw Route1Blocks ; connection strip location
    dw $C6EB + (VIRIDIAN_CITY_HEIGHT + 3) * (VIRIDIAN_CITY_WIDTH + 6) + 5 ; current map position
    db ROUTE_1_WIDTH, ROUTE_1_WIDTH ; bigness, width
    db 0, (5 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_1_WIDTH ; window

	db ROUTE_22
    dw Route22Blocks - 3 + (ROUTE_22_WIDTH) ; connection strip location
    dw $C6E8 + (VIRIDIAN_CITY_WIDTH + 6) * (4 + 3) ; current map position
    db ROUTE_22_HEIGHT, ROUTE_22_WIDTH ; bigness, width
    db (4 * -2), (ROUTE_22_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_22_WIDTH ; window

    ; end connections data

    dw ViridianCityObject ; objects

ViridianCityObject: ; 0x18384 (size=104)
    db $f ; border tile

    db $5 ; warps
    db $19, $17, $0, VIRIDIAN_POKECENTER
    db $13, $1d, $0, VIRIDIAN_MART
    db $f, $15, $0, VIRIDIAN_SCHOOL
    db $9, $15, $0, VIRIDIAN_HOUSE
    db $7, $20, $0, VIRIDIAN_GYM

    db $6 ; signs
    db $11, $11, $8 ; ViridianCityText8
    db $1, $13, $9 ; ViridianCityText9
    db $1d, $15, $a ; ViridianCityText10
    db $13, $1e, $b ; ViridianCityText11
    db $19, $18, $c ; ViridianCityText12
    db $7, $1b, $d ; ViridianCityText13

    db $7 ; people
    db SPRITE_BUG_CATCHER, $14 + 4, $d + 4, $fe, $0, $1 ; person
    db SPRITE_GAMBLER, $8 + 4, $1e + 4, $ff, $ff, $2 ; person
    db SPRITE_BUG_CATCHER, $19 + 4, $1e + 4, $fe, $0, $3 ; person
    db SPRITE_GIRL, $9 + 4, $11 + 4, $ff, $d3, $4 ; person
    db SPRITE_LYING_OLD_MAN, $9 + 4, $12 + 4, $ff, $ff, $5 ; person
    db SPRITE_FISHER2, $17 + 4, $6 + 4, $ff, $d0, $6 ; person
    db SPRITE_GAMBLER, $5 + 4, $11 + 4, $fe, $2, $7 ; person

    ; warp-to
    EVENT_DISP $14, $19, $17 ; VIRIDIAN_POKECENTER
    EVENT_DISP $14, $13, $1d ; VIRIDIAN_MART
    EVENT_DISP $14, $f, $15 ; VIRIDIAN_SCHOOL
    EVENT_DISP $14, $9, $15 ; VIRIDIAN_HOUSE
    EVENT_DISP $14, $7, $20 ; VIRIDIAN_GYM

ViridianCityBlocks: ; 360
    INCBIN "maps/viridiancity.blk"

PewterCity_h: ; 0x18554 to 0x18576 (34 bytes) (bank=6) (id=2)
    db $00 ; tileset
    db PEWTER_CITY_HEIGHT, PEWTER_CITY_WIDTH ; dimensions (y, x)
    dw PewterCityBlocks, PewterCityTexts, PewterCityScript ; blocks, texts, scripts
    db SOUTH | EAST ; connections

    ; connections data

	db ROUTE_2
    dw Route2Blocks ; connection strip location
    dw $C6EB + (PEWTER_CITY_HEIGHT + 3) * (PEWTER_CITY_WIDTH + 6) + 5 ; current map position
    db ROUTE_2_WIDTH, ROUTE_2_WIDTH ; bigness, width
    db 0, (5 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_2_WIDTH ; window

	db ROUTE_3
    dw Route3Blocks + (ROUTE_3_WIDTH * 0) ; connection strip location
    dw $C6E5 + (PEWTER_CITY_WIDTH + 6) * (4 + 4) ; current map position
    db ROUTE_3_HEIGHT, ROUTE_3_WIDTH ; bigness, width
    db (4 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_3_WIDTH ; window

    ; end connections data

    dw PewterCityObject ; objects

INCBIN "baserom.gbc",$18576,$18577 - $18576

PewterCityObject: ; 0x18577 (size=111)
    db $a ; border tile

    db $7 ; warps
    db $7, $e, $0, MUSEUM_1F
    db $5, $13, $2, MUSEUM_1F
    db $11, $10, $0, PEWTER_GYM
    db $d, $1d, $0, PEWTER_HOUSE_1
    db $11, $17, $0, PEWTER_MART
    db $1d, $7, $0, PEWTER_HOUSE_2
    db $19, $d, $0, PEWTER_POKECENTER

    db $7 ; signs
    db $1d, $13, $6 ; PewterCityText6
    db $13, $21, $7 ; PewterCityText7
    db $11, $18, $8 ; PewterCityText8
    db $19, $e, $9 ; PewterCityText9
    db $9, $f, $a ; PewterCityText10
    db $11, $b, $b ; PewterCityText11
    db $17, $19, $c ; PewterCityText12

    db $5 ; people
    db SPRITE_LASS, $f + 4, $8 + 4, $ff, $ff, $1 ; person
    db SPRITE_BLACK_HAIR_BOY_1, $19 + 4, $11 + 4, $ff, $ff, $2 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $11 + 4, $1b + 4, $ff, $ff, $3 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $19 + 4, $1a + 4, $fe, $2, $4 ; person
    db SPRITE_BUG_CATCHER, $10 + 4, $23 + 4, $ff, $d0, $5 ; person

    ; warp-to
    EVENT_DISP $14, $7, $e ; MUSEUM_1F
    EVENT_DISP $14, $5, $13 ; MUSEUM_1F
    EVENT_DISP $14, $11, $10 ; PEWTER_GYM
    EVENT_DISP $14, $d, $1d ; PEWTER_HOUSE_1
    EVENT_DISP $14, $11, $17 ; PEWTER_MART
    EVENT_DISP $14, $1d, $7 ; PEWTER_HOUSE_2
    EVENT_DISP $14, $19, $d ; PEWTER_POKECENTER

PewterCityBlocks: ; 360
    INCBIN "maps/pewtercity.blk"

CeruleanCity_h: ; 0x1874e to 0x18786 (56 bytes) (bank=6) (id=3)
    db $00 ; tileset
    db CERULEAN_CITY_HEIGHT, CERULEAN_CITY_WIDTH ; dimensions (y, x)
    dw CeruleanCityBlocks, CeruleanCityTexts, CeruleanCityScript ; blocks, texts, scripts
    db NORTH | SOUTH | WEST | EAST ; connections

    ; connections data

	db ROUTE_24
    dw Route24Blocks + (ROUTE_24_HEIGHT - 3) * ROUTE_24_WIDTH ; connection strip location
    dw $C6EB + 5 ; current map position
    db ROUTE_24_WIDTH, ROUTE_24_WIDTH ; bigness, width
    db (ROUTE_24_HEIGHT * 2) - 1, (5 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_24_HEIGHT * (ROUTE_24_WIDTH + 6) ; window

	db ROUTE_5
    dw Route5Blocks ; connection strip location
    dw $C6EB + (CERULEAN_CITY_HEIGHT + 3) * (CERULEAN_CITY_WIDTH + 6) + 5 ; current map position
    db ROUTE_5_WIDTH, ROUTE_5_WIDTH ; bigness, width
    db 0, (5 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_5_WIDTH ; window

	db ROUTE_4
    dw Route4Blocks - 3 + (ROUTE_4_WIDTH) ; connection strip location
    dw $C6E8 + (CERULEAN_CITY_WIDTH + 6) * (4 + 3) ; current map position
    db ROUTE_4_HEIGHT, ROUTE_4_WIDTH ; bigness, width
    db (4 * -2), (ROUTE_4_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_4_WIDTH ; window

	db ROUTE_9
    dw Route9Blocks + (ROUTE_9_WIDTH * 0) ; connection strip location
    dw $C6E5 + (CERULEAN_CITY_WIDTH + 6) * (4 + 4) ; current map position
    db ROUTE_9_HEIGHT, ROUTE_9_WIDTH ; bigness, width
    db (4 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_9_WIDTH ; window

    ; end connections data

    dw CeruleanCityObject ; objects

CeruleanCityObject: ; 0x18786 (size=170)
    db $f ; border tile

    db $a ; warps
    db $b, $1b, $0, TRASHED_HOUSE
    db $f, $d, $0, CERULEAN_HOUSE
    db $11, $13, $0, CERULEAN_POKECENTER
    db $13, $1e, $0, CERULEAN_GYM
    db $19, $d, $0, BIKE_SHOP
    db $19, $19, $0, CERULEAN_MART
    db $b, $4, $0, UNKNOWN_DUNGEON_1
    db $9, $1b, $2, TRASHED_HOUSE
    db $b, $9, $1, CERULEAN_HOUSE_3
    db $9, $9, $0, CERULEAN_HOUSE_3

    db $6 ; signs
    db $13, $17, $c ; CeruleanCityText12
    db $1d, $11, $d ; CeruleanCityText13
    db $19, $1a, $e ; CeruleanCityText14
    db $11, $14, $f ; CeruleanCityText15
    db $19, $b, $10 ; CeruleanCityText16
    db $15, $1b, $11 ; CeruleanCityText17

    db $b ; people
    db SPRITE_BLUE, $2 + 4, $14 + 4, $ff, $d0, $1 ; person
    db SPRITE_ROCKET, $8 + 4, $1e + 4, $ff, $ff, $42, ROCKET + $C8, $5 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $14 + 4, $1f + 4, $ff, $d0, $3 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $12 + 4, $f + 4, $fe, $1, $4 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $15 + 4, $9 + 4, $fe, $2, $5 ; person
    db SPRITE_GUARD, $c + 4, $1c + 4, $ff, $d0, $6 ; person
    db SPRITE_LASS, $1a + 4, $1d + 4, $ff, $d2, $7 ; person
    db SPRITE_SLOWBRO, $1a + 4, $1c + 4, $ff, $d0, $8 ; person
    db SPRITE_LASS, $1b + 4, $9 + 4, $fe, $2, $9 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $c + 4, $4 + 4, $ff, $d0, $a ; person
    db SPRITE_GUARD, $c + 4, $1b + 4, $ff, $d0, $b ; person

    ; warp-to
    EVENT_DISP $14, $b, $1b ; TRASHED_HOUSE
    EVENT_DISP $14, $f, $d ; CERULEAN_HOUSE
    EVENT_DISP $14, $11, $13 ; CERULEAN_POKECENTER
    EVENT_DISP $14, $13, $1e ; CERULEAN_GYM
    EVENT_DISP $14, $19, $d ; BIKE_SHOP
    EVENT_DISP $14, $19, $19 ; CERULEAN_MART
    EVENT_DISP $14, $b, $4 ; UNKNOWN_DUNGEON_1
    EVENT_DISP $14, $9, $1b ; TRASHED_HOUSE
    EVENT_DISP $14, $b, $9 ; CERULEAN_HOUSE_3
    EVENT_DISP $14, $9, $9 ; CERULEAN_HOUSE_3

CeruleanCityBlocks: ; 360
    INCBIN "maps/ceruleancity.blk"

VermilionCity_h: ; 0x18998 to 0x189ba (34 bytes) (bank=6) (id=5)
    db $00 ; tileset
    db VERMILION_CITY_HEIGHT, VERMILION_CITY_WIDTH ; dimensions (y, x)
    dw VermilionCityBlocks, VermilionCityTexts, VermilionCityScript ; blocks, texts, scripts
    db NORTH | EAST ; connections

    ; connections data

	db ROUTE_6
    dw Route6Blocks + (ROUTE_6_HEIGHT - 3) * ROUTE_6_WIDTH ; connection strip location
    dw $C6EB + 5 ; current map position
    db ROUTE_6_WIDTH, ROUTE_6_WIDTH ; bigness, width
    db (ROUTE_6_HEIGHT * 2) - 1, (5 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_6_HEIGHT * (ROUTE_6_WIDTH + 6) ; window

	db ROUTE_11
    dw Route11Blocks + (ROUTE_11_WIDTH * 0) ; connection strip location
    dw $C6E5 + (VERMILION_CITY_WIDTH + 6) * (4 + 4) ; current map position
    db ROUTE_11_HEIGHT, ROUTE_11_WIDTH ; bigness, width
    db (4 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_11_WIDTH ; window

    ; end connections data

    dw VermilionCityObject ; objects

VermilionCityObject: ; 0x189ba (size=133)
    db $43 ; border tile

    db $9 ; warps
    db $3, $b, $0, VERMILION_POKECENTER
    db $d, $9, $0, POKEMON_FAN_CLUB
    db $d, $17, $0, VERMILION_MART
    db $13, $c, $0, VERMILION_GYM
    db $13, $17, $0, VERMILION_HOUSE_1
    db $1f, $12, $0, VERMILION_DOCK
    db $1f, $13, $0, VERMILION_DOCK
    db $d, $f, $0, VERMILION_HOUSE_3
    db $3, $7, $0, VERMILION_HOUSE_2

    db $7 ; signs
    db $3, $1b, $7 ; VermilionCityText7
    db $d, $25, $8 ; VermilionCityText8
    db $d, $18, $9 ; VermilionCityText9
    db $3, $c, $a ; VermilionCityText10
    db $d, $7, $b ; VermilionCityText11
    db $13, $7, $c ; VermilionCityText12
    db $f, $1d, $d ; VermilionCityText13

    db $6 ; people
    db SPRITE_FOULARD_WOMAN, $7 + 4, $13 + 4, $fe, $2, $1 ; person
    db SPRITE_GAMBLER, $6 + 4, $e + 4, $ff, $ff, $2 ; person
    db SPRITE_SAILOR, $1e + 4, $13 + 4, $ff, $d1, $3 ; person
    db SPRITE_GAMBLER, $7 + 4, $1e + 4, $ff, $ff, $4 ; person
    db SPRITE_SLOWBRO, $9 + 4, $1d + 4, $fe, $1, $5 ; person
    db SPRITE_SAILOR, $1b + 4, $19 + 4, $fe, $2, $6 ; person

    ; warp-to
    EVENT_DISP $14, $3, $b ; VERMILION_POKECENTER
    EVENT_DISP $14, $d, $9 ; POKEMON_FAN_CLUB
    EVENT_DISP $14, $d, $17 ; VERMILION_MART
    EVENT_DISP $14, $13, $c ; VERMILION_GYM
    EVENT_DISP $14, $13, $17 ; VERMILION_HOUSE_1
    EVENT_DISP $14, $1f, $12 ; VERMILION_DOCK
    EVENT_DISP $14, $1f, $13 ; VERMILION_DOCK
    EVENT_DISP $14, $d, $f ; VERMILION_HOUSE_3
    EVENT_DISP $14, $3, $7 ; VERMILION_HOUSE_2

VermilionCityBlocks: ; 360
    INCBIN "maps/vermilioncity.blk"

FuchsiaCity_h: ; 0x18ba7 to 0x18bd4 (45 bytes) (bank=6) (id=7)
    db $00 ; tileset
    db FUCHSIA_CITY_HEIGHT, FUCHSIA_CITY_WIDTH ; dimensions (y, x)
    dw FuchsiaCityBlocks, FuchsiaCityTexts, FuchsiaCityScript ; blocks, texts, scripts
    db SOUTH | WEST | EAST ; connections

    ; connections data

	db ROUTE_19
    dw Route19Blocks ; connection strip location
    dw $C6EB + (FUCHSIA_CITY_HEIGHT + 3) * (FUCHSIA_CITY_WIDTH + 6) + 5 ; current map position
    db ROUTE_19_WIDTH, ROUTE_19_WIDTH ; bigness, width
    db 0, (5 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_19_WIDTH ; window

	db ROUTE_18
    dw Route18Blocks - 3 + (ROUTE_18_WIDTH) ; connection strip location
    dw $C6E8 + (FUCHSIA_CITY_WIDTH + 6) * (4 + 3) ; current map position
    db ROUTE_18_HEIGHT, ROUTE_18_WIDTH ; bigness, width
    db (4 * -2), (ROUTE_18_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_18_WIDTH ; window

	db ROUTE_15
    dw Route15Blocks + (ROUTE_15_WIDTH * 0) ; connection strip location
    dw $C6E5 + (FUCHSIA_CITY_WIDTH + 6) * (4 + 4) ; current map position
    db ROUTE_15_HEIGHT, ROUTE_15_WIDTH ; bigness, width
    db (4 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_15_WIDTH ; window

    ; end connections data

    dw FuchsiaCityObject ; objects

FuchsiaCityObject: ; 0x18bd4 (size=178)
    db $f ; border tile

    db $9 ; warps
    db $d, $5, $0, FUCHSIA_MART
    db $1b, $b, $0, FUCHSIA_HOUSE_1
    db $1b, $13, $0, FUCHSIA_POKECENTER
    db $1b, $1b, $0, FUCHSIA_HOUSE_2
    db $3, $12, $0, SAFARIZONEENTRANCE
    db $1b, $5, $0, FUCHSIA_GYM
    db $d, $16, $0, FUCHSIAMEETINGROOM
    db $1b, $1f, $1, FUCHSIA_HOUSE_3
    db $18, $1f, $0, FUCHSIA_HOUSE_3

    db $e ; signs
    db $17, $f, $b ; FuchsiaCityText11
    db $f, $19, $c ; FuchsiaCityText12
    db $5, $11, $d ; FuchsiaCityText13
    db $d, $6, $e ; FuchsiaCityText14
    db $1b, $14, $f ; FuchsiaCityText15
    db $1d, $1b, $10 ; FuchsiaCityText16
    db $f, $15, $11 ; FuchsiaCityText17
    db $1d, $5, $12 ; FuchsiaCityText18
    db $7, $21, $13 ; FuchsiaCityText19
    db $7, $1b, $14 ; FuchsiaCityText20
    db $7, $d, $15 ; FuchsiaCityText21
    db $d, $1f, $16 ; FuchsiaCityText22
    db $f, $d, $17 ; FuchsiaCityText23
    db $7, $7, $18 ; FuchsiaCityText24

    db $a ; people
    db SPRITE_BUG_CATCHER, $c + 4, $a + 4, $fe, $2, $1 ; person
    db SPRITE_GAMBLER, $11 + 4, $1c + 4, $fe, $2, $2 ; person
    db SPRITE_FISHER2, $e + 4, $1e + 4, $ff, $d0, $3 ; person
    db SPRITE_BUG_CATCHER, $8 + 4, $18 + 4, $ff, $d1, $4 ; person
    db SPRITE_CLEFAIRY, $5 + 4, $1f + 4, $fe, $0, $5 ; person
    db SPRITE_BALL, $6 + 4, $19 + 4, $ff, $ff, $6 ; person
    db SPRITE_SLOWBRO, $6 + 4, $c + 4, $fe, $2, $7 ; person
    db SPRITE_SLOWBRO, $c + 4, $1e + 4, $fe, $2, $8 ; person
    db SPRITE_SEEL, $11 + 4, $8 + 4, $fe, $0, $9 ; person
    db SPRITE_OMANYTE, $5 + 4, $6 + 4, $ff, $ff, $a ; person

    ; warp-to
    EVENT_DISP $14, $d, $5 ; FUCHSIA_MART
    EVENT_DISP $14, $1b, $b ; FUCHSIA_HOUSE_1
    EVENT_DISP $14, $1b, $13 ; FUCHSIA_POKECENTER
    EVENT_DISP $14, $1b, $1b ; FUCHSIA_HOUSE_2
    EVENT_DISP $14, $3, $12 ; SAFARIZONEENTRANCE
    EVENT_DISP $14, $1b, $5 ; FUCHSIA_GYM
    EVENT_DISP $14, $d, $16 ; FUCHSIAMEETINGROOM
    EVENT_DISP $14, $1b, $1f ; FUCHSIA_HOUSE_3
    EVENT_DISP $14, $18, $1f ; FUCHSIA_HOUSE_3

FuchsiaCityBlocks: ; 360
    INCBIN "maps/fuchsiacity.blk"

INCBIN "baserom.gbc",$18dee,$6d

PalletTownScript:
	ld a,[$D74B]
	bit 4,a
	jr z,.next\@
	ld hl,$D747
	set 6,[hl]
.next\@
	call $3C3C
	ld hl,PalletTownScriptPointers
	ld a,[$D5F1]
	jp $3D97
; 0x18e73

PalletTownScriptPointers:
	dw PalletTownScript1,PalletTownScript2,PalletTownScript3,PalletTownScript4,PalletTownScript5,PalletTownScript6,PalletTownScript7

PalletTownScript1:
	ld a,[$D747]
	bit 0,a
	ret nz
	ld a,[W_YCOORD]
	cp 1 ; is player near north exit?
	ret nz
	xor a
	ld [$FFB4],a
	ld a,4
	ld [$D528],a
	ld a,$FF
	call $23B1 ; stop music
	ld a,2
	ld c,a ; song bank
	ld a,$DB ; “oak appears” music
	call $23A1 ; plays music
	ld a,$FC
	ld [$CD6B],a
	ld hl,$D74B
	set 7,[hl]

	; trigger the next script
	ld a,1
	ld [$D5F1],a
	ret

PalletTownScript2:
	xor a
	ld [$CF0D],a
	ld a,1
	ld [$FF8C],a
	call $2920
	ld a,$FF
	ld [$CD6B],a
	ld a,0
	ld [$CC4D],a
	ld a,$15
	call Predef

	; trigger the next script
	ld a,2
	ld [$D5F1],a
	ret

PalletTownScript3:
	ld a,1
	ld [$FF8C],a
	ld a,4
	ld [$FF8D],a
	call $34A6
	call Delay3
	ld a,1
	ld [W_YCOORD],a
	ld a,1
	ld [$FF9B],a
	ld a,1
	swap a
	ld [$FF95],a
	ld a,$22
	call Predef
	ld hl,$FF95
	dec [hl]
	ld a,$20
	call Predef ; load Oak’s movement into $CC97
	ld de,$CC97
	ld a,1 ; oak
	ld [$FF8C],a
	call MoveSprite
	ld a,$FF
	ld [$CD6B],a

	; trigger the next script
	ld a,3
	ld [$D5F1],a
	ret

PalletTownScript4:
	ld a,[$D730]
	bit 0,a
	ret nz
	xor a
	ld [$C109],a
	ld a,1
	ld [$CF0D],a
	ld a,$FC
	ld [$CD6B],a
	ld a,1
	ld [$FF8C],a
	call $2920
	ld a,$FF
	ld [$CD6B],a
	ld a,1
	ld [$CF13],a
	xor a
	ld [$CF10],a
	ld a,1
	ld [$CC57],a
	ld a,[$FFB8]
	ld [$CC58],a

	; trigger the next script
	ld a,4
	ld [$D5F1],a
	ret

PalletTownScript5:
	ld a,[$CC57]
	and a
	ret nz

	; trigger the next script
	ld a,5
	ld [$D5F1],a
	ret

PalletTownScript6:
	ld a,[$D74A]
	bit 2,a
	jr nz,.next\@
	and 3
	cp 3
	jr nz,.next\@
	ld hl,$D74A
	set 2,[hl]
	ld a,$27
	ld [$CC4D],a
	ld a,$11
	call Predef
	ld a,$28
	ld [$CC4D],a
	ld a,$15
	jp Predef
.next\@
	ld a,[$D74B]
	bit 4,a
	ret z
	ld hl,$D74B
	set 6,[hl]
PalletTownScript7:
	ret

PalletTownTexts: ; 0x18f88
	dw PalletTownText1,PalletTownText2,PalletTownText3,PalletTownText4,PalletTownText5,PalletTownText6,PalletTownText7

PalletTownText1: ; 4F96 0x18f96
	db 8
	ld a,[$CF0D]
	and a
	jr nz,.next\@
	ld a,1
	ld [$CC3C],a
	ld hl,OakAppearsText
	jr .done\@
.next\@
	ld hl,OakWalksUpText
.done\@
	call PrintText
	jp $24D7

OakAppearsText:
	TX_FAR _OakAppearsText
	db 8
	ld c,10
	call DelayFrames
	xor a
	ld [$CD4F],a
	ld [$CD50],a
	ld a,$4C
	call Predef ; display ! over head
	ld a,4
	ld [$D528],a
	jp $24D7

OakWalksUpText:
	TX_FAR _OakWalksUpText
	db "@"

PalletTownText2: ; girl 0x18fd3
	TX_FAR _PalletTownText2 ; dc 42 29 pointing to 0xa42dc
	db "@"

PalletTownText3: ; fat man
	TX_FAR _PalletTownText3
	db "@"

PalletTownText4: ; sign by lab
	TX_FAR _PalletTownText4
	db "@"

PalletTownText5: ; sign by fence
	TX_FAR _PalletTownText5
	db "@"

PalletTownText6: ; sign by Red’s house
	TX_FAR _PalletTownText6
	db "@"

PalletTownText7: ; sign by Blue’s house
	TX_FAR _PalletTownText7
	db "@"

ViridianCityScript: ; 0x18ff1
    call $3c3c
    ld hl, $4ffd
    ld a, [$d5f4]
    jp $3d97
; 0x18ffd

ViridianCityScripts: ; 0x18ffd
    dw ViridianCityScript0

INCBIN "baserom.gbc",$18fff,$6

ViridianCityScript0: ; 0x19005
    call $500b
    jp $503d
; 0x1900b

INCBIN "baserom.gbc",$1900b,$d9

ViridianCityTexts: ; 0x190e4
    dw ViridianCityText1, ViridianCityText2, ViridianCityText3, ViridianCityText4, ViridianCityText5, ViridianCityText6, ViridianCityText7, ViridianCityText8, ViridianCityText9, ViridianCityText10, ViridianCityText11, ViridianCityText12, ViridianCityText13, ViridianCityText14, ViridianCityText15

ViridianCityText1: ; 0x19102
    TX_FAR _ViridianCityText1
    db $50

ViridianCityText2: ; 0x19107
    db $08 ; asm
    ld a, [$d356]
    cp $7f
    ld hl, $5127
    jr z, .asm_ae9fe ; 0x19110
    ld a, [$d751]
    bit 1, a
    jr nz, .asm_ae9fe ; 0x19117
    ld hl, $5122
.asm_ae9fe ; 0x1911c
    call PrintText
    jp $24d7

UnnamedText_19122: ; 0x19122
    TX_FAR _UnnamedText_19122
    db $50
; 0x19122 + 5 bytes

UnnamedText_19127: ; 0x19127
    TX_FAR _UnnamedText_19127
    db $50
; 0x19127 + 5 bytes

ViridianCityText3: ; 0x1912c
    db $08 ; asm
    ld hl, $514d
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, .asm_6dfea ; 0x1913a
    ld hl, $5157
    call PrintText
    jr .asm_d611f ; 0x19142
.asm_6dfea ; 0x19144
    ld hl, $5152
    call PrintText
.asm_d611f ; 0x1914a
    jp $24d7

UnnamedText_1914d: ; 0x1914d
    TX_FAR _UnnamedText_1914d
    db $50
; 0x1914d + 5 bytes

UnnamedText_19152: ; 0x19152
    TX_FAR _UnnamedText_19152
    db $50
; 0x19152 + 5 bytes

UnnamedText_19157: ; 0x19157
    TX_FAR _UnnamedText_19157
    db $50
; 0x19157 + 5 bytes

ViridianCityText4: ; 0x1915c
    db $08 ; asm
    ld a, [$d74b]
    bit 5, a
    jr nz, .asm_83894 ; 0x19162
    ld hl, $5175
    call PrintText
    jr .asm_700a6 ; 0x1916a
.asm_83894 ; 0x1916c
    ld hl, $517a
    call PrintText
.asm_700a6 ; 0x19172
    jp $24d7

UnnamedText_19175: ; 0x19175
    TX_FAR _UnnamedText_19175
    db $50
; 0x19175 + 5 bytes

UnnamedText_1917a: ; 0x1917a
    TX_FAR _UnnamedText_1917a
    db $50
; 0x1917a + 5 bytes

ViridianCityText5: ; 0x1917f
    db $08 ; asm
    ld hl, $5191
    call PrintText
    call $50cf
    ld a, $3
    ld [$d5f4], a
    jp $24d7

UnnamedText_19191: ; 0x19191
    TX_FAR _UnnamedText_19191
    db $50
; 0x19191 + 5 bytes

ViridianCityText6: ; 0x19196
    db $08 ; asm
    ld a, [$d74c]
    bit 1, a
    jr nz, .asm_4e5a0 ; 0x1919c
    ld hl, $51ca
    call PrintText
    ld bc,(TM_42 << 8) | 1
    call $3e2e
    jr nc, .asm_b655e ; 0x191aa
    ld hl, $51cf
    call PrintText
    ld hl, $d74c
    set 1, [hl]
    jr .asm_3c73c ; 0x191b7
.asm_b655e ; 0x191b9
    ld hl, $51da
    call PrintText
    jr .asm_3c73c ; 0x191bf
.asm_4e5a0 ; 0x191c1
    ld hl, $51d5
    call PrintText
.asm_3c73c ; 0x191c7
    jp $24d7

UnnamedText_191ca: ; 0x191ca
    TX_FAR _UnnamedText_191ca
    db $50
; 0x191ca + 5 bytes

INCBIN "baserom.gbc",$191cf,$191d5 - $191cf

UnnamedText_191d5: ; 0x191d5
    TX_FAR _UnnamedText_191d5
    db $50
; 0x191d5 + 5 bytes

UnnamedText_191da: ; 0x191da
    TX_FAR _UnnamedText_191da
    db $50
; 0x191da + 5 bytes

ViridianCityText7: ; 0x191df
    db $08 ; asm
    ld hl, $520a
    call PrintText
    ld c, $2
    call $3739
    call $35ec
    ld a, [$cc26]
    and a
    jr z, .asm_42f68 ; 0x191f2
    ld hl, $520f
    call PrintText
    ld a, $1
    ld [$d5f4], a
    jr .asm_2413a ; 0x191ff
.asm_42f68 ; 0x19201
    ld hl, $5214
    call PrintText
.asm_2413a ; 0x19207
    jp $24d7

UnnamedText_1920a: ; 0x1920a
    TX_FAR _UnnamedText_1920a
    db $50
; 0x1920a + 5 bytes

UnnamedText_1920f: ; 0x1920f
    TX_FAR _UnnamedText_1920f
    db $50
; 0x1920f + 5 bytes

UnnamedText_19214: ; 0x19214
    TX_FAR _UnnamedText_19214
    db $50
; 0x19214 + 5 bytes

ViridianCityText15: ; 0x19219
    TX_FAR _UnnamedText_19219
    db $50
; 0x19219 + 5 bytes

ViridianCityText8: ; 0x1921e
    TX_FAR _ViridianCityText8
    db $50

ViridianCityText9: ; 0x19223
    TX_FAR _ViridianCityText9
    db $50

ViridianCityText10: ; 0x19228
    TX_FAR _ViridianCityText10
    db $50

ViridianCityText13: ; 0x1922d
    TX_FAR _ViridianCityText13
    db $50

ViridianCityText14:

UnnamedText_19232: ; 0x19232
    TX_FAR _UnnamedText_19232
    db $50
; 0x19232 + 5 bytes

PewterCityScript: ; 0x19237
    call $3c3c
    ld hl, $5243
    ld a, [$d5f7]
    jp $3d97
; 0x19243

PewterCityScripts: ; 0x19243
    dw PewterCityScript0

INCBIN "baserom.gbc",$19245,$c

PewterCityScript0: ; 0x19251
    xor a
    ld [$d619], a
    ld hl, $d754
    res 0, [hl]
    call $525e
    ret
; 0x1925e

INCBIN "baserom.gbc",$1925e,$12d

PewterCityTexts: ; 0x1938b
    dw PewterCityText1, PewterCityText2, PewterCityText3, PewterCityText4, PewterCityText5, PewterCityText6, PewterCityText7, PewterCityText8, PewterCityText9, PewterCityText10, PewterCityText11, PewterCityText12, PewterCityText13, PewterCityText14

PewterCityText1: ; 0x193a7
    TX_FAR _PewterCityText1
    db $50

PewterCityText2: ; 0x193ac
    TX_FAR _PewterCityText2
    db $50

PewterCityText3: ; 0x193b1
    db $08 ; asm
    ld hl, $53f1
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, .asm_f46a9 ; 0x193bf
    ld hl, $53f6
    call PrintText
    jr .asm_ac429 ; 0x193c7
.asm_f46a9 ; 0x193c9
    ld hl, $53fb
    call PrintText
    xor a
    ldh [$b3], a
    ldh [$b4], a
    ld [$cf10], a
    ld a, $2
    ld [$cc57], a
    ldh a, [$b8]
    ld [$cc58], a
    ld a, $3
    ld [$cf13], a
    call $32f4
    ld a, $1
    ld [$d5f7], a
.asm_ac429 ; 0x193ee
    jp $24d7

UnnamedText_193f1: ; 0x193f1
    TX_FAR _UnnamedText_193f1
    db $50
; 0x193f1 + 5 bytes

UnnamedText_193f6: ; 0x193f6
    TX_FAR _UnnamedText_193f6
    db $50
; 0x193f6 + 5 bytes

UnnamedText_193fb: ; 0x193fb
    TX_FAR _UnnamedText_193fb
    db $50
; 0x193fb + 5 bytes

PewterCityText13:

UnnamedText_19400: ; 0x19400
    TX_FAR _UnnamedText_19400
    db $50
; 0x19400 + 5 bytes

PewterCityText4: ; 0x19405
    db $8
    ld hl, $5427
    call PrintText
    call $35ec
    ld a, [$cc26]
    cp $0
    jr nz, .asm_e4603
    ld hl, $542c
    call PrintText
    jr .asm_e4604 ; 0x1941c $6
.asm_e4603
    ld hl, $5431
    call PrintText
.asm_e4604 ; 0x19424
    jp $24d7
; 0x19427

UnnamedText_19427: ; 0x19427
    TX_FAR _UnnamedText_19427
    db $50
; 0x19427 + 5 bytes

UnnamedText_1942c: ; 0x1942c
    TX_FAR _UnnamedText_1942c
    db $50
; 0x1942c + 5 bytes

UnnamedText_19431: ; 0x19431
    TX_FAR _UnnamedText_19431
    db $50
; 0x19431 + 5 bytes

PewterCityText5: ; 0x19436
    db $08 ; asm
    ld hl, $545d
    call PrintText
    xor a
    ldh [$b4], a
    ld [$cf10], a
    ld a, $3
    ld [$cc57], a
    ldh a, [$b8]
    ld [$cc58], a
    ld a, $5
    ld [$cf13], a
    call $32f4
    ld a, $4
    ld [$d5f7], a
    jp $24d7

UnnamedText_1945d: ; 0x1945d
    TX_FAR _UnnamedText_1945d
    db $50
; 0x1945d + 5 bytes

PewterCityText14: ; 0x19462

UnnamedText_19462: ; 0x19462
    TX_FAR _UnnamedText_19462
    db $50
; 0x19462 + 5 bytes

PewterCityText6: ; 0x19467
    TX_FAR _PewterCityText6
    db $50

PewterCityText7: ; 0x1946c
    TX_FAR _PewterCityText7
    db $50

PewterCityText10: ; 0x19471
    TX_FAR _PewterCityText10
    db $50

PewterCityText11: ; 0x19476
    TX_FAR _PewterCityText11
    db $50

PewterCityText12: ; 0x1947b
    TX_FAR _PewterCityText12
    db $50

CeruleanCityScript: ; 0x19480
    call $3c3c
    ld hl, $549d
    ld a, [$d60f]
    jp $3d97
; 0x1948c

INCBIN "baserom.gbc",$1948c,$1949d - $1948c

CeruleanCityScripts: ; 0x1949d
    dw CeruleanCityScript0, CeruleanCityScript1, CeruleanCityScript2, CeruleanCityScript3

INCBIN "baserom.gbc",$194a5,$23

CeruleanCityScript0: ; 0x194c8
    ld a, [$d75b]
    bit 7, a
    jr nz, .asm_194f7 ; 0x194cd $28
    ld hl, $554f
    call $34bf
    jr nc, .asm_194f7 ; 0x194d5 $20
    ld a, [$cd3d]
    cp $1
    ld a, $8
    ld b, $0
    jr nz, .asm_194e6 ; 0x194e0 $4
    ld a, $4
    ld b, $4
.asm_194e6
    ld [$d528], a
    ld a, b
    ld [$c129], a
    call Delay3
    ld a, $2
    ld [$ff00+$8c], a
    jp $2920
.asm_194f7
    ld a, [$d75a]
    bit 0, a
    ret nz
    ld hl, $5554
    call $34bf
    ret nc
    ld a, [$d700]
    and a
    jr z, .asm_19512 ; 0x19508 $8
    ld a, $ff
    ld [$c0ee], a
    call $23b1
.asm_19512
    ld c, $2
    ld a, $de
    call $23a1
    xor a
    ld [$ff00+$b4], a
    ld a, $f0
    ld [$cd6b], a
    ld a, [$d362]
    cp $14
    jr z, .asm_19535 ; 0x19526 $d
    ld a, $1
    ld [$ff00+$8c], a
    ld a, $5
    ld [$ff00+$8b], a
    call $3500
    ld [hl], $19
.asm_19535
    ld a, $5
    ld [$cc4d], a
    ld a, $15
    call Predef
    ld de, $5559
    ld a, $1
    ld [$ff00+$8c], a
    call $363a
    ld a, $1
    ld [$d60f], a
    ret
; 0x1954f

INCBIN "baserom.gbc",$1954f,$19567 - $1954f

CeruleanCityScript1: ; 0x19567
    ld a, [$d730]
    bit 0, a
    ret nz
    xor a
    ld [$cd6b], a
    ld a, $1
    ld [$ff00+$8c], a
    call $2920
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $566d
    ld de, $5672
    call $3354
    ld a, $e1
    ld [$d059], a
    ld a, [$d715]
    cp $b1
    jr nz, .asm_19598 ; 0x19592 $4
    ld a, $7
    jr .asm_195a2 ; 0x19596 $a
.asm_19598
    cp $99
    jr nz, .asm_195a0 ; 0x1959a $4
    ld a, $8
    jr .asm_195a2 ; 0x1959e $2
.asm_195a0
    ld a, $9
.asm_195a2
    ld [$d05d], a
    xor a
    ld [$ff00+$b4], a
    call $555d
    ld a, $2
    ld [$d60f], a
    ret
; 0x195b1

CeruleanCityScript2: ; 0x195b1
    ld a, [$d057]
    cp $ff
    jp z, $548c
    call $555d
    ld a, $f0
    ld [$cd6b], a
    ld hl, $d75a
    set 0, [hl]
    ld a, $1
    ld [$ff00+$8c], a
    call $2920
    ld a, $ff
    ld [$c0ee], a
    call $23b1
    ld b, $2
    ld hl, $5b47
    call Bankswitch
    ld a, $1
    ld [$ff00+$8c], a
    call $3541
    ld a, [$d362]
    cp $14
    jr nz, .asm_195f0 ; 0x195e9 $5
    ld de, $5608
    jr .asm_195f3 ; 0x195ee $3
.asm_195f0
    ld de, $5600
.asm_195f3
    ld a, $1
    ld [$ff00+$8c], a
    call $363a
    ld a, $3
    ld [$d60f], a
    ret
; 0x19600

INCBIN "baserom.gbc",$19600,$19610 - $19600

CeruleanCityScript3: ; 0x19610
    ld a, [$d730]
    bit 0, a
    ret nz
    ld a, $5
    ld [$cc4d], a
    ld a, $11
    call Predef
    xor a
    ld [$cd6b], a
    call $2307
    ld a, $0
    ld [$d60f], a
    ret
; 0x1962d

CeruleanCityTexts: ; 0x1962d
    dw CeruleanCityText1, CeruleanCityText2, CeruleanCityText3, CeruleanCityText4, CeruleanCityText5, CeruleanCityText6, CeruleanCityText7, CeruleanCityText8, CeruleanCityText9, CeruleanCityText10, CeruleanCityText11, CeruleanCityText12, CeruleanCityText13, CeruleanCityText14, CeruleanCityText15, CeruleanCityText16, CeruleanCityText17

CeruleanCityText1: ; 0x1964f
    db $08 ; asm
    ld a, [$d75a]
    bit 0, a
    jr z, .asm_a89f9 ; 0x19655
    ld hl, $5677
    call PrintText
    jr .asm_815c6 ; 0x1965d
.asm_a89f9 ; 0x1965f
    ld hl, $5668
    call PrintText
.asm_815c6 ; 0x19665
    jp $24d7

UnnamedText_19668: ; 0x19668
    TX_FAR _UnnamedText_19668
    db $50
; 0x19668 + 5 bytes

UnnamedText_1966d: ; 0x1966d
    TX_FAR _UnnamedText_1966d
    db $50
; 0x1966d + 5 bytes

UnnamedText_19672: ; 0x19672
    TX_FAR _UnnamedText_19672
    db $50
; 0x19672 + 5 bytes

UnnamedText_19677: ; 0x19677
    TX_FAR _UnnamedText_19677
    db $50
; 0x19677 + 5 bytes

CeruleanCityText2: ; 0x1967c
    db $8
    ld a, [$d75b]
    bit 7, a
    jr nz, .asm_4ca20 ; 0x19682 $29
    ld hl, $56d9
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $56ee
    ld de, $56ee
    call $3354
    ld a, [$ff00+$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    ld a, $4
    ld [$d60f], a
    jp $24d7
.asm_4ca20 ; 0x196ad
    ld hl, $56f3
    call PrintText
    ld bc, $e401
    call GiveItem
    jr c, .asm_8bbbd ; 0x196b9 $8
    ld hl, $56e9
    call PrintText
    jr .asm_e4e6f ; 0x196c1 $13
.asm_8bbbd ; 0x196c3
    ld a, $1
    ld [$cc3c], a
    ld hl, $56de
    call PrintText
    ld b, $1d
    ld hl, $4872
    call Bankswitch
.asm_e4e6f ; 0x196d6
    jp $24d7
; 0x196d9

UnnamedText_196d9: ; 0x196d9
    TX_FAR _UnnamedText_196d9
    db $50
; 0x196d9 + 5 bytes

INCBIN "baserom.gbc",$196de,$196e9 - $196de

UnnamedText_196e9: ; 0x196e9
    TX_FAR _UnnamedText_196e9
    db $50
; 0x196e9 + 5 bytes

UnnamedText_196ee: ; 0x196ee
    TX_FAR _UnnamedText_196ee
    db $50
; 0x196ee + 5 bytes

UnnamedText_196f3: ; 0x196f3
    TX_FAR _UnnamedText_196f3
    db $50
; 0x196f3 + 5 bytes

CeruleanCityText3: ; 0x196f8
    TX_FAR _CeruleanCityText3
    db $50

CeruleanCityText4: ; 0x196fd
    TX_FAR _CeruleanCityText4
    db $50

CeruleanCityText5: ; 0x19702
    TX_FAR _CeruleanCityText5
    db $50

CeruleanCityText11:
CeruleanCityText6: ; 0x19707
    TX_FAR _CeruleanCityText6
    db $50

CeruleanCityText7: ; 0x1970c
    db $08 ; asm
    ldh a, [$d3]
    cp $b4
    jr c, .asm_e9fc9 ; 0x19711
    ld hl, $5730
    call PrintText
    jr .asm_d486e ; 0x19719
.asm_e9fc9 ; 0x1971b
    cp $64
    jr c, .asm_df99b ; 0x1971d
    ld hl, $5735
    call PrintText
    jr .asm_d486e ; 0x19725
.asm_df99b ; 0x19727
    ld hl, $573a
    call PrintText
.asm_d486e ; 0x1972d
    jp $24d7

UnnamedText_19730: ; 0x19730
    TX_FAR _UnnamedText_19730
    db $50
; 0x19730 + 5 bytes

UnnamedText_19735: ; 0x19735
    TX_FAR _UnnamedText_19735
    db $50
; 0x19735 + 5 bytes

UnnamedText_1973a: ; 0x1973a
    TX_FAR _UnnamedText_1973a
    db $50
; 0x1973a + 5 bytes

CeruleanCityText8: ; 0x1973f
    db $08 ; asm
    ldh a, [$d3]
    cp $b4
    jr c, .asm_e28da ; 0x19744
    ld hl, $576f
    call PrintText
    jr .asm_f2f38 ; 0x1974c
.asm_e28da ; 0x1974e
    cp $78
    jr c, .asm_15d08 ; 0x19750
    ld hl, $5774
    call PrintText
    jr .asm_f2f38 ; 0x19758
.asm_15d08 ; 0x1975a
    cp $3c
    jr c, .asm_d7fea ; 0x1975c
    ld hl, $5779
    call PrintText
    jr .asm_f2f38 ; 0x19764
.asm_d7fea ; 0x19766
    ld hl, $577e
    call PrintText
.asm_f2f38 ; 0x1976c
    jp $24d7

UnnamedText_1976f: ; 0x1976f
    TX_FAR _UnnamedText_1976f
    db $50
; 0x1976f + 5 bytes

UnnamedText_19774: ; 0x19774
    TX_FAR _UnnamedText_19774
    db $50
; 0x19774 + 5 bytes

UnnamedText_19779: ; 0x19779
    TX_FAR _UnnamedText_19779
    db $50
; 0x19779 + 5 bytes

UnnamedText_1977e: ; 0x1977e
    TX_FAR _UnnamedText_1977e
    db $50
; 0x1977e + 5 bytes

CeruleanCityText9: ; 0x19783
    TX_FAR _CeruleanCityText9
    db $50

CeruleanCityText10: ; 0x19788
    TX_FAR _CeruleanCityText10
    db $50

CeruleanCityText12: ; 0x1978d
    TX_FAR _CeruleanCityText12
    db $50

CeruleanCityText13: ; 0x19792
    TX_FAR _CeruleanCityText13
    db $50

CeruleanCityText16: ; 0x19797
    TX_FAR _CeruleanCityText16
    db $50

CeruleanCityText17: ; 0x1979c
    TX_FAR _CeruleanCityText17
    db $50

VermilionCityScript: ; 0x197a1
    call $3c3c
    ld hl, $d126
    bit 6, [hl]
    res 6, [hl]
    push hl
    call nz, $57cb
    pop hl
    bit 5, [hl]
    res 5, [hl]
    call nz, $57c0
    ld hl, $57dc
    ld a, [$d62a]
    jp $3d97
; 0x197c0

INCBIN "baserom.gbc",$197c0,$197dc - $197c0

VermilionCityScripts: ; 0x197dc
    dw VermilionCityScript0, VermilionCityScript1

INCBIN "baserom.gbc",$197e0,$6

VermilionCityScript0: ; 0x197e6
    ld a, [$c109]
    and a
    ret nz
    ld hl, $5823
    call $34bf
    ret nc
    xor a
    ld [$ff00+$b4], a
    ld [$cf0d], a
    ld a, $3
    ld [$ff00+$8c], a
    call $2920
    ld a, [$d803]
    bit 2, a
    jr nz, .asm_19810 ; 0x19804 $a
    ld b, $3f
    ld a, $1c
    call Predef
    ld a, b
    and a
    ret nz
.asm_19810
    ld a, $40
    ld [$ccd3], a
    ld a, $1
    ld [$cd38], a
    call $3486
    ld a, $1
    ld [$d62a], a
    ret
; 0x19823

INCBIN "baserom.gbc",$19823,$1985f - $19823

VermilionCityScript1: ; 0x1985f
    ld a, [$cd38]
    and a
    ret nz
    ld c, $a
    call $3739
    ld a, $0
    ld [$d62a], a
    ret
; 0x1986f

VermilionCityTexts: ; 0x1986f
    dw VermilionCityText1, VermilionCityText2, VermilionCityText3, VermilionCityText4, VermilionCityText5, VermilionCityText6, VermilionCityText7, VermilionCityText8, VermilionCityText9, VermilionCityText10, VermilionCityText11, VermilionCityText12, VermilionCityText13

VermilionCityText1: ; 0x19889
    TX_FAR _VermilionCityText1
    db $50

VermilionCityText2: ; 0x1988e
    db $08 ; asm
    ld a, [$d803]
    bit 2, a
    jr nz, .asm_359bd ; 0x19894
    ld hl, $58a7
    call PrintText
    jr .asm_735d9 ; 0x1989c
.asm_359bd ; 0x1989e
    ld hl, $58ac
    call PrintText
.asm_735d9 ; 0x198a4
    jp $24d7

UnnamedText_198a7: ; 0x198a7
    TX_FAR _UnnamedText_198a7
    db $50
; 0x198a7 + 5 bytes

UnnamedText_198ac: ; 0x198ac
    TX_FAR _UnnamedText_198ac
    db $50
; 0x198ac + 5 bytes

VermilionCityText3: ; 0x198b1
    db $08 ; asm
    ld a, [$d803]
    bit 2, a
    jr nz, .asm_3e0e9 ; 0x198b7
    ld a, [$c109]
    cp $c
    jr z, .asm_07af3 ; 0x198be
    ld hl, $58ff
    call $34bf
    jr nc, .asm_57b73 ; 0x198c6
.asm_07af3 ; 0x198c8
    ld hl, $5904
    call PrintText
    jr .asm_79bd1 ; 0x198ce
.asm_57b73 ; 0x198d0
    ld hl, $5909
    call PrintText
    ld b, $3f
    ld a, $1c
    call Predef
    ld a, b
    and a
    jr nz, .asm_0419b ; 0x198df
    ld hl, $5913
    call PrintText
    jr .asm_79bd1 ; 0x198e7
.asm_0419b ; 0x198e9
    ld hl, $590e
    call PrintText
    ld a, $4
    ld [$d62a], a
    jr .asm_79bd1 ; 0x198f4
.asm_3e0e9 ; 0x198f6
    ld hl, $5918
    call PrintText
.asm_79bd1 ; 0x198fc
    jp $24d7

INCBIN "baserom.gbc",$198ff,$19904 - $198ff

UnnamedText_19904: ; 0x19904
    TX_FAR _UnnamedText_19904
    db $50
; 0x19904 + 5 bytes

UnnamedText_19909: ; 0x19909
    TX_FAR _UnnamedText_19909
    db $50
; 0x19909 + 5 bytes

UnnamedText_1990e: ; 0x1990e
    TX_FAR _UnnamedText_1990e
    db $50
; 0x1990e + 5 bytes

UnnamedText_19913: ; 0x19913
    TX_FAR _UnnamedText_19913
    db $50
; 0x19913 + 5 bytes

UnnamedText_19918: ; 0x19918
    TX_FAR _UnnamedText_19918
    db $50
; 0x19918 + 5 bytes

VermilionCityText4: ; 0x1991d
    TX_FAR _VermilionCityText4
    db $50

VermilionCityText5: ; 0x19922
    TX_FAR _VermilionCityText5
    db $08 ; asm
    ld a, $6a
    call $13d0
    call $3748
    ld hl, $5933
    ret

VermilionCityText14: ; 0x19933
    TX_FAR _VermilionCityText14
    db $50

VermilionCityText6: ; 0x19938
    TX_FAR _VermilionCityText6
    db $50

VermilionCityText7: ; 0x1993d
    TX_FAR _VermilionCityText7
    db $50

VermilionCityText8: ; 0x19942
    TX_FAR _VermilionCityText8
    db $50

VermilionCityText11: ; 0x19947
    TX_FAR _VermilionCityText11
    db $50

VermilionCityText12: ; 0x1994c
    TX_FAR _VermilionCityText12
    db $50

VermilionCityText13: ; 0x19951
    TX_FAR _VermilionCityText13
    db $50

CeladonCityScript: ; 0x19956
    call $3c3c
    ld hl, $d77e
    res 0, [hl]
    res 7, [hl]
    ld hl, $d816
    res 7, [hl]
    ret
; 0x19966

CeladonCityTexts: ; 0x19966
    dw CeladonCityText1, CeladonCityText2, CeladonCityText3, CeladonCityText4, CeladonCityText5, CeladonCityText6, CeladonCityText7, CeladonCityText8, CeladonCityText9, CeladonCityText10, CeladonCityText11, CeladonCityText12, CeladonCityText13, CeladonCityText14, CeladonCityText15, CeladonCityText16, CeladonCityText17, CeladonCityText18

CeladonCityText1: ; 0x1998a
    TX_FAR _CeladonCityText1
    db $50

CeladonCityText2: ; 0x1998f
    TX_FAR _CeladonCityText2
    db $50

CeladonCityText3: ; 0x19994
    TX_FAR _CeladonCityText3
    db $50

CeladonCityText4: ; 0x19999
    TX_FAR _CeladonCityText4
    db $50

CeladonCityText5: ; 0x1999e
    db $08 ; asm
    ld a, [$d777]
    bit 0, a
    jr nz, .asm_7053f ; 0x199a4
    ld hl, $59d2
    call PrintText
    ld bc,(TM_41 << 8) | 1
    call $3e2e
    jr c, .asm_890ec ; 0x199b2
    ld hl, $59e2
    call PrintText
    jr .asm_c765a ; 0x199ba
.asm_890ec ; 0x199bc
    ld hl, $59d7
    call PrintText
    ld hl, $d777
    set 0, [hl]
    jr .asm_c765a ; 0x199c7
.asm_7053f ; 0x199c9
    ld hl, $59dd
    call PrintText
.asm_c765a ; 0x199cf
    jp $24d7

UnnamedText_199d2: ; 0x199d2
    TX_FAR _UnnamedText_199d2
    db $50
; 0x199d2 + 5 bytes

INCBIN "baserom.gbc",$199d7,$199dd - $199d7

UnnamedText_199dd: ; 0x199dd
    TX_FAR _UnnamedText_199dd
    db $50
; 0x199dd + 5 bytes

UnnamedText_199e2: ; 0x199e2
    TX_FAR _UnnamedText_199e2
    db $50
; 0x199e2 + 5 bytes

CeladonCityText6: ; 0x199e7
    TX_FAR _CeladonCityText6
    db $50

CeladonCityText7: ; 0x199ec
    TX_FAR _CeladonCityText7
    db $08 ; asm
    ld a, $6f
    call $13d0
    jp $24d7

CeladonCityText8: ; 0x199f9
    TX_FAR _CeladonCityText8
    db $50

CeladonCityText9: ; 0x199fe
    TX_FAR _CeladonCityText9
    db $50

CeladonCityText10: ; 0x19a03
    TX_FAR _CeladonCityText10
    db $50

CeladonCityText11: ; 0x19a08
    TX_FAR _CeladonCityText11
    db $50

CeladonCityText13: ; 0x19a0d
    TX_FAR _CeladonCityText13
    db $50

CeladonCityText14: ; 0x19a12
    TX_FAR _CeladonCityText14
    db $50

CeladonCityText15: ; 0x19a17
    TX_FAR _CeladonCityText15
    db $50

CeladonCityText16: ; 0x19a1c
    TX_FAR _CeladonCityText16
    db $50

CeladonCityText17: ; 0x19a21
    TX_FAR _CeladonCityText17
    db $50

CeladonCityText18: ; 0x19a26
    TX_FAR _CeladonCityText18
    db $50

FuchsiaCityScript: ; 0x19a2b
    jp $3c3c
; 0x19a2e

FuchsiaCityTexts: ; 0x19a2e
    dw FuchsiaCityText1, FuchsiaCityText2, FuchsiaCityText3, FuchsiaCityText4, FuchsiaCityText5, FuchsiaCityText6, FuchsiaCityText7, FuchsiaCityText8, FuchsiaCityText9, FuchsiaCityText10, FuchsiaCityText11, FuchsiaCityText12, FuchsiaCityText13, FuchsiaCityText14, FuchsiaCityText15, FuchsiaCityText16, FuchsiaCityText17, FuchsiaCityText18, FuchsiaCityText19, FuchsiaCityText20, FuchsiaCityText21, FuchsiaCityText22, FuchsiaCityText23, FuchsiaCityText24

FuchsiaCityText1: ; 0x19a5e
    TX_FAR _FuchsiaCityText1
    db $50

FuchsiaCityText2: ; 0x19a63
    TX_FAR _FuchsiaCityText2
    db $50

FuchsiaCityText3: ; 0x19a68
    TX_FAR _FuchsiaCityText3
    db $50

FuchsiaCityText4: ; 0x19a6d
    TX_FAR _FuchsiaCityText4
    db $50

FuchsiaCityText5: ; 0x19a72
FuchsiaCityText6:
FuchsiaCityText7:
FuchsiaCityText8:
FuchsiaCityText9:
FuchsiaCityText10: ; 0x19a72
    TX_FAR _FuchsiaCityText5
    db $50

FuchsiaCityText12:
FuchsiaCityText11: ; 0x19a77
    TX_FAR _FuchsiaCityText11
    db $50

FuchsiaCityText13: ; 0x19a7c
    TX_FAR _FuchsiaCityText13
    db $50

FuchsiaCityText16: ; 0x19a81
    TX_FAR _FuchsiaCityText16
    db $50

FuchsiaCityText17: ; 0x19a86
    TX_FAR _FuchsiaCityText17
    db $50

FuchsiaCityText18: ; 0x19a8b
    TX_FAR _FuchsiaCityText18
    db $50

FuchsiaCityText19: ; 0x19a90
    db $08 ; asm
    ld hl, $5a9f
    call PrintText
    ld a, $28
    call $349b
    jp $24d7

UnnamedText_19a9f: ; 0x19a9f
    TX_FAR _UnnamedText_19a9f
    db $50
; 0x19a9f + 5 bytes

FuchsiaCityText20: ; 0x19aa4
    db $08 ; asm
    ld hl, $5ab3
    call PrintText
    ld a, $6
    call $349b
    jp $24d7

UnnamedText_19ab3: ; 0x19ab3
    TX_FAR _UnnamedText_19ab3
    db $50
; 0x19ab3 + 5 bytes

FuchsiaCityText21: ; 0x19ab8
    db $08 ; asm
    ld hl, $5ac7
    call PrintText
    ld a, $2
    call $349b
    jp $24d7

UnnamedText_19ac7: ; 0x19ac7
    TX_FAR _UnnamedText_19ac7
    db $50
; 0x19ac7 + 5 bytes

FuchsiaCityText22: ; 0x19acc
    db $08 ; asm
    ld hl, $5adb
    call PrintText
    ld a, $25
    call $349b
    jp $24d7

UnnamedText_19adb: ; 0x19adb
    TX_FAR _UnnamedText_19adb
    db $50
; 0x19adb + 5 bytes

FuchsiaCityText23: ; 0x19ae0
    db $08 ; asm
    ld hl, $5aef
    call PrintText
    ld a, $13
    call $349b
    jp $24d7

UnnamedText_19aef: ; 0x19aef
    TX_FAR _UnnamedText_19aef
    db $50
; 0x19aef + 5 bytes

FuchsiaCityText24: ; 0x19af4
    db $08 ; asm
    ld a, [$d7f6]
    bit 6, a
    jr nz, .asm_3b4e8 ; 0x19afa
    bit 7, a
    jr nz, .asm_667d5 ; 0x19afe
    ld hl, $5b2a
    call PrintText
    jr .asm_4343f ; 0x19b06
.asm_3b4e8 ; 0x19b08
    ld hl, $5b20
    call PrintText
    ld a, $62
    jr .asm_81556 ; 0x19b10
.asm_667d5 ; 0x19b12
    ld hl, $5b25
    call PrintText
    ld a, $5a
.asm_81556 ; 0x19b1a
    call $349b
.asm_4343f ; 0x19b1d
    jp $24d7

UnnamedText_19b20: ; 0x19b20
    TX_FAR _UnnamedText_19b20
    db $50
; 0x19b20 + 5 bytes

UnnamedText_19b25: ; 0x19b25
    TX_FAR _UnnamedText_19b25
    db $50
; 0x19b25 + 5 bytes

UnnamedText_19b2a: ; 0x19b2a
    TX_FAR _UnnamedText_19b2a
    db $50
; 0x19b2a + 5 bytes

BluesHouse_h: ; 0x19b2f
	db $08 ; tileset
	db BLUES_HOUSE_HEIGHT, BLUES_HOUSE_WIDTH ; dimensions
	dw BluesHouseBlocks, BluesHouseTexts, BluesHouseScript
	db 0
	dw BluesHouseObject

BluesHouseScript:
	call $3C3C
	ld hl,BluesHouseScriptPointers
	ld a,[$D5F3]
	jp $3D97

BluesHouseScriptPointers:
	dw BluesHouseScript1,BluesHouseScript2

BluesHouseScript1:
	ld hl,$D74A
	set 1,[hl]

	; trigger the next script
	ld a,1
	ld [$D5F3],a
	ret

BluesHouseScript2:
	ret

BluesHouseTexts: ; 0x19B57
	dw BluesHouseText1,BluesHouseText2,BluesHouseText3

BluesHouseText1: ; 5B5D 0x19B5D
	db 8
	ld a,[$D74A]
	bit 0,a
	jr nz,.GotMap\@
	ld a,[$D74B]
	bit 5,a
	jr nz,.GiveMap\@
	ld hl,DaisyInitialText
	call PrintText
	jr .done\@
.GiveMap\@
	ld hl,DaisyOfferMapText
	call PrintText
	ld bc,(TOWN_MAP << 8) | 1
	call $3E2E
	jr nc,.BagFull\@
	ld a,$29
	ld [$CC4D],a
	ld a,$11
	call Predef ; hide table map object
	ld hl,GotMapText
	call PrintText
	ld hl,$D74A
	set 0,[hl]
	jr .done\@
.GotMap\@
	ld hl,DaisyUseMapText
	call PrintText
	jr .done\@
.BagFull\@
	ld hl,DaisyBagFullText
	call PrintText
.done\@
	jp $24D7

DaisyInitialText:
	TX_FAR _DaisyInitialText
	db "@"

DaisyOfferMapText:
	TX_FAR _DaisyOfferMapText
	db "@"

GotMapText:
	TX_FAR _GotMapText
	db $11,"@"

DaisyBagFullText:
	TX_FAR _DaisyBagFullText
	db "@"

DaisyUseMapText:
	TX_FAR _DaisyUseMapText
	db "@"

BluesHouseText2: ; Daisy, walking around
	TX_FAR _BluesHouseText2
	db "@"

BluesHouseText3: ; map on table
	TX_FAR _BluesHouseText3
	db "@"

BluesHouseObject:
	db $0A ; border tile

	db 2 ; warps
	db 7,2,1,$FF
	db 7,3,1,$FF

	db 0 ; signs

	db 3 ; people
	db $11,4+3,4+2,$FF,$D3,1 ; Daisy, sitting by map
	db $11,4+4,4+6,$FE,1,ITEM|2,0 ; map on table
	db $41,4+3,4+3,$FF,$FF,ITEM|3,0 ; Daisy, walking around

	; warp-to
	dw $C712
	db 7,2

	dw $C712
	db 7,3

BluesHouseBlocks:
	INCBIN "maps/blueshouse.blk"

VermilionHouse3_h: ; 0x19c06 to 0x19c12 (12 bytes) (bank=6) (id=196)
    db $08 ; tileset
    db VERMILION_HOUSE_3_HEIGHT, VERMILION_HOUSE_3_WIDTH ; dimensions (y, x)
    dw VermilionHouse3Blocks, VermilionHouse3Texts, VermilionHouse3Script ; blocks, texts, scripts
    db $00 ; connections

    dw VermilionHouse3Object ; objects

VermilionHouse3Script: ; 0x19c12
    jp $3c3c
; 0x19c15

VermilionHouse3Texts: ; 0x19c15
    dw VermilionHouse3Text1

VermilionHouse3Text1: ; 0x19c17
    db $08 ; asm
    ld a, $4
    ld [W_WHICHTRADE], a
    ld a, $54
    call Predef
    jp $24d7

VermilionHouse3Object: ; 0x19c25 (size=26)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $7, $ff
    db $7, $3, $7, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_LITTLE_GIRL, $5 + 4, $3 + 4, $ff, $d1, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

VermilionHouse3Blocks: ; 16
    INCBIN "maps/vermilionhouse3.blk"

IndigoPlateauLobby_h: ; 0x19c4f to 0x19c5b (12 bytes) (bank=6) (id=174)
    db $02 ; tileset
    db INDIGO_PLATEAU_LOBBY_HEIGHT, INDIGO_PLATEAU_LOBBY_WIDTH ; dimensions (y, x)
    dw IndigoPlateauLobbyBlocks, IndigoPlateauLobbyTexts, IndigoPlateauLobbyScript ; blocks, texts, scripts
    db $00 ; connections

    dw IndigoPlateauLobbyObject ; objects

IndigoPlateauLobbyScript: ; 0x19c5b
    call $22fa
    call $3c3c
    ld hl, $d126
    bit 6, [hl]
    res 6, [hl]
    ret z
    ld hl, $d869
    res 7, [hl]
    ld hl, $d734
    bit 1, [hl]
    res 1, [hl]
    ret z
    ld hl, $d863
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ret
; 0x19c7f

IndigoPlateauLobbyTexts:
    dw IndigoPlateauLobbyText1, IndigoPlateauLobbyText2, IndigoPlateauLobbyText3, IndigoPlateauLobbyText4, IndigoPlateauLobbyText5

IndigoPlateauLobbyText1: ; 0x19c8a
    db $ff

IndigoPlateauLobbyText2: ; 0x19c8b
    TX_FAR _IndigoPlateauLobbyText1
    db $50

INCBIN "baserom.gbc",$19c8f,$19c8f - $19c8f

IndigoPlateauLobbyText3: ; 0x19c8f
    TX_FAR _IndigoPlateauLobbyText3
    db $50

IndigoPlateauLobbyText5:
    db $f6

IndigoPlateauLobbyObject: ; 0x19c95 (size=58)
    db $0 ; border tile

    db $3 ; warps
    db $b, $7, $0, $ff
    db $b, $8, $1, $ff
    db $0, $8, $0, LORELEIS_ROOM

    db $0 ; signs

    db $5 ; people
    db SPRITE_NURSE, $5 + 4, $7 + 4, $ff, $d0, $1 ; person
    db SPRITE_GYM_HELPER, $9 + 4, $4 + 4, $ff, $d3, $2 ; person
    db SPRITE_LASS, $1 + 4, $5 + 4, $ff, $d0, $3 ; person
    db SPRITE_MART_GUY, $5 + 4, $0 + 4, $ff, $d3, $4 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $6 + 4, $d + 4, $ff, $d0, $5 ; person

    ; warp-to
    EVENT_DISP $8, $b, $7
    EVENT_DISP $8, $b, $8
    EVENT_DISP $8, $0, $8 ; LORELEIS_ROOM

IndigoPlateauLobbyBlocks: ; 48
    INCBIN "maps/indigoplateaulobby.blk"

SilphCo4_h: ; 0x19cff to 0x19d0b (12 bytes) (bank=6) (id=209)
    db $16 ; tileset
    db SILPH_CO_4F_HEIGHT, SILPH_CO_4F_WIDTH ; dimensions (y, x)
    dw SilphCo4Blocks, SilphCo4Texts, SilphCo4Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo4Object ; objects

SilphCo4Script: ; 0x19d0b
    call $5d21
    call $3c3c
    ld hl, $5dae
    ld de, $5d9a
    ld a, [$d645]
    call $3160
    ld [$d645], a
    ret
; 0x19d21

INCBIN "baserom.gbc",$19d21,$7f

SilphCo4Texts: ; 0x19da0
    dw SilphCo4Text1, SilphCo4Text2, SilphCo4Text3, SilphCo4Text4, SilphCo4Text5, SilphCo4Text6, SilphCo4Text7

INCBIN "baserom.gbc",$19dae,$25

SilphCo4Text1: ; 0x19dd3
    db $08 ; asm
    ld hl, $5de0
    ld de, $5de5
    call $622f
    jp $24d7

UnnamedText_19de0: ; 0x19de0
    TX_FAR _UnnamedText_19de0
    db $50
; 0x19de0 + 5 bytes

UnnamedText_19de5: ; 0x19de5
    TX_FAR _UnnamedText_19de5
    db $50
; 0x19de5 + 5 bytes

SilphCo4Text2: ; 0x19dea
    db $08 ; asm
    ld hl, $5dae
    call LoadTrainerHeader
    jp $24d7

UnnamedText_19df4: ; 0x19df4
    TX_FAR _UnnamedText_19df4
    db $50
; 0x19df4 + 5 bytes

UnnamedText_19df9: ; 0x19df9
    TX_FAR _UnnamedText_19df9
    db $50
; 0x19df9 + 5 bytes

UnnamedText_19dfe: ; 0x19dfe
    TX_FAR _UnnamedText_19dfe
    db $50
; 0x19dfe + 5 bytes

SilphCo4Text3: ; 0x19e03
    db $08 ; asm
    ld hl, $5dba
    call LoadTrainerHeader
    jp $24d7

UnnamedText_19e0d: ; 0x19e0d
    TX_FAR _UnnamedText_19e0d
    db $50
; 0x19e0d + 5 bytes

UnnamedText_19e12: ; 0x19e12
    TX_FAR _UnnamedText_19e12
    db $50
; 0x19e12 + 5 bytes

UnnamedText_19e17: ; 0x19e17
    TX_FAR _UnnamedText_19e17
    db $50
; 0x19e17 + 5 bytes

SilphCo4Text4: ; 0x19e1c
    db $08 ; asm
    ld hl, $5dc6
    call LoadTrainerHeader
    jp $24d7

UnnamedText_19e26: ; 0x19e26
    TX_FAR _UnnamedText_19e26
    db $50
; 0x19e26 + 5 bytes

UnnamedText_19e2b: ; 0x19e2b
    TX_FAR _UnnamedText_19e2b
    db $50
; 0x19e2b + 5 bytes

UnnamedText_19e30: ; 0x19e30
    TX_FAR _UnnamedText_19e30
    db $50
; 0x19e30 + 5 bytes

SilphCo4Object: ; 0x19e35 (size=111)
    db $2e ; border tile

    db $7 ; warps
    db $0, $18, $1, SILPH_CO_3F
    db $0, $1a, $1, SILPH_CO_5F
    db $0, $14, $0, SILPH_CO_ELEVATOR
    db $7, $b, $3, SILPH_CO_10F
    db $3, $11, $3, SILPH_CO_6F
    db $f, $3, $4, SILPH_CO_10F
    db $b, $11, $5, SILPH_CO_10F

    db $0 ; signs

    db $7 ; people
    db SPRITE_LAPRAS_GIVER, $2 + 4, $6 + 4, $ff, $ff, $1 ; person
    db SPRITE_ROCKET, $e + 4, $9 + 4, $ff, $d3, $42, ROCKET + $C8, $1a ; trainer
    db SPRITE_OAK_AIDE, $6 + 4, $e + 4, $ff, $d2, $43, SCIENTIST + $C8, $5 ; trainer
    db SPRITE_ROCKET, $a + 4, $1a + 4, $ff, $d1, $44, ROCKET + $C8, $1b ; trainer
	db SPRITE_BALL, $9 + 4, $3 + 4, $ff, $ff, $85, FULL_HEAL ; item
	db SPRITE_BALL, $7 + 4, $4 + 4, $ff, $ff, $86, MAX_REVIVE ; item
	db SPRITE_BALL, $8 + 4, $5 + 4, $ff, $ff, $87, ESCAPE_ROPE ; item

    ; warp-to
    EVENT_DISP $f, $0, $18 ; SILPH_CO_3F
    EVENT_DISP $f, $0, $1a ; SILPH_CO_5F
    EVENT_DISP $f, $0, $14 ; SILPH_CO_ELEVATOR
    EVENT_DISP $f, $7, $b ; SILPH_CO_10F
    EVENT_DISP $f, $3, $11 ; SILPH_CO_6F
    EVENT_DISP $f, $f, $3 ; SILPH_CO_10F
    EVENT_DISP $f, $b, $11 ; SILPH_CO_10F

SilphCo4Blocks: ; 135
    INCBIN "maps/silphco4.blk"

SilphCo5_h: ; 0x19f2b to 0x19f37 (12 bytes) (bank=6) (id=210)
    db $16 ; tileset
    db SILPH_CO_5F_HEIGHT, SILPH_CO_5F_WIDTH ; dimensions (y, x)
    dw SilphCo5Blocks, SilphCo5Texts, SilphCo5Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo5Object ; objects

SilphCo5Script: ; 0x19f37
    call $5f4d
    call $3c3c
    ld hl, $5fd2
    ld de, $5fb6
    ld a, [$d646]
    call $3160
    ld [$d646], a
    ret
; 0x19f4d

INCBIN "baserom.gbc",$19f4d,$6f

SilphCo5Texts: ; 0x19fbc
    dw SilphCo5Text1, SilphCo5Text2, SilphCo5Text3, SilphCo5Text4, SilphCo5Text5, SilphCo5Text6, SilphCo5Text7, SilphCo5Text8, SilphCo5Text9, SilphCo5Text10, SilphCo5Text11

INCBIN "baserom.gbc",$19fd2,$31

SilphCo5Text1: ; 0x1a003
    db $08 ; asm
    ld hl, $6010
    ld de, $6015
    call $622f
    jp $24d7

UnnamedText_1a010: ; 0x1a010
    TX_FAR _UnnamedText_1a010
    db $50
; 0x1a010 + 5 bytes

UnnamedText_1a015: ; 0x1a015
    TX_FAR _UnnamedText_1a015
    db $50
; 0x1a015 + 5 bytes

SilphCo5Text2: ; 0x1a01a
    db $08 ; asm
    ld hl, $5fd2
    call LoadTrainerHeader
    jp $24d7

UnnamedText_1a024: ; 0x1a024
    TX_FAR _UnnamedText_1a024
    db $50
; 0x1a024 + 5 bytes

UnnamedText_1a029: ; 0x1a029
    TX_FAR _UnnamedText_1a029
    db $50
; 0x1a029 + 5 bytes

UnnamedText_1a02e: ; 0x1a02e
    TX_FAR _UnnamedText_1a02e
    db $50
; 0x1a02e + 5 bytes

SilphCo5Text3: ; 0x1a033
    db $08 ; asm
    ld hl, $5fde
    call LoadTrainerHeader
    jp $24d7

UnnamedText_1a03d: ; 0x1a03d
    TX_FAR _UnnamedText_1a03d
    db $50
; 0x1a03d + 5 bytes

UnnamedText_1a042: ; 0x1a042
    TX_FAR _UnnamedText_1a042
    db $50
; 0x1a042 + 5 bytes

UnnamedText_1a047: ; 0x1a047
    TX_FAR _UnnamedText_1a047
    db $50
; 0x1a047 + 5 bytes

SilphCo5Text4: ; 0x1a04c
    db $08 ; asm
    ld hl, $5fea
    call LoadTrainerHeader
    jp $24d7

UnnamedText_1a056: ; 0x1a056
    TX_FAR _UnnamedText_1a056
    db $50
; 0x1a056 + 5 bytes

UnnamedText_1a05b: ; 0x1a05b
    TX_FAR _UnnamedText_1a05b
    db $50
; 0x1a05b + 5 bytes

UnnamedText_1a060: ; 0x1a060
    TX_FAR _UnnamedText_1a060
    db $50
; 0x1a060 + 5 bytes

SilphCo5Text5: ; 0x1a065
    db $08 ; asm
    ld hl, $5ff6
    call LoadTrainerHeader
    jp $24d7

UnnamedText_1a06f: ; 0x1a06f
    TX_FAR _UnnamedText_1a06f
    db $50
; 0x1a06f + 5 bytes

UnnamedText_1a074: ; 0x1a074
    TX_FAR _UnnamedText_1a074
    db $50
; 0x1a074 + 5 bytes

UnnamedText_1a079: ; 0x1a079
    TX_FAR _UnnamedText_1a079
    db $50
; 0x1a079 + 5 bytes

SilphCo5Text9: ; 0x1a07e
    TX_FAR _SilphCo5Text9
    db $50

SilphCo5Text10: ; 0x1a083
    TX_FAR _SilphCo5Text10
    db $50

SilphCo5Text11: ; 0x1a088
    TX_FAR _SilphCo5Text11
    db $50

SilphCo5Object: ; 0x1a08d (size=137)
    db $2e ; border tile

    db $7 ; warps
    db $0, $18, $1, SILPH_CO_6F
    db $0, $1a, $1, SILPH_CO_4F
    db $0, $14, $0, SILPH_CO_ELEVATOR
    db $3, $1b, $5, SILPH_CO_7F
    db $f, $9, $4, SILPH_CO_9F
    db $5, $b, $4, SILPH_CO_3F
    db $f, $3, $5, SILPH_CO_3F

    db $0 ; signs

    db $b ; people
    db SPRITE_LAPRAS_GIVER, $9 + 4, $d + 4, $ff, $ff, $1 ; person
    db SPRITE_ROCKET, $10 + 4, $8 + 4, $ff, $d3, $42, ROCKET + $C8, $1c ; trainer
    db SPRITE_OAK_AIDE, $3 + 4, $8 + 4, $ff, $d3, $43, SCIENTIST + $C8, $6 ; trainer
    db SPRITE_ROCKER, $a + 4, $12 + 4, $ff, $d1, $44, JUGGLER + $C8, $1 ; trainer
    db SPRITE_ROCKET, $4 + 4, $1c + 4, $ff, $d1, $45, ROCKET + $C8, $1d ; trainer
	db SPRITE_BALL, $d + 4, $2 + 4, $ff, $ff, $86, TM_09 ; item
	db SPRITE_BALL, $6 + 4, $4 + 4, $ff, $ff, $87, PROTEIN ; item
	db SPRITE_BALL, $10 + 4, $15 + 4, $ff, $ff, $88, CARD_KEY ; item
    db SPRITE_CLIPBOARD, $c + 4, $16 + 4, $ff, $ff, $9 ; person
    db SPRITE_CLIPBOARD, $a + 4, $19 + 4, $ff, $ff, $a ; person
    db SPRITE_CLIPBOARD, $6 + 4, $18 + 4, $ff, $ff, $b ; person

    ; warp-to
    EVENT_DISP $f, $0, $18 ; SILPH_CO_6F
    EVENT_DISP $f, $0, $1a ; SILPH_CO_4F
    EVENT_DISP $f, $0, $14 ; SILPH_CO_ELEVATOR
    EVENT_DISP $f, $3, $1b ; SILPH_CO_7F
    EVENT_DISP $f, $f, $9 ; SILPH_CO_9F
    EVENT_DISP $f, $5, $b ; SILPH_CO_3F
    EVENT_DISP $f, $f, $3 ; SILPH_CO_3F

SilphCo5Blocks: ; 135
    INCBIN "maps/silphco5.blk"

SilphCo6_h: ; 0x1a19d to 0x1a1a9 (12 bytes) (bank=6) (id=211)
    db $16 ; tileset
    db SILPH_CO_6F_HEIGHT, SILPH_CO_6F_WIDTH ; dimensions (y, x)
    dw SilphCo6Blocks, SilphCo6Texts, SilphCo6Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo6Object ; objects

SilphCo6Script: ; 0x1a1a9
    call $61bf
    call $3c3c
    ld hl, $620a
    ld de, $61f0
    ld a, [$d647]
    call $3160
    ld [$d647], a
    ret
; 0x1a1bf

INCBIN "baserom.gbc",$1a1bf,$37

SilphCo6Texts: ; 0x1a1f6
    dw SilphCo6Text1, SilphCo6Text2, SilphCo6Text3, SilphCo6Text4, SilphCo6Text5, SilphCo6Text6, SilphCo6Text7, SilphCo6Text8, SilphCo6Text9, SilphCo6Text10

INCBIN "baserom.gbc",$1a20a,$33

SilphCo6Text1: ; 0x1a23d
    db $08 ; asm
    ld hl, $624a
    ld de, $624f
    call $622f
    jp $24d7

UnnamedText_1a24a: ; 0x1a24a
    TX_FAR _UnnamedText_1a24a
    db $50
; 0x1a24a + 5 bytes

UnnamedText_1a24f: ; 0x1a24f
    TX_FAR _UnnamedText_1a24f
    db $50
; 0x1a24f + 5 bytes

SilphCo6Text2: ; 0x1a254
    db $08 ; asm
    ld hl, $6261
    ld de, $6266
    call $622f
    jp $24d7

UnnamedText_1a261: ; 0x1a261
    TX_FAR _UnnamedText_1a261
    db $50
; 0x1a261 + 5 bytes

UnnamedText_1a266: ; 0x1a266
    TX_FAR _UnnamedText_1a266
    db $50
; 0x1a266 + 5 bytes

SilphCo6Text3: ; 0x1a26b
    db $08 ; asm
    ld hl, $6278
    ld de, $627d
    call $622f
    jp $24d7

UnnamedText_1a278: ; 0x1a278
    TX_FAR _UnnamedText_1a278
    db $50
; 0x1a278 + 5 bytes

UnnamedText_1a27d: ; 0x1a27d
    TX_FAR _UnnamedText_1a27d
    db $50
; 0x1a27d + 5 bytes

SilphCo6Text4: ; 0x1a282
    db $08 ; asm
    ld hl, $628f
    ld de, $6294
    call $622f
    jp $24d7

UnnamedText_1a28f: ; 0x1a28f
    TX_FAR _UnnamedText_1a28f
    db $50
; 0x1a28f + 5 bytes

UnnamedText_1a294: ; 0x1a294
    TX_FAR _UnnamedText_1a294
    db $50
; 0x1a294 + 5 bytes

SilphCo6Text5: ; 0x1a299
    db $08 ; asm
    ld hl, $62a6
    ld de, $62ab
    call $622f
    jp $24d7

UnnamedText_1a2a6: ; 0x1a2a6
    TX_FAR _UnnamedText_1a2a6
    db $50
; 0x1a2a6 + 5 bytes

UnnamedText_1a2ab: ; 0x1a2ab
    TX_FAR _UnnamedText_1a2ab
    db $50
; 0x1a2ab + 5 bytes

SilphCo6Text6: ; 0x1a2b0
    db $08 ; asm
    ld hl, $620a
    call LoadTrainerHeader
    jp $24d7

UnnamedText_1a2ba: ; 0x1a2ba
    TX_FAR _UnnamedText_1a2ba
    db $50
; 0x1a2ba + 5 bytes

UnnamedText_1a2bf: ; 0x1a2bf
    TX_FAR _UnnamedText_1a2bf
    db $50
; 0x1a2bf + 5 bytes

UnnamedText_1a2c4: ; 0x1a2c4
    TX_FAR _UnnamedText_1a2c4
    db $50
; 0x1a2c4 + 5 bytes

SilphCo6Text7: ; 0x1a2c9
    db $08 ; asm
    ld hl, $6216
    call LoadTrainerHeader
    jp $24d7

UnnamedText_1a2d3: ; 0x1a2d3
    TX_FAR _UnnamedText_1a2d3
    db $50
; 0x1a2d3 + 5 bytes

UnnamedText_1a2d8: ; 0x1a2d8
    TX_FAR _UnnamedText_1a2d8
    db $50
; 0x1a2d8 + 5 bytes

UnnamedText_1a2dd: ; 0x1a2dd
    TX_FAR _UnnamedText_1a2dd
    db $50
; 0x1a2dd + 5 bytes

SilphCo6Text8: ; 0x1a2e2
    db $08 ; asm
    ld hl, $6222
    call LoadTrainerHeader
    jp $24d7

UnnamedText_1a2ec: ; 0x1a2ec
    TX_FAR _UnnamedText_1a2ec
    db $50
; 0x1a2ec + 5 bytes

UnnamedText_1a2f1: ; 0x1a2f1
    TX_FAR _UnnamedText_1a2f1
    db $50
; 0x1a2f1 + 5 bytes

UnnamedText_1a2f6: ; 0x1a2f6
    TX_FAR _UnnamedText_1a2f6
    db $50
; 0x1a2f6 + 5 bytes

SilphCo6Object: ; 0x1a2fb (size=112)
    db $2e ; border tile

    db $5 ; warps
    db $0, $10, $1, SILPH_CO_7F
    db $0, $e, $0, SILPH_CO_5F
    db $0, $12, $0, SILPH_CO_ELEVATOR
    db $3, $3, $4, SILPH_CO_4F
    db $3, $17, $6, SILPH_CO_2F

    db $0 ; signs

    db $a ; people
    db SPRITE_LAPRAS_GIVER, $6 + 4, $a + 4, $ff, $ff, $1 ; person
    db SPRITE_LAPRAS_GIVER, $6 + 4, $14 + 4, $ff, $ff, $2 ; person
    db SPRITE_ERIKA, $6 + 4, $15 + 4, $ff, $d0, $3 ; person
    db SPRITE_ERIKA, $a + 4, $b + 4, $ff, $d3, $4 ; person
    db SPRITE_LAPRAS_GIVER, $d + 4, $12 + 4, $ff, $d1, $5 ; person
    db SPRITE_ROCKET, $3 + 4, $11 + 4, $ff, $d3, $46, ROCKET + $C8, $1e ; trainer
    db SPRITE_OAK_AIDE, $8 + 4, $7 + 4, $ff, $d0, $47, SCIENTIST + $C8, $7 ; trainer
    db SPRITE_ROCKET, $f + 4, $e + 4, $ff, $d2, $48, ROCKET + $C8, $1f ; trainer
	db SPRITE_BALL, $c + 4, $3 + 4, $ff, $ff, $89, HP_UP ; item
	db SPRITE_BALL, $f + 4, $2 + 4, $ff, $ff, $8a, X_ACCURACY ; item

    ; warp-to
    EVENT_DISP $d, $0, $10 ; SILPH_CO_7F
    EVENT_DISP $d, $0, $e ; SILPH_CO_5F
    EVENT_DISP $d, $0, $12 ; SILPH_CO_ELEVATOR
    EVENT_DISP $d, $3, $3 ; SILPH_CO_4F
    EVENT_DISP $d, $3, $17 ; SILPH_CO_2F

SilphCo6Blocks: ; 117
    INCBIN "maps/silphco6.blk"

INCBIN "baserom.gbc",$1a3e0,$1c20

SECTION "bank7",DATA,BANK[$7]

CinnabarIsland_h: ; 0x1c000 to 0x1c022 (34 bytes) (bank=7) (id=8)
    db $00 ; tileset
    db CINNABAR_ISLAND_HEIGHT, CINNABAR_ISLAND_WIDTH ; dimensions (y, x)
    dw CinnabarIslandBlocks, CinnabarIslandTexts, CinnabarIslandScript ; blocks, texts, scripts
    db NORTH | EAST ; connections

    ; connections data

	db ROUTE_21
    dw Route21Blocks + (ROUTE_21_HEIGHT - 3) * ROUTE_21_WIDTH ; connection strip location
    dw $C6EB + 0 ; current map position
    db ROUTE_21_WIDTH, ROUTE_21_WIDTH ; bigness, width
    db (ROUTE_21_HEIGHT * 2) - 1, (0 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_21_HEIGHT * (ROUTE_21_WIDTH + 6) ; window

	db ROUTE_20
    dw Route20Blocks + (ROUTE_20_WIDTH * 0) ; connection strip location
    dw $C6E5 + (CINNABAR_ISLAND_WIDTH + 6) * (0 + 4) ; current map position
    db ROUTE_20_HEIGHT, ROUTE_20_WIDTH ; bigness, width
    db (0 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_20_WIDTH ; window

    ; end connections data

    dw CinnabarIslandObject ; objects

CinnabarIslandObject: ; 0x1c022 (size=71)
    db $43 ; border tile

    db $5 ; warps
    db $3, $6, $1, MANSION_1
    db $3, $12, $0, CINNABAR_GYM
    db $9, $6, $0, CINNABAR_LAB_1
    db $b, $b, $0, CINNABAR_POKECENTER
    db $b, $f, $0, CINNABAR_MART

    db $5 ; signs
    db $5, $9, $3 ; CinnabarIslandText3
    db $b, $10, $4 ; CinnabarIslandText4
    db $b, $c, $5 ; CinnabarIslandText5
    db $b, $9, $6 ; CinnabarIslandText6
    db $3, $d, $7 ; CinnabarIslandText7

    db $2 ; people
    db SPRITE_GIRL, $5 + 4, $c + 4, $fe, $2, $1 ; person
    db SPRITE_GAMBLER, $6 + 4, $e + 4, $ff, $ff, $2 ; person

    ; warp-to
    EVENT_DISP $a, $3, $6 ; MANSION_1
    EVENT_DISP $a, $3, $12 ; CINNABAR_GYM
    EVENT_DISP $a, $9, $6 ; CINNABAR_LAB_1
    EVENT_DISP $a, $b, $b ; CINNABAR_POKECENTER
    EVENT_DISP $a, $b, $f ; CINNABAR_MART

CinnabarIslandBlocks: ; 90
    INCBIN "maps/cinnabarisland.blk"

Route1_h: ; 0x1c0c3 to 0x1c0e5 (34 bytes) (bank=7) (id=12)
    db $00 ; tileset
    db ROUTE_1_HEIGHT, ROUTE_1_WIDTH ; dimensions (y, x)
    dw Route1Blocks, Route1Texts, Route1Script ; blocks, texts, scripts
    db NORTH | SOUTH ; connections

    ; connections data

	db VIRIDIAN_CITY
    dw ViridianCityBlocks + (VIRIDIAN_CITY_HEIGHT - 3) * VIRIDIAN_CITY_WIDTH + 2, $c6e8 ; pointers (connected, current) (strip)
    db $10, $14 ; bigness, width
    db $23, $0a ; alignments (y, x)
    dw $c8bd ; window

	db PALLET_TOWN
    dw PalletTownBlocks, $c83b ; pointers (connected, current) (strip)
    db $0a, $0a ; bigness, width
    db $00, $00 ; alignments (y, x)
    dw $c6f9 ; window

    ; end connections data

    dw Route1Object ; objects

Route1Object: ; 0x1c0e5 (size=19)
    db $b ; border tile

    db $0 ; warps

    db $1 ; signs
    db $1b, $9, $3 ; Route1Text3

    db $2 ; people
    db SPRITE_BUG_CATCHER, $18 + 4, $5 + 4, $fe, $1, $1 ; person
    db SPRITE_BUG_CATCHER, $d + 4, $f + 4, $fe, $2, $2 ; person

INCBIN "baserom.gbc",$1c0f8,$4

Route1Blocks: ; 180
    INCBIN "maps/route1.blk"

UndergroundPathEntranceRoute8Blocks: ; 16
    INCBIN "maps/undergroundpathentranceroute8.blk"

OaksLabBlocks: ; 30
    INCBIN "maps/oakslab.blk"

Route16HouseBlocks:
Route2HouseBlocks:
SaffronHouse1Blocks:
SaffronHouse2Blocks:
VermilionHouse1Blocks:
NameRaterBlocks:
LavenderHouse1Blocks:
LavenderHouse2Blocks:
CeruleanHouse2Blocks:
PewterHouse1Blocks:
PewterHouse2Blocks:
ViridianHouseBlocks: ; 16 0x1c1de 41DE
    INCBIN "maps/viridianhouse.blk"

CeladonMansion5Blocks:
SchoolBlocks: ; 16 0x1c1ee 41EE
    INCBIN "maps/school.blk"

CeruleanHouseTrashedBlocks: ; 16
    INCBIN "maps/ceruleanhousetrashed.blk"

DiglettsCaveEntranceRoute11Blocks:
DiglettsCaveRoute2Blocks: ; 16
    INCBIN "maps/diglettscaveroute2.blk"

MonsterNames: ; 421E
	db "RHYDON@@@@"
	db "KANGASKHAN"
	db "NIDORAN♂@@"
	db "CLEFAIRY@@"
	db "SPEAROW@@@"
	db "VOLTORB@@@"
	db "NIDOKING@@"
	db "SLOWBRO@@@"
	db "IVYSAUR@@@"
	db "EXEGGUTOR@"
	db "LICKITUNG@"
	db "EXEGGCUTE@"
	db "GRIMER@@@@"
	db "GENGAR@@@@"
	db "NIDORAN♀@@"
	db "NIDOQUEEN@"
	db "CUBONE@@@@"
	db "RHYHORN@@@"
	db "LAPRAS@@@@"
	db "ARCANINE@@"
	db "MEW@@@@@@@"
	db "GYARADOS@@"
	db "SHELLDER@@"
	db "TENTACOOL@"
	db "GASTLY@@@@"
	db "SCYTHER@@@"
	db "STARYU@@@@"
	db "BLASTOISE@"
	db "PINSIR@@@@"
	db "TANGELA@@@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "GROWLITHE@"
	db "ONIX@@@@@@"
	db "FEAROW@@@@"
	db "PIDGEY@@@@"
	db "SLOWPOKE@@"
	db "KADABRA@@@"
	db "GRAVELER@@"
	db "CHANSEY@@@"
	db "MACHOKE@@@"
	db "MR.MIME@@@"
	db "HITMONLEE@"
	db "HITMONCHAN"
	db "ARBOK@@@@@"
	db "PARASECT@@"
	db "PSYDUCK@@@"
	db "DROWZEE@@@"
	db "GOLEM@@@@@"
	db "MISSINGNO."
	db "MAGMAR@@@@"
	db "MISSINGNO."
	db "ELECTABUZZ"
	db "MAGNETON@@"
	db "KOFFING@@@"
	db "MISSINGNO."
	db "MANKEY@@@@"
	db "SEEL@@@@@@"
	db "DIGLETT@@@"
	db "TAUROS@@@@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "MISSINGNO."
	db "FARFETCH'D"
	db "VENONAT@@@"
	db "DRAGONITE@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "MISSINGNO."
	db "DODUO@@@@@"
	db "POLIWAG@@@"
	db "JYNX@@@@@@"
	db "MOLTRES@@@"
	db "ARTICUNO@@"
	db "ZAPDOS@@@@"
	db "DITTO@@@@@"
	db "MEOWTH@@@@"
	db "KRABBY@@@@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "MISSINGNO."
	db "VULPIX@@@@"
	db "NINETALES@"
	db "PIKACHU@@@"
	db "RAICHU@@@@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "DRATINI@@@"
	db "DRAGONAIR@"
	db "KABUTO@@@@"
	db "KABUTOPS@@"
	db "HORSEA@@@@"
	db "SEADRA@@@@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "SANDSHREW@"
	db "SANDSLASH@"
	db "OMANYTE@@@"
	db "OMASTAR@@@"
	db "JIGGLYPUFF"
	db "WIGGLYTUFF"
	db "EEVEE@@@@@"
	db "FLAREON@@@"
	db "JOLTEON@@@"
	db "VAPOREON@@"
	db "MACHOP@@@@"
	db "ZUBAT@@@@@"
	db "EKANS@@@@@"
	db "PARAS@@@@@"
	db "POLIWHIRL@"
	db "POLIWRATH@"
	db "WEEDLE@@@@"
	db "KAKUNA@@@@"
	db "BEEDRILL@@"
	db "MISSINGNO."
	db "DODRIO@@@@"
	db "PRIMEAPE@@"
	db "DUGTRIO@@@"
	db "VENOMOTH@@"
	db "DEWGONG@@@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "CATERPIE@@"
	db "METAPOD@@@"
	db "BUTTERFREE"
	db "MACHAMP@@@"
	db "MISSINGNO."
	db "GOLDUCK@@@"
	db "HYPNO@@@@@"
	db "GOLBAT@@@@"
	db "MEWTWO@@@@"
	db "SNORLAX@@@"
	db "MAGIKARP@@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "MUK@@@@@@@"
	db "MISSINGNO."
	db "KINGLER@@@"
	db "CLOYSTER@@"
	db "MISSINGNO."
	db "ELECTRODE@"
	db "CLEFABLE@@"
	db "WEEZING@@@"
	db "PERSIAN@@@"
	db "MAROWAK@@@"
	db "MISSINGNO."
	db "HAUNTER@@@"
	db "ABRA@@@@@@"
	db "ALAKAZAM@@"
	db "PIDGEOTTO@"
	db "PIDGEOT@@@"
	db "STARMIE@@@"
	db "BULBASAUR@"
	db "VENUSAUR@@"
	db "TENTACRUEL"
	db "MISSINGNO."
	db "GOLDEEN@@@"
	db "SEAKING@@@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "MISSINGNO."
	db "MISSINGNO."
	db "PONYTA@@@@"
	db "RAPIDASH@@"
	db "RATTATA@@@"
	db "RATICATE@@"
	db "NIDORINO@@"
	db "NIDORINA@@"
	db "GEODUDE@@@"
	db "PORYGON@@@"
	db "AERODACTYL"
	db "MISSINGNO."
	db "MAGNEMITE@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "CHARMANDER"
	db "SQUIRTLE@@"
	db "CHARMELEON"
	db "WARTORTLE@"
	db "CHARIZARD@"
	db "MISSINGNO."
	db "MISSINGNO."
	db "MISSINGNO."
	db "MISSINGNO."
	db "ODDISH@@@@"
	db "GLOOM@@@@@"
	db "VILEPLUME@"
	db "BELLSPROUT"
	db "WEEPINBELL"
	db "VICTREEBEL"

INCBIN "baserom.gbc",$1c98a,$1c9c1 - $1c98a

UnnamedText_1c9c1: ; 0x1c9c1
    TX_FAR _UnnamedText_1c9c1
    db $50
; 0x1c9c1 + 5 bytes

INCBIN "baserom.gbc",$1c9c6,$1ca14 - $1c9c6

UnnamedText_1ca14: ; 0x1ca14
    TX_FAR _UnnamedText_1ca14
    db $50
; 0x1ca14 + 5 bytes

CinnabarIslandScript: ; 0x1ca19
    call $3c3c
    ld hl, $d126
    set 5, [hl]
    ld hl, $d796
    res 0, [hl]
    ld hl, $d7a3
    res 1, [hl]
    ld hl, $4a34
    ld a, [$d639]
    jp $3d97
; 0x1ca34

CinnabarIslandScripts: ; 0x1ca34
    dw CinnabarIslandScript0, CinnabarIslandScript1

CinnabarIslandScript0: ; 0x1ca38
    ld b, $2b
    call $3493
    ret nz
    ld a, [$d361]
    cp $4
    ret nz
    ld a, [$d362]
    cp $12
    ret nz
    ld a, $8
    ld [$d528], a
    ld a, $8
    ld [$ff00+$8c], a
    call $2920
    xor a
    ld [$ff00+$b4], a
    ld a, $1
    ld [$cd38], a
    ld a, $80
    ld [$ccd3], a
    call $3486
    xor a
    ld [$c109], a
    ld [$cd6b], a
    ld a, $1
    ld [$d639], a
    ret
; 0x1ca73

CinnabarIslandScript1: ; 0x1ca73
    ld a, [$cd38]
    and a
    ret nz
    call Delay3
    ld a, $0
    ld [$d639], a
    ret
; 0x1ca81

CinnabarIslandTexts: ; 0x1ca81
    dw CinnabarIslandText1, CinnabarIslandText2, CinnabarIslandText3, CinnabarIslandText4, CinnabarIslandText5, CinnabarIslandText6, CinnabarIslandText7, CinnabarIslandText8

CinnabarIslandText8:

UnnamedText_1ca91: ; 0x1ca91
    TX_FAR _UnnamedText_1ca91
    db $50
; 0x1ca91 + 5 bytes

CinnabarIslandText1: ; 0x1ca96
    TX_FAR _CinnabarIslandText1
    db $50

CinnabarIslandText2: ; 0x1ca9b
    TX_FAR _CinnabarIslandText2
    db $50

CinnabarIslandText3: ; 0x1caa0
    TX_FAR _CinnabarIslandText3
    db $50

CinnabarIslandText6: ; 0x1caa5
    TX_FAR _CinnabarIslandText6
    db $50

CinnabarIslandText7: ; 0x1caaa
    TX_FAR _CinnabarIslandText7
    db $50

Route1Script: ; 0x1caaf
    jp $3c3c
; 0x1cab2

Route1Texts: ; 0x1cab2
    dw Route1Text1, Route1Text2, Route1Text3

Route1Text1: ; 0x1cab8
    db $08 ; asm
    ld hl, $d7bf
    bit 0, [hl]
    set 0, [hl]
    jr nz, .asm_02840 ; 0x1cac0
    ld hl, $4ae3
    call PrintText
    ld bc, (POTION << 8) | 1
    call $3e2e
    jr nc, .asm_a630e ; 0x1cace
    ld hl, $4ae8
    jr .asm_46d43 ; 0x1cad3
.asm_a630e ; 0x1cad5
    ld hl, $4af3
    jr .asm_46d43 ; 0x1cad8
.asm_02840 ; 0x1cada
    ld hl, $4aee
.asm_46d43 ; 0x1cadd
    call PrintText
    jp $24d7

UnnamedText_1cae3: ; 0x1cae3
    TX_FAR _UnnamedText_1cae3
    db $50
; 0x1cae3 + 5 bytes

INCBIN "baserom.gbc",$1cae8,$1caee - $1cae8

UnnamedText_1caee: ; 0x1caee
    TX_FAR _UnnamedText_1caee
    db $50
; 0x1caee + 5 bytes

UnnamedText_1caf3: ; 0x1caf3
    TX_FAR _UnnamedText_1caf3
    db $50
; 0x1caf3 + 5 bytes

Route1Text2: ; 0x1caf8
    TX_FAR _Route1Text2
    db $50

Route1Text3: ; 0x1cafd
    TX_FAR _Route1Text3
    db $50

OaksLab_h: ; 0x1cb02 to 0x1cb0e (12 bytes) (bank=7) (id=40)
    db $05 ; tileset
    db OAKS_LAB_HEIGHT, OAKS_LAB_WIDTH ; dimensions (y, x)
    dw OaksLabBlocks, OaksLabTexts, OaksLabScript ; blocks, texts, scripts
    db $00 ; connections

    dw OaksLabObject ; objects

OaksLabScript: ; 0x1cb0e
    ld a, [$d74b]
    bit 6, a
    call nz, $5076
    ld a, $1
    ld [$cf0c], a
    xor a
    ld [$cc3c], a
    ld hl, $4b28
    ld a, [$d5f0]
    jp $3d97
; 0x1cb28

OaksLabScripts: ; 0x1cb28
    dw OaksLabScript0, OaksLabScript1, OaksLabScript2, OaksLabScript3, OaksLabScript4, OaksLabScript5, OaksLabScript6, OaksLabScript7

INCBIN "baserom.gbc",$1cb38,$16

OaksLabScript0: ; 0x1cb4e
    ld a, [$d74b]
    bit 7, a
    ret z
    ld a, [$cf10]
    and a
    ret nz
    ld a, $31
    ld [$cc4d], a
    ld a, $15
    call Predef
    ld hl, $d72e
    res 4, [hl]
    ld a, $1
    ld [$d5f0], a
    ret
; 0x1cb6e

OaksLabScript1: ; 0x1cb6e
    ld a, $8
    ld [$ff00+$8c], a
    ld de, $4b7e
    call $363a
    ld a, $2
    ld [$d5f0], a
    ret
; 0x1cb7e

db $40, $40, $40, $ff

OaksLabScript2: ; 0x1cb82
    ld a, [$d730]
    bit 0, a
    ret nz
    ld a, $31
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld a, $2e
    ld [$cc4d], a
    ld a, $15
    call Predef
    ld a, $3
    ld [$d5f0], a
    ret
; 0x1cba2

OaksLabScript3: ; 0x1cba2
    call Delay3
    ld hl, $ccd3
    ld de, $4bcf
    call $350c
    dec a
    ld [$cd38], a
    call $3486
    ld a, $1
    ld [$ff00+$8c], a
    xor a
    ld [$ff00+$8d], a
    call $34a6
    ld a, $5
    ld [$ff00+$8c], a
    xor a
    ld [$ff00+$8d], a
    call $34a6
    ld a, $4
    ld [$d5f0], a
    ret
; 0x1cbcf

db $40, $8, $ff

OaksLabScript4: ; 0x1cbd2
    ld a, [$cd38]
    and a
    ret nz
    ld hl, $d747
    set 0, [hl]
    ld hl, $d74b
    set 0, [hl]
    ld a, $1
    ld [$ff00+$8c], a
    ld a, $4
    ld [$ff00+$8d], a
    call $34a6
    call $2429
    ld hl, $d733
    res 1, [hl]
    call $2307
    ld a, $5
    ld [$d5f0], a
    ret
; 0x1cbfd

OaksLabScript5: ; 0x1cbfd
    ld a, $fc
    ld [$cd6b], a
    ld a, $11
    ld [$ff00+$8c], a
    call $2920
    call Delay3
    ld a, $12
    ld [$ff00+$8c], a
    call $2920
    call Delay3
    ld a, $13
    ld [$ff00+$8c], a
    call $2920
    call Delay3
    ld a, $14
    ld [$ff00+$8c], a
    call $2920
    ld hl, $d74b
    set 1, [hl]
    xor a
    ld [$cd6b], a
    ld a, $6
    ld [$d5f0], a
    ret
; 0x1cc36

OaksLabScript6: ; 0x1cc36
    ld a, [$d361]
    cp $6
    ret nz
    ld a, $5
    ld [$ff00+$8c], a
    xor a
    ld [$ff00+$8d], a
    call $34a6
    ld a, $1
    ld [$ff00+$8c], a
    xor a
    ld [$ff00+$8d], a
    call $34a6
    call $2429
    ld a, $c
    ld [$ff00+$8c], a
    call $2920
    ld a, $1
    ld [$cd38], a
    ld a, $40
    ld [$ccd3], a
    call $3486
    ld a, $8
    ld [$d528], a
    ld a, $7
    ld [$d5f0], a
    ret
; 0x1cc72

OaksLabScript7: ; 0x1cc72
    ld a, [$cd38]
    and a
    ret nz
    call Delay3
    ld a, $6
    ld [$d5f0], a
    ret
; 0x1cc80

INCBIN "baserom.gbc",$1cc80,$402

OaksLabTexts: ; 0x1d082
    dw OaksLabText1, OaksLabText2, OaksLabText3, OaksLabText4, OaksLabText5, OaksLabText6, OaksLabText7, OaksLabText8, OaksLabText9, OaksLabText10, OaksLabText11, OaksLabText12, OaksLabText13, OaksLabText14, OaksLabText15, OaksLabText16, OaksLabText17, OaksLabText18, OaksLabText19, OaksLabText20, OaksLabText21, OaksLabText22, OaksLabText23, OaksLabText24, OaksLabText25, OaksLabText26, OaksLabText27, OaksLabText28, OaksLabText29, OaksLabText30, OaksLabText31, OaksLabText32, OaksLabText33, OaksLabText34, OaksLabText35, OaksLabText36, OaksLabText37, OaksLabText38

OaksLabText28:
OaksLabText1: ; 0x1d0ce
    db $08 ; asm
    ld a, [$d74b]
    bit 0, a
    jr nz, .asm_6a7a2 ; 0x1d0d4
    ld hl, $50f3
    call PrintText
    jr .asm_ff2ed ; 0x1d0dc
.asm_6a7a2 ; 0x1d0de
    bit 2, a
    jr nz, .asm_56780 ; 0x1d0e0
    ld hl, $50f8
    call PrintText
    jr .asm_ff2ed ; 0x1d0e8
.asm_56780 ; 0x1d0ea
    ld hl, $50fd
    call PrintText
.asm_ff2ed ; 0x1d0f0
    jp $24d7

UnnamedText_1d0f3: ; 0x1d0f3
    TX_FAR _UnnamedText_1d0f3
    db $50
; 0x1d0f3 + 5 bytes

UnnamedText_1d0f8: ; 0x1d0f8
    TX_FAR _UnnamedText_1d0f8
    db $50
; 0x1d0f8 + 5 bytes

UnnamedText_1d0fd: ; 0x1d0fd
    TX_FAR _UnnamedText_1d0fd
    db $50
; 0x1d0fd + 5 bytes

OaksLabText29:
OaksLabText2: ; 0x1d102
    db $8
    ld a, $b1
    ld [$cd3d], a
    ld a, $3
    ld [$cd3e], a
    ld a, $b0
    ld b, $2
    jr asm_5e6bb ; 0x1d111 $20

OaksLabText30:
OaksLabText3: ; 0x1d113
    db $8
    ld a, $99
    ld [$cd3d], a
    ld a, $4
    ld [$cd3e], a
    ld a, $b1
    ld b, $3
    jr asm_5e6bb ; 0x1d122 $f

OaksLabText31:
OaksLabText4: ; 0x1d124
    db $8
    ld a, $b0
    ld [$cd3d], a
    ld a, $2
    ld [$cd3e], a
    ld a, $99
    ld b, $4

asm_5e6bb: ; 0x1d133
    ld [$cf91], a
    ld [$d11e], a
    ld a, b
    ld [$cf13], a
    ld a, [$d74b]
    bit 2, a
    jp nz, $522d
    bit 1, a
    jr nz, asm_9eaa4 ; 0x1d147 $e
    ld hl, OaksLabText39
    call PrintText
    jp $24d7
; 0x1d152

OaksLabText39:
    db $17, $df, $4d, $25, $50

asm_9eaa4: ; 0x1d157
    ld a, $5
    ld [$ff00+$8c], a
    ld a, $9
    ld [$ff00+$8b], a
    call $34fc
    ld [hl], $0
    ; manually fixed some disassembler issues around here
    ld a, $1
    ld [$FF8c], a
    ld a, $9
    ld [$ff00+$8b], a
    call $34fc
    ld [hl], $c
    ld hl, $d730
    set 6, [hl]
    ld a, $46
    call Predef
    ld hl, $d730
    res 6, [hl]
    call $3071
    ld c, $a
    call $3739
    ld a, [$cf13]
    cp $2
    jr z, asm_f6e3a ; 0x1d18d $6
    cp $3
    jr z, asm_2391d ; 0x1d191 $c
    jr asm_ddec1 ; 0x1d193 $14
asm_f6e3a: ; 0x1d195
    ld hl, $519a
    jr asm_b5ddf ; 0x1d198 $19
    rla ; probably a TX_FAR
    ld b, $4e
    dec h
    ld d, b
asm_2391d: ; 0x1d19f
    ld hl, $51a4
    jr asm_b5ddf ; 0x1d1a2 $f
    rla ; probably a TX_FAR
    cpl
    ld c, [hl]
    dec h
    ld d, b
asm_ddec1: ; 0x1d1a9
    ld hl, $51ae
    jr asm_b5ddf ; 0x1d1ac $5
    rla ; probably a TX_FAR
    ld d, a
    ld c, [hl]
    dec h
    ld d, b
asm_b5ddf: ; 0x1d1b3
    call PrintText
    ld a, $1
    ld [$cc3c], a
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, asm_6ccd7 ; 0x1d1c2 $5b
    ld a, [$cf91]
    ld [$d717], a
    ld [$d11e], a
    call GetMonName
    ld a, [$cf13]
    cp $2
    jr nz, asm_5b538 ; 0x1d1d5 $4
    ld a, $2b
    jr asm_03e85 ; 0x1d1d9 $a
asm_5b538: ; 0x1d1db
    cp $3
    jr nz, asm_f8b3f ; 0x1d1dd $4
    ld a, $2c
    jr asm_03e85 ; 0x1d1e1 $2
asm_f8b3f: ; 0x1d1e3
    ld a, $2d
asm_03e85: ; 0x1d1e5
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld a, $1
    ld [$cc3c], a
    ld hl, $5222
    call PrintText
    ld hl, $5227
    call PrintText
    xor a
    ld [$cc49], a
    ld a, $5
    ld [$d127], a
    ld a, [$cf91]
    ld [$d11e], a
    call AddPokemonToParty
    ld hl, $d72e
    set 3, [hl]
    ld a, $fc
    ld [$cd6b], a
    ld a, $8
    ld [$d5f0], a
asm_6ccd7: ; 0x1d21f
    jp $24d7
; 0x1d222

UnnamedText_1d222: ; 0x1d222
    TX_FAR _UnnamedText_1d222
    db $50
; 0x1d222 + 5 bytes

INCBIN "baserom.gbc",$1d227,$1d243 - $1d227

UnnamedText_1d243: ; 0x1d243
    TX_FAR _UnnamedText_1d243
    db $50
; 0x1d243 + 5 bytes

OaksLabText32:
OaksLabText5: ; 0x1d248
    db $08 ; asm
    ld a, [$d747]
    bit 6, a
    jr nz, .asm_50e81 ; 0x1d24e
    ld hl, $d2f7
    ld b, $13
    call $2b7f
    ld a, [$d11e]
    cp $2
    jr c, .asm_b28b0 ; 0x1d25d
    ld a, [$d74b]
    bit 5, a
    jr z, .asm_b28b0 ; 0x1d264
.asm_50e81 ; 0x1d266
    ld hl, $531d
    call PrintText
    ld a, $1
    ld [$cc3c], a
    ld a, $56
    call Predef
    jp $52ed
.asm_b28b0 ; 0x1d279
    ld b,POKE_BALL
    call $3493
    jr nz, .asm_17c30 ; 0x1d27e
    ld a, [$d7eb]
    bit 5, a
    jr nz, .asm_f1adc ; 0x1d285
    ld a, [$d74b]
    bit 5, a
    jr nz, .asm_333a2 ; 0x1d28c
    bit 3, a
    jr nz, .asm_76269 ; 0x1d290
    ld a, [$d72e]
    bit 3, a
    jr nz, .asm_4a5e0 ; 0x1d297
    ld hl, $52f0
    call PrintText
    jr .asm_0f042 ; 0x1d29f
.asm_4a5e0 ; 0x1d2a1
    ld hl, $52f5
    call PrintText
    jr .asm_0f042 ; 0x1d2a7
.asm_76269 ; 0x1d2a9
    ld b,OAKS_PARCEL
    call $3493
    jr nz, .asm_a8fcf ; 0x1d2ae
    ld hl, $52fa
    call PrintText
    jr .asm_0f042 ; 0x1d2b6
.asm_a8fcf ; 0x1d2b8
    ld hl, $52ff
    call PrintText
    call $500a
    ld a, $f
    ld [$d5f0], a
    jr .asm_0f042 ; 0x1d2c6
.asm_333a2 ; 0x1d2c8
    ld hl, $5309
    call PrintText
    jr .asm_0f042 ; 0x1d2ce
.asm_f1adc ; 0x1d2d0
    ld hl, $d74b
    bit 4, [hl]
    set 4, [hl]
    jr nz, .asm_17c30 ; 0x1d2d7
    ld bc, (POKE_BALL << 8) | 5
    call $3e2e
    ld hl, $530e
    call PrintText
    jr .asm_0f042 ; 0x1d2e5
.asm_17c30 ; 0x1d2e7
    ld hl, $5318
    call PrintText
.asm_0f042 ; 0x1d2ed
    jp $24d7
; 0x1d2f0

UnnamedText_1d2f0: ; 0x1d2f0
    TX_FAR _UnnamedText_1d2f0
    db $50
; 0x1d2f0 + 5 bytes

UnnamedText_1d2f5: ; 0x1d2f5
    TX_FAR _UnnamedText_1d2f5
    db $50
; 0x1d2f5 + 5 bytes

UnnamedText_1d2fa: ; 0x1d2fa
    TX_FAR _UnnamedText_1d2fa
    db $50
; 0x1d2fa + 5 bytes

INCBIN "baserom.gbc",$1d2ff,$1d304 - $1d2ff

UnnamedText_1d304: ; 0x1d304
    TX_FAR _UnnamedText_1d304
    db $50
; 0x1d304 + 5 bytes

UnnamedText_1d309: ; 0x1d309
    TX_FAR _UnnamedText_1d309
    db $50
; 0x1d309 + 5 bytes

INCBIN "baserom.gbc",$1d30e,$1d313 - $1d30e

UnnamedText_1d313: ; 0x1d313
    TX_FAR _UnnamedText_1d313
    db $50
; 0x1d313 + 5 bytes

UnnamedText_1d318: ; 0x1d318
    TX_FAR _UnnamedText_1d318
    db $50
; 0x1d318 + 5 bytes

UnnamedText_1d31d: ; 0x1d31d
    TX_FAR _UnnamedText_1d31d
    db $50
; 0x1d31d + 5 bytes

OaksLabText34:
OaksLabText33:
OaksLabText7: ; 0x1d322
OaksLabText6: ; 0x1d322
    db $08 ; asm
    ld hl, $532c
    call PrintText
    jp $24d7

UnnamedText_1d32c: ; 0x1d32c
    TX_FAR _UnnamedText_1d32c
    db $50
; 0x1d32c + 5 bytes

OaksLabText35:
OaksLabText8: ; 0x1d331
    TX_FAR _OaksLabText8
    db $50

OaksLabText36:
OaksLabText9: ; 0x1d336
    db $08 ; asm
    ld hl, $5340
    call PrintText
    jp $24d7

UnnamedText_1d340: ; 0x1d340
    TX_FAR _UnnamedText_1d340
    db $50
; 0x1d340 + 5 bytes

OaksLabText17: ; 0x1d345
    db $8
    ld hl, $534f
    call PrintText
    jp $24d7
; 0x1d34f

UnnamedText_1d34f: ; 0x1d34f
    TX_FAR _UnnamedText_1d34f
    db $50
; 0x1d34f + 5 bytes

OaksLabText18: ; 0x1d354
    db $8
    ld hl, $535e
    call PrintText
    jp $24d7
; 0x1d35e

UnnamedText_1d35e: ; 0x1d35e
    TX_FAR _UnnamedText_1d35e
    db $50
; 0x1d35e + 5 bytes

OaksLabText19: ; 0x1d363
    db $8
    ld hl, $536d
    call PrintText
    jp $24d7
; 0x1d36d

UnnamedText_1d36d: ; 0x1d36d
    TX_FAR _UnnamedText_1d36d
    db $50
; 0x1d36d + 5 bytes

OaksLabText20: ; 0x1d372
    db $8
    ld hl, $537c
    call PrintText
    jp $24d7
; 0x1d37c

UnnamedText_1d37c: ; 0x1d37c
    TX_FAR _UnnamedText_1d37c
    db $50
; 0x1d37c + 5 bytes

OaksLabText12: ; 0x1d381

INCBIN "baserom.gbc",$1d381,$5

INCBIN "baserom.gbc",$1d386,$1d38b - $1d386

UnnamedText_1d38b: ; 0x1d38b
    TX_FAR _UnnamedText_1d38b
    db $50
; 0x1d38b + 5 bytes

OaksLabText13: ; 0x1d390

INCBIN "baserom.gbc",$1d390,$5

INCBIN "baserom.gbc",$1d395,$1d39a - $1d395

UnnamedText_1d39a: ; 0x1d39a
    TX_FAR _UnnamedText_1d39a
    db $50
; 0x1d39a + 5 bytes

OaksLabText14: ; 0x1d39f
    db $8
    ld hl, $53a9
    call PrintText
    jp $24d7
; 0x1d3a9

INCBIN "baserom.gbc",$1d3a9,$1d3af - $1d3a9

OaksLabText15: ; 0x1d3af to 0x1d3b9
    db $8
    ld hl, $53b9
    call PrintText
    jp $24d7
; 0x1d3b9

UnnamedText_1d3b9: ; 0x1d3b9
    TX_FAR _UnnamedText_1d3b9
    db $50
; 0x1d3b9 + 5 bytes

UnnamedText_1d3be: ; 0x1d3be
    TX_FAR _UnnamedText_1d3be
    db $50
; 0x1d3be + 5 bytes

UnnamedText_1d3c3: ; 0x1d3c3
    TX_FAR _UnnamedText_1d3c3
    db $50
; 0x1d3c3 + 5 bytes

OaksLabText16: ; 0x1d3c8
    db $8
    ld hl, $53d2
    call PrintText
    jp $24d7
; 0x1d3d2

UnnamedText_1d3d2: ; 0x1d3d2
    TX_FAR _UnnamedText_1d3d2
    db $50
; 0x1d3d2 + 5 bytes

OaksLabText21: ; 0x1d3d7
    TX_FAR _UnnamedText_1d3d7
    db $50
; 0x1d3d7 + 5 bytes

OaksLabText22: ; 0x1d3dc
    TX_FAR _UnnamedText_1d3dc
    db $50
; 0x1d3dc + 5 bytes

OaksLabText23: ; 0x1d3e1
    TX_FAR _UnnamedText_1d3e1
    db $50
; 0x1d3e1 + 5 bytes

OaksLabText24: ; 0x1d3e6

UnnamedText_1d3e6: ; 0x1d3e6
    TX_FAR _UnnamedText_1d3e6
    db $50
; 0x1d3e6 + 5 bytes

OaksLabText25: ; 0x1d3eb

INCBIN "baserom.gbc",$1d3eb,$4
    db $11
    db $50

OaksLabText26: ; 0x1d3f1
    TX_FAR _UnnamedText_1d3f1
    db $50
; 0x1d3f1 + 5 bytes

OaksLabText27: ; 0x1d3f6
    TX_FAR _OaksLabText27
    db $50

OaksLabText38:
OaksLabText37:
OaksLabText11:
OaksLabText10: ; 0x1d3fb
    db $08 ; asm
    ld hl, $5405
    call PrintText
    jp $24d7

UnnamedText_1d405: ; 0x1d405
    TX_FAR _UnnamedText_1d405
    db $50
; 0x1d405 + 5 bytes

OaksLabObject: ; 0x1d40a (size=88)
    db $3 ; border tile

    db $2 ; warps
    db $b, $4, $2, $ff
    db $b, $5, $2, $ff

    db $0 ; signs

    db $b ; people
    db SPRITE_BLUE, $3 + 4, $4 + 4, $ff, $ff, $41, SONY1 + $C8, $1 ; trainer
    db SPRITE_BALL, $3 + 4, $6 + 4, $ff, $ff, $2 ; person
    db SPRITE_BALL, $3 + 4, $7 + 4, $ff, $ff, $3 ; person
    db SPRITE_BALL, $3 + 4, $8 + 4, $ff, $ff, $4 ; person
    db SPRITE_OAK, $2 + 4, $5 + 4, $ff, $d0, $5 ; person
    db SPRITE_BOOK_MAP_DEX, $1 + 4, $2 + 4, $ff, $ff, $6 ; person
    db SPRITE_BOOK_MAP_DEX, $1 + 4, $3 + 4, $ff, $ff, $7 ; person
    db SPRITE_OAK, $a + 4, $5 + 4, $ff, $d1, $8 ; person
    db SPRITE_GIRL, $9 + 4, $1 + 4, $fe, $1, $9 ; person
    db SPRITE_OAK_AIDE, $a + 4, $2 + 4, $ff, $ff, $a ; person
    db SPRITE_OAK_AIDE, $a + 4, $8 + 4, $ff, $ff, $b ; person

    ; warp-to
    EVENT_DISP $5, $b, $4
    EVENT_DISP $5, $b, $5

ViridianMart_h: ; 0x1d462 to 0x1d46e (12 bytes) (bank=7) (id=42)
    db $02 ; tileset
    db VIRIDIAN_MART_HEIGHT, VIRIDIAN_MART_WIDTH ; dimensions (y, x)
    dw ViridianMartBlocks, ViridianMartTexts, ViridianMartScript ; blocks, texts, scripts
    db $00 ; connections

    dw ViridianMartObject ; objects

ViridianMartScript: ; 0x1d46e
    call $547d
    call $3c3c
    ld hl, $5495
    ld a, [$d60d]
    jp $3d97
; 0x1d47d

INCBIN "baserom.gbc",$1d47d,$1e

ViridianMartScript0: ; 0x1d49b
    call $2429
    ld a, $4
    ld [$ff00+$8c], a
    call $2920
    ld hl, $ccd3
    ld de, $54bb
    call $350c
    dec a
    ld [$cd38], a
    call $3486
    ld a, $1
    ld [$d60d], a
    ret
; 0x1d4bb

INCBIN "baserom.gbc",$1d4bb,$1d4c0 - $1d4bb

ViridianMartScript1: ; 0x1d4c0
    ld a, [$cd38]
    and a
    ret nz
    call Delay3
    ld a, $5
    ld [$ff00+$8c], a
    call $2920
    ld bc, $4601
    call GiveItem
    ld hl, $d74e
    set 1, [hl]
    ld a, $2
    ld [$d60d], a
    ret
; 0x1d4e0

ViridianMartTexts: ; 0x1d4e0
    dw ViridianMartText1, ViridianMartText2, ViridianMartText3 ;, ViridianMartText4

INCBIN "baserom.gbc",$1d4e6,$a

ViridianMartText1: ; 0x1d4f0
    TX_FAR _ViridianMartText1
    db $50

UnnamedText_1d4f5: ; 0x1d4f5
    TX_FAR _UnnamedText_1d4f5
    db $50
; 0x1d4f5 + 5 bytes

INCBIN "baserom.gbc",$1d4fa,$6

ViridianMartText2: ; 0x1d500
    TX_FAR _ViridianMartText2
    db $50

ViridianMartText3: ; 0x1d505
    TX_FAR _ViridianMartText3
    db $50

ViridianMartObject: ; 0x1d50a (size=38)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $1, $ff
    db $7, $4, $1, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_MART_GUY, $5 + 4, $0 + 4, $ff, $d3, $1 ; person
    db SPRITE_BUG_CATCHER, $5 + 4, $5 + 4, $fe, $1, $2 ; person
    db SPRITE_BLACK_HAIR_BOY_1, $3 + 4, $3 + 4, $ff, $ff, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4

ViridianMartBlocks: ; 16
    INCBIN "maps/viridianmart.blk"

School_h: ; 0x1d540 to 0x1d54c (12 bytes) (bank=7) (id=43)
    db $08 ; tileset
    db VIRIDIAN_SCHOOL_HEIGHT, VIRIDIAN_SCHOOL_WIDTH ; dimensions (y, x)
    dw SchoolBlocks, SchoolTexts, SchoolScript ; blocks, texts, scripts
    db $00 ; connections

    dw SchoolObject ; objects

SchoolScript: ; 0x1d54c
    jp $3c3c
; 0x1d54f

SchoolTexts: ; 0x1d54f
    dw SchoolText1, SchoolText2

SchoolText1: ; 0x1d553
    TX_FAR _SchoolText1
    db $50

SchoolText2: ; 0x1d558
    TX_FAR _SchoolText2
    db $50

SchoolObject: ; 0x1d55d (size=32)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $2, $ff
    db $7, $3, $2, $ff

    db $0 ; signs

    db $2 ; people
    db SPRITE_BRUNETTE_GIRL, $5 + 4, $3 + 4, $ff, $d1, $1 ; person
    db SPRITE_LASS, $1 + 4, $4 + 4, $ff, $d0, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

ViridianHouse_h: ; 0x1d57d to 0x1d589 (12 bytes) (bank=7) (id=44)
    db $08 ; tileset
    db VIRIDIAN_HOUSE_HEIGHT, VIRIDIAN_HOUSE_WIDTH ; dimensions (y, x)
    dw ViridianHouseBlocks, ViridianHouseTexts, ViridianHouseScript ; blocks, texts, scripts
    db $00 ; connections

    dw ViridianHouseObject ; objects

INCBIN "baserom.gbc",$1d589,$1d58a - $1d589

ViridianHouseScript: ; 0x1d58a
    jp $3c3c
; 0x1d58d

ViridianHouseTexts: ; 0x1d58d
    dw ViridianHouseText1, ViridianHouseText2, ViridianHouseText3, ViridianHouseText4

ViridianHouseText1: ; 0x1d595
    TX_FAR _ViridianHouseText1
    db $50

ViridianHouseText2: ; 0x1d59a
    TX_FAR _ViridianHouseText2
    db $50

ViridianHouseText3: ; 0x1d59f
    db $08 ; asm
    ld hl, $55b1
    call PrintText
	ld a,SPEAROW
    call $13d0
    call $3748
    jp $24d7

UnnamedText_1d5b1: ; 0x1d5b1
    TX_FAR _UnnamedText_1d5b1
    db $50
; 0x1d5b1 + 5 bytes

ViridianHouseText4: ; 0x1d5b6
    TX_FAR _ViridianHouseText4
    db $50

ViridianHouseObject: ; 0x1d5bb (size=44)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $3, $ff
    db $7, $3, $3, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_BALDING_GUY, $3 + 4, $5 + 4, $ff, $ff, $1 ; person
    db SPRITE_LITTLE_GIRL, $4 + 4, $1 + 4, $fe, $1, $2 ; person
    db SPRITE_BIRD, $5 + 4, $5 + 4, $fe, $2, $3 ; person
    db SPRITE_CLIPBOARD, $0 + 4, $4 + 4, $ff, $ff, $4 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

PewterHouse1_h: ; 0x1d5e7 to 0x1d5f3 (12 bytes) (bank=7) (id=55)
    db $08 ; tileset
    db PEWTER_HOUSE_1_HEIGHT, PEWTER_HOUSE_1_WIDTH ; dimensions (y, x)
    dw PewterHouse1Blocks, PewterHouse1Texts, PewterHouse1Script ; blocks, texts, scripts
    db $00 ; connections

    dw PewterHouse1Object ; objects

PewterHouse1Script: ; 0x1d5f3
    jp $3c3c
; 0x1d5f6

PewterHouse1Texts: ; 0x1d5f6
    dw PewterHouse1Text1, PewterHouse1Text2, PewterHouse1Text3

PewterHouse1Text1: ; 0x1d5fc
    TX_FAR _PewterHouse1Text1
    db $08 ; asm
    ld a, $3
    call $13d0
    call $3748
    jp $24d7

PewterHouse1Text2: ; 0x1d60c
    TX_FAR _PewterHouse1Text2
    db $50

PewterHouse1Text3: ; 0x1d611
    TX_FAR _PewterHouse1Text3
    db $50

PewterHouse1Object: ; 0x1d616 (size=38)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $3, $ff
    db $7, $3, $3, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_SLOWBRO, $5 + 4, $4 + 4, $ff, $d2, $1 ; person
    db SPRITE_YOUNG_BOY, $5 + 4, $3 + 4, $ff, $d3, $2 ; person
    db SPRITE_FAT_BALD_GUY, $2 + 4, $1 + 4, $ff, $ff, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

PewterHouse2_h: ; 0x1d63c to 0x1d648 (12 bytes) (bank=7) (id=57)
    db $08 ; tileset
    db PEWTER_HOUSE_2_HEIGHT, PEWTER_HOUSE_2_WIDTH ; dimensions (y, x)
    dw PewterHouse2Blocks, PewterHouse2Texts, PewterHouse2Script ; blocks, texts, scripts
    db $00 ; connections

    dw PewterHouse2Object ; objects

PewterHouse2Script: ; 0x1d648
    jp $3c3c
; 0x1d64b

PewterHouse2Texts: ; 0x1d64b
    dw PewterHouse2Text1, PewterHouse2Text2

PewterHouse2Text1: ; 0x1d64f
    TX_FAR _PewterHouse2Text1
    db $50

PewterHouse2Text2: ; 0x1d654
    TX_FAR _PewterHouse2Text2
    db $50

PewterHouse2Object: ; 0x1d659 (size=32)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $5, $ff
    db $7, $3, $5, $ff

    db $0 ; signs

    db $2 ; people
    db SPRITE_GAMBLER, $3 + 4, $2 + 4, $ff, $d3, $1 ; person
    db SPRITE_BUG_CATCHER, $5 + 4, $4 + 4, $ff, $ff, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

CeruleanHouseTrashed_h: ; 0x1d679 to 0x1d685 (12 bytes) (bank=7) (id=62)
    db $08 ; tileset
    db TRASHED_HOUSE_HEIGHT, TRASHED_HOUSE_WIDTH ; dimensions (y, x)
    dw CeruleanHouseTrashedBlocks, CeruleanHouseTrashedTexts, CeruleanHouseTrashedScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeruleanHouseTrashedObject ; objects

CeruleanHouseTrashedScript: ; 0x1d685
    call $3c3c
    ret
; 0x1d689

CeruleanHouseTrashedTexts: ; 0x1d689
    dw CeruleanHouseTrashedText1, CeruleanHouseTrashedText2, CeruleanHouseTrashedText3

CeruleanHouseTrashedText1: ; 0x1d68f
    db $08 ; asm
    ld b, $e4
    ld a, $1c
    call Predef
    and b
    jr z, .asm_f8734 ; 0x1d698
    ld hl, $56b0
    call PrintText
    jr .asm_8dfe9 ; 0x1d6a0
.asm_f8734 ; 0x1d6a2
    ld hl, $56ab
    call PrintText
.asm_8dfe9 ; 0x1d6a8
    jp $24d7

UnnamedText_1d6ab: ; 0x1d6ab
    TX_FAR _UnnamedText_1d6ab
    db $50
; 0x1d6ab + 5 bytes

UnnamedText_1d6b0: ; 0x1d6b0
    TX_FAR _UnnamedText_1d6b0
    db $50
; 0x1d6b0 + 5 bytes

CeruleanHouseTrashedText2: ; 0x1d6b5
    TX_FAR _CeruleanHouseTrashedText2
    db $50

CeruleanHouseTrashedText3: ; 0x1d6ba
    TX_FAR _CeruleanHouseTrashedText3
    db $50

CeruleanHouseTrashedObject: ; 0x1d6bf (size=43)
    db $a ; border tile

    db $3 ; warps
    db $7, $2, $0, $ff
    db $7, $3, $0, $ff
    db $0, $3, $7, $ff

    db $1 ; signs
    db $0, $3, $3 ; CeruleanHouseTrashedText3

    db $2 ; people
    db SPRITE_FISHER, $1 + 4, $2 + 4, $ff, $d0, $1 ; person
    db SPRITE_GIRL, $6 + 4, $5 + 4, $fe, $2, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $0, $3

CeruleanHouse2_h: ; 0x1d6ea to 0x1d6f6 (12 bytes) (bank=7) (id=63)
    db $08 ; tileset
    db CERULEAN_HOUSE_HEIGHT, CERULEAN_HOUSE_WIDTH ; dimensions (y, x)
    dw CeruleanHouse2Blocks, CeruleanHouse2Texts, CeruleanHouse2Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeruleanHouse2Object ; objects

CeruleanHouse2Script: ; 0x1d6f6
    jp $3c3c
; 0x1d6f9

CeruleanHouse2Texts: ; 0x1d6f9
    dw CeruleanHouse2Text1, CeruleanHouse2Text2

CeruleanHouse2Text1: ; 0x1d6fd
    TX_FAR _CeruleanHouse2Text1
    db $50

CeruleanHouse2Text2: ; 0x1d702
    db $08 ; asm
    ld a, $6
    ld [W_WHICHTRADE], a
    ld a, $54
    call Predef
    jp $24d7

CeruleanHouse2Object: ; 0x1d710 (size=32)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $1, $ff
    db $7, $3, $1, $ff

    db $0 ; signs

    db $2 ; people
    db SPRITE_OLD_MEDIUM_WOMAN, $4 + 4, $5 + 4, $ff, $d2, $1 ; person
    db SPRITE_GAMBLER, $2 + 4, $1 + 4, $ff, $ff, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

BikeShop_h: ; 0x1d730 to 0x1d73c (12 bytes) (bank=7) (id=66)
    db $15 ; tileset
    db BIKE_SHOP_HEIGHT, BIKE_SHOP_WIDTH ; dimensions (y, x)
    dw BikeShopBlocks, BikeShopTexts, BikeShopScript ; blocks, texts, scripts
    db $00 ; connections

    dw BikeShopObject ; objects

BikeShopScript: ; 0x1d73c
    jp $3c3c
; 0x1d73f

BikeShopTexts: ; 0x1d73f
    dw BikeShopText1, BikeShopText2, BikeShopText3

BikeShopText1: ; 0x1d745
    db $08 ; asm
    ld a, [$d75f]
    bit 0, a
    jr z, .asm_260d4 ; 0x1d74b
    ld hl, $582f
    call PrintText
    jp $57f5
.asm_260d4 ; 0x1d756
	ld b,BIKE_VOUCHER
    call $3493
    jr z, .asm_41190 ; 0x1d75b
    ld hl, $581f
    call PrintText
    ld bc,(BICYCLE << 8) | 1
    call $3e2e
    jr nc, .asm_d0d90 ; 0x1d769
    ld a, $2d
    ldh [$db], a
    ld b, $5 ; BANK(MyFunction)
    ld hl, $7f37 ; MyFunction
    call Bankswitch
    ld hl, $d75f
    set 0, [hl]
    ld hl, $5824
    call PrintText
    jr .asm_99ef2 ; 0x1d782
.asm_d0d90 ; 0x1d784
    ld hl, $5834
    call PrintText
    jr .asm_99ef2 ; 0x1d78a
.asm_41190 ; 0x1d78c
    ld hl, $5810
    call PrintText
    xor a
    ld [$cc26], a
    ld [$cc2a], a
    ld a, $3
    ld [$cc29], a
    ld a, $1
    ld [$cc28], a
    ld a, $2
    ld [$cc24], a
    ld a, $1
    ld [$cc25], a
    ld hl, $d730
    set 6, [hl]
    ld hl, $c3a0
    ld b, $4
    ld c, $f
    call $1922
    call $2429
    ld hl, $c3ca
    ld de, $57f8
    call $1955
    ld hl, $c3e4
    ld de, $5807
    call $1955
    ld hl, $5815
    call PrintText
    call $3abe
    bit 1, a
    jr nz, .asm_b7579 ; 0x1d7dc
    ld hl, $d730
    res 6, [hl]
    ld a, [$cc26]
    and a
    jr nz, .asm_b7579 ; 0x1d7e7
    ld hl, $581a
    call PrintText
.asm_b7579 ; 0x1d7ef
    ld hl, $582a
    call PrintText
.asm_99ef2 ; 0x1d7f5
    jp $24d7

INCBIN "baserom.gbc",$1d7f8,$1d810 - $1d7f8

UnnamedText_1d810: ; 0x1d810
    TX_FAR _UnnamedText_1d810
    db $50
; 0x1d810 + 5 bytes

UnnamedText_1d815: ; 0x1d815
    TX_FAR _UnnamedText_1d815
    db $50
; 0x1d815 + 5 bytes

UnnamedText_1d81a: ; 0x1d81a
    TX_FAR _UnnamedText_1d81a
    db $50
; 0x1d81a + 5 bytes

UnnamedText_1d81f: ; 0x1d81f
    TX_FAR _UnnamedText_1d81f
    db $50
; 0x1d81f + 5 bytes

INCBIN "baserom.gbc",$1d824,$1d82a - $1d824

UnnamedText_1d82a: ; 0x1d82a
    TX_FAR _UnnamedText_1d82a
    db $50
; 0x1d82a + 5 bytes

UnnamedText_1d82f: ; 0x1d82f
    TX_FAR _UnnamedText_1d82f
    db $50
; 0x1d82f + 5 bytes

UnnamedText_1d834: ; 0x1d834
    TX_FAR _UnnamedText_1d834
    db $50
; 0x1d834 + 5 bytes

BikeShopText2: ; 0x1d839
    db $08 ; asm
    ld hl, $5843
    call PrintText
    jp $24d7

UnnamedText_1d843: ; 0x1d843
    TX_FAR _UnnamedText_1d843
    db $50
; 0x1d843 + 5 bytes

BikeShopText3: ; 0x1d848
    db $08 ; asm
    ld a, [$d75f]
    bit 0, a
    ld hl, $5861
    jr nz, .asm_34d2d ; 0x1d851
    ld hl, $585c
.asm_34d2d ; 0x1d856
    call PrintText
    jp $24d7

UnnamedText_1d85c: ; 0x1d85c
    TX_FAR _UnnamedText_1d85c
    db $50
; 0x1d85c + 5 bytes

UnnamedText_1d861: ; 0x1d861
    TX_FAR _UnnamedText_1d861
    db $50
; 0x1d861 + 5 bytes

BikeShopObject: ; 0x1d866 (size=38)
    db $e ; border tile

    db $2 ; warps
    db $7, $2, $4, $ff
    db $7, $3, $4, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_BIKE_SHOP_GUY, $2 + 4, $6 + 4, $ff, $ff, $1 ; person
    db SPRITE_MOM_GEISHA, $6 + 4, $5 + 4, $fe, $1, $2 ; person
    db SPRITE_BUG_CATCHER, $3 + 4, $1 + 4, $ff, $d1, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

BikeShopBlocks: ; 16
    INCBIN "maps/bikeshop.blk"

LavenderHouse1_h: ; 0x1d89c to 0x1d8a8 (12 bytes) (bank=7) (id=149)
    db $08 ; tileset
    db LAVENDER_HOUSE_1_HEIGHT, LAVENDER_HOUSE_1_WIDTH ; dimensions (y, x)
    dw LavenderHouse1Blocks, LavenderHouse1Texts, LavenderHouse1Script ; blocks, texts, scripts
    db $00 ; connections

    dw LavenderHouse1Object ; objects

LavenderHouse1Script: ; 0x1d8a8
    call $3c3c
    ret
; 0x1d8ac

LavenderHouse1Texts: ; 0x1d8ac
    dw LavenderHouse1Text1, LavenderHouse1Text2, LavenderHouse1Text3, LavenderHouse1Text4, LavenderHouse1Text5, LavenderHouse1Text6

LavenderHouse1Text1: ; 0x1d8b8
    db $08 ; asm
    ld a, [$d7e0]
    bit 7, a
    jr nz, .asm_72e5d ; 0x1d8be
    ld hl, $58d1
    call PrintText
    jr .asm_6957f ; 0x1d8c6
.asm_72e5d ; 0x1d8c8
    ld hl, $58d6
    call PrintText
.asm_6957f ; 0x1d8ce
    jp $24d7

UnnamedText_1d8d1: ; 0x1d8d1
    TX_FAR _UnnamedText_1d8d1
    db $50
; 0x1d8d1 + 5 bytes

UnnamedText_1d8d6: ; 0x1d8d6
    TX_FAR _UnnamedText_1d8d6
    db $50
; 0x1d8d6 + 5 bytes

LavenderHouse1Text2: ; 0x1d8db
    db $08 ; asm
    ld a, [$d7e0]
    bit 7, a
    jr nz, .asm_06470 ; 0x1d8e1
    ld hl, $58f4
    call PrintText
    jr .asm_3d208 ; 0x1d8e9
.asm_06470 ; 0x1d8eb
    ld hl, $58f9
    call PrintText
.asm_3d208 ; 0x1d8f1
    jp $24d7

UnnamedText_1d8f4: ; 0x1d8f4
    TX_FAR _UnnamedText_1d8f4
    db $50
; 0x1d8f4 + 5 bytes

UnnamedText_1d8f9: ; 0x1d8f9
    TX_FAR _UnnamedText_1d8f9
    db $50
; 0x1d8f9 + 5 bytes

LavenderHouse1Text3: ; 0x1d8fe
    TX_FAR _LavenderHouse1Text3
    db $8
    ld a, $2f
    call $13d0
    jp $24d7

LavenderHouse1Text4: ; 0x1d90b
    TX_FAR _LavenderHouse1Text4
    db $8
    ld a, $a7
    call $13d0
    jp $24d7
; 0x1d918

LavenderHouse1Text5: ; 0x1d918
    db $08 ; asm
    ld a, [$d76c]
    bit 0, a
    jr nz, .asm_15ac2 ; 0x1d91e
    ld hl, $594c
    call PrintText
    ld bc, (POKE_FLUTE << 8) | 1
    call $3e2e
    jr nc, .asm_5ce36 ; 0x1d92c
    ld hl, $5951
    call PrintText
    ld hl, $d76c
    set 0, [hl]
    jr .asm_da749 ; 0x1d939
.asm_5ce36 ; 0x1d93b
    ld hl, $595b
    call PrintText
    jr .asm_da749 ; 0x1d941
.asm_15ac2 ; 0x1d943
    ld hl, $5960
    call PrintText
.asm_da749 ; 0x1d949
    jp $24d7

UnnamedText_1d94c: ; 0x1d94c
    TX_FAR _UnnamedText_1d94c
    db $50
; 0x1d94c + 5 bytes

INCBIN "baserom.gbc",$1d951,$1d956 - $1d951

UnnamedText_1d956: ; 0x1d956
    TX_FAR _UnnamedText_1d956
    db $50
; 0x1d956 + 5 bytes

UnnamedText_1d95b: ; 0x1d95b
    TX_FAR _UnnamedText_1d95b
    db $50
; 0x1d95b + 5 bytes

UnnamedText_1d960: ; 0x1d960
    TX_FAR _UnnamedText_1d960
    db $50
; 0x1d960 + 5 bytes

LavenderHouse1Text6: ; 0x1d965
    TX_FAR _LavenderHouse1Text6
    db $50

LavenderHouse1Object: ; 0x1d96a (size=56)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $2, $ff
    db $7, $3, $2, $ff

    db $0 ; signs

    db $6 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $5 + 4, $3 + 4, $ff, $ff, $1 ; person
    db SPRITE_LITTLE_GIRL, $3 + 4, $6 + 4, $ff, $d0, $2 ; person
    db SPRITE_SLOWBRO, $4 + 4, $6 + 4, $ff, $d1, $3 ; person
    db SPRITE_SLOWBRO, $3 + 4, $1 + 4, $ff, $ff, $4 ; person
    db SPRITE_MR_FUJI, $1 + 4, $3 + 4, $ff, $ff, $5 ; person
    db SPRITE_BOOK_MAP_DEX, $3 + 4, $3 + 4, $ff, $ff, $6 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

LavenderHouse2_h: ; 0x1d9a2 to 0x1d9ae (12 bytes) (bank=7) (id=151)
    db $08 ; tileset
    db LAVENDER_HOUSE_2_HEIGHT, LAVENDER_HOUSE_2_WIDTH ; dimensions (y, x)
    dw LavenderHouse2Blocks, LavenderHouse2Texts, LavenderHouse2Script ; blocks, texts, scripts
    db $00 ; connections

    dw LavenderHouse2Object ; objects

LavenderHouse2Script: ; 0x1d9ae
    call $3c3c
    ret
; 0x1d9b2

LavenderHouse2Texts: ; 0x1d9b2
    dw LavenderHouse2Text1, LavenderHouse2Text2

LavenderHouse2Text1: ; 0x1d9b6
    TX_FAR _LavenderHouse2Text1
    db $8
    ld a, $11
    call $13d0
    jp $24d7
; 0x1d9c3

LavenderHouse2Text2: ; 0x1d9c3
    db $08 ; asm
    ld a, [$d7e0]
    bit 7, a
    jr nz, .asm_65711 ; 0x1d9c9
    ld hl, $59dc
    call PrintText
    jr .asm_64be1 ; 0x1d9d1
.asm_65711 ; 0x1d9d3
    ld hl, $59e1
    call PrintText
.asm_64be1 ; 0x1d9d9
    jp $24d7

UnnamedText_1d9dc: ; 0x1d9dc
    TX_FAR _UnnamedText_1d9dc
    db $50
; 0x1d9dc + 5 bytes

UnnamedText_1d9e1: ; 0x1d9e1
    TX_FAR _UnnamedText_1d9e1
    db $50
; 0x1d9e1 + 5 bytes

LavenderHouse2Object: ; 0x1d9e6 (size=32)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $4, $ff
    db $7, $3, $4, $ff

    db $0 ; signs

    db $2 ; people
    db SPRITE_SLOWBRO, $5 + 4, $3 + 4, $ff, $d1, $1 ; person
    db SPRITE_BRUNETTE_GIRL, $4 + 4, $2 + 4, $ff, $d3, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

NameRater_h: ; 0x1da06 to 0x1da12 (12 bytes) (bank=7) (id=229)
    db $08 ; tileset
    db NAME_RATERS_HOUSE_HEIGHT, NAME_RATERS_HOUSE_WIDTH ; dimensions (y, x)
    dw NameRaterBlocks, $5a54, NameRaterScript ; blocks, texts, scripts
    db $00 ; connections

    dw NameRaterObject ; objects

NameRaterScript: ; 0x1da12
    jp $3c3c
; 0x1da15

INCBIN "baserom.gbc",$1da15,$41

NameRaterText1: ; 0x1da56
    db $8
    call $36f4
    ld hl, $5ab3
    call $5a15
    jr nz, .asm_1daae ; 0x1da60 $4c
    ld hl, $5ab8
    call PrintText
    xor a
    ld [$d07d], a
    ld [$cfcb], a
    ld [$cc35], a
    call $13fc
    push af
    call $3dd4
    call $3dbe
    call $20ba
    pop af
    jr c, .asm_1daae ; 0x1da80 $2c
    call $15b4
    call $5a20
    ld hl, $5ad1
    jr c, .asm_1daa8 ; 0x1da8b $1b
    ld hl, $5abd
    call $5a15
    jr nz, .asm_1daae ; 0x1da93 $19
    ld hl, $5ac2
    call PrintText
    ld b, $1
    ld hl, $655c
    call Bankswitch
    jr c, .asm_1daae ; 0x1daa3 $9
    ld hl, $5ac7
.asm_1daa8
    call PrintText
    jp $24d7
.asm_1daae
    ld hl, $5acc
    jr .asm_1daa8 ; 0x1dab1 $f5
; 0x1dab3

UnnamedText_1dab3: ; 0x1dab3
    TX_FAR _UnnamedText_1dab3
    db $50
; 0x1dab3 + 5 bytes

UnnamedText_1dab8: ; 0x1dab8
    TX_FAR _UnnamedText_1dab8
    db $50
; 0x1dab8 + 5 bytes

UnnamedText_1dabd: ; 0x1dabd
    TX_FAR _UnnamedText_1dabd
    db $50
; 0x1dabd + 5 bytes

UnnamedText_1dac2: ; 0x1dac2
    TX_FAR _UnnamedText_1dac2
    db $50
; 0x1dac2 + 5 bytes

UnnamedText_1dac7: ; 0x1dac7
    TX_FAR _UnnamedText_1dac7
    db $50
; 0x1dac7 + 5 bytes

UnnamedText_1dacc: ; 0x1dacc
    TX_FAR _UnnamedText_1dacc
    db $50
; 0x1dacc + 5 bytes

UnnamedText_1dad1: ; 0x1dad1
    TX_FAR _UnnamedText_1dad1
    db $50
; 0x1dad1 + 5 bytes

NameRaterObject: ; 0x1dad6 (size=26)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $5, $ff
    db $7, $3, $5, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_MR_MASTERBALL, $3 + 4, $5 + 4, $ff, $d2, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

VermilionHouse1_h: ; 0x1daf0 to 0x1dafc (12 bytes) (bank=7) (id=93)
    db $08 ; tileset
    db VERMILION_HOUSE_1_HEIGHT, VERMILION_HOUSE_1_WIDTH ; dimensions (y, x)
    dw VermilionHouse1Blocks, VermilionHouse1Texts, VermilionHouse1Script ; blocks, texts, scripts
    db $00 ; connections

    dw VermilionHouse1Object ; objects

VermilionHouse1Script: ; 0x1dafc
    call $3c3c
    ret
; 0x1db00

VermilionHouse1Texts: ; 0x1db00
    dw VermilionHouse1Text1, VermilionHouse1Text2, VermilionHouse1Text3

VermilionHouse1Text1: ; 0x1db06
    TX_FAR _VermilionHouse1Text1
    db $50

VermilionHouse1Text2: ; 0x1db0b
    TX_FAR _VermilionHouse1Text2
    db $08 ; asm
    ld a, $24
    call $13d0
    call $3748
    jp $24d7

VermilionHouse1Text3: ; 0x1db1b
    TX_FAR _VermilionHouse1Text3
    db $50

INCBIN "baserom.gbc", $1db1b + 5, $1db20 - ($1db1b + 5)

VermilionHouse1Object: ; 0x1db20 (size=38)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $4, $ff
    db $7, $3, $4, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_BUG_CATCHER, $3 + 4, $5 + 4, $ff, $d2, $1 ; person
    db SPRITE_BIRD, $5 + 4, $3 + 4, $fe, $2, $2 ; person
    db SPRITE_PAPER_SHEET, $3 + 4, $4 + 4, $ff, $ff, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

VermilionDock_h: ; 0x1db46 to 0x1db52 (12 bytes) (bank=7) (id=94)
    db $0e ; tileset
    db VERMILION_DOCK_HEIGHT, VERMILION_DOCK_WIDTH ; dimensions (y, x)
    dw VermilionDockBlocks, VermilionDockTexts, VermilionDockScript ; blocks, texts, scripts
    db $00 ; connections

    dw VermilionDockObject ; objects

VermilionDockScript: ; 0x1db52
    call $3c3c
    ld hl, $d803
    bit 4, [hl]
    jr nz, .asm_1db8d ; 0x1db5a $31
    bit 0, [hl]
    ret z
    ld a, [$d42f]
    cp $1
    ret nz
    bit 2, [hl]
    jp z, $5b9b
    set 4, [hl]
    call Delay3
    ld hl, $d730
    set 7, [hl]
    ld hl, $ccd3
    ld a, $40
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld a, $3
    ld [$cd38], a
    xor a
    ld [$c206], a
    ld [$cd3b], a
    dec a
    ld [$cd6b], a
    ret
.asm_1db8d
    bit 5, [hl]
    ret nz
    ld a, [$cd38]
    and a
    ret nz
    ld [$cd6b], a
    set 5, [hl]
    ret
; 0x1db9b

INCBIN "baserom.gbc",$1db9b,$1dcbf - $1db9b

VermilionDockTexts: ; 0x1dcbf
INCBIN "baserom.gbc",$1dcbf,$1dcc1 - $1dcbf

UnnamedText_1dcc1: ; 0x1dcc1
    TX_FAR _UnnamedText_1dcc1
    db $50
; 0x1dcc1 + 5 bytes

VermilionDockObject: ; 0x1dcc6 (size=20)
    db $f ; border tile

    db $2 ; warps
    db $0, $e, $5, $ff
    db $2, $e, $1, SS_ANNE_1

    db $0 ; signs

    db $0 ; people

    ; warp-to
    EVENT_DISP $e, $0, $e
    EVENT_DISP $e, $2, $e ; SS_ANNE_1

VermilionDockBlocks: ; 84
    INCBIN "maps/vermiliondock.blk"

CeladonMansion5_h: ; 0x1dd2e to 0x1dd3a (12 bytes) (bank=7) (id=132)
    db $08 ; tileset
    db CELADON_MANSION_5_HEIGHT, CELADON_MANSION_5_WIDTH ; dimensions (y, x)
    dw CeladonMansion5Blocks, CeladonMansion5Texts, CeladonMansion5Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMansion5Object ; objects

CeladonMansion5Script: ; 0x1dd3a
    jp $3c3c
; 0x1dd3d

CeladonMansion5Texts: ; 0x1dd3d
    dw CeladonMansion5Text1, CeladonMansion5Text2

CeladonMansion5Text1: ; 0x1dd41
    TX_FAR _CeladonMansion5Text1
    db $50

CeladonMansion5Text2: ; 0x1dd46
    db $08 ; asm
	ld bc,(EEVEE << 8) | 25
    call GivePokemon
    jr nc, .asm_24365 ; 0x1dd4d
    ld a, $45
    ld [$cc4d], a
    ld a, $11
    call Predef
.asm_24365 ; 0x1dd59
    jp $24d7

CeladonMansion5Object: ; 0x1dd5c (size=32)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $2, CELADON_MANSION_4
    db $7, $3, $2, CELADON_MANSION_4

    db $0 ; signs

    db $2 ; people
    db SPRITE_HIKER, $2 + 4, $2 + 4, $ff, $d0, $1 ; person
    db SPRITE_BALL, $3 + 4, $4 + 4, $ff, $ff, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2 ; CELADON_MANSION_4
    EVENT_DISP $4, $7, $3 ; CELADON_MANSION_4

FuchsiaMart_h: ; 0x1dd7c to 0x1dd88 (12 bytes) (bank=7) (id=152)
    db $02 ; tileset
    db FUCHSIA_MART_HEIGHT, FUCHSIA_MART_WIDTH ; dimensions (y, x)
    dw FuchsiaMartBlocks, FuchsiaMartTexts, FuchsiaMartScript ; blocks, texts, scripts
    db $00 ; connections

    dw FuchsiaMartObject ; objects

FuchsiaMartScript: ; 0x1dd88
    jp $3c3c
; 0x1dd8b

FuchsiaMartTexts: ; 0x1dd8b
    dw FuchsiaMartText1, FuchsiaMartText2, FuchsiaMartText3

FuchsiaMartText2: ; 0x1dd91
    TX_FAR _FuchsiaMartText2
    db $50

FuchsiaMartText3: ; 0x1dd96
    TX_FAR _FuchsiaMartText3
    db $50

FuchsiaMartObject: ; 0x1dd9b (size=38)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $0, $ff
    db $7, $4, $0, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_MART_GUY, $5 + 4, $0 + 4, $ff, $d3, $1 ; person
    db SPRITE_FAT_BALD_GUY, $2 + 4, $4 + 4, $ff, $ff, $2 ; person
    db SPRITE_LASS, $5 + 4, $6 + 4, $fe, $1, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4

FuchsiaMartBlocks: ; 16
    INCBIN "maps/fuchsiamart.blk"

SaffronHouse1_h: ; 0x1ddd1 to 0x1dddd (12 bytes) (bank=7) (id=179)
    db $08 ; tileset
    db SAFFRON_HOUSE_1_HEIGHT, SAFFRON_HOUSE_1_WIDTH ; dimensions (y, x)
    dw SaffronHouse1Blocks, SaffronHouse1Texts, SaffronHouse1Script ; blocks, texts, scripts
    db $00 ; connections

    dw SaffronHouse1Object ; objects

SaffronHouse1Script: ; 0x1dddd
    jp $3c3c
; 0x1dde0

SaffronHouse1Texts: ; 0x1dde0
    dw SaffronHouse1Text1, SaffronHouse1Text2, SaffronHouse1Text3, SaffronHouse1Text4

SaffronHouse1Text1: ; 0x1dde8
    TX_FAR _SaffronHouse1Text1
    db $50

SaffronHouse1Text2: ; 0x1dded
    TX_FAR _SaffronHouse1Text2
    db $8
    ld a, $24
    call $13d0
    jp $24d7
; 0x1ddfa

SaffronHouse1Text3: ; 0x1ddfa
    TX_FAR _SaffronHouse1Text3
    db $50

SaffronHouse1Text4: ; 0x1ddff
    TX_FAR _SaffronHouse1Text4
    db $50

SaffronHouse1Object: ; 0x1de04 (size=44)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $3, $ff
    db $7, $3, $3, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_BRUNETTE_GIRL, $3 + 4, $2 + 4, $ff, $d3, $1 ; person
    db SPRITE_BIRD, $4 + 4, $0 + 4, $fe, $1, $2 ; person
    db SPRITE_BUG_CATCHER, $1 + 4, $4 + 4, $ff, $d0, $3 ; person
    db SPRITE_PAPER_SHEET, $3 + 4, $3 + 4, $ff, $ff, $4 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

SaffronHouse2_h: ; 0x1de30 to 0x1de3c (12 bytes) (bank=7) (id=183)
    db $08 ; tileset
    db SAFFRON_HOUSE_2_HEIGHT, SAFFRON_HOUSE_2_WIDTH ; dimensions (y, x)
    dw SaffronHouse2Blocks, SaffronHouse2Texts, SaffronHouse2Script ; blocks, texts, scripts
    db $00 ; connections

    dw SaffronHouse2Object ; objects

SaffronHouse2Script: ; 0x1de3c
    jp $3c3c
; 0x1de3f

SaffronHouse2Texts: ; 0x1de3f
    dw SaffronHouse2Text1

SaffronHouse2Text1: ; 0x1de41
    db $08 ; asm
    ld a, [$d7bd]
    bit 0, a
    jr nz, .asm_9e72b ; 0x1de47
    ld hl, $5e75
    call PrintText
    ld bc,(TM_29 << 8) | 1
    call $3e2e
    jr nc, .asm_4b1da ; 0x1de55
    ld hl, $5e7a
    call PrintText
    ld hl, $d7bd
    set 0, [hl]
    jr .asm_fe4e1 ; 0x1de62
.asm_4b1da ; 0x1de64
    ld hl, $5e85
    call PrintText
    jr .asm_fe4e1 ; 0x1de6a
.asm_9e72b ; 0x1de6c
    ld hl, $5e80
    call PrintText
.asm_fe4e1 ; 0x1de72
    jp $24d7

UnnamedText_1de75: ; 0x1de75
    TX_FAR _UnnamedText_1de75
    db $50
; 0x1de75 + 5 bytes

INCBIN "baserom.gbc",$1de7a,$1de80 - $1de7a

UnnamedText_1de80: ; 0x1de80
    TX_FAR _UnnamedText_1de80
    db $50
; 0x1de80 + 5 bytes

UnnamedText_1de85: ; 0x1de85
    TX_FAR _UnnamedText_1de85
    db $50
; 0x1de85 + 5 bytes

SaffronHouse2Object: ; 0x1de8a (size=26)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $7, $ff
    db $7, $3, $7, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_FISHER, $3 + 4, $5 + 4, $ff, $d2, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

DiglettsCaveRoute2_h: ; 0x1dea4 to 0x1deb0 (12 bytes) (bank=7) (id=46)
    db $11 ; tileset
    db DIGLETTS_CAVE_EXIT_HEIGHT, DIGLETTS_CAVE_EXIT_WIDTH ; dimensions (y, x)
    dw DiglettsCaveRoute2Blocks, DiglettsCaveRoute2Texts, DiglettsCaveRoute2Script ; blocks, texts, scripts
    db $00 ; connections

    dw DiglettsCaveRoute2Object ; objects

DiglettsCaveRoute2Script: ; 0x1deb0
    ld a, $d
    ld [$d365], a
    jp $3c3c
; 0x1deb8

DiglettsCaveRoute2Texts: ; 0x1deb8
    dw DiglettsCaveRoute2Text1

DiglettsCaveRoute2Text1: ; 0x1deba
    TX_FAR _DiglettsCaveRoute2Text1
    db $50

DiglettsCaveRoute2Object: ; 0x1debf (size=34)
    db $7d ; border tile

    db $3 ; warps
    db $7, $2, $0, $ff
    db $7, $3, $0, $ff
    db $4, $4, $0, DIGLETTS_CAVE

    db $0 ; signs

    db $1 ; people
    db SPRITE_FISHER, $3 + 4, $3 + 4, $ff, $ff, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $4, $4 ; DIGLETTS_CAVE

Route2House_h: ; 0x1dee1 to 0x1deed (12 bytes) (bank=7) (id=48)
    db $08 ; tileset
    db ROUTE_2_HOUSE_HEIGHT, ROUTE_2_HOUSE_WIDTH ; dimensions (y, x)
    dw Route2HouseBlocks, Route2HouseTexts, Route2HouseScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route2HouseObject ; objects

Route2HouseScript: ; 0x1deed
    jp $3c3c
; 0x1def0

Route2HouseTexts: ; 0x1def0
    dw Route2HouseText1, Route2HouseText2

Route2HouseText1: ; 0x1def4
    TX_FAR _Route2HouseText1
    db $50

Route2HouseText2: ; 0x1def9
    db $08 ; asm
    ld a, $1
    ld [W_WHICHTRADE], a
    ld a, $54
    call Predef
    jp $24d7

Route2HouseObject: ; 0x1df07 (size=32)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $2, $ff
    db $7, $3, $2, $ff

    db $0 ; signs

    db $2 ; people
    db SPRITE_OAK_AIDE, $4 + 4, $2 + 4, $ff, $d3, $1 ; person
    db SPRITE_GAMEBOY_KID_COPY, $1 + 4, $4 + 4, $ff, $d0, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

Route5Gate_h: ; 0x1df27 to 0x1df33 (12 bytes) (bank=7) (id=70)
    db $0c ; tileset
    db ROUTE_5_GATE_HEIGHT, ROUTE_5_GATE_WIDTH ; dimensions (y, x)
    dw Route5GateBlocks, Route5GateTexts, Route5GateScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route5GateObject ; objects

Route5GateScript: ; 0x1df33
    call $3c3c
    ld a, [$d662]
    ld hl, $5f3f
    jp $3d97
; 0x1df3f

Route5GateScripts: ; 0x1df3f
    dw Route5GateScript0

INCBIN "baserom.gbc",$1df41,$f

Route5GateScript0: ; 0x1df50
    ld a, [$d728]
    bit 6, a
    ret nz
    ld hl, $5f8f
    call $34bf
    ret nc
    ld a, $2
    ld [$d528], a
    xor a
    ld [$ff00+$b4], a
    ld b, $16
    ld hl, $659f
    call Bankswitch
    ld a, [$ff00+$db]
    and a
    jr nz, .asm_1df82 ; 0x1df70 $10
    ld a, $2
    ld [$ff00+$8c], a
    call $2920
    call $5f43
    ld a, $1
    ld [$d662], a
    ret
.asm_1df82
    ld a, $3
    ld [$ff00+$8c], a
    call $2920
    ld hl, $d728
    set 6, [hl]
    ret
; 0x1df8f

INCBIN "baserom.gbc",$1df8f,$15

Route5GateTexts: ; 0x1dfa4
    dw Route5GateText1, Route5GateText2, Route5GateText3

Route8GateText1:
Route7GateText1:
Route6GateText1:
Route5GateText1: ; 0x1dfaa
    db $8
    ld a, [$d728]
    bit 6, a
    jr nz, .asm_88856 ; 0x1dfb0 $2c
    ld b, $16
    ld hl, $659f
    call Bankswitch
    ld a, [$ff00+$db]
    and a
    jr nz, .asm_768a2 ; 0x1dfbd $11
    ld hl, $5fe7
    call PrintText
    call $5f43
    ld a, $1
    ld [$d662], a
    jp $24d7
.asm_768a2 ; 0x1dfd0
    ld hl, $5fec
    call PrintText
    ld hl, $d728
    set 6, [hl]
    jp $24d7
.asm_88856 ; 0x1dfde
    ld hl, $5ff6
    call PrintText
    jp $24d7
; 0x1dfe7

Route8GateText2:
Route7GateText2:
Route6GateText2:
Route5GateText2: ; 0x1dfe7

UnnamedText_1dfe7: ; 0x1dfe7
    TX_FAR _UnnamedText_1dfe7
    db $50
; 0x1dfe7 + 5 bytes

Route8GateText3:
Route7GateText3:
Route6GateText3:
Route5GateText3: ; 0x1dfec

INCBIN "baserom.gbc",$1dfec,$5

INCBIN "baserom.gbc",$1dff1,$1dff6 - $1dff1

UnnamedText_1dff6: ; 0x1dff6
    TX_FAR _UnnamedText_1dff6
    db $50
; 0x1dff6 + 5 bytes

Route5GateObject: ; 0x1dffb (size=42)
    db $a ; border tile

    db $4 ; warps
    db $5, $3, $2, $ff
    db $5, $4, $2, $ff
    db $0, $3, $1, $ff
    db $0, $4, $0, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_GUARD, $3 + 4, $1 + 4, $ff, $d3, $1 ; person

    ; warp-to
    EVENT_DISP $4, $5, $3
    EVENT_DISP $4, $5, $4
    EVENT_DISP $4, $0, $3
    EVENT_DISP $4, $0, $4

Route5GateBlocks: ; 12
    INCBIN "maps/route5gate.blk"

Route6Gate_h: ; 0x1e031 to 0x1e03d (12 bytes) (bank=7) (id=73)
    db $0c ; tileset
    db ROUTE_6_GATE_HEIGHT, ROUTE_6_GATE_WIDTH ; dimensions (y, x)
    dw Route6GateBlocks, Route6GateTexts, Route6GateScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route6GateObject ; objects

Route6GateScript: ; 0x1e03d
    call $3c3c
    ld hl, $604a
    ld a, [$d636]
    call $3d97
    ret
; 0x1e04a

Route6GateScripts: ; 0x1e04a
    dw Route6GateScript0

INCBIN "baserom.gbc",$1e04c,$2

Route6GateScript0: ; 0x1e04e
    ld a, [$d728]
    bit 6, a
    ret nz
    ld hl, $608c
    call $34bf
    ret nc
    ld a, $1
    ld [$d528], a
    xor a
    ld [$ff00+$b4], a
    ld b, $16
    ld hl, $659f
    call Bankswitch
    ld a, [$ff00+$db]
    and a
    jr nz, .asm_1e080 ; 0x1e06e $10
    ld a, $2
    ld [$ff00+$8c], a
    call $2920
    call $60a1
    ld a, $1
    ld [$d636], a
    ret
.asm_1e080
    ld hl, $d728
    set 6, [hl]
    ld a, $3
    ld [$ff00+$8c], a
    jp $2920
; 0x1e08c

INCBIN "baserom.gbc",$1e08c,$2c

Route6GateTexts: ; 0x1e0b8
    dw Route6GateText1, Route6GateText2, Route6GateText3

Route6GateObject: ; 0x1e0be (size=42)
    db $a ; border tile

    db $4 ; warps
    db $5, $3, $2, $ff
    db $5, $4, $2, $ff
    db $0, $3, $1, $ff
    db $0, $4, $1, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_GUARD, $2 + 4, $6 + 4, $ff, $d2, $1 ; person

    ; warp-to
    EVENT_DISP $4, $5, $3
    EVENT_DISP $4, $5, $4
    EVENT_DISP $4, $0, $3
    EVENT_DISP $4, $0, $4

Route6GateBlocks: ; 12
    INCBIN "maps/route6gate.blk"

Route7Gate_h: ; 0x1e0f4 to 0x1e100 (12 bytes) (bank=7) (id=76)
    db $0c ; tileset
    db ROUTE_7_GATE_HEIGHT, ROUTE_7_GATE_WIDTH ; dimensions (y, x)
    dw Route7GateBlocks, Route7GateTexts, Route7GateScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route7GateObject ; objects

Route7GateScript: ; 0x1e100
    call $3c3c
    ld a, [$d663]
    ld hl, $610d
    call $3d97
    ret
; 0x1e10d

Route7GateScripts: ; 0x1e10d
    dw Route7GateScript0

INCBIN "baserom.gbc",$1e10f,$19

Route7GateScript0: ; 0x1e128
    ld a, [$d728]
    bit 6, a
    ret nz
    ld hl, $6167
    call $34bf
    ret nc
    ld a, $8
    ld [$d528], a
    xor a
    ld [$ff00+$b4], a
    ld b, $16
    ld hl, $659f
    call Bankswitch
    ld a, [$ff00+$db]
    and a
    jr nz, .asm_1e15a ; 0x1e148 $10
    ld a, $2
    ld [$ff00+$8c], a
    call $2920
    call $6111
    ld a, $1
    ld [$d663], a
    ret
.asm_1e15a
    ld a, $3
    ld [$ff00+$8c], a
    call $2920
    ld hl, $d728
    set 6, [hl]
    ret
; 0x1e167

INCBIN "baserom.gbc",$1e167,$18

Route7GateTexts: ; 0x1e17f
    dw Route7GateText1, Route7GateText2, Route7GateText3

Route7GateObject: ; 0x1e185 (size=42)
    db $a ; border tile

    db $4 ; warps
    db $3, $0, $3, $ff
    db $4, $0, $3, $ff
    db $3, $5, $0, $ff
    db $4, $5, $1, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_GUARD, $1 + 4, $3 + 4, $ff, $d0, $1 ; person

    ; warp-to
    EVENT_DISP $3, $3, $0
    EVENT_DISP $3, $4, $0
    EVENT_DISP $3, $3, $5
    EVENT_DISP $3, $4, $5

Route7GateBlocks: ; 12
    INCBIN "maps/route7gate.blk"

Route8Gate_h: ; 0x1e1bb to 0x1e1c7 (12 bytes) (bank=7) (id=79)
    db $0c ; tileset
    db ROUTE_8_GATE_HEIGHT, ROUTE_8_GATE_WIDTH ; dimensions (y, x)
    dw Route8GateBlocks, Route8GateTexts, Route8GateScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route8GateObject ; objects

Route8GateScript: ; 0x1e1c7
    call $3c3c
    ld hl, $61d3
    ld a, [$d637]
    jp $3d97
; 0x1e1d3

Route8GateScripts: ; 0x1e1d3
    dw Route8GateScript0

INCBIN "baserom.gbc",$1e1d5,$19

Route8GateScript0: ; 0x1e1ee
    ld a, [$d728]
    bit 6, a
    ret nz
    ld hl, $622c
    call $34bf
    ret nc
    ld a, $2
    ld [$d528], a
    xor a
    ld [$ff00+$b4], a
    ld b, $16
    ld hl, $659f
    call Bankswitch
    ld a, [$ff00+$db]
    and a
    jr nz, .asm_1e220 ; 0x1e20e $10
    ld a, $2
    ld [$ff00+$8c], a
    call $2920
    call $61d7
    ld a, $1
    ld [$d637], a
    ret
.asm_1e220
    ld hl, $d728
    set 6, [hl]
    ld a, $3
    ld [$ff00+$8c], a
    jp $2920
; 0x1e22c

INCBIN "baserom.gbc",$1e22c,$15

Route8GateTexts: ; 0x1e241
    dw Route8GateText1, Route8GateText2, Route8GateText3

Route8GateObject: ; 0x1e247 (size=42)
    db $a ; border tile

    db $4 ; warps
    db $3, $0, $0, $ff
    db $4, $0, $1, $ff
    db $3, $5, $2, $ff
    db $4, $5, $3, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_GUARD, $1 + 4, $2 + 4, $ff, $d0, $1 ; person

    ; warp-to
    EVENT_DISP $3, $3, $0
    EVENT_DISP $3, $4, $0
    EVENT_DISP $3, $3, $5
    EVENT_DISP $3, $4, $5

Route8GateBlocks: ; 12
    INCBIN "maps/route8gate.blk"

UndergroundPathEntranceRoute8_h: ; 0x1e27d to 0x1e289 (12 bytes) (bank=7) (id=80)
    db $0c ; tileset
    db PATH_ENTRANCE_ROUTE_8_HEIGHT, PATH_ENTRANCE_ROUTE_8_WIDTH ; dimensions (y, x)
    dw UndergroundPathEntranceRoute8Blocks, UndergroundPathEntranceRoute8Texts, UndergroundPathEntranceRoute8Script ; blocks, texts, scripts
    db $00 ; connections

    dw UndergroundPathEntranceRoute8Object ; objects

UndergroundPathEntranceRoute8Script: ; 0x1e289
    ld a, $13
    ld [$d365], a
    jp $3c3c
; 0x1e291

UndergroundPathEntranceRoute8Texts: ; 0x1e291
    dw UndergroundPathEntranceRoute8Text1

;XXX wtf? syntax error
UndergroundPathEntranceRoute8Text1: ; 0x1e293
    db $17, $8d, $42, $23
    ;TX_FAR _UndergroundPathEntranceRoute8Text1
    db $50

UndergroundPathEntranceRoute8Object: ; 0x1e298 (size=34)
    db $a ; border tile

    db $3 ; warps
    db $7, $3, $4, $ff
    db $7, $4, $4, $ff
    db $4, $4, $1, UNDERGROUND_PATH_WE

    db $0 ; signs

    db $1 ; people
    db SPRITE_GIRL, $4 + 4, $3 + 4, $ff, $ff, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4
    EVENT_DISP $4, $4, $4 ; UNDERGROUND_PATH_WE

PowerPlant_h: ; 0x1e2ba to 0x1e2c6 (12 bytes) (bank=7) (id=83)
    db $16 ; tileset
    db POWER_PLANT_HEIGHT, POWER_PLANT_WIDTH ; dimensions (y, x)
    dw PowerPlantBlocks, PowerPlantTexts, PowerPlantScript ; blocks, texts, scripts
    db $00 ; connections

    dw PowerPlantObject ; objects

PowerPlantScript: ; 0x1e2c6
    call $3c3c
    ld hl, $62fb
    ld de, $62d9
    ld a, [$d663]
    call $3160
    ld [$d663], a
    ret
; 0x1e2d9

INCBIN "baserom.gbc",$1e2d9,$6

PowerPlantTexts: ; 0x1e2df
    dw PowerPlantText1, PowerPlantText2, PowerPlantText3, PowerPlantText4, PowerPlantText5, PowerPlantText6, PowerPlantText7, PowerPlantText8, PowerPlantText9, PowerPlantText10, PowerPlantText11, PowerPlantText12, PowerPlantText13, PowerPlantText14

INCBIN "baserom.gbc",$1e2fb,$6d

asm_234cc:
    call $31cc
    ld a, [$da39]
    ld [$d663], a
    jp $24d7
; 0x1e374

PowerPlantText1: ; maybe
    db $8 ; asm
    ld hl, $62fb
    jr asm_234cc ; 0x1e378 $ee

PowerPlantText2:
    db $8 ; asm
    ld hl, $6307
    jr asm_234cc ; 0x1e37e $e8

PowerPlantText3:
    db $8 ; asm
    ld hl, $6313
    jr asm_234cc ; 0x1e384 $e2

PowerPlantText4:
    db $8 ; asm
    ld hl, $631f
    jr asm_234cc ; 0x1e38a $dc

PowerPlantText5:
    db $8 ; asm
    ld hl, $632b
    jr asm_234cc ; 0x1e390 $d6

PowerPlantText6:
    db $8 ; asm
    ld hl, $6337
    jr asm_234cc ; 0x1e396 $d0

PowerPlantText7:
    db $8 ; asm
    ld hl, $6343
    jr asm_234cc ; 0x1e39c $ca

PowerPlantText8:
    db $8 ; asm
    ld hl, $634f
    jr asm_234cc ; 0x1e3a2 $c4

PowerPlantText9:
    db $8 ; asm
    ld hl, $635b
    jr asm_234cc ; 0x1e3a8 $be
    rla ; probably a TX_FAR
    ld [$ff00+c], a
    ld b, l
    inc hl
    ld d, b
    rla
    ld [$2345], a
    db $8
    ld a, $4b
    call $13d0
    call $3748
    jp $24d7
; 0x1e3bf

PowerPlantObject: ; 0x1e3bf (size=135)
    db $2e ; border tile

    db $3 ; warps
    db $23, $4, $3, $ff
    db $23, $5, $3, $ff
    db $b, $0, $3, $ff

    db $0 ; signs

    db $e ; people
    db SPRITE_BALL, $14 + 4, $9 + 4, $ff, $ff, $41, VOLTORB, $28 ; trainer
    db SPRITE_BALL, $12 + 4, $20 + 4, $ff, $ff, $42, VOLTORB, $28 ; trainer
    db SPRITE_BALL, $19 + 4, $15 + 4, $ff, $ff, $43, VOLTORB, $28 ; trainer
    db SPRITE_BALL, $12 + 4, $19 + 4, $ff, $ff, $44, ELECTRODE, $2b ; trainer
    db SPRITE_BALL, $22 + 4, $17 + 4, $ff, $ff, $45, VOLTORB, $28 ; trainer
    db SPRITE_BALL, $1c + 4, $1a + 4, $ff, $ff, $46, VOLTORB, $28 ; trainer
    db SPRITE_BALL, $e + 4, $15 + 4, $ff, $ff, $47, ELECTRODE, $2b ; trainer
    db SPRITE_BALL, $20 + 4, $25 + 4, $ff, $ff, $48, VOLTORB, $28 ; trainer
    db SPRITE_BIRD, $9 + 4, $4 + 4, $ff, $d1, $49, ZAPDOS, $32 ; trainer
	db SPRITE_BALL, $19 + 4, $7 + 4, $ff, $ff, $8a, CARBOS ; item
	db SPRITE_BALL, $3 + 4, $1c + 4, $ff, $ff, $8b, HP_UP ; item
	db SPRITE_BALL, $3 + 4, $22 + 4, $ff, $ff, $8c, RARE_CANDY ; item
	db SPRITE_BALL, $20 + 4, $1a + 4, $ff, $ff, $8d, TM_25 ; item
	db SPRITE_BALL, $20 + 4, $14 + 4, $ff, $ff, $8e, TM_33 ; item

    ; warp-to
    EVENT_DISP $14, $23, $4
    EVENT_DISP $14, $23, $5
    EVENT_DISP $14, $b, $0

PowerPlantBlocks: ; 360
    INCBIN "maps/powerplant.blk"

DiglettsCaveEntranceRoute11_h: ; 0x1e5ae to 0x1e5ba (12 bytes) (bank=7) (id=85)
    db $11 ; tileset
    db DIGLETTS_CAVE_ENTRANCE_HEIGHT, DIGLETTS_CAVE_ENTRANCE_WIDTH ; dimensions (y, x)
    dw DiglettsCaveEntranceRoute11Blocks, DiglettsCaveEntranceRoute11Texts, DiglettsCaveEntranceRoute11Script ; blocks, texts, scripts
    db $00 ; connections

    dw DiglettsCaveEntranceRoute11Object ; objects

DiglettsCaveEntranceRoute11Script: ; 0x1e5ba
    call $3c3c
    ld a, $16
    ld [$d365], a
    ret
; 0x1e5c3

DiglettsCaveEntranceRoute11Texts: ; 0x1e5c3
    dw DiglettsCaveEntranceRoute11Text1

; XXX wtf? syntax error
DiglettsCaveEntranceRoute11Text1: ; 0x1e5c5
    db $17, $f9, $47, $23
    ;TX_FAR _DiglettsCaveEntranceRoute11Text1
    db $50

DiglettsCaveEntranceRoute11Object: ; 0x1e5ca (size=34)
    db $7d ; border tile

    db $3 ; warps
    db $7, $2, $4, $ff
    db $7, $3, $4, $ff
    db $4, $4, $1, DIGLETTS_CAVE

    db $0 ; signs

    db $1 ; people
    db SPRITE_GAMBLER, $3 + 4, $2 + 4, $ff, $ff, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $4, $4 ; DIGLETTS_CAVE

Route16House_h: ; 0x1e5ec to 0x1e5f8 (12 bytes) (bank=7) (id=188)
    db $08 ; tileset
    db ROUTE_16_HOUSE_HEIGHT, ROUTE_16_HOUSE_WIDTH ; dimensions (y, x)
    dw Route16HouseBlocks, Route16HouseTexts, Route16HouseScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route16HouseObject ; objects

Route16HouseScript: ; 0x1e5f8
    jp $3c3c
; 0x1e5fb

Route16HouseTexts: ; 0x1e5fb
    dw Route16HouseText1, Route16HouseText2

Route16HouseText1: ; 0x1e5ff
    db $08 ; asm
    ld a, [$d7e0]
    bit 6, a
    ld hl, $6636
    jr nz, .asm_13616 ; 0x1e608
    ld hl, $662b
    call PrintText
    ld bc,(HM_02 << 8) | 1
    call $3e2e
    jr nc, .asm_d3ee3 ; 0x1e616
    ld hl, $d7e0
    set 6, [hl]
    ld hl, $6630
    jr .asm_13616 ; 0x1e620
.asm_d3ee3 ; 0x1e622
    ld hl, $663b
.asm_13616 ; 0x1e625
    call PrintText
    jp $24d7

UnnamedText_1e62b: ; 0x1e62b
    TX_FAR _UnnamedText_1e62b
    db $50
; 0x1e62b + 5 bytes

INCBIN "baserom.gbc",$1e630,$1e636 - $1e630

UnnamedText_1e636: ; 0x1e636
    TX_FAR _UnnamedText_1e636
    db $50
; 0x1e636 + 5 bytes

UnnamedText_1e63b: ; 0x1e63b
    TX_FAR _UnnamedText_1e63b
    db $50
; 0x1e63b + 5 bytes

Route16HouseText2: ; 0x1e640
    db $08 ; asm
    ld hl, $6652
    call PrintText
	ld a,FEAROW
    call $13d0
    call $3748
    jp $24d7

UnnamedText_1e652: ; 0x1e652
    TX_FAR _UnnamedText_1e652
    db $50
; 0x1e652 + 5 bytes

Route16HouseObject: ; 0x1e657 (size=32)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $8, $ff
    db $7, $3, $8, $ff

    db $0 ; signs

    db $2 ; people
    db SPRITE_BRUNETTE_GIRL, $3 + 4, $2 + 4, $ff, $d3, $1 ; person
    db SPRITE_BIRD, $4 + 4, $6 + 4, $fe, $0, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

Route22Gate_h: ; 0x1e677 to 0x1e683 (12 bytes) (bank=7) (id=193)
    db $0c ; tileset
    db ROUTE_22_GATE_HEIGHT, ROUTE_22_GATE_WIDTH ; dimensions (y, x)
    dw Route22GateBlocks, Route22GateTexts, Route22GateScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route22GateObject ; objects

Route22GateScript: ; 0x1e683
    call $3c3c
    ld hl, $669e
    ld a, [$d60e]
    call $3d97
    ld a, [$d361]
    cp $4
    ld a, $22
    jr c, .asm_1e69a ; 0x1e696 $2
    ld a, $21
.asm_1e69a
    ld [$d365], a
    ret
; 0x1e69e

Route22GateScripts: ; 0x1e69e
    dw Route22GateScript0, Route22GateScript1

INCBIN "baserom.gbc",$1e6a2,$2

Route22GateScript0: ; 0x1e6a4
    ld hl, $66b5
    call $34bf
    ret nc
    xor a
    ld [$ff00+$b4], a
    ld a, $1
    ld [$ff00+$8c], a
    jp $2920
; 0x1e6b5

INCBIN "baserom.gbc",$1e6b5,$1e6cd - $1e6b5

Route22GateScript1: ; 0x1e6cd
    ld a, [$cd38]
    and a
    ret nz
    xor a
    ld [$cd6b], a
    call Delay3
    ld a, $0
    ld [$d60e], a
    ret
; 0x1e6df

Route22GateTexts: ; 0x1e6df
    dw Route22GateText1

Route22GateText1: ; 0x1e6e1
    db $8
    ld a, [$d356]
    bit 0, a
    jr nz, .asm_8a809 ; 0x1e6e7 $d
    ld hl, $6704
    call PrintText
    call $66ba
    ld a, $1
    jr .asm_20f7e ; 0x1e6f4 $8
.asm_8a809 ; 0x1e6f6
    ld hl, $671a
    call PrintText
    ld a, $2
.asm_20f7e ; 0x1e6fe
    ld [$d60e], a
    jp $24d7
; 0x1e704

INCBIN "baserom.gbc",$1e704,$1e715 - $1e704

UnnamedText_1e715: ; 0x1e715
    TX_FAR _UnnamedText_1e715
    db $50
; 0x1e715 + 5 bytes

INCBIN "baserom.gbc",$1e71a,$6

Route22GateObject: ; 0x1e720 (size=42)
    db $a ; border tile

    db $4 ; warps
    db $7, $4, $0, $ff
    db $7, $5, $0, $ff
    db $0, $4, $0, $ff
    db $0, $5, $1, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_GUARD, $2 + 4, $6 + 4, $ff, $d2, $1 ; person

    ; warp-to
    EVENT_DISP $5, $7, $4
    EVENT_DISP $5, $7, $5
    EVENT_DISP $5, $0, $4
    EVENT_DISP $5, $0, $5

Route22GateBlocks: ; 20
    INCBIN "maps/route22gate.blk"

BillsHouse_h: ; 0x1e75e to 0x1e76a (12 bytes) (bank=7) (id=88)
    db $10 ; tileset
    db BILLS_HOUSE_HEIGHT, BILLS_HOUSE_WIDTH ; dimensions (y, x)
    dw BillsHouseBlocks, BillsHouseTexts, BillsHouseScript ; blocks, texts, scripts
    db $00 ; connections

    dw BillsHouseObject ; objects

BillsHouseScript: ; 0x1e76a
    call $3c3c
    ld a, [$d661]
    ld hl, $6776
    jp $3d97
; 0x1e776

BillsHouseScripts: ; 0x1e776
    dw BillsHouseScript0

INCBIN "baserom.gbc",$1e778,$a

BillsHouseScript0: ; 0x1e782
    ret
; 0x1e783

INCBIN "baserom.gbc",$1e783,$b1

BillsHouseTexts: ; 0x1e834
    dw BillsHouseText1, BillsHouseText2, BillsHouseText3, BillsHouseText4

BillsHouseText4:
    db $fd

BillsHouseText1: ; 0x1e83d
    db $8
    ld hl, $6865
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, asm_6b196 ; 0x1e84b $d
asm_4d03c:
    ld hl, $686a
    call PrintText
    ld a, $1
    ld [$d661], a
    jr asm_fd4e2 ; 0x1e858 $8
asm_6b196: ; 0x1e85a
    ld hl, $686f
    call PrintText
    jr asm_4d03c ; 0x1e860 $eb
asm_fd4e2 ; 0x1e862
    jp $24d7

; dunno what this is (rla indicates $17 or TX_FAR)
    rla
    ld h, a
    ld d, d
    inc hl
    ld d, b
    rla
    ld b, l
    ld d, e
    inc hl
    ld d, b
    rla
    sub c
    ld d, e
    inc hl
    ld d, b

BillsHouseText2: ; 0x1e874
    db $08 ; asm
    ld a, [$d7f2]
    bit 4, a
    jr nz, .asm_5491f ; 0x1e87a
    ld hl, $68ba
    call PrintText
    ld bc,(S_S__TICKET << 8) | 1
    call $3e2e
    jr nc, .asm_18a67 ; 0x1e888
    ld hl, $68bf
    call PrintText
    ld hl, $d7f2
    set 4, [hl]
    ld a, $7
    ld [$cc4d], a
    ld a, $15
    call Predef
    ld a, $9
    ld [$cc4d], a
    ld a, $11
    call Predef
.asm_5491f ; 0x1e8a9
    ld hl, $68cb
    call PrintText
    jr .asm_bd408 ; 0x1e8af
.asm_18a67 ; 0x1e8b1
    ld hl, $68c6
    call PrintText
.asm_bd408 ; 0x1e8b7
    jp $24d7

UnnamedText_1e8ba: ; 0x1e8ba
    TX_FAR _UnnamedText_1e8ba
    db $50
; 0x1e8ba + 5 bytes

INCBIN "baserom.gbc",$1e8bf,$1e8c6 - $1e8bf

UnnamedText_1e8c6: ; 0x1e8c6
    TX_FAR _UnnamedText_1e8c6
    db $50
; 0x1e8c6 + 5 bytes

UnnamedText_1e8cb: ; 0x1e8cb
    TX_FAR _UnnamedText_1e8cb
    db $50
; 0x1e8cb + 5 bytes

BillsHouseText3: ; 0x1e8d0
    db $08 ; asm
    ld hl, $68da
    call PrintText
    jp $24d7
; 0x1e8da

UnnamedText_1e8da: ; 0x1e8da
    TX_FAR _UnnamedText_1e8da
    db $50
; 0x1e8da + 5 bytes

BillsHouseObject: ; 0x1e8df (size=38)
    db $d ; border tile

    db $2 ; warps
    db $7, $2, $0, $ff
    db $7, $3, $0, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_SLOWBRO, $5 + 4, $6 + 4, $ff, $ff, $1 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $4 + 4, $4 + 4, $ff, $ff, $2 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $5 + 4, $6 + 4, $ff, $ff, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

BillsHouseBlocks:
    INCBIN "maps/billshouse.blk"

INCBIN "baserom.gbc",$1e915,$1e93b - $1e915

UnnamedText_1e93b: ; 0x1e93b
    TX_FAR _UnnamedText_1e93b
    db $50
; 0x1e93b + 5 bytes

INCBIN "baserom.gbc",$1e940,$1e946 - $1e940

UnnamedText_1e946: ; 0x1e946
    TX_FAR _UnnamedText_1e946
    db $50
; 0x1e946 + 5 bytes

INCBIN "baserom.gbc",$1e94b,$1e953 - $1e94b

UnnamedText_1e953: ; 0x1e953
    TX_FAR _UnnamedText_1e953
    db $50
; 0x1e953 + 5 bytes

INCBIN "baserom.gbc",$1e958,$1e960 - $1e958

UnnamedText_1e960: ; 0x1e960
    TX_FAR _UnnamedText_1e960
    db $50
; 0x1e960 + 5 bytes

INCBIN "baserom.gbc",$1e965,$1e97e - $1e965

UnnamedText_1e97e: ; 0x1e97e
    TX_FAR _UnnamedText_1e97e
    db $50
; 0x1e97e + 5 bytes

UnnamedText_1e983: ; 0x1e983
    TX_FAR _UnnamedText_1e983
    db $50
; 0x1e983 + 5 bytes

INCBIN "baserom.gbc",$1e988,$1ea0d - $1e988

UnnamedText_1ea0d: ; 0x1ea0d
    TX_FAR _UnnamedText_1ea0d
    db $50
; 0x1ea0d + 5 bytes

UnnamedText_1ea12: ; 0x1ea12
    TX_FAR _UnnamedText_1ea12
    db $50
; 0x1ea12 + 5 bytes

INCBIN "baserom.gbc",$1ea17,$1ea5b - $1ea17

UnnamedText_1ea5b: ; 0x1ea5b
    TX_FAR _UnnamedText_1ea5b
    db $50
; 0x1ea5b + 5 bytes

INCBIN "baserom.gbc",$1ea60,$1ea6c - $1ea60

UnnamedText_1ea6c: ; 0x1ea6c
    TX_FAR _UnnamedText_1ea6c
    db $50
; 0x1ea6c + 5 bytes

UnnamedText_1ea71: ; 0x1ea71
    TX_FAR _UnnamedText_1ea71
    db $50
; 0x1ea71 + 5 bytes

UnnamedText_1ea76: ; 0x1ea76
    TX_FAR _UnnamedText_1ea76
    db $50
; 0x1ea76 + 5 bytes

UnnamedText_1ea7b: ; 0x1ea7b
    TX_FAR _UnnamedText_1ea7b
    db $50
; 0x1ea7b + 5 bytes

UnnamedText_1ea80: ; 0x1ea80
    TX_FAR _UnnamedText_1ea80
    db $50
; 0x1ea80 + 5 bytes

UnnamedText_1ea85: ; 0x1ea85
    TX_FAR _UnnamedText_1ea85
    db $50
; 0x1ea85 + 5 bytes

INCBIN "baserom.gbc",$1ea8a,$1eb05 - $1ea8a

UnnamedText_1eb05: ; 0x1eb05
    TX_FAR _UnnamedText_1eb05
    db $50
; 0x1eb05 + 5 bytes

INCBIN "baserom.gbc",$1eb0a,$1eb69 - $1eb0a

UnnamedText_1eb69: ; 0x1eb69
    TX_FAR _UnnamedText_1eb69
    db $50
; 0x1eb69 + 5 bytes

INCBIN "baserom.gbc",$1eb6e,$1ebdd - $1eb6e

UnnamedText_1ebdd: ; 0x1ebdd
    TX_FAR _UnnamedText_1ebdd
    db $50
; 0x1ebdd + 5 bytes

INCBIN "baserom.gbc",$1ebe2,$1ec7f - $1ebe2

UnnamedText_1ec7f: ; 0x1ec7f
    TX_FAR _UnnamedText_1ec7f
    db $50
; 0x1ec7f + 5 bytes

INCBIN "baserom.gbc",$1ec84,$1ecaa - $1ec84

UnnamedText_1ecaa: ; 0x1ecaa
    TX_FAR _UnnamedText_1ecaa
    db $50
; 0x1ecaa + 5 bytes

INCBIN "baserom.gbc",$1ecaf,$1ecbd - $1ecaf

UnnamedText_1ecbd: ; 0x1ecbd
    TX_FAR _UnnamedText_1ecbd
    db $50
; 0x1ecbd + 5 bytes

INCBIN "baserom.gbc",$1ecc2,$133e

SECTION "bank8",DATA,BANK[$8]

INCBIN "baserom.gbc",$20000,$217e9 - $20000

UnnamedText_217e9: ; 0x217e9
    TX_FAR _UnnamedText_217e9
    db $50
; 0x217e9 + 5 bytes

UnnamedText_217ee: ; 0x217ee
    TX_FAR _UnnamedText_217ee
    db $50
; 0x217ee + 5 bytes

UnnamedText_217f3: ; 0x217f3
    TX_FAR _UnnamedText_217f3
    db $50
; 0x217f3 + 5 bytes

UnnamedText_217f8: ; 0x217f8
    TX_FAR _UnnamedText_217f8
    db $50
; 0x217f8 + 5 bytes

UnnamedText_217fd: ; 0x217fd
    TX_FAR _UnnamedText_217fd
    db $50
; 0x217fd + 5 bytes

UnnamedText_21802: ; 0x21802
    TX_FAR _UnnamedText_21802
    db $50
; 0x21802 + 5 bytes

UnnamedText_21807: ; 0x21807
    TX_FAR _UnnamedText_21807
    db $50
; 0x21807 + 5 bytes

UnnamedText_2180c: ; 0x2180c
    TX_FAR _UnnamedText_2180c
    db $50
; 0x2180c + 5 bytes

UnnamedText_21811: ; 0x21811
    TX_FAR _UnnamedText_21811
    db $50
; 0x21811 + 5 bytes

UnnamedText_21816: ; 0x21816
    TX_FAR _UnnamedText_21816
    db $50
; 0x21816 + 5 bytes

UnnamedText_2181b: ; 0x2181b
    TX_FAR _UnnamedText_2181b
    db $50
; 0x2181b + 5 bytes

UnnamedText_21820: ; 0x21820
    TX_FAR _UnnamedText_21820
    db $50
; 0x21820 + 5 bytes

INCBIN "baserom.gbc",$21825,$21865 - $21825

UnnamedText_21865: ; 0x21865
    TX_FAR _UnnamedText_21865
    db $50
; 0x21865 + 5 bytes

INCBIN "baserom.gbc",$2186a,$2796

SECTION "bank9",DATA,BANK[$9]

RhydonPicFront:
	INCBIN "pic/bmon/rhydon.pic"
RhydonPicBack:
	INCBIN "pic/monback/rhydonb.pic"
KangaskhanPicFront:
	INCBIN "pic/bmon/kangaskhan.pic"
KangaskhanPicBack:
	INCBIN "pic/monback/kangaskhanb.pic"
NidoranMPicFront:
	INCBIN "pic/bmon/nidoranm.pic"
NidoranMPicBack:
	INCBIN "pic/monback/nidoranmb.pic"
ClefairyPicFront:
	INCBIN "pic/bmon/clefairy.pic"
ClefairyPicBack:
	INCBIN "pic/monback/clefairyb.pic"
SpearowPicFront:
	INCBIN "pic/bmon/spearow.pic"
SpearowPicBack:
	INCBIN "pic/monback/spearowb.pic"
VoltorbPicFront:
	INCBIN "pic/bmon/voltorb.pic"
VoltorbPicBack:
	INCBIN "pic/monback/voltorbb.pic"
NidokingPicFront:
	INCBIN "pic/bmon/nidoking.pic"
NidokingPicBack:
	INCBIN "pic/monback/nidokingb.pic"
SlowbroPicFront:
	INCBIN "pic/bmon/slowbro.pic"
SlowbroPicBack:
	INCBIN "pic/monback/slowbrob.pic"
IvysaurPicFront:
	INCBIN "pic/bmon/ivysaur.pic"
IvysaurPicBack:
	INCBIN "pic/monback/ivysaurb.pic"
ExeggutorPicFront:
	INCBIN "pic/bmon/exeggutor.pic"
ExeggutorPicBack:
	INCBIN "pic/monback/exeggutorb.pic"
LickitungPicFront:
	INCBIN "pic/bmon/lickitung.pic"
LickitungPicBack:
	INCBIN "pic/monback/lickitungb.pic"
ExeggcutePicFront:
	INCBIN "pic/bmon/exeggcute.pic"
ExeggcutePicBack:
	INCBIN "pic/monback/exeggcuteb.pic"
GrimerPicFront:
	INCBIN "pic/bmon/grimer.pic"
GrimerPicBack:
	INCBIN "pic/monback/grimerb.pic"
GengarPicFront:
	INCBIN "pic/bmon/gengar.pic"
GengarPicBack:
	INCBIN "pic/monback/gengarb.pic"
NidoranFPicFront:
	INCBIN "pic/bmon/nidoranf.pic"
NidoranFPicBack:
	INCBIN "pic/monback/nidoranfb.pic"
NidoqueenPicFront:
	INCBIN "pic/bmon/nidoqueen.pic"
NidoqueenPicBack:
	INCBIN "pic/monback/nidoqueenb.pic"
CubonePicFront:
	INCBIN "pic/bmon/cubone.pic"
CubonePicBack:
	INCBIN "pic/monback/cuboneb.pic"
RhyhornPicFront:
	INCBIN "pic/bmon/rhyhorn.pic"
RhyhornPicBack:
	INCBIN "pic/monback/rhyhornb.pic"
LaprasPicFront:
	INCBIN "pic/bmon/lapras.pic"
LaprasPicBack:
	INCBIN "pic/monback/laprasb.pic"
ArcaninePicFront:
	INCBIN "pic/bmon/arcanine.pic"
ArcaninePicBack:
	INCBIN "pic/monback/arcanineb.pic"
GyaradosPicFront:
	INCBIN "pic/bmon/gyarados.pic"
GyaradosPicBack:
	INCBIN "pic/monback/gyaradosb.pic"
ShellderPicFront:
	INCBIN "pic/bmon/shellder.pic"
ShellderPicBack:
	INCBIN "pic/monback/shellderb.pic"
TentacoolPicFront:
	INCBIN "pic/bmon/tentacool.pic"
TentacoolPicBack:
	INCBIN "pic/monback/tentacoolb.pic"
GastlyPicFront:
	INCBIN "pic/bmon/gastly.pic"
GastlyPicBack:
	INCBIN "pic/monback/gastlyb.pic"
ScytherPicFront:
	INCBIN "pic/bmon/scyther.pic"
ScytherPicBack:
	INCBIN "pic/monback/scytherb.pic"
StaryuPicFront:
	INCBIN "pic/bmon/staryu.pic"
StaryuPicBack:
	INCBIN "pic/monback/staryub.pic"
BlastoisePicFront:
	INCBIN "pic/bmon/blastoise.pic"
BlastoisePicBack:
	INCBIN "pic/monback/blastoiseb.pic"
PinsirPicFront:
	INCBIN "pic/bmon/pinsir.pic"
PinsirPicBack:
	INCBIN "pic/monback/pinsirb.pic"
TangelaPicFront:
	INCBIN "pic/bmon/tangela.pic"
TangelaPicBack:
	INCBIN "pic/monback/tangelab.pic"

INCBIN "baserom.gbc",$27d6b,$27DAE - $27d6b

TypeNamePointers: ; 7DAE
	dw Type00Name
	dw Type01Name
	dw Type02Name
	dw Type03Name
	dw Type04Name
	dw Type05Name
	dw Type06Name
	dw Type07Name
	dw Type08Name
	dw Type00Name
	dw Type00Name
	dw Type00Name
	dw Type00Name
	dw Type00Name
	dw Type00Name
	dw Type00Name
	dw Type00Name
	dw Type00Name
	dw Type00Name
	dw Type00Name
	dw Type14Name
	dw Type15Name
	dw Type16Name
	dw Type17Name
	dw Type18Name
	dw Type19Name
	dw Type1AName

Type00Name:
	db "NORMAL@"
Type01Name:
	db "FIGHTING@"
Type02Name:
	db "FLYING@"
Type03Name:
	db "POISON@"
Type14Name:
	db "FIRE@"
Type15Name:
	db "WATER@"
Type16Name:
	db "GRASS@"
Type17Name:
	db "ELECTRIC@"
Type18Name:
	db "PSYCHIC@"
Type19Name:
	db "ICE@"
Type04Name:
	db "GROUND@"
Type05Name:
	db "ROCK@"
Type06Name:
	db "BIRD@"
Type07Name:
	db "BUG@"
Type08Name:
	db "GHOST@"
Type1AName:
	db "DRAGON@"

SaveTrainerName: ; 7E4A
	ld hl,TrainerNamePointers
	ld a,[W_TRAINERCLASS]
	dec a
	ld c,a
	ld b,0
	add hl,bc
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld de,$CD6D
.CopyCharacter\@
	ld a,[hli]
	ld [de],a
	inc de
	cp "@"
	jr nz,.CopyCharacter\@
	ret

TrainerNamePointers:
; what is the point of these?
	dw YoungsterName
	dw BugCatcherName
	dw LassName
	dw $D04A
	dw JrTrainerMName
	dw JrTrainerFName
	dw PokemaniacName
	dw SuperNerdName
	dw $D04A
	dw $D04A
	dw BurglarName
	dw EngineerName
	dw JugglerXName
	dw $D04A
	dw SwimmerName
	dw $D04A
	dw $D04A
	dw BeautyName
	dw $D04A
	dw RockerName
	dw JugglerName
	dw $D04A
	dw $D04A
	dw BlackbeltName
	dw $D04A
	dw ProfOakName
	dw ChiefName
	dw ScientistName
	dw $D04A
	dw RocketName
	dw CooltrainerMName
	dw CooltrainerFName
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A
	dw $D04A

YoungsterName:
	db "YOUNGSTER@"
BugCatcherName:
	db "BUG CATCHER@"
LassName:
	db "LASS@"
JrTrainerMName:
	db "JR.TRAINER♂@"
JrTrainerFName:
	db "JR.TRAINER♀@"
PokemaniacName:
	db "POKéMANIAC@"
SuperNerdName:
	db "SUPER NERD@"
BurglarName:
	db "BURGLAR@"
EngineerName:
	db "ENGINEER@"
JugglerXName:
	db "JUGGLER@"
SwimmerName:
	db "SWIMMER@"
BeautyName:
	db "BEAUTY@"
RockerName:
	db "ROCKER@"
JugglerName:
	db "JUGGLER@"
BlackbeltName:
	db "BLACKBELT@"
ProfOakName:
	db "PROF.OAK@"
ChiefName:
	db "CHIEF@"
ScientistName:
	db "SCIENTIST@"
RocketName:
	db "ROCKET@"
CooltrainerMName:
	db "COOLTRAINER♂@"
CooltrainerFName:
	db "COOLTRAINER♀@"

INCBIN "baserom.gbc",$27f86,$27fb3 - $27f86

UnnamedText_27fb3: ; 0x27fb3
    TX_FAR _UnnamedText_27fb3
    db $50
; 0x27fb3 + 5 bytes

SECTION "bankA",DATA,BANK[$A]
GrowlithePicFront:
	INCBIN "pic/bmon/growlithe.pic"
GrowlithePicBack:
	INCBIN "pic/monback/growlitheb.pic"
OnixPicFront:
	INCBIN "pic/bmon/onix.pic"
OnixPicBack:
	INCBIN "pic/monback/onixb.pic"
FearowPicFront:
	INCBIN "pic/bmon/fearow.pic"
FearowPicBack:
	INCBIN "pic/monback/fearowb.pic"
PidgeyPicFront:
	INCBIN "pic/bmon/pidgey.pic"
PidgeyPicBack:
	INCBIN "pic/monback/pidgeyb.pic"
SlowpokePicFront:
	INCBIN "pic/bmon/slowpoke.pic"
SlowpokePicBack:
	INCBIN "pic/monback/slowpokeb.pic"
KadabraPicFront:
	INCBIN "pic/bmon/kadabra.pic"
KadabraPicBack:
	INCBIN "pic/monback/kadabrab.pic"
GravelerPicFront:
	INCBIN "pic/bmon/graveler.pic"
GravelerPicBack:
	INCBIN "pic/monback/gravelerb.pic"
ChanseyPicFront:
	INCBIN "pic/bmon/chansey.pic"
ChanseyPicBack:
	INCBIN "pic/monback/chanseyb.pic"
MachokePicFront:
	INCBIN "pic/bmon/machoke.pic"
MachokePicBack:
	INCBIN "pic/monback/machokeb.pic"
MrMimePicFront:
	INCBIN "pic/bmon/mr.mime.pic"
MrMimePicBack:
	INCBIN "pic/monback/mr.mimeb.pic"
HitmonleePicFront:
	INCBIN "pic/bmon/hitmonlee.pic"
HitmonleePicBack:
	INCBIN "pic/monback/hitmonleeb.pic"
HitmonchanPicFront:
	INCBIN "pic/bmon/hitmonchan.pic"
HitmonchanPicBack:
	INCBIN "pic/monback/hitmonchanb.pic"
ArbokPicFront:
	INCBIN "pic/bmon/arbok.pic"
ArbokPicBack:
	INCBIN "pic/monback/arbokb.pic"
ParasectPicFront:
	INCBIN "pic/bmon/parasect.pic"
ParasectPicBack:
	INCBIN "pic/monback/parasectb.pic"
PsyduckPicFront:
	INCBIN "pic/bmon/psyduck.pic"
PsyduckPicBack:
	INCBIN "pic/monback/psyduckb.pic"
DrowzeePicFront:
	INCBIN "pic/bmon/drowzee.pic"
DrowzeePicBack:
	INCBIN "pic/monback/drowzeeb.pic"
GolemPicFront:
	INCBIN "pic/bmon/golem.pic"
GolemPicBack:
	INCBIN "pic/monback/golemb.pic"
MagmarPicFront:
	INCBIN "pic/bmon/magmar.pic"
MagmarPicBack:
	INCBIN "pic/monback/magmarb.pic"
ElectabuzzPicFront:
	INCBIN "pic/bmon/electabuzz.pic"
ElectabuzzPicBack:
	INCBIN "pic/monback/electabuzzb.pic"
MagnetonPicFront:
	INCBIN "pic/bmon/magneton.pic"
MagnetonPicBack:
	INCBIN "pic/monback/magnetonb.pic"
KoffingPicFront:
	INCBIN "pic/bmon/koffing.pic"
KoffingPicBack:
	INCBIN "pic/monback/koffingb.pic"
MankeyPicFront:
	INCBIN "pic/bmon/mankey.pic"
MankeyPicBack:
	INCBIN "pic/monback/mankeyb.pic"
SeelPicFront:
	INCBIN "pic/bmon/seel.pic"
SeelPicBack:
	INCBIN "pic/monback/seelb.pic"
DiglettPicFront:
	INCBIN "pic/bmon/diglett.pic"
DiglettPicBack:
	INCBIN "pic/monback/diglettb.pic"
TaurosPicFront:
	INCBIN "pic/bmon/tauros.pic"
TaurosPicBack:
	INCBIN "pic/monback/taurosb.pic"
FarfetchdPicFront:
	INCBIN "pic/bmon/farfetchd.pic"
FarfetchdPicBack:
	INCBIN "pic/monback/farfetchdb.pic"
VenonatPicFront:
	INCBIN "pic/bmon/venonat.pic"
VenonatPicBack:
	INCBIN "pic/monback/venonatb.pic"
DragonitePicFront:
	INCBIN "pic/bmon/dragonite.pic"
DragonitePicBack:
	INCBIN "pic/monback/dragoniteb.pic"
DoduoPicFront:
	INCBIN "pic/bmon/doduo.pic"
DoduoPicBack:
	INCBIN "pic/monback/doduob.pic"
PoliwagPicFront:
	INCBIN "pic/bmon/poliwag.pic"
PoliwagPicBack:
	INCBIN "pic/monback/poliwagb.pic"
JynxPicFront:
	INCBIN "pic/bmon/jynx.pic"
JynxPicBack:
	INCBIN "pic/monback/jynxb.pic"
MoltresPicFront:
	INCBIN "pic/bmon/moltres.pic"
MoltresPicBack:
	INCBIN "pic/monback/moltresb.pic"

INCBIN "baserom.gbc",$2bea9,$2bef2 - $2bea9

UnnamedText_2bef2: ; 0x2bef2
    TX_FAR _UnnamedText_2bef2
    db $50
; 0x2bef2 + 5 bytes

UnnamedText_2bef7: ; 0x2bef7
    TX_FAR _UnnamedText_2bef7
    db $50
; 0x2bef7 + 5 bytes

SECTION "bankB",DATA,BANK[$B]
ArticunoPicFront:
	INCBIN "pic/bmon/articuno.pic"
ArticunoPicBack:
	INCBIN "pic/monback/articunob.pic"
ZapdosPicFront:
	INCBIN "pic/bmon/zapdos.pic"
ZapdosPicBack:
	INCBIN "pic/monback/zapdosb.pic"
DittoPicFront:
	INCBIN "pic/bmon/ditto.pic"
DittoPicBack:
	INCBIN "pic/monback/dittob.pic"
MeowthPicFront:
	INCBIN "pic/bmon/meowth.pic"
MeowthPicBack:
	INCBIN "pic/monback/meowthb.pic"
KrabbyPicFront:
	INCBIN "pic/bmon/krabby.pic"
KrabbyPicBack:
	INCBIN "pic/monback/krabbyb.pic"
VulpixPicFront:
	INCBIN "pic/bmon/vulpix.pic"
VulpixPicBack:
	INCBIN "pic/monback/vulpixb.pic"
NinetalesPicFront:
	INCBIN "pic/bmon/ninetales.pic"
NinetalesPicBack:
	INCBIN "pic/monback/ninetalesb.pic"
PikachuPicFront:
	INCBIN "pic/bmon/pikachu.pic"
PikachuPicBack:
	INCBIN "pic/monback/pikachub.pic"
RaichuPicFront:
	INCBIN "pic/bmon/raichu.pic"
RaichuPicBack:
	INCBIN "pic/monback/raichub.pic"
DratiniPicFront:
	INCBIN "pic/bmon/dratini.pic"
DratiniPicBack:
	INCBIN "pic/monback/dratinib.pic"
DragonairPicFront:
	INCBIN "pic/bmon/dragonair.pic"
DragonairPicBack:
	INCBIN "pic/monback/dragonairb.pic"
KabutoPicFront:
	INCBIN "pic/bmon/kabuto.pic"
KabutoPicBack:
	INCBIN "pic/monback/kabutob.pic"
KabutopsPicFront:
	INCBIN "pic/bmon/kabutops.pic"
KabutopsPicBack:
	INCBIN "pic/monback/kabutopsb.pic"
HorseaPicFront:
	INCBIN "pic/bmon/horsea.pic"
HorseaPicBack:
	INCBIN "pic/monback/horseab.pic"
SeadraPicFront:
	INCBIN "pic/bmon/seadra.pic"
SeadraPicBack:
	INCBIN "pic/monback/seadrab.pic"
SandshrewPicFront:
	INCBIN "pic/bmon/sandshrew.pic"
SandshrewPicBack:
	INCBIN "pic/monback/sandshrewb.pic"
SandslashPicFront:
	INCBIN "pic/bmon/sandslash.pic"
SandslashPicBack:
	INCBIN "pic/monback/sandslashb.pic"
OmanytePicFront:
	INCBIN "pic/bmon/omanyte.pic"
OmanytePicBack:
	INCBIN "pic/monback/omanyteb.pic"
OmastarPicFront:
	INCBIN "pic/bmon/omastar.pic"
OmastarPicBack:
	INCBIN "pic/monback/omastarb.pic"
JigglypuffPicFront:
	INCBIN "pic/bmon/jigglypuff.pic"
JigglypuffPicBack:
	INCBIN "pic/monback/jigglypuffb.pic"
WigglytuffPicFront:
	INCBIN "pic/bmon/wigglytuff.pic"
WigglytuffPicBack:
	INCBIN "pic/monback/wigglytuffb.pic"
EeveePicFront:
	INCBIN "pic/bmon/eevee.pic"
EeveePicBack:
	INCBIN "pic/monback/eeveeb.pic"
FlareonPicFront:
	INCBIN "pic/bmon/flareon.pic"
FlareonPicBack:
	INCBIN "pic/monback/flareonb.pic"
JolteonPicFront:
	INCBIN "pic/bmon/jolteon.pic"
JolteonPicBack:
	INCBIN "pic/monback/jolteonb.pic"
VaporeonPicFront:
	INCBIN "pic/bmon/vaporeon.pic"
VaporeonPicBack:
	INCBIN "pic/monback/vaporeonb.pic"
MachopPicFront:
	INCBIN "pic/bmon/machop.pic"
MachopPicBack:
	INCBIN "pic/monback/machopb.pic"
ZubatPicFront:
	INCBIN "pic/bmon/zubat.pic"
ZubatPicBack:
	INCBIN "pic/monback/zubatb.pic"
EkansPicFront:
	INCBIN "pic/bmon/ekans.pic"
EkansPicBack:
	INCBIN "pic/monback/ekansb.pic"
ParasPicFront:
	INCBIN "pic/bmon/paras.pic"
ParasPicBack:
	INCBIN "pic/monback/parasb.pic"
PoliwhirlPicFront:
	INCBIN "pic/bmon/poliwhirl.pic"
PoliwhirlPicBack:
	INCBIN "pic/monback/poliwhirlb.pic"
PoliwrathPicFront:
	INCBIN "pic/bmon/poliwrath.pic"
PoliwrathPicBack:
	INCBIN "pic/monback/poliwrathb.pic"
WeedlePicFront:
	INCBIN "pic/bmon/weedle.pic"
WeedlePicBack:
	INCBIN "pic/monback/weedleb.pic"
KakunaPicFront:
	INCBIN "pic/bmon/kakuna.pic"
KakunaPicBack:
	INCBIN "pic/monback/kakunab.pic"
BeedrillPicFront:
	INCBIN "pic/bmon/beedrill.pic"
BeedrillPicBack:
	INCBIN "pic/monback/beedrillb.pic"
FossilKabutopsPic:
	INCBIN "pic/bmon/fossilkabutops.pic"

INCBIN "baserom.gbc",$2fb7b,$2fb8e - $2fb7b

UnnamedText_2fb8e: ; 0x2fb8e
    TX_FAR _UnnamedText_2fb8e
    db $50
; 0x2fb8e + 5 bytes

UnnamedText_2fb93: ; 0x2fb93
    TX_FAR _UnnamedText_2fb93
    db $50
; 0x2fb93 + 5 bytes

INCBIN "baserom.gbc",$2fb98,$2fe3b - $2fb98

UnnamedText_2fe3b: ; 0x2fe3b
    TX_FAR _UnnamedText_2fe3b
    db $50
; 0x2fe3b + 5 bytes

INCBIN "baserom.gbc",$2fe40,$2ff04 - $2fe40

UnnamedText_2ff04: ; 0x2ff04
    TX_FAR _UnnamedText_2ff04
    db $50
; 0x2ff04 + 5 bytes

INCBIN "baserom.gbc",$2ff09,$2ff32 - $2ff09

UnnamedText_2ff32: ; 0x2ff32
    TX_FAR _UnnamedText_2ff32
    db $50
; 0x2ff32 + 5 bytes

UnnamedText_2ff37: ; 0x2ff37
    TX_FAR _UnnamedText_2ff37
    db $50
; 0x2ff37 + 5 bytes

SECTION "bankC",DATA,BANK[$C]
DodrioPicFront:
	INCBIN "pic/bmon/dodrio.pic"
DodrioPicBack:
	INCBIN "pic/monback/dodriob.pic"
PrimeapePicFront:
	INCBIN "pic/bmon/primeape.pic"
PrimeapePicBack:
	INCBIN "pic/monback/primeapeb.pic"
DugtrioPicFront:
	INCBIN "pic/bmon/dugtrio.pic"
DugtrioPicBack:
	INCBIN "pic/monback/dugtriob.pic"
VenomothPicFront:
	INCBIN "pic/bmon/venomoth.pic"
VenomothPicBack:
	INCBIN "pic/monback/venomothb.pic"
DewgongPicFront:
	INCBIN "pic/bmon/dewgong.pic"
DewgongPicBack:
	INCBIN "pic/monback/dewgongb.pic"
CaterpiePicFront:
	INCBIN "pic/bmon/caterpie.pic"
CaterpiePicBack:
	INCBIN "pic/monback/caterpieb.pic"
MetapodPicFront:
	INCBIN "pic/bmon/metapod.pic"
MetapodPicBack:
	INCBIN "pic/monback/metapodb.pic"
ButterfreePicFront:
	INCBIN "pic/bmon/butterfree.pic"
ButterfreePicBack:
	INCBIN "pic/monback/butterfreeb.pic"
MachampPicFront:
	INCBIN "pic/bmon/machamp.pic"
MachampPicBack:
	INCBIN "pic/monback/machampb.pic"
GolduckPicFront:
	INCBIN "pic/bmon/golduck.pic"
GolduckPicBack:
	INCBIN "pic/monback/golduckb.pic"
HypnoPicFront:
	INCBIN "pic/bmon/hypno.pic"
HypnoPicBack:
	INCBIN "pic/monback/hypnob.pic"
GolbatPicFront:
	INCBIN "pic/bmon/golbat.pic"
GolbatPicBack:
	INCBIN "pic/monback/golbatb.pic"
MewtwoPicFront:
	INCBIN "pic/bmon/mewtwo.pic"
MewtwoPicBack:
	INCBIN "pic/monback/mewtwob.pic"
SnorlaxPicFront:
	INCBIN "pic/bmon/snorlax.pic"
SnorlaxPicBack:
	INCBIN "pic/monback/snorlaxb.pic"
MagikarpPicFront:
	INCBIN "pic/bmon/magikarp.pic"
MagikarpPicBack:
	INCBIN "pic/monback/magikarpb.pic"
MukPicFront:
	INCBIN "pic/bmon/muk.pic"
MukPicBack:
	INCBIN "pic/monback/mukb.pic"
KinglerPicFront:
	INCBIN "pic/bmon/kingler.pic"
KinglerPicBack:
	INCBIN "pic/monback/kinglerb.pic"
CloysterPicFront:
	INCBIN "pic/bmon/cloyster.pic"
CloysterPicBack:
	INCBIN "pic/monback/cloysterb.pic"
ElectrodePicFront:
	INCBIN "pic/bmon/electrode.pic"
ElectrodePicBack:
	INCBIN "pic/monback/electrodeb.pic"
ClefablePicFront:
	INCBIN "pic/bmon/clefable.pic"
ClefablePicBack:
	INCBIN "pic/monback/clefableb.pic"
WeezingPicFront:
	INCBIN "pic/bmon/weezing.pic"
WeezingPicBack:
	INCBIN "pic/monback/weezingb.pic"
PersianPicFront:
	INCBIN "pic/bmon/persian.pic"
PersianPicBack:
	INCBIN "pic/monback/persianb.pic"
MarowakPicFront:
	INCBIN "pic/bmon/marowak.pic"
MarowakPicBack:
	INCBIN "pic/monback/marowakb.pic"
HaunterPicFront:
	INCBIN "pic/bmon/haunter.pic"
HaunterPicBack:
	INCBIN "pic/monback/haunterb.pic"
AbraPicFront:
	INCBIN "pic/bmon/abra.pic"
AbraPicBack:
	INCBIN "pic/monback/abrab.pic"
AlakazamPicFront:
	INCBIN "pic/bmon/alakazam.pic"
AlakazamPicBack:
	INCBIN "pic/monback/alakazamb.pic"
PidgeottoPicFront:
	INCBIN "pic/bmon/pidgeotto.pic"
PidgeottoPicBack:
	INCBIN "pic/monback/pidgeottob.pic"
PidgeotPicFront:
	INCBIN "pic/bmon/pidgeot.pic"
PidgeotPicBack:
	INCBIN "pic/monback/pidgeotb.pic"
StarmiePicFront:
	INCBIN "pic/bmon/starmie.pic"
StarmiePicBack:
	INCBIN "pic/monback/starmieb.pic"
RedPicBack:
	INCBIN "pic/trainer/redb.pic"
OldManPic:
	INCBIN "pic/trainer/oldman.pic"

INCBIN "baserom.gbc",$33f2b,$33f52 - $33f2b

UnnamedText_33f52: ; 0x33f52
    TX_FAR _UnnamedText_33f52
    db $50
; 0x33f52 + 5 bytes

INCBIN "baserom.gbc",$33f57,$39

SECTION "bankD",DATA,BANK[$D]
BulbasaurPicFront:
	INCBIN "pic/bmon/bulbasaur.pic"
BulbasaurPicBack:
	INCBIN "pic/monback/bulbasaurb.pic"
VenusaurPicFront:
	INCBIN "pic/bmon/venusaur.pic"
VenusaurPicBack:
	INCBIN "pic/monback/venusaurb.pic"
TentacruelPicFront:
	INCBIN "pic/bmon/tentacruel.pic"
TentacruelPicBack:
	INCBIN "pic/monback/tentacruelb.pic"
GoldeenPicFront:
	INCBIN "pic/bmon/goldeen.pic"
GoldeenPicBack:
	INCBIN "pic/monback/goldeenb.pic"
SeakingPicFront:
	INCBIN "pic/bmon/seaking.pic"
SeakingPicBack:
	INCBIN "pic/monback/seakingb.pic"
PonytaPicFront:
	INCBIN "pic/bmon/ponyta.pic"
RapidashPicFront:
	INCBIN "pic/bmon/rapidash.pic"
PonytaPicBack:
	INCBIN "pic/monback/ponytab.pic"
RapidashPicBack:
	INCBIN "pic/monback/rapidashb.pic"
RattataPicFront:
	INCBIN "pic/bmon/rattata.pic"
RattataPicBack:
	INCBIN "pic/monback/rattatab.pic"
RaticatePicFront:
	INCBIN "pic/bmon/raticate.pic"
RaticatePicBack:
	INCBIN "pic/monback/raticateb.pic"
NidorinoPicFront:
	INCBIN "pic/bmon/nidorino.pic"
NidorinoPicBack:
	INCBIN "pic/monback/nidorinob.pic"
NidorinaPicFront:
	INCBIN "pic/bmon/nidorina.pic"
NidorinaPicBack:
	INCBIN "pic/monback/nidorinab.pic"
GeodudePicFront:
	INCBIN "pic/bmon/geodude.pic"
GeodudePicBack:
	INCBIN "pic/monback/geodudeb.pic"
PorygonPicFront:
	INCBIN "pic/bmon/porygon.pic"
PorygonPicBack:
	INCBIN "pic/monback/porygonb.pic"
AerodactylPicFront:
	INCBIN "pic/bmon/aerodactyl.pic"
AerodactylPicBack:
	INCBIN "pic/monback/aerodactylb.pic"
MagnemitePicFront:
	INCBIN "pic/bmon/magnemite.pic"
MagnemitePicBack:
	INCBIN "pic/monback/magnemiteb.pic"
CharmanderPicFront:
	INCBIN "pic/bmon/charmander.pic"
CharmanderPicBack:
	INCBIN "pic/monback/charmanderb.pic"
SquirtlePicFront:
	INCBIN "pic/bmon/squirtle.pic"
SquirtlePicBack:
	INCBIN "pic/monback/squirtleb.pic"
CharmeleonPicFront:
	INCBIN "pic/bmon/charmeleon.pic"
CharmeleonPicBack:
	INCBIN "pic/monback/charmeleonb.pic"
WartortlePicFront:
	INCBIN "pic/bmon/wartortle.pic"
WartortlePicBack:
	INCBIN "pic/monback/wartortleb.pic"
CharizardPicFront:
	INCBIN "pic/bmon/charizard.pic"
CharizardPicBack:
	INCBIN "pic/monback/charizardb.pic"
FossilAerodactylPic:
	INCBIN "pic/bmon/fossilaerodactyl.pic"
GhostPic:
	INCBIN "pic/other/ghost.pic"
OddishPicFront:
	INCBIN "pic/bmon/oddish.pic"
OddishPicBack:
	INCBIN "pic/monback/oddishb.pic"
GloomPicFront:
	INCBIN "pic/bmon/gloom.pic"
GloomPicBack:
	INCBIN "pic/monback/gloomb.pic"
VileplumePicFront:
	INCBIN "pic/bmon/vileplume.pic"
VileplumePicBack:
	INCBIN "pic/monback/vileplumeb.pic"
BellsproutPicFront:
	INCBIN "pic/bmon/bellsprout.pic"
BellsproutPicBack:
	INCBIN "pic/monback/bellsproutb.pic"
WeepinbellPicFront:
	INCBIN "pic/bmon/weepinbell.pic"
WeepinbellPicBack:
	INCBIN "pic/monback/weepinbellb.pic"
VictreebelPicFront:
	INCBIN "pic/bmon/victreebel.pic"
VictreebelPicBack:
	INCBIN "pic/monback/victreebelb.pic"

INCBIN "baserom.gbc",$37244,$37390 - $37244

UnnamedText_37390: ; 0x37390
    TX_FAR _UnnamedText_37390
    db $50
; 0x37390 + 5 bytes

INCBIN "baserom.gbc",$37395,$37467 - $37395

UnnamedText_37467: ; 0x37467
    TX_FAR _UnnamedText_37467
    db $50
; 0x37467 + 5 bytes

UnnamedText_3746c: ; 0x3746c
    TX_FAR _UnnamedText_3746c
    db $50
; 0x3746c + 5 bytes

UnnamedText_37471: ; 0x37471
    TX_FAR _UnnamedText_37471
    db $50
; 0x37471 + 5 bytes

UnnamedText_37476: ; 0x37476
    TX_FAR _UnnamedText_37476
    db $50
; 0x37476 + 5 bytes

UnnamedText_3747b: ; 0x3747b
    TX_FAR _UnnamedText_3747b
    db $50
; 0x3747b + 5 bytes

INCBIN "baserom.gbc",$37480,$37673 - $37480

UnnamedText_37673: ; 0x37673
    TX_FAR _UnnamedText_37673
    db $50
; 0x37673 + 5 bytes

INCBIN "baserom.gbc",$37678,$3769d - $37678

UnnamedText_3769d: ; 0x3769d
    TX_FAR _UnnamedText_3769d
    db $50
; 0x3769d + 5 bytes

INCBIN "baserom.gbc",$376a2,$44f

IF _RED
	INCBIN "gfx/red/slotmachine1.2bpp"
ENDC
IF _BLUE
	INCBIN "gfx/blue/slotmachine1.2bpp"
ENDC

INCBIN "baserom.gbc",$37ca1,$37e79 - $37ca1

UnnamedText_37e79: ; 0x37e79
    TX_FAR _UnnamedText_37e79
    db $50
; 0x37e79 + 5 bytes

UnnamedText_37e7e: ; 0x37e7e
    TX_FAR _UnnamedText_37e7e
    db $50
; 0x37e7e + 5 bytes

UnnamedText_37e83: ; 0x37e83
    TX_FAR _UnnamedText_37e83
    db $50
; 0x37e83 + 5 bytes

SECTION "bankE",DATA,BANK[$E]

Attacks: ; 4000
; characteristics of each attack
; animation, effect, power, type, accuracy, PP
db POUND       ,$00,$28,NORMAL,$FF,35
db KARATE_CHOP ,$00,$32,NORMAL,$FF,25
db DOUBLESLAP  ,$1D,$0F,NORMAL,$D8,10
db COMET_PUNCH ,$1D,$12,NORMAL,$D8,15
db MEGA_PUNCH  ,$00,$50,NORMAL,$D8,20
db PAY_DAY     ,$10,$28,NORMAL,$FF,20
db FIRE_PUNCH  ,$04,$4B,FIRE,$FF,15
db ICE_PUNCH   ,$05,$4B,ICE,$FF,15
db THUNDERPUNCH,$06,$4B,ELECTRIC,$FF,15
db SCRATCH     ,$00,$28,NORMAL,$FF,35
db VICEGRIP    ,$00,$37,NORMAL,$FF,30
db GUILLOTINE  ,$26,$01,NORMAL,$4C,5
db RAZOR_WIND  ,$27,$50,NORMAL,$BF,10
db SWORDS_DANCE,$32,$00,NORMAL,$FF,30
db CUT         ,$00,$32,NORMAL,$F2,30
db GUST        ,$00,$28,NORMAL,$FF,35
db WING_ATTACK ,$00,$23,FLYING,$FF,35
db WHIRLWIND   ,$1C,$00,NORMAL,$D8,20
db FLY         ,$2B,$46,FLYING,$F2,15
db BIND        ,$2A,$0F,NORMAL,$BF,20
db SLAM        ,$00,$50,NORMAL,$BF,20
db VINE_WHIP   ,$00,$23,GRASS,$FF,10
db STOMP       ,$25,$41,NORMAL,$FF,20
db DOUBLE_KICK ,$2C,$1E,FIGHTING,$FF,30
db MEGA_KICK   ,$00,$78,NORMAL,$BF,5
db JUMP_KICK   ,$2D,$46,FIGHTING,$F2,25
db ROLLING_KICK,$25,$3C,FIGHTING,$D8,15
db SAND_ATTACK ,$16,$00,NORMAL,$FF,15
db HEADBUTT    ,$25,$46,NORMAL,$FF,15
db HORN_ATTACK ,$00,$41,NORMAL,$FF,25
db FURY_ATTACK ,$1D,$0F,NORMAL,$D8,20
db HORN_DRILL  ,$26,$01,NORMAL,$4C,5
db TACKLE      ,$00,$23,NORMAL,$F2,35
db BODY_SLAM   ,$24,$55,NORMAL,$FF,15
db WRAP        ,$2A,$0F,NORMAL,$D8,20
db TAKE_DOWN   ,$30,$5A,NORMAL,$D8,20
db THRASH      ,$1B,$5A,NORMAL,$FF,20
db DOUBLE_EDGE ,$30,$64,NORMAL,$FF,15
db TAIL_WHIP   ,$13,$00,NORMAL,$FF,30
db POISON_STING,$02,$0F,POISON,$FF,35
db TWINEEDLE   ,$4D,$19,BUG,$FF,20
db PIN_MISSILE ,$1D,$0E,BUG,$D8,20
db LEER        ,$13,$00,NORMAL,$FF,30
db BITE        ,$1F,$3C,NORMAL,$FF,25
db GROWL       ,$12,$00,NORMAL,$FF,40
db ROAR        ,$1C,$00,NORMAL,$FF,20
db SING        ,$20,$00,NORMAL,$8C,15
db SUPERSONIC  ,$31,$00,NORMAL,$8C,20
db SONICBOOM   ,$29,$01,NORMAL,$E5,20
db DISABLE     ,$56,$00,NORMAL,$8C,20
db ACID        ,$45,$28,POISON,$FF,30
db EMBER       ,$04,$28,FIRE,$FF,25
db FLAMETHROWER,$04,$5F,FIRE,$FF,15
db MIST        ,$2E,$00,ICE,$FF,30
db WATER_GUN   ,$00,$28,WATER,$FF,25
db HYDRO_PUMP  ,$00,$78,WATER,$CC,5
db SURF        ,$00,$5F,WATER,$FF,15
db ICE_BEAM    ,$05,$5F,ICE,$FF,10
db BLIZZARD    ,$05,$78,ICE,$E5,5
db PSYBEAM     ,$4C,$41,PSYCHIC,$FF,20
db BUBBLEBEAM  ,$46,$41,WATER,$FF,20
db AURORA_BEAM ,$44,$41,ICE,$FF,20
db HYPER_BEAM  ,$50,$96,NORMAL,$E5,5
db PECK        ,$00,$23,FLYING,$FF,35
db DRILL_PECK  ,$00,$50,FLYING,$FF,20
db SUBMISSION  ,$30,$50,FIGHTING,$CC,25
db LOW_KICK    ,$25,$32,FIGHTING,$E5,20
db COUNTER     ,$00,$01,FIGHTING,$FF,20
db SEISMIC_TOSS,$29,$01,FIGHTING,$FF,20
db STRENGTH    ,$00,$50,NORMAL,$FF,15
db ABSORB      ,$03,$14,GRASS,$FF,20
db MEGA_DRAIN  ,$03,$28,GRASS,$FF,10
db LEECH_SEED  ,$54,$00,GRASS,$E5,10
db GROWTH      ,$0D,$00,NORMAL,$FF,40
db RAZOR_LEAF  ,$00,$37,GRASS,$F2,25
db SOLARBEAM   ,$27,$78,GRASS,$FF,10
db POISONPOWDER,$42,$00,POISON,$BF,35
db STUN_SPORE  ,$43,$00,GRASS,$BF,30
db SLEEP_POWDER,$20,$00,GRASS,$BF,15
db PETAL_DANCE ,$1B,$46,GRASS,$FF,20
db STRING_SHOT ,$14,$00,BUG,$F2,40
db DRAGON_RAGE ,$29,$01,DRAGON,$FF,10
db FIRE_SPIN   ,$2A,$0F,FIRE,$B2,15
db THUNDERSHOCK,$06,$28,ELECTRIC,$FF,30
db THUNDERBOLT ,$06,$5F,ELECTRIC,$FF,15
db THUNDER_WAVE,$43,$00,ELECTRIC,$FF,20
db THUNDER     ,$06,$78,ELECTRIC,$B2,10
db ROCK_THROW  ,$00,$32,ROCK,$A5,15
db EARTHQUAKE  ,$00,$64,GROUND,$FF,10
db FISSURE     ,$26,$01,GROUND,$4C,5
db DIG         ,$27,$64,GROUND,$FF,10
db TOXIC       ,$42,$00,POISON,$D8,10
db CONFUSION   ,$4C,$32,PSYCHIC,$FF,25
db PSYCHIC_M   ,$47,$5A,PSYCHIC,$FF,10
db HYPNOSIS    ,$20,$00,PSYCHIC,$99,20
db MEDITATE    ,$0A,$00,PSYCHIC,$FF,40
db AGILITY     ,$34,$00,PSYCHIC,$FF,30
db QUICK_ATTACK,$00,$28,NORMAL,$FF,30
db RAGE        ,$51,$14,NORMAL,$FF,20
db TELEPORT    ,$1C,$00,PSYCHIC,$FF,20
db NIGHT_SHADE ,$29,$00,GHOST,$FF,15
db MIMIC       ,$52,$00,NORMAL,$FF,10
db SCREECH     ,$3B,$00,NORMAL,$D8,40
db DOUBLE_TEAM ,$0F,$00,NORMAL,$FF,15
db RECOVER     ,$38,$00,NORMAL,$FF,20
db HARDEN      ,$0B,$00,NORMAL,$FF,30
db MINIMIZE    ,$0F,$00,NORMAL,$FF,20
db SMOKESCREEN ,$16,$00,NORMAL,$FF,20
db CONFUSE_RAY ,$31,$00,GHOST,$FF,10
db WITHDRAW    ,$0B,$00,WATER,$FF,40
db DEFENSE_CURL,$0B,$00,NORMAL,$FF,40
db BARRIER     ,$33,$00,PSYCHIC,$FF,30
db LIGHT_SCREEN,$40,$00,PSYCHIC,$FF,30
db HAZE        ,$19,$00,ICE,$FF,30
db REFLECT     ,$41,$00,PSYCHIC,$FF,20
db FOCUS_ENERGY,$2F,$00,NORMAL,$FF,30
db BIDE        ,$1A,$00,NORMAL,$FF,10
db METRONOME   ,$53,$00,NORMAL,$FF,10
db MIRROR_MOVE ,$09,$00,FLYING,$FF,20
db SELFDESTRUCT,$07,$82,NORMAL,$FF,5
db EGG_BOMB    ,$00,$64,NORMAL,$BF,10
db LICK        ,$24,$14,GHOST,$FF,30
db SMOG        ,$21,$14,POISON,$B2,20
db SLUDGE      ,$21,$41,POISON,$FF,20
db BONE_CLUB   ,$1F,$41,GROUND,$D8,20
db FIRE_BLAST  ,$22,$78,FIRE,$D8,5
db WATERFALL   ,$00,$50,WATER,$FF,15
db CLAMP       ,$2A,$23,WATER,$BF,10
db SWIFT       ,$11,$3C,NORMAL,$FF,20
db SKULL_BASH  ,$27,$64,NORMAL,$FF,15
db SPIKE_CANNON,$1D,$14,NORMAL,$FF,15
db CONSTRICT   ,$46,$0A,NORMAL,$FF,35
db AMNESIA     ,$35,$00,PSYCHIC,$FF,20
db KINESIS     ,$16,$00,PSYCHIC,$CC,15
db SOFTBOILED  ,$38,$00,NORMAL,$FF,10
db HI_JUMP_KICK,$2D,$55,FIGHTING,$E5,20
db GLARE       ,$43,$00,NORMAL,$BF,30
db DREAM_EATER ,$08,$64,PSYCHIC,$FF,15
db POISON_GAS  ,$42,$00,POISON,$8C,40
db BARRAGE     ,$1D,$0F,NORMAL,$D8,20
db LEECH_LIFE  ,$03,$14,BUG,$FF,15
db LOVELY_KISS ,$20,$00,NORMAL,$BF,10
db SKY_ATTACK  ,$27,$8C,FLYING,$E5,5
db TRANSFORM   ,$39,$00,NORMAL,$FF,10
db BUBBLE      ,$46,$14,WATER,$FF,30
db DIZZY_PUNCH ,$00,$46,NORMAL,$FF,10
db SPORE       ,$20,$00,GRASS,$FF,15
db FLASH       ,$16,$00,NORMAL,$B2,20
db PSYWAVE     ,$29,$01,PSYCHIC,$CC,15
db SPLASH      ,$55,$00,NORMAL,$FF,40
db ACID_ARMOR  ,$33,$00,POISON,$FF,40
db CRABHAMMER  ,$00,$5A,WATER,$D8,10
db EXPLOSION   ,$07,$AA,NORMAL,$FF,5
db FURY_SWIPES ,$1D,$12,NORMAL,$CC,15
db BONEMERANG  ,$2C,$32,GROUND,$E5,10
db REST        ,$38,$00,PSYCHIC,$FF,10
db ROCK_SLIDE  ,$00,$4B,ROCK,$E5,10
db HYPER_FANG  ,$1F,$50,NORMAL,$E5,15
db SHARPEN     ,$0A,$00,NORMAL,$FF,30
db CONVERSION  ,$18,$00,NORMAL,$FF,30
db TRI_ATTACK  ,$00,$50,NORMAL,$FF,10
db SUPER_FANG  ,$28,$01,NORMAL,$E5,10
db SLASH       ,$00,$46,NORMAL,$FF,20
db SUBSTITUTE  ,$4F,$00,NORMAL,$FF,10
db STRUGGLE    ,$30,$32,NORMAL,$FF,10

INCBIN "baserom.gbc",$383DE,$39884 - $383DE

ReadAttack: ; 5884
	push hl
	push de
	push bc
	dec a
	ld hl,Attacks
	ld bc,6
	call AddNTimes
	ld de,$CFCC
	call CopyData
	pop bc
	pop de
	pop hl
	ret

; trainer data: from 5C53 to 652E

INCBIN "baserom.gbc",$3989B,$39914 - $3989B

; trainer pic pointers and base money.
dw YoungsterPic
db 0,$15,0

dw BugCatcherPic
db 0,$10,0

dw LassPic
db 0,$15,0

dw SailorPic
db 0,$30,0

dw JrTrainerMPic
db 0,$20,0

dw JrTrainerFPic
db 0,$20,0

dw PokemaniacPic
db 0,$50,0

dw SuperNerdPic
db 0,$25,0

dw HikerPic
db 0,$35,0

dw BikerPic
db 0,$20,0

dw BurglarPic
db 0,$90,0

dw EngineerPic
db 0,$50,0

dw JugglerPic
db 0,$35,0

dw FisherPic
db 0,$35,0

dw SwimmerPic
db 0,$05,0

dw CueBallPic
db 0,$25,0

dw GamblerPic
db 0,$70,0

dw BeautyPic
db 0,$70,0

dw PsychicPic
db 0,$10,0

dw RockerPic
db 0,$25,0

dw JugglerPic
db 0,$35,0

dw TamerPic
db 0,$40,0

dw BirdKeeperPic
db 0,$25,0

dw BlackbeltPic
db 0,$25,0

dw Rival1Pic
db 0,$35,0

dw ProfOakPic
db 0,$99,0

dw ChiefPic
db 0,$30,0

dw ScientistPic
db 0,$50,0

dw GiovanniPic
db 0,$99,0

dw RocketPic
db 0,$30,0

dw CooltrainerMPic
db 0,$35,0

dw CooltrainerFPic
db 0,$35,0

dw BrunoPic
db 0,$99,0

dw BrockPic
db 0,$99,0

dw MistyPic
db 0,$99,0

dw LtSurgePic
db 0,$99,0

dw ErikaPic
db 0,$99,0

dw KogaPic
db 0,$99,0

dw BlainePic
db 0,$99,0

dw SabrinaPic
db 0,$99,0

dw GentlemanPic
db 0,$70,0

dw Rival2Pic
db 0,$65,0

dw Rival3Pic
db 0,$99,0

dw LoreleiPic
db 0,$99,0

dw ChannelerPic
db 0,$30,0

dw AgathaPic
db 0,$99,0

dw LancePic
db 0,$99,0

TrainerNames: ; 59FF
	db "YOUNGSTER@"
	db "BUG CATCHER@"
	db "LASS@"
	db "SAILOR@"
	db "JR.TRAINER♂@"
	db "JR.TRAINER♀@"
	db "POKéMANIAC@"
	db "SUPER NERD@"
	db "HIKER@"
	db "BIKER@"
	db "BURGLAR@"
	db "ENGINEER@"
	db "JUGGLER@"
	db "FISHERMAN@"
	db "SWIMMER@"
	db "CUE BALL@"
	db "GAMBLER@"
	db "BEAUTY@"
	db "PSYCHIC@"
	db "ROCKER@"
	db "JUGGLER@"
	db "TAMER@"
	db "BIRD KEEPER@"
	db "BLACKBELT@"
	db "RIVAL1@"
	db "PROF.OAK@"
	db "CHIEF@"
	db "SCIENTIST@"
	db "GIOVANNI@"
	db "ROCKET@"
	db "COOLTRAINER♂@"
	db "COOLTRAINER♀@"
	db "BRUNO@"
	db "BROCK@"
	db "MISTY@"
	db "LT.SURGE@"
	db "ERIKA@"
	db "KOGA@"
	db "BLAINE@"
	db "SABRINA@"
	db "GENTLEMAN@"
	db "RIVAL2@"
	db "RIVAL3@"
	db "LORELEI@"
	db "CHANNELER@"
	db "AGATHA@"
	db "LANCE@"

INCBIN "baserom.gbc",$39B87,$39C53 - $39B87

ReadTrainer: ; 5C53

; don't change any moves in a link battle
	ld a,[W_ISLINKBATTLE]
	and a
	ret nz

; set [W_ENEMYMONCOUNT] to 0, [$D89D] to FF
; XXX first is total enemy pokemon?
; XXX second is species of first pokemon?
	ld hl,W_ENEMYMONCOUNT
	xor a
	ld [hli],a
	dec a
	ld [hl],a

; get the pointer to trainer data for this class
	ld a,[W_CUROPPONENT]
	sub $C9 ; convert value from pokemon to trainer
	add a,a
	ld hl,TrainerDataPointers
	ld c,a
	ld b,0
	add hl,bc ; hl points to trainer class
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[W_TRAINERNO]
	ld b,a
; At this point b contains the trainer number,
; and hl points to the trainer class.
; Our next task is to iterate through the trainers,
; decrementing b each time, until we get to the right one.
.outer\@
	dec b
	jr z,.IterateTrainer
.inner\@
	ld a,[hli]
	and a
	jr nz,.inner\@
	jr .outer\@

; if the first byte of trainer data is FF,
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [W_LONEATTACKNO] != 0, one pokemon on the team has a special move
; else the first byte is the level of every pokemon on the team
.IterateTrainer
	ld a,[hli]
	cp $FF ; is the trainer special?
	jr z,.SpecialTrainer\@ ; if so, check for special attacks
	ld [W_CURENEMYLVL],a
.LoopTrainerData\@
	ld a,[hli]
	and a ; have we reached the end of the trainer data?
	jr z,.FinishUp\@
	ld [$CF91],a ; write species somewhere (XXX why?)
	ld a,1
	ld [$CC49],a
	push hl
	call AddPokemonToParty
	pop hl
	jr .LoopTrainerData\@
.SpecialTrainer\@
; if this code is being run:
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [W_LONEATTACKNO] != 0, one pokemon on the team has a special move
	ld a,[hli]
	and a ; have we reached the end of the trainer data?
	jr z,.AddLoneAttack\@
	ld [W_CURENEMYLVL],a
	ld a,[hli]
	ld [$CF91],a
	ld a,1
	ld [$CC49],a
	push hl
	call AddPokemonToParty
	pop hl
	jr .SpecialTrainer\@
.AddLoneAttack\@
; does the trainer have a single monster with a different move
	ld a,[W_LONEATTACKNO] ; Brock is 01, Misty is 02, Erika is 04, etc
	and a
	jr z,.AddTeamAttack\@
	dec a
	add a,a
	ld c,a
	ld b,0
	ld hl,LoneAttacks
	add hl,bc
	ld a,[hli]
	ld d,[hl]
	ld hl,W_ENEMYMON1MOVE3
	ld bc,W_ENEMYMON2MOVE3 - W_ENEMYMON1MOVE3
	call AddNTimes
	ld [hl],d
	jr .FinishUp\@
.AddTeamAttack\@
; check if our trainer's team has special moves

; get trainer class number
	ld a,[$D059]
	sub $C8
	ld b,a
	ld hl,TeamAttacks

; iterate through entries in TeamAttacks, checking each for our trainer class
.IterateTeamAttacks\@
	ld a,[hli]
	cp b
	jr z,.GiveTeamAttacks\@ ; is there a match?
	inc hl ; if not, go to the next entry
	inc a
	jr nz,.IterateTeamAttacks\@

	; no matches found. is this trainer champion rival?
	ld a,b
	cp SONY3
	jr z,.ChampionRival\@
	jr .FinishUp\@ ; nope
.GiveTeamAttacks\@
	ld a,[hl]
	ld [$D95E],a
	jr .FinishUp\@
.ChampionRival\@ ; give attacks to his team

; pidgeot
	ld a,SKY_ATTACK
	ld [W_ENEMYMON1MOVE3],a

; starter
	ld a,[W_RIVALSTARTER]
	cp BULBASAUR
	ld b,MEGA_DRAIN
	jr z,.GiveStarterMove\@
	cp CHARMANDER
	ld b,FIRE_BLAST
	jr z,.GiveStarterMove\@
	ld b,BLIZZARD ; must be squirtle
.GiveStarterMove\@
	ld a,b
	ld [W_ENEMYMON6MOVE3],a
.FinishUp\@ ; XXX this needs documenting
	xor a       ; clear D079-D07B
	ld de,$D079
	ld [de],a
	inc de
	ld [de],a
	inc de
	ld [de],a
	ld a,[W_CURENEMYLVL]
	ld b,a
.LastLoop\@
	ld hl,$D047
	ld c,2
	push bc
	ld a,$B
	call Predef
	pop bc
	inc de
	inc de
	dec b
	jr nz,.LastLoop\@
	ret

LoneAttacks: ; 5D22
; these are used for gym leaders.
; this is not automatic! you have to write the number you want to W_LONEATTACKNO
; first. e.g., erika's script writes 4 to W_LONEATTACKNO to get mega drain,
; the fourth entry in the list.

; first byte:  pokemon in the trainer's party that gets the move
; second byte: move
; unterminated
	db 1,BIDE
	db 1,BUBBLEBEAM
	db 2,THUNDERBOLT
	db 2,MEGA_DRAIN
	db 3,TOXIC
	db 3,PSYWAVE
	db 3,FIRE_BLAST
	db 4,FISSURE

TeamAttacks: ; 5D32
; these are used for elite four.
; this is automatic, based on trainer class.
; don't be confused by LoneAttacks above, the two data structures are
	; _completely_ unrelated.

; first byte: trainer (all trainers in this class have this move)
; second byte: move
; ff-terminated
	db LORELEI,BLIZZARD
	db BRUNO,FISSURE
	db AGATHA,TOXIC
	db LANCE,BARRIER
	db $FF

TrainerDataPointers: ; 5D3B
	dw YoungsterData,BugCatcherData,LassData,SailorData,JrTrainerMData
	dw JrTrainerFData,PokemaniacData,SuperNerdData,HikerData,BikerData
	dw BurglarData,EngineerData,Juggler1Data,FisherData,SwimmerData
	dw CueBallData,GamblerData,BeautyData,PsychicData,RockerData
	dw JugglerData,TamerData,BirdKeeperData,BlackbeltData,Green1Data
	dw ProfOakData,ChiefData,ScientistData,GiovanniData,RocketData
	dw CooltrainerMData,CooltrainerFData,BrunoData,BrockData,MistyData
	dw LtSurgeData,ErikaData,KogaData,BlaineData,SabrinaData
	dw GentlemanData,Green2Data,Green3Data,LoreleiData,ChannelerData
	dw AgathaData,LanceData

; if first byte != FF, then
	; first byte is level (of all pokemon on this team)
	; all the next bytes are pokemon species
	; null-terminated
; if first byte == FF, then
	; first byte is FF (obviously)
	; every next two bytes are a level and species
	; null-terminated

YoungsterData:
	db 11,RATTATA,EKANS,0
	db 14,SPEAROW,0
	db 10,RATTATA,RATTATA,ZUBAT,0
	db 14,RATTATA,EKANS,ZUBAT,0
	db 15,RATTATA,SPEAROW,0
	db 17,SLOWPOKE,0
	db 14,EKANS,SANDSHREW,0
	db 21,NIDORAN_M,0
	db 21,EKANS,0
	db 19,SANDSHREW,ZUBAT,0
	db 17,RATTATA,RATTATA,RATICATE,0
	db 18,NIDORAN_M,NIDORINO,0
	db 17,SPEAROW,RATTATA,RATTATA,SPEAROW,0
BugCatcherData:
	db 6,WEEDLE,CATERPIE,0
	db 7,WEEDLE,KAKUNA,WEEDLE,0
	db 9,WEEDLE,0
	db 10,CATERPIE,WEEDLE,CATERPIE,0
	db 9,WEEDLE,KAKUNA,CATERPIE,METAPOD,0
	db 11,CATERPIE,METAPOD,0
	db 11,WEEDLE,KAKUNA,0
	db 10,CATERPIE,METAPOD,CATERPIE,0
	db 14,CATERPIE,WEEDLE,0
	db 16,WEEDLE,CATERPIE,WEEDLE,0
	db 20,BUTTERFREE,0
	db 18,METAPOD,CATERPIE,VENONAT,0
	db 19,BEEDRILL,BEEDRILL,0
	db 20,CATERPIE,WEEDLE,VENONAT,0
LassData:
	db 9,PIDGEY,PIDGEY,0
	db 10,RATTATA,NIDORAN_M,0
	db 14,JIGGLYPUFF,0
	db 31,PARAS,PARAS,PARASECT,0
	db 11,ODDISH,BELLSPROUT,0
	db 14,CLEFAIRY,0
	db 16,PIDGEY,NIDORAN_F,0
	db 14,PIDGEY,NIDORAN_F,0
	db 15,NIDORAN_M,NIDORAN_F,0
	db 13,ODDISH,PIDGEY,ODDISH,0
	db 18,PIDGEY,NIDORAN_F,0
	db 18,RATTATA,PIKACHU,0
	db 23,NIDORAN_F,NIDORINA,0
	db 24,MEOWTH,MEOWTH,MEOWTH,0
	db 19,PIDGEY,RATTATA,NIDORAN_M,MEOWTH,PIKACHU,0
	db 22,CLEFAIRY,CLEFAIRY,0
	db 23,BELLSPROUT,WEEPINBELL,0
	db 23,ODDISH,GLOOM,0
SailorData:
	db 18,MACHOP,SHELLDER,0
	db 17,MACHOP,TENTACOOL,0
	db 21,SHELLDER,0
	db 17,HORSEA,SHELLDER,TENTACOOL,0
	db 18,TENTACOOL,STARYU,0
	db 17,HORSEA,HORSEA,HORSEA,0
	db 20,MACHOP,0
	db 21,PIKACHU,PIKACHU,0
JrTrainerMData:
	db 11,DIGLETT,SANDSHREW,0
	db 14,RATTATA,EKANS,0
	db 18,MANKEY,0
	db 20,SQUIRTLE,0
	db 16,SPEAROW,RATICATE,0
	db 18,DIGLETT,DIGLETT,SANDSHREW,0
	db 21,GROWLITHE,CHARMANDER,0
	db 19,RATTATA,DIGLETT,EKANS,SANDSHREW,0
	db 29,NIDORAN_M,NIDORINO,0
JrTrainerFData:
	db 19,GOLDEEN,0
	db 16,RATTATA,PIKACHU,0
	db 16,PIDGEY,PIDGEY,PIDGEY,0
	db 22,BULBASAUR,0
	db 18,ODDISH,BELLSPROUT,ODDISH,BELLSPROUT,0
	db 23,MEOWTH,0
	db 20,PIKACHU,CLEFAIRY,0
	db 21,PIDGEY,PIDGEOTTO,0
	db 21,JIGGLYPUFF,PIDGEY,MEOWTH,0
	db 22,ODDISH,BULBASAUR,0
	db 24,BULBASAUR,IVYSAUR,0
	db 24,PIDGEY,MEOWTH,RATTATA,PIKACHU,MEOWTH,0
	db 30,POLIWAG,POLIWAG,0
	db 27,PIDGEY,MEOWTH,PIDGEY,PIDGEOTTO,0
	db 28,GOLDEEN,POLIWAG,HORSEA,0
	db 31,GOLDEEN,SEAKING,0
	db 22,BELLSPROUT,CLEFAIRY,0
	db 20,MEOWTH,ODDISH,PIDGEY,0
	db 19,PIDGEY,RATTATA,RATTATA,BELLSPROUT,0
	db 28,GLOOM,ODDISH,ODDISH,0
	db 29,PIKACHU,RAICHU,0
	db 33,CLEFAIRY,0
	db 29,BELLSPROUT,ODDISH,TANGELA,0
	db 30,TENTACOOL,HORSEA,SEEL,0
PokemaniacData:
	db 30,RHYHORN,LICKITUNG,0
	db 20,CUBONE,SLOWPOKE,0
	db 20,SLOWPOKE,SLOWPOKE,SLOWPOKE,0
	db 22,CHARMANDER,CUBONE,0
	db 25,SLOWPOKE,0
	db 40,CHARMELEON,LAPRAS,LICKITUNG,0
	db 23,CUBONE,SLOWPOKE,0
SuperNerdData:
	db 11,MAGNEMITE,VOLTORB,0
	db 12,GRIMER,VOLTORB,KOFFING,0
	db 20,VOLTORB,KOFFING,VOLTORB,MAGNEMITE,0
	db 22,GRIMER,MUK,GRIMER,0
	db 26,KOFFING,0
	db 22,KOFFING,MAGNEMITE,WEEZING,0
	db 20,MAGNEMITE,MAGNEMITE,KOFFING,MAGNEMITE,0
	db 24,MAGNEMITE,VOLTORB,0
	db 36,VULPIX,VULPIX,NINETALES,0
	db 34,PONYTA,CHARMANDER,VULPIX,GROWLITHE,0
	db 41,RAPIDASH,0
	db 37,GROWLITHE,VULPIX,0
HikerData:
	db 10,GEODUDE,GEODUDE,ONIX,0
	db 15,MACHOP,GEODUDE,0
	db 13,GEODUDE,GEODUDE,MACHOP,GEODUDE,0
	db 17,ONIX,0
	db 21,GEODUDE,ONIX,0
	db 20,GEODUDE,MACHOP,GEODUDE,0
	db 21,GEODUDE,ONIX,0
	db 19,ONIX,GRAVELER,0
	db 21,GEODUDE,GEODUDE,GRAVELER,0
	db 25,GEODUDE,0
	db 20,MACHOP,ONIX,0
	db 19,GEODUDE,MACHOP,GEODUDE,GEODUDE,0
	db 20,ONIX,ONIX,GEODUDE,0
	db 21,GEODUDE,GRAVELER,0
BikerData:
	db 28,KOFFING,KOFFING,KOFFING,0
	db 29,KOFFING,GRIMER,0
	db 25,KOFFING,KOFFING,WEEZING,KOFFING,GRIMER,0
	db 28,KOFFING,GRIMER,WEEZING,0
	db 29,GRIMER,KOFFING,0
	db 33,WEEZING,0
	db 26,GRIMER,GRIMER,GRIMER,GRIMER,0
	db 28,WEEZING,KOFFING,WEEZING,0
	db 33,MUK,0
	db 29,VOLTORB,VOLTORB,0
	db 29,WEEZING,MUK,0
	db 25,KOFFING,WEEZING,KOFFING,KOFFING,WEEZING,0
	db 26,KOFFING,KOFFING,GRIMER,KOFFING,0
	db 28,GRIMER,GRIMER,KOFFING,0
	db 29,KOFFING,MUK,0
BurglarData:
	db 29,GROWLITHE,VULPIX,0
	db 33,GROWLITHE,0
	db 28,VULPIX,CHARMANDER,PONYTA,0
	db 36,GROWLITHE,VULPIX,NINETALES,0
	db 41,PONYTA,0
	db 37,VULPIX,GROWLITHE,0
	db 34,CHARMANDER,CHARMELEON,0
	db 38,NINETALES,0
	db 34,GROWLITHE,PONYTA,0
EngineerData:
	db 21,VOLTORB,MAGNEMITE,0
	db 21,MAGNEMITE,0
	db 18,MAGNEMITE,MAGNEMITE,MAGNETON,0
Juggler1Data:
; none
FisherData:
	db 17,GOLDEEN,TENTACOOL,GOLDEEN,0
	db 17,TENTACOOL,STARYU,SHELLDER,0
	db 22,GOLDEEN,POLIWAG,GOLDEEN,0
	db 24,TENTACOOL,GOLDEEN,0
	db 27,GOLDEEN,0
	db 21,POLIWAG,SHELLDER,GOLDEEN,HORSEA,0
	db 28,SEAKING,GOLDEEN,SEAKING,SEAKING,0
	db 31,SHELLDER,CLOYSTER,0
	db 27,MAGIKARP,MAGIKARP,MAGIKARP,MAGIKARP,MAGIKARP,MAGIKARP,0
	db 33,SEAKING,GOLDEEN,0
	db 24,MAGIKARP,MAGIKARP,0
SwimmerData:
	db 16,HORSEA,SHELLDER,0
	db 30,TENTACOOL,SHELLDER,0
	db 29,GOLDEEN,HORSEA,STARYU,0
	db 30,POLIWAG,POLIWHIRL,0
	db 27,HORSEA,TENTACOOL,TENTACOOL,GOLDEEN,0
	db 29,GOLDEEN,SHELLDER,SEAKING,0
	db 30,HORSEA,HORSEA,0
	db 27,TENTACOOL,TENTACOOL,STARYU,HORSEA,TENTACRUEL,0
	db 31,SHELLDER,CLOYSTER,0
	db 35,STARYU,0
	db 28,HORSEA,HORSEA,SEADRA,HORSEA,0
	db 33,SEADRA,TENTACRUEL,0
	db 37,STARMIE,0
	db 33,STARYU,WARTORTLE,0
	db 32,POLIWHIRL,TENTACOOL,SEADRA,0
CueBallData:
	db 28,MACHOP,MANKEY,MACHOP,0
	db 29,MANKEY,MACHOP,0
	db 33,MACHOP,0
	db 29,MANKEY,PRIMEAPE,0
	db 29,MACHOP,MACHOKE,0
	db 33,MACHOKE,0
	db 26,MANKEY,MANKEY,MACHOKE,MACHOP,0
	db 29,PRIMEAPE,MACHOKE,0
	db 31,TENTACOOL,TENTACOOL,TENTACRUEL,0
GamblerData:
	db 18,POLIWAG,HORSEA,0
	db 18,BELLSPROUT,ODDISH,0
	db 18,VOLTORB,MAGNEMITE,0
	db 18,GROWLITHE,VULPIX,0
	db 22,POLIWAG,POLIWAG,POLIWHIRL,0
	db 22,ONIX,GEODUDE,GRAVELER,0
	db 24,GROWLITHE,VULPIX,0
BeautyData:
	db 21,ODDISH,BELLSPROUT,ODDISH,BELLSPROUT,0
	db 24,BELLSPROUT,BELLSPROUT,0
	db 26,EXEGGCUTE,0
	db 27,RATTATA,PIKACHU,RATTATA,0
	db 29,CLEFAIRY,MEOWTH,0
	db 35,SEAKING,0
	db 30,SHELLDER,SHELLDER,CLOYSTER,0
	db 31,POLIWAG,SEAKING,0
	db 29,PIDGEOTTO,WIGGLYTUFF,0
	db 29,BULBASAUR,IVYSAUR,0
	db 33,WEEPINBELL,BELLSPROUT,WEEPINBELL,0
	db 27,POLIWAG,GOLDEEN,SEAKING,GOLDEEN,POLIWAG,0
	db 30,GOLDEEN,SEAKING,0
	db 29,STARYU,STARYU,STARYU,0
	db 30,SEADRA,HORSEA,SEADRA,0
PsychicData:
	db 31,KADABRA,SLOWPOKE,MR_MIME,KADABRA,0
	db 34,MR_MIME,KADABRA,0
	db 33,SLOWPOKE,SLOWPOKE,SLOWBRO,0
	db 38,SLOWBRO,0
RockerData:
	db 20,VOLTORB,MAGNEMITE,VOLTORB,0
	db 29,VOLTORB,ELECTRODE,0
JugglerData:
	db 29,KADABRA,MR_MIME,0
	db 41,DROWZEE,HYPNO,KADABRA,KADABRA,0
	db 31,DROWZEE,DROWZEE,KADABRA,DROWZEE,0
	db 34,DROWZEE,HYPNO,0
	db 48,MR_MIME,0
	db 33,HYPNO,0
	db 38,HYPNO,0
	db 34,DROWZEE,KADABRA,0
TamerData:
	db 34,SANDSLASH,ARBOK,0
	db 33,ARBOK,SANDSLASH,ARBOK,0
	db 43,RHYHORN,0
	db 39,ARBOK,TAUROS,0
	db 44,PERSIAN,GOLDUCK,0
	db 42,RHYHORN,PRIMEAPE,ARBOK,TAUROS,0
BirdKeeperData:
	db 29,PIDGEY,PIDGEOTTO,0
	db 25,SPEAROW,PIDGEY,PIDGEY,SPEAROW,SPEAROW,0
	db 26,PIDGEY,PIDGEOTTO,SPEAROW,FEAROW,0
	db 33,FARFETCH_D,0
	db 29,SPEAROW,FEAROW,0
	db 26,PIDGEOTTO,FARFETCH_D,DODUO,PIDGEY,0
	db 28,DODRIO,DODUO,DODUO,0
	db 29,SPEAROW,FEAROW,0
	db 34,DODRIO,0
	db 26,SPEAROW,SPEAROW,FEAROW,SPEAROW,0
	db 30,FEAROW,FEAROW,PIDGEOTTO,0
	db 39,PIDGEOTTO,PIDGEOTTO,PIDGEY,PIDGEOTTO,0
	db 42,FARFETCH_D,FEAROW,0
	db 28,PIDGEY,DODUO,PIDGEOTTO,0
	db 26,PIDGEY,SPEAROW,PIDGEY,FEAROW,0
	db 29,PIDGEOTTO,FEAROW,0
	db 28,SPEAROW,DODUO,FEAROW,0
BlackbeltData:
	db 37,HITMONLEE,HITMONCHAN,0
	db 31,MANKEY,MANKEY,PRIMEAPE,0
	db 32,MACHOP,MACHOKE,0
	db 36,PRIMEAPE,0
	db 31,MACHOP,MANKEY,PRIMEAPE,0
	db 40,MACHOP,MACHOKE,0
	db 43,MACHOKE,0
	db 38,MACHOKE,MACHOP,MACHOKE,0
	db 43,MACHOKE,MACHOP,MACHOKE,0
Green1Data:
	db 5,SQUIRTLE,0
	db 5,BULBASAUR,0
	db 5,CHARMANDER,0
	db $FF,9,PIDGEY,8,SQUIRTLE,0
	db $FF,9,PIDGEY,8,BULBASAUR,0
	db $FF,9,PIDGEY,8,CHARMANDER,0
	db $FF,18,PIDGEOTTO,15,ABRA,15,RATTATA,17,SQUIRTLE,0
	db $FF,18,PIDGEOTTO,15,ABRA,15,RATTATA,17,BULBASAUR,0
	db $FF,18,PIDGEOTTO,15,ABRA,15,RATTATA,17,CHARMANDER,0
ProfOakData:
	db $FF,66,TAUROS,67,EXEGGUTOR,68,ARCANINE,69,BLASTOISE,70,GYARADOS,0
	db $FF,66,TAUROS,67,EXEGGUTOR,68,ARCANINE,69,VENUSAUR,70,GYARADOS,0
	db $FF,66,TAUROS,67,EXEGGUTOR,68,ARCANINE,69,CHARIZARD,70,GYARADOS,0
ChiefData:
; none
ScientistData:
	db 34,KOFFING,VOLTORB,0
	db 26,GRIMER,WEEZING,KOFFING,WEEZING,0
	db 28,MAGNEMITE,VOLTORB,MAGNETON,0
	db 29,ELECTRODE,WEEZING,0
	db 33,ELECTRODE,0
	db 26,MAGNETON,KOFFING,WEEZING,MAGNEMITE,0
	db 25,VOLTORB,KOFFING,MAGNETON,MAGNEMITE,KOFFING,0
	db 29,ELECTRODE,MUK,0
	db 29,GRIMER,ELECTRODE,0
	db 28,VOLTORB,KOFFING,MAGNETON,0
	db 29,MAGNEMITE,KOFFING,0
	db 33,MAGNEMITE,MAGNETON,VOLTORB,0
	db 34,MAGNEMITE,ELECTRODE,0
GiovanniData:
	db $FF,25,ONIX,24,RHYHORN,29,KANGASKHAN,0
	db $FF,37,NIDORINO,35,KANGASKHAN,37,RHYHORN,41,NIDOQUEEN,0
	db $FF,45,RHYHORN,42,DUGTRIO,44,NIDOQUEEN,45,NIDOKING,50,RHYDON,0
RocketData:
	db 13,RATTATA,ZUBAT,0
	db 11,SANDSHREW,RATTATA,ZUBAT,0
	db 12,ZUBAT,EKANS,0
	db 16,RATICATE,0
	db 17,MACHOP,DROWZEE,0
	db 15,EKANS,ZUBAT,0
	db 20,RATICATE,ZUBAT,0
	db 21,DROWZEE,MACHOP,0
	db 21,RATICATE,RATICATE,0
	db 20,GRIMER,KOFFING,KOFFING,0
	db 19,RATTATA,RATICATE,RATICATE,RATTATA,0
	db 22,GRIMER,KOFFING,0
	db 17,ZUBAT,KOFFING,GRIMER,ZUBAT,RATICATE,0
	db 20,RATTATA,RATICATE,DROWZEE,0
	db 21,MACHOP,MACHOP,0
	db 23,SANDSHREW,EKANS,SANDSLASH,0
	db 23,EKANS,SANDSHREW,ARBOK,0
	db 21,KOFFING,ZUBAT,0
	db 25,ZUBAT,ZUBAT,GOLBAT,0
	db 26,KOFFING,DROWZEE,0
	db 23,ZUBAT,RATTATA,RATICATE,ZUBAT,0
	db 26,DROWZEE,KOFFING,0
	db 29,CUBONE,ZUBAT,0
	db 25,GOLBAT,ZUBAT,ZUBAT,RATICATE,ZUBAT,0
	db 28,RATICATE,HYPNO,RATICATE,0
	db 29,MACHOP,DROWZEE,0
	db 28,EKANS,ZUBAT,CUBONE,0
	db 33,ARBOK,0
	db 33,HYPNO,0
	db 29,MACHOP,MACHOKE,0
	db 28,ZUBAT,ZUBAT,GOLBAT,0
	db 26,RATICATE,ARBOK,KOFFING,GOLBAT,0
	db 29,CUBONE,CUBONE,0
	db 29,SANDSHREW,SANDSLASH,0
	db 26,RATICATE,ZUBAT,GOLBAT,RATTATA,0
	db 28,WEEZING,GOLBAT,KOFFING,0
	db 28,DROWZEE,GRIMER,MACHOP,0
	db 28,GOLBAT,DROWZEE,HYPNO,0
	db 33,MACHOKE,0
	db 25,RATTATA,RATTATA,ZUBAT,RATTATA,EKANS,0
	db 32,CUBONE,DROWZEE,MAROWAK,0
CooltrainerMData:
	db 39,NIDORINO,NIDOKING,0
	db 43,EXEGGUTOR,CLOYSTER,ARCANINE,0
	db 43,KINGLER,TENTACRUEL,BLASTOISE,0
	db 45,KINGLER,STARMIE,0
	db 42,IVYSAUR,WARTORTLE,CHARMELEON,CHARIZARD,0
	db 44,IVYSAUR,WARTORTLE,CHARMELEON,0
	db 49,NIDOKING,0
	db 44,KINGLER,CLOYSTER,0
	db 39,SANDSLASH,DUGTRIO,0
	db 43,RHYHORN,0
CooltrainerFData:
	db 24,WEEPINBELL,GLOOM,IVYSAUR,0
	db 43,BELLSPROUT,WEEPINBELL,VICTREEBEL,0
	db 43,PARASECT,DEWGONG,CHANSEY,0
	db 46,VILEPLUME,BUTTERFREE,0
	db 44,PERSIAN,NINETALES,0
	db 45,IVYSAUR,VENUSAUR,0
	db 45,NIDORINA,NIDOQUEEN,0
	db 43,PERSIAN,NINETALES,RAICHU,0
BrunoData:
	db $FF,53,ONIX,55,HITMONCHAN,55,HITMONLEE,56,ONIX,58,MACHAMP,0
BrockData:
	db $FF,12,GEODUDE,14,ONIX,0
MistyData:
	db $FF,18,STARYU,21,STARMIE,0
LtSurgeData:
	db $FF,21,VOLTORB,18,PIKACHU,24,RAICHU,0
ErikaData:
	db $FF,29,VICTREEBEL,24,TANGELA,29,VILEPLUME,0
KogaData:
	db $FF,37,KOFFING,39,MUK,37,KOFFING,43,WEEZING,0
BlaineData:
	db $FF,42,GROWLITHE,40,PONYTA,42,RAPIDASH,47,ARCANINE,0
SabrinaData:
	db $FF,38,KADABRA,37,MR_MIME,38,VENOMOTH,43,ALAKAZAM,0
GentlemanData:
	db 18,GROWLITHE,GROWLITHE,0
	db 19,NIDORAN_M,NIDORAN_F,0
	db 23,PIKACHU,0
	db 48,PRIMEAPE,0
	db 17,GROWLITHE,PONYTA,0
Green2Data:
	db $FF,19,PIDGEOTTO,16,RATICATE,18,KADABRA,20,WARTORTLE,0
	db $FF,19,PIDGEOTTO,16,RATICATE,18,KADABRA,20,IVYSAUR,0
	db $FF,19,PIDGEOTTO,16,RATICATE,18,KADABRA,20,CHARMELEON,0
	db $FF,25,PIDGEOTTO,23,GROWLITHE,22,EXEGGCUTE,20,KADABRA,25,WARTORTLE,0
	db $FF,25,PIDGEOTTO,23,GYARADOS,22,GROWLITHE,20,KADABRA,25,IVYSAUR,0
	db $FF,25,PIDGEOTTO,23,EXEGGCUTE,22,GYARADOS,20,KADABRA,25,CHARMELEON,0
	db $FF,37,PIDGEOT,38,GROWLITHE,35,EXEGGCUTE,35,ALAKAZAM,40,BLASTOISE,0
	db $FF,37,PIDGEOT,38,GYARADOS,35,GROWLITHE,35,ALAKAZAM,40,VENUSAUR,0
	db $FF,37,PIDGEOT,38,EXEGGCUTE,35,GYARADOS,35,ALAKAZAM,40,CHARIZARD,0
	db $FF,47,PIDGEOT,45,RHYHORN,45,GROWLITHE,47,EXEGGCUTE,50,ALAKAZAM ;\
		db 53,BLASTOISE,0
	db $FF,47,PIDGEOT,45,RHYHORN,45,GYARADOS,47,GROWLITHE,50,ALAKAZAM ;\
		db 53,VENUSAUR,0
	db $FF,47,PIDGEOT,45,RHYHORN,45,EXEGGCUTE,47,GYARADOS,50,ALAKAZAM ;\
		db 53,CHARIZARD,0
Green3Data:
	db $FF,61,PIDGEOT,59,ALAKAZAM,61,RHYDON,61,ARCANINE,63,EXEGGUTOR ;\
		db 65,BLASTOISE,0
	db $FF,61,PIDGEOT,59,ALAKAZAM,61,RHYDON,61,GYARADOS,63,ARCANINE ;\
		db 65,VENUSAUR,0
	db $FF,61,PIDGEOT,59,ALAKAZAM,61,RHYDON,61,EXEGGUTOR,63,GYARADOS ;\
		db 65,CHARIZARD,0
LoreleiData:
	db $FF,54,DEWGONG,53,CLOYSTER,54,SLOWBRO,56,JYNX,56,LAPRAS,0
ChannelerData:
	db 22,GASTLY,0
	db 24,GASTLY,0
	db 23,GASTLY,GASTLY,0
	db 24,GASTLY,0
	db 23,GASTLY,0
	db 24,GASTLY,0
	db 24,HAUNTER,0
	db 22,GASTLY,0
	db 24,GASTLY,0
	db 23,GASTLY,GASTLY,0
	db 24,GASTLY,0
	db 22,GASTLY,0
	db 24,GASTLY,0
	db 23,HAUNTER,0
	db 24,GASTLY,0
	db 22,GASTLY,0
	db 24,GASTLY,0
	db 22,HAUNTER,0
	db 22,GASTLY,GASTLY,GASTLY,0
	db 24,GASTLY,0
	db 24,GASTLY,0
	db 34,GASTLY,HAUNTER,0
	db 38,HAUNTER,0
	db 33,GASTLY,GASTLY,HAUNTER,0
AgathaData:
	db $FF,56,GENGAR,56,GOLBAT,55,HAUNTER,58,ARBOK,60,GENGAR,0
LanceData:
	db $FF,58,GYARADOS,56,DRAGONAIR,56,DRAGONAIR,60,AERODACTYL ;\
		db 62,DRAGONITE,0

TrainerAI: ; 652E
;XXX called at 34964, 3c342, 3c398
	and a
	ld a,[W_ISINBATTLE]
	dec a
	ret z ; if not a trainer, we're done here
	ld a,[W_ISLINKBATTLE]
	cp 4
	ret z
	ld a,[W_TRAINERCLASS] ; what trainer class is this?
	dec a
	ld c,a
	ld b,0
	ld hl,TrainerAIPointers
	add hl,bc
	add hl,bc
	add hl,bc
	ld a,[W_AICOUNT]
	and a
	ret z ; if no AI uses left, we're done here
	inc hl
	inc a
	jr nz,.getpointer\@
	dec hl
	ld a,[hli]
	ld [W_AICOUNT],a
.getpointer\@
	ld a,[hli]
	ld h,[hl]
	ld l,a
	call GenRandom
	jp [hl]

TrainerAIPointers: ; 655C
; one entry per trainer class
; first byte, number of times (per Pokémon) it can occur
; next two bytes, pointer to AI subroutine for trainer class
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,JugglerAI ; juggler_x
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,JugglerAI ; juggler
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 2,BlackbeltAI ; blackbelt
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 1,GenericAI ; chief
	dbw 3,GenericAI
	dbw 1,GiovanniAI ; giovanni
	dbw 3,GenericAI
	dbw 2,CooltrainerMAI ; cooltrainerm
	dbw 1,CooltrainerFAI ; cooltrainerf
	dbw 2,BrunoAI ; bruno
	dbw 5,BrockAI ; brock
	dbw 1,MistyAI ; misty
	dbw 1,LtSurgeAI ; surge
	dbw 1,ErikaAI ; erika
	dbw 2,KogaAI ; koga
	dbw 2,BlaineAI ; blaine
	dbw 1,SabrinaAI ; sabrina
	dbw 3,GenericAI
	dbw 1,Sony2AI ; sony2
	dbw 1,Sony3AI ; sony3
	dbw 2,LoreleiAI ; lorelei
	dbw 3,GenericAI
	dbw 2,AgathaAI ; agatha
	dbw 1,LanceAI ; lance

JugglerAI:
	cp $40
	ret nc
	jp $672A

BlackbeltAI:
	cp $20
	ret nc
	jp AIUseXAttack

GiovanniAI:
	cp $40
	ret nc
	jp AIUseGuardSpec

CooltrainerMAI:
	cp $40
	ret nc
	jp AIUseXAttack

CooltrainerFAI:
	cp $40
	ld a,$A
	call $67CF
	jp c,AIUseHyperPotion
	ld a,5
	call $67CF
	ret nc
	jp $672A

BrockAI:
; if his active monster has a status condition, use a full heal
	ld a,[W_OPPONENTSTATUS]
	and a
	ret z
	jp AIUseFullHeal

MistyAI:
	cp $40
	ret nc
	jp AIUseXDefend

LtSurgeAI:
	cp $40
	ret nc
	jp AIUseXSpeed

ErikaAI:
	cp $80
	ret nc
	ld a,$A
	call $67CF
	ret nc
	jp AIUseSuperPotion

KogaAI:
	cp $40
	ret nc
	jp AIUseXAttack

BlaineAI:
	cp $40
	ret nc
	jp AIUseSuperPotion

SabrinaAI:
	cp $40
	ret nc
	ld a,$A
	call $67CF
	ret nc
	jp AIUseHyperPotion

Sony2AI:
	cp $20
	ret nc
	ld a,5
	call $67CF
	ret nc
	jp AIUsePotion

Sony3AI:
	cp $20
	ret nc
	ld a,5
	call $67CF
	ret nc
	jp AIUseFullRestore

LoreleiAI:
	cp $80
	ret nc
	ld a,5
	call $67CF
	ret nc
	jp AIUseSuperPotion

BrunoAI:
	cp $40
	ret nc
	jp AIUseXDefend

AgathaAI:
	cp $14
	jp c,$672A
	cp $80
	ret nc
	ld a,4
	call $67CF
	ret nc
	jp AIUseSuperPotion

LanceAI:
	cp $80
	ret nc
	ld a,5
	call $67CF
	ret nc
	jp AIUseHyperPotion

GenericAI:
	and a ; clear carry
	ret

; end of individual trainer AI routines

DecrementAICount: ; 6695
	ld hl,W_AICOUNT
	dec [hl]
	scf
	ret

Function669B: ; 669B
; XXX what does this do
	ld a,$8E
	jp $3740

AIUseFullRestore:
	call AICureStatus
	ld a,FULL_RESTORE
	ld [$CF05],a
	ld de,$CEEB
	ld hl,$CFE7
	ld a,[hld]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	inc de
	ld hl,$CFF5
	ld a,[hld]
	ld [de],a
	inc de
	ld [$CEE9],a
	ld [$CFE7],a
	ld a,[hl]
	ld [de],a
	ld [$CEEA],a
	ld [W_OPPONENTHP],a
	jr Function6718

AIUsePotion:
; enemy trainer heals his monster with a potion
	ld a,POTION
	ld b,20
	jr AIRecoverHP

AIUseSuperPotion:
; enemy trainer heals his monster with a super potion
	ld a,SUPER_POTION
	ld b,50
	jr AIRecoverHP

AIUseHyperPotion:
; enemy trainer heals his monster with a hyper potion
	ld a,HYPER_POTION
	ld b,200
	; fallthrough

AIRecoverHP: ; 66DA
; heal b HP and print "trainer used $(a) on pokemon!"
	ld [$CF05],a
	ld hl,$CFE7
	ld a,[hl]
	ld [$CEEB],a
	add b
	ld [hld],a
	ld [$CEED],a
	ld a,[hl]
	ld [$CEEC],a
	ld [$CEEE],a
	jr nc,.next\@
	inc a
	ld [hl],a
	ld [$CEEE],a
.next\@
	inc hl
	ld a,[hld]
	ld b,a
	ld de,$CFF5
	ld a,[de]
	dec de
	ld [$CEE9],a
	sub b
	ld a,[hli]
	ld b,a
	ld a,[de]
	ld [$CEEA],a
	sbc b
	jr nc,Function6718
	inc de
	ld a,[de]
	dec de
	ld [hld],a
	ld [$CEED],a
	ld a,[de]
	ld [hl],a
	ld [$CEEE],a
	; fallthrough

Function6718: ; 6718
	call AIPrintItemUse_
	ld hl,$C3CA
	xor a
	ld [$CF94],a
	ld a,$48
	call Predef
	jp DecrementAICount

Function672A: ; 672A
	ld a,[W_ENEMYMONCOUNT]
	ld c,a
	ld hl,W_ENEMYMON1HP

	ld d,0 ; keep count of unfainted monsters

	; count how many monsters haven't fainted yet
.loop\@
	ld a,[hli]
	ld b,a
	ld a,[hld]
	or b
	jr z,.Fainted\@ ; has monster fainted?
	inc d
.Fainted\@
	push bc
	ld bc,$2C
	add hl,bc
	pop bc
	dec c
	jr nz,.loop\@

	ld a,d ; how many available monsters are there?
	cp 2 ; don't bother if only 1 or 2
	jp nc,Function674B ; XXX check, does this jump when a = 2?
	and a
	ret

Function674B: ; 674B

; prepare to withdraw the active monster: copy hp, number, and status to roster

	ld a,[W_OPPONENTNUMBER]
	ld hl,W_ENEMYMON1HP
	ld bc,$2C
	call AddNTimes
	ld d,h
	ld e,l
	ld hl,W_OPPONENTHP
	ld bc,4
	call CopyData

	ld hl,AIBattleWithdrawText
	call PrintText

	ld a,1
	ld [$D11D],a
	ld hl,EnemySendOut
	ld b,BANK(EnemySendOut)
	call Bankswitch
	xor a
	ld [$D11D],a

	ld a,[W_ISLINKBATTLE]
	cp 4
	ret z
	scf
	ret

AIBattleWithdrawText:
	TX_FAR _AIBattleWithdrawText
	db "@"

AIUseFullHeal:
	call $669B
	call AICureStatus
	ld a,FULL_HEAL
	jp AIPrintItemUse

AICureStatus:
; cures the status of enemy's active pokemon
	ld a,[W_OPPONENTNUMBER]
	ld hl,$D8A8
	ld bc,$2C
	call AddNTimes
	xor a
	ld [hl],a ; clear status in enemy team roster
	ld [W_OPPONENTSTATUS],a ; clear status of active enemy
	ld hl,$D069
	res 0,[hl]
	ret

AIUseXAccuracy: ; unused
	call $669B
	ld hl,$D068
	set 0,[hl]
	ld a,X_ACCURACY
	jp AIPrintItemUse

AIUseGuardSpec:
	call $669B
	ld hl,$D068
	set 1,[hl]
	ld a,GUARD_SPEC_
	jp AIPrintItemUse

AIUseDireHit: ; unused
	call $669B
	ld hl,$D068
	set 2,[hl]
	ld a,DIRE_HIT
	jp AIPrintItemUse

Function67CF: ; 67CF
	ld [$FF99],a
	ld hl,$CFF4
	ld a,[hli]
	ld [$FF95],a
	ld a,[hl]
	ld [$FF96],a
	ld b,2
	call $38B9
	ld a,[$FF98]
	ld c,a
	ld a,[$FF97]
	ld b,a
	ld hl,$CFE7
	ld a,[hld]
	ld e,a
	ld a,[hl]
	ld d,a
	ld a,d
	sub b
	ret nz
	ld a,e
	sub c
	ret

AIUseXAttack:
	ld b,$A
	ld a,X_ATTACK
	jr AIIncreaseStat

AIUseXDefend:
	ld b,$B
	ld a,X_DEFEND
	jr AIIncreaseStat

AIUseXSpeed:
	ld b,$C
	ld a,X_SPEED
	jr AIIncreaseStat

AIUseXSpecial:
	ld b,$D
	ld a,X_SPECIAL
	; fallthrough

AIIncreaseStat:
	ld [$CF05],a
	push bc
	call AIPrintItemUse_
	pop bc
	ld hl,$CFCD
	ld a,[hld]
	push af
	ld a,[hl]
	push af
	push hl
	ld a,$AF
	ld [hli],a
	ld [hl],b
	ld hl,$7428
	ld b,$F
	call Bankswitch
	pop hl
	pop af
	ld [hli],a
	pop af
	ld [hl],a
	jp DecrementAICount

AIPrintItemUse:
	ld [$CF05],a
	call AIPrintItemUse_
	jp DecrementAICount

AIPrintItemUse_:
; print "x used [$CF05] on z!"
	ld a,[$CF05]
	ld [$D11E],a
	call GetItemName
	ld hl,AIBattleUseItemText
	jp PrintText

AIBattleUseItemText:
	TX_FAR _AIBattleUseItemText
	db "@"

INCBIN "baserom.gbc",$3a849,$3af3e - $3a849

UnnamedText_3af3e: ; 0x3af3e
    TX_FAR _UnnamedText_3af3e
    db $50
; 0x3af3e + 5 bytes

UnnamedText_3af43: ; 0x3af43
    TX_FAR _UnnamedText_3af43
    db $50
; 0x3af43 + 5 bytes

UnnamedText_3af48: ; 0x3af48
    TX_FAR _UnnamedText_3af48
    db $50
; 0x3af48 + 5 bytes

UnnamedText_3af4d: ; 0x3af4d
    TX_FAR _UnnamedText_3af4d
    db $50
; 0x3af4d + 5 bytes

INCBIN "baserom.gbc",$3af52,$10a

EvosAttacksPointerTable: ; 705C
	dw Mon112_EvosAttacks
	dw Mon115_EvosAttacks
	dw Mon032_EvosAttacks
	dw Mon035_EvosAttacks
	dw Mon021_EvosAttacks
	dw Mon100_EvosAttacks
	dw Mon034_EvosAttacks
	dw Mon080_EvosAttacks
	dw Mon002_EvosAttacks
	dw Mon103_EvosAttacks
	dw Mon108_EvosAttacks
	dw Mon102_EvosAttacks
	dw Mon088_EvosAttacks
	dw Mon094_EvosAttacks
	dw Mon029_EvosAttacks
	dw Mon031_EvosAttacks
	dw Mon104_EvosAttacks
	dw Mon111_EvosAttacks
	dw Mon131_EvosAttacks
	dw Mon059_EvosAttacks
	dw Mon151_EvosAttacks
	dw Mon130_EvosAttacks
	dw Mon090_EvosAttacks
	dw Mon072_EvosAttacks
	dw Mon092_EvosAttacks
	dw Mon123_EvosAttacks
	dw Mon120_EvosAttacks
	dw Mon009_EvosAttacks
	dw Mon127_EvosAttacks
	dw Mon114_EvosAttacks
	dw Mon152_EvosAttacks	;MissingNo
	dw Mon153_EvosAttacks	;MissingNo
	dw Mon058_EvosAttacks
	dw Mon095_EvosAttacks
	dw Mon022_EvosAttacks
	dw Mon016_EvosAttacks
	dw Mon079_EvosAttacks
	dw Mon064_EvosAttacks
	dw Mon075_EvosAttacks
	dw Mon113_EvosAttacks
	dw Mon067_EvosAttacks
	dw Mon122_EvosAttacks
	dw Mon106_EvosAttacks
	dw Mon107_EvosAttacks
	dw Mon024_EvosAttacks
	dw Mon047_EvosAttacks
	dw Mon054_EvosAttacks
	dw Mon096_EvosAttacks
	dw Mon076_EvosAttacks
	dw Mon154_EvosAttacks	;MissingNo
	dw Mon126_EvosAttacks
	dw Mon155_EvosAttacks	;MissingNo
	dw Mon125_EvosAttacks
	dw Mon082_EvosAttacks
	dw Mon109_EvosAttacks
	dw Mon156_EvosAttacks	;MissingNo
	dw Mon056_EvosAttacks
	dw Mon086_EvosAttacks
	dw Mon050_EvosAttacks
	dw Mon128_EvosAttacks
	dw Mon157_EvosAttacks	;MissingNo
	dw Mon158_EvosAttacks	;MissingNo
	dw Mon159_EvosAttacks	;MissingNo
	dw Mon083_EvosAttacks
	dw Mon048_EvosAttacks
	dw Mon149_EvosAttacks
	dw Mon160_EvosAttacks	;MissingNo
	dw Mon161_EvosAttacks	;MissingNo
	dw Mon162_EvosAttacks	;MissingNo
	dw Mon084_EvosAttacks
	dw Mon060_EvosAttacks
	dw Mon124_EvosAttacks
	dw Mon146_EvosAttacks
	dw Mon144_EvosAttacks
	dw Mon145_EvosAttacks
	dw Mon132_EvosAttacks
	dw Mon052_EvosAttacks
	dw Mon098_EvosAttacks
	dw Mon163_EvosAttacks	;MissingNo
	dw Mon164_EvosAttacks	;MissingNo
	dw Mon165_EvosAttacks	;MissingNo
	dw Mon037_EvosAttacks
	dw Mon038_EvosAttacks
	dw Mon025_EvosAttacks
	dw Mon026_EvosAttacks
	dw Mon166_EvosAttacks	;MissingNo
	dw Mon167_EvosAttacks	;MissingNo
	dw Mon147_EvosAttacks
	dw Mon148_EvosAttacks
	dw Mon140_EvosAttacks
	dw Mon141_EvosAttacks
	dw Mon116_EvosAttacks
	dw Mon117_EvosAttacks
	dw Mon168_EvosAttacks	;MissingNo
	dw Mon169_EvosAttacks	;MissingNo
	dw Mon027_EvosAttacks
	dw Mon028_EvosAttacks
	dw Mon138_EvosAttacks
	dw Mon139_EvosAttacks
	dw Mon039_EvosAttacks
	dw Mon040_EvosAttacks
	dw Mon133_EvosAttacks
	dw Mon136_EvosAttacks
	dw Mon135_EvosAttacks
	dw Mon134_EvosAttacks
	dw Mon066_EvosAttacks
	dw Mon041_EvosAttacks
	dw Mon023_EvosAttacks
	dw Mon046_EvosAttacks
	dw Mon061_EvosAttacks
	dw Mon062_EvosAttacks
	dw Mon013_EvosAttacks
	dw Mon014_EvosAttacks
	dw Mon015_EvosAttacks
	dw Mon170_EvosAttacks	;MissingNo
	dw Mon085_EvosAttacks
	dw Mon057_EvosAttacks
	dw Mon051_EvosAttacks
	dw Mon049_EvosAttacks
	dw Mon087_EvosAttacks
	dw Mon171_EvosAttacks	;MissingNo
	dw Mon172_EvosAttacks	;MissingNo
	dw Mon010_EvosAttacks
	dw Mon011_EvosAttacks
	dw Mon012_EvosAttacks
	dw Mon068_EvosAttacks
	dw Mon173_EvosAttacks	;MissingNo
	dw Mon055_EvosAttacks
	dw Mon097_EvosAttacks
	dw Mon042_EvosAttacks
	dw Mon150_EvosAttacks
	dw Mon143_EvosAttacks
	dw Mon129_EvosAttacks
	dw Mon174_EvosAttacks	;MissingNo
	dw Mon175_EvosAttacks	;MissingNo
	dw Mon089_EvosAttacks
	dw Mon176_EvosAttacks	;MissingNo
	dw Mon099_EvosAttacks
	dw Mon091_EvosAttacks
	dw Mon177_EvosAttacks	;MissingNo
	dw Mon101_EvosAttacks
	dw Mon036_EvosAttacks
	dw Mon110_EvosAttacks
	dw Mon053_EvosAttacks
	dw Mon105_EvosAttacks
	dw Mon178_EvosAttacks	;MissingNo
	dw Mon093_EvosAttacks
	dw Mon063_EvosAttacks
	dw Mon065_EvosAttacks
	dw Mon017_EvosAttacks
	dw Mon018_EvosAttacks
	dw Mon121_EvosAttacks
	dw Mon001_EvosAttacks
	dw Mon003_EvosAttacks
	dw Mon073_EvosAttacks
	dw Mon179_EvosAttacks	;MissingNo
	dw Mon118_EvosAttacks
	dw Mon119_EvosAttacks
	dw Mon180_EvosAttacks	;MissingNo
	dw Mon181_EvosAttacks	;MissingNo
	dw Mon182_EvosAttacks	;MissingNo
	dw Mon183_EvosAttacks	;MissingNo
	dw Mon077_EvosAttacks
	dw Mon078_EvosAttacks
	dw Mon019_EvosAttacks
	dw Mon020_EvosAttacks
	dw Mon033_EvosAttacks
	dw Mon030_EvosAttacks
	dw Mon074_EvosAttacks
	dw Mon137_EvosAttacks
	dw Mon142_EvosAttacks
	dw Mon184_EvosAttacks	;MissingNo
	dw Mon081_EvosAttacks
	dw Mon185_EvosAttacks	;MissingNo
	dw Mon186_EvosAttacks	;MissingNo
	dw Mon004_EvosAttacks
	dw Mon007_EvosAttacks
	dw Mon005_EvosAttacks
	dw Mon008_EvosAttacks
	dw Mon006_EvosAttacks
	dw Mon187_EvosAttacks	;MissingNo
	dw Mon188_EvosAttacks	;MissingNo
	dw Mon189_EvosAttacks	;MissingNo
	dw Mon190_EvosAttacks	;MissingNo
	dw Mon043_EvosAttacks
	dw Mon044_EvosAttacks
	dw Mon045_EvosAttacks
	dw Mon069_EvosAttacks
	dw Mon070_EvosAttacks
	dw Mon071_EvosAttacks

Mon112_EvosAttacks:
;RHYDON
;Evolutions
	db 0
;Learnset
	db 30,STOMP
	db 35,TAIL_WHIP
	db 40,FURY_ATTACK
	db 48,HORN_DRILL
	db 55,LEER
	db 64,TAKE_DOWN
	db 0
Mon115_EvosAttacks:
;KANGASKHAN
;Evolutions
	db 0
;Learnset
	db 26,BITE
	db 31,TAIL_WHIP
	db 36,MEGA_PUNCH
	db 41,LEER
	db 46,DIZZY_PUNCH
	db 0
Mon032_EvosAttacks:
;NIDORAN_M
;Evolutions
	db EV_LEVEL,16,NIDORINO
	db 0
;Learnset
	db 8,HORN_ATTACK
	db 14,POISON_STING
	db 21,FOCUS_ENERGY
	db 29,FURY_ATTACK
	db 36,HORN_DRILL
	db 43,DOUBLE_KICK
	db 0
Mon035_EvosAttacks:
;CLEFAIRY
;Evolutions
	db EV_ITEM,MOON_STONE,1,CLEFABLE
	db 0
;Learnset
	db 13,SING
	db 18,DOUBLESLAP
	db 24,MINIMIZE
	db 31,METRONOME
	db 39,DEFENSE_CURL
	db 48,LIGHT_SCREEN
	db 0
Mon021_EvosAttacks:
;SPEAROW
;Evolutions
	db EV_LEVEL,20,FEAROW
	db 0
;Learnset
	db 9,LEER
	db 15,FURY_ATTACK
	db 22,MIRROR_MOVE
	db 29,DRILL_PECK
	db 36,AGILITY
	db 0
Mon100_EvosAttacks:
;VOLTORB
;Evolutions
	db EV_LEVEL,30,ELECTRODE
	db 0
;Learnset
	db 17,SONICBOOM
	db 22,SELFDESTRUCT
	db 29,LIGHT_SCREEN
	db 36,SWIFT
	db 43,EXPLOSION
	db 0
Mon034_EvosAttacks:
;NIDOKING
;Evolutions
	db 0
;Learnset
	db 8,HORN_ATTACK
	db 14,POISON_STING
	db 23,THRASH
	db 0
Mon080_EvosAttacks:
;SLOWBRO
;Evolutions
	db 0
;Learnset
	db 18,DISABLE
	db 22,HEADBUTT
	db 27,GROWL
	db 33,WATER_GUN
	db 37,WITHDRAW
	db 44,AMNESIA
	db 55,PSYCHIC_M
	db 0
Mon002_EvosAttacks:
;IVYSAUR
;Evolutions
	db EV_LEVEL,32,VENUSAUR
	db 0
;Learnset
	db 7,LEECH_SEED
	db 13,VINE_WHIP
	db 22,POISONPOWDER
	db 30,RAZOR_LEAF
	db 38,GROWTH
	db 46,SLEEP_POWDER
	db 54,SOLARBEAM
	db 0
Mon103_EvosAttacks:
;EXEGGUTOR
;Evolutions
	db 0
;Learnset
	db 28,STOMP
	db 0
Mon108_EvosAttacks:
;LICKITUNG
;Evolutions
	db 0
;Learnset
	db 7,STOMP
	db 15,DISABLE
	db 23,DEFENSE_CURL
	db 31,SLAM
	db 39,SCREECH
	db 0
Mon102_EvosAttacks:
;EXEGGCUTE
;Evolutions
	db EV_ITEM,LEAF_STONE ,1,EXEGGUTOR
	db 0
;Learnset
	db 25,REFLECT
	db 28,LEECH_SEED
	db 32,STUN_SPORE
	db 37,POISONPOWDER
	db 42,SOLARBEAM
	db 48,SLEEP_POWDER
	db 0
Mon088_EvosAttacks:
;GRIMER
;Evolutions
	db EV_LEVEL,38,MUK
	db 0
;Learnset
	db 30,POISON_GAS
	db 33,MINIMIZE
	db 37,SLUDGE
	db 42,HARDEN
	db 48,SCREECH
	db 55,ACID_ARMOR
	db 0
Mon094_EvosAttacks:
;GENGAR
;Evolutions
	db 0
;Learnset
	db 29,HYPNOSIS
	db 38,DREAM_EATER
	db 0
Mon029_EvosAttacks:
;NIDORAN_F
;Evolutions
	db EV_LEVEL,16,NIDORINA
	db 0
;Learnset
	db 8,SCRATCH
	db 14,POISON_STING
	db 21,TAIL_WHIP
	db 29,BITE
	db 36,FURY_SWIPES
	db 43,DOUBLE_KICK
	db 0
Mon031_EvosAttacks:
;NIDOQUEEN
;Evolutions
	db 0
;Learnset
	db 8,SCRATCH
	db 14,POISON_STING
	db 23,BODY_SLAM
	db 0
Mon104_EvosAttacks:
;CUBONE
;Evolutions
	db EV_LEVEL,28,MAROWAK
	db 0
;Learnset
	db 25,LEER
	db 31,FOCUS_ENERGY
	db 38,THRASH
	db 43,BONEMERANG
	db 46,RAGE
	db 0
Mon111_EvosAttacks:
;RHYHORN
;Evolutions
	db EV_LEVEL,42,RHYDON
	db 0
;Learnset
	db 30,STOMP
	db 35,TAIL_WHIP
	db 40,FURY_ATTACK
	db 45,HORN_DRILL
	db 50,LEER
	db 55,TAKE_DOWN
	db 0
Mon131_EvosAttacks:
;LAPRAS
;Evolutions
	db 0
;Learnset
	db 16,SING
	db 20,MIST
	db 25,BODY_SLAM
	db 31,CONFUSE_RAY
	db 38,ICE_BEAM
	db 46,HYDRO_PUMP
	db 0
Mon059_EvosAttacks:
;ARCANINE
;Evolutions
	db 0
;Learnset
	db 0
Mon151_EvosAttacks:
;MEW
;Evolutions
	db 0
;Learnset
	db 10,TRANSFORM
	db 20,MEGA_PUNCH
	db 30,METRONOME
	db 40,PSYCHIC_M
	db 0
Mon130_EvosAttacks:
;GYARADOS
;Evolutions
	db 0
;Learnset
	db 20,BITE
	db 25,DRAGON_RAGE
	db 32,LEER
	db 41,HYDRO_PUMP
	db 52,HYPER_BEAM
	db 0
Mon090_EvosAttacks:
;SHELLDER
;Evolutions
	db EV_ITEM,WATER_STONE ,1,CLOYSTER
	db 0
;Learnset
	db 18,SUPERSONIC
	db 23,CLAMP
	db 30,AURORA_BEAM
	db 39,LEER
	db 50,ICE_BEAM
	db 0
Mon072_EvosAttacks:
;TENTACOOL
;Evolutions
	db EV_LEVEL,30,TENTACRUEL
	db 0
;Learnset
	db 7,SUPERSONIC
	db 13,WRAP
	db 18,POISON_STING
	db 22,WATER_GUN
	db 27,CONSTRICT
	db 33,BARRIER
	db 40,SCREECH
	db 48,HYDRO_PUMP
	db 0
Mon092_EvosAttacks:
;GASTLY
;Evolutions
	db EV_LEVEL,25,HAUNTER
	db 0
;Learnset
	db 27,HYPNOSIS
	db 35,DREAM_EATER
	db 0
Mon123_EvosAttacks:
;SCYTHER
;Evolutions
	db 0
;Learnset
	db 17,LEER
	db 20,FOCUS_ENERGY
	db 24,DOUBLE_TEAM
	db 29,SLASH
	db 35,SWORDS_DANCE
	db 42,AGILITY
	db 0
Mon120_EvosAttacks:
;STARYU
;Evolutions
	db EV_ITEM,WATER_STONE ,1,STARMIE
	db 0
;Learnset
	db 17,WATER_GUN
	db 22,HARDEN
	db 27,RECOVER
	db 32,SWIFT
	db 37,MINIMIZE
	db 42,LIGHT_SCREEN
	db 47,HYDRO_PUMP
	db 0
Mon009_EvosAttacks:
;BLASTOISE
;Evolutions
	db 0
;Learnset
	db 8,BUBBLE
	db 15,WATER_GUN
	db 24,BITE
	db 31,WITHDRAW
	db 42,SKULL_BASH
	db 52,HYDRO_PUMP
	db 0
Mon127_EvosAttacks:
;PINSIR
;Evolutions
	db 0
;Learnset
	db 25,SEISMIC_TOSS
	db 30,GUILLOTINE
	db 36,FOCUS_ENERGY
	db 43,HARDEN
	db 49,SLASH
	db 54,SWORDS_DANCE
	db 0
Mon114_EvosAttacks:
;TANGELA
;Evolutions
	db 0
;Learnset
	db 29,ABSORB
	db 32,POISONPOWDER
	db 36,STUN_SPORE
	db 39,SLEEP_POWDER
	db 45,SLAM
	db 49,GROWTH
	db 0

Mon152_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon153_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon058_EvosAttacks:
;GROWLITHE
;Evolutions
	db EV_ITEM,FIRE_STONE,1,ARCANINE
	db 0
;Learnset
	db 18,EMBER
	db 23,LEER
	db 30,TAKE_DOWN
	db 39,AGILITY
	db 50,FLAMETHROWER
	db 0
Mon095_EvosAttacks:
;ONIX
;Evolutions
	db 0
;Learnset
	db 15,BIND
	db 19,ROCK_THROW
	db 25,RAGE
	db 33,SLAM
	db 43,HARDEN
	db 0
Mon022_EvosAttacks:
;FEAROW
;Evolutions
	db 0
;Learnset
	db 9,LEER
	db 15,FURY_ATTACK
	db 25,MIRROR_MOVE
	db 34,DRILL_PECK
	db 43,AGILITY
	db 0
Mon016_EvosAttacks:
;PIDGEY
;Evolutions
	db EV_LEVEL,18,PIDGEOTTO
	db 0
;Learnset
	db 5,SAND_ATTACK
	db 12,QUICK_ATTACK
	db 19,WHIRLWIND
	db 28,WING_ATTACK
	db 36,AGILITY
	db 44,MIRROR_MOVE
	db 0
Mon079_EvosAttacks:
;SLOWPOKE
;Evolutions
	db EV_LEVEL,37,SLOWBRO
	db 0
;Learnset
	db 18,DISABLE
	db 22,HEADBUTT
	db 27,GROWL
	db 33,WATER_GUN
	db 40,AMNESIA
	db 48,PSYCHIC_M
	db 0
Mon064_EvosAttacks:
;KADABRA
;Evolutions
	db EV_TRADE,1,ALAKAZAM
	db 0
;Learnset
	db 16,CONFUSION
	db 20,DISABLE
	db 27,PSYBEAM
	db 31,RECOVER
	db 38,PSYCHIC_M
	db 42,REFLECT
	db 0
Mon075_EvosAttacks:
;GRAVELER
;Evolutions
	db EV_TRADE,1,GOLEM
	db 0
;Learnset
	db 11,DEFENSE_CURL
	db 16,ROCK_THROW
	db 21,SELFDESTRUCT
	db 29,HARDEN
	db 36,EARTHQUAKE
	db 43,EXPLOSION
	db 0
Mon113_EvosAttacks:
;CHANSEY
;Evolutions
	db 0
;Learnset
	db 24,SING
	db 30,GROWL
	db 38,MINIMIZE
	db 44,DEFENSE_CURL
	db 48,LIGHT_SCREEN
	db 54,DOUBLE_EDGE
	db 0
Mon067_EvosAttacks:
;MACHOKE
;Evolutions
	db EV_TRADE,1,MACHAMP
	db 0
;Learnset
	db 20,LOW_KICK
	db 25,LEER
	db 36,FOCUS_ENERGY
	db 44,SEISMIC_TOSS
	db 52,SUBMISSION
	db 0
Mon122_EvosAttacks:
;MR_MIME
;Evolutions
	db 0
;Learnset
	db 15,CONFUSION
	db 23,LIGHT_SCREEN
	db 31,DOUBLESLAP
	db 39,MEDITATE
	db 47,SUBSTITUTE
	db 0
Mon106_EvosAttacks:
;HITMONLEE
;Evolutions
	db 0
;Learnset
	db 33,ROLLING_KICK
	db 38,JUMP_KICK
	db 43,FOCUS_ENERGY
	db 48,HI_JUMP_KICK
	db 53,MEGA_KICK
	db 0
Mon107_EvosAttacks:
;HITMONCHAN
;Evolutions
	db 0
;Learnset
	db 33,FIRE_PUNCH
	db 38,ICE_PUNCH
	db 43,THUNDERPUNCH
	db 48,MEGA_PUNCH
	db 53,COUNTER
	db 0
Mon024_EvosAttacks:
;ARBOK
;Evolutions
	db 0
;Learnset
	db 10,POISON_STING
	db 17,BITE
	db 27,GLARE
	db 36,SCREECH
	db 47,ACID
	db 0
Mon047_EvosAttacks:
;PARASECT
;Evolutions
	db 0
;Learnset
	db 13,STUN_SPORE
	db 20,LEECH_LIFE
	db 30,SPORE
	db 39,SLASH
	db 48,GROWTH
	db 0
Mon054_EvosAttacks:
;PSYDUCK
;Evolutions
	db EV_LEVEL,33,GOLDUCK
	db 0
;Learnset
	db 28,TAIL_WHIP
	db 31,DISABLE
	db 36,CONFUSION
	db 43,FURY_SWIPES
	db 52,HYDRO_PUMP
	db 0
Mon096_EvosAttacks:
;DROWZEE
;Evolutions
	db EV_LEVEL,26,HYPNO
	db 0
;Learnset
	db 12,DISABLE
	db 17,CONFUSION
	db 24,HEADBUTT
	db 29,POISON_GAS
	db 32,PSYCHIC_M
	db 37,MEDITATE
	db 0
Mon076_EvosAttacks:
;GOLEM
;Evolutions
	db 0
;Learnset
	db 11,DEFENSE_CURL
	db 16,ROCK_THROW
	db 21,SELFDESTRUCT
	db 29,HARDEN
	db 36,EARTHQUAKE
	db 43,EXPLOSION
	db 0

Mon154_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon126_EvosAttacks:
;MAGMAR
;Evolutions
	db 0
;Learnset
	db 36,LEER
	db 39,CONFUSE_RAY
	db 43,FIRE_PUNCH
	db 48,SMOKESCREEN
	db 52,SMOG
	db 55,FLAMETHROWER
	db 0

Mon155_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon125_EvosAttacks:
;ELECTABUZZ
;Evolutions
	db 0
;Learnset
	db 34,THUNDERSHOCK
	db 37,SCREECH
	db 42,THUNDERPUNCH
	db 49,LIGHT_SCREEN
	db 54,THUNDER
	db 0
Mon082_EvosAttacks:
;MAGNETON
;Evolutions
	db 0
;Learnset
	db 21,SONICBOOM
	db 25,THUNDERSHOCK
	db 29,SUPERSONIC
	db 38,THUNDER_WAVE
	db 46,SWIFT
	db 54,SCREECH
	db 0
Mon109_EvosAttacks:
;KOFFING
;Evolutions
	db EV_LEVEL,35,WEEZING
	db 0
;Learnset
	db 32,SLUDGE
	db 37,SMOKESCREEN
	db 40,SELFDESTRUCT
	db 45,HAZE
	db 48,EXPLOSION
	db 0

Mon156_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon056_EvosAttacks:
;MANKEY
;Evolutions
	db EV_LEVEL,28,PRIMEAPE
	db 0
;Learnset
	db 15,KARATE_CHOP
	db 21,FURY_SWIPES
	db 27,FOCUS_ENERGY
	db 33,SEISMIC_TOSS
	db 39,THRASH
	db 0
Mon086_EvosAttacks:
;SEEL
;Evolutions
	db EV_LEVEL,34,DEWGONG
	db 0
;Learnset
	db 30,GROWL
	db 35,AURORA_BEAM
	db 40,REST
	db 45,TAKE_DOWN
	db 50,ICE_BEAM
	db 0
Mon050_EvosAttacks:
;DIGLETT
;Evolutions
	db EV_LEVEL,26,DUGTRIO
	db 0
;Learnset
	db 15,GROWL
	db 19,DIG
	db 24,SAND_ATTACK
	db 31,SLASH
	db 40,EARTHQUAKE
	db 0
Mon128_EvosAttacks:
;TAUROS
;Evolutions
	db 0
;Learnset
	db 21,STOMP
	db 28,TAIL_WHIP
	db 35,LEER
	db 44,RAGE
	db 51,TAKE_DOWN
	db 0

Mon157_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon158_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon159_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon083_EvosAttacks:
;FARFETCH_D
;Evolutions
	db 0
;Learnset
	db 7,LEER
	db 15,FURY_ATTACK
	db 23,SWORDS_DANCE
	db 31,AGILITY
	db 39,SLASH
	db 0
Mon048_EvosAttacks:
;VENONAT
;Evolutions
	db EV_LEVEL,31,VENOMOTH
	db 0
;Learnset
	db 24,POISONPOWDER
	db 27,LEECH_LIFE
	db 30,STUN_SPORE
	db 35,PSYBEAM
	db 38,SLEEP_POWDER
	db 43,PSYCHIC_M
	db 0
Mon149_EvosAttacks:
;DRAGONITE
;Evolutions
	db 0
;Learnset
	db 10,THUNDER_WAVE
	db 20,AGILITY
	db 35,SLAM
	db 45,DRAGON_RAGE
	db 60,HYPER_BEAM
	db 0

Mon160_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon161_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon162_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon084_EvosAttacks:
;DODUO
;Evolutions
	db EV_LEVEL,31,DODRIO
	db 0
;Learnset
	db 20,GROWL
	db 24,FURY_ATTACK
	db 30,DRILL_PECK
	db 36,RAGE
	db 40,TRI_ATTACK
	db 44,AGILITY
	db 0
Mon060_EvosAttacks:
;POLIWAG
;Evolutions
	db EV_LEVEL,25,POLIWHIRL
	db 0
;Learnset
	db 16,HYPNOSIS
	db 19,WATER_GUN
	db 25,DOUBLESLAP
	db 31,BODY_SLAM
	db 38,AMNESIA
	db 45,HYDRO_PUMP
	db 0
Mon124_EvosAttacks:
;JYNX
;Evolutions
	db 0
;Learnset
	db 18,LICK
	db 23,DOUBLESLAP
	db 31,ICE_PUNCH
	db 39,BODY_SLAM
	db 47,THRASH
	db 58,BLIZZARD
	db 0
Mon146_EvosAttacks:
;MOLTRES
;Evolutions
	db 0
;Learnset
	db 51,LEER
	db 55,AGILITY
	db 60,SKY_ATTACK
	db 0
Mon144_EvosAttacks:
;ARTICUNO
;Evolutions
	db 0
;Learnset
	db 51,BLIZZARD
	db 55,AGILITY
	db 60,MIST
	db 0
Mon145_EvosAttacks:
;ZAPDOS
;Evolutions
	db 0
;Learnset
	db 51,THUNDER
	db 55,AGILITY
	db 60,LIGHT_SCREEN
	db 0
Mon132_EvosAttacks:
;DITTO
;Evolutions
	db 0
;Learnset
	db 0
Mon052_EvosAttacks:
;MEOWTH
;Evolutions
	db EV_LEVEL,28,PERSIAN
	db 0
;Learnset
	db 12,BITE
	db 17,PAY_DAY
	db 24,SCREECH
	db 33,FURY_SWIPES
	db 44,SLASH
	db 0
Mon098_EvosAttacks:
;KRABBY
;Evolutions
	db EV_LEVEL,28,KINGLER
	db 0
;Learnset
	db 20,VICEGRIP
	db 25,GUILLOTINE
	db 30,STOMP
	db 35,CRABHAMMER
	db 40,HARDEN
	db 0

Mon163_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon164_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon165_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon037_EvosAttacks:
;VULPIX
;Evolutions
	db EV_ITEM,FIRE_STONE,1,NINETALES
	db 0
;Learnset
	db 16,QUICK_ATTACK
	db 21,ROAR
	db 28,CONFUSE_RAY
	db 35,FLAMETHROWER
	db 42,FIRE_SPIN
	db 0
Mon038_EvosAttacks:
;NINETALES
;Evolutions
	db 0
;Learnset
	db 0
Mon025_EvosAttacks:
;PIKACHU
;Evolutions
	db EV_ITEM,THUNDER_STONE ,1,RAICHU
	db 0
;Learnset
	db 9,THUNDER_WAVE
	db 16,QUICK_ATTACK
	db 26,SWIFT
	db 33,AGILITY
	db 43,THUNDER
	db 0
Mon026_EvosAttacks:
;RAICHU
;Evolutions
	db 0
;Learnset
	db 0

Mon166_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon167_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon147_EvosAttacks:
;DRATINI
;Evolutions
	db EV_LEVEL,30,DRAGONAIR
	db 0
;Learnset
	db 10,THUNDER_WAVE
	db 20,AGILITY
	db 30,SLAM
	db 40,DRAGON_RAGE
	db 50,HYPER_BEAM
	db 0
Mon148_EvosAttacks:
;DRAGONAIR
;Evolutions
	db EV_LEVEL,55,DRAGONITE
	db 0
;Learnset
	db 10,THUNDER_WAVE
	db 20,AGILITY
	db 35,SLAM
	db 45,DRAGON_RAGE
	db 55,HYPER_BEAM
	db 0
Mon140_EvosAttacks:
;KABUTO
;Evolutions
	db EV_LEVEL,40,KABUTOPS
	db 0
;Learnset
	db 34,ABSORB
	db 39,SLASH
	db 44,LEER
	db 49,HYDRO_PUMP
	db 0
Mon141_EvosAttacks:
;KABUTOPS
;Evolutions
	db 0
;Learnset
	db 34,ABSORB
	db 39,SLASH
	db 46,LEER
	db 53,HYDRO_PUMP
	db 0
Mon116_EvosAttacks:
;HORSEA
;Evolutions
	db EV_LEVEL,32,SEADRA
	db 0
;Learnset
	db 19,SMOKESCREEN
	db 24,LEER
	db 30,WATER_GUN
	db 37,AGILITY
	db 45,HYDRO_PUMP
	db 0
Mon117_EvosAttacks:
;SEADRA
;Evolutions
	db 0
;Learnset
	db 19,SMOKESCREEN
	db 24,LEER
	db 30,WATER_GUN
	db 41,AGILITY
	db 52,HYDRO_PUMP
	db 0

Mon168_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon169_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon027_EvosAttacks:
;SANDSHREW
;Evolutions
	db EV_LEVEL,22,SANDSLASH
	db 0
;Learnset
	db 10,SAND_ATTACK
	db 17,SLASH
	db 24,POISON_STING
	db 31,SWIFT
	db 38,FURY_SWIPES
	db 0
Mon028_EvosAttacks:
;SANDSLASH
;Evolutions
	db 0
;Learnset
	db 10,SAND_ATTACK
	db 17,SLASH
	db 27,POISON_STING
	db 36,SWIFT
	db 47,FURY_SWIPES
	db 0
Mon138_EvosAttacks:
;OMANYTE
;Evolutions
	db EV_LEVEL,40,OMASTAR
	db 0
;Learnset
	db 34,HORN_ATTACK
	db 39,LEER
	db 46,SPIKE_CANNON
	db 53,HYDRO_PUMP
	db 0
Mon139_EvosAttacks:
;OMASTAR
;Evolutions
	db 0
;Learnset
	db 34,HORN_ATTACK
	db 39,LEER
	db 44,SPIKE_CANNON
	db 49,HYDRO_PUMP
	db 0
Mon039_EvosAttacks:
;JIGGLYPUFF
;Evolutions
	db EV_ITEM,MOON_STONE,1,WIGGLYTUFF
	db 0
;Learnset
	db 9,POUND
	db 14,DISABLE
	db 19,DEFENSE_CURL
	db 24,DOUBLESLAP
	db 29,REST
	db 34,BODY_SLAM
	db 39,DOUBLE_EDGE
	db 0
Mon040_EvosAttacks:
;WIGGLYTUFF
;Evolutions
	db 0
;Learnset
	db 0
Mon133_EvosAttacks:
;EEVEE
;Evolutions
	db EV_ITEM,FIRE_STONE,1,FLAREON
	db EV_ITEM,THUNDER_STONE ,1,JOLTEON
	db EV_ITEM,WATER_STONE ,1,VAPOREON
	db 0
;Learnset
	db 27,QUICK_ATTACK
	db 31,TAIL_WHIP
	db 37,BITE
	db 45,TAKE_DOWN
	db 0
Mon136_EvosAttacks:
;FLAREON
;Evolutions
	db 0
;Learnset
	db 27,QUICK_ATTACK
	db 31,EMBER
	db 37,TAIL_WHIP
	db 40,BITE
	db 42,LEER
	db 44,FIRE_SPIN
	db 48,RAGE
	db 54,FLAMETHROWER
	db 0
Mon135_EvosAttacks:
;JOLTEON
;Evolutions
	db 0
;Learnset
	db 27,QUICK_ATTACK
	db 31,THUNDERSHOCK
	db 37,TAIL_WHIP
	db 40,THUNDER_WAVE
	db 42,DOUBLE_KICK
	db 44,AGILITY
	db 48,PIN_MISSILE
	db 54,THUNDER
	db 0
Mon134_EvosAttacks:
;VAPOREON
;Evolutions
	db 0
;Learnset
	db 27,QUICK_ATTACK
	db 31,WATER_GUN
	db 37,TAIL_WHIP
	db 40,BITE
	db 42,ACID_ARMOR
	db 44,HAZE
	db 48,MIST
	db 54,HYDRO_PUMP
	db 0
Mon066_EvosAttacks:
;MACHOP
;Evolutions
	db EV_LEVEL,28,MACHOKE
	db 0
;Learnset
	db 20,LOW_KICK
	db 25,LEER
	db 32,FOCUS_ENERGY
	db 39,SEISMIC_TOSS
	db 46,SUBMISSION
	db 0
Mon041_EvosAttacks:
;ZUBAT
;Evolutions
	db EV_LEVEL,22,GOLBAT
	db 0
;Learnset
	db 10,SUPERSONIC
	db 15,BITE
	db 21,CONFUSE_RAY
	db 28,WING_ATTACK
	db 36,HAZE
	db 0
Mon023_EvosAttacks:
;EKANS
;Evolutions
	db EV_LEVEL,22,ARBOK
	db 0
;Learnset
	db 10,POISON_STING
	db 17,BITE
	db 24,GLARE
	db 31,SCREECH
	db 38,ACID
	db 0
Mon046_EvosAttacks:
;PARAS
;Evolutions
	db EV_LEVEL,24,PARASECT
	db 0
;Learnset
	db 13,STUN_SPORE
	db 20,LEECH_LIFE
	db 27,SPORE
	db 34,SLASH
	db 41,GROWTH
	db 0
Mon061_EvosAttacks:
;POLIWHIRL
;Evolutions
	db EV_ITEM,WATER_STONE ,1,POLIWRATH
	db 0
;Learnset
	db 16,HYPNOSIS
	db 19,WATER_GUN
	db 26,DOUBLESLAP
	db 33,BODY_SLAM
	db 41,AMNESIA
	db 49,HYDRO_PUMP
	db 0
Mon062_EvosAttacks:
;POLIWRATH
;Evolutions
	db 0
;Learnset
	db 16,HYPNOSIS
	db 19,WATER_GUN
	db 0
Mon013_EvosAttacks:
;WEEDLE
;Evolutions
	db EV_LEVEL,7,KAKUNA
	db 0
;Learnset
	db 0
Mon014_EvosAttacks:
;KAKUNA
;Evolutions
	db EV_LEVEL,10,BEEDRILL
	db 0
;Learnset
	db 0
Mon015_EvosAttacks:
;BEEDRILL
;Evolutions
	db 0
;Learnset
	db 12,FURY_ATTACK
	db 16,FOCUS_ENERGY
	db 20,TWINEEDLE
	db 25,RAGE
	db 30,PIN_MISSILE
	db 35,AGILITY
	db 0

Mon170_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon085_EvosAttacks:
;DODRIO
;Evolutions
	db 0
;Learnset
	db 20,GROWL
	db 24,FURY_ATTACK
	db 30,DRILL_PECK
	db 39,RAGE
	db 45,TRI_ATTACK
	db 51,AGILITY
	db 0
Mon057_EvosAttacks:
;PRIMEAPE
;Evolutions
	db 0
;Learnset
	db 15,KARATE_CHOP
	db 21,FURY_SWIPES
	db 27,FOCUS_ENERGY
	db 37,SEISMIC_TOSS
	db 46,THRASH
	db 0
Mon051_EvosAttacks:
;DUGTRIO
;Evolutions
	db 0
;Learnset
	db 15,GROWL
	db 19,DIG
	db 24,SAND_ATTACK
	db 35,SLASH
	db 47,EARTHQUAKE
	db 0
Mon049_EvosAttacks:
;VENOMOTH
;Evolutions
	db 0
;Learnset
	db 24,POISONPOWDER
	db 27,LEECH_LIFE
	db 30,STUN_SPORE
	db 38,PSYBEAM
	db 43,SLEEP_POWDER
	db 50,PSYCHIC_M
	db 0
Mon087_EvosAttacks:
;DEWGONG
;Evolutions
	db 0
;Learnset
	db 30,GROWL
	db 35,AURORA_BEAM
	db 44,REST
	db 50,TAKE_DOWN
	db 56,ICE_BEAM
	db 0

Mon171_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon172_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon010_EvosAttacks:
;CATERPIE
;Evolutions
	db EV_LEVEL,7,METAPOD
	db 0
;Learnset
	db 0
Mon011_EvosAttacks:
;METAPOD
;Evolutions
	db EV_LEVEL,10,BUTTERFREE
	db 0
;Learnset
	db 0
Mon012_EvosAttacks:
;BUTTERFREE
;Evolutions
	db 0
;Learnset
	db 12,CONFUSION
	db 15,POISONPOWDER
	db 16,STUN_SPORE
	db 17,SLEEP_POWDER
	db 21,SUPERSONIC
	db 26,WHIRLWIND
	db 32,PSYBEAM
	db 0
Mon068_EvosAttacks:
;MACHAMP
;Evolutions
	db 0
;Learnset
	db 20,LOW_KICK
	db 25,LEER
	db 36,FOCUS_ENERGY
	db 44,SEISMIC_TOSS
	db 52,SUBMISSION
	db 0

Mon173_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon055_EvosAttacks:
;GOLDUCK
;Evolutions
	db 0
;Learnset
	db 28,TAIL_WHIP
	db 31,DISABLE
	db 39,CONFUSION
	db 48,FURY_SWIPES
	db 59,HYDRO_PUMP
	db 0
Mon097_EvosAttacks:
;HYPNO
;Evolutions
	db 0
;Learnset
	db 12,DISABLE
	db 17,CONFUSION
	db 24,HEADBUTT
	db 33,POISON_GAS
	db 37,PSYCHIC_M
	db 43,MEDITATE
	db 0
Mon042_EvosAttacks:
;GOLBAT
;Evolutions
	db 0
;Learnset
	db 10,SUPERSONIC
	db 15,BITE
	db 21,CONFUSE_RAY
	db 32,WING_ATTACK
	db 43,HAZE
	db 0
Mon150_EvosAttacks:
;MEWTWO
;Evolutions
	db 0
;Learnset
	db 63,BARRIER
	db 66,PSYCHIC_M
	db 70,RECOVER
	db 75,MIST
	db 81,AMNESIA
	db 0
Mon143_EvosAttacks:
;SNORLAX
;Evolutions
	db 0
;Learnset
	db 35,BODY_SLAM
	db 41,HARDEN
	db 48,DOUBLE_EDGE
	db 56,HYPER_BEAM
	db 0
Mon129_EvosAttacks:
;MAGIKARP
;Evolutions
	db EV_LEVEL,20,GYARADOS
	db 0
;Learnset
	db 15,TACKLE
	db 0

Mon174_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon175_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon089_EvosAttacks:
;MUK
;Evolutions
	db 0
;Learnset
	db 30,POISON_GAS
	db 33,MINIMIZE
	db 37,SLUDGE
	db 45,HARDEN
	db 53,SCREECH
	db 60,ACID_ARMOR
	db 0

Mon176_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon099_EvosAttacks:
;KINGLER
;Evolutions
	db 0
;Learnset
	db 20,VICEGRIP
	db 25,GUILLOTINE
	db 34,STOMP
	db 42,CRABHAMMER
	db 49,HARDEN
	db 0
Mon091_EvosAttacks:
;CLOYSTER
;Evolutions
	db 0
;Learnset
	db 50,SPIKE_CANNON
	db 0

Mon177_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon101_EvosAttacks:
;ELECTRODE
;Evolutions
	db 0
;Learnset
	db 17,SONICBOOM
	db 22,SELFDESTRUCT
	db 29,LIGHT_SCREEN
	db 40,SWIFT
	db 50,EXPLOSION
	db 0
Mon036_EvosAttacks:
;CLEFABLE
;Evolutions
	db 0
;Learnset
	db 0
Mon110_EvosAttacks:
;WEEZING
;Evolutions
	db 0
;Learnset
	db 32,SLUDGE
	db 39,SMOKESCREEN
	db 43,SELFDESTRUCT
	db 49,HAZE
	db 53,EXPLOSION
	db 0
Mon053_EvosAttacks:
;PERSIAN
;Evolutions
	db 0
;Learnset
	db 12,BITE
	db 17,PAY_DAY
	db 24,SCREECH
	db 37,FURY_SWIPES
	db 51,SLASH
	db 0
Mon105_EvosAttacks:
;MAROWAK
;Evolutions
	db 0
;Learnset
	db 25,LEER
	db 33,FOCUS_ENERGY
	db 41,THRASH
	db 48,BONEMERANG
	db 55,RAGE
	db 0

Mon178_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon093_EvosAttacks:
;HAUNTER
;Evolutions
	db EV_TRADE,1,GENGAR
	db 0
;Learnset
	db 29,HYPNOSIS
	db 38,DREAM_EATER
	db 0
Mon063_EvosAttacks:
;ABRA
;Evolutions
	db EV_LEVEL,16,KADABRA
	db 0
;Learnset
	db 0
Mon065_EvosAttacks:
;ALAKAZAM
;Evolutions
	db 0
;Learnset
	db 16,CONFUSION
	db 20,DISABLE
	db 27,PSYBEAM
	db 31,RECOVER
	db 38,PSYCHIC_M
	db 42,REFLECT
	db 0
Mon017_EvosAttacks:
;PIDGEOTTO
;Evolutions
	db EV_LEVEL,36,PIDGEOT
	db 0
;Learnset
	db 5,SAND_ATTACK
	db 12,QUICK_ATTACK
	db 21,WHIRLWIND
	db 31,WING_ATTACK
	db 40,AGILITY
	db 49,MIRROR_MOVE
	db 0
Mon018_EvosAttacks:
;PIDGEOT
;Evolutions
	db 0
;Learnset
	db 5,SAND_ATTACK
	db 12,QUICK_ATTACK
	db 21,WHIRLWIND
	db 31,WING_ATTACK
	db 44,AGILITY
	db 54,MIRROR_MOVE
	db 0
Mon121_EvosAttacks:
;STARMIE
;Evolutions
	db 0
;Learnset
	db 0
Mon001_EvosAttacks:
;BULBASAUR
;Evolutions
	db EV_LEVEL,16,IVYSAUR
	db 0
;Learnset
	db 7,LEECH_SEED
	db 13,VINE_WHIP
	db 20,POISONPOWDER
	db 27,RAZOR_LEAF
	db 34,GROWTH
	db 41,SLEEP_POWDER
	db 48,SOLARBEAM
	db 0
Mon003_EvosAttacks:
;VENUSAUR
;Evolutions
	db 0
;Learnset
	db 7,LEECH_SEED
	db 13,VINE_WHIP
	db 22,POISONPOWDER
	db 30,RAZOR_LEAF
	db 43,GROWTH
	db 55,SLEEP_POWDER
	db 65,SOLARBEAM
	db 0
Mon073_EvosAttacks:
;TENTACRUEL
;Evolutions
	db 0
;Learnset
	db 7,SUPERSONIC
	db 13,WRAP
	db 18,POISON_STING
	db 22,WATER_GUN
	db 27,CONSTRICT
	db 35,BARRIER
	db 43,SCREECH
	db 50,HYDRO_PUMP
	db 0

Mon179_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon118_EvosAttacks:
;GOLDEEN
;Evolutions
	db EV_LEVEL,33,SEAKING
	db 0
;Learnset
	db 19,SUPERSONIC
	db 24,HORN_ATTACK
	db 30,FURY_ATTACK
	db 37,WATERFALL
	db 45,HORN_DRILL
	db 54,AGILITY
	db 0
Mon119_EvosAttacks:
;SEAKING
;Evolutions
	db 0
;Learnset
	db 19,SUPERSONIC
	db 24,HORN_ATTACK
	db 30,FURY_ATTACK
	db 39,WATERFALL
	db 48,HORN_DRILL
	db 54,AGILITY
	db 0

Mon180_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon181_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon182_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon183_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon077_EvosAttacks:
;PONYTA
;Evolutions
	db EV_LEVEL,40,RAPIDASH
	db 0
;Learnset
	db 30,TAIL_WHIP
	db 32,STOMP
	db 35,GROWL
	db 39,FIRE_SPIN
	db 43,TAKE_DOWN
	db 48,AGILITY
	db 0
Mon078_EvosAttacks:
;RAPIDASH
;Evolutions
	db 0
;Learnset
	db 30,TAIL_WHIP
	db 32,STOMP
	db 35,GROWL
	db 39,FIRE_SPIN
	db 47,TAKE_DOWN
	db 55,AGILITY
	db 0
Mon019_EvosAttacks:
;RATTATA
;Evolutions
	db EV_LEVEL,20,RATICATE
	db 0
;Learnset
	db 7,QUICK_ATTACK
	db 14,HYPER_FANG
	db 23,FOCUS_ENERGY
	db 34,SUPER_FANG
	db 0
Mon020_EvosAttacks:
;RATICATE
;Evolutions
	db 0
;Learnset
	db 7,QUICK_ATTACK
	db 14,HYPER_FANG
	db 27,FOCUS_ENERGY
	db 41,SUPER_FANG
	db 0
Mon033_EvosAttacks:
;NIDORINO
;Evolutions
	db EV_ITEM,MOON_STONE,1,NIDOKING
	db 0
;Learnset
	db 8,HORN_ATTACK
	db 14,POISON_STING
	db 23,FOCUS_ENERGY
	db 32,FURY_ATTACK
	db 41,HORN_DRILL
	db 50,DOUBLE_KICK
	db 0
Mon030_EvosAttacks:
;NIDORINA
;Evolutions
	db EV_ITEM,MOON_STONE,1,NIDOQUEEN
	db 0
;Learnset
	db 8,SCRATCH
	db 14,POISON_STING
	db 23,TAIL_WHIP
	db 32,BITE
	db 41,FURY_SWIPES
	db 50,DOUBLE_KICK
	db 0
Mon074_EvosAttacks:
;GEODUDE
;Evolutions
	db EV_LEVEL,25,GRAVELER
	db 0
;Learnset
	db 11,DEFENSE_CURL
	db 16,ROCK_THROW
	db 21,SELFDESTRUCT
	db 26,HARDEN
	db 31,EARTHQUAKE
	db 36,EXPLOSION
	db 0
Mon137_EvosAttacks:
;PORYGON
;Evolutions
	db 0
;Learnset
	db 23,PSYBEAM
	db 28,RECOVER
	db 35,AGILITY
	db 42,TRI_ATTACK
	db 0
Mon142_EvosAttacks:
;AERODACTYL
;Evolutions
	db 0
;Learnset
	db 33,SUPERSONIC
	db 38,BITE
	db 45,TAKE_DOWN
	db 54,HYPER_BEAM
	db 0

Mon184_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon081_EvosAttacks:
;MAGNEMITE
;Evolutions
	db EV_LEVEL,30,MAGNETON
	db 0
;Learnset
	db 21,SONICBOOM
	db 25,THUNDERSHOCK
	db 29,SUPERSONIC
	db 35,THUNDER_WAVE
	db 41,SWIFT
	db 47,SCREECH
	db 0

Mon185_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon186_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon004_EvosAttacks:
;CHARMANDER
;Evolutions
	db EV_LEVEL,16,CHARMELEON
	db 0
;Learnset
	db 9,EMBER
	db 15,LEER
	db 22,RAGE
	db 30,SLASH
	db 38,FLAMETHROWER
	db 46,FIRE_SPIN
	db 0
Mon007_EvosAttacks:
;SQUIRTLE
;Evolutions
	db EV_LEVEL,16,WARTORTLE
	db 0
;Learnset
	db 8,BUBBLE
	db 15,WATER_GUN
	db 22,BITE
	db 28,WITHDRAW
	db 35,SKULL_BASH
	db 42,HYDRO_PUMP
	db 0
Mon005_EvosAttacks:
;CHARMELEON
;Evolutions
	db EV_LEVEL,36,CHARIZARD
	db 0
;Learnset
	db 9,EMBER
	db 15,LEER
	db 24,RAGE
	db 33,SLASH
	db 42,FLAMETHROWER
	db 56,FIRE_SPIN
	db 0
Mon008_EvosAttacks:
;WARTORTLE
;Evolutions
	db EV_LEVEL,36,BLASTOISE
	db 0
;Learnset
	db 8,BUBBLE
	db 15,WATER_GUN
	db 24,BITE
	db 31,WITHDRAW
	db 39,SKULL_BASH
	db 47,HYDRO_PUMP
	db 0
Mon006_EvosAttacks:
;CHARIZARD
;Evolutions
	db 0
;Learnset
	db 9,EMBER
	db 15,LEER
	db 24,RAGE
	db 36,SLASH
	db 46,FLAMETHROWER
	db 55,FIRE_SPIN
	db 0

Mon187_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon188_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon189_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0

Mon190_EvosAttacks:
;MISSINGNO
;Evolutions
	db 0
;Learnset
	db 0
Mon043_EvosAttacks:
;ODDISH
;Evolutions
	db EV_LEVEL,21,GLOOM
	db 0
;Learnset
	db 15,POISONPOWDER
	db 17,STUN_SPORE
	db 19,SLEEP_POWDER
	db 24,ACID
	db 33,PETAL_DANCE
	db 46,SOLARBEAM
	db 0
Mon044_EvosAttacks:
;GLOOM
;Evolutions
	db EV_ITEM,LEAF_STONE ,1,VILEPLUME
	db 0
;Learnset
	db 15,POISONPOWDER
	db 17,STUN_SPORE
	db 19,SLEEP_POWDER
	db 28,ACID
	db 38,PETAL_DANCE
	db 52,SOLARBEAM
	db 0
Mon045_EvosAttacks:
;VILEPLUME
;Evolutions
	db 0
;Learnset
	db 15,POISONPOWDER
	db 17,STUN_SPORE
	db 19,SLEEP_POWDER
	db 0
Mon069_EvosAttacks:
;BELLSPROUT
;Evolutions
	db EV_LEVEL,21,WEEPINBELL
	db 0
;Learnset
	db 13,WRAP
	db 15,POISONPOWDER
	db 18,SLEEP_POWDER
	db 21,STUN_SPORE
	db 26,ACID
	db 33,RAZOR_LEAF
	db 42,SLAM
	db 0
Mon070_EvosAttacks:
;WEEPINBELL
;Evolutions
	db EV_ITEM,LEAF_STONE ,1,VICTREEBEL
	db 0
;Learnset
	db 13,WRAP
	db 15,POISONPOWDER
	db 18,SLEEP_POWDER
	db 23,STUN_SPORE
	db 29,ACID
	db 38,RAZOR_LEAF
	db 49,SLAM
	db 0
Mon071_EvosAttacks:
;VICTREEBEL
;Evolutions
	db 0
;Learnset
	db 13,WRAP
	db 15,POISONPOWDER
	db 18,SLEEP_POWDER
	db 0

INCBIN "baserom.gbc",$3b9ec,$3baa2 - $3b9ec

UnnamedText_3baa2: ; 0x3baa2
    TX_FAR _UnnamedText_3baa2
    db $50
; 0x3baa2 + 5 bytes

UnnamedText_3baa7: ; 0x3baa7
    TX_FAR _UnnamedText_3baa7
    db $50
; 0x3baa7 + 5 bytes

UnnamedText_3baac: ; 0x3baac
    TX_FAR _UnnamedText_3baac
    db $50
; 0x3baac + 5 bytes

INCBIN "baserom.gbc",$3bab1,$3bb92 - $3bab1

UnnamedText_3bb92: ; 0x3bb92
    TX_FAR _UnnamedText_3bb92
    db $50
; 0x3bb92 + 5 bytes

INCBIN "baserom.gbc",$3bb97,$3bbd7 - $3bb97

UnnamedText_3bbd7: ; 0x3bbd7
    TX_FAR _UnnamedText_3bbd7
    db $50
; 0x3bbd7 + 5 bytes

UnnamedText_3bbdc: ; 0x3bbdc
    TX_FAR _UnnamedText_3bbdc
    db $50
; 0x3bbdc + 5 bytes

INCBIN "baserom.gbc",$3bbe1,$41f

SECTION "bankF",DATA,BANK[$F]

; These are move effects (second value from the Attacks table in bank $E).
EffectsArray1: ; 4000
	db $18,$19,$1C,$2E,$2F,$31,$38,$39,$40,$41,$42,$43,$4F,$52,$54,$55,$FF
EffectsArray2: ; 4011
; attacks that do damage but not through normal calculations
; e.g., Super Fang, Psywave
	db $28,$29,$FF
EffectsArray3: ; 4014
; non-damaging, stat‐affecting or status‐causing attacks?
; e.g., Meditate, Bide, Hypnosis
	db $01,$0A,$0B,$0C,$0D,$0E,$0F,$12,$13,$14,$15,$16,$17,$1A,$20,$32,$33,$34,$35,$36,$37,$3A,$3B,$3C,$3D,$3E,$3F,$FF
EffectsArray4: ; 4030
	db $03,$07,$08,$10,$1D,$1E,$2C,$30,$4D,$51,$FF
EffectsArray5: ; 403B
	db $03,$07,$08,$10,$11,$1D,$1E,$27,$28,$29,$2B,$2C,$2D,$30 ; fallthru
EffectsArray5B: ; 4049
; attacks that prevent the player from switching attacks?
	db $1B,$2A,$FF

INCBIN "baserom.gbc",$3c04c,$3c1a8 - $3c04c

UnnamedText_3c1a8: ; 0x3c1a8
    TX_FAR _UnnamedText_3c1a8
    db $50
; 0x3c1a8 + 5 bytes

INCBIN "baserom.gbc",$3c1ad,$3c229 - $3c1ad

UnnamedText_3c229: ; 0x3c229
    TX_FAR _UnnamedText_3c229
    db $50
; 0x3c229 + 5 bytes

UnnamedText_3c22e: ; 0x3c22e
    TX_FAR _UnnamedText_3c22e
    db $50
; 0x3c22e + 5 bytes

INCBIN "baserom.gbc",$3c233,$3c42e - $3c233

UnnamedText_3c42e: ; 0x3c42e
    TX_FAR _UnnamedText_3c42e
    db $50
; 0x3c42e + 5 bytes

UnnamedText_3c433: ; 0x3c433
    TX_FAR _UnnamedText_3c433
    db $50
; 0x3c433 + 5 bytes

UnnamedText_3c438: ; 0x3c438
    TX_FAR _UnnamedText_3c438
    db $50
; 0x3c438 + 5 bytes

INCBIN "baserom.gbc",$3c43d,$3c63e - $3c43d

UnnamedText_3c63e: ; 0x3c63e
    TX_FAR _UnnamedText_3c63e
    db $50
; 0x3c63e + 5 bytes

INCBIN "baserom.gbc",$3c643,$3c6e4 - $3c643

UnnamedText_3c6e4: ; 0x3c6e4
    TX_FAR _UnnamedText_3c6e4
    db $50
; 0x3c6e4 + 5 bytes

UnnamedText_3c6e9: ; 0x3c6e9
    TX_FAR _UnnamedText_3c6e9
    db $50
; 0x3c6e9 + 5 bytes

INCBIN "baserom.gbc",$3c6ee,$3c796 - $3c6ee

UnnamedText_3c796: ; 0x3c796
    TX_FAR _UnnamedText_3c796
    db $50
; 0x3c796 + 5 bytes

INCBIN "baserom.gbc",$3c79b,$3c7d3 - $3c79b

UnnamedText_3c7d3: ; 0x3c7d3
    TX_FAR _UnnamedText_3c7d3
    db $50
; 0x3c7d3 + 5 bytes

INCBIN "baserom.gbc",$3c7d8,$3c884 - $3c7d8

UnnamedText_3c884: ; 0x3c884
    TX_FAR _UnnamedText_3c884
    db $50
; 0x3c884 + 5 bytes

UnnamedText_3c889: ; 0x3c889
    TX_FAR _UnnamedText_3c889
    db $50
; 0x3c889 + 5 bytes

UnnamedText_3c88e: ; 0x3c88e
    TX_FAR _UnnamedText_3c88e
    db $50
; 0x3c88e + 5 bytes

INCBIN "baserom.gbc",$3c893,$7b

; XXX this needs cleaning up. it's what runs when a juggler switches pokemon
EnemySendOut: ; 490E
	ld hl,$D058
	xor a
	ld [hl],a
	ld a,[$CC2F]
	ld c,a
	ld b,1
	push bc
	ld a,$10
	call Predef
	ld hl,$CCF5
	xor a
	ld [hl],a
	pop bc
	ld a,$10
	call Predef
	xor a
	ld hl,$D065
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld [$D072],a
	ld [$CCEF],a
	ld [$CCF3],a
	ld hl,$CCF1
	ld [hli],a
	ld [hl],a
	dec a
	ld [W_AICOUNT],a
	ld hl,$D062
	res 5,[hl]
	ld hl,$C3B2
	ld a,8
	call $48DF
	call $6E94
	call $3719
	ld a,[$D12B]
	cp 4
	jr nz,.next\@
	ld a,[$CC3E]
	sub 4
	ld [$CF92],a
	jr .next3\@
.next\@
	ld b,$FF
.next2\@
	inc b
	ld a,[$CFE8]
	cp b
	jr z,.next2\@
	ld hl,$D8A4
	ld a,b
	ld [$CF92],a
	push bc
	ld bc,$2C
	call AddNTimes
	pop bc
	inc hl
	ld a,[hli]
	ld c,a
	ld a,[hl]
	or c
	jr z,.next2\@
.next3\@
	ld a,[$CF92]
	ld hl,$D8C5
	ld bc,$2C
	call AddNTimes
	ld a,[hl]
	ld [$D127],a
	ld a,[$CF92]
	inc a
	ld hl,$D89C
	ld c,a
	ld b,0
	add hl,bc
	ld a,[hl]
	ld [$CFD8],a
	ld [$CF91],a
	call $6B01
	ld hl,$CFE6
	ld a,[hli]
	ld [$CCE3],a
	ld a,[hl]
	ld [$CCE4],a
	ld a,1
	ld [$CC26],a
	ld a,[$D11D]
	dec a
	jr z,.next4\@
	ld a,[W_NUMINPARTY]
	dec a
	jr z,.next4\@
	ld a,[$D12B]
	cp 4
	jr z,.next4\@
	ld a,[$D355]
	bit 6,a
	jr nz,.next4\@
	ld hl,TrainerAboutToUseText
	call PrintText
	ld hl,$C42C
	ld bc,$0801
	ld a,$14
	ld [$D125],a
	call $30E8
	ld a,[$CC26]
	and a
	jr nz,.next4\@
	ld a,2
	ld [$D07D],a
	call $13FC
.next9\@
	ld a,1
	ld [$CC26],a
	jr c,.next7\@
	ld hl,$CC2F
	ld a,[$CF92]
	cp [hl]
	jr nz,.next6\@
	ld hl,$51F5
	call PrintText
.next8\@
	call $1411
	jr .next9\@
.next6\@
	call $4A97
	jr z,.next8\@
	xor a
	ld [$CC26],a
.next7\@
	call $3DE5
	call $6E5B
	call $3725
.next4\@
	call $0082
	ld hl,$C3A0
	ld bc,$040B
	call $18C4
	ld b,1
	call $3DEF
	call $3DDC
	ld hl,TrainerSentOutText
	call PrintText
	ld a,[$CFD8]
	ld [$CF91],a
	ld [$D0B5],a
	call $1537
	ld de,$9000
	call $1665
	ld a,$CF
	ld [$FFE1],a
	ld hl,$C427
	ld a,2
	call Predef
	ld a,[$CFD8]
	call $13D0
	call $4DEC
	ld a,[$CC26]
	and a
	ret nz
	xor a
	ld [$D058],a
	ld [$CCF5],a
	call $3719
	jp $51BA

TrainerAboutToUseText:
	TX_FAR _TrainerAboutToUseText
	db "@"

TrainerSentOutText:
	TX_FAR _TrainerSentOutText
	db "@"

INCBIN "baserom.gbc",$3ca83,$3cab4 - $3ca83

UnnamedText_3cab4: ; 0x3cab4
    TX_FAR _UnnamedText_3cab4
    db $50
; 0x3cab4 + 5 bytes

INCBIN "baserom.gbc",$3cab9,$3cb97 - $3cab9

UnnamedText_3cb97: ; 0x3cb97
    TX_FAR _UnnamedText_3cb97
    db $50
; 0x3cb97 + 5 bytes

UnnamedText_3cb9c: ; 0x3cb9c
    TX_FAR _UnnamedText_3cb9c
    db $50
; 0x3cb9c + 5 bytes

UnnamedText_3cba1: ; 0x3cba1
    TX_FAR _UnnamedText_3cba1
    db $50
; 0x3cba1 + 5 bytes

INCBIN "baserom.gbc",$3cba6,$3d0c5 - $3cba6

UnnamedText_3d0c5: ; 0x3d0c5
    TX_FAR _UnnamedText_3d0c5
    db $50
; 0x3d0c5 + 5 bytes

INCBIN "baserom.gbc",$3d0ca,$3d1f5 - $3d0ca

UnnamedText_3d1f5: ; 0x3d1f5
    TX_FAR _UnnamedText_3d1f5
    db $50
; 0x3d1f5 + 5 bytes

INCBIN "baserom.gbc",$3d1fa,$3d3ae - $3d1fa

UnnamedText_3d3ae: ; 0x3d3ae
    TX_FAR _UnnamedText_3d3ae
    db $50
; 0x3d3ae + 5 bytes

UnnamedText_3d3b3: ; 0x3d3b3
    TX_FAR _UnnamedText_3d3b3
    db $50
; 0x3d3b3 + 5 bytes

INCBIN "baserom.gbc",$3d3b8,$3d430 - $3d3b8

UnnamedText_3d430: ; 0x3d430
    TX_FAR _UnnamedText_3d430
    db $50
; 0x3d430 + 5 bytes

INCBIN "baserom.gbc",$3d435,$274

; in-battle stuff
	ld hl,$D062
	res 4,[hl]
	res 6,[hl]
	call $5AF5
	ld hl,DecrementPP
	ld de,$CCDC ; pointer to the move just used
	ld b,BANK(DecrementPP)
	call Bankswitch
	ld a,[$CFD3] ; effect of the attack just used
	ld hl,EffectsArray1
	ld de,1
	call IsInArray
	jp c,$7132
	ld a,[$CFD3]
	ld hl,EffectsArray5B
	ld de,1
	call IsInArray
	call c,$7132
	ld a,[$CFD3]
	ld hl,EffectsArray2
	ld de,1
	call IsInArray
	jp c,$5702
	call $6023
	call $6093
	jr z,.next11\@
	call $5DCF
	call $5F65
	jp z,$574B
	call $63A5
	call $6687
	call $656B
.next11\@
	ld a,[$D05F]
	and a
	jr z,.next\@
	ld a,[$CFD3]
	sub a,7
	jr z,.next2\@
	jr .next3\@ ; 574B
.next\@
	ld a,[$CFD3]
	and a
	ld a,4
	jr z,.next2\@
	ld a,5
.next2\@
	push af
	ld a,[$D063]
	bit 4,a
	ld hl,$5747
	ld b,$1E
	call nz,Bankswitch
	pop af
	ld [$CC5B],a
	ld a,[$CFD2]
	call $6F07
	call $6ED3
	call $4D60
	ld a,[$D063]
	bit 4,a
	ld hl,$5771
	ld b,$1E
	call nz,Bankswitch
	jr .next4\@
.next3\@
	ld c,$1E
	call $3739
	ld a,[$CFD3]
	cp a,$2B
	jr z,.next5\@
	cp a,$27 ; XXX SLP | FRZ ?
	jr z,.next5\@
	jr .next4\@
.next5\@
	xor a
	ld [$CC5B],a
	ld a,$A7
	call $6F07
.next4\@
	ld a,[$CFD3]
	cp a,9
	jr nz,.next6\@ ; 577A
	call $62FD
	jp z,Function580A
	xor a
	ld [$CCED],a
	jp $569A
.next6\@
	cp a,$53
	jr nz,.next7\@ ; 5784
	call $6348
	jp $569A
.next7\@
	ld a,[$CFD3]
	ld hl,EffectsArray3
	ld de,1
	call IsInArray
	jp c,$7132
	ld a,[$D05F]
	and a
	jr z,.next8\@ ; 57A6
	call $5BE2
	ld a,[$CFD3]
	cp a,7
	jr z,.next9\@ ; 57B9
	jp Function580A
.next8\@
	call $60DF
	call $5C5C
	ld hl,$7B7B ; MyFunction
	ld b,$B ; BANK(MyFunction)
	call Bankswitch
	ld a,1
	ld [$CCF4],a
.next9\@
	ld a,[$CFD3]
	ld hl,EffectsArray4
	ld de,1
	call IsInArray
	call c,$7132
	ld hl,$CFE6
	ld a,[hli]
	ld b,[hl]
	or b
	ret z
	call $62B6

	ld hl,$D062
	bit 2,[hl]
	jr z,.next10\@ ; 57EF
	ld a,[$D06A]
	dec a
	ld [$D06A],a
	jp nz,$5714

	res 2,[hl]
	ld hl,MultiHitText
	call PrintText
	xor a
	ld [W_NUMHITS],a ; reset
.next10\@
	ld a,[$CFD3]
	and a
	jp z,Function580A
	ld hl,EffectsArray5
	ld de,1
	call IsInArray
	call nc,$7132
	jp Function580A

MultiHitText:
	TX_FAR _MultiHitText
	db "@"

Function580A: ; 580A
	xor a
	ld [$CD6A],a
	ld b,1
	ret

Function5811: ; 5811
; print the ghost battle messages
	call $583A
	ret nz
	ld a,[H_WHOSETURN]
	and a
	jr nz,.Ghost\@
	ld a,[W_CURMONSTATUS] ; player’s turn
	and a,SLP | FRZ
	ret nz
	ld hl,ScaredText
	call PrintText
	xor a
	ret
.Ghost\@ ; ghost’s turn
	ld hl,GetOutText
	call PrintText
	xor a
	ret

ScaredText:
	TX_FAR _ScaredText
	db "@"

GetOutText:
	TX_FAR _GetOutText
	db "@"

Function583A: ; 583A
	ld a,[W_ISINBATTLE]
	dec a
	ret nz
	ld a,[W_CURMAP]
	cp a,$8E ; Lavender Town
	jr c,.next\@
	cp a,$95 ; Pokémon Tower
	jr nc,.next\@
	ld b,SILPH_SCOPE
	call IsItemInBag ; $3493
	ret z
.next\@
	ld a,1
	and a
	ret

Function5854: ; 5854
	ld hl,W_CURMONSTATUS
	ld a,[hl]
	and a,SLP
	jr z,.FrozenCheck\@ ; to 5884

	dec a
	ld [W_CURMONSTATUS],a ; decrement sleep count
	and a
	jr z,.WakeUp\@ ; to 5874

	xor a
	ld [$CC5B],a
	ld a,SLP_ANIM - 1
	call $6F07
	ld hl,FastAsleepText
	call PrintText
	jr .sleepDone\@
.WakeUp\@
	ld hl,WokeUpText
	call PrintText
.sleepDone\@
	xor a
	ld [$CCF1],a
	ld hl,Function580A
	jp $5A37

.FrozenCheck\@
	bit 5,[hl] ; frozen?
	jr z,.HeldInPlaceCheck\@ ; to 5898
	ld hl,FrozenText
	call PrintText
	xor a
	ld [$CCF1],a
	ld hl,Function580A
	jp $5A37

.HeldInPlaceCheck\@
	ld a,[W_CURMONBATTSTATUS]
	bit 5,a
	jp z,FlinchedCheck
	ld hl,CantMoveText
	call PrintText
	ld hl,Function580A
	jp $5A37

FlinchedCheck: ; 58AC
	ld hl,$D062
	bit 3,[hl]
	jp z,HyperBeamCheck
	res 3,[hl]
	ld hl,FlinchedText
	call PrintText
	ld hl,Function580A
	jp $5A37

HyperBeamCheck: ; 58C2
	ld hl,$D063
	bit 5,[hl]
	jr z,.next\@ ; 58D7
	res 5,[hl]
	ld hl,MustRechargeText
	call PrintText
	ld hl,$580A
	jp $5A37
.next\@
	ld hl,$D06D
	ld a,[hl]
	and a
	jr z,.next2\@ ; 58EE
	dec a
	ld [hl],a
	and a,$F
	jr nz,.next2\@
	ld [hl],a
	ld [$CCEE],a
	ld hl,DisabledNoMoreText
	call PrintText
.next2\@
	ld a,[$D062]
	add a
	jr nc,.next3\@ ; 5929
	ld hl,$D06B
	dec [hl]
	jr nz,.next4\@ ; 5907
	ld hl,$D062
	res 7,[hl]
	ld hl,ConfusedNoMoreText
	call PrintText
	jr .next3\@
.next4\@
	ld hl,IsConfusedText
	call PrintText
	xor a
	ld [$CC5B],a
	ld a,CONF_ANIM - 1
	call $6F07
	call $6E9B
	cp a,$80
	jr c,.next3\@
	ld hl,$D062
	ld a,[hl]
	and a,$80
	ld [hl],a
	call $5AAD
	jr .next5\@ ; 5952
.next3\@
	ld a,[$CCEE]
	and a
	jr z,.ParalysisCheck\@ ; 593E
	ld hl,$CCDC
	cp [hl]
	jr nz,.ParalysisCheck\@
	call $5A88
	ld hl,$580A
	jp $5A37
.ParalysisCheck\@
	ld hl,W_CURMONSTATUS
	bit 6,[hl]
	jr z,.next7\@ ; 5975
	call $6E9B ; random number?
	cp a,$3F
	jr nc,.next7\@
	ld hl,FullyParalyzedText
	call PrintText
.next5\@
	ld hl,$D062
	ld a,[hl]
	and a,$CC
	ld [hl],a
	ld a,[$CFD3]
	cp a,$2B
	jr z,.next8\@ ; 5966
	cp a,$27
	jr z,.next8\@
	jr .next9\@ ; 596F
.next8\@
	xor a
	ld [$CC5B],a
	ld a,$A7
	call $6F07
.next9\@
	ld hl,$580A
	jp $5A37
.next7\@
	ld hl,$D062
	bit 0,[hl]
	jr z,.next10\@ ; 59D0
	xor a
	ld [$CFD2],a
	ld hl,$D0D7
	ld a,[hli]
	ld b,a
	ld c,[hl]
	ld hl,$D075
	ld a,[hl]
	add c
	ld [hld],a
	ld a,[hl]
	adc b
	ld [hl],a
	ld hl,$D06A
	dec [hl]
	jr z,.next11\@ ; 599B
	ld hl,$580A
	jp $5A37
.next11\@
	ld hl,$D062
	res 0,[hl]
	ld hl,UnleashedEnergyText
	call PrintText
	ld a,1
	ld [$CFD4],a
	ld hl,$D075
	ld a,[hld]
	add a
	ld b,a
	ld [$D0D8],a
	ld a,[hl]
	rl a
	ld [$D0D7],a
	or b
	jr nz,.next12\@ ; 59C2
	ld a,1
	ld [$D05F],a
.next12\@
	xor a
	ld [hli],a
	ld [hl],a
	ld a,$75
	ld [$CFD2],a
	ld hl,$5705
	jp $5A37
.next10\@
	bit 1,[hl]
	jr z,.next13\@ ; 59FF
	ld a,$25
	ld [$CFD2],a
	ld hl,ThrashingAboutText
	call PrintText
	ld hl,$D06A
	dec [hl]
	ld hl,$56DC
	jp nz,$5A37
	push hl
	ld hl,$D062
	res 1,[hl]
	set 7,[hl]
	call $6E9B ; random number?
	and a,3
	inc a
	inc a
	ld [$D06B],a
	pop hl
	jp $5A37
.next13\@
	bit 5,[hl]
	jp z,$5A1A
	ld hl,AttackContinuesText
	call PrintText
	ld a,[$D06A]
	dec a
	ld [$D06A],a
	ld hl,$5714
	jp nz,$5A37
	jp $5A37

INCBIN "baserom.gbc",$3DA1A,$3DA3D - $3DA1A

FastAsleepText:
	TX_FAR _FastAsleepText
	db "@"

WokeUpText:
	TX_FAR _WokeUpText
	db "@"

FrozenText:
	TX_FAR _FrozenText
	db "@"

FullyParalyzedText:
	TX_FAR _FullyParalyzedText
	db "@"

FlinchedText:
	TX_FAR _FlinchedText
	db "@"

MustRechargeText:
	TX_FAR _MustRechargeText
	db "@"

DisabledNoMoreText:
	TX_FAR _DisabledNoMoreText
	db "@"

IsConfusedText:
	TX_FAR _IsConfusedText
	db "@"

HurtItselfText:
	TX_FAR _HurtItselfText
	db "@"

ConfusedNoMoreText:
	TX_FAR _ConfusedNoMoreText
	db "@"

SavingEnergyText:
	TX_FAR _SavingEnergyText
	db "@"

UnleashedEnergyText:
	TX_FAR _UnleashedEnergyText
	db "@"

ThrashingAboutText:
	TX_FAR _ThrashingAboutText
	db "@"

AttackContinuesText:
	TX_FAR _AttackContinuesText
	db "@"

CantMoveText:
	TX_FAR _CantMoveText
	db "@"

INCBIN "baserom.gbc",$3da88,$3daa8 - $3da88

UnnamedText_3daa8: ; 0x3daa8
    TX_FAR _UnnamedText_3daa8
    db $50
; 0x3daa8 + 5 bytes

INCBIN "baserom.gbc",$3daad,$3db6c - $3daad

UnnamedText_3db6c: ; 0x3db6c
    TX_FAR _UnnamedText_3db6c
    db $50
; 0x3db6c + 5 bytes

UnnamedText_3db71: ; 0x3db71
    TX_FAR _UnnamedText_3db71
    db $50
; 0x3db71 + 5 bytes

UnnamedText_3db76: ; 0x3db76
    TX_FAR _UnnamedText_3db76
    db $50
; 0x3db76 + 5 bytes

UnnamedText_3db7b: ; 0x3db7b
    TX_FAR _UnnamedText_3db7b
    db $50
; 0x3db7b + 5 bytes

UnnamedText_3db80: ; 0x3db80
    TX_FAR _UnnamedText_3db80
    db $50
; 0x3db80 + 5 bytes

INCBIN "baserom.gbc",$3db85,$3dc42 - $3db85

UnnamedText_3dc42: ; 0x3dc42
    TX_FAR _UnnamedText_3dc42
    db $50
; 0x3dc42 + 5 bytes

UnnamedText_3dc47: ; 0x3dc47
    TX_FAR _UnnamedText_3dc47
    db $50
; 0x3dc47 + 5 bytes

UnnamedText_3dc4c: ; 0x3dc4c
    TX_FAR _UnnamedText_3dc4c
    db $50
; 0x3dc4c + 5 bytes

INCBIN "baserom.gbc",$3dc51,$3dc57 - $3dc51

UnnamedText_3dc57: ; 0x3dc57
    TX_FAR _UnnamedText_3dc57
    db $50
; 0x3dc57 + 5 bytes

INCBIN "baserom.gbc",$3dc5c,$3dc7e - $3dc5c

UnnamedText_3dc7e: ; 0x3dc7e
    TX_FAR _UnnamedText_3dc7e
    db $50
; 0x3dc7e + 5 bytes

UnnamedText_3dc83: ; 0x3dc83
    TX_FAR _UnnamedText_3dc83
    db $50
; 0x3dc83 + 5 bytes

INCBIN "baserom.gbc",$3dc88,$3ddb6 - $3dc88

UnnamedText_3ddb6: ; 0x3ddb6
    TX_FAR _UnnamedText_3ddb6
    db $50
; 0x3ddb6 + 5 bytes

UnnamedText_3ddbb: ; 0x3ddbb
    TX_FAR _UnnamedText_3ddbb
    db $50
; 0x3ddbb + 5 bytes

UnnamedText_3ddc0: ; 0x3ddc0
    TX_FAR _UnnamedText_3ddc0
    db $50
; 0x3ddc0 + 5 bytes

UnnamedText_3ddc5: ; 0x3ddc5
    TX_FAR _UnnamedText_3ddc5
    db $50
; 0x3ddc5 + 5 bytes

UnnamedText_3ddca: ; 0x3ddca
    TX_FAR _UnnamedText_3ddca
    db $50
; 0x3ddca + 5 bytes

INCBIN "baserom.gbc",$3ddcf,$3e2ac - $3ddcf

UnnamedText_3e2ac: ; 0x3e2ac
    TX_FAR _UnnamedText_3e2ac
    db $50
; 0x3e2ac + 5 bytes

UnnamedText_3e2b1: ; 0x3e2b1
    TX_FAR _UnnamedText_3e2b1
    db $50
; 0x3e2b1 + 5 bytes

INCBIN "baserom.gbc",$3e2b6,$3e2f8 - $3e2b6

UnnamedText_3e2f8: ; 0x3e2f8
    TX_FAR _UnnamedText_3e2f8
    db $50
; 0x3e2f8 + 5 bytes

INCBIN "baserom.gbc",$3e2fd,$3e324 - $3e2fd

UnnamedText_3e324: ; 0x3e324
    TX_FAR _UnnamedText_3e324
    db $50
; 0x3e324 + 5 bytes

INCBIN "baserom.gbc",$3e329,$14b

TypeEffects: ; 6474
; format: attacking type, defending type, damage multiplier
; the multiplier is a (decimal) fixed-point number:
;     20 is ×2.0
;     05 is ×0.5
;     00 is ×0
	db WATER,FIRE,20
	db FIRE,GRASS,20
	db FIRE,ICE,20
	db GRASS,WATER,20
	db ELECTRIC,WATER,20
	db WATER,ROCK,20
	db GROUND,FLYING,00
	db WATER,WATER,05
	db FIRE,FIRE,05
	db ELECTRIC,ELECTRIC,05
	db ICE,ICE,05
	db GRASS,GRASS,05
	db PSYCHIC,PSYCHIC,05
	db FIRE,WATER,05
	db GRASS,FIRE,05
	db WATER,GRASS,05
	db ELECTRIC,GRASS,05
	db NORMAL,ROCK,05
	db NORMAL,GHOST,00
	db GHOST,GHOST,20
	db FIRE,BUG,20
	db FIRE,ROCK,05
	db WATER,GROUND,20
	db ELECTRIC,GROUND,00
	db ELECTRIC,FLYING,20
	db GRASS,GROUND,20
	db GRASS,BUG,05
	db GRASS,POISON,05
	db GRASS,ROCK,20
	db GRASS,FLYING,05
	db ICE,WATER,05
	db ICE,GRASS,20
	db ICE,GROUND,20
	db ICE,FLYING,20
	db FIGHTING,NORMAL,20
	db FIGHTING,POISON,05
	db FIGHTING,FLYING,05
	db FIGHTING,PSYCHIC,05
	db FIGHTING,BUG,05
	db FIGHTING,ROCK,20
	db FIGHTING,ICE,20
	db FIGHTING,GHOST,00
	db POISON,GRASS,20
	db POISON,POISON,05
	db POISON,GROUND,05
	db POISON,BUG,20
	db POISON,ROCK,05
	db POISON,GHOST,05
	db GROUND,FIRE,20
	db GROUND,ELECTRIC,20
	db GROUND,GRASS,05
	db GROUND,BUG,05
	db GROUND,ROCK,20
	db GROUND,POISON,20
	db FLYING,ELECTRIC,05
	db FLYING,FIGHTING,20
	db FLYING,BUG,20
	db FLYING,GRASS,20
	db FLYING,ROCK,05
	db PSYCHIC,FIGHTING,20
	db PSYCHIC,POISON,20
	db BUG,FIRE,05
	db BUG,GRASS,20
	db BUG,FIGHTING,05
	db BUG,FLYING,05
	db BUG,PSYCHIC,20
	db BUG,GHOST,05
	db BUG,POISON,20
	db ROCK,FIRE,20
	db ROCK,FIGHTING,05
	db ROCK,GROUND,05
	db ROCK,FLYING,20
	db ROCK,BUG,20
	db ROCK,ICE,20
	db GHOST,NORMAL,00
	db GHOST,PSYCHIC,00
	db FIRE,DRAGON,05
	db WATER,DRAGON,05
	db ELECTRIC,DRAGON,05
	db GRASS,DRAGON,05
	db ICE,DRAGON,20
	db DRAGON,DRAGON,20
	db $FF

INCBIN "baserom.gbc",$3e56b,$3e887 - $3e56b

UnnamedText_3e887: ; 0x3e887
    TX_FAR _UnnamedText_3e887
    db $50
; 0x3e887 + 5 bytes

INCBIN "baserom.gbc",$3e88c,$67b

PlayAttackAnimation: ; 6F07
	ld [$D07C],a
	call Delay3
	ld a,8
	jp Predef

INCBIN "baserom.gbc",$3ef12,$3f245 - $3ef12

UnnamedText_3f245: ; 0x3f245
    TX_FAR _UnnamedText_3f245
    db $50
; 0x3f245 + 5 bytes

UnnamedText_3f24a: ; 0x3f24a
    TX_FAR _UnnamedText_3f24a
    db $50
; 0x3f24a + 5 bytes

INCBIN "baserom.gbc",$3f24f,$3f2df - $3f24f

UnnamedText_3f2df: ; 0x3f2df
    TX_FAR _UnnamedText_3f2df
    db $50
; 0x3f2df + 5 bytes

UnnamedText_3f2e4: ; 0x3f2e4
    TX_FAR _UnnamedText_3f2e4
    db $50
; 0x3f2e4 + 5 bytes

INCBIN "baserom.gbc",$3f2e9,$3f3d8 - $3f2e9

UnnamedText_3f3d8: ; 0x3f3d8
    TX_FAR _UnnamedText_3f3d8
    db $50
; 0x3f3d8 + 5 bytes

UnnamedText_3f3dd: ; 0x3f3dd
    TX_FAR _UnnamedText_3f3dd
    db $50
; 0x3f3dd + 5 bytes

INCBIN "baserom.gbc",$3f3e2,$3f423 - $3f3e2

UnnamedText_3f423: ; 0x3f423
    TX_FAR _UnnamedText_3f423
    db $50
; 0x3f423 + 5 bytes

INCBIN "baserom.gbc",$3f428,$3f547 - $3f428

UnnamedText_3f547: ; 0x3f547
    TX_FAR _UnnamedText_3f547
    db $50
; 0x3f547 + 5 bytes

INCBIN "baserom.gbc",$3f54c,$3f683 - $3f54c

UnnamedText_3f683: ; 0x3f683
    TX_FAR _UnnamedText_3f683
    db $50
; 0x3f683 + 5 bytes

INCBIN "baserom.gbc",$3f688,$3f802 - $3f688

UnnamedText_3f802: ; 0x3f802
    TX_FAR _UnnamedText_3f802
    db $50
; 0x3f802 + 5 bytes

UnnamedText_3f807: ; 0x3f807
    TX_FAR _UnnamedText_3f807
    db $50
; 0x3f807 + 5 bytes

UnnamedText_3f80c: ; 0x3f80c
    TX_FAR _UnnamedText_3f80c
    db $50
; 0x3f80c + 5 bytes

INCBIN "baserom.gbc",$3f811,$3f8f9 - $3f811

UnnamedText_3f8f9: ; 0x3f8f9
    TX_FAR _UnnamedText_3f8f9
    db $50
; 0x3f8f9 + 5 bytes

UnnamedText_3f8fe: ; 0x3f8fe
    TX_FAR _UnnamedText_3f8fe
    db $50
; 0x3f8fe + 5 bytes

UnnamedText_3f903: ; 0x3f903
    TX_FAR _UnnamedText_3f903
    db $50
; 0x3f903 + 5 bytes

UnnamedText_3f908: ; 0x3f908
    TX_FAR _UnnamedText_3f908
    db $50
; 0x3f908 + 5 bytes

UnnamedText_3f90d: ; 0x3f90d
    TX_FAR _UnnamedText_3f90d
    db $50
; 0x3f90d + 5 bytes

UnnamedText_3f912: ; 0x3f912
    TX_FAR _UnnamedText_3f912
    db $50
; 0x3f912 + 5 bytes

INCBIN "baserom.gbc",$3f917,$3f9a1 - $3f917

UnnamedText_3f9a1: ; 0x3f9a1
    TX_FAR _UnnamedText_3f9a1
    db $50
; 0x3f9a1 + 5 bytes

INCBIN "baserom.gbc",$3f9a6,$3fa77 - $3f9a6

UnnamedText_3fa77: ; 0x3fa77
    TX_FAR _UnnamedText_3fa77
    db $50
; 0x3fa77 + 5 bytes

INCBIN "baserom.gbc",$3fa7c,$3fb09 - $3fa7c

UnnamedText_3fb09: ; 0x3fb09
    TX_FAR _UnnamedText_3fb09
    db $50
; 0x3fb09 + 5 bytes

INCBIN "baserom.gbc",$3fb0e,$3fb3e - $3fb0e

UnnamedText_3fb3e: ; 0x3fb3e
    TX_FAR _UnnamedText_3fb3e
    db $50
; 0x3fb3e + 5 bytes

INCBIN "baserom.gbc",$3fb43,$3fb49 - $3fb43

UnnamedText_3fb49: ; 0x3fb49
    TX_FAR _UnnamedText_3fb49
    db $50
; 0x3fb49 + 5 bytes

INCBIN "baserom.gbc",$3fb4e,$3fb59 - $3fb4e

UnnamedText_3fb59: ; 0x3fb59
    TX_FAR _UnnamedText_3fb59
    db $50
; 0x3fb59 + 5 bytes

INCBIN "baserom.gbc",$3fb5e,$3fb64 - $3fb5e

UnnamedText_3fb64: ; 0x3fb64
    TX_FAR _UnnamedText_3fb64
    db $50
; 0x3fb64 + 5 bytes

UnnamedText_3fb69: ; 0x3fb69
    TX_FAR _UnnamedText_3fb69
    db $50
; 0x3fb69 + 5 bytes

INCBIN "baserom.gbc",$3fb6e,$3fb74 - $3fb6e

UnnamedText_3fb74: ; 0x3fb74
    TX_FAR _UnnamedText_3fb74
    db $50
; 0x3fb74 + 5 bytes

INCBIN "baserom.gbc",$3fb79,$487

SECTION "bank10",DATA,BANK[$10]

INCBIN "baserom.gbc",$40000,$47E

PokedexEntryPointers: ; 447E
	dw RhydonDexEntry
	dw KangaskhanDexEntry
	dw NidoranMDexEntry
	dw ClefairyDexEntry
	dw SpearowDexEntry
	dw VoltorbDexEntry
	dw NidokingDexEntry
	dw SlowbroDexEntry
	dw IvysaurDexEntry
	dw ExeggutorDexEntry
	dw LickitungDexEntry
	dw ExeggcuteDexEntry
	dw GrimerDexEntry
	dw GengarDexEntry
	dw NidoranFDexEntry
	dw NidoqueenDexEntry
	dw CuboneDexEntry
	dw RhyhornDexEntry
	dw LaprasDexEntry
	dw ArcanineDexEntry
	dw MewDexEntry
	dw GyaradosDexEntry
	dw ShellderDexEntry
	dw TentacoolDexEntry
	dw GastlyDexEntry
	dw ScytherDexEntry
	dw StaryuDexEntry
	dw BlastoiseDexEntry
	dw PinsirDexEntry
	dw TangelaDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw GrowlitheDexEntry
	dw OnixDexEntry
	dw FearowDexEntry
	dw PidgeyDexEntry
	dw SlowpokeDexEntry
	dw KadabraDexEntry
	dw GravelerDexEntry
	dw ChanseyDexEntry
	dw MachokeDexEntry
	dw MrMimeDexEntry
	dw HitmonleeDexEntry
	dw HitmonchanDexEntry
	dw ArbokDexEntry
	dw ParasectDexEntry
	dw PsyduckDexEntry
	dw DrowzeeDexEntry
	dw GolemDexEntry
	dw MissingNoDexEntry
	dw MagmarDexEntry
	dw MissingNoDexEntry
	dw ElectabuzzDexEntry
	dw MagnetonDexEntry
	dw KoffingDexEntry
	dw MissingNoDexEntry
	dw MankeyDexEntry
	dw SeelDexEntry
	dw DiglettDexEntry
	dw TaurosDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw FarfetchdDexEntry
	dw VenonatDexEntry
	dw DragoniteDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw DoduoDexEntry
	dw PoliwagDexEntry
	dw JynxDexEntry
	dw MoltresDexEntry
	dw ArticunoDexEntry
	dw ZapdosDexEntry
	dw DittoDexEntry
	dw MeowthDexEntry
	dw KrabbyDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw VulpixDexEntry
	dw NinetalesDexEntry
	dw PikachuDexEntry
	dw RaichuDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw DratiniDexEntry
	dw DragonairDexEntry
	dw KabutoDexEntry
	dw KabutopsDexEntry
	dw HorseaDexEntry
	dw SeadraDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw SandshrewDexEntry
	dw SandslashDexEntry
	dw OmanyteDexEntry
	dw OmastarDexEntry
	dw JigglypuffDexEntry
	dw WigglytuffDexEntry
	dw EeveeDexEntry
	dw FlareonDexEntry
	dw JolteonDexEntry
	dw VaporeonDexEntry
	dw MachopDexEntry
	dw ZubatDexEntry
	dw EkansDexEntry
	dw ParasDexEntry
	dw PoliwhirlDexEntry
	dw PoliwrathDexEntry
	dw WeedleDexEntry
	dw KakunaDexEntry
	dw BeedrillDexEntry
	dw MissingNoDexEntry
	dw DodrioDexEntry
	dw PrimeapeDexEntry
	dw DugtrioDexEntry
	dw VenomothDexEntry
	dw DewgongDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw CaterpieDexEntry
	dw MetapodDexEntry
	dw ButterfreeDexEntry
	dw MachampDexEntry
	dw MissingNoDexEntry
	dw GolduckDexEntry
	dw HypnoDexEntry
	dw GolbatDexEntry
	dw MewtwoDexEntry
	dw SnorlaxDexEntry
	dw MagikarpDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw MukDexEntry
	dw MissingNoDexEntry
	dw KinglerDexEntry
	dw CloysterDexEntry
	dw MissingNoDexEntry
	dw ElectrodeDexEntry
	dw ClefableDexEntry
	dw WeezingDexEntry
	dw PersianDexEntry
	dw MarowakDexEntry
	dw MissingNoDexEntry
	dw HaunterDexEntry
	dw AbraDexEntry
	dw AlakazamDexEntry
	dw PidgeottoDexEntry
	dw PidgeotDexEntry
	dw StarmieDexEntry
	dw BulbasaurDexEntry
	dw VenusaurDexEntry
	dw TentacruelDexEntry
	dw MissingNoDexEntry
	dw GoldeenDexEntry
	dw SeakingDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw PonytaDexEntry
	dw RapidashDexEntry
	dw RattataDexEntry
	dw RaticateDexEntry
	dw NidorinoDexEntry
	dw NidorinaDexEntry
	dw GeodudeDexEntry
	dw PorygonDexEntry
	dw AerodactylDexEntry
	dw MissingNoDexEntry
	dw MagnemiteDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw CharmanderDexEntry
	dw SquirtleDexEntry
	dw CharmeleonDexEntry
	dw WartortleDexEntry
	dw CharizardDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw MissingNoDexEntry
	dw OddishDexEntry
	dw GloomDexEntry
	dw VileplumeDexEntry
	dw BellsproutDexEntry
	dw WeepinbellDexEntry
	dw VictreebelDexEntry

; string: species name
; height in feet, inches
; weight in pounds
; text entry

RhydonDexEntry:
	db "DRILL@"
	db 6,3
	dw 2650
	TX_FAR _RhydonDexEntry
	db "@"

KangaskhanDexEntry:
	db "PARENT@"
	db 7,3
	dw 1760
	TX_FAR _KangaskhanDexEntry
	db "@"

NidoranMDexEntry:
	db "POISON PIN@"
	db 1,8
	dw 200
	TX_FAR _NidoranMDexEntry
	db "@"

ClefairyDexEntry:
	db "FAIRY@"
	db 2,0
	dw 170
	TX_FAR _ClefairyDexEntry
	db "@"

SpearowDexEntry:
	db "TINY BIRD@"
	db 1,0
	dw 40
	TX_FAR _SpearowDexEntry
	db "@"

VoltorbDexEntry:
	db "BALL@"
	db 1,8
	dw 230
	TX_FAR _VoltorbDexEntry
	db "@"

NidokingDexEntry:
	db "DRILL@"
	db 4,7
	dw 1370
	TX_FAR _NidokingDexEntry
	db "@"

SlowbroDexEntry:
	db "HERMITCRAB@"
	db 5,3
	dw 1730
	TX_FAR _SlowbroDexEntry
	db "@"

IvysaurDexEntry:
	db "SEED@"
	db 3,3
	dw 290
	TX_FAR _IvysaurDexEntry
	db "@"

ExeggutorDexEntry:
	db "COCONUT@"
	db 6,7
	dw 2650
	TX_FAR _ExeggutorDexEntry
	db "@"

LickitungDexEntry:
	db "LICKING@"
	db 3,11
	dw 1440
	TX_FAR _LickitungDexEntry
	db "@"

ExeggcuteDexEntry:
	db "EGG@"
	db 1,4
	dw 60
	TX_FAR _ExeggcuteDexEntry
	db "@"

GrimerDexEntry:
	db "SLUDGE@"
	db 2,11
	dw 660
	TX_FAR _GrimerDexEntry
	db "@"

GengarDexEntry:
	db "SHADOW@"
	db 4,11
	dw 890
	TX_FAR _GengarDexEntry
	db "@"

NidoranFDexEntry:
	db "POISON PIN@"
	db 1,4
	dw 150
	TX_FAR _NidoranFDexEntry
	db "@"

NidoqueenDexEntry:
	db "DRILL@"
	db 4,3
	dw 1320
	TX_FAR _NidoqueenDexEntry
	db "@"

CuboneDexEntry:
	db "LONELY@"
	db 1,4
	dw 140
	TX_FAR _CuboneDexEntry
	db "@"

RhyhornDexEntry:
	db "SPIKES@"
	db 3,3
	dw 2540
	TX_FAR _RhyhornDexEntry
	db "@"

LaprasDexEntry:
	db "TRANSPORT@"
	db 8,2
	dw 4850
	TX_FAR _LaprasDexEntry
	db "@"

ArcanineDexEntry:
	db "LEGENDARY@"
	db 6,3
	dw 3420
	TX_FAR _ArcanineDexEntry
	db "@"

MewDexEntry:
	db "NEW SPECIE@"
	db 1,4
	dw 90
	TX_FAR _MewDexEntry
	db "@"

GyaradosDexEntry:
	db "ATROCIOUS@"
	db 21,4
	dw 5180
	TX_FAR _GyaradosDexEntry
	db "@"

ShellderDexEntry:
	db "BIVALVE@"
	db 1,0
	dw 90
	TX_FAR _ShellderDexEntry
	db "@"

TentacoolDexEntry:
	db "JELLYFISH@"
	db 2,11
	dw 1000
	TX_FAR _TentacoolDexEntry
	db "@"

GastlyDexEntry:
	db "GAS@"
	db 4,3
	dw 2
	TX_FAR _GastlyDexEntry
	db "@"

ScytherDexEntry:
	db "MANTIS@"
	db 4,11
	dw 1230
	TX_FAR _ScytherDexEntry
	db "@"

StaryuDexEntry:
	db "STARSHAPE@"
	db 2,7
	dw 760
	TX_FAR _StaryuDexEntry
	db "@"

BlastoiseDexEntry:
	db "SHELLFISH@"
	db 5,3
	dw 1890
	TX_FAR _BlastoiseDexEntry
	db "@"

PinsirDexEntry:
	db "STAGBEETLE@"
	db 4,11
	dw 1210
	TX_FAR _PinsirDexEntry
	db "@"

TangelaDexEntry:
	db "VINE@"
	db 3,3
	dw 770
	TX_FAR _TangelaDexEntry
	db "@"

GrowlitheDexEntry:
	db "PUPPY@"
	db 2,4
	dw 420
	TX_FAR _GrowlitheDexEntry
	db "@"

OnixDexEntry:
	db "ROCK SNAKE@"
	db 28,10
	dw 4630
	TX_FAR _OnixDexEntry
	db "@"

FearowDexEntry:
	db "BEAK@"
	db 3,11
	dw 840
	TX_FAR _FearowDexEntry
	db "@"

PidgeyDexEntry:
	db "TINY BIRD@"
	db 1,0
	dw 40
	TX_FAR _PidgeyDexEntry
	db "@"

SlowpokeDexEntry:
	db "DOPEY@"
	db 3,11
	dw 790
	TX_FAR _SlowpokeDexEntry
	db "@"

KadabraDexEntry:
	db "PSI@"
	db 4,3
	dw 1250
	TX_FAR _KadabraDexEntry
	db "@"

GravelerDexEntry:
	db "ROCK@"
	db 3,3
	dw 2320
	TX_FAR _GravelerDexEntry
	db "@"

ChanseyDexEntry:
	db "EGG@"
	db 3,7
	dw 760
	TX_FAR _ChanseyDexEntry
	db "@"

MachokeDexEntry:
	db "SUPERPOWER@"
	db 4,11
	dw 1550
	TX_FAR _MachokeDexEntry
	db "@"

MrMimeDexEntry:
	db "BARRIER@"
	db 4,3
	dw 1200
	TX_FAR _MrMimeDexEntry
	db "@"

HitmonleeDexEntry:
	db "KICKING@"
	db 4,11
	dw 1100
	TX_FAR _HitmonleeDexEntry
	db "@"

HitmonchanDexEntry:
	db "PUNCHING@"
	db 4,7
	dw 1110
	TX_FAR _HitmonchanDexEntry
	db "@"

ArbokDexEntry:
	db "COBRA@"
	db 11,6
	dw 1430
	TX_FAR _ArbokDexEntry
	db "@"

ParasectDexEntry:
	db "MUSHROOM@"
	db 3,3
	dw 650
	TX_FAR _ParasectDexEntry
	db "@"

PsyduckDexEntry:
	db "DUCK@"
	db 2,7
	dw 430
	TX_FAR _PsyduckDexEntry
	db "@"

DrowzeeDexEntry:
	db "HYPNOSIS@"
	db 3,3
	dw 710
	TX_FAR _DrowzeeDexEntry
	db "@"

GolemDexEntry:
	db "MEGATON@"
	db 4,7
	dw 6620
	TX_FAR _GolemDexEntry
	db "@"

MagmarDexEntry:
	db "SPITFIRE@"
	db 4,3
	dw 980
	TX_FAR _MagmarDexEntry
	db "@"

ElectabuzzDexEntry:
	db "ELECTRIC@"
	db 3,7
	dw 660
	TX_FAR _ElectabuzzDexEntry
	db "@"

MagnetonDexEntry:
	db "MAGNET@"
	db 3,3
	dw 1320
	TX_FAR _MagnetonDexEntry
	db "@"

KoffingDexEntry:
	db "POISON GAS@"
	db 2,0
	dw 20
	TX_FAR _KoffingDexEntry
	db "@"

MankeyDexEntry:
	db "PIG MONKEY@"
	db 1,8
	dw 620
	TX_FAR _MankeyDexEntry
	db "@"

SeelDexEntry:
	db "SEA LION@"
	db 3,7
	dw 1980
	TX_FAR _SeelDexEntry
	db "@"

DiglettDexEntry:
	db "MOLE@"
	db 0,8
	dw 20
	TX_FAR _DiglettDexEntry
	db "@"

TaurosDexEntry:
	db "WILD BULL@"
	db 4,7
	dw 1950
	TX_FAR _TaurosDexEntry
	db "@"

FarfetchdDexEntry:
	db "WILD DUCK@"
	db 2,7
	dw 330
	TX_FAR _FarfetchdDexEntry
	db "@"

VenonatDexEntry:
	db "INSECT@"
	db 3,3
	dw 660
	TX_FAR _VenonatDexEntry
	db "@"

DragoniteDexEntry:
	db "DRAGON@"
	db 7,3
	dw 4630
	TX_FAR _DragoniteDexEntry
	db "@"

DoduoDexEntry:
	db "TWIN BIRD@"
	db 4,7
	dw 860
	TX_FAR _DoduoDexEntry
	db "@"

PoliwagDexEntry:
	db "TADPOLE@"
	db 2,0
	dw 270
	TX_FAR _PoliwagDexEntry
	db "@"

JynxDexEntry:
	db "HUMANSHAPE@"
	db 4,7
	dw 900
	TX_FAR _JynxDexEntry
	db "@"

MoltresDexEntry:
	db "FLAME@"
	db 6,7
	dw 1320
	TX_FAR _MoltresDexEntry
	db "@"

ArticunoDexEntry:
	db "FREEZE@"
	db 5,7
	dw 1220
	TX_FAR _ArticunoDexEntry
	db "@"

ZapdosDexEntry:
	db "ELECTRIC@"
	db 5,3
	dw 1160
	TX_FAR _ZapdosDexEntry
	db "@"

DittoDexEntry:
	db "TRANSFORM@"
	db 1,0
	dw 90
	TX_FAR _DittoDexEntry
	db "@"

MeowthDexEntry:
	db "SCRATCHCAT@"
	db 1,4
	dw 90
	TX_FAR _MeowthDexEntry
	db "@"

KrabbyDexEntry:
	db "RIVER CRAB@"
	db 1,4
	dw 140
	TX_FAR _KrabbyDexEntry
	db "@"

VulpixDexEntry:
	db "FOX@"
	db 2,0
	dw 220
	TX_FAR _VulpixDexEntry
	db "@"

NinetalesDexEntry:
	db "FOX@"
	db 3,7
	dw 440
	TX_FAR _NinetalesDexEntry
	db "@"

PikachuDexEntry:
	db "MOUSE@"
	db 1,4
	dw 130
	TX_FAR _PikachuDexEntry
	db "@"

RaichuDexEntry:
	db "MOUSE@"
	db 2,7
	dw 660
	TX_FAR _RaichuDexEntry
	db "@"

DratiniDexEntry:
	db "DRAGON@"
	db 5,11
	dw 70
	TX_FAR _DratiniDexEntry
	db "@"

DragonairDexEntry:
	db "DRAGON@"
	db 13,1
	dw 360
	TX_FAR _DragonairDexEntry
	db "@"

KabutoDexEntry:
	db "SHELLFISH@"
	db 1,8
	dw 250
	TX_FAR _KabutoDexEntry
	db "@"

KabutopsDexEntry:
	db "SHELLFISH@"
	db 4,3
	dw 890
	TX_FAR _KabutopsDexEntry
	db "@"

HorseaDexEntry:
	db "DRAGON@"
	db 1,4
	dw 180
	TX_FAR _HorseaDexEntry
	db "@"

SeadraDexEntry:
	db "DRAGON@"
	db 3,11
	dw 550
	TX_FAR _SeadraDexEntry
	db "@"

SandshrewDexEntry:
	db "MOUSE@"
	db 2,0
	dw 260
	TX_FAR _SandshrewDexEntry
	db "@"

SandslashDexEntry:
	db "MOUSE@"
	db 3,3
	dw 650
	TX_FAR _SandslashDexEntry
	db "@"

OmanyteDexEntry:
	db "SPIRAL@"
	db 1,4
	dw 170
	TX_FAR _OmanyteDexEntry
	db "@"

OmastarDexEntry:
	db "SPIRAL@"
	db 3,3
	dw 770
	TX_FAR _OmastarDexEntry
	db "@"

JigglypuffDexEntry:
	db "BALLOON@"
	db 1,8
	dw 120
	TX_FAR _JigglypuffDexEntry
	db "@"

WigglytuffDexEntry:
	db "BALLOON@"
	db 3,3
	dw 260
	TX_FAR _WigglytuffDexEntry
	db "@"

EeveeDexEntry:
	db "EVOLUTION@"
	db 1,0
	dw 140
	TX_FAR _EeveeDexEntry
	db "@"

FlareonDexEntry:
	db "FLAME@"
	db 2,11
	dw 550
	TX_FAR _FlareonDexEntry
	db "@"

JolteonDexEntry:
	db "LIGHTNING@"
	db 2,7
	dw 540
	TX_FAR _JolteonDexEntry
	db "@"

VaporeonDexEntry:
	db "BUBBLE JET@"
	db 3,3
	dw 640
	TX_FAR _VaporeonDexEntry
	db "@"

MachopDexEntry:
	db "SUPERPOWER@"
	db 2,7
	dw 430
	TX_FAR _MachopDexEntry
	db "@"

ZubatDexEntry:
	db "BAT@"
	db 2,7
	dw 170
	TX_FAR _ZubatDexEntry
	db "@"

EkansDexEntry:
	db "SNAKE@"
	db 6,7
	dw 150
	TX_FAR _EkansDexEntry
	db "@"

ParasDexEntry:
	db "MUSHROOM@"
	db 1,0
	dw 120
	TX_FAR _ParasDexEntry
	db "@"

PoliwhirlDexEntry:
	db "TADPOLE@"
	db 3,3
	dw 440
	TX_FAR _PoliwhirlDexEntry
	db "@"

PoliwrathDexEntry:
	db "TADPOLE@"
	db 4,3
	dw 1190
	TX_FAR _PoliwrathDexEntry
	db "@"

WeedleDexEntry:
	db "HAIRY BUG@"
	db 1,0
	dw 70
	TX_FAR _WeedleDexEntry
	db "@"

KakunaDexEntry:
	db "COCOON@"
	db 2,0
	dw 220
	TX_FAR _KakunaDexEntry
	db "@"

BeedrillDexEntry:
	db "POISON BEE@"
	db 3,3
	dw 650
	TX_FAR _BeedrillDexEntry
	db "@"

DodrioDexEntry:
	db "TRIPLEBIRD@"
	db 5,11
	dw 1880
	TX_FAR _DodrioDexEntry
	db "@"

PrimeapeDexEntry:
	db "PIG MONKEY@"
	db 3,3
	dw 710
	TX_FAR _PrimeapeDexEntry
	db "@"

DugtrioDexEntry:
	db "MOLE@"
	db 2,4
	dw 730
	TX_FAR _DugtrioDexEntry
	db "@"

VenomothDexEntry:
	db "POISONMOTH@"
	db 4,11
	dw 280
	TX_FAR _VenomothDexEntry
	db "@"

DewgongDexEntry:
	db "SEA LION@"
	db 5,7
	dw 2650
	TX_FAR _DewgongDexEntry
	db "@"

CaterpieDexEntry:
	db "WORM@"
	db 1,0
	dw 60
	TX_FAR _CaterpieDexEntry
	db "@"

MetapodDexEntry:
	db "COCOON@"
	db 2,4
	dw 220
	TX_FAR _MetapodDexEntry
	db "@"

ButterfreeDexEntry:
	db "BUTTERFLY@"
	db 3,7
	dw 710
	TX_FAR _ButterfreeDexEntry
	db "@"

MachampDexEntry:
	db "SUPERPOWER@"
	db 5,3
	dw 2870
	TX_FAR _MachampDexEntry
	db "@"

GolduckDexEntry:
	db "DUCK@"
	db 5,7
	dw 1690
	TX_FAR _GolduckDexEntry
	db "@"

HypnoDexEntry:
	db "HYPNOSIS@"
	db 5,3
	dw 1670
	TX_FAR _HypnoDexEntry
	db "@"

GolbatDexEntry:
	db "BAT@"
	db 5,3
	dw 1210
	TX_FAR _GolbatDexEntry
	db "@"

MewtwoDexEntry:
	db "GENETIC@"
	db 6,7
	dw 2690
	TX_FAR _MewtwoDexEntry
	db "@"

SnorlaxDexEntry:
	db "SLEEPING@"
	db 6,11
	dw 10140
	TX_FAR _SnorlaxDexEntry
	db "@"

MagikarpDexEntry:
	db "FISH@"
	db 2,11
	dw 220
	TX_FAR _MagikarpDexEntry
	db "@"

MukDexEntry:
	db "SLUDGE@"
	db 3,11
	dw 660
	TX_FAR _MukDexEntry
	db "@"

KinglerDexEntry:
	db "PINCER@"
	db 4,3
	dw 1320
	TX_FAR _KinglerDexEntry
	db "@"

CloysterDexEntry:
	db "BIVALVE@"
	db 4,11
	dw 2920
	TX_FAR _CloysterDexEntry
	db "@"

ElectrodeDexEntry:
	db "BALL@"
	db 3,11
	dw 1470
	TX_FAR _ElectrodeDexEntry
	db "@"

ClefableDexEntry:
	db "FAIRY@"
	db 4,3
	dw 880
	TX_FAR _ClefableDexEntry
	db "@"

WeezingDexEntry:
	db "POISON GAS@"
	db 3,11
	dw 210
	TX_FAR _WeezingDexEntry
	db "@"

PersianDexEntry:
	db "CLASSY CAT@"
	db 3,3
	dw 710
	TX_FAR _PersianDexEntry
	db "@"

MarowakDexEntry:
	db "BONEKEEPER@"
	db 3,3
	dw 990
	TX_FAR _MarowakDexEntry
	db "@"

HaunterDexEntry:
	db "GAS@"
	db 5,3
	dw 2
	TX_FAR _HaunterDexEntry
	db "@"

AbraDexEntry:
	db "PSI@"
	db 2,11
	dw 430
	TX_FAR _AbraDexEntry
	db "@"

AlakazamDexEntry:
	db "PSI@"
	db 4,11
	dw 1060
	TX_FAR _AlakazamDexEntry
	db "@"

PidgeottoDexEntry:
	db "BIRD@"
	db 3,7
	dw 660
	TX_FAR _PidgeottoDexEntry
	db "@"

PidgeotDexEntry:
	db "BIRD@"
	db 4,11
	dw 870
	TX_FAR _PidgeotDexEntry
	db "@"

StarmieDexEntry:
	db "MYSTERIOUS@"
	db 3,7
	dw 1760
	TX_FAR _StarmieDexEntry
	db "@"

BulbasaurDexEntry:
	db "SEED@"
	db 2,4
	dw 150
	TX_FAR _BulbasaurDexEntry
	db "@"

VenusaurDexEntry:
	db "SEED@"
	db 6,7
	dw 2210
	TX_FAR _VenusaurDexEntry
	db "@"

TentacruelDexEntry:
	db "JELLYFISH@"
	db 5,3
	dw 1210
	TX_FAR _TentacruelDexEntry
	db "@"

GoldeenDexEntry:
	db "GOLDFISH@"
	db 2,0
	dw 330
	TX_FAR _GoldeenDexEntry
	db "@"

SeakingDexEntry:
	db "GOLDFISH@"
	db 4,3
	dw 860
	TX_FAR _SeakingDexEntry
	db "@"

PonytaDexEntry:
	db "FIRE HORSE@"
	db 3,3
	dw 660
	TX_FAR _PonytaDexEntry
	db "@"

RapidashDexEntry:
	db "FIRE HORSE@"
	db 5,7
	dw 2090
	TX_FAR _RapidashDexEntry
	db "@"

RattataDexEntry:
	db "RAT@"
	db 1,0
	dw 80
	TX_FAR _RattataDexEntry
	db "@"

RaticateDexEntry:
	db "RAT@"
	db 2,4
	dw 410
	TX_FAR _RaticateDexEntry
	db "@"

NidorinoDexEntry:
	db "POISON PIN@"
	db 2,11
	dw 430
	TX_FAR _NidorinoDexEntry
	db "@"

NidorinaDexEntry:
	db "POISON PIN@"
	db 2,7
	dw 440
	TX_FAR _NidorinaDexEntry
	db "@"

GeodudeDexEntry:
	db "ROCK@"
	db 1,4
	dw 440
	TX_FAR _GeodudeDexEntry
	db "@"

PorygonDexEntry:
	db "VIRTUAL@"
	db 2,7
	dw 800
	TX_FAR _PorygonDexEntry
	db "@"

AerodactylDexEntry:
	db "FOSSIL@"
	db 5,11
	dw 1300
	TX_FAR _AerodactylDexEntry
	db "@"

MagnemiteDexEntry:
	db "MAGNET@"
	db 1,0
	dw 130
	TX_FAR _MagnemiteDexEntry
	db "@"

CharmanderDexEntry:
	db "LIZARD@"
	db 2,0
	dw 190
	TX_FAR _CharmanderDexEntry
	db "@"

SquirtleDexEntry:
	db "TINYTURTLE@"
	db 1,8
	dw 200
	TX_FAR _SquirtleDexEntry
	db "@"

CharmeleonDexEntry:
	db "FLAME@"
	db 3,7
	dw 420
	TX_FAR _CharmeleonDexEntry
	db "@"

WartortleDexEntry:
	db "TURTLE@"
	db 3,3
	dw 500
	TX_FAR _WartortleDexEntry
	db "@"

CharizardDexEntry:
	db "FLAME@"
	db 5,7
	dw 2000
	TX_FAR _CharizardDexEntry
	db "@"

OddishDexEntry:
	db "WEED@"
	db 1,8
	dw 120
	TX_FAR _OddishDexEntry
	db "@"

GloomDexEntry:
	db "WEED@"
	db 2,7
	dw 190
	TX_FAR _GloomDexEntry
	db "@"

VileplumeDexEntry:
	db "FLOWER@"
	db 3,11
	dw 410
	TX_FAR _VileplumeDexEntry
	db "@"

BellsproutDexEntry:
	db "FLOWER@"
	db 2,4
	dw 90
	TX_FAR _BellsproutDexEntry
	db "@"

WeepinbellDexEntry:
	db "FLYCATCHER@"
	db 3,3
	dw 140
	TX_FAR _WeepinbellDexEntry
	db "@"

VictreebelDexEntry:
	db "FLYCATCHER@"
	db 5,7
	dw 340
	TX_FAR _VictreebelDexEntry
	db "@"

MissingNoDexEntry:
	db "???@"
	db 10 ; 1.0 m
	db 100 ; 10.0 kg
	db 0,"コメント さくせいちゅう@" ; コメント作成中 (Comment to be written)

PokedexToIndex:
	; converts the Pokédex number at $D11E to an index
	push bc
	push hl
	ld a,[$D11E]
	ld b,a
	ld c,0
	ld hl,PokedexOrder

.loop\@ ; go through the list until we find an entry with a matching dex number
	inc c
	ld a,[hli]
	cp b
	jr nz,.loop\@

	ld a,c
	ld [$D11E],a
	pop hl
	pop bc
	ret

IndexToPokedex:
	; converts the indexédex number at $D11E to a Pokédex number
	push bc
	push hl
	ld a,[$D11E]
	dec a
	ld hl,PokedexOrder
	ld b,0
	ld c,a
	add hl,bc
	ld a,[hl]
	ld [$D11E],a
	pop hl
	pop bc
	ret

PokedexOrder: ; 5024
	db DEX_RHYDON
	db DEX_KANGASKHAN
	db DEX_NIDORAN_M
	db DEX_CLEFAIRY
	db DEX_SPEAROW
	db DEX_VOLTORB
	db DEX_NIDOKING
	db DEX_SLOWBRO
	db DEX_IVYSAUR
	db DEX_EXEGGUTOR
	db DEX_LICKITUNG
	db DEX_EXEGGCUTE
	db DEX_GRIMER
	db DEX_GENGAR
	db DEX_NIDORAN_F
	db DEX_NIDOQUEEN
	db DEX_CUBONE
	db DEX_RHYHORN
	db DEX_LAPRAS
	db DEX_ARCANINE
	db DEX_MEW
	db DEX_GYARADOS
	db DEX_SHELLDER
	db DEX_TENTACOOL
	db DEX_GASTLY
	db DEX_SCYTHER
	db DEX_STARYU
	db DEX_BLASTOISE
	db DEX_PINSIR
	db DEX_TANGELA
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_GROWLITHE
	db DEX_ONIX
	db DEX_FEAROW
	db DEX_PIDGEY
	db DEX_SLOWPOKE
	db DEX_KADABRA
	db DEX_GRAVELER
	db DEX_CHANSEY
	db DEX_MACHOKE
	db DEX_MR_MIME
	db DEX_HITMONLEE
	db DEX_HITMONCHAN
	db DEX_ARBOK
	db DEX_PARASECT
	db DEX_PSYDUCK
	db DEX_DROWZEE
	db DEX_GOLEM
	db 0 ; MISSINGNO.
	db DEX_MAGMAR
	db 0 ; MISSINGNO.
	db DEX_ELECTABUZZ
	db DEX_MAGNETON
	db DEX_KOFFING
	db 0 ; MISSINGNO.
	db DEX_MANKEY
	db DEX_SEEL
	db DEX_DIGLETT
	db DEX_TAUROS
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_FARFETCH_D
	db DEX_VENONAT
	db DEX_DRAGONITE
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_DODUO
	db DEX_POLIWAG
	db DEX_JYNX
	db DEX_MOLTRES
	db DEX_ARTICUNO
	db DEX_ZAPDOS
	db DEX_DITTO
	db DEX_MEOWTH
	db DEX_KRABBY
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_VULPIX
	db DEX_NINETALES
	db DEX_PIKACHU
	db DEX_RAICHU
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_DRATINI
	db DEX_DRAGONAIR
	db DEX_KABUTO
	db DEX_KABUTOPS
	db DEX_HORSEA
	db DEX_SEADRA
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_SANDSHREW
	db DEX_SANDSLASH
	db DEX_OMANYTE
	db DEX_OMASTAR
	db DEX_JIGGLYPUFF
	db DEX_WIGGLYTUFF
	db DEX_EEVEE
	db DEX_FLAREON
	db DEX_JOLTEON
	db DEX_VAPOREON
	db DEX_MACHOP
	db DEX_ZUBAT
	db DEX_EKANS
	db DEX_PARAS
	db DEX_POLIWHIRL
	db DEX_POLIWRATH
	db DEX_WEEDLE
	db DEX_KAKUNA
	db DEX_BEEDRILL
	db 0 ; MISSINGNO.
	db DEX_DODRIO
	db DEX_PRIMEAPE
	db DEX_DUGTRIO
	db DEX_VENOMOTH
	db DEX_DEWGONG
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_CATERPIE
	db DEX_METAPOD
	db DEX_BUTTERFREE
	db DEX_MACHAMP
	db 0 ; MISSINGNO.
	db DEX_GOLDUCK
	db DEX_HYPNO
	db DEX_GOLBAT
	db DEX_MEWTWO
	db DEX_SNORLAX
	db DEX_MAGIKARP
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_MUK
	db 0 ; MISSINGNO.
	db DEX_KINGLER
	db DEX_CLOYSTER
	db 0 ; MISSINGNO.
	db DEX_ELECTRODE
	db DEX_CLEFABLE
	db DEX_WEEZING
	db DEX_PERSIAN
	db DEX_MAROWAK
	db 0 ; MISSINGNO.
	db DEX_HAUNTER
	db DEX_ABRA
	db DEX_ALAKAZAM
	db DEX_PIDGEOTTO
	db DEX_PIDGEOT
	db DEX_STARMIE
	db DEX_BULBASAUR
	db DEX_VENUSAUR
	db DEX_TENTACRUEL
	db 0 ; MISSINGNO.
	db DEX_GOLDEEN
	db DEX_SEAKING
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_PONYTA
	db DEX_RAPIDASH
	db DEX_RATTATA
	db DEX_RATICATE
	db DEX_NIDORINO
	db DEX_NIDORINA
	db DEX_GEODUDE
	db DEX_PORYGON
	db DEX_AERODACTYL
	db 0 ; MISSINGNO.
	db DEX_MAGNEMITE
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_CHARMANDER
	db DEX_SQUIRTLE
	db DEX_CHARMELEON
	db DEX_WARTORTLE
	db DEX_CHARIZARD
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db 0 ; MISSINGNO.
	db DEX_ODDISH
	db DEX_GLOOM
	db DEX_VILEPLUME
	db DEX_BELLSPROUT
	db DEX_WEEPINBELL
	db DEX_VICTREEBEL

INCBIN "baserom.gbc",$410e2,$4160c - $410e2

UnnamedText_4160c: ; 0x4160c
    TX_FAR _UnnamedText_4160c
    db $50
; 0x4160c + 5 bytes

INCBIN "baserom.gbc",$41611,$41623 - $41611

UnnamedText_41623: ; 0x41623
    TX_FAR _UnnamedText_41623
    db $50
; 0x41623 + 5 bytes

UnnamedText_41628: ; 0x41628
    TX_FAR _UnnamedText_41628
    db $50
; 0x41628 + 5 bytes

INCBIN "baserom.gbc",$4162d,$41642 - $4162d

UnnamedText_41642: ; 0x41642
    TX_FAR _UnnamedText_41642
    db $50
; 0x41642 + 5 bytes

UnnamedText_41647: ; 0x41647
    TX_FAR _UnnamedText_41647
    db $50
; 0x41647 + 5 bytes

INCBIN "baserom.gbc",$4164c,$41655 - $4164c

UnnamedText_41655: ; 0x41655
    TX_FAR _UnnamedText_41655
    db $50
; 0x41655 + 5 bytes

INCBIN "baserom.gbc",$4165a,$4166c - $4165a

UnnamedText_4166c: ; 0x4166c
    TX_FAR _UnnamedText_4166c
    db $50
; 0x4166c + 5 bytes

UnnamedText_41671: ; 0x41671
    TX_FAR _UnnamedText_41671
    db $50
; 0x41671 + 5 bytes

INCBIN "baserom.gbc",$41676,$a63

IF _RED
	INCBIN "gfx/red/introfight.2bpp"
ENDC
IF _BLUE
	INCBIN "gfx/blue/introfight.2bpp"
ENDC

; XXX what do these do
	FuncCoord 5,0
	ld hl,Coord
	ld de,OTString67E5
	call PlaceString
	ld a,[$CD3D]
	ld [$D11E],a
	ld a,$3A
	call Predef
	ld hl,$C3A9
	ld de,$D11E
	ld bc,$8103
	call $3C5F
	FuncCoord 5,2
	ld hl,Coord
	ld de,$CF4B
	call PlaceString
	FuncCoord 8,4
	ld hl,Coord
	ld de,$CD41
	call PlaceString
	ld hl,$C420
	ld de,$CD4C
	ld bc,$8205
	jp $3C5F

	FuncCoord 5,10
	ld hl,Coord
	ld de,OTString67E5
	call PlaceString
	ld a,[$CD3E]
	ld [$D11E],a
	ld a,$3A
	call Predef
	ld hl,$C471
	ld de,$D11E
	ld bc,$8103
	call $3C5F
	FuncCoord 5,12
	ld hl,Coord
	ld de,$CD6D
	call PlaceString
	FuncCoord 8,14
	ld hl,Coord
	ld de,$CD4E
	call PlaceString
	ld hl,$C4E8
	ld de,$CD59
	ld bc,$8205
	jp $3C5F

OTString67E5: ; 67E5
	db "──",$74,$F2,$4E
	db $4E
	db "OT/",$4E
	db $73,"№",$F2,"@"

SECTION "bank11",DATA,BANK[$11]

LavenderTown_h: ; 0x44000 to 0x4402d (45 bytes) (bank=11) (id=4)
    db $00 ; tileset
    db LAVENDER_TOWN_HEIGHT, LAVENDER_TOWN_WIDTH ; dimensions (y, x)
    dw LavenderTownBlocks, LavenderTownTexts, LavenderTownScript ; blocks, texts, scripts
    db NORTH | SOUTH | WEST ; connections

    ; connections data

	db ROUTE_10
    dw Route10Blocks + (ROUTE_10_HEIGHT - 3) * ROUTE_10_WIDTH ; connection strip location
    dw $C6EB + 0 ; current map position
    db ROUTE_10_WIDTH, ROUTE_10_WIDTH ; bigness, width
    db (ROUTE_10_HEIGHT * 2) - 1, (0 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_10_HEIGHT * (ROUTE_10_WIDTH + 6) ; window

	db ROUTE_12
    dw Route12Blocks ; connection strip location
    dw $C6EB + (LAVENDER_TOWN_HEIGHT + 3) * (LAVENDER_TOWN_WIDTH + 6) + 0 ; current map position
    db ROUTE_12_WIDTH, ROUTE_12_WIDTH ; bigness, width
    db 0, (0 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_12_WIDTH ; window

	db ROUTE_8
    dw Route8Blocks - 3 + (ROUTE_8_WIDTH) ; connection strip location
    dw $C6E8 + (LAVENDER_TOWN_WIDTH + 6) * (0 + 3) ; current map position
    db ROUTE_8_HEIGHT, ROUTE_8_WIDTH ; bigness, width
    db (0 * -2), (ROUTE_8_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_8_WIDTH ; window

    ; end connections data

    dw LavenderTownObject ; objects

LavenderTownObject: ; 0x4402d (size=88)
    db $2c ; border tile

    db $6 ; warps
    db $5, $3, $0, LAVENDER_POKECENTER
    db $5, $e, $0, POKEMONTOWER_1
    db $9, $7, $0, LAVENDER_HOUSE_1
    db $d, $f, $0, LAVENDER_MART
    db $d, $3, $0, LAVENDER_HOUSE_2
    db $d, $7, $0, NAME_RATERS_HOUSE

    db $6 ; signs
    db $9, $b, $4 ; LavenderTownText4
    db $3, $9, $5 ; LavenderTownText5
    db $d, $10, $6 ; LavenderTownText6
    db $5, $4, $7 ; LavenderTownText7
    db $9, $5, $8 ; LavenderTownText8
    db $7, $11, $9 ; LavenderTownText9

    db $3 ; people
    db SPRITE_LITTLE_GIRL, $9 + 4, $f + 4, $fe, $0, $1 ; person
    db SPRITE_BLACK_HAIR_BOY_1, $a + 4, $9 + 4, $ff, $ff, $2 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $7 + 4, $8 + 4, $fe, $2, $3 ; person

    ; warp-to
    EVENT_DISP $a, $5, $3 ; LAVENDER_POKECENTER
    EVENT_DISP $a, $5, $e ; POKEMONTOWER_1
    EVENT_DISP $a, $9, $7 ; LAVENDER_HOUSE_1
    EVENT_DISP $a, $d, $f ; LAVENDER_MART
    EVENT_DISP $a, $d, $3 ; LAVENDER_HOUSE_2
    EVENT_DISP $a, $d, $7 ; NAME_RATERS_HOUSE

LavenderTownBlocks: ; 90
    INCBIN "maps/lavendertown.blk"

ViridianPokecenterBlocks: ; 28
    INCBIN "maps/viridianpokecenter.blk"

SafariZoneRestHouse1Blocks: ; 16
    INCBIN "maps/safarizoneresthouse1.blk"

LavenderTownScript: ; 0x4410b
    jp $3c3c
; 0x4410e

LavenderTownTexts: ; 0x4410e
    dw LavenderTownText1, LavenderTownText2, LavenderTownText3, LavenderTownText4, LavenderTownText5, LavenderTownText6, LavenderTownText7, LavenderTownText8, LavenderTownText9

LavenderTownText1: ; 0x44120
    db $08 ; asm
    ld hl, $413c
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    ld hl, $4146
    jr nz, .asm_40831 ; 0x44131
    ld hl, $4141
.asm_40831 ; 0x44136
    call PrintText
    jp $24d7

UnnamedText_4413c: ; 0x4413c
    TX_FAR _UnnamedText_4413c
    db $50
; 0x4413c + 5 bytes

UnnamedText_44141: ; 0x44141
    TX_FAR _UnnamedText_44141
    db $50
; 0x44141 + 5 bytes

UnnamedText_44146: ; 0x44146
    TX_FAR _UnnamedText_44146
    db $50
; 0x44146 + 5 bytes

LavenderTownText2: ; 0x4414b
    TX_FAR _LavenderTownText2
    db $50

LavenderTownText3: ; 0x44150
    TX_FAR _LavenderTownText3
    db $50

LavenderTownText4: ; 0x44155
    TX_FAR _LavenderTownText4
    db $50

LavenderTownText5: ; 0x4415a
    TX_FAR _LavenderTownText5
    db $50

LavenderTownText8: ; 0x4415f
    TX_FAR _LavenderTownText8
    db $50

LavenderTownText9: ; 0x44164
    TX_FAR _LavenderTownText9
    db $50

INCBIN "baserom.gbc",$44169,$441cc - $44169

UnnamedText_441cc: ; 0x441cc
    TX_FAR _UnnamedText_441cc
    db $50
; 0x441cc + 5 bytes

INCBIN "baserom.gbc",$441d1,$44201 - $441d1

UnnamedText_44201: ; 0x44201
    TX_FAR _UnnamedText_44201
    db $50
; 0x44201 + 5 bytes

UnnamedText_44206: ; 0x44206
    TX_FAR _UnnamedText_44206
    db $50
; 0x44206 + 5 bytes

UnnamedText_4420b: ; 0x4420b
    TX_FAR _UnnamedText_4420b
    db $50
; 0x4420b + 5 bytes

UnnamedText_44210: ; 0x44210
    TX_FAR _UnnamedText_44210
    db $50
; 0x44210 + 5 bytes

UnnamedText_44215: ; 0x44215
    TX_FAR _UnnamedText_44215
    db $50
; 0x44215 + 5 bytes

UnnamedText_4421a: ; 0x4421a
    TX_FAR _UnnamedText_4421a
    db $50
; 0x4421a + 5 bytes

UnnamedText_4421f: ; 0x4421f
    TX_FAR _UnnamedText_4421f
    db $50
; 0x4421f + 5 bytes

UnnamedText_44224: ; 0x44224
    TX_FAR _UnnamedText_44224
    db $50
; 0x44224 + 5 bytes

UnnamedText_44229: ; 0x44229
    TX_FAR _UnnamedText_44229
    db $50
; 0x44229 + 5 bytes

UnnamedText_4422e: ; 0x4422e
    TX_FAR _UnnamedText_4422e
    db $50
; 0x4422e + 5 bytes

UnnamedText_44233: ; 0x44233
    TX_FAR _UnnamedText_44233
    db $50
; 0x44233 + 5 bytes

UnnamedText_44238: ; 0x44238
    TX_FAR _UnnamedText_44238
    db $50
; 0x44238 + 5 bytes

UnnamedText_4423d: ; 0x4423d
    TX_FAR _UnnamedText_4423d
    db $50
; 0x4423d + 5 bytes

UnnamedText_44242: ; 0x44242
    TX_FAR _UnnamedText_44242
    db $50
; 0x44242 + 5 bytes

UnnamedText_44247: ; 0x44247
    TX_FAR _UnnamedText_44247
    db $50
; 0x44247 + 5 bytes

UnnamedText_4424c: ; 0x4424c
    TX_FAR _UnnamedText_4424c
    db $50
; 0x4424c + 5 bytes

ViridianPokecenter_h: ; 0x44251 to 0x4425d (12 bytes) (bank=11) (id=41)
    db $06 ; tileset
    db $04, $07 ; dimensions (y, x)
    dw ViridianPokecenterBlocks, ViridianPokecenterTexts, ViridianPokeCenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw ViridianPokecenterObject ; objects

ViridianPokeCenterScript: ; 0x4425d
    call $22fa
    jp $3c3c
; 0x44263

ViridianPokecenterTexts: ; 0x44263
    dw ViridianPokeCenterText1, ViridianPokeCenterText2, ViridianPokeCenterText3, ViridianPokeCenterText4

ViridianPokeCenterText1: ; 0x4426b
    db $ff

ViridianPokeCenterText2: ; 0x4426c
    TX_FAR _ViridianPokeCenterText1
    db $50

INCBIN "baserom.gbc",$44271,$44271 - $44271

ViridianPokeCenterText3: ; 0x44271
    TX_FAR _ViridianPokeCenterText3
    db $50

ViridianPokeCenterText4:
    db $f6

ViridianPokecenterObject: ; 0x44277 (size=44)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $0, $ff
    db $7, $4, $0, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_GENTLEMAN, $5 + 4, $a + 4, $fe, $1, $2 ; person
    db SPRITE_BLACK_HAIR_BOY_1, $3 + 4, $4 + 4, $ff, $ff, $3 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

Mansion1_h: ; 0x442a3 to 0x442af (12 bytes) (bank=11) (id=165)
    db $16 ; tileset
    db MANSION_1_HEIGHT, MANSION_1_WIDTH ; dimensions (y, x)
    dw Mansion1Blocks, Mansion1Texts, Mansion1Script ; blocks, texts, scripts
    db $00 ; connections

    dw Mansion1Object ; objects

Mansion1Script:
    call Mansion1Subscript1
    call $3c3c
    ld hl, $4334
    ld de, $4326
    ld a, [$d63a]
    call $3160
    ld [$d63a], a
    ret
; 0x442c5

Mansion1Subscript1: ; 0x442c5
    ld hl, $d126
    bit 5, [hl]
    res 5, [hl]
    ret z
    ld a, [$d796]
    bit 0, a
    jr nz, .asm_442ec ; 0x442d2 $18
    ld bc, $060c
    call $430b
    ld bc, $0308
    call $4304
    ld bc, $080a
    call $4304
    ld bc, $0d0d
    jp $4304
.asm_442ec
    ld bc, $060c
    call $4304
    ld bc, $0308
    call $430b
    ld bc, $080a
    call $430b
    ld bc, $0d0d
    jp $430b
; 0x44304

INCBIN "baserom.gbc",$44304,$4432c - $44304

Mansion1Texts: ; 4432c

INCBIN "baserom.gbc",$4432c,$44341 - $4432c

Mansion1Text1: ; 0x44341
    db $08 ; asm
    ld hl, $4334
    call LoadTrainerHeader
    jp $24d7

UnnamedText_4434b: ; 0x4434b
    TX_FAR _UnnamedText_4434b
    db $50
; 0x4434b + 5 bytes

UnnamedText_44350: ; 0x44350
    TX_FAR _UnnamedText_44350
    db $50
; 0x44350 + 5 bytes

UnnamedText_44355: ; 0x44355
    TX_FAR _UnnamedText_44355
    db $50
; 0x44355 + 5 bytes

INCBIN "baserom.gbc",$4435a,$44395 - $4435a

UnnamedText_44395: ; 0x44395
    TX_FAR _UnnamedText_44395
    db $50
; 0x44395 + 5 bytes

UnnamedText_4439a: ; 0x4439a
    TX_FAR _UnnamedText_4439a
    db $50
; 0x4439a + 5 bytes

UnnamedText_4439f: ; 0x4439f
    TX_FAR _UnnamedText_4439f
    db $50
; 0x4439f + 5 bytes

Mansion1Object: ; 0x443a4 (size=90)
    db $2e ; border tile

    db $8 ; warps
    db $1b, $4, $0, $ff
    db $1b, $5, $0, $ff
    db $1b, $6, $0, $ff
    db $1b, $7, $0, $ff
    db $a, $5, $0, MANSION_2
    db $17, $15, $0, MANSION_4
    db $1b, $1a, $0, $ff
    db $1b, $1b, $0, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_OAK_AIDE, $11 + 4, $11 + 4, $ff, $d2, $41, SCIENTIST + $C8, $4 ; trainer
	db SPRITE_BALL, $3 + 4, $e + 4, $ff, $ff, $82, ESCAPE_ROPE ; item
	db SPRITE_BALL, $15 + 4, $12 + 4, $ff, $ff, $83, CARBOS ; item

    ; warp-to
    EVENT_DISP $f, $1b, $4
    EVENT_DISP $f, $1b, $5
    EVENT_DISP $f, $1b, $6
    EVENT_DISP $f, $1b, $7
    EVENT_DISP $f, $a, $5 ; MANSION_2
    EVENT_DISP $f, $17, $15 ; MANSION_4
    EVENT_DISP $f, $1b, $1a
    EVENT_DISP $f, $1b, $1b

Mansion1Blocks: ; 203
    INCBIN "maps/mansion1.blk"

RockTunnel1_h: ; 0x444d0 to 0x444dc (12 bytes) (bank=11) (id=82)
    db $11 ; tileset
    db ROCK_TUNNEL_1_HEIGHT, ROCK_TUNNEL_1_WIDTH ; dimensions (y, x)
    dw RockTunnel1Blocks, RockTunnel1Texts, RockTunnel1Script ; blocks, texts, scripts
    db $00 ; connections

    dw RockTunnel1Object ; objects

RockTunnel1Script: ; 0x444dc
    call $3c3c
    ld hl, $4505
    ld de, $44ef
    ld a, [$d621]
    call $3160
    ld [$d621], a
    ret
; 0x444ef

INCBIN "baserom.gbc",$444ef,$6

RockTunnel1Texts: ; 0x444f5
    dw RockTunnel1Text1, RockTunnel1Text2, RockTunnel1Text3, RockTunnel1Text4, RockTunnel1Text5, RockTunnel1Text6, RockTunnel1Text7, RockTunnel1Text8

INCBIN "baserom.gbc",$44505,$55

RockTunnel1Text1: ; 0x4455a
    db $8
    ld hl, $4505
    jr asm_0c916 ; 0x4455e $22

RockTunnel1Text2:
    db $8
    ld hl, $4511
    jr asm_0c916 ; 0x44564 $1c

RockTunnel1Text3:
    db $8
    ld hl, $451d
    jr asm_0c916 ; 0x4456a $16

RockTunnel1Text4:
    db $8
    ld hl, $4529
    jr asm_0c916 ; 0x44570 $10

RockTunnel1Text5:
    db $8
    ld hl, $4535
    jr asm_0c916 ; 0x44576 $a

RockTunnel1Text6:
    db $8
    ld hl, $4541
    jr asm_0c916 ; 0x4457c $4

RockTunnel1Text7:
    db $8
    ld hl, $454d
asm_0c916: ; 0x44582
    call $31cc
    jp $24d7

UnnamedText_44588: ; 0x44588
    TX_FAR _UnnamedText_44588
    db $50
; 0x44588 + 5 bytes

UnnamedText_4458d: ; 0x4458d
    TX_FAR _UnnamedText_4458d
    db $50
; 0x4458d + 5 bytes

UnnamedText_44592: ; 0x44592
    TX_FAR _UnnamedText_44592
    db $50
; 0x44592 + 5 bytes

UnnamedText_44597: ; 0x44597
    TX_FAR _UnnamedText_44597
    db $50
; 0x44597 + 5 bytes

UnnamedText_4459c: ; 0x4459c
    TX_FAR _UnnamedText_4459c
    db $50
; 0x4459c + 5 bytes

UnnamedText_445a1: ; 0x445a1
    TX_FAR _UnnamedText_445a1
    db $50
; 0x445a1 + 5 bytes

UnnamedText_445a6: ; 0x445a6
    TX_FAR _UnnamedText_445a6
    db $50
; 0x445a6 + 5 bytes

UnnamedText_445ab: ; 0x445ab
    TX_FAR _UnnamedText_445ab
    db $50
; 0x445ab + 5 bytes

UnnamedText_445b0: ; 0x445b0
    TX_FAR _UnnamedText_445b0
    db $50
; 0x445b0 + 5 bytes

UnnamedText_445b5: ; 0x445b5
    TX_FAR _UnnamedText_445b5
    db $50
; 0x445b5 + 5 bytes

UnnamedText_445ba: ; 0x445ba
    TX_FAR _UnnamedText_445ba
    db $50
; 0x445ba + 5 bytes

UnnamedText_445bf: ; 0x445bf
    TX_FAR _UnnamedText_445bf
    db $50
; 0x445bf + 5 bytes

UnnamedText_445c4: ; 0x445c4
    TX_FAR _UnnamedText_445c4
    db $50
; 0x445c4 + 5 bytes

UnnamedText_445c9: ; 0x445c9
    TX_FAR _UnnamedText_445c9
    db $50
; 0x445c9 + 5 bytes

UnnamedText_445ce: ; 0x445ce
    TX_FAR _UnnamedText_445ce
    db $50
; 0x445ce + 5 bytes

UnnamedText_445d3: ; 0x445d3
    TX_FAR _UnnamedText_445d3
    db $50
; 0x445d3 + 5 bytes

UnnamedText_445d8: ; 0x445d8
    TX_FAR _UnnamedText_445d8
    db $50
; 0x445d8 + 5 bytes

UnnamedText_445dd: ; 0x445dd
    TX_FAR _UnnamedText_445dd
    db $50
; 0x445dd + 5 bytes

UnnamedText_445e2: ; 0x445e2
    TX_FAR _UnnamedText_445e2
    db $50
; 0x445e2 + 5 bytes

UnnamedText_445e7: ; 0x445e7
    TX_FAR _UnnamedText_445e7
    db $50
; 0x445e7 + 5 bytes

UnnamedText_445ec: ; 0x445ec
    TX_FAR _UnnamedText_445ec
    db $50
; 0x445ec + 5 bytes

RockTunnel1Text8: ; 0x445f1
    TX_FAR _RockTunnel1Text8
    db $50

RockTunnel1Object: ; 0x445f6 (size=127)
    db $3 ; border tile

    db $8 ; warps
    db $3, $f, $1, $ff
    db $0, $f, $1, $ff
    db $21, $f, $2, $ff
    db $23, $f, $2, $ff
    db $3, $25, $0, ROCK_TUNNEL_2
    db $3, $5, $1, ROCK_TUNNEL_2
    db $b, $11, $2, ROCK_TUNNEL_2
    db $11, $25, $3, ROCK_TUNNEL_2

    db $1 ; signs
    db $1d, $b, $8 ; RockTunnel1Text8

    db $7 ; people
    db SPRITE_HIKER, $5 + 4, $7 + 4, $ff, $d0, $41, HIKER + $C8, $c ; trainer
    db SPRITE_HIKER, $10 + 4, $5 + 4, $ff, $d0, $42, HIKER + $C8, $d ; trainer
    db SPRITE_HIKER, $f + 4, $11 + 4, $ff, $d2, $43, HIKER + $C8, $e ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $8 + 4, $17 + 4, $ff, $d2, $44, POKEMANIAC + $C8, $7 ; trainer
    db SPRITE_LASS, $15 + 4, $25 + 4, $ff, $d2, $45, JR__TRAINER_F + $C8, $11 ; trainer
    db SPRITE_LASS, $18 + 4, $16 + 4, $ff, $d0, $46, JR__TRAINER_F + $C8, $12 ; trainer
    db SPRITE_LASS, $18 + 4, $20 + 4, $ff, $d3, $47, JR__TRAINER_F + $C8, $13 ; trainer

    ; warp-to
    EVENT_DISP $14, $3, $f
    EVENT_DISP $14, $0, $f
    EVENT_DISP $14, $21, $f
    EVENT_DISP $14, $23, $f
    EVENT_DISP $14, $3, $25 ; ROCK_TUNNEL_2
    EVENT_DISP $14, $3, $5 ; ROCK_TUNNEL_2
    EVENT_DISP $14, $b, $11 ; ROCK_TUNNEL_2
    EVENT_DISP $14, $11, $25 ; ROCK_TUNNEL_2

RockTunnel1Blocks: ; 360
    INCBIN "maps/rocktunnel1.blk"

SeafoamIslands1_h: ; 0x447dd to 0x447e9 (12 bytes) (bank=11) (id=192)
    db $11 ; tileset
    db SEAFOAM_ISLANDS_1_HEIGHT, SEAFOAM_ISLANDS_1_WIDTH ; dimensions (y, x)
    dw SeafoamIslands1Blocks, SeafoamIslands1Texts, SeafoamIslands1Script ; blocks, texts, scripts
    db $00 ; connections

    dw SeafoamIslands1Object ; objects

SeafoamIslands1Script: ; 0x447e9
    call $3c3c
    ld hl, $d7e7
    set 0, [hl]
    ld hl, $cd60
    bit 7, [hl]
    res 7, [hl]
    jr z, .asm_4483b ; 0x447f8 $41
    ld hl, $4846
    call $34e4
    ret nc
    ld hl, $d7e8
    ld a, [$cd3d]
    cp $1
    jr nz, .asm_44819 ; 0x44809 $e
    set 6, [hl]
    ld a, $d7
    ld [$d079], a
    ld a, $d9
    ld [$d07a], a
    jr .asm_44825 ; 0x44817 $c
.asm_44819
    set 7, [hl]
    ld a, $d8
    ld [$d079], a
    ld a, $da
    ld [$d07a], a
.asm_44825
    ld a, [$d079]
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld a, [$d07a]
    ld [$cc4d], a
    ld a, $15
    jp $3e6d
.asm_4483b
    ld a, $9f
    ld [$d71d], a
    ld hl, $4846
    jp $6981
; 0x44846

INCBIN "baserom.gbc",$44846,$5

SeafoamIslands1Texts: ; 0x4484b
    dw SeafoamIslands1Text1, SeafoamIslands1Text2

SeafoamIslands1Object: ; 0x4484f (size=72)
    db $7d ; border tile

    db $7 ; warps
    db $11, $4, $0, $ff
    db $11, $5, $0, $ff
    db $11, $1a, $1, $ff
    db $11, $1b, $1, $ff
    db $5, $7, $1, SEAFOAM_ISLANDS_2
    db $3, $19, $6, SEAFOAM_ISLANDS_2
    db $f, $17, $4, SEAFOAM_ISLANDS_2

    db $0 ; signs

    db $2 ; people
    db SPRITE_BOULDER, $a + 4, $12 + 4, $ff, $10, $1 ; person
    db SPRITE_BOULDER, $7 + 4, $1a + 4, $ff, $10, $2 ; person

    ; warp-to
    EVENT_DISP $f, $11, $4
    EVENT_DISP $f, $11, $5
    EVENT_DISP $f, $11, $1a
    EVENT_DISP $f, $11, $1b
    EVENT_DISP $f, $5, $7 ; SEAFOAM_ISLANDS_2
    EVENT_DISP $f, $3, $19 ; SEAFOAM_ISLANDS_2
    EVENT_DISP $f, $f, $17 ; SEAFOAM_ISLANDS_2

INCBIN "baserom.gbc",$44897,$8

SeafoamIslands1Blocks: ; 135
    INCBIN "maps/seafoamislands1.blk"

SSAnne3_h: ; 0x44926 to 0x44932 (12 bytes) (bank=11) (id=97)
    db $0d ; tileset
    db SS_ANNE_3_HEIGHT, SS_ANNE_3_WIDTH ; dimensions (y, x)
    dw SSAnne3Blocks, SSAnne3Texts, SSAnne3Script ; blocks, texts, scripts
    db $00 ; connections

    dw SSAnne3Object ; objects

SSAnne3Script: ; 0x44932
    jp $3c3c
; 0x44935

SSAnne3Texts: ; 0x44935
    dw SSAnne3Text1

SSAnne3Text1: ; 0x44937
    TX_FAR _SSAnne3Text1
    db $50

SSAnne3Object: ; 0x4493c (size=26)
    db $c ; border tile

    db $2 ; warps
    db $3, $0, $0, SS_ANNE_5
    db $3, $13, $7, SS_ANNE_2

    db $0 ; signs

    db $1 ; people
    db SPRITE_SAILOR, $3 + 4, $9 + 4, $fe, $2, $1 ; person

    ; warp-to
    EVENT_DISP $a, $3, $0 ; SS_ANNE_5
    EVENT_DISP $a, $3, $13 ; SS_ANNE_2

SSAnne3Blocks: ; 30
    INCBIN "maps/ssanne3.blk"

VictoryRoad3_h: ; 0x44974 to 0x44980 (12 bytes) (bank=11) (id=198)
    db $11 ; tileset
    db VICTORY_ROAD_3_HEIGHT, VICTORY_ROAD_3_WIDTH ; dimensions (y, x)
    dw VictoryRoad3Blocks, VictoryRoad3Texts, VictoryRoad3Script ; blocks, texts, scripts
    db $00 ; connections

    dw VictoryRoad3Object ; objects

VictoryRoad3Script: ; 0x44980
    call $4996
    call $3c3c
    ld hl, $4a38
    ld de, $49b1
    ld a, [$d640]
    call $3160
    ld [$d640], a
    ret
; 0x44996

INCBIN "baserom.gbc",$44996,$8e

VictoryRoad3Texts: ; 0x44a24
    dw VictoryRoad3Text1, VictoryRoad3Text2, VictoryRoad3Text3, VictoryRoad3Text4, VictoryRoad3Text5, VictoryRoad3Text6, VictoryRoad3Text7, VictoryRoad3Text8, VictoryRoad3Text9, VictoryRoad3Text10

INCBIN "baserom.gbc",$44a38,$31

VictoryRoad3Text1: ; 0x44a69
    db $08 ; asm
    ld hl, $4a38
    call LoadTrainerHeader
    jp $24d7

VictoryRoad3Text2: ; 0x44a73
    db $08 ; asm
    ld hl, $4a44
    call LoadTrainerHeader
    jp $24d7

VictoryRoad3Text3: ; 0x44a7d
    db $08 ; asm
    ld hl, $4a50
    call LoadTrainerHeader
    jp $24d7

VictoryRoad3Text4: ; 0x44a87
    db $08 ; asm
    ld hl, $4a5c
    call LoadTrainerHeader
    jp $24d7

UnnamedText_44a91: ; 0x44a91
    TX_FAR _UnnamedText_44a91
    db $50
; 0x44a91 + 5 bytes

UnnamedText_44a96: ; 0x44a96
    TX_FAR _UnnamedText_44a96
    db $50
; 0x44a96 + 5 bytes

UnnamedText_44a9b: ; 0x44a9b
    TX_FAR _UnnamedText_44a9b
    db $50
; 0x44a9b + 5 bytes

UnnamedText_44aa0: ; 0x44aa0
    TX_FAR _UnnamedText_44aa0
    db $50
; 0x44aa0 + 5 bytes

UnnamedText_44aa5: ; 0x44aa5
    TX_FAR _UnnamedText_44aa5
    db $50
; 0x44aa5 + 5 bytes

UnnamedText_44aaa: ; 0x44aaa
    TX_FAR _UnnamedText_44aaa
    db $50
; 0x44aaa + 5 bytes

UnnamedText_44aaf: ; 0x44aaf
    TX_FAR _UnnamedText_44aaf
    db $50
; 0x44aaf + 5 bytes

UnnamedText_44ab4: ; 0x44ab4
    TX_FAR _UnnamedText_44ab4
    db $50
; 0x44ab4 + 5 bytes

UnnamedText_44ab9: ; 0x44ab9
    TX_FAR _UnnamedText_44ab9
    db $50
; 0x44ab9 + 5 bytes

UnnamedText_44abe: ; 0x44abe
    TX_FAR _UnnamedText_44abe
    db $50
; 0x44abe + 5 bytes

UnnamedText_44ac3: ; 0x44ac3
    TX_FAR _UnnamedText_44ac3
    db $50
; 0x44ac3 + 5 bytes

UnnamedText_44ac8: ; 0x44ac8
    TX_FAR _UnnamedText_44ac8
    db $50
; 0x44ac8 + 5 bytes

VictoryRoad3Object: ; 0x44acd (size=106)
    db $7d ; border tile

    db $4 ; warps
    db $7, $17, $3, VICTORY_ROAD_2
    db $8, $1a, $5, VICTORY_ROAD_2
    db $f, $1b, $4, VICTORY_ROAD_2
    db $0, $2, $6, VICTORY_ROAD_2

    db $0 ; signs

    db $a ; people
    db SPRITE_BLACK_HAIR_BOY_1, $5 + 4, $1c + 4, $ff, $d2, $41, COOLTRAINER_M + $C8, $2 ; trainer
    db SPRITE_LASS, $d + 4, $7 + 4, $ff, $d3, $42, COOLTRAINER_F + $C8, $2 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $e + 4, $6 + 4, $ff, $d2, $43, COOLTRAINER_M + $C8, $3 ; trainer
    db SPRITE_LASS, $3 + 4, $d + 4, $ff, $d3, $44, COOLTRAINER_F + $C8, $3 ; trainer
	db SPRITE_BALL, $5 + 4, $1a + 4, $ff, $ff, $85, MAX_REVIVE ; item
	db SPRITE_BALL, $7 + 4, $7 + 4, $ff, $ff, $86, TM_47 ; item
    db SPRITE_BOULDER, $3 + 4, $16 + 4, $ff, $10, $7 ; person
    db SPRITE_BOULDER, $c + 4, $d + 4, $ff, $10, $8 ; person
    db SPRITE_BOULDER, $a + 4, $18 + 4, $ff, $10, $9 ; person
    db SPRITE_BOULDER, $f + 4, $16 + 4, $ff, $10, $a ; person

    ; warp-to
    EVENT_DISP $f, $7, $17 ; VICTORY_ROAD_2
    EVENT_DISP $f, $8, $1a ; VICTORY_ROAD_2
    EVENT_DISP $f, $f, $1b ; VICTORY_ROAD_2
    EVENT_DISP $f, $0, $2 ; VICTORY_ROAD_2

VictoryRoad3Blocks: ; 135
    INCBIN "maps/victoryroad3.blk"

RocketHideout1_h: ; 0x44bbe to 0x44bca (12 bytes) (bank=11) (id=199)
    db $16 ; tileset
    db ROCKET_HIDEOUT_1_HEIGHT, ROCKET_HIDEOUT_1_WIDTH ; dimensions (y, x)
    dw RocketHideout1Blocks, RocketHideout1Texts, RocketHideout1Script ; blocks, texts, scripts
    db $00 ; connections

    dw RocketHideout1Object ; objects

RocketHideout1Script: ; 0x44bca
    call $4be0
    call $3c3c
    ld hl, $4c22
    ld de, $4c0e
    ld a, [$d631]
    call $3160
    ld [$d631], a
    ret
; 0x44be0

INCBIN "baserom.gbc",$44be0,$34

RocketHideout1Texts: ; 0x44c14
    dw RocketHideout1Text1, RocketHideout1Text2, RocketHideout1Text3, RocketHideout1Text4, RocketHideout1Text5, RocketHideout1Text6, RocketHideout1Text7

INCBIN "baserom.gbc",$44c22,$3d

RocketHideout1Text1: ; 0x44c5f
    db $08 ; asm
    ld hl, $4c22
    call LoadTrainerHeader
    jp $24d7

RocketHideout1Text2: ; 0x44c69
    db $08 ; asm
    ld hl, $4c2e
    call LoadTrainerHeader
    jp $24d7

RocketHideout1Text3: ; 0x44c73
    db $08 ; asm
    ld hl, $4c3a
    call LoadTrainerHeader
    jp $24d7

RocketHideout1Text4: ; 0x44c7d
    db $08 ; asm
    ld hl, $4c46
    call LoadTrainerHeader
    jp $24d7

RocketHideout1Text5: ; 0x44c87
    db $08 ; asm
    ld hl, $4c52
    call LoadTrainerHeader
    jp $24d7

INCBIN "baserom.gbc",$44c91,$44ca1 - $44c91

UnnamedText_44ca1: ; 0x44ca1
    TX_FAR _UnnamedText_44ca1
    db $50
; 0x44ca1 + 5 bytes

UnnamedText_44ca6: ; 0x44ca6
    TX_FAR _UnnamedText_44ca6
    db $50
; 0x44ca6 + 5 bytes

UnnamedText_44cab: ; 0x44cab
    TX_FAR _UnnamedText_44cab
    db $50
; 0x44cab + 5 bytes

UnnamedText_44cb0: ; 0x44cb0
    TX_FAR _UnnamedText_44cb0
    db $50
; 0x44cb0 + 5 bytes

UnnamedText_44cb5: ; 0x44cb5
    TX_FAR _UnnamedText_44cb5
    db $50
; 0x44cb5 + 5 bytes

UnnamedText_44cba: ; 0x44cba
    TX_FAR _UnnamedText_44cba
    db $50
; 0x44cba + 5 bytes

UnnamedText_44cbf: ; 0x44cbf
    TX_FAR _UnnamedText_44cbf
    db $50
; 0x44cbf + 5 bytes

UnnamedText_44cc4: ; 0x44cc4
    TX_FAR _UnnamedText_44cc4
    db $50
; 0x44cc4 + 5 bytes

UnnamedText_44cc9: ; 0x44cc9
    TX_FAR _UnnamedText_44cc9
    db $50
; 0x44cc9 + 5 bytes

UnnamedText_44cce: ; 0x44cce
    TX_FAR _UnnamedText_44cce
    db $50
; 0x44cce + 5 bytes

UnnamedText_44cd3: ; 0x44cd3
    TX_FAR _UnnamedText_44cd3
    db $50
; 0x44cd3 + 5 bytes

UnnamedText_44cd8: ; 0x44cd8
    TX_FAR _UnnamedText_44cd8
    db $50
; 0x44cd8 + 5 bytes

UnnamedText_44cdd: ; 0x44cdd
    TX_FAR _UnnamedText_44cdd
    db $50
; 0x44cdd + 5 bytes

UnnamedText_44ce2: ; 0x44ce2
    TX_FAR _UnnamedText_44ce2
    db $50
; 0x44ce2 + 5 bytes

RocketHideout1Object: ; 0x44ce7 (size=98)
    db $2e ; border tile

    db $5 ; warps
    db $2, $17, $0, ROCKET_HIDEOUT_2
    db $2, $15, $2, GAME_CORNER
    db $13, $18, $0, ROCKET_HIDEOUT_ELEVATOR
    db $18, $15, $3, ROCKET_HIDEOUT_2
    db $13, $19, $1, ROCKET_HIDEOUT_ELEVATOR

    db $0 ; signs

    db $7 ; people
    db SPRITE_ROCKET, $8 + 4, $1a + 4, $ff, $d2, $41, ROCKET + $C8, $8 ; trainer
    db SPRITE_ROCKET, $6 + 4, $c + 4, $ff, $d3, $42, ROCKET + $C8, $9 ; trainer
    db SPRITE_ROCKET, $11 + 4, $12 + 4, $ff, $d0, $43, ROCKET + $C8, $a ; trainer
    db SPRITE_ROCKET, $19 + 4, $f + 4, $ff, $d3, $44, ROCKET + $C8, $b ; trainer
    db SPRITE_ROCKET, $12 + 4, $1c + 4, $ff, $d2, $45, ROCKET + $C8, $c ; trainer
	db SPRITE_BALL, $e + 4, $b + 4, $ff, $ff, $86, ESCAPE_ROPE ; item
	db SPRITE_BALL, $11 + 4, $9 + 4, $ff, $ff, $87, HYPER_POTION ; item

    ; warp-to
    EVENT_DISP $f, $2, $17 ; ROCKET_HIDEOUT_2
    EVENT_DISP $f, $2, $15 ; GAME_CORNER
    EVENT_DISP $f, $13, $18 ; ROCKET_HIDEOUT_ELEVATOR
    EVENT_DISP $f, $18, $15 ; ROCKET_HIDEOUT_2
    EVENT_DISP $f, $13, $19 ; ROCKET_HIDEOUT_ELEVATOR

RocketHideout1Blocks: ; 210
    INCBIN "maps/rockethideout1.blk"

RocketHideout2_h: ; 0x44e1b to 0x44e27 (12 bytes) (bank=11) (id=200)
    db $16 ; tileset
    db ROCKET_HIDEOUT_2_HEIGHT, ROCKET_HIDEOUT_2_WIDTH ; dimensions (y, x)
    dw RocketHideout2Blocks, RocketHideout2Texts, RocketHideout2Script ; blocks, texts, scripts
    db $00 ; connections

    dw RocketHideout2Object ; objects

RocketHideout2Script: ; 0x44e27
    call $3c3c
    ld hl, $50d1
    ld de, $4e3a
    ld a, [$d632]
    call $3160
    ld [$d632], a
    ret
; 0x44e3a

INCBIN "baserom.gbc",$44e3a,$28d

RocketHideout2Texts: ; 0x450c7
    dw RocketHideout2Text1, RocketHideout2Text2, RocketHideout2Text3, RocketHideout2Text4, RocketHideout2Text5

INCBIN "baserom.gbc",$450d1,$d

RocketHideout2Text1: ; 0x450de
    db $08 ; asm
    ld hl, $50d1
    call LoadTrainerHeader
    jp $24d7

UnnamedText_450e8: ; 0x450e8
    TX_FAR _UnnamedText_450e8
    db $50
; 0x450e8 + 5 bytes

UnnamedText_450ed: ; 0x450ed
    TX_FAR _UnnamedText_450ed
    db $50
; 0x450ed + 5 bytes

UnnamedText_450f2: ; 0x450f2
    TX_FAR _UnnamedText_450f2
    db $50
; 0x450f2 + 5 bytes

RocketHideout2Object: ; 0x450f7 (size=80)
    db $2e ; border tile

    db $5 ; warps
    db $8, $1b, $0, ROCKET_HIDEOUT_1
    db $8, $15, $0, ROCKET_HIDEOUT_3
    db $13, $18, $0, ROCKET_HIDEOUT_ELEVATOR
    db $16, $15, $3, ROCKET_HIDEOUT_1
    db $13, $19, $1, ROCKET_HIDEOUT_ELEVATOR

    db $0 ; signs

    db $5 ; people
    db SPRITE_ROCKET, $c + 4, $14 + 4, $ff, $d0, $41, ROCKET + $C8, $d ; trainer
	db SPRITE_BALL, $b + 4, $1 + 4, $ff, $ff, $82, MOON_STONE ; item
	db SPRITE_BALL, $8 + 4, $10 + 4, $ff, $ff, $83, NUGGET ; item
	db SPRITE_BALL, $c + 4, $6 + 4, $ff, $ff, $84, TM_07 ; item
	db SPRITE_BALL, $15 + 4, $3 + 4, $ff, $ff, $85, SUPER_POTION ; item

    ; warp-to
    EVENT_DISP $f, $8, $1b ; ROCKET_HIDEOUT_1
    EVENT_DISP $f, $8, $15 ; ROCKET_HIDEOUT_3
    EVENT_DISP $f, $13, $18 ; ROCKET_HIDEOUT_ELEVATOR
    EVENT_DISP $f, $16, $15 ; ROCKET_HIDEOUT_1
    EVENT_DISP $f, $13, $19 ; ROCKET_HIDEOUT_ELEVATOR

RocketHideout2Blocks: ; 210
    INCBIN "maps/rockethideout2.blk"

RocketHideout3_h: ; 0x45219 to 0x45225 (12 bytes) (bank=11) (id=201)
    db $16 ; tileset
    db ROCKET_HIDEOUT_3_HEIGHT, ROCKET_HIDEOUT_3_WIDTH ; dimensions (y, x)
    dw RocketHideout3Blocks, RocketHideout3Texts, RocketHideout3Script ; blocks, texts, scripts
    db $00 ; connections

    dw RocketHideout3Object ; objects

RocketHideout3Script: ; 0x45225
    call $3c3c
    ld hl, $5302
    ld de, $5238
    ld a, [$d633]
    call $3160
    ld [$d633], a
    ret
; 0x45238

INCBIN "baserom.gbc",$45238,$c2

RocketHideout3Texts: ; 0x452fa
    dw RocketHideout3Text1, RocketHideout3Text2, RocketHideout3Text3, RocketHideout3Text4

INCBIN "baserom.gbc",$45302,$19

RocketHideout3Text1: ; 0x4531b
    db $08 ; asm
    ld hl, $5302
    call LoadTrainerHeader
    jp $24d7

UnnamedText_45325: ; 0x45325
    TX_FAR _UnnamedText_45325
    db $50
; 0x45325 + 5 bytes

UnnamedText_4532a: ; 0x4532a
    TX_FAR _UnnamedText_4532a
    db $50
; 0x4532a + 5 bytes

UnnamedText_4532f: ; 0x4532f
    TX_FAR _UnnamedText_4532f
    db $50
; 0x4532f + 5 bytes

RocketHideout3Text2: ; 0x45334
    db $08 ; asm
    ld hl, $530e
    call LoadTrainerHeader
    jp $24d7

UnnamedText_4533e: ; 0x4533e
    TX_FAR _UnnamedText_4533e
    db $50
; 0x4533e + 5 bytes

UnnamedText_45343: ; 0x45343
    TX_FAR _UnnamedText_45343
    db $50
; 0x45343 + 5 bytes

UnnamedText_45348: ; 0x45348
    TX_FAR _UnnamedText_45348
    db $50
; 0x45348 + 5 bytes

RocketHideout3Object: ; 0x4534d (size=50)
    db $2e ; border tile

    db $2 ; warps
    db $6, $19, $1, ROCKET_HIDEOUT_2
    db $12, $13, $0, ROCKET_HIDEOUT_4

    db $0 ; signs

    db $4 ; people
    db SPRITE_ROCKET, $16 + 4, $a + 4, $ff, $d3, $41, ROCKET + $C8, $e ; trainer
    db SPRITE_ROCKET, $c + 4, $1a + 4, $ff, $d1, $42, ROCKET + $C8, $f ; trainer
	db SPRITE_BALL, $11 + 4, $1a + 4, $ff, $ff, $83, TM_10 ; item
	db SPRITE_BALL, $e + 4, $14 + 4, $ff, $ff, $84, RARE_CANDY ; item

    ; warp-to
    EVENT_DISP $f, $6, $19 ; ROCKET_HIDEOUT_2
    EVENT_DISP $f, $12, $13 ; ROCKET_HIDEOUT_4

RocketHideout3Blocks: ; 210
    INCBIN "maps/rockethideout3.blk"

RocketHideout4_h: ; 0x45451 to 0x4545d (12 bytes) (bank=11) (id=202)
    db $16 ; tileset
    db ROCKET_HIDEOUT_4_HEIGHT, ROCKET_HIDEOUT_4_WIDTH ; dimensions (y, x)
    dw RocketHideout4Blocks, RocketHideout4Texts, RocketHideout4Script ; blocks, texts, scripts
    db $00 ; connections

    dw RocketHideout4Object ; objects

RocketHideout4Script: ; 0x4545d
    call $5473
    call $3c3c
    ld hl, $5515
    ld de, $54ae
    ld a, [$d634]
    call $3160
    ld [$d634], a
    ret
; 0x45473

INCBIN "baserom.gbc",$45473,$8e

RocketHideout4Texts: ; 0x45501
    dw RocketHideout4Text1, RocketHideout4Text2, RocketHideout4Text3, RocketHideout4Text4, RocketHideout4Text5, RocketHideout4Text6, RocketHideout4Text7, RocketHideout4Text8, RocketHideout4Text9, RocketHideout4Text10

INCBIN "baserom.gbc",$45515,$25

RocketHideout4Text1: ; 0x4553a
    db $08 ; asm
    ld a, [$d81b]
    bit 7, a
    jp nz, $5571
    ld hl, $557a
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $557f
    ld de, $557f
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    xor a
    ldh [$b4], a
    ld a, $3
    ld [$d634], a
    ld [$da39], a
    jr .asm_209f0 ; 0x4556f
    ld hl, $5584
    call PrintText
.asm_209f0 ; 0x45577
    jp $24d7

UnnamedText_4557a: ; 0x4557a
    TX_FAR _UnnamedText_4557a
    db $50
; 0x4557a + 5 bytes

UnnamedText_4557f: ; 0x4557f
    TX_FAR _UnnamedText_4557f
    db $50
; 0x4557f + 5 bytes

RocketHideout4Text10: ; 0x45584
    TX_FAR _UnnamedText_45584
    db $50
; 0x45584 + 5 bytes

RocketHideout4Text2: ; 0x45589
    db $08 ; asm
    ld hl, $5515
    call LoadTrainerHeader
    jp $24d7

UnnamedText_45593: ; 0x45593
    TX_FAR _UnnamedText_45593
    db $50
; 0x45593 + 5 bytes

UnnamedText_45598: ; 0x45598
    TX_FAR _UnnamedText_45598
    db $50
; 0x45598 + 5 bytes

UnnamedText_4559d: ; 0x4559d
    TX_FAR _UnnamedText_4559d
    db $50
; 0x4559d + 5 bytes

RocketHideout4Text3: ; 0x455a2
    db $08 ; asm
    ld hl, $5521
    call LoadTrainerHeader
    jp $24d7

UnnamedText_455ac: ; 0x455ac
    TX_FAR _UnnamedText_455ac
    db $50
; 0x455ac + 5 bytes

UnnamedText_455b1: ; 0x455b1
    TX_FAR _UnnamedText_455b1
    db $50
; 0x455b1 + 5 bytes

UnnamedText_455b6: ; 0x455b6
    TX_FAR _UnnamedText_455b6
    db $50
; 0x455b6 + 5 bytes

RocketHideout4Text4: ; 0x455bb
    db $08 ; asm
    ld hl, $552d
    call LoadTrainerHeader
    jp $24d7

UnnamedText_455c5: ; 0x455c5
    TX_FAR _UnnamedText_455c5
    db $50
; 0x455c5 + 5 bytes

UnnamedText_455ca: ; 0x455ca
    TX_FAR _UnnamedText_455ca
    db $50
; 0x455ca + 5 bytes

INCBIN "baserom.gbc",$455cf,$455ec - $455cf

UnnamedText_455ec: ; 0x455ec
    TX_FAR _UnnamedText_455ec
    db $50
; 0x455ec + 5 bytes

RocketHideout4Object: ; 0x455f1 (size=95)
    db $2e ; border tile

    db $3 ; warps
    db $a, $13, $1, ROCKET_HIDEOUT_3
    db $f, $18, $0, ROCKET_HIDEOUT_ELEVATOR
    db $f, $19, $1, ROCKET_HIDEOUT_ELEVATOR

    db $0 ; signs

    db $9 ; people
    db SPRITE_GIOVANNI, $3 + 4, $19 + 4, $ff, $d0, $41, GIOVANNI + $C8, $1 ; trainer
    db SPRITE_ROCKET, $c + 4, $17 + 4, $ff, $d0, $42, ROCKET + $C8, $10 ; trainer
    db SPRITE_ROCKET, $c + 4, $1a + 4, $ff, $d0, $43, ROCKET + $C8, $11 ; trainer
    db SPRITE_ROCKET, $2 + 4, $b + 4, $ff, $d0, $44, ROCKET + $C8, $12 ; trainer
	db SPRITE_BALL, $c + 4, $a + 4, $ff, $ff, $85, HP_UP ; item
	db SPRITE_BALL, $4 + 4, $9 + 4, $ff, $ff, $86, TM_02 ; item
	db SPRITE_BALL, $14 + 4, $c + 4, $ff, $ff, $87, IRON ; item
	db SPRITE_BALL, $2 + 4, $19 + 4, $ff, $ff, $88, SILPH_SCOPE ; item
	db SPRITE_BALL, $2 + 4, $a + 4, $ff, $ff, $89, LIFT_KEY ; item

    ; warp-to
    EVENT_DISP $f, $a, $13 ; ROCKET_HIDEOUT_3
    EVENT_DISP $f, $f, $18 ; ROCKET_HIDEOUT_ELEVATOR
    EVENT_DISP $f, $f, $19 ; ROCKET_HIDEOUT_ELEVATOR

RocketHideout4Blocks: ; 180
    INCBIN "maps/rockethideout4.blk"

RocketHideoutElevator_h: ; 0x45704 to 0x45710 (12 bytes) (bank=11) (id=203)
    db $12 ; tileset
    db ROCKET_HIDEOUT_ELEVATOR_HEIGHT, ROCKET_HIDEOUT_ELEVATOR_WIDTH ; dimensions (y, x)
    dw RocketHideoutElevatorBlocks, RocketHideoutElevatorTexts, RocketHideoutElevatorScript ; blocks, texts, scripts
    db $00 ; connections

    dw RocketHideoutElevatorObject ; objects

RocketHideoutElevatorScript: ; 0x45710
    ld hl, $d126
    bit 5, [hl]
    res 5, [hl]
    push hl
    call nz, $572c
    pop hl
    bit 7, [hl]
    res 7, [hl]
    call nz, $575f
    xor a
    ld [$cf0c], a
    inc a
    ld [$cc3c], a
    ret
; 0x4572c

INCBIN "baserom.gbc",$4572c,$3f

RocketHideoutElevatorTexts: ; 0x4576b
    dw RocketHideoutElevatorText1

RocketHideoutElevatorText1: ; 0x4576d
    db $08 ; asm
    ld b,LIFT_KEY
    call $3493
    jr z, .asm_8d8f0 ; 0x45773
    call $5741
    ld hl, $5759
    ld a, $61
    call Predef
    jr .asm_46c43 ; 0x45780
.asm_8d8f0 ; 0x45782
    ld hl, $578b
    call PrintText
.asm_46c43 ; 0x45788
    jp $24d7

INCBIN "baserom.gbc",$4578b,$6

RocketHideoutElevatorObject: ; 0x45791 (size=23)
    db $f ; border tile

    db $2 ; warps
    db $1, $2, $2, ROCKET_HIDEOUT_1
    db $1, $3, $4, ROCKET_HIDEOUT_1

    db $1 ; signs
    db $1, $1, $1 ; RocketHideoutElevatorText1

    db $0 ; people

    ; warp-to
    EVENT_DISP $3, $1, $2 ; ROCKET_HIDEOUT_1
    EVENT_DISP $3, $1, $3 ; ROCKET_HIDEOUT_1

RocketHideoutElevatorBlocks: ; 12
    INCBIN "maps/rockethideoutelevator.blk"

SilphCoElevator_h: ; 0x457b4 to 0x457c0 (12 bytes) (bank=11) (id=236)
    db $12 ; tileset
    db SILPH_CO_ELEVATOR_HEIGHT, SILPH_CO_ELEVATOR_WIDTH ; dimensions (y, x)
    dw SilphCoElevatorBlocks, SilphCoElevatorTexts, SilphCoElevatorScript ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCoElevatorObject ; objects

SilphCoElevatorScript: ; 0x457c0
    ld hl, $d126
    bit 5, [hl]
    res 5, [hl]
    push hl
    call nz, $57dc
    pop hl
    bit 7, [hl]
    res 7, [hl]
    call nz, $5827
    xor a
    ld [$cf0c], a
    inc a
    ld [$cc3c], a
    ret
; 0x457dc

INCBIN "baserom.gbc",$457dc,$57

SilphCoElevatorTexts: ; 0x45833
    dw SilphCoElevatorText1

SilphCoElevatorText1: ; 0x45835
    db $08 ; asm
    call $57f1
    ld hl, $5811
    ld a, $61
    call Predef
    jp $24d7

SilphCoElevatorObject: ; 0x45844 (size=23)
    db $f ; border tile

    db $2 ; warps
    db $3, $1, $0, $ed
    db $3, $2, $0, $ed

    db $1 ; signs
    db $0, $3, $1 ; SilphCoElevatorText1

    db $0 ; people

    ; warp-to
    EVENT_DISP $2, $3, $1
    EVENT_DISP $2, $3, $2

SilphCoElevatorBlocks: ; 4
    INCBIN "maps/silphcoelevator.blk"

SafariZoneEast_h: ; 0x4585f to 0x4586b (12 bytes) (bank=11) (id=217)
    db $03 ; tileset
    db SAFARI_ZONE_EAST_HEIGHT, SAFARI_ZONE_EAST_WIDTH ; dimensions (y, x)
    dw SafariZoneEastBlocks, SafariZoneEastTexts, SafariZoneEastScript ; blocks, texts, scripts
    db $00 ; connections

    dw SafariZoneEastObject ; objects

SafariZoneEastScript: ; 0x4586b
    jp $3c3c
; 0x4586e

SafariZoneEastTexts: ; 0x4586e
    dw SafariZoneEastText1, SafariZoneEastText2, SafariZoneEastText3, SafariZoneEastText4, SafariZoneEastText5, SafariZoneEastText6, SafariZoneEastText7

SafariZoneEastText5: ; 0x4587c
    TX_FAR _SafariZoneEastText5
    db $50

SafariZoneEastText6: ; 0x45881
    TX_FAR _SafariZoneEastText6
    db $50

SafariZoneEastText7: ; 0x45886
    TX_FAR _SafariZoneEastText7
    db $50

SafariZoneEastObject: ; 0x4588b (size=81)
    db $0 ; border tile

    db $5 ; warps
    db $4, $0, $6, SAFARI_ZONE_NORTH
    db $5, $0, $7, SAFARI_ZONE_NORTH
    db $16, $0, $6, SAFARI_ZONE_CENTER
    db $17, $0, $6, SAFARI_ZONE_CENTER
    db $9, $19, $0, SAFARI_ZONE_REST_HOUSE_3

    db $3 ; signs
    db $a, $1a, $5 ; SafariZoneEastText5
    db $4, $6, $6 ; SafariZoneEastText6
    db $17, $5, $7 ; SafariZoneEastText7

    db $4 ; people
	db SPRITE_BALL, $a + 4, $15 + 4, $ff, $ff, $81, FULL_RESTORE ; item
	db SPRITE_BALL, $7 + 4, $3 + 4, $ff, $ff, $82, MAX_POTION ; item
	db SPRITE_BALL, $d + 4, $14 + 4, $ff, $ff, $83, CARBOS ; item
	db SPRITE_BALL, $c + 4, $f + 4, $ff, $ff, $84, TM_37 ; item

    ; warp-to
    EVENT_DISP $f, $4, $0 ; SAFARI_ZONE_NORTH
    EVENT_DISP $f, $5, $0 ; SAFARI_ZONE_NORTH
    EVENT_DISP $f, $16, $0 ; SAFARI_ZONE_CENTER
    EVENT_DISP $f, $17, $0 ; SAFARI_ZONE_CENTER
    EVENT_DISP $f, $9, $19 ; SAFARI_ZONE_REST_HOUSE_3

SafariZoneEastBlocks: ; 195
    INCBIN "maps/safarizoneeast.blk"

SafariZoneNorth_h: ; 0x4599f to 0x459ab (12 bytes) (bank=11) (id=218)
    db $03 ; tileset
    db SAFARI_ZONE_NORTH_HEIGHT, SAFARI_ZONE_NORTH_WIDTH ; dimensions (y, x)
    dw SafariZoneNorthBlocks, SafariZoneNorthTexts, SafariZoneNorthScript ; blocks, texts, scripts
    db $00 ; connections

    dw SafariZoneNorthObject ; objects

SafariZoneNorthScript: ; 0x459ab
    jp $3c3c
; 0x459ae

SafariZoneNorthTexts: ; 0x459ae
    dw SafariZoneNorthText1, SafariZoneNorthText2, SafariZoneNorthText3, SafariZoneNorthText4, SafariZoneNorthText5, SafariZoneNorthText6, SafariZoneNorthText7

SafariZoneNorthText3: ; 0x459bc
    TX_FAR _SafariZoneNorthText3
    db $50

SafariZoneNorthText4: ; 0x459c1
    TX_FAR _SafariZoneNorthText4
    db $50

SafariZoneNorthText5: ; 0x459c6
    TX_FAR _SafariZoneNorthText5
    db $50

SafariZoneNorthText6: ; 0x459cb
    TX_FAR _SafariZoneNorthText6
    db $50

SafariZoneNorthText7: ; 0x459d0
    TX_FAR _SafariZoneNorthText7
    db $50

SafariZoneNorthObject: ; 0x459d5 (size=105)
    db $0 ; border tile

    db $9 ; warps
    db $23, $2, $0, SAFARI_ZONE_WEST
    db $23, $3, $1, SAFARI_ZONE_WEST
    db $23, $8, $2, SAFARI_ZONE_WEST
    db $23, $9, $3, SAFARI_ZONE_WEST
    db $23, $14, $4, SAFARI_ZONE_CENTER
    db $23, $15, $5, SAFARI_ZONE_CENTER
    db $1e, $27, $0, SAFARI_ZONE_EAST
    db $1f, $27, $1, SAFARI_ZONE_EAST
    db $3, $23, $0, SAFARI_ZONE_REST_HOUSE_4

    db $5 ; signs
    db $4, $24, $3 ; SafariZoneNorthText3
    db $19, $4, $4 ; SafariZoneNorthText4
    db $1f, $d, $5 ; SafariZoneNorthText5
    db $21, $13, $6 ; SafariZoneNorthText6
    db $1c, $1a, $7 ; SafariZoneNorthText7

    db $2 ; people
	db SPRITE_BALL, $1 + 4, $19 + 4, $ff, $ff, $81, PROTEIN ; item
	db SPRITE_BALL, $7 + 4, $13 + 4, $ff, $ff, $82, TM_40 ; item

    ; warp-to
    EVENT_DISP $14, $23, $2 ; SAFARI_ZONE_WEST
    EVENT_DISP $14, $23, $3 ; SAFARI_ZONE_WEST
    EVENT_DISP $14, $23, $8 ; SAFARI_ZONE_WEST
    EVENT_DISP $14, $23, $9 ; SAFARI_ZONE_WEST
    EVENT_DISP $14, $23, $14 ; SAFARI_ZONE_CENTER
    EVENT_DISP $14, $23, $15 ; SAFARI_ZONE_CENTER
    EVENT_DISP $14, $1e, $27 ; SAFARI_ZONE_EAST
    EVENT_DISP $14, $1f, $27 ; SAFARI_ZONE_EAST
    EVENT_DISP $14, $3, $23 ; SAFARI_ZONE_REST_HOUSE_4

SafariZoneNorthBlocks: ; 360
    INCBIN "maps/safarizonenorth.blk"

SafariZoneCenter_h: ; 0x45ba6 to 0x45bb2 (12 bytes) (bank=11) (id=220)
    db $03 ; tileset
    db SAFARI_ZONE_CENTER_HEIGHT, SAFARI_ZONE_CENTER_WIDTH ; dimensions (y, x)
    dw SafariZoneCenterBlocks, SafariZoneCenterTexts, SafariZoneCenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw SafariZoneCenterObject ; objects

SafariZoneCenterScript: ; 0x45bb2
    jp $3c3c
; 0x45bb5

SafariZoneCenterTexts: ; 0x45bb5
    dw SafariZoneCenterText1, SafariZoneCenterText2, SafariZoneCenterText3

SafariZoneCenterText2: ; 0x45bbb
    TX_FAR _SafariZoneCenterText2
    db $50

SafariZoneCenterText3: ; 0x45bc0
    TX_FAR _SafariZoneCenterText3
    db $50

SafariZoneCenterObject: ; 0x45bc5 (size=89)
    db $0 ; border tile

    db $9 ; warps
    db $19, $e, $2, SAFARIZONEENTRANCE
    db $19, $f, $3, SAFARIZONEENTRANCE
    db $a, $0, $4, SAFARI_ZONE_WEST
    db $b, $0, $5, SAFARI_ZONE_WEST
    db $0, $e, $4, SAFARI_ZONE_NORTH
    db $0, $f, $5, SAFARI_ZONE_NORTH
    db $a, $1d, $2, SAFARI_ZONE_EAST
    db $b, $1d, $3, SAFARI_ZONE_EAST
    db $13, $11, $0, SAFARI_ZONE_REST_HOUSE_1

    db $2 ; signs
    db $14, $12, $2 ; SafariZoneCenterText2
    db $16, $e, $3 ; SafariZoneCenterText3

    db $1 ; people
	db SPRITE_BALL, $a + 4, $e + 4, $ff, $ff, $81, NUGGET ; item

    ; warp-to
    EVENT_DISP $f, $19, $e ; SAFARIZONEENTRANCE
    EVENT_DISP $f, $19, $f ; SAFARIZONEENTRANCE
    EVENT_DISP $f, $a, $0 ; SAFARI_ZONE_WEST
    EVENT_DISP $f, $b, $0 ; SAFARI_ZONE_WEST
    EVENT_DISP $f, $0, $e ; SAFARI_ZONE_NORTH
    EVENT_DISP $f, $0, $f ; SAFARI_ZONE_NORTH
    EVENT_DISP $f, $a, $1d ; SAFARI_ZONE_EAST
    EVENT_DISP $f, $b, $1d ; SAFARI_ZONE_EAST
    EVENT_DISP $f, $13, $11 ; SAFARI_ZONE_REST_HOUSE_1

SafariZoneCenterBlocks: ; 195
    INCBIN "maps/safarizonecenter.blk"

SafariZoneRestHouse1_h: ; 0x45ce1 to 0x45ced (12 bytes) (bank=11) (id=221)
    db $0c ; tileset
    db SAFARI_ZONE_REST_HOUSE_1_HEIGHT, SAFARI_ZONE_REST_HOUSE_1_WIDTH ; dimensions (y, x)
    dw SafariZoneRestHouse1Blocks, SafariZoneRestHouse1Texts, SafariZoneRestHouse1Script ; blocks, texts, scripts
    db $00 ; connections

    dw SafariZoneRestHouse1Object ; objects

SafariZoneRestHouse1Script: ; 0x45ced
    jp $3c3c
; 0x45cf0

SafariZoneRestHouse1Texts: ; 0x45cf0
    dw SafariZoneRestHouse1Text1, SafariZoneRestHouse1Text2

SafariZoneRestHouse1Text1: ; 0x45cf4
    TX_FAR _SafariZoneRestHouse1Text1
    db $50

SafariZoneRestHouse1Text2: ; 0x45cf9
    TX_FAR _SafariZoneRestHouse1Text2
    db $50

SafariZoneRestHouse1Object: ; 0x45cfe (size=32)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $8, SAFARI_ZONE_CENTER
    db $7, $3, $8, SAFARI_ZONE_CENTER

    db $0 ; signs

    db $2 ; people
    db SPRITE_GIRL, $2 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_OAK_AIDE, $4 + 4, $1 + 4, $fe, $1, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2 ; SAFARI_ZONE_CENTER
    EVENT_DISP $4, $7, $3 ; SAFARI_ZONE_CENTER

SafariZoneRestHouse2_h: ; 0x45d1e to 0x45d2a (12 bytes) (bank=11) (id=223)
    db $0c ; tileset
    db SAFARI_ZONE_REST_HOUSE_2_HEIGHT, SAFARI_ZONE_REST_HOUSE_2_WIDTH ; dimensions (y, x)
    dw $40fb, SafariZoneRestHouse2Texts, SafariZoneRestHouse2Script ; blocks, texts, scripts
    db $00 ; connections

    dw SafariZoneRestHouse2Object ; objects

SafariZoneRestHouse2Script: ; 0x45d2a
    call $3c3c
    ret
; 0x45d2e

SafariZoneRestHouse2Texts: ; 0x45d2e
    dw SafariZoneRestHouse2Text1, SafariZoneRestHouse2Text2, SafariZoneRestHouse2Text3

SafariZoneRestHouse2Text1: ; 0x45d34
    TX_FAR _SafariZoneRestHouse2Text1
    db $50

SafariZoneRestHouse2Text2: ; 0x45d39
    TX_FAR _SafariZoneRestHouse2Text2
    db $50

SafariZoneRestHouse2Text3: ; 0x45d3e
    TX_FAR _SafariZoneRestHouse2Text3
    db $50

SafariZoneRestHouse2Object: ; 0x45d43 (size=38)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $7, SAFARI_ZONE_WEST
    db $7, $3, $7, SAFARI_ZONE_WEST

    db $0 ; signs

    db $3 ; people
    db SPRITE_OAK_AIDE, $4 + 4, $4 + 4, $fe, $0, $1 ; person
    db SPRITE_BLACK_HAIR_BOY_1, $2 + 4, $0 + 4, $ff, $d3, $2 ; person
    db SPRITE_ERIKA, $2 + 4, $6 + 4, $ff, $d0, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2 ; SAFARI_ZONE_WEST
    EVENT_DISP $4, $7, $3 ; SAFARI_ZONE_WEST

SafariZoneRestHouse3_h: ; 0x45d69 to 0x45d75 (12 bytes) (bank=11) (id=224)
    db $0c ; tileset
    db SAFARI_ZONE_REST_HOUSE_3_HEIGHT, SAFARI_ZONE_REST_HOUSE_3_WIDTH ; dimensions (y, x)
    dw $40fb, SafariZoneRestHouse3Texts, SafariZoneRestHouse3Script ; blocks, texts, scripts
    db $00 ; connections

    dw SafariZoneRestHouse3Object ; objects

SafariZoneRestHouse3Script: ; 0x45d75
    call $3c3c
    ret
; 0x45d79

SafariZoneRestHouse3Texts: ; 0x45d79
    dw SafariZoneRestHouse3Text1, SafariZoneRestHouse3Text2, SafariZoneRestHouse3Text3

SafariZoneRestHouse3Text1: ; 0x45d7f
    TX_FAR _SafariZoneRestHouse3Text1
    db $50

SafariZoneRestHouse3Text2: ; 0x45d84
    TX_FAR _SafariZoneRestHouse3Text2
    db $50

SafariZoneRestHouse3Text3: ; 0x45d89
    TX_FAR _SafariZoneRestHouse3Text3
    db $50

SafariZoneRestHouse3Object: ; 0x45d8e (size=38)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $4, SAFARI_ZONE_EAST
    db $7, $3, $4, SAFARI_ZONE_EAST

    db $0 ; signs

    db $3 ; people
    db SPRITE_OAK_AIDE, $3 + 4, $1 + 4, $fe, $1, $1 ; person
    db SPRITE_ROCKER, $2 + 4, $4 + 4, $ff, $ff, $2 ; person
    db SPRITE_LAPRAS_GIVER, $2 + 4, $5 + 4, $ff, $ff, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2 ; SAFARI_ZONE_EAST
    EVENT_DISP $4, $7, $3 ; SAFARI_ZONE_EAST

SafariZoneRestHouse4_h: ; 0x45db4 to 0x45dc0 (12 bytes) (bank=11) (id=225)
    db $0c ; tileset
    db SAFARI_ZONE_REST_HOUSE_4_HEIGHT, SAFARI_ZONE_REST_HOUSE_4_WIDTH ; dimensions (y, x)
    dw $40fb, SafariZoneRestHouse4Texts, SafariZoneRestHouse4Script ; blocks, texts, scripts
    db $00 ; connections

    dw SafariZoneRestHouse4Object ; objects

SafariZoneRestHouse4Script: ; 0x45dc0
    call $3c3c
    ret
; 0x45dc4

SafariZoneRestHouse4Texts: ; 0x45dc4
    dw SafariZoneRestHouse4Text1, SafariZoneRestHouse4Text2, SafariZoneRestHouse4Text3

SafariZoneRestHouse4Text1: ; 0x45dca
    TX_FAR _SafariZoneRestHouse4Text1
    db $50

SafariZoneRestHouse4Text2: ; 0x45dcf
    TX_FAR _SafariZoneRestHouse4Text2
    db $50

SafariZoneRestHouse4Text3: ; 0x45dd4
    TX_FAR _SafariZoneRestHouse4Text3
    db $50

SafariZoneRestHouse4Object: ; 0x45dd9 (size=38)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $8, SAFARI_ZONE_NORTH
    db $7, $3, $8, SAFARI_ZONE_NORTH

    db $0 ; signs

    db $3 ; people
    db SPRITE_OAK_AIDE, $3 + 4, $6 + 4, $fe, $2, $1 ; person
    db SPRITE_WHITE_PLAYER, $4 + 4, $3 + 4, $ff, $ff, $2 ; person
    db SPRITE_GENTLEMAN, $5 + 4, $1 + 4, $fe, $1, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2 ; SAFARI_ZONE_NORTH
    EVENT_DISP $4, $7, $3 ; SAFARI_ZONE_NORTH

UnknownDungeon2_h: ; 0x45dff to 0x45e0b (12 bytes) (bank=11) (id=226)
    db $11 ; tileset
    db UNKNOWN_DUNGEON_2_HEIGHT, UNKNOWN_DUNGEON_2_WIDTH ; dimensions (y, x)
    dw UnknownDungeon2Blocks, UnknownDungeon2Texts, UnknownDungeon2Script ; blocks, texts, scripts
    db $00 ; connections

    dw UnknownDungeon2Object ; objects

UnknownDungeon2Script: ; 0x45e0b
    jp $3c3c
; 0x45e0e

UnknownDungeon2Texts: ; 0x45e0e
    dw UnknownDungeon2Text1, UnknownDungeon2Text2, UnknownDungeon2Text3

UnknownDungeon2Object: ; 0x45e14 (size=73)
    db $7d ; border tile

    db $6 ; warps
    db $1, $1d, $2, UNKNOWN_DUNGEON_1
    db $6, $16, $3, UNKNOWN_DUNGEON_1
    db $7, $13, $4, UNKNOWN_DUNGEON_1
    db $1, $9, $5, UNKNOWN_DUNGEON_1
    db $3, $1, $6, UNKNOWN_DUNGEON_1
    db $b, $3, $7, UNKNOWN_DUNGEON_1

    db $0 ; signs

    db $3 ; people
	db SPRITE_BALL, $9 + 4, $1d + 4, $ff, $ff, $81, PP_UP ; item
	db SPRITE_BALL, $f + 4, $4 + 4, $ff, $ff, $82, ULTRA_BALL ; item
	db SPRITE_BALL, $6 + 4, $d + 4, $ff, $ff, $83, FULL_RESTORE ; item

    ; warp-to
    EVENT_DISP $f, $1, $1d ; UNKNOWN_DUNGEON_1
    EVENT_DISP $f, $6, $16 ; UNKNOWN_DUNGEON_1
    EVENT_DISP $f, $7, $13 ; UNKNOWN_DUNGEON_1
    EVENT_DISP $f, $1, $9 ; UNKNOWN_DUNGEON_1
    EVENT_DISP $f, $3, $1 ; UNKNOWN_DUNGEON_1
    EVENT_DISP $f, $b, $3 ; UNKNOWN_DUNGEON_1

UnknownDungeon2Blocks: ; 135
    INCBIN "maps/unknowndungeon2.blk"

UnknownDungeon3_h: ; 0x45ee4 to 0x45ef0 (12 bytes) (bank=11) (id=227)
    db $11 ; tileset
    db UNKNOWN_DUNGEON_3_HEIGHT, UNKNOWN_DUNGEON_3_WIDTH ; dimensions (y, x)
    dw UnknownDungeon3Blocks, UnknownDungeon3Texts, UnknownDungeon3Script ; blocks, texts, scripts
    db $00 ; connections

    dw UnknownDungeon3Object ; objects

UnknownDungeon3Script: ; 0x45ef0
    call $3c3c
    ld hl, $5f0f
    ld de, $5f03
    ld a, [$d650]
    call $3160
    ld [$d650], a
    ret
; 0x45f03

INCBIN "baserom.gbc",$45f03,$6

UnknownDungeon3Texts: ; 0x45f09
    dw UnknownDungeon3Text1, UnknownDungeon3Text2, UnknownDungeon3Text3

INCBIN "baserom.gbc",$45f0f,$d

UnknownDungeon3Text1: ; 0x45f1c
    db $08 ; asm
    ld hl, $5f0f
    call LoadTrainerHeader
    jp $24d7

INCBIN "baserom.gbc",$45f26,$10

UnknownDungeon3Object: ; 0x45f36 (size=34)
    db $7d ; border tile

    db $1 ; warps
    db $6, $3, $8, UNKNOWN_DUNGEON_1

    db $0 ; signs

    db $3 ; people
    db SPRITE_SLOWBRO, $d + 4, $1b + 4, $ff, $d0, $41, MEWTWO, $46 ; trainer
	db SPRITE_BALL, $9 + 4, $10 + 4, $ff, $ff, $82, ULTRA_BALL ; item
	db SPRITE_BALL, $1 + 4, $12 + 4, $ff, $ff, $83, MAX_REVIVE ; item

    ; warp-to
    EVENT_DISP $f, $6, $3 ; UNKNOWN_DUNGEON_1

UnknownDungeon3Blocks: ; 135
    INCBIN "maps/unknowndungeon3.blk"

RockTunnel2_h: ; 0x45fdf to 0x45feb (12 bytes) (bank=11) (id=232)
    db $11 ; tileset
    db ROCK_TUNNEL_2_HEIGHT, ROCK_TUNNEL_2_WIDTH ; dimensions (y, x)
    dw RockTunnel2Blocks, RockTunnel2Texts, RockTunnel2Script ; blocks, texts, scripts
    db $00 ; connections

    dw RockTunnel2Object ; objects

RockTunnel2Script: ; 0x45feb
    call $3c3c
    ld hl, $6014
    ld de, $5ffe
    ld a, [$d620]
    call $3160
    ld [$d620], a
    ret
; 0x45ffe

INCBIN "baserom.gbc",$45ffe,$6

RockTunnel2Texts: ; 0x46004
    dw RockTunnel2Text1, RockTunnel2Text2, RockTunnel2Text3, RockTunnel2Text4, RockTunnel2Text5, RockTunnel2Text6, RockTunnel2Text7, RockTunnel2Text8

INCBIN "baserom.gbc",$46014,$61

RockTunnel2Text1: ; 0x46075
    db $08 ; asm
    ld hl, $6014
    call LoadTrainerHeader
    jp $24d7

RockTunnel2Text2: ; 0x4607f
    db $08 ; asm
    ld hl, $6020
    call LoadTrainerHeader
    jp $24d7

RockTunnel2Text3: ; 0x46089
    db $08 ; asm
    ld hl, $602c
    call LoadTrainerHeader
    jp $24d7

RockTunnel2Text4: ; 0x46093
    db $08 ; asm
    ld hl, $6038
    call LoadTrainerHeader
    jp $24d7

RockTunnel2Text5: ; 0x4609d
    db $08 ; asm
    ld hl, $6044
    call LoadTrainerHeader
    jp $24d7

RockTunnel2Text6: ; 0x460a7
    db $08 ; asm
    ld hl, $6050
    call LoadTrainerHeader
    jp $24d7

RockTunnel2Text7: ; 0x460b1
    db $08 ; asm
    ld hl, $605c
    call LoadTrainerHeader
    jp $24d7

RockTunnel2Text8: ; 0x460bb
    db $08 ; asm
    ld hl, $6068
    call LoadTrainerHeader
    jp $24d7

UnnamedText_460c5: ; 0x460c5
    TX_FAR _UnnamedText_460c5
    db $50
; 0x460c5 + 5 bytes

UnnamedText_460ca: ; 0x460ca
    TX_FAR _UnnamedText_460ca
    db $50
; 0x460ca + 5 bytes

UnnamedText_460cf: ; 0x460cf
    TX_FAR _UnnamedText_460cf
    db $50
; 0x460cf + 5 bytes

UnnamedText_460d4: ; 0x460d4
    TX_FAR _UnnamedText_460d4
    db $50
; 0x460d4 + 5 bytes

UnnamedText_460d9: ; 0x460d9
    TX_FAR _UnnamedText_460d9
    db $50
; 0x460d9 + 5 bytes

UnnamedText_460de: ; 0x460de
    TX_FAR _UnnamedText_460de
    db $50
; 0x460de + 5 bytes

UnnamedText_460e3: ; 0x460e3
    TX_FAR _UnnamedText_460e3
    db $50
; 0x460e3 + 5 bytes

UnnamedText_460e8: ; 0x460e8
    TX_FAR _UnnamedText_460e8
    db $50
; 0x460e8 + 5 bytes

UnnamedText_460ed: ; 0x460ed
    TX_FAR _UnnamedText_460ed
    db $50
; 0x460ed + 5 bytes

UnnamedText_460f2: ; 0x460f2
    TX_FAR _UnnamedText_460f2
    db $50
; 0x460f2 + 5 bytes

UnnamedText_460f7: ; 0x460f7
    TX_FAR _UnnamedText_460f7
    db $50
; 0x460f7 + 5 bytes

UnnamedText_460fc: ; 0x460fc
    TX_FAR _UnnamedText_460fc
    db $50
; 0x460fc + 5 bytes

UnnamedText_46101: ; 0x46101
    TX_FAR _UnnamedText_46101
    db $50
; 0x46101 + 5 bytes

UnnamedText_46106: ; 0x46106
    TX_FAR _UnnamedText_46106
    db $50
; 0x46106 + 5 bytes

UnnamedText_4610b: ; 0x4610b
    TX_FAR _UnnamedText_4610b
    db $50
; 0x4610b + 5 bytes

UnnamedText_46110: ; 0x46110
    TX_FAR _UnnamedText_46110
    db $50
; 0x46110 + 5 bytes

UnnamedText_46115: ; 0x46115
    TX_FAR _UnnamedText_46115
    db $50
; 0x46115 + 5 bytes

UnnamedText_4611a: ; 0x4611a
    TX_FAR _UnnamedText_4611a
    db $50
; 0x4611a + 5 bytes

UnnamedText_4611f: ; 0x4611f
    TX_FAR _UnnamedText_4611f
    db $50
; 0x4611f + 5 bytes

UnnamedText_46124: ; 0x46124
    TX_FAR _UnnamedText_46124
    db $50
; 0x46124 + 5 bytes

UnnamedText_46129: ; 0x46129
    TX_FAR _UnnamedText_46129
    db $50
; 0x46129 + 5 bytes

UnnamedText_4612e: ; 0x4612e
    TX_FAR _UnnamedText_4612e
    db $50
; 0x4612e + 5 bytes

UnnamedText_46133: ; 0x46133
    TX_FAR _UnnamedText_46133
    db $50
; 0x46133 + 5 bytes

UnnamedText_46138: ; 0x46138
    TX_FAR _UnnamedText_46138
    db $50
; 0x46138 + 5 bytes

RockTunnel2Object: ; 0x4613d (size=100)
    db $3 ; border tile

    db $4 ; warps
    db $19, $21, $4, ROCK_TUNNEL_1
    db $3, $1b, $5, ROCK_TUNNEL_1
    db $b, $17, $6, ROCK_TUNNEL_1
    db $3, $3, $7, ROCK_TUNNEL_1

    db $0 ; signs

    db $8 ; people
    db SPRITE_LASS, $d + 4, $b + 4, $ff, $d0, $41, JR__TRAINER_F + $C8, $9 ; trainer
    db SPRITE_HIKER, $a + 4, $6 + 4, $ff, $d0, $42, HIKER + $C8, $9 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $5 + 4, $3 + 4, $ff, $d0, $43, POKEMANIAC + $C8, $3 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $15 + 4, $14 + 4, $ff, $d3, $44, POKEMANIAC + $C8, $4 ; trainer
    db SPRITE_HIKER, $a + 4, $1e + 4, $ff, $d0, $45, HIKER + $C8, $a ; trainer
    db SPRITE_LASS, $1c + 4, $e + 4, $ff, $d3, $46, JR__TRAINER_F + $C8, $a ; trainer
    db SPRITE_HIKER, $5 + 4, $21 + 4, $ff, $d3, $47, HIKER + $C8, $b ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $1e + 4, $1a + 4, $ff, $d0, $48, POKEMANIAC + $C8, $5 ; trainer

    ; warp-to
    EVENT_DISP $14, $19, $21 ; ROCK_TUNNEL_1
    EVENT_DISP $14, $3, $1b ; ROCK_TUNNEL_1
    EVENT_DISP $14, $b, $17 ; ROCK_TUNNEL_1
    EVENT_DISP $14, $3, $3 ; ROCK_TUNNEL_1

RockTunnel2Blocks: ; 360
    INCBIN "maps/rocktunnel2.blk"

SeafoamIslands2_h: ; 0x46309 to 0x46315 (12 bytes) (bank=11) (id=159)
    db $11 ; tileset
    db SEAFOAM_ISLANDS_2_HEIGHT, SEAFOAM_ISLANDS_2_WIDTH ; dimensions (y, x)
    dw SeafoamIslands2Blocks, SeafoamIslands2Texts, SeafoamIslands2Script ; blocks, texts, scripts
    db $00 ; connections

    dw SeafoamIslands2Object ; objects

SeafoamIslands2Script: ; 0x46315
    call $3c3c
    ld hl, $cd60
    bit 7, [hl]
    res 7, [hl]
    jr z, .asm_46362 ; 0x4631f $41
    ld hl, $636d
    call $34e4
    ret nc
    ld hl, $d87f
    ld a, [$cd3d]
    cp $1
    jr nz, .asm_46340 ; 0x46330 $e
    set 0, [hl]
    ld a, $d9
    ld [$d079], a
    ld a, $db
    ld [$d07a], a
    jr .asm_4634c ; 0x4633e $c
.asm_46340
    set 1, [hl]
    ld a, $da
    ld [$d079], a
    ld a, $dc
    ld [$d07a], a
.asm_4634c
    ld a, [$d079]
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld a, [$d07a]
    ld [$cc4d], a
    ld a, $15
    jp $3e6d
.asm_46362
    ld a, $a0
    ld [$d71d], a
    ld hl, $636d
    jp $6981
; 0x4636d

INCBIN "baserom.gbc",$4636d,$5

SeafoamIslands2Texts: ; 0x46372
    dw SeafoamIslands2Text1, SeafoamIslands2Text2

SeafoamIslands2Object: ; 0x46376 (size=72)
    db $7d ; border tile

    db $7 ; warps
    db $2, $4, $0, SEAFOAM_ISLANDS_3
    db $5, $7, $4, SEAFOAM_ISLANDS_1
    db $7, $d, $2, SEAFOAM_ISLANDS_3
    db $f, $13, $3, SEAFOAM_ISLANDS_3
    db $f, $17, $6, SEAFOAM_ISLANDS_1
    db $b, $19, $5, SEAFOAM_ISLANDS_3
    db $3, $19, $5, SEAFOAM_ISLANDS_1

    db $0 ; signs

    db $2 ; people
    db SPRITE_BOULDER, $6 + 4, $11 + 4, $ff, $10, $1 ; person
    db SPRITE_BOULDER, $6 + 4, $16 + 4, $ff, $10, $2 ; person

    ; warp-to
    EVENT_DISP $f, $2, $4 ; SEAFOAM_ISLANDS_3
    EVENT_DISP $f, $5, $7 ; SEAFOAM_ISLANDS_1
    EVENT_DISP $f, $7, $d ; SEAFOAM_ISLANDS_3
    EVENT_DISP $f, $f, $13 ; SEAFOAM_ISLANDS_3
    EVENT_DISP $f, $f, $17 ; SEAFOAM_ISLANDS_1
    EVENT_DISP $f, $b, $19 ; SEAFOAM_ISLANDS_3
    EVENT_DISP $f, $3, $19 ; SEAFOAM_ISLANDS_1

SeafoamIslands2Blocks: ; 135
    INCBIN "maps/seafoamislands2.blk"

SeafoamIslands3_h: ; 0x46445 to 0x46451 (12 bytes) (bank=11) (id=160)
    db $11 ; tileset
    db SEAFOAM_ISLANDS_3_HEIGHT, SEAFOAM_ISLANDS_3_WIDTH ; dimensions (y, x)
    dw SeafoamIslands3Blocks, SeafoamIslands3Texts, SeafoamIslands3Script ; blocks, texts, scripts
    db $00 ; connections

    dw SeafoamIslands3Object ; objects

SeafoamIslands3Script: ; 0x46451
    call $3c3c
    ld hl, $cd60
    bit 7, [hl]
    res 7, [hl]
    jr z, .asm_4649e ; 0x4645b $41
    ld hl, $64a9
    call $34e4
    ret nc
    ld hl, $d880
    ld a, [$cd3d]
    cp $1
    jr nz, .asm_4647c ; 0x4646c $e
    set 0, [hl]
    ld a, $db
    ld [$d079], a
    ld a, $df
    ld [$d07a], a
    jr .asm_46488 ; 0x4647a $c
.asm_4647c
    set 1, [hl]
    ld a, $dc
    ld [$d079], a
    ld a, $e0
    ld [$d07a], a
.asm_46488
    ld a, [$d079]
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld a, [$d07a]
    ld [$cc4d], a
    ld a, $15
    jp $3e6d
.asm_4649e
    ld a, $a1
    ld [$d71d], a
    ld hl, $64a9
    jp $6981
; 0x464a9

INCBIN "baserom.gbc",$464a9,$5

SeafoamIslands3Texts: ; 0x464ae
    dw SeafoamIslands3Text1, SeafoamIslands3Text2

SeafoamIslands3Object: ; 0x464b2 (size=72)
    db $7d ; border tile

    db $7 ; warps
    db $3, $5, $0, SEAFOAM_ISLANDS_2
    db $d, $5, $0, SEAFOAM_ISLANDS_4
    db $7, $d, $2, SEAFOAM_ISLANDS_2
    db $f, $13, $3, SEAFOAM_ISLANDS_2
    db $3, $19, $3, SEAFOAM_ISLANDS_4
    db $b, $19, $5, SEAFOAM_ISLANDS_2
    db $e, $19, $4, SEAFOAM_ISLANDS_4

    db $0 ; signs

    db $2 ; people
    db SPRITE_BOULDER, $6 + 4, $12 + 4, $ff, $10, $1 ; person
    db SPRITE_BOULDER, $6 + 4, $17 + 4, $ff, $10, $2 ; person

    ; warp-to
    EVENT_DISP $f, $3, $5 ; SEAFOAM_ISLANDS_2
    EVENT_DISP $f, $d, $5 ; SEAFOAM_ISLANDS_4
    EVENT_DISP $f, $7, $d ; SEAFOAM_ISLANDS_2
    EVENT_DISP $f, $f, $13 ; SEAFOAM_ISLANDS_2
    EVENT_DISP $f, $3, $19 ; SEAFOAM_ISLANDS_4
    EVENT_DISP $f, $b, $19 ; SEAFOAM_ISLANDS_2
    EVENT_DISP $f, $e, $19 ; SEAFOAM_ISLANDS_4

SeafoamIslands3Blocks: ; 135
    INCBIN "maps/seafoamislands3.blk"

SeafoamIslands4_h: ; 0x46581 to 0x4658d (12 bytes) (bank=11) (id=161)
    db $11 ; tileset
    db SEAFOAM_ISLANDS_4_HEIGHT, SEAFOAM_ISLANDS_4_WIDTH ; dimensions (y, x)
    dw SeafoamIslands4Blocks, SeafoamIslands4Texts, SeafoamIslands4Script ; blocks, texts, scripts
    db $00 ; connections

    dw SeafoamIslands4Object ; objects

SeafoamIslands4Script: ; 0x4658d
    call $3c3c
    ld hl, $cd60
    bit 7, [hl]
    res 7, [hl]
    jr z, .asm_465dc ; 0x46597 $43
    ld hl, $65f6
    call $34e4
    ret nc
    ld hl, $d881
    ld a, [$cd3d]
    cp $1
    jr nz, .asm_465b8 ; 0x465a8 $e
    set 0, [hl]
    ld a, $dd
    ld [$d079], a
    ld a, $e1
    ld [$d07a], a
    jr .asm_465c4 ; 0x465b6 $c
.asm_465b8
    set 1, [hl]
    ld a, $de
    ld [$d079], a
    ld a, $e2
    ld [$d07a], a
.asm_465c4
    ld a, [$d079]
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld a, [$d07a]
    ld [$cc4d], a
    ld a, $15
    call Predef
    jr .asm_465ed ; 0x465da $11
.asm_465dc
    ld a, $a2
    ld [$d71d], a
    ld hl, $65f6
    call $6981
    ld a, [$d732]
    bit 4, a
    ret nz
.asm_465ed
    ld hl, $65fb
    ld a, [$d666]
    jp $3d97
; 0x465f6

INCBIN "baserom.gbc",$465f6,$465fb - $465f6

SeafoamIslands4Scripts: ; 0x465fb
    dw SeafoamIslands4Script0, SeafoamIslands4Script1

INCBIN "baserom.gbc",$465ff,$4

SeafoamIslands4Script0: ; 0x46603
    ld a, [$d880]
    and $3
    cp $3
    ret z
    ld a, [$d361]
    cp $8
    ret nz
    ld a, [$d362]
    cp $f
    ret nz
    ld hl, $ccd3
    ld de, $6632
    call $350c
    dec a
    ld [$cd38], a
    call $3486
    ld hl, $d733
    set 2, [hl]
    ld a, $1
    ld [$d666], a
    ret
; 0x46632

INCBIN "baserom.gbc",$46632,$46639 - $46632

SeafoamIslands4Script1: ; 0x46639
    ld a, [$cd38]
    and a
    ret nz
    ld a, $0
    ld [$d666], a
    ret
; 0x46644

INCBIN "baserom.gbc",$46644,$56

SeafoamIslands4Texts: ; 0x4669a
    dw SeafoamIslands4Text1, SeafoamIslands4Text2, SeafoamIslands4Text3, SeafoamIslands4Text4, SeafoamIslands4Text5, SeafoamIslands4Text6

SeafoamIslands4Object: ; 0x466a6 (size=96)
    db $7d ; border tile

    db $7 ; warps
    db $c, $5, $1, SEAFOAM_ISLANDS_3
    db $6, $8, $2, SEAFOAM_ISLANDS_5
    db $4, $19, $3, SEAFOAM_ISLANDS_5
    db $3, $19, $4, SEAFOAM_ISLANDS_3
    db $e, $19, $6, SEAFOAM_ISLANDS_3
    db $11, $14, $0, SEAFOAM_ISLANDS_5
    db $11, $15, $1, SEAFOAM_ISLANDS_5

    db $0 ; signs

    db $6 ; people
    db SPRITE_BOULDER, $e + 4, $5 + 4, $ff, $10, $1 ; person
    db SPRITE_BOULDER, $f + 4, $3 + 4, $ff, $10, $2 ; person
    db SPRITE_BOULDER, $e + 4, $8 + 4, $ff, $10, $3 ; person
    db SPRITE_BOULDER, $e + 4, $9 + 4, $ff, $10, $4 ; person
    db SPRITE_BOULDER, $6 + 4, $12 + 4, $ff, $ff, $5 ; person
    db SPRITE_BOULDER, $6 + 4, $13 + 4, $ff, $ff, $6 ; person

    ; warp-to
    EVENT_DISP $f, $c, $5 ; SEAFOAM_ISLANDS_3
    EVENT_DISP $f, $6, $8 ; SEAFOAM_ISLANDS_5
    EVENT_DISP $f, $4, $19 ; SEAFOAM_ISLANDS_5
    EVENT_DISP $f, $3, $19 ; SEAFOAM_ISLANDS_3
    EVENT_DISP $f, $e, $19 ; SEAFOAM_ISLANDS_3
    EVENT_DISP $f, $11, $14 ; SEAFOAM_ISLANDS_5
    EVENT_DISP $f, $11, $15 ; SEAFOAM_ISLANDS_5

SeafoamIslands4Blocks: ; 135
    INCBIN "maps/seafoamislands4.blk"

SeafoamIslands5_h: ; 0x4678d to 0x46799 (12 bytes) (bank=11) (id=162)
    db $11 ; tileset
    db SEAFOAM_ISLANDS_5_HEIGHT, SEAFOAM_ISLANDS_5_WIDTH ; dimensions (y, x)
    dw SeafoamIslands5Blocks, SeafoamIslands5Texts, SeafoamIslands5Script ; blocks, texts, scripts
    db $00 ; connections

    dw SeafoamIslands5Object ; objects

SeafoamIslands5Script: ; 0x46799
    call $3c3c
    ld a, [$d668]
    ld hl, $67ad
    jp $3d97
; 0x467a5

INCBIN "baserom.gbc",$467a5,$467ad - $467a5

SeafoamIslands5Scripts: ; 0x467ad
    dw SeafoamIslands5Script0, SeafoamIslands5Script1

INCBIN "baserom.gbc",$467b1,$16

SeafoamIslands5Script0: ; 0x467c7
    ld a, [$d880]
    and $3
    cp $3
    ret z
    ld hl, $67fe
    call $34bf
    ret nc
    ld a, [$cd3d]
    cp $3
    jr nc, .asm_467e6 ; 0x467db $9
    ld a, $40
    ld [$ccd4], a
    ld a, $2
    jr .asm_467e8 ; 0x467e4 $2
.asm_467e6
    ld a, $1
.asm_467e8
    ld [$cd38], a
    ld a, $40
    ld [$ccd3], a
    call $3486
    ld hl, $d733
    res 2, [hl]
    ld a, $1
    ld [$d668], a
    ret
; 0x467fe

INCBIN "baserom.gbc",$467fe,$46807 - $467fe

SeafoamIslands5Script1: ; 0x46807
    ld a, [$cd38]
    and a
    ret nz
    xor a
    ld [$cd6b], a
    ld a, $0
    ld [$d668], a
    ret
; 0x46816

INCBIN "baserom.gbc",$46816,$66

SeafoamIslands5Texts: ; 0x4687c
    dw SeafoamIslands5Text1, SeafoamIslands5Text2, SeafoamIslands5Text3, SeafoamIslands5Text4, SeafoamIslands5Text5

INCBIN "baserom.gbc",$46886,$d

SeafoamIslands5Text3: ; 0x46893
    db $08 ; asm
    ld hl, $6886
    call LoadTrainerHeader
    ld a, $4
    ld [$d668], a
    jp $24d7

; 0x468a2 TX_FAR
db $17, $75, $40, $22
; 0x468a6
    db $8
    ld a, $4a
    call $13d0
    call $3748
    jp TextScriptEnd
; 0x468b2

SeafoamIslands5Text4: ; 0x468b2
    TX_FAR _SeafoamIslands5Text4
    db $50

SeafoamIslands5Text5: ; 0x468b7
    TX_FAR _SeafoamIslands5Text5
    db $50

SeafoamIslands5Object: ; 0x468bc (size=62)
    db $7d ; border tile

    db $4 ; warps
    db $11, $14, $5, SEAFOAM_ISLANDS_4
    db $11, $15, $6, SEAFOAM_ISLANDS_4
    db $7, $b, $1, SEAFOAM_ISLANDS_4
    db $4, $19, $2, SEAFOAM_ISLANDS_4

    db $2 ; signs
    db $f, $9, $4 ; SeafoamIslands5Text4
    db $1, $17, $5 ; SeafoamIslands5Text5

    db $3 ; people
    db SPRITE_BOULDER, $f + 4, $4 + 4, $ff, $ff, $1 ; person
    db SPRITE_BOULDER, $f + 4, $5 + 4, $ff, $ff, $2 ; person
    db SPRITE_BIRD, $1 + 4, $6 + 4, $ff, $d0, $43, ARTICUNO, $32 ; trainer

    ; warp-to
    EVENT_DISP $f, $11, $14 ; SEAFOAM_ISLANDS_4
    EVENT_DISP $f, $11, $15 ; SEAFOAM_ISLANDS_4
    EVENT_DISP $f, $7, $b ; SEAFOAM_ISLANDS_4
    EVENT_DISP $f, $4, $19 ; SEAFOAM_ISLANDS_4

SeafoamIslands5Blocks: ; 135
    INCBIN "maps/seafoamislands5.blk"

INCBIN "baserom.gbc",$46981,$167f

SECTION "bank12",DATA,BANK[$12]

Route7_h: ; 0x48000 to 0x48022 (34 bytes) (bank=12) (id=18)
    db $00 ; tileset
    db ROUTE_7_HEIGHT, ROUTE_7_WIDTH ; dimensions (y, x)
    dw Route7Blocks, $4155, Route7Script ; blocks, texts, scripts
    db WEST | EAST ; connections

    ; connections data

	db CELADON_CITY
    dw CeladonCityBlocks - 3 + (CELADON_CITY_WIDTH * 2) ; connection strip location
    dw $C6E8 + (ROUTE_7_WIDTH + 6) * (-3 + 3) ; current map position
    db $f, CELADON_CITY_WIDTH ; bigness, width
    db (-4 * -2), (CELADON_CITY_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * CELADON_CITY_WIDTH ; window

	db SAFFRON_CITY
    dw SaffronCityBlocks + (SAFFRON_CITY_WIDTH) ; connection strip location
    dw $C6E5 + (ROUTE_7_WIDTH + 6) * (-3 + 4) ; current map position
    db $f, SAFFRON_CITY_WIDTH ; bigness, width
    db (-4 * -2), 0 ; alignments (y, x)
    dw $C6EF + SAFFRON_CITY_WIDTH ; window

    ; end connections data

    dw Route7Object ; objects

Route7Object: ; 0x48022 (size=47)
    db $f ; border tile

    db $5 ; warps
    db $9, $12, $2, ROUTE_7_GATE
    db $a, $12, $3, ROUTE_7_GATE
    db $9, $b, $0, ROUTE_7_GATE
    db $a, $b, $1, ROUTE_7_GATE
    db $d, $5, $0, PATH_ENTRANCE_ROUTE_7

    db $1 ; signs
    db $d, $3, $1 ; Route7Text1

    db $0 ; people

    ; warp-to
    EVENT_DISP $a, $9, $12 ; ROUTE_7_GATE
    EVENT_DISP $a, $a, $12 ; ROUTE_7_GATE
    EVENT_DISP $a, $9, $b ; ROUTE_7_GATE
    EVENT_DISP $a, $a, $b ; ROUTE_7_GATE
    EVENT_DISP $a, $d, $5 ; PATH_ENTRANCE_ROUTE_7

Route7Blocks: ; 90
    INCBIN "maps/route7.blk"

CeladonPokecenterBlocks:
RockTunnelPokecenterBlocks:
MtMoonPokecenterBlocks: ; 28
    INCBIN "maps/mtmoonpokecenter.blk"

Route18GateBlocks:
Route15GateBlocks:
Route11GateBlocks: ; 20
    INCBIN "maps/route11gate.blk"

Route18GateHeaderBlocks:
Route16GateUpstairsBlocks:
Route12GateUpstairsBlocks:
Route11GateUpstairsBlocks: ; 16 40db
    INCBIN "maps/route11gateupstairs.blk"

INCBIN "baserom.gbc",$480eb,$48152 - $480eb

Route7Script: ; 0x48152
    jp $3c3c
; 0x48155

INCBIN "baserom.gbc",$48155,$2

Route7Text1: ; 0x48157
    TX_FAR _Route7Text1
    db $50

RedsHouse1F_h: ; 415C
	db $01 ; tileset
	db $04,$04 ; dimensions
	dw RedsHouse1FBlocks, RedsHouse1FTexts, RedsHouse1FScript
	db 0 ; no connections
	dw RedsHouse1FObject

RedsHouse1FScript: ; 4168
	jp $3C3C

RedsHouse1FTexts: ; 416B
	dw RedsHouse1FText1,RedsHouse1FText2

RedsHouse1FText1: ; Mom
	db 8
	ld a,[$D72E]
	bit 3,a
	jr nz,.heal\@ ; if player has received a Pokémon from Oak, heal team
	ld hl,MomWakeUpText
	call PrintText
	jr .done\@
.heal\@
	call MomHealPokemon
.done\@
	jp $24D7

MomWakeUpText:
	TX_FAR _MomWakeUpText
	db "@"

MomHealPokemon:
	ld hl,MomHealText1
	call PrintText
	call GBFadeOut2
	call $3071
	ld a,7
	call Predef
	ld a,$E8
	ld [$C0EE],a
	call $23B1 ; play sound?
.next\@
	ld a,[$C026]
	cp $E8
	jr z,.next\@
	ld a,[$D35B]
	ld [$C0EE],a
	call $23B1
	call GBFadeIn2
	ld hl,MomHealText2
	jp PrintText

MomHealText1:
	TX_FAR _MomHealText1
	db "@"
MomHealText2:
	TX_FAR _MomHealText2
	db "@"

RedsHouse1FText2: ; TV
	db 8
	ld a,[$C109]
	cp 4
	ld hl,TVWrongSideText
	jr nz,.done\@ ; if player is not facing up
	ld hl,StandByMeText
.done\@
	call PrintText
	jp $24D7

StandByMeText:
	TX_FAR _StandByMeText
	db "@"

TVWrongSideText:
	TX_FAR _TVWrongSideText
	db "@"

RedsHouse1FObject:
	db $0A ; border tile

	db 3 ; warps
	db 7,2,0,$FF ; exit1
	db 7,3,0,$FF ; exit2
	db 1,7,0,$26 ; staircase

	db 1 ; signs
	db 1,3,2 ; TV

	db 1 ; people
	db $33,4+4,5+4,$FF,$D2,1 ; Mom

	; warp-to

	dw $C6EF + 4 + (4 + 6) * (3) + 1
	db 7,2

	dw $C6EF + 4 + (4 + 6) * (3) + 1
	db 7,3

	dw $C6EF + 4 + (4 + 6) * (0) + 3
	db 1,7

RedsHouse1FBlocks:
	INCBIN "maps/redshouse1f.blk"

CeladonMart3_h: ; 0x48219 to 0x48225 (12 bytes) (bank=12) (id=124)
    db $12 ; tileset
    db CELADON_MART_3_HEIGHT, CELADON_MART_3_WIDTH ; dimensions (y, x)
    dw CeladonMart3Blocks, CeladonMart3Texts, CeladonMart3Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMart3Object ; objects

CeladonMart3Script: ; 0x48225
    jp $3c3c
; 0x48228

CeladonMart3Texts: ; 0x48228
    dw CeladonMart3Text1, CeladonMart3Text2, CeladonMart3Text3, CeladonMart3Text4, CeladonMart3Text5, CeladonMart3Text6, CeladonMart3Text7, CeladonMart3Text8, CeladonMart3Text9, CeladonMart3Text10, CeladonMart3Text11, CeladonMart3Text12, CeladonMart3Text13, CeladonMart3Text14, CeladonMart3Text15, CeladonMart3Text16, CeladonMart3Text17

CeladonMart3Text1: ; 0x4824a
    db $08 ; asm
    ld a, [$d778]
    bit 7, a
    jr nz, .asm_a5463 ; 0x48250
    ld hl, $4278
    call PrintText
    ld bc,(TM_18 << 8) | 1
    call $3e2e
    jr nc, .asm_95f37 ; 0x4825e
    ld hl, $d778
    set 7, [hl]
    ld hl, $427d
    jr .asm_81359 ; 0x48268
.asm_95f37 ; 0x4826a
    ld hl, $4288
    jr .asm_81359 ; 0x4826d
.asm_a5463 ; 0x4826f
    ld hl, $4283
.asm_81359 ; 0x48272
    call PrintText
    jp $24d7

UnnamedText_48278: ; 0x48278
    TX_FAR _UnnamedText_48278
    db $50
; 0x48278 + 5 bytes

INCBIN "baserom.gbc",$4827d,$48283 - $4827d

UnnamedText_48283: ; 0x48283
    TX_FAR _UnnamedText_48283
    db $50
; 0x48283 + 5 bytes

UnnamedText_48288: ; 0x48288
    TX_FAR _UnnamedText_48288
    db $50
; 0x48288 + 5 bytes

CeladonMart3Text2: ; 0x4828d
    TX_FAR _CeladonMart3Text2
    db $50

CeladonMart3Text3: ; 0x48292
    TX_FAR _CeladonMart3Text3
    db $50

CeladonMart3Text4: ; 0x48297
    TX_FAR _CeladonMart3Text4
    db $50

CeladonMart3Text5: ; 0x4829c
    TX_FAR _CeladonMart3Text5
    db $50

CeladonMart3Text12
CeladonMart3Text10:
CeladonMart3Text8:
CeladonMart3Text6: ; 0x482a1
    TX_FAR _CeladonMart3Text6
    db $50

CeladonMart3Text7: ; 0x482a6
    TX_FAR _CeladonMart3Text7
    db $50

CeladonMart3Text9: ; 0x482ab
    TX_FAR _CeladonMart3Text9
    db $50

CeladonMart3Text11: ; 0x482b0
    TX_FAR _CeladonMart3Text11
    db $50

CeladonMart3Text13: ; 0x482b5
    TX_FAR _CeladonMart3Text13
    db $50

CeladonMart3Text14: ; 0x482ba
    TX_FAR _CeladonMart3Text14
    db $50

CeladonMart3Text17:
CeladonMart3Text16:
CeladonMart3Text15: ; 0x482bf
    TX_FAR _CeladonMart3Text15
    db $50

CeladonMart3Object: ; 0x482c4 (size=94)
    db $f ; border tile

    db $3 ; warps
    db $1, $c, $0, CELADON_MART_4
    db $1, $10, $1, CELADON_MART_2
    db $1, $1, $0, CELADON_MART_ELEVATOR

    db $c ; signs
    db $4, $2, $6 ; CeladonMart3Text6
    db $4, $3, $7 ; CeladonMart3Text7
    db $4, $5, $8 ; CeladonMart3Text8
    db $4, $6, $9 ; CeladonMart3Text9
    db $6, $2, $a ; CeladonMart3Text10
    db $6, $3, $b ; CeladonMart3Text11
    db $6, $5, $c ; CeladonMart3Text12
    db $6, $6, $d ; CeladonMart3Text13
    db $1, $e, $e ; CeladonMart3Text14
    db $1, $4, $f ; CeladonMart3Text15
    db $1, $6, $10 ; CeladonMart3Text16
    db $1, $a, $11 ; CeladonMart3Text17

    db $5 ; people
    db SPRITE_MART_GUY, $5 + 4, $10 + 4, $ff, $ff, $1 ; person
    db SPRITE_GAMEBOY_KID_COPY, $6 + 4, $b + 4, $ff, $d3, $2 ; person
    db SPRITE_GAMEBOY_KID_COPY, $2 + 4, $7 + 4, $ff, $d0, $3 ; person
    db SPRITE_GAMEBOY_KID_COPY, $2 + 4, $8 + 4, $ff, $d0, $4 ; person
    db SPRITE_YOUNG_BOY, $5 + 4, $2 + 4, $ff, $d1, $5 ; person

    ; warp-to
    EVENT_DISP $a, $1, $c ; CELADON_MART_4
    EVENT_DISP $a, $1, $10 ; CELADON_MART_2
    EVENT_DISP $a, $1, $1 ; CELADON_MART_ELEVATOR

CeladonMart3Blocks: ; 40
    INCBIN "maps/celadonmart3.blk"

CeladonMart4_h: ; 0x4834a to 0x48356 (12 bytes) (bank=12) (id=125)
    db $12 ; tileset
    db CELADON_MART_4_HEIGHT, CELADON_MART_4_WIDTH ; dimensions (y, x)
    dw CeladonMart4Blocks, CeladonMart4Texts, CeladonMart4Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMart4Object ; objects

CeladonMart4Script: ; 0x48356
    jp $3c3c
; 0x48359

CeladonMart4Texts: ; 0x48359
    dw CeladonMart4Text1, CeladonMart4Text2, CeladonMart4Text3, CeladonMart4Text4

CeladonMart4Text2: ; 0x48361
    TX_FAR _CeladonMart4Text2
    db $50

CeladonMart4Text3: ; 0x48366
    TX_FAR _CeladonMart4Text3
    db $50

CeladonMart4Text4: ; 0x4836b
    TX_FAR _CeladonMart4Text4
    db $50

CeladonMart4Object: ; 0x48370 (size=49)
    db $f ; border tile

    db $3 ; warps
    db $1, $c, $0, CELADON_MART_3
    db $1, $10, $1, CELADON_MART_5
    db $1, $1, $0, CELADON_MART_ELEVATOR

    db $1 ; signs
    db $1, $e, $4 ; CeladonMart4Text4

    db $3 ; people
    db SPRITE_MART_GUY, $7 + 4, $5 + 4, $ff, $ff, $1 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $5 + 4, $f + 4, $fe, $2, $2 ; person
    db SPRITE_BUG_CATCHER, $2 + 4, $5 + 4, $fe, $2, $3 ; person

    ; warp-to
    EVENT_DISP $a, $1, $c ; CELADON_MART_3
    EVENT_DISP $a, $1, $10 ; CELADON_MART_5
    EVENT_DISP $a, $1, $1 ; CELADON_MART_ELEVATOR

CeladonMart4Blocks: ; 40
    INCBIN "maps/celadonmart4.blk"

CeladonMartRoof_h: ; 0x483c9 to 0x483d5 (12 bytes) (bank=12) (id=126)
    db $12 ; tileset
    db CELADON_MART_5_HEIGHT, CELADON_MART_5_WIDTH ; dimensions (y, x)
    dw CeladonMartRoofBlocks, CeladonMartRoofTexts, CeladonMartRoofScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMartRoofObject ; objects

CeladonMartRoofScript: ; 0x483d5
    jp $3c3c
; 0x483d8

INCBIN "baserom.gbc",$483d8,$484ee - $483d8

UnnamedText_484ee: ; 0x484ee
    TX_FAR _UnnamedText_484ee
    db $50
; 0x484ee + 5 bytes

INCBIN "baserom.gbc",$484f3,$68

CeladonMartRoofTexts: ; 0x4855b
    dw CeladonMartRoofText1, CeladonMartRoofText2, CeladonMartRoofText5, CeladonMartRoofText5, CeladonMartRoofText5, CeladonMartRoofText6

CeladonMartRoofText1: ; 0x48567
    TX_FAR _CeladonMartRoofText1
    db $50

CeladonMartRoofText2: ; 0x4856c
    db $08 ; asm
    call $43d8
    ld a, [$cd37]
    and a
    jr z, .asm_914b9 ; 0x48574
    ld a, $1
    ld [$cc3c], a
    ld hl, $459d
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, .asm_05aa4 ; 0x48588
    call $440c
    jr .asm_05aa4 ; 0x4858d
.asm_914b9 ; 0x4858f
    ld hl, $4598
    call PrintText
.asm_05aa4 ; 0x48595
    jp $24d7

CeladonMartRoofText3:

UnnamedText_48598: ; 0x48598
    TX_FAR _UnnamedText_48598
    db $50
; 0x48598 + 5 bytes

CeladonMartRoofText4:

UnnamedText_4859d: ; 0x4859d
    TX_FAR _UnnamedText_4859d
    db $50
; 0x4859d + 5 bytes

CeladonMartRoofText5: ; 0x485a2
    db $f5

CeladonMartRoofText6: ; 0x485a3
    TX_FAR _CeladonMartRoofText6
    db $50

CeladonMartRoofObject: ; 0x485a8 (size=36)
    db $42 ; border tile

    db $1 ; warps
    db $2, $f, $0, CELADON_MART_5

    db $4 ; signs
    db $1, $a, $3 ; CeladonMartRoofText3
    db $1, $b, $4 ; CeladonMartRoofText4
    db $2, $c, $5 ; CeladonMartRoofText5
    db $2, $d, $6 ; CeladonMartRoofText6

    db $2 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $4 + 4, $a + 4, $ff, $d2, $1 ; person
    db SPRITE_LITTLE_GIRL, $5 + 4, $5 + 4, $fe, $0, $2 ; person

    ; warp-to
    EVENT_DISP $a, $2, $f ; CELADON_MART_5

CeladonMartRoofBlocks: ; 40
    INCBIN "maps/celadonmart5.blk"

CeladonMartElevator_h: ; 0x485f4 to 0x48600 (12 bytes) (bank=12) (id=127)
    db $12 ; tileset
    db CELADON_MART_6_HEIGHT, CELADON_MART_6_WIDTH ; dimensions (y, x)
    dw CeladonMartElevatorBlocks, CeladonMartElevatorTexts, CeladonMartElevatorScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMartElevatorObject ; objects

CeladonMartElevatorScript: ; 0x48600
    ld hl, $d126
    bit 5, [hl]
    res 5, [hl]
    push hl
    call nz, $461c
    pop hl
    bit 7, [hl]
    res 7, [hl]
    call nz, $4654
    xor a
    ld [$cf0c], a
    inc a
    ld [$cc3c], a
    ret
; 0x4861c

INCBIN "baserom.gbc",$4861c,$40

CeladonMartElevatorTexts: ; 0x4865c
    dw CeladonMartElevatorText1

CeladonMartElevatorText1: ; 0x4865e
    db $08 ; asm
    call $4631
    ld hl, $464a
    ld a, $61
    call Predef
    jp $24d7

CeladonMartElevatorObject: ; 0x4866d (size=23)
    db $f ; border tile

    db $2 ; warps
    db $3, $1, $5, CELADON_MART_1
    db $3, $2, $5, CELADON_MART_1

    db $1 ; signs
    db $0, $3, $1 ; CeladonMartElevatorText1

    db $0 ; people

    ; warp-to
    EVENT_DISP $2, $3, $1 ; CELADON_MART_1
    EVENT_DISP $2, $3, $2 ; CELADON_MART_1

CeladonMartElevatorBlocks: ; 4
    INCBIN "maps/celadonmart6.blk"

CeladonMansion1_h: ; 0x48688 to 0x48694 (12 bytes) (bank=12) (id=128)
    db $13 ; tileset
    db CELADON_MANSION_1_HEIGHT, CELADON_MANSION_1_WIDTH ; dimensions (y, x)
    dw CeladonMansion1Blocks, CeladonMansion1Texts, CeladonMansion1Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMansion1Object ; objects

CeladonMansion1Script: ; 0x48694
    jp $3c3c
; 0x48697

CeladonMansion1Texts: ; 0x48697
    dw CeladonMansion1Text1, CeladonMansion1Text2, CeladonMansion1Text3, CeladonMansion1Text4, CeladonMansion1Text5

;0x486a1
    call $13d0
    jp TextScriptEnd
; 0x486a7

CeladonMansion1Text1: ; 0x486a7
    TX_FAR _CeladonMansion1Text1
    db $08 ; asm
    ld a, $4d
    jp $46a1

CeladonMansion1Text2: ; 0x486b1
    TX_FAR _CeladonMansion1Text2
    db $50

CeladonMansion1Text3: ; 0x486b6
    TX_FAR _CeladonMansion1Text3
    db $8
    ld a, $4
    jp $46a1
; 0x486c0

CeladonMansion1Text4: ; 0x486c0
    TX_FAR _CeladonMansion1Text4
    db $8
    ld a, $f
    jp $46a1
; 0x486ca

CeladonMansion1Text5: ; 0x486ca
    TX_FAR _CeladonMansion1Text5
    db $50

CeladonMansion1Object: ; 0x486cf (size=71)
    db $f ; border tile

    db $5 ; warps
    db $b, $4, $2, $ff
    db $b, $5, $2, $ff
    db $0, $4, $4, $ff
    db $1, $7, $1, CELADON_MANSION_2
    db $1, $2, $2, CELADON_MANSION_2

    db $1 ; signs
    db $9, $4, $5 ; CeladonMansion1Text5

    db $4 ; people
    db SPRITE_SLOWBRO, $5 + 4, $0 + 4, $ff, $d3, $1 ; person
    db SPRITE_OLD_MEDIUM_WOMAN, $5 + 4, $1 + 4, $ff, $d0, $2 ; person
    db SPRITE_CLEFAIRY, $8 + 4, $1 + 4, $fe, $2, $3 ; person
    db SPRITE_SLOWBRO, $4 + 4, $4 + 4, $fe, $1, $4 ; person

    ; warp-to
    EVENT_DISP $4, $b, $4
    EVENT_DISP $4, $b, $5
    EVENT_DISP $4, $0, $4
    EVENT_DISP $4, $1, $7 ; CELADON_MANSION_2
    EVENT_DISP $4, $1, $2 ; CELADON_MANSION_2

CeladonMansion1Blocks: ; 24
    INCBIN "maps/celadonmansion1.blk"

CeladonMansion2_h: ; 0x4872e to 0x4873a (12 bytes) (bank=12) (id=129)
    db $13 ; tileset
    db CELADON_MANSION_2_HEIGHT, CELADON_MANSION_2_WIDTH ; dimensions (y, x)
    dw CeladonMansion2Blocks, CeladonMansion2Texts, CeladonMansion2Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMansion2Object ; objects

CeladonMansion2Script: ; 0x4873a
    call $3c3c
    ret
; 0x4873e

CeladonMansion2Texts: ; 0x4873e
    dw CeladonMansion2Text1

CeladonMansion2Text1: ; 0x48740
    TX_FAR _CeladonMansion2Text1
    db $50

CeladonMansion2Object: ; 0x48745 (size=39)
    db $f ; border tile

    db $4 ; warps
    db $1, $6, $0, CELADON_MANSION_3
    db $1, $7, $3, CELADON_MANSION_1
    db $1, $2, $4, CELADON_MANSION_1
    db $1, $4, $3, CELADON_MANSION_3

    db $1 ; signs
    db $9, $4, $1 ; CeladonMansion2Text1

    db $0 ; people

    ; warp-to
    EVENT_DISP $4, $1, $6 ; CELADON_MANSION_3
    EVENT_DISP $4, $1, $7 ; CELADON_MANSION_1
    EVENT_DISP $4, $1, $2 ; CELADON_MANSION_1
    EVENT_DISP $4, $1, $4 ; CELADON_MANSION_3

CeladonMansion2Blocks: ; 24
    INCBIN "maps/celadonmansion2.blk"

CeladonMansion3_h: ; 0x48784 to 0x48790 (12 bytes) (bank=12) (id=130)
    db $13 ; tileset
    db CELADON_MANSION_3_HEIGHT, CELADON_MANSION_3_WIDTH ; dimensions (y, x)
    dw CeladonMansion3Blocks, CeladonMansion3Texts, CeladonMansion3Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMansion3Object ; objects

CeladonMansion3Script: ; 0x48790
    jp $3c3c
; 0x48793

CeladonMansion3Texts: ; 0x48793
    dw CeladonMansion3Text1, CeladonMansion3Text2, CeladonMansion3Text3, CeladonMansion3Text4, CeladonMansion3Text5, CeladonMansion3Text6, CeladonMansion3Text7, CeladonMansion3Text8

CeladonMansion3Text1: ; 0x487a3
    TX_FAR _CeladonMansion3Text1
    db $50

CeladonMansion3Text2: ; 0x487a8
    TX_FAR _CeladonMansion3Text2
    db $50

CeladonMansion3Text3: ; 0x487ad
    TX_FAR _CeladonMansion3Text3
    db $50

CeladonMansion3Text4: ; 0x487b2
    db $08 ; asm
    ld hl, $d2f7
    ld b, $13
    call $2b7f
    ld a, [$d11e]
    cp $96
    jr nc, .asm_f03d0 ; 0x487c0
    ld hl, $47d0
    jr .asm_c13f0 ; 0x487c5
.asm_f03d0 ; 0x487c7
    ld hl, $47d5
.asm_c13f0 ; 0x487ca
    call PrintText
    jp $24d7

UnnamedText_487d0: ; 0x487d0
    TX_FAR _UnnamedText_487d0
    db $50
; 0x487d0 + 5 bytes

INCBIN "baserom.gbc",$487d5,$16

CeladonMansion3Text5: ; 0x487eb
    TX_FAR _CeladonMansion3Text5
    db $50

CeladonMansion3Text6: ; 0x487f0
    TX_FAR _CeladonMansion3Text6
    db $50

CeladonMansion3Text7: ; 0x487f5
    TX_FAR _CeladonMansion3Text7
    db $50

CeladonMansion3Text8: ; 0x487fa
    TX_FAR _CeladonMansion3Text8
    db $50

CeladonMansion3Object: ; 0x487ff (size=72)
    db $f ; border tile

    db $4 ; warps
    db $1, $6, $0, CELADON_MANSION_2
    db $1, $7, $0, CELADON_MANSION_4
    db $1, $2, $1, CELADON_MANSION_4
    db $1, $4, $3, CELADON_MANSION_2

    db $4 ; signs
    db $3, $1, $5 ; CeladonMansion3Text5
    db $3, $4, $6 ; CeladonMansion3Text6
    db $6, $1, $7 ; CeladonMansion3Text7
    db $9, $4, $8 ; CeladonMansion3Text8

    db $4 ; people
    db SPRITE_BIKE_SHOP_GUY, $4 + 4, $0 + 4, $ff, $d1, $1 ; person
    db SPRITE_MART_GUY, $4 + 4, $3 + 4, $ff, $d1, $2 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $7 + 4, $0 + 4, $ff, $d1, $3 ; person
    db SPRITE_LAPRAS_GIVER, $3 + 4, $2 + 4, $ff, $ff, $4 ; person

    ; warp-to
    EVENT_DISP $4, $1, $6 ; CELADON_MANSION_2
    EVENT_DISP $4, $1, $7 ; CELADON_MANSION_4
    EVENT_DISP $4, $1, $2 ; CELADON_MANSION_4
    EVENT_DISP $4, $1, $4 ; CELADON_MANSION_2

CeladonMansion3Blocks: ; 24
    INCBIN "maps/celadonmansion3.blk"

CeladonMansion4_h: ; 0x4885f to 0x4886b (12 bytes) (bank=12) (id=131)
    db $13 ; tileset
    db CELADON_MANSION_4_HEIGHT, CELADON_MANSION_4_WIDTH ; dimensions (y, x)
    dw CeladonMansion4Blocks, CeladonMansion4Texts, CeladonMansion4Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMansion4Object ; objects

CeladonMansion4Script: ; 0x4886b
    jp $3c3c
; 0x4886e

CeladonMansion4Texts: ; 0x4886e
    dw CeladonMansion4Text1

CeladonMansion4Text1: ; 0x48870
    TX_FAR _CeladonMansion4Text1
    db $50

CeladonMansion4Object: ; 0x48875 (size=31)
    db $9 ; border tile

    db $3 ; warps
    db $1, $6, $1, CELADON_MANSION_3
    db $1, $2, $2, CELADON_MANSION_3
    db $7, $2, $0, CELADON_MANSION_5

    db $1 ; signs
    db $7, $3, $1 ; CeladonMansion4Text1

    db $0 ; people

    ; warp-to
    EVENT_DISP $4, $1, $6 ; CELADON_MANSION_3
    EVENT_DISP $4, $1, $2 ; CELADON_MANSION_3
    EVENT_DISP $4, $7, $2 ; CELADON_MANSION_5

CeladonMansion4Blocks: ; 24
    INCBIN "maps/celadonmansion4.blk"

CeladonPokecenter_h: ; 0x488ac to 0x488b8 (12 bytes) (bank=12) (id=133)
    db $06 ; tileset
    db CELADON_POKECENTER_HEIGHT, CELADON_POKECENTER_WIDTH ; dimensions (y, x)
    dw CeladonPokecenterBlocks, CeladonPokecenterTexts, CeladonPokecenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonPokecenterObject ; objects

CeladonPokecenterScript: ; 0x488b8
    call $22fa
    jp $3c3c
; 0x488be

CeladonPokecenterTexts:
    dw CeladonPokecenterText1, CeladonPokecenterText2, CeladonPokecenterText3, CeladonPokecenterText4

CeladonPokecenterText4:
    db $f6

CeladonPokecenterText1:
    db $ff

CeladonPokecenterText2: ; 0x488c8
    TX_FAR _CeladonPokecenterText2
    db $50

CeladonPokecenterText3: ; 0x488cd
    TX_FAR _CeladonPokecenterText3
    db $50

CeladonPokecenterObject: ; 0x488d2 (size=44)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $5, $ff
    db $7, $4, $5, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_GENTLEMAN, $3 + 4, $7 + 4, $fe, $2, $2 ; person
    db SPRITE_FOULARD_WOMAN, $5 + 4, $a + 4, $fe, $0, $3 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

CeladonGym_h: ; 0x488fe to 0x4890a (12 bytes) (bank=12) (id=134)
    db $07 ; tileset
    db CELADON_GYM_HEIGHT, CELADON_GYM_WIDTH ; dimensions (y, x)
    dw CeladonGymBlocks, CeladonGymTexts, CeladonGymScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonGymObject ; objects

CeladonGymScript: ; 0x4890a
    ld hl, $d126
    bit 6, [hl]
    res 6, [hl]
    call nz, $4927
    call $3c3c
    ld hl, $49bc
    ld de, $494e
    ld a, [$d5ff]
    call $3160
    ld [$d5ff], a
    ret
; 0x48927

INCBIN "baserom.gbc",$48927,$7f

CeladonGymTexts: ; 0x489a6
    dw CeladonGymText1, CeladonGymText2, CeladonGymText3, CeladonGymText4, CeladonGymText5, CeladonGymText6, CeladonGymText7, CeladonGymText8, CeladonGymText9, CeladonGymText10, CeladonGymText11

INCBIN "baserom.gbc",$489bc,$55

CeladonGymText1: ; 0x48a11
    db $08 ; asm
    ld a, [$d77c]
    bit 1, a
    jr z, .asm_16064 ; 0x48a17
    bit 0, a
    jr nz, .asm_3b22c ; 0x48a1b
    call z, $4963
    call $30b6
    jr .asm_96252 ; 0x48a23
.asm_3b22c ; 0x48a25
    ld hl, $4a68
    call PrintText
    jr .asm_96252 ; 0x48a2b
.asm_16064 ; 0x48a2d
    ld hl, $4a5e
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $4a63
    ld de, $4a63
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    ld a, $4
    ld [$d05c], a
    ld a, $3
    ld [$d5ff], a
    ld [$da39], a
.asm_96252 ; 0x48a5b
    jp $24d7

UnnamedText_48a5e: ; 0x48a5e
    TX_FAR _UnnamedText_48a5e
    db $50
; 0x48a5e + 5 bytes

UnnamedText_48a63: ; 0x48a63
    TX_FAR _UnnamedText_48a63
    db $50
; 0x48a63 + 5 bytes

UnnamedText_48a68: ; 0x48a68
    TX_FAR _UnnamedText_48a68
    db $50
; 0x48a68 + 5 bytes

CeladonGymText9: ; 0x48a6d
UnnamedText_48a6d: ; 0x48a6d
    TX_FAR _UnnamedText_48a6d
    db $50
; 0x48a6d + 5 bytes

CeladonGymText10: ; 0x48a72
INCBIN "baserom.gbc",$48a72,$4
db $0b

UnnamedText_48a77: ; 0x48a77
    TX_FAR _UnnamedText_48a77
    db $50
; 0x48a77 + 5 bytes

CeladonGymText11: ; 0x48a7c
    TX_FAR _UnnamedText_48a7c
    db $50
; 0x48a7c + 5 bytes

CeladonGymText2: ; 0x48a81
    db $08 ; asm
    ld hl, $49bc
    call LoadTrainerHeader
    jp $24d7

UnnamedText_48a8b: ; 0x48a8b
    TX_FAR _UnnamedText_48a8b
    db $50
; 0x48a8b + 5 bytes

UnnamedText_48a90: ; 0x48a90
    TX_FAR _UnnamedText_48a90
    db $50
; 0x48a90 + 5 bytes

UnnamedText_48a95: ; 0x48a95
    TX_FAR _UnnamedText_48a95
    db $50
; 0x48a95 + 5 bytes

CeladonGymText3: ; 0x48a9a
    db $08 ; asm
    ld hl, $49c8
    call LoadTrainerHeader
    jp $24d7

UnnamedText_48aa4: ; 0x48aa4
    TX_FAR _UnnamedText_48aa4
    db $50
; 0x48aa4 + 5 bytes

UnnamedText_48aa9: ; 0x48aa9
    TX_FAR _UnnamedText_48aa9
    db $50
; 0x48aa9 + 5 bytes

UnnamedText_48aae: ; 0x48aae
    TX_FAR _UnnamedText_48aae
    db $50
; 0x48aae + 5 bytes

CeladonGymText4: ; 0x48ab3
    db $08 ; asm
    ld hl, $49d4
    call LoadTrainerHeader
    jp $24d7

UnnamedText_48abd: ; 0x48abd
    TX_FAR _UnnamedText_48abd
    db $50
; 0x48abd + 5 bytes

UnnamedText_48ac2: ; 0x48ac2
    TX_FAR _UnnamedText_48ac2
    db $50
; 0x48ac2 + 5 bytes

UnnamedText_48ac7: ; 0x48ac7
    TX_FAR _UnnamedText_48ac7
    db $50
; 0x48ac7 + 5 bytes

CeladonGymText5: ; 0x48acc
    db $08 ; asm
    ld hl, $49e0
    call LoadTrainerHeader
    jp $24d7

UnnamedText_48ad6: ; 0x48ad6
    TX_FAR _UnnamedText_48ad6
    db $50
; 0x48ad6 + 5 bytes

UnnamedText_48adb: ; 0x48adb
    TX_FAR _UnnamedText_48adb
    db $50
; 0x48adb + 5 bytes

UnnamedText_48ae0: ; 0x48ae0
    TX_FAR _UnnamedText_48ae0
    db $50
; 0x48ae0 + 5 bytes

CeladonGymText6: ; 0x48ae5
    db $08 ; asm
    ld hl, $49ec
    call LoadTrainerHeader
    jp $24d7

UnnamedText_48aef: ; 0x48aef
    TX_FAR _UnnamedText_48aef
    db $50
; 0x48aef + 5 bytes

UnnamedText_48af4: ; 0x48af4
    TX_FAR _UnnamedText_48af4
    db $50
; 0x48af4 + 5 bytes

UnnamedText_48af9: ; 0x48af9
    TX_FAR _UnnamedText_48af9
    db $50
; 0x48af9 + 5 bytes

CeladonGymText7: ; 0x48afe
    db $08 ; asm
    ld hl, $49f8
    call LoadTrainerHeader
    jp $24d7

UnnamedText_48b08: ; 0x48b08
    TX_FAR _UnnamedText_48b08
    db $50
; 0x48b08 + 5 bytes

UnnamedText_48b0d: ; 0x48b0d
    TX_FAR _UnnamedText_48b0d
    db $50
; 0x48b0d + 5 bytes

UnnamedText_48b12: ; 0x48b12
    TX_FAR _UnnamedText_48b12
    db $50
; 0x48b12 + 5 bytes

CeladonGymText8: ; 0x48b17
    db $08 ; asm
    ld hl, $4a04
    call LoadTrainerHeader
    jp $24d7

UnnamedText_48b21: ; 0x48b21
    TX_FAR _UnnamedText_48b21
    db $50
; 0x48b21 + 5 bytes

UnnamedText_48b26: ; 0x48b26
    TX_FAR _UnnamedText_48b26
    db $50
; 0x48b26 + 5 bytes

UnnamedText_48b2b: ; 0x48b2b
    TX_FAR _UnnamedText_48b2b
    db $50
; 0x48b2b + 5 bytes

CeladonGymObject: ; 0x48b30 (size=84)
    db $3 ; border tile

    db $2 ; warps
    db $11, $4, $6, $ff
    db $11, $5, $6, $ff

    db $0 ; signs

    db $8 ; people
    db SPRITE_ERIKA, $3 + 4, $4 + 4, $ff, $d0, $41, ERIKA + $C8, $1 ; trainer
    db SPRITE_LASS, $b + 4, $2 + 4, $ff, $d3, $42, LASS + $C8, $11 ; trainer
    db SPRITE_FOULARD_WOMAN, $a + 4, $7 + 4, $ff, $d2, $43, BEAUTY + $C8, $1 ; trainer
    db SPRITE_LASS, $5 + 4, $9 + 4, $ff, $d0, $44, JR__TRAINER_F + $C8, $b ; trainer
    db SPRITE_FOULARD_WOMAN, $5 + 4, $1 + 4, $ff, $d0, $45, BEAUTY + $C8, $2 ; trainer
    db SPRITE_LASS, $3 + 4, $6 + 4, $ff, $d0, $46, LASS + $C8, $12 ; trainer
    db SPRITE_FOULARD_WOMAN, $3 + 4, $3 + 4, $ff, $d0, $47, BEAUTY + $C8, $3 ; trainer
    db SPRITE_LASS, $3 + 4, $5 + 4, $ff, $d0, $48, COOLTRAINER_F + $C8, $1 ; trainer

    ; warp-to
    EVENT_DISP $5, $11, $4
    EVENT_DISP $5, $11, $5

CeladonGymBlocks: ; 45
    INCBIN "maps/celadongym.blk"

CeladonGameCorner_h: ; 0x48bb1 to 0x48bbd (12 bytes) (bank=12) (id=135)
    db $12 ; tileset
    db GAME_CORNER_HEIGHT, GAME_CORNER_WIDTH ; dimensions (y, x)
    dw CeladonGameCornerBlocks, CeladonGameCornerTexts, CeladonGameCornerScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonGameCornerObject ; objects

CeladonGameCornerScript: ; 0x48bbd
    call $4bcf
    call $4bec
    call $3c3c
    ld hl, $4c12
    ld a, [$d65f]
    jp $3d97
; 0x48bcf

INCBIN "baserom.gbc",$48bcf,$48c12 - $48bcf

CeladonGameCornerScripts: ; 0x48c12
    dw CeladonGameCornerScript0

INCBIN "baserom.gbc",$48c14,$4

CeladonGameCornerScript0: ; 0x48c18
    ret
; 0x48c19

INCBIN "baserom.gbc",$48c19,$71

CeladonGameCornerTexts: ; 0x48c8a
    dw CeladonGameCornerText1, CeladonGameCornerText2, CeladonGameCornerText3, CeladonGameCornerText4, CeladonGameCornerText5, CeladonGameCornerText6, CeladonGameCornerText7, CeladonGameCornerText8, CeladonGameCornerText9, CeladonGameCornerText10, CeladonGameCornerText11, CeladonGameCornerText12, CeladonGameCornerText13

CeladonGameCornerText1: ; 0x48ca4
    TX_FAR _CeladonGameCornerText1
    db $50

CeladonGameCornerText2: ; 0x48ca9
    db $08 ; asm
    call $4f1e
    ld hl, $4d22
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, .asm_c650b ; 0x48cba
    ld b,COIN_CASE
    call $3493
    jr z, .asm_ed086 ; 0x48cc1
    call $4f95
    jr nc, .asm_31338 ; 0x48cc6
    xor a
    ldh [$9f], a
    ldh [$a1], a
    ld a, $10
    ldh [$a0], a
    call $35a6
    jr nc, .asm_b6ef0 ; 0x48cd4
    ld hl, $4d31
    jr .asm_e2afd ; 0x48cd9
.asm_b6ef0 ; 0x48cdb
    xor a
    ldh [$9f], a
    ldh [$a1], a
    ld a, $10
    ldh [$a0], a
    ld hl, $ffa1
    ld de, $d349
    ld c, $3
    ld a, $c
    call Predef
    xor a
    ldh [$9f], a
    ldh [$a0], a
    ld a, $50
    ldh [$a1], a
    ld de, $d5a5
    ld hl, $ffa1
    ld c, $2
    ld a, $b
    call Predef
    call $4f1e
    ld hl, $4d27
    jr .asm_e2afd ; 0x48d0d
.asm_c650b ; 0x48d0f
    ld hl, $4d2c
    jr .asm_e2afd ; 0x48d12
.asm_31338 ; 0x48d14
    ld hl, $4d36
    jr .asm_e2afd ; 0x48d17
.asm_ed086 ; 0x48d19
    ld hl, $4d3b
.asm_e2afd ; 0x48d1c
    call PrintText
    jp $24d7

UnnamedText_48d22: ; 0x48d22
    TX_FAR _UnnamedText_48d22
    db $50
; 0x48d22 + 5 bytes

UnnamedText_48d27: ; 0x48d27
    TX_FAR _UnnamedText_48d27
    db $50
; 0x48d27 + 5 bytes

UnnamedText_48d2c: ; 0x48d2c
    TX_FAR _UnnamedText_48d2c
    db $50
; 0x48d2c + 5 bytes

UnnamedText_48d31: ; 0x48d31
    TX_FAR _UnnamedText_48d31
    db $50
; 0x48d31 + 5 bytes

UnnamedText_48d36: ; 0x48d36
    TX_FAR _UnnamedText_48d36
    db $50
; 0x48d36 + 5 bytes

UnnamedText_48d3b: ; 0x48d3b
    TX_FAR _UnnamedText_48d3b
    db $50
; 0x48d3b + 5 bytes

CeladonGameCornerText3: ; 0x48d40
    TX_FAR _CeladonGameCornerText3
    db $50

CeladonGameCornerText4: ; 0x48d45
    TX_FAR _CeladonGameCornerText4
    db $50

CeladonGameCornerText5: ; 0x48d4a
    db $08 ; asm
    ld a, [$d77e]
    bit 2, a
    jr nz, .asm_d0957 ; 0x48d50
    ld hl, $4d9c
    call PrintText
    ld b,COIN_CASE
    call $3493
    jr z, .asm_5aef9 ; 0x48d5d
    call $4f95
    jr nc, .asm_98546 ; 0x48d62
    xor a
    ldh [$9f], a
    ldh [$a0], a
    ld a, $10
    ldh [$a1], a
    ld de, $d5a5
    ld hl, $ffa1
    ld c, $2
    ld a, $b
    call Predef
    ld hl, $d77e
    set 2, [hl]
    ld a, $1
    ld [$cc3c], a
    ld hl, $4da1
    jr .asm_c7d1a ; 0x48d87
.asm_d0957 ; 0x48d89
    ld hl, $4dac
    jr .asm_c7d1a ; 0x48d8c
.asm_98546 ; 0x48d8e
    ld hl, $4da7
    jr .asm_c7d1a ; 0x48d91
.asm_5aef9 ; 0x48d93
    ld hl, $4f19
.asm_c7d1a ; 0x48d96
    call PrintText
    jp $24d7

UnnamedText_48d9c: ; 0x48d9c
    TX_FAR _UnnamedText_48d9c
    db $50
; 0x48d9c + 5 bytes

INCBIN "baserom.gbc",$48da1,$48da7 - $48da1

UnnamedText_48da7: ; 0x48da7
    TX_FAR _UnnamedText_48da7
    db $50
; 0x48da7 + 5 bytes

UnnamedText_48dac: ; 0x48dac
    TX_FAR _UnnamedText_48dac
    db $50
; 0x48dac + 5 bytes

CeladonGameCornerText6: ; 0x48db1
    TX_FAR _CeladonGameCornerText6
    db $50

CeladonGameCornerText7: ; 0x48db6
    db $08 ; asm
    ld a, [$d77c]
    bit 1, a
    ld hl, $4dca
    jr z, .asm_be3fd ; 0x48dbf
    ld hl, $4dcf
.asm_be3fd ; 0x48dc4
    call PrintText
    jp $24d7

UnnamedText_48dca: ; 0x48dca
    TX_FAR _UnnamedText_48dca
    db $50
; 0x48dca + 5 bytes

UnnamedText_48dcf: ; 0x48dcf
    TX_FAR _UnnamedText_48dcf
    db $50
; 0x48dcf + 5 bytes

CeladonGameCornerText8: ; 0x48dd4
    TX_FAR _CeladonGameCornerText8
    db $50

CeladonGameCornerText9: ; 0x48dd9
    db $08 ; asm
    ld a, [$d77e]
    bit 4, a
    jr nz, .asm_ed8bc ; 0x48ddf
    ld hl, $4e26
    call PrintText
    ld b,COIN_CASE
    call $3493
    jr z, .asm_df794 ; 0x48dec
    call $4f95
    jr nc, .asm_f17c3 ; 0x48df1
    xor a
    ldh [$9f], a
    ldh [$a0], a
    ld a, $20
    ldh [$a1], a
    ld de, $d5a5
    ld hl, $ffa1
    ld c, $2
    ld a, $b
    call Predef
    ld hl, $d77e
    set 4, [hl]
    ld hl, $4e2b
    jr .asm_0ddc2 ; 0x48e11
.asm_ed8bc ; 0x48e13
    ld hl, $4e36
    jr .asm_0ddc2 ; 0x48e16
.asm_f17c3 ; 0x48e18
    ld hl, $4e31
    jr .asm_0ddc2 ; 0x48e1b
.asm_df794 ; 0x48e1d
    ld hl, $4f19
.asm_0ddc2 ; 0x48e20
    call PrintText
    jp $24d7

UnnamedText_48e26: ; 0x48e26
    TX_FAR _UnnamedText_48e26
    db $50
; 0x48e26 + 5 bytes

INCBIN "baserom.gbc",$48e2b,$48e31 - $48e2b

UnnamedText_48e31: ; 0x48e31
    TX_FAR _UnnamedText_48e31
    db $50
; 0x48e31 + 5 bytes

UnnamedText_48e36: ; 0x48e36
    TX_FAR _UnnamedText_48e36
    db $50
; 0x48e36 + 5 bytes

CeladonGameCornerText10: ; 0x48e3b
    db $08 ; asm
    ld a, [$d77e]
    bit 3, a
    jr nz, .asm_ff080 ; 0x48e41
    ld hl, $4e88
    call PrintText
    ld b,COIN_CASE
    call $3493
    jr z, .asm_4fb0c ; 0x48e4e
    call $4f95
    jr z, .asm_9505a ; 0x48e53
    xor a
    ldh [$9f], a
    ldh [$a0], a
    ld a, $20
    ldh [$a1], a
    ld de, $d5a5
    ld hl, $ffa1
    ld c, $2
    ld a, $b
    call Predef
    ld hl, $d77e
    set 3, [hl]
    ld hl, $4e8d
    jr .asm_78d65 ; 0x48e73
.asm_ff080 ; 0x48e75
    ld hl, $4e98
    jr .asm_78d65 ; 0x48e78
.asm_9505a ; 0x48e7a
    ld hl, $4e93
    jr .asm_78d65 ; 0x48e7d
.asm_4fb0c ; 0x48e7f
    ld hl, $4f19
.asm_78d65 ; 0x48e82
    call PrintText
    jp $24d7

UnnamedText_48e88: ; 0x48e88
    TX_FAR _UnnamedText_48e88
    db $50
; 0x48e88 + 5 bytes

INCBIN "baserom.gbc",$48e8d,$48e93 - $48e8d

UnnamedText_48e93: ; 0x48e93
    TX_FAR _UnnamedText_48e93
    db $50
; 0x48e93 + 5 bytes

UnnamedText_48e98: ; 0x48e98
    TX_FAR _UnnamedText_48e98
    db $50
; 0x48e98 + 5 bytes

CeladonGameCornerText11: ; 0x48e9d
    db $08 ; asm
    ld hl, $4ece
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $4ed3
    ld de, $4ed3
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    xor a
    ldh [$b4], a
    ldh [$b3], a
    ldh [$b2], a
    ld a, $1
    ld [$d65f], a
    jp $24d7

UnnamedText_48ece: ; 0x48ece
    TX_FAR _UnnamedText_48ece
    db $50
; 0x48ece + 5 bytes

UnnamedText_48ed3: ; 0x48ed3
    TX_FAR _UnnamedText_48ed3
    db $50
; 0x48ed3 + 5 bytes

CeladonGameCornerText13: ; 0x48ed8
    TX_FAR _UnnamedText_48ed8
    db $50
; 0x48ed8 + 5 bytes

CeladonGameCornerText12: ; 0x48edd
    db $08 ; asm
    ld a, $1
    ld [$cc3c], a
    ld hl, $4f09
    call PrintText
    call $3748
    ld a, $ad
    call $23b1
    call $3748
    ld hl, $d77e
    set 1, [hl]
    ld a, $43
    ld [$d09f], a
    ld bc, $0208
    ld a, $17
    call Predef
    jp $24d7

INCBIN "baserom.gbc",$48f09,$48f19 - $48f09

UnnamedText_48f19: ; 0x48f19
    TX_FAR _UnnamedText_48f19
    db $50
; 0x48f19 + 5 bytes

INCBIN "baserom.gbc",$48f1e,$82

CeladonGameCornerObject: ; 0x48fa0 (size=99)
    db $f ; border tile

    db $3 ; warps
    db $11, $f, $7, $ff
    db $11, $10, $7, $ff
    db $4, $11, $1, ROCKET_HIDEOUT_1

    db $1 ; signs
    db $4, $9, $c ; CeladonGameCornerText12

    db $b ; people
    db SPRITE_FOULARD_WOMAN, $6 + 4, $2 + 4, $ff, $d0, $1 ; person
    db SPRITE_MART_GUY, $6 + 4, $5 + 4, $ff, $d0, $2 ; person
    db SPRITE_FAT_BALD_GUY, $a + 4, $2 + 4, $ff, $d2, $3 ; person
    db SPRITE_FOULARD_WOMAN, $d + 4, $2 + 4, $ff, $d2, $4 ; person
    db SPRITE_FISHER, $b + 4, $5 + 4, $ff, $d3, $5 ; person
    db SPRITE_MOM_GEISHA, $b + 4, $8 + 4, $ff, $d2, $6 ; person
    db SPRITE_GYM_HELPER, $e + 4, $8 + 4, $ff, $d2, $7 ; person
    db SPRITE_GAMBLER, $f + 4, $b + 4, $ff, $d3, $8 ; person
    db SPRITE_MART_GUY, $b + 4, $e + 4, $ff, $d2, $9 ; person
    db SPRITE_GENTLEMAN, $d + 4, $11 + 4, $ff, $d3, $a ; person
    db SPRITE_ROCKET, $5 + 4, $9 + 4, $ff, $d1, $4b, ROCKET + $C8, $7 ; trainer

    ; warp-to
    EVENT_DISP $a, $11, $f
    EVENT_DISP $a, $11, $10
    EVENT_DISP $a, $4, $11 ; ROCKET_HIDEOUT_1

CeladonGameCornerBlocks: ; 90
    INCBIN "maps/celadongamecorner.blk"

CeladonMart5_h: ; 0x4905d to 0x49069 (12 bytes) (bank=12) (id=136)
    db $12 ; tileset
    db CELADON_HOUSE_HEIGHT, CELADON_HOUSE_WIDTH ; dimensions (y, x)
    dw CeladonMart5Blocks, CeladonMart5Texts, CeladonMart5Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMart5Object ; objects

CeladonMart5Script: ; 0x49069
    jp $3c3c
; 0x4906c

CeladonMart5Texts: ; 0x4906c
    dw CeladonMart5Text1, CeladonMart5Text2, CeladonMart5Text3, CeladonMart5Text4, CeladonMart5Text5

CeladonMart5Text1: ; 0x49076
    TX_FAR _CeladonMart5Text1
    db $50

CeladonMart5Text2: ; 0x4907b
    TX_FAR _CeladonMart5Text2
    db $50

CeladonMart5Text5: ; 0x49080
    TX_FAR _CeladonMart5Text5
    db $50

CeladonMart5Object: ; 0x49085 (size=55)
    db $f ; border tile

    db $3 ; warps
    db $1, $c, $0, CELADON_MART_ROOF
    db $1, $10, $1, CELADON_MART_4
    db $1, $1, $0, CELADON_MART_ELEVATOR

    db $1 ; signs
    db $1, $e, $5 ; CeladonMart5Text5

    db $4 ; people
    db SPRITE_GENTLEMAN, $5 + 4, $e + 4, $fe, $1, $1 ; person
    db SPRITE_SAILOR, $6 + 4, $2 + 4, $ff, $ff, $2 ; person
    db SPRITE_MART_GUY, $3 + 4, $5 + 4, $ff, $d0, $3 ; person
    db SPRITE_MART_GUY, $3 + 4, $6 + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $a, $1, $c ; CELADON_MART_ROOF
    EVENT_DISP $a, $1, $10 ; CELADON_MART_4
    EVENT_DISP $a, $1, $1 ; CELADON_MART_ELEVATOR

CeladonMart5Blocks: ; 40
    INCBIN "maps/celadonhouse.blk"

CeladonPrizeRoom_h: ; 0x490e4 to 0x490f0 (12 bytes) (bank=12) (id=137)
    db $12 ; tileset
    db CELADONPRIZE_ROOM_HEIGHT, CELADONPRIZE_ROOM_WIDTH ; dimensions (y, x)
    dw CeladonPrizeRoomBlocks, CeladonPrizeRoomTexts, CeladonPrizeRoomScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonPrizeRoomObject ; objects

CeladonPrizeRoomScript: ; 0x490f0
    jp $3c3c
; 0x490f3

CeladonPrizeRoomTexts:
    dw CeladonPrizeRoomText1, CeladonPrizeRoomText2, CeladonPrizeRoomText3, CeladonPrizeRoomText3, CeladonPrizeRoomText3

CeladonPrizeRoomText1: ; 0x490fd
    TX_FAR _CeladonPrizeRoomText1
    db $50

CeladonPrizeRoomText2: ; 0x49102
    TX_FAR _CeladonPrizeRoomText2
    db $50

CeladonPrizeRoomText3: ; 0x49107
    db $f7

CeladonPrizeRoomObject: ; 0x49108 (size=41)
    db $f ; border tile

    db $2 ; warps
    db $7, $4, $9, $ff
    db $7, $5, $9, $ff

    db $3 ; signs
    db $2, $2, $3 ; CeladonPrizeRoomText3
    db $2, $4, $4 ; CeladonPrizeRoomText4
    db $2, $6, $5 ; CeladonPrizeRoomText5

    db $2 ; people
    db SPRITE_BALDING_GUY, $4 + 4, $1 + 4, $ff, $ff, $1 ; person
    db SPRITE_GAMBLER, $3 + 4, $7 + 4, $fe, $2, $2 ; person

    ; warp-to
    EVENT_DISP $5, $7, $4
    EVENT_DISP $5, $7, $5

CeladonPrizeRoomBlocks: ; 20
    INCBIN "maps/celadonprizeroom.blk"

CeladonDiner_h: ; 0x49145 to 0x49151 (12 bytes) (bank=12) (id=138)
    db $12 ; tileset
    db CELADON_DINER_HEIGHT, CELADON_DINER_WIDTH ; dimensions (y, x)
    dw CeladonDinerBlocks, CeladonDinerTexts, CeladonDinerScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonDinerObject ; objects

CeladonDinerScript: ; 0x49151
    call $3c3c
    ret
; 0x49155

CeladonDinerTexts: ; 0x49155
    dw CeladonDinerText1, CeladonDinerText2, CeladonDinerText3, CeladonDinerText4, CeladonDinerText5

CeladonDinerText1: ; 0x4915f
    TX_FAR _CeladonDinerText1
    db $50

CeladonDinerText2: ; 0x49164
    TX_FAR _CeladonDinerText2
    db $50

CeladonDinerText3: ; 0x49169
    TX_FAR _CeladonDinerText3
    db $50

CeladonDinerText4: ; 0x4916e
    TX_FAR _CeladonDinerText4
    db $50

CeladonDinerText5: ; 0x49173
    db $08 ; asm
    ld a, [$d783]
    bit 0, a
    jr nz, .asm_eb14d ; 0x49179
    ld hl, $51a7
    call PrintText
    ld bc,(COIN_CASE << 8) | 1
    call $3e2e
    jr nc, .asm_78e93 ; 0x49187
    ld hl, $d783
    set 0, [hl]
    ld hl, $51ac
    call PrintText
    jr .asm_68b61 ; 0x49194
.asm_78e93 ; 0x49196
    ld hl, $51b2
    call PrintText
    jr .asm_68b61 ; 0x4919c
.asm_eb14d ; 0x4919e
    ld hl, $51b7
    call PrintText
.asm_68b61 ; 0x491a4
    jp $24d7

UnnamedText_491a7: ; 0x491a7
    TX_FAR _UnnamedText_491a7
    db $50
; 0x491a7 + 5 bytes

INCBIN "baserom.gbc",$491ac,$491b2 - $491ac

UnnamedText_491b2: ; 0x491b2
    TX_FAR _UnnamedText_491b2
    db $50
; 0x491b2 + 5 bytes

UnnamedText_491b7: ; 0x491b7
    TX_FAR _UnnamedText_491b7
    db $50
; 0x491b7 + 5 bytes

CeladonDinerObject: ; 0x491bc (size=50)
    db $f ; border tile

    db $2 ; warps
    db $7, $3, $a, $ff
    db $7, $4, $a, $ff

    db $0 ; signs

    db $5 ; people
    db SPRITE_COOK, $5 + 4, $8 + 4, $fe, $2, $1 ; person
    db SPRITE_MOM_GEISHA, $2 + 4, $7 + 4, $ff, $ff, $2 ; person
    db SPRITE_FAT_BALD_GUY, $4 + 4, $1 + 4, $ff, $d0, $3 ; person
    db SPRITE_FISHER2, $3 + 4, $5 + 4, $ff, $d3, $4 ; person
    db SPRITE_GYM_HELPER, $1 + 4, $0 + 4, $ff, $d0, $5 ; person

    ; warp-to
    EVENT_DISP $5, $7, $3
    EVENT_DISP $5, $7, $4

CeladonDinerBlocks: ; 20
    INCBIN "maps/celadondiner.blk"

CeladonHouse_h: ; 0x49202 to 0x4920e (12 bytes) (bank=12) (id=139)
    db $13 ; tileset
    db CELADON_HOUSE_2_HEIGHT, CELADON_HOUSE_2_WIDTH ; dimensions (y, x)
    dw CeladonHouseBlocks, CeladonHouseTexts, CeladonHouseScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonHouseObject ; objects

CeladonHouseScript: ; 0x4920e
    call $3c3c
    ret
; 0x49212

CeladonHouseTexts: ; 0x49212
    dw CeladonHouseText1, CeladonHouseText2, CeladonHouseText3

CeladonHouseText1: ; 0x49218
    TX_FAR _CeladonHouseText1
    db $50

CeladonHouseText2: ; 0x4921d
    TX_FAR _CeladonHouseText2
    db $50

CeladonHouseText3: ; 0x49222
    TX_FAR _CeladonHouseText3
    db $50

CeladonHouseObject: ; 0x49227 (size=38)
    db $f ; border tile

    db $2 ; warps
    db $7, $2, $b, $ff
    db $7, $3, $b, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_OLD_PERSON, $2 + 4, $4 + 4, $ff, $d0, $1 ; person
    db SPRITE_ROCKET, $4 + 4, $1 + 4, $fe, $0, $2 ; person
    db SPRITE_SAILOR, $6 + 4, $5 + 4, $ff, $d2, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

CeladonHouseBlocks: ; 16
    INCBIN "maps/celadonhouse2.blk"

CeladonHotel_h: ; 0x4925d to 0x49269 (12 bytes) (bank=12) (id=140)
    db $06 ; tileset
    db CELADONHOTEL_HEIGHT, CELADONHOTEL_WIDTH ; dimensions (y, x)
    dw CeladonHotelBlocks, CeladonHotelTexts, CeladonHotelScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonHotelObject ; objects

CeladonHotelScript: ; 0x49269
    jp $3c3c
; 0x4926c

CeladonHotelTexts: ; 0x4926c
    dw CeladonHotelText1, CeladonHotelText2, CeladonHotelText3

CeladonHotelText1: ; 0x49272
    TX_FAR _CeladonHotelText1
    db $50

CeladonHotelText2: ; 0x49277
    TX_FAR _CeladonHotelText2
    db $50

CeladonHotelText3: ; 0x4927c
    TX_FAR _CeladonHotelText3
    db $50

CeladonHotelObject: ; 0x49281 (size=38)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $c, $ff
    db $7, $4, $c, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_OLD_MEDIUM_WOMAN, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_FOULARD_WOMAN, $4 + 4, $2 + 4, $ff, $ff, $2 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $4 + 4, $8 + 4, $fe, $2, $3 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

CeladonHotelBlocks: ; 28
    INCBIN "maps/celadonhotel.blk"

MtMoonPokecenter_h: ; 0x492c3 to 0x492cf (12 bytes) (bank=12) (id=68)
    db $06 ; tileset
    db MT_MOON_POKECENTER_HEIGHT, MT_MOON_POKECENTER_WIDTH ; dimensions (y, x)
    dw MtMoonPokecenterBlocks, MtMoonPokecenterTexts, MtMoonPokecenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw MtMoonPokecenterObject ; objects

MtMoonPokecenterScript: ; 0x492cf
    call $22fa
    jp $3c3c
; 0x492d5

MtMoonPokecenterTexts:
    dw MtMoonPokecenterText1, MtMoonPokecenterText2, MtMoonPokecenterText3, MtMoonPokecenterText4, MtMoonPokecenterText5, MtMoonPokecenterText6

MtMoonPokecenterText1: ; 0x492e0
    db $ff

MtMoonPokecenterText2: ; 0x492e2
    TX_FAR _MtMoonPokecenterText1
    db $50

MtMoonPokecenterText3: ; 0x492e7
    TX_FAR _MtMoonPokecenterText3
    db $50

MtMoonPokecenterText4: ; 0x492ec
    db $08 ; asm
    ld a, [$d7c6]
    add a
    jp c, $5353
    ld hl, $535c
    call PrintText
    ld a, $13
    ld [$d125], a
    call $30e8
    call $35ec
    ld a, [$cc26]
    and a
    jp nz, $534e
    ldh [$9f], a
    ldh [$a1], a
    ld a, $5
    ldh [$a0], a
    call $35a6
    jr nc, .asm_faa09 ; 0x49317
    ld hl, $5366
    jr .asm_ae354 ; 0x4931c
.asm_faa09 ; 0x4931e
	ld bc,(MAGIKARP << 8) | 5
    call GivePokemon
    jr nc, .asm_38361 ; 0x49324
    xor a
    ld [W_WHICHTRADE], a
    ld [$cd3f], a
    ld a, $5
    ld [$cd3e], a
    ld hl, $cd3f
    ld de, $d349
    ld c, $3
    ld a, $c
    call Predef
    ld a, $13
    ld [$d125], a
    call $30e8
    ld hl, $d7c6
    set 7, [hl]
    jr .asm_38361 ; 0x4934c
    ld hl, $5361
    jr .asm_ae354 ; 0x49351
    ld hl, $536b
.asm_ae354 ; 0x49356
    call PrintText
.asm_38361 ; 0x49359
    jp $24d7

UnnamedText_4935c: ; 0x4935c
    TX_FAR _UnnamedText_4935c
    db $50
; 0x4935c + 5 bytes

UnnamedText_49361: ; 0x49361
    TX_FAR _UnnamedText_49361
    db $50
; 0x49361 + 5 bytes

UnnamedText_49366: ; 0x49366
    TX_FAR _UnnamedText_49366
    db $50
; 0x49366 + 5 bytes

UnnamedText_4936b: ; 0x4936b
    TX_FAR _UnnamedText_4936b
    db $50
; 0x4936b + 5 bytes

MtMoonPokecenterText5: ; 0x49370
    TX_FAR _MtMoonPokecenterText5
    db $50

MtMoonPokecenterText6:
    db $f6

MtMoonPokecenterObject: ; 0x49376 (size=56)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $0, $ff
    db $7, $4, $0, $ff

    db $0 ; signs

    db $6 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_BUG_CATCHER, $3 + 4, $4 + 4, $ff, $d1, $2 ; person
    db SPRITE_GENTLEMAN, $3 + 4, $7 + 4, $ff, $d1, $3 ; person
    db SPRITE_FAT_BALD_GUY, $6 + 4, $a + 4, $fe, $2, $4 ; person
    db SPRITE_CLIPBOARD, $2 + 4, $7 + 4, $ff, $ff, $5 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $6 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

RockTunnelPokecenter_h: ; 0x493ae to 0x493ba (12 bytes) (id=81)
    db $06 ; tileset
    db ROCK_TUNNEL_POKECENTER_HEIGHT, ROCK_TUNNEL_POKECENTER_WIDTH ; dimensions (y, x)
    dw RockTunnelPokecenterBlocks, RockTunnelPokecenterTexts, RockTunnelPokecenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw RockTunnelPokecenterObject ; objects

RockTunnelPokecenterScript: ; 0x493ba
    call $22fa
    jp $3c3c
; 0x493c0

RockTunnelPokecenterTexts:
    dw RockTunnelPokecenterText1, RockTunnelPokecenterText2, RockTunnelPokecenterText3, RockTunnelPokecenterText4

RockTunnelPokecenterText1: ; 0x493c8
    db $ff

RockTunnelPokecenterText2: ; 0x493c9
    TX_FAR _RockTunnelPokecenterText1
    db $50

RockTunnelPokecenterText3: ; 0x493ce
    TX_FAR _RockTunnelPokecenterText3
    db $50

RockTunnelPokecenterText4: ; 0x493d3
    db $f6

RockTunnelPokecenterObject: ; 0x493d4 (size=44)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $0, $ff
    db $7, $4, $0, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_GENTLEMAN, $3 + 4, $7 + 4, $fe, $2, $2 ; person
    db SPRITE_FISHER2, $5 + 4, $2 + 4, $ff, $ff, $3 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

Route11Gate_h: ; 0x49400 to 0x4940c (12 bytes) (id=84)
    db $0c ; tileset
    db ROUTE_11_GATE_1F_HEIGHT, ROUTE_11_GATE_1F_WIDTH ; dimensions (y, x)
    dw Route11GateBlocks, Route11GateTexts, Route11GateScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route11GateObject ; objects

Route11GateScript: ; 0x4940c
    jp $3c3c
; 0x4940f

Route11GateTexts: ; 0x4940f
    dw Route11GateText1

Route11GateText1: ; 0x49411
    TX_FAR _Route11GateText1
    db $50

Route11GateObject: ; 0x49416 (size=50)
    db $a ; border tile

    db $5 ; warps
    db $4, $0, $0, $ff
    db $5, $0, $1, $ff
    db $4, $7, $2, $ff
    db $5, $7, $3, $ff
    db $8, $6, $0, ROUTE_11_GATE_2F

    db $0 ; signs

    db $1 ; people
    db SPRITE_GUARD, $1 + 4, $4 + 4, $ff, $ff, $1 ; person

    ; warp-to
    EVENT_DISP $4, $4, $0
    EVENT_DISP $4, $5, $0
    EVENT_DISP $4, $4, $7
    EVENT_DISP $4, $5, $7
    EVENT_DISP $4, $8, $6 ; ROUTE_11_GATE_2F

Route11GateUpstairs_h: ; 0x49448 to 0x49454 (12 bytes) (id=86)
    db $0c ; tileset
    db ROUTE_11_GATE_2F_HEIGHT, ROUTE_11_GATE_2F_WIDTH ; dimensions (y, x)
    dw Route11GateUpstairsBlocks, Route11GateUpstairsTexts, Route11GateUpstairsScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route11GateUpstairsObject ; objects

Route11GateUpstairsScript: ; 0x49454
    jp $3c3f
; 0x49457

Route11GateUpstairsTexts:
    dw Route11GateUpstairsText1, Route11GateUpstairsText2, Route11GateUpstairsText3, Route11GateUpstairsText4

Route11GateUpstairsText1: ; 0x4945f
    db $08 ; asm
    xor a
    ld [W_WHICHTRADE], a
    ld a, $54
    call Predef
asm_49469:
    jp $24d7

Route11GateUpstairsText2: ; 0x4946c
    db $8
    ld a, [$d7d6]
    add a
    jr c, .asm_4949b ; 0x49471 $28
    ld a, $1e
    ld [$ff00+$db], a
    ld a, $47
    ld [$ff00+$dc], a
    ld [$d11e], a
    call $2fcf
    ld h, d
    ld l, e
    ld de, $cc5b
    ld bc, $000d
    call CopyData
    ld a, $62
    call Predef
    ld a, [$ff00+$db]
    dec a
    jr nz, .asm_494a1 ; 0x49494 $b
    ld hl, $d7d6
    set 7, [hl]
.asm_4949b
    ld hl, $54a3
    call PrintText
.asm_494a1
    jr asm_49469 ; 0x494a1 $c6
; 0x494a3

UnnamedText_494a3: ; 0x494a3
    TX_FAR _UnnamedText_494a3
    db $50
; 0x494a3 + 5 bytes

Route11GateUpstairsText3: ; 0x494a8
    db $08 ; asm
    ld a, [$c109]
    cp $4
    jp nz, $55c9
    ld a, [$d7d8]
    bit 7, a
    ld hl, $54c4
    jr z, .asm_5ac80 ; 0x494b9
    ld hl, $54c9
.asm_5ac80 ; 0x494be
    call PrintText
    jp $24d7

UnnamedText_494c4: ; 0x494c4
    TX_FAR _UnnamedText_494c4
    db $50
; 0x494c4 + 5 bytes

UnnamedText_494c9: ; 0x494c9
    TX_FAR _UnnamedText_494c9
    db $50
; 0x494c9 + 5 bytes

Route11GateUpstairsText4: ; 0x494ce
    db $8
    ld hl, $54d5
    jp $55c9
; 0x494d5

UnnamedText_494d5: ; 0x494d5
    TX_FAR _UnnamedText_494d5
    db $50
; 0x494d5 + 5 bytes

Route11GateUpstairsObject: ; 0x494da (size=30)
    db $a ; border tile

    db $1 ; warps
    db $7, $7, $4, ROUTE_11_GATE_1F

    db $2 ; signs
    db $2, $1, $3 ; Route11GateUpstairsText3
    db $2, $6, $4 ; Route11GateUpstairsText4

    db $2 ; people
    db SPRITE_BUG_CATCHER, $2 + 4, $4 + 4, $fe, $2, $1 ; person
    db SPRITE_OAK_AIDE, $6 + 4, $2 + 4, $ff, $ff, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $7 ; ROUTE_11_GATE_1F

Route12Gate_h: ; 0x494f8 to 0x49504 (12 bytes) (id=87)
    db $0c ; tileset
    db ROUTE_12_GATE_HEIGHT, ROUTE_12_GATE_WIDTH ; dimensions (y, x)
    dw Route12GateBlocks, Route12GateTexts, Route12GateScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route12GateObject ; objects

Route12GateScript: ; 0x49504
    jp $3c3c
; 0x49507

Route12GateTexts: ; 0x49507
    dw Route12GateText1

Route12GateText1: ; 0x49509
    TX_FAR _Route12GateText1
    db $50

Route12GateObject: ; 0x4950e (size=50)
    db $a ; border tile

    db $5 ; warps
    db $0, $4, $0, $ff
    db $0, $5, $1, $ff
    db $7, $4, $2, $ff
    db $7, $5, $2, $ff
    db $6, $8, $0, ROUTE_12_GATE_2F

    db $0 ; signs

    db $1 ; people
    db SPRITE_GUARD, $3 + 4, $1 + 4, $ff, $ff, $1 ; person

    ; warp-to
    EVENT_DISP $5, $0, $4
    EVENT_DISP $5, $0, $5
    EVENT_DISP $5, $7, $4
    EVENT_DISP $5, $7, $5
    EVENT_DISP $5, $6, $8 ; ROUTE_12_GATE_2F

Route12GateBlocks: ; 20
    INCBIN "maps/route12gate.blk"

Route12GateUpstairs_h: ; 0x49554 to 0x49560 (12 bytes) (id=195)
    db $0c ; tileset
    db ROUTE_12_GATE_2F_HEIGHT, ROUTE_12_GATE_2F_WIDTH ; dimensions (y, x)
    dw Route12GateUpstairsBlocks, Route12GateUpstairsTexts, Route12GateUpstairsScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route12GateUpstairsObject ; objects

Route12GateUpstairsScript: ; 0x49560
    jp $3c3f
; 0x49563

Route12GateUpstairsTexts: ; 0x49563
    dw Route12GateUpstairsText1, Route12GateUpstairsText2, Route12GateUpstairsText3

Route12GateUpstairsText1: ; 0x49569
    db $08 ; asm
    ld a, [$d7d7]
    rrca
    jr c, .asm_0ad3c ; 0x4956e
    ld hl, $559c
    call PrintText
    ld bc,(TM_39 << 8) | 1
    call $3e2e
    jr nc, .asm_4c2be ; 0x4957c
    ld hl, $55a1
    call PrintText
    ld hl, $d7d7
    set 0, [hl]
    jr .asm_4ba56 ; 0x49589
.asm_4c2be ; 0x4958b
    ld hl, $55ac
    call PrintText
    jr .asm_4ba56 ; 0x49591
.asm_0ad3c ; 0x49593
    ld hl, $55a7
    call PrintText
.asm_4ba56 ; 0x49599
    jp $24d7

UnnamedText_4959c: ; 0x4959c
    TX_FAR _UnnamedText_4959c
    db $50
; 0x4959c + 5 bytes

INCBIN "baserom.gbc",$495a1,$495a7 - $495a1

UnnamedText_495a7: ; 0x495a7
    TX_FAR _UnnamedText_495a7
    db $50
; 0x495a7 + 5 bytes

UnnamedText_495ac: ; 0x495ac
    TX_FAR _UnnamedText_495ac
    db $50
; 0x495ac + 5 bytes

Route12GateUpstairsText2: ; 0x495b1
    db $08 ; asm
    ld hl, $55b8
    jp $55c9

;TX_FAR at 0x495b8
db $17, $5a, $49, $23, $50

Route12GateUpstairsText3: ; 0x495bd
    db $8
    ld hl, $55c4
    jp $55c9
; 0x495c4

UnnamedText_495c4: ; 0x495c4
    TX_FAR _UnnamedText_495c4
    db $50
; 0x495c4 + 5 bytes

INCBIN "baserom.gbc",$495c9,$15

Route12GateUpstairsObject: ; 0x495de (size=24)
    db $a ; border tile

    db $1 ; warps
    db $7, $7, $4, ROUTE_12_GATE

    db $2 ; signs
    db $2, $1, $2 ; Route12GateUpstairsText2
    db $2, $6, $3 ; Route12GateUpstairsText3

    db $1 ; people
    db SPRITE_BRUNETTE_GIRL, $4 + 4, $3 + 4, $fe, $1, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $7 ; ROUTE_12_GATE

Route15Gate_h: ; 0x495f6 to 0x49602 (12 bytes) (id=184)
    db $0c ; tileset
    db ROUTE_15_GATE_HEIGHT, ROUTE_15_GATE_WIDTH ; dimensions (y, x)
    dw Route15GateBlocks, Route15GateTexts, Route15GateScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route15GateObject ; objects

Route15GateScript: ; 0x49602
    jp $3c3c
; 0x49605

Route15GateTexts: ; 0x49605
    dw Route15GateText1

Route15GateText1: ; 0x49607
    TX_FAR _Route15GateText1
    db $50

Route15GateObject: ; 0x4960c (size=50)
    db $a ; border tile

    db $5 ; warps
    db $4, $0, $0, $ff
    db $5, $0, $1, $ff
    db $4, $7, $2, $ff
    db $5, $7, $3, $ff
    db $8, $6, $0, $b9

    db $0 ; signs

    db $1 ; people
    db SPRITE_GUARD, $1 + 4, $4 + 4, $ff, $ff, $1 ; person

    ; warp-to
    EVENT_DISP $4, $4, $0
    EVENT_DISP $4, $5, $0
    EVENT_DISP $4, $4, $7
    EVENT_DISP $4, $5, $7
    EVENT_DISP $4, $8, $6

INCBIN "baserom.gbc",$4963e,$4968c - $4963e

UnnamedText_4968c: ; 0x4968c
    TX_FAR _UnnamedText_4968c
    db $50
; 0x4968c + 5 bytes

INCBIN "baserom.gbc",$49691,$49698 - $49691

UnnamedText_49698: ; 0x49698
    TX_FAR _UnnamedText_49698
    db $50
; 0x49698 + 5 bytes

INCBIN "baserom.gbc",$4969d,$15

Route16GateMap_h: ; 0x496b2 to 0x496be (12 bytes) (id=186)
    db $0c ; tileset
    db ROUTE_16_GATE_1F_HEIGHT, ROUTE_16_GATE_1F_WIDTH ; dimensions (y, x)
    dw Route16GateMapBlocks, Route16GateMapTexts, Route16GateMapScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route16GateMapObject ; objects

Route16GateMapScript: ; 0x496be
    ld hl, $d732
    res 5, [hl]
    call $3c3c
    ld a, [$d660]
    ld hl, $56cf
    jp $3d97
; 0x496cf

Route16GateMapScripts: ; 0x496cf
    dw Route16GateMapScript0

INCBIN "baserom.gbc",$496d1,$6

Route16GateMapScript0: ; 0x496d7
    call $5755
    ret nz
    ld hl, $5714
    call $34bf
    ret nc
    ld a, $3
    ld [$ff00+$8c], a
    call $2920
    xor a
    ld [$ff00+$b4], a
    ld a, [$cd3d]
    cp $1
    jr z, .asm_4970e ; 0x496f1 $1b
    ld a, [$cd3d]
    dec a
    ld [$cd38], a
    ld b, $0
    ld c, a
    ld a, $40
    ld hl, $ccd3
    call $36e0
    call $3486
    ld a, $1
    ld [$d660], a
    ret
.asm_4970e
    ld a, $2
    ld [$d660], a
    ret
; 0x49714

INCBIN "baserom.gbc",$49714,$46

Route16GateMapTexts: ; 0x4975a
    dw Route16GateMapText1, Route16GateMapText2, Route16GateMapText3

Route16GateMapText1: ; 0x49760
    db $08 ; asm
    call $5755
    jr z, .asm_0bdf3 ; 0x49764
    ld hl, $577c
    call PrintText
    jr .asm_56c9d ; 0x4976c
.asm_0bdf3 ; 0x4976e
    ld hl, $5777
    call PrintText
.asm_56c9d ; 0x49774
    jp $24d7

UnnamedText_49777: ; 0x49777
    TX_FAR _UnnamedText_49777
    db $50
; 0x49777 + 5 bytes

UnnamedText_4977c: ; 0x4977c
    TX_FAR _UnnamedText_4977c
    db $50
; 0x4977c + 5 bytes

Route16GateMapText3: ; 0x49781
    TX_FAR _UnnamedText_49781
    db $50
; 0x49781 + 5 bytes

Route16GateMapText2: ; 0x49786
    TX_FAR _Route16GateMapText2
    db $50

Route16GateMapObject: ; 0x4978b (size=88)
    db $a ; border tile

    db $9 ; warps
    db $8, $0, $0, $ff
    db $9, $0, $1, $ff
    db $8, $7, $2, $ff
    db $9, $7, $2, $ff
    db $2, $0, $4, $ff
    db $3, $0, $5, $ff
    db $2, $7, $6, $ff
    db $3, $7, $7, $ff
    db $c, $6, $0, ROUTE_16_GATE_2F

    db $0 ; signs

    db $2 ; people
    db SPRITE_GUARD, $5 + 4, $4 + 4, $ff, $d0, $1 ; person
    db SPRITE_GAMBLER, $3 + 4, $4 + 4, $ff, $ff, $2 ; person

    ; warp-to
    EVENT_DISP $4, $8, $0
    EVENT_DISP $4, $9, $0
    EVENT_DISP $4, $8, $7
    EVENT_DISP $4, $9, $7
    EVENT_DISP $4, $2, $0
    EVENT_DISP $4, $3, $0
    EVENT_DISP $4, $2, $7
    EVENT_DISP $4, $3, $7
    EVENT_DISP $4, $c, $6 ; ROUTE_16_GATE_2F

Route16GateMapBlocks: ; 28
    INCBIN "maps/route16gatemap.blk"

Route16GateUpstairs_h: ; 0x497ff to 0x4980b (12 bytes) (id=187)
    db $0c ; tileset
    db ROUTE_16_GATE_2F_HEIGHT, ROUTE_16_GATE_2F_WIDTH ; dimensions (y, x)
    dw Route16GateUpstairsBlocks, Route16GateUpstairsTexts, Route16GateUpstairsScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route16GateUpstairsObject ; objects

Route16GateUpstairsScript: ; 0x4980b
    jp $3c3f
; 0x4980e

Route16GateUpstairsTexts: ; 0x4980e
    dw Route16GateUpstairsText1, Route16GateUpstairsText2, Route16GateUpstairsText3, Route16GateUpstairsText4

Route16GateUpstairsText1: ; 0x49816
    db $08 ; asm
    ld hl, $5820
    call PrintText
    jp $24d7

UnnamedText_49820: ; 0x49820
    TX_FAR _UnnamedText_49820
    db $50
; 0x49820 + 5 bytes

Route16GateUpstairsText2: ; 0x49825
    db $08 ; asm
    ld hl, $582f
    call PrintText
    jp $24d7

UnnamedText_4982f: ; 0x4982f
    TX_FAR _UnnamedText_4982f
    db $50
; 0x4982f + 5 bytes

Route16GateUpstairsText3: ; 0x49834
    db $8
    ld hl, $583b
    jp $55c9
; 0x4983b

UnnamedText_4983b: ; 0x4983b
    TX_FAR _UnnamedText_4983b
    db $50
; 0x4983b + 5 bytes

Route16GateUpstairsText4: ; 0x49840
    db $8
    ld hl, $5847
    jp $55c9
; 0x49847

UnnamedText_49847: ; 0x49847
    TX_FAR _UnnamedText_49847
    db $50
; 0x49847 + 5 bytes

Route16GateUpstairsObject: ; 0x4984c (size=30)
    db $a ; border tile

    db $1 ; warps
    db $7, $7, $8, ROUTE_16_GATE_1F

    db $2 ; signs
    db $2, $1, $3 ; Route16GateUpstairsText3
    db $2, $6, $4 ; Route16GateUpstairsText4

    db $2 ; people
    db SPRITE_YOUNG_BOY, $2 + 4, $4 + 4, $ff, $ff, $1 ; person
    db SPRITE_LITTLE_GIRL, $5 + 4, $2 + 4, $fe, $2, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $7 ; ROUTE_16_GATE_1F

Route18Gate_h: ; 0x4986a to 0x49876 (12 bytes) (id=190)
    db $0c ; tileset
    db ROUTE_18_GATE_1F_HEIGHT, ROUTE_18_GATE_1F_WIDTH ; dimensions (y, x)
    dw Route18GateBlocks, Route18GateTexts, Route18GateScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route18GateObject ; objects

Route18GateScript: ; 0x49876
    ld hl, $d732
    res 5, [hl]
    call $3c3c
    ld a, [$d669]
    ld hl, $5887
    jp $3d97
; 0x49887

Route18GateScripts: ; 0x49887
    dw Route18GateScript0

INCBIN "baserom.gbc",$49889,$6

Route18GateScript0: ; 0x4988f
    call $5755
    ret nz
    ld hl, $58cc
    call $34bf
    ret nc
    ld a, $2
    ld [$ff00+$8c], a
    call $2920
    xor a
    ld [$ff00+$b4], a
    ld a, [$cd3d]
    cp $1
    jr z, .asm_498c6 ; 0x498a9 $1b
    ld a, [$cd3d]
    dec a
    ld [$cd38], a
    ld b, $0
    ld c, a
    ld a, $40
    ld hl, $ccd3
    call $36e0
    call $3486
    ld a, $1
    ld [$d669], a
    ret
.asm_498c6
    ld a, $2
    ld [$d669], a
    ret
; 0x498cc

INCBIN "baserom.gbc",$498cc,$41

Route18GateTexts: ; 0x4990d
    dw Route18GateText1, Route18GateText2

Route18GateText1: ; 0x49911
    db $08 ; asm
    call $5755
    jr z, .asm_3c84d ; 0x49915
    ld hl, $592d
    call PrintText
    jr .asm_a8410 ; 0x4991d
.asm_3c84d ; 0x4991f
    ld hl, $5928
    call PrintText
.asm_a8410 ; 0x49925
    jp $24d7

UnnamedText_49928: ; 0x49928
    TX_FAR _UnnamedText_49928
    db $50
; 0x49928 + 5 bytes

UnnamedText_4992d: ; 0x4992d
    TX_FAR _UnnamedText_4992d
    db $50
; 0x4992d + 5 bytes

Route18GateText2: ; 0x49932
    TX_FAR _UnnamedText_49932
    db $50
; 0x49932 + 5 bytes

Route18GateObject: ; 0x49937 (size=50)
    db $a ; border tile

    db $5 ; warps
    db $4, $0, $0, $ff
    db $5, $0, $1, $ff
    db $4, $7, $2, $ff
    db $5, $7, $3, $ff
    db $8, $6, $0, ROUTE_18_GATE_2F

    db $0 ; signs

    db $1 ; people
    db SPRITE_GUARD, $1 + 4, $4 + 4, $ff, $d0, $1 ; person

    ; warp-to
    EVENT_DISP $4, $4, $0
    EVENT_DISP $4, $5, $0
    EVENT_DISP $4, $4, $7
    EVENT_DISP $4, $5, $7
    EVENT_DISP $4, $8, $6 ; ROUTE_18_GATE_2F

Route18GateHeader_h: ; 0x49969 to 0x49975 (12 bytes) (id=191)
    db $0c ; tileset
    db ROUTE_18_GATE_2F_HEIGHT, ROUTE_18_GATE_2F_WIDTH ; dimensions (y, x)
    dw Route18GateHeaderBlocks, Route18GateHeaderTexts, Route18GateHeaderScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route18GateHeaderObject ; objects

Route18GateHeaderScript: ; 0x49975
    jp $3c3f
; 0x49978

Route18GateHeaderTexts: ; 0x49978
    dw Route18GateHeaderText1, Route18GateHeaderText2, Route18GateHeaderText3

Route18GateHeaderText1: ; 0x4997e
    db $08 ; asm
    ld a, $5
    ld [W_WHICHTRADE], a
    ld a, $54
    call Predef
    jp $24d7

Route18GateHeaderText2: ; 0x4998c
    db $8
    ld hl, $5993
    jp $55c9
; 0x49993

UnnamedText_49993: ; 0x49993
    TX_FAR _UnnamedText_49993
    db $50
; 0x49993 + 5 bytes

Route18GateHeaderText3: ; 0x49998
    db $8
    ld hl, $599f
    jp $55c9
; 0x4999f

UnnamedText_4999f: ; 0x4999f
    TX_FAR _UnnamedText_4999f
    db $50
; 0x4999f + 5 bytes

Route18GateHeaderObject: ; 0x499a4 (size=24)
    db $a ; border tile

    db $1 ; warps
    db $7, $7, $4, ROUTE_18_GATE_1F

    db $2 ; signs
    db $2, $1, $2 ; Route18GateHeaderText2
    db $2, $6, $3 ; Route18GateHeaderText3

    db $1 ; people
    db SPRITE_BUG_CATCHER, $2 + 4, $4 + 4, $fe, $2, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $7 ; ROUTE_18_GATE_1F

MtMoon1_h: ; 0x499bc to 0x499c8 (12 bytes) (id=59)
    db $11 ; tileset
    db MT_MOON_1_HEIGHT, MT_MOON_1_WIDTH ; dimensions (y, x)
    dw MtMoon1Blocks, MtMoon1Texts, MtMoon1Script ; blocks, texts, scripts
    db $00 ; connections

    dw MtMoon1Object ; objects

MtMoon1Script: ; 0x499c8
    call $3c3c
    ld hl, $59fd
    ld de, $59db
    ld a, [$d606]
    call $3160
    ld [$d606], a
    ret
; 0x499db

INCBIN "baserom.gbc",$499db,$6

MtMoon1Texts: ; 0x499e1
    dw MtMoon1Text1, MtMoon1Text2, MtMoon1Text3, MtMoon1Text4, MtMoon1Text5, MtMoon1Text6, MtMoon1Text7, MtMoon1Text8, MtMoon1Text9, MtMoon1Text10, MtMoon1Text11, MtMoon1Text12, MtMoon1Text13, MtMoon1Text14

INCBIN "baserom.gbc",$499fd,$55

MtMoon1Text1: ; 0x49a52
    db $08 ; asm
    ld hl, $59fd
    call LoadTrainerHeader
    jp $24d7

MtMoon1Text2: ; 0x49a5c
    db $08 ; asm
    ld hl, $5a09
    call LoadTrainerHeader
    jp $24d7

MtMoon1Text3: ; 0x49a66
    db $08 ; asm
    ld hl, $5a15
    call LoadTrainerHeader
    jp $24d7

MtMoon1Text4: ; 0x49a70
    db $08 ; asm
    ld hl, $5a21
    call LoadTrainerHeader
    jp $24d7

MtMoon1Text5: ; 0x49a7a
    db $08 ; asm
    ld hl, $5a2d
    call LoadTrainerHeader
    jp $24d7

MtMoon1Text6: ; 0x49a84
    db $08 ; asm
    ld hl, $5a39
    call LoadTrainerHeader
    jp $24d7

MtMoon1Text7: ; 0x49a8e
    db $08 ; asm
    ld hl, $5a45
    call LoadTrainerHeader
    jp $24d7

UnnamedText_49a98: ; 0x49a98
    TX_FAR _UnnamedText_49a98
    db $50
; 0x49a98 + 5 bytes

UnnamedText_49a9d: ; 0x49a9d
    TX_FAR _UnnamedText_49a9d
    db $50
; 0x49a9d + 5 bytes

UnnamedText_49aa2: ; 0x49aa2
    TX_FAR _UnnamedText_49aa2
    db $50
; 0x49aa2 + 5 bytes

UnnamedText_49aa7: ; 0x49aa7
    TX_FAR _UnnamedText_49aa7
    db $50
; 0x49aa7 + 5 bytes

UnnamedText_49aac: ; 0x49aac
    TX_FAR _UnnamedText_49aac
    db $50
; 0x49aac + 5 bytes

UnnamedText_49ab1: ; 0x49ab1
    TX_FAR _UnnamedText_49ab1
    db $50
; 0x49ab1 + 5 bytes

UnnamedText_49ab6: ; 0x49ab6
    TX_FAR _UnnamedText_49ab6
    db $50
; 0x49ab6 + 5 bytes

UnnamedText_49abb: ; 0x49abb
    TX_FAR _UnnamedText_49abb
    db $50
; 0x49abb + 5 bytes

UnnamedText_49ac0: ; 0x49ac0
    TX_FAR _UnnamedText_49ac0
    db $50
; 0x49ac0 + 5 bytes

UnnamedText_49ac5: ; 0x49ac5
    TX_FAR _UnnamedText_49ac5
    db $50
; 0x49ac5 + 5 bytes

UnnamedText_49aca: ; 0x49aca
    TX_FAR _UnnamedText_49aca
    db $50
; 0x49aca + 5 bytes

UnnamedText_49acf: ; 0x49acf
    TX_FAR _UnnamedText_49acf
    db $50
; 0x49acf + 5 bytes

UnnamedText_49ad4: ; 0x49ad4
    TX_FAR _UnnamedText_49ad4
    db $50
; 0x49ad4 + 5 bytes

UnnamedText_49ad9: ; 0x49ad9
    TX_FAR _UnnamedText_49ad9
    db $50
; 0x49ad9 + 5 bytes

UnnamedText_49ade: ; 0x49ade
    TX_FAR _UnnamedText_49ade
    db $50
; 0x49ade + 5 bytes

UnnamedText_49ae3: ; 0x49ae3
    TX_FAR _UnnamedText_49ae3
    db $50
; 0x49ae3 + 5 bytes

UnnamedText_49ae8: ; 0x49ae8
    TX_FAR _UnnamedText_49ae8
    db $50
; 0x49ae8 + 5 bytes

UnnamedText_49aed: ; 0x49aed
    TX_FAR _UnnamedText_49aed
    db $50
; 0x49aed + 5 bytes

UnnamedText_49af2: ; 0x49af2
    TX_FAR _UnnamedText_49af2
    db $50
; 0x49af2 + 5 bytes

UnnamedText_49af7: ; 0x49af7
    TX_FAR _UnnamedText_49af7
    db $50
; 0x49af7 + 5 bytes

UnnamedText_49afc: ; 0x49afc
    TX_FAR _UnnamedText_49afc
    db $50
; 0x49afc + 5 bytes

MtMoon1Text14: ; 0x49b01
    TX_FAR _MtMoon1Text14
    db $50

MtMoon1Object: ; 0x49b06 (size=145)
    db $3 ; border tile

    db $5 ; warps
    db $23, $e, $1, $ff
    db $23, $f, $1, $ff
    db $5, $5, $0, MT_MOON_2
    db $b, $11, $2, MT_MOON_2
    db $f, $19, $3, MT_MOON_2

    db $1 ; signs
    db $17, $f, $e ; MtMoon1Text14

    db $d ; people
    db SPRITE_HIKER, $6 + 4, $5 + 4, $ff, $d0, $41, HIKER + $C8, $1 ; trainer
    db SPRITE_BUG_CATCHER, $10 + 4, $c + 4, $ff, $d3, $42, YOUNGSTER + $C8, $3 ; trainer
    db SPRITE_LASS, $4 + 4, $1e + 4, $ff, $d0, $43, LASS + $C8, $5 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $1f + 4, $18 + 4, $ff, $d1, $44, SUPER_NERD + $C8, $1 ; trainer
    db SPRITE_LASS, $17 + 4, $10 + 4, $ff, $d0, $45, LASS + $C8, $6 ; trainer
    db SPRITE_BUG_CATCHER, $16 + 4, $7 + 4, $ff, $d0, $46, BUG_CATCHER + $C8, $7 ; trainer
    db SPRITE_BUG_CATCHER, $1b + 4, $1e + 4, $ff, $d3, $47, BUG_CATCHER + $C8, $8 ; trainer
	db SPRITE_BALL, $14 + 4, $2 + 4, $ff, $ff, $88, POTION ; item
	db SPRITE_BALL, $2 + 4, $2 + 4, $ff, $ff, $89, MOON_STONE ; item
	db SPRITE_BALL, $1f + 4, $23 + 4, $ff, $ff, $8a, RARE_CANDY ; item
	db SPRITE_BALL, $17 + 4, $24 + 4, $ff, $ff, $8b, ESCAPE_ROPE ; item
	db SPRITE_BALL, $21 + 4, $14 + 4, $ff, $ff, $8c, POTION ; item
	db SPRITE_BALL, $20 + 4, $5 + 4, $ff, $ff, $8d, TM_12 ; item

    ; warp-to
    EVENT_DISP $14, $23, $e
    EVENT_DISP $14, $23, $f
    EVENT_DISP $14, $5, $5 ; MT_MOON_2
    EVENT_DISP $14, $b, $11 ; MT_MOON_2
    EVENT_DISP $14, $f, $19 ; MT_MOON_2

MtMoon1Blocks: ; 360
    INCBIN "maps/mtmoon1.blk"

MtMoon3_h: ; 0x49cff to 0x49d0b (12 bytes) (id=61)
    db $11 ; tileset
    db MT_MOON_3_HEIGHT, MT_MOON_3_WIDTH ; dimensions (y, x)
    dw MtMoon3Blocks, MtMoon3Texts, MtMoon3Script ; blocks, texts, scripts
    db $00 ; connections

    dw MtMoon3Object ; objects

MtMoon3Script: ; 0x49d0b
    call $3c3c
    ld hl, $5e48
    ld de, $5d63
    ld a, [$d607]
    call $3160
    ld [$d607], a
    ld a, [$d7f6]
    bit 1, a
    ret z
    ld hl, $5d37
    call $34bf
    jr nc, .asm_49d31 ; 0x49d29 $6
    ld hl, $d72e
    set 4, [hl]
    ret
.asm_49d31
    ld hl, $d72e
    res 4, [hl]
    ret
; 0x49d37

INCBIN "baserom.gbc",$49d37,$fd

MtMoon3Texts: ; 0x49e34
    dw MtMoon3Text1, MtMoon3Text2, MtMoon3Text3, MtMoon3Text4, MtMoon3Text5, MtMoon3Text6, MtMoon3Text7, MtMoon3Text8, MtMoon3Text9

INCBIN "baserom.gbc",$49e46,$33

MtMoon3Text1: ; 0x49e79
    db $08 ; asm
    ld a, [$d7f6]
    bit 1, a
    jr z, .asm_be1e0 ; 0x49e7f
    and $c0
    jr nz, .asm_f8cd4 ; 0x49e83
    ld hl, $5f8f
    call PrintText
    jr .asm_f1fba ; 0x49e8b
.asm_be1e0 ; 0x49e8d
    ld hl, $5f85
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $5f8a
    ld de, $5f8a
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    ld a, $3
    ld [$d607], a
    ld [$da39], a
    jr .asm_f1fba ; 0x49eb6
.asm_f8cd4 ; 0x49eb8
    ld hl, $5f94
    call PrintText
.asm_f1fba ; 0x49ebe
    jp $24d7

MtMoon3Text2: ; 0x49ec1
    db $08 ; asm
    ld hl, $5e48
    call LoadTrainerHeader
    jp $24d7

MtMoon3Text3: ; 0x49ecb
    db $08 ; asm
    ld hl, $5e54
    call LoadTrainerHeader
    jp $24d7

MtMoon3Text4: ; 0x49ed5
    db $08 ; asm
    ld hl, $5e60
    call LoadTrainerHeader
    jp $24d7

MtMoon3Text5: ; 0x49edf
    db $08 ; asm
    ld hl, $5e6c
    call LoadTrainerHeader
    jp $24d7

MtMoon3Text6: ; 0x49ee9
    db $08 ; asm
    ld a, $1
    ld [$cc3c], a
    ld hl, $5f24
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, .asm_1fa5e ; 0x49efc
    ld bc,(DOME_FOSSIL << 8) | 1
    call $3e2e
    jp nc, $5f76
    call $5f69
    ld a, $6d
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld hl, $d7f6
    set 6, [hl]
    ld a, $4
    ld [$d607], a
    ld [$da39], a
.asm_1fa5e ; 0x49f21
    jp $24d7

UnnamedText_49f24: ; 0x49f24
    TX_FAR _UnnamedText_49f24
    db $50
; 0x49f24 + 5 bytes

MtMoon3Text7: ; 0x49f29
    db $08 ; asm
    ld a, $1
    ld [$cc3c], a
    ld hl, $5f64
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, .asm_8e988 ; 0x49f3c
    ld bc,(HELIX_FOSSIL << 8) | 1
    call $3e2e
    jp nc, $5f76
    call $5f69
    ld a, $6e
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld hl, $d7f6
    set 7, [hl]
    ld a, $4
    ld [$d607], a
    ld [$da39], a
.asm_8e988 ; 0x49f61
    jp $24d7

UnnamedText_49f64: ; 0x49f64
    TX_FAR _UnnamedText_49f64
    db $50
; 0x49f64 + 5 bytes

INCBIN "baserom.gbc",$49f69,$49f85 - $49f69

UnnamedText_49f85: ; 0x49f85
    TX_FAR _UnnamedText_49f85
    db $50
; 0x49f85 + 5 bytes

UnnamedText_49f8a: ; 0x49f8a
    TX_FAR _UnnamedText_49f8a
    db $50
; 0x49f8a + 5 bytes

UnnamedText_49f8f: ; 0x49f8f
    TX_FAR _UnnamedText_49f8f
    db $50
; 0x49f8f + 5 bytes

UnnamedText_49f94: ; 0x49f94
    TX_FAR _UnnamedText_49f94
    db $50
; 0x49f94 + 5 bytes

INCBIN "baserom.gbc",$49f99,$49f9f - $49f99

UnnamedText_49f9f: ; 0x49f9f
    TX_FAR _UnnamedText_49f9f
    db $50
; 0x49f9f + 5 bytes

UnnamedText_49fa4: ; 0x49fa4
    TX_FAR _UnnamedText_49fa4
    db $50
; 0x49fa4 + 5 bytes

UnnamedText_49fa9: ; 0x49fa9
    TX_FAR _UnnamedText_49fa9
    db $50
; 0x49fa9 + 5 bytes

UnnamedText_49fae: ; 0x49fae
    TX_FAR _UnnamedText_49fae
    db $50
; 0x49fae + 5 bytes

UnnamedText_49fb3: ; 0x49fb3
    TX_FAR _UnnamedText_49fb3
    db $50
; 0x49fb3 + 5 bytes

UnnamedText_49fb8: ; 0x49fb8
    TX_FAR _UnnamedText_49fb8
    db $50
; 0x49fb8 + 5 bytes

UnnamedText_49fbd: ; 0x49fbd
    TX_FAR _UnnamedText_49fbd
    db $50
; 0x49fbd + 5 bytes

UnnamedText_49fc2: ; 0x49fc2
    TX_FAR _UnnamedText_49fc2
    db $50
; 0x49fc2 + 5 bytes

UnnamedText_49fc7: ; 0x49fc7
    TX_FAR _UnnamedText_49fc7
    db $50
; 0x49fc7 + 5 bytes

UnnamedText_49fcc: ; 0x49fcc
    TX_FAR _UnnamedText_49fcc
    db $50
; 0x49fcc + 5 bytes

UnnamedText_49fd1: ; 0x49fd1
    TX_FAR _UnnamedText_49fd1
    db $50
; 0x49fd1 + 5 bytes

UnnamedText_49fd6: ; 0x49fd6
    TX_FAR _UnnamedText_49fd6
    db $50
; 0x49fd6 + 5 bytes

MtMoon3Object: ; 0x49fdb (size=102)
    db $3 ; border tile

    db $4 ; warps
    db $9, $19, $1, MT_MOON_2
    db $11, $15, $4, MT_MOON_2
    db $1b, $f, $5, MT_MOON_2
    db $7, $5, $6, MT_MOON_2

    db $0 ; signs

    db $9 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $8 + 4, $c + 4, $ff, $d3, $41, SUPER_NERD + $C8, $2 ; trainer
    db SPRITE_ROCKET, $10 + 4, $b + 4, $ff, $d0, $42, ROCKET + $C8, $1 ; trainer
    db SPRITE_ROCKET, $16 + 4, $f + 4, $ff, $d0, $43, ROCKET + $C8, $2 ; trainer
    db SPRITE_ROCKET, $b + 4, $1d + 4, $ff, $d1, $44, ROCKET + $C8, $3 ; trainer
    db SPRITE_ROCKET, $11 + 4, $1d + 4, $ff, $d2, $45, ROCKET + $C8, $4 ; trainer
    db SPRITE_OMANYTE, $6 + 4, $c + 4, $ff, $ff, $6 ; person
    db SPRITE_OMANYTE, $6 + 4, $d + 4, $ff, $ff, $7 ; person
	db SPRITE_BALL, $15 + 4, $19 + 4, $ff, $ff, $88, HP_UP ; item
	db SPRITE_BALL, $5 + 4, $1d + 4, $ff, $ff, $89, TM_01 ; item

    ; warp-to
    EVENT_DISP $14, $9, $19 ; MT_MOON_2
    EVENT_DISP $14, $11, $15 ; MT_MOON_2
    EVENT_DISP $14, $1b, $f ; MT_MOON_2
    EVENT_DISP $14, $7, $5 ; MT_MOON_2

MtMoon3Blocks: ; 360
    INCBIN "maps/mtmoon3.blk"

SafariZoneWest_h: ; 0x4a1a9 to 0x4a1b5 (12 bytes) (id=219)
    db $03 ; tileset
    db SAFARI_ZONE_WEST_HEIGHT, SAFARI_ZONE_WEST_WIDTH ; dimensions (y, x)
    dw SafariZoneWestBlocks, SafariZoneWestTexts, SafariZoneWestScript ; blocks, texts, scripts
    db $00 ; connections

    dw SafariZoneWestObject ; objects

SafariZoneWestScript: ; 0x4a1b5
    jp $3c3c
; 0x4a1b8

SafariZoneWestTexts: ; 0x4a1b8
    dw SafariZoneWestText1, SafariZoneWestText2, SafariZoneWestText3, SafariZoneWestText4, SafariZoneWestText5, SafariZoneWestText6, SafariZoneWestText7, SafariZoneWestText8

SafariZoneWestText5: ; 0x4a1c8
    TX_FAR _SafariZoneWestText5
    db $50

SafariZoneWestText6: ; 0x4a1cd
    TX_FAR _SafariZoneWestText6
    db $50

SafariZoneWestText7: ; 0x4a1d2
    TX_FAR _SafariZoneWestText7
    db $50

SafariZoneWestText8: ; 0x4a1d7
    TX_FAR _SafariZoneWestText8
    db $50

SafariZoneWestObject: ; 0x4a1dc (size=108)
    db $0 ; border tile

    db $8 ; warps
    db $0, $14, $0, SAFARI_ZONE_NORTH
    db $0, $15, $1, SAFARI_ZONE_NORTH
    db $0, $1a, $2, SAFARI_ZONE_NORTH
    db $0, $1b, $3, SAFARI_ZONE_NORTH
    db $16, $1d, $2, SAFARI_ZONE_CENTER
    db $17, $1d, $3, SAFARI_ZONE_CENTER
    db $3, $3, $0, SAFARI_ZONE_SECRET_HOUSE
    db $b, $b, $0, SAFARI_ZONE_REST_HOUSE_2

    db $4 ; signs
    db $c, $c, $5 ; SafariZoneWestText5
    db $3, $11, $6 ; SafariZoneWestText6
    db $4, $1a, $7 ; SafariZoneWestText7
    db $16, $18, $8 ; SafariZoneWestText8

    db $4 ; people
	db SPRITE_BALL, $14 + 4, $8 + 4, $ff, $ff, $81, MAX_POTION ; item
	db SPRITE_BALL, $7 + 4, $9 + 4, $ff, $ff, $82, TM_32 ; item
	db SPRITE_BALL, $12 + 4, $12 + 4, $ff, $ff, $83, MAX_REVIVE ; item
	db SPRITE_BALL, $7 + 4, $13 + 4, $ff, $ff, $84, GOLD_TEETH ; item

    ; warp-to
    EVENT_DISP $f, $0, $14 ; SAFARI_ZONE_NORTH
    EVENT_DISP $f, $0, $15 ; SAFARI_ZONE_NORTH
    EVENT_DISP $f, $0, $1a ; SAFARI_ZONE_NORTH
    EVENT_DISP $f, $0, $1b ; SAFARI_ZONE_NORTH
    EVENT_DISP $f, $16, $1d ; SAFARI_ZONE_CENTER
    EVENT_DISP $f, $17, $1d ; SAFARI_ZONE_CENTER
    EVENT_DISP $f, $3, $3 ; SAFARI_ZONE_SECRET_HOUSE
    EVENT_DISP $f, $b, $b ; SAFARI_ZONE_REST_HOUSE_2

SafariZoneWestBlocks: ; 195
    INCBIN "maps/safarizonewest.blk"

SafariZoneSecretHouse_h: ; 0x4a30b to 0x4a317 (12 bytes) (id=222)
    db $14 ; tileset
    db SAFARI_ZONE_SECRET_HOUSE_HEIGHT, SAFARI_ZONE_SECRET_HOUSE_WIDTH ; dimensions (y, x)
    dw SafariZoneSecretHouseBlocks, SafariZoneSecretHouseTexts, SafariZoneSecretHouseScript ; blocks, texts, scripts
    db $00 ; connections

    dw SafariZoneSecretHouseObject ; objects

SafariZoneSecretHouseScript: ; 0x4a317
    jp $3c3c
; 0x4a31a

SafariZoneSecretHouseTexts: ; 0x4a31a
    dw SafariZoneSecretHouseText1

SafariZoneSecretHouseText1: ; 0x4a31c
    db $08 ; asm
    ld a, [$d857]
    bit 0, a
    jr nz, .asm_20a9b ; 0x4a322
    ld hl, $6350
    call PrintText
    ld bc,(HM_03 << 8) | 1
    call $3e2e
    jr nc, .asm_a21d2 ; 0x4a330
    ld hl, $6355
    call PrintText
    ld hl, $d857
    set 0, [hl]
    jr .asm_8f1fc ; 0x4a33d
.asm_a21d2 ; 0x4a33f
    ld hl, $6360
    call PrintText
    jr .asm_8f1fc ; 0x4a345
.asm_20a9b ; 0x4a347
    ld hl, $635b
    call PrintText
.asm_8f1fc ; 0x4a34d
    jp $24d7

UnnamedText_4a350: ; 0x4a350
    TX_FAR _UnnamedText_4a350
    db $50
; 0x4a350 + 5 bytes

INCBIN "baserom.gbc",$4a355,$4a35b - $4a355

UnnamedText_4a35b: ; 0x4a35b
    TX_FAR _UnnamedText_4a35b
    db $50
; 0x4a35b + 5 bytes

UnnamedText_4a360: ; 0x4a360
    TX_FAR _UnnamedText_4a360
    db $50
; 0x4a360 + 5 bytes

SafariZoneSecretHouseObject: ; 0x4a365 (size=26)
    db $17 ; border tile

    db $2 ; warps
    db $7, $2, $6, SAFARI_ZONE_WEST
    db $7, $3, $6, SAFARI_ZONE_WEST

    db $0 ; signs

    db $1 ; people
    db SPRITE_FISHER, $3 + 4, $3 + 4, $ff, $d0, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2 ; SAFARI_ZONE_WEST
    EVENT_DISP $4, $7, $3 ; SAFARI_ZONE_WEST

SafariZoneSecretHouseBlocks: ; 16
    INCBIN "maps/safarizonesecrethouse.blk"

INCBIN "baserom.gbc",$4a38f,$1c71

SECTION "bank13",DATA,BANK[$13]

YoungsterPic:
	INCBIN "pic/trainer/youngster.pic"
BugCatcherPic:
	INCBIN "pic/trainer/bugcatcher.pic"
LassPic:
	INCBIN "pic/trainer/lass.pic"
SailorPic:
	INCBIN "pic/trainer/sailor.pic"
JrTrainerMPic:
	INCBIN "pic/trainer/jr.trainerm.pic"
JrTrainerFPic:
	INCBIN "pic/trainer/jr.trainerf.pic"
PokemaniacPic:
	INCBIN "pic/trainer/pokemaniac.pic"
SuperNerdPic:
	INCBIN "pic/trainer/supernerd.pic"
HikerPic:
	INCBIN "pic/trainer/hiker.pic"
BikerPic:
	INCBIN "pic/trainer/biker.pic"
BurglarPic:
	INCBIN "pic/trainer/burglar.pic"
EngineerPic:
	INCBIN "pic/trainer/engineer.pic"
FisherPic:
	INCBIN "pic/trainer/fisher.pic"
SwimmerPic:
	INCBIN "pic/trainer/swimmer.pic"
CueBallPic:
	INCBIN "pic/trainer/cueball.pic"
GamblerPic:
	INCBIN "pic/trainer/gambler.pic"
BeautyPic:
	INCBIN "pic/trainer/beauty.pic"
PsychicPic:
	INCBIN "pic/trainer/psychic.pic"
RockerPic:
	INCBIN "pic/trainer/rocker.pic"
JugglerPic:
	INCBIN "pic/trainer/juggler.pic"
TamerPic:
	INCBIN "pic/trainer/tamer.pic"
BirdKeeperPic:
	INCBIN "pic/trainer/birdkeeper.pic"
BlackbeltPic:
	INCBIN "pic/trainer/blackbelt.pic"
Rival1Pic:
	INCBIN "pic/trainer/rival1.pic"
ProfOakPic:
	INCBIN "pic/trainer/prof.oak.pic"
ChiefPic:
ScientistPic:
	INCBIN "pic/trainer/scientist.pic"
GiovanniPic:
	INCBIN "pic/trainer/giovanni.pic"
RocketPic:
	INCBIN "pic/trainer/rocket.pic"
CooltrainerMPic:
	INCBIN "pic/trainer/cooltrainerm.pic"
CooltrainerFPic:
	INCBIN "pic/trainer/cooltrainerf.pic"
BrunoPic:
	INCBIN "pic/trainer/bruno.pic"
BrockPic:
	INCBIN "pic/trainer/brock.pic"
MistyPic:
	INCBIN "pic/trainer/misty.pic"
LtSurgePic:
	INCBIN "pic/trainer/lt.surge.pic"
ErikaPic:
	INCBIN "pic/trainer/erika.pic"
KogaPic:
	INCBIN "pic/trainer/koga.pic"
BlainePic:
	INCBIN "pic/trainer/blaine.pic"
SabrinaPic:
	INCBIN "pic/trainer/sabrina.pic"
GentlemanPic:
	INCBIN "pic/trainer/gentleman.pic"
Rival2Pic:
	INCBIN "pic/trainer/rival2.pic"
Rival3Pic:
	INCBIN "pic/trainer/rival3.pic"
LoreleiPic:
	INCBIN "pic/trainer/lorelei.pic"
ChannelerPic:
	INCBIN "pic/trainer/channeler.pic"
AgathaPic:
	INCBIN "pic/trainer/agatha.pic"
LancePic:
	INCBIN "pic/trainer/lance.pic"

BattleCenterM_h: ; 0x4fd04 to 0x4fd10 (12 bytes) (id=239)
    db $15 ; tileset
    db BATTLE_CENTER_HEIGHT, BATTLE_CENTER_WIDTH ; dimensions (y, x)
    dw BattleCenterMBlocks, BattleCenterMTexts, BattleCenterMScript ; blocks, texts, scripts
    db $00 ; connections

    dw BattleCenterMObject ; objects

BattleCenterMScript: ; 0x4fd10
    call $3c3c
    ld a, [$ff00+$aa]
    cp $2
    ld a, $8
    jr z, .asm_4fd1d ; 0x4fd19 $2
    ld a, $c
.asm_4fd1d
    ld [$ff00+$8d], a
    ld a, $1
    ld [$ff00+$8c], a
    call $34ae
    ld hl, $d72d
    bit 0, [hl]
    set 0, [hl]
    ret nz
    ld hl, $c214
    ld a, $8
    ld [hli], a
    ld a, $a
    ld [hl], a
    ld a, $8
    ld [$c119], a
    ld a, [$ff00+$aa]
    cp $2
    ret z
    ld a, $7
    ld [$c215], a
    ld a, $c
    ld [$c119], a
    ret
; 0x4fd4c

BattleCenterMTexts: ; 0x4fd4c
    dw BattleCenterMText1

BattleCenterMText1: ; 0x4fd4e
    TX_FAR _BattleCenterMText1
    db $50

BattleCenterMObject: ; 0x4fd53 (size=10)
    db $e ; border tile

    db $0 ; warps

    db $0 ; signs

    db $1 ; people
    db SPRITE_RED, $2 + 4, $2 + 4, $ff, $0, $1 ; person

BattleCenterMBlocks: ; 20
    INCBIN "maps/battlecenterm.blk"

TradeCenterM_h: ; 0x4fd71 to 0x4fd7d (12 bytes) (id=240)
    db $15 ; tileset
    db TRADE_CENTER_HEIGHT, TRADE_CENTER_WIDTH ; dimensions (y, x)
    dw TradeCenterMBlocks, TradeCenterMTexts, TradeCenterMScript ; blocks, texts, scripts
    db $00 ; connections

    dw TradeCenterMObject ; objects

TradeCenterMScript: ; 0x4fd7d
    jp $7d10
; 0x4fd80

TradeCenterMTexts: ; 0x4fd80
    dw TradeCenterMText1

TradeCenterMText1: ; 0x4fd82
    TX_FAR _TradeCenterMText1
    db $50

TradeCenterMObject: ; 0x4fd87 (size=10)
    db $e ; border tile

    db $0 ; warps

    db $0 ; signs

    db $1 ; people
    db SPRITE_RED, $2 + 4, $2 + 4, $ff, $0, $1 ; person

TradeCenterMBlocks: ; 20
    INCBIN "maps/tradecenterm.blk"

INCBIN "baserom.gbc",$4fda5,$4fe3f - $4fda5

UnnamedText_4fe3f: ; 0x4fe3f
    TX_FAR _UnnamedText_4fe3f
    db $50
; 0x4fe3f + 5 bytes

UnnamedText_4fe44: ; 0x4fe44
    TX_FAR _UnnamedText_4fe44
    db $50
; 0x4fe44 + 5 bytes

GetPredefPointer: ; 7E49
; stores hl in $CC4F,$CC50
; stores de in $CC51,$CC52
; stores bc in $CC53,$CC54
; grabs a byte "n" from $CC4E,
;    and gets the nth (3-byte) pointer in PredefPointers
; stores the bank of said pointer in [$D0B7]
; stores the pointer in hl and returns
        ; ld $CC4F,hl
        ld a,h
        ld [$CC4F],a
        ld a,l
        ld [$CC50],a

        ; ld $CC51,de
        ld hl,$CC51
        ld a,d
        ld [hli],a
        ld a,e
        ld [hli],a

        ; ld $CC53,bc
        ld a,b
        ld [hli],a
        ld [hl],c

        ld hl,PredefPointers
        ld de,0

        ; de = 3 * [$CC4E]
        ld a,[$CC4E]
        ld e,a
        add a,a
        add a,e
        ld e,a
        jr nc,.next\@
        inc d

.next\@
        add hl,de
        ld d,h
        ld e,l

	; get bank of predef routine
        ld a,[de]
        ld [$D0B7],a

	; get pointer
        inc de
        ld a,[de]
        ld l,a
        inc de
        ld a,[de]
        ld h,a

        ret

PredefPointers: ; 7E79
; these are pointers to ASM routines.
; they appear to be used in overworld map scripts.
        dbw $0F,$4D60
        dbw $0F,$70C6
        dbw $0F,$7073
        dbw $0B,$7E40
        dbw $0F,$7103
        dbw $1E,$5ABA
        dbw $03,$7132
        dbw $03,$76A5
        dbw BANK(AttackAnimation),AttackAnimation; 08 play attack animation
        dbw $03,$771E
        dbw $03,$771E
        dbw $03,$781D
        dbw $03,$7836
        dbw $03,$771E
        dbw $03,$771E
        dbw $03,$7850
        dbw $03,$7666
        dbw $03,$71D7
        dbw $03,$71A6
        dbw $03,$469C
        dbw $0F,$4A83
        dbw $03,$71C8
        dbw $03,$71C8
        dbw $03,$6E9E
        dbw $03,$7850
        dbw $03,$4754
        dbw $0E,$6F5B
        dbw $01,$6E43
        dbw $03,$78A5; 1C, used in Pokémon Tower
        dbw $03,$3EB5
        dbw $03,$3E2E
        dbw $12,$40EB
        dbw $03,$78BA
        dbw $12,$40FF
        dbw $03,$7929
        dbw $03,$79A0
        dbw $12,$4125
        dbw $03,$7A1D
        dbw $03,$79DC
        dbw $01,$5AB0
        dbw $0F,$6D02
        dbw $10,$4000
        dbw $0E,$6D1C
        dbw $1C,$778C
        dbw $0F,$6F18
        dbw $01,$5A5F
        dbw $03,$6A03
        dbw $10,$50F3
        dbw $1C,$496D
        dbw $1E,$5DDA
        dbw $10,$5682
        dbw $1E,$5869
        dbw $1C,$4B5D
        dbw $03,$4586
        dbw $04,$6953
        dbw $04,$6B57
        dbw $10,$50E2
        dbw $15,$690F
        dbw $10,$5010
        dbw BANK(Predef3B),Predef3B; 3B display pic?
        dbw $03,$6F54
        dbw $10,$42D1
        dbw $0E,$6FB8
        dbw $1C,$770A
        dbw $1C,$602B
        dbw $03,$7113
	dbw $17,$5B5E
        dbw $04,$773E
        dbw $04,$7763
        dbw $1C,$5DDF
        dbw $17,$40DC; 46 load dex screen
        dbw $03,$72E5
        dbw $03,$7A1D
        dbw $0F,$4DEC
        dbw $1C,$4F60
        dbw $09,$7D6B
        dbw $05,$7C47; 4C player exclamation
        dbw $01,$5AAF
        dbw $01,$64EB
        dbw $0D,$7CA1
        dbw $1C,$780F
        dbw $1C,$76BD
        dbw $1C,$75E8
        dbw $1C,$77E2
        dbw BANK(Predef54),Predef54 ; 54 initiate trade
        dbw $1D,$405C
        dbw $11,$4169
        dbw $1E,$45BA
        dbw $1E,$4510
        dbw $03,$45BE
        dbw $03,$460B
        dbw $03,$4D99
        dbw $01,$4DE1
        dbw $09,$7D98
        dbw $03,$7473
        dbw $04,$68EF
        dbw $04,$68F6
        dbw $07,$49C6
        dbw $16,$5035

SECTION "bank14",DATA,BANK[$14]

Route22_h: ; 0x50000 to 0x50022 (34 bytes) (id=33)
    db $00 ; tileset
    db ROUTE_22_HEIGHT, ROUTE_22_WIDTH ; dimensions (y, x)
    dw Route22Blocks, Route22Texts, Route22Script ; blocks, texts, scripts
    db NORTH | EAST ; connections

    ; connections data

	db ROUTE_23
    dw Route23Blocks + (ROUTE_23_HEIGHT - 3) * ROUTE_23_WIDTH ; connection strip location
    dw $C6EB + 0 ; current map position
    db ROUTE_23_WIDTH, ROUTE_23_WIDTH ; bigness, width
    db (ROUTE_23_HEIGHT * 2) - 1, (0 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_23_HEIGHT * (ROUTE_23_WIDTH + 6) ; window

	db VIRIDIAN_CITY
    dw ViridianCityBlocks + (VIRIDIAN_CITY_WIDTH) ; connection strip location
    dw $C6E5 + (ROUTE_22_WIDTH + 6) * (-3 + 4) ; current map position
    db $f, VIRIDIAN_CITY_WIDTH ; bigness, width
    db (-4 * -2), 0 ; alignments (y, x)
    dw $C6EF + VIRIDIAN_CITY_WIDTH ; window

    ; end connections data

    dw Route22Object ; objects

Route22Object: ; 0x50022 (size=27)
    db $2c ; border tile

    db $1 ; warps
    db $5, $8, $0, ROUTE_22_GATE

    db $1 ; signs
    db $b, $7, $3 ; Route22Text3

    db $2 ; people
    db SPRITE_BLUE, $5 + 4, $19 + 4, $ff, $ff, $1 ; person
    db SPRITE_BLUE, $5 + 4, $19 + 4, $ff, $ff, $2 ; person

    ; warp-to
    EVENT_DISP $14, $5, $8 ; ROUTE_22_GATE

Route22Blocks: ; 180
    INCBIN "maps/route22.blk"

Route20_h: ; 0x500f1 to 0x50113 (34 bytes) (id=31)
    db $00 ; tileset
    db ROUTE_20_HEIGHT, ROUTE_20_WIDTH ; dimensions (y, x)
    dw Route20Blocks, Route20Texts, Route20Script ; blocks, texts, scripts
    db WEST | EAST ; connections

    ; connections data

	db CINNABAR_ISLAND
    dw CinnabarIslandBlocks - 3 + (CINNABAR_ISLAND_WIDTH) ; connection strip location
    dw $C6E8 + (ROUTE_20_WIDTH + 6) * (0 + 3) ; current map position
    db CINNABAR_ISLAND_HEIGHT, CINNABAR_ISLAND_WIDTH ; bigness, width
    db (0 * -2), (CINNABAR_ISLAND_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * CINNABAR_ISLAND_WIDTH ; window

	db ROUTE_19
    dw Route19Blocks + (ROUTE_19_WIDTH * 15) ; connection strip location
    dw $C6E5 + (ROUTE_20_WIDTH + 6) * (-3 + 4) ; current map position
    db $c, ROUTE_19_WIDTH ; bigness, width
    db (-18 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_19_WIDTH ; window

    ; end connections data

    dw Route20Object ; objects

Route20Object: ; 0x50113 (size=106)
    db $43 ; border tile

    db $2 ; warps
    db $5, $30, $0, SEAFOAM_ISLANDS_1
    db $9, $3a, $2, SEAFOAM_ISLANDS_1

    db $2 ; signs
    db $7, $33, $b ; Route20Text11
    db $b, $39, $c ; Route20Text12

    db $a ; people
    db SPRITE_SWIMMER, $8 + 4, $57 + 4, $ff, $d1, $41, SWIMMER + $C8, $9 ; trainer
    db SPRITE_SWIMMER, $b + 4, $44 + 4, $ff, $d1, $42, BEAUTY + $C8, $f ; trainer
    db SPRITE_SWIMMER, $a + 4, $2d + 4, $ff, $d0, $43, BEAUTY + $C8, $6 ; trainer
    db SPRITE_SWIMMER, $e + 4, $37 + 4, $ff, $d3, $44, JR__TRAINER_F + $C8, $18 ; trainer
    db SPRITE_SWIMMER, $d + 4, $26 + 4, $ff, $d0, $45, SWIMMER + $C8, $a ; trainer
    db SPRITE_SWIMMER, $d + 4, $57 + 4, $ff, $d1, $46, SWIMMER + $C8, $b ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $9 + 4, $22 + 4, $ff, $d1, $47, BIRD_KEEPER + $C8, $b ; trainer
    db SPRITE_SWIMMER, $7 + 4, $19 + 4, $ff, $d1, $48, BEAUTY + $C8, $7 ; trainer
    db SPRITE_SWIMMER, $c + 4, $18 + 4, $ff, $d0, $49, JR__TRAINER_F + $C8, $10 ; trainer
    db SPRITE_SWIMMER, $8 + 4, $f + 4, $ff, $d1, $4a, BEAUTY + $C8, $8 ; trainer

    ; warp-to
    EVENT_DISP $32, $5, $30 ; SEAFOAM_ISLANDS_1
    EVENT_DISP $32, $9, $3a ; SEAFOAM_ISLANDS_1

Route20Blocks: ; 450
    INCBIN "maps/route20.blk"

Route23_h: ; 0x5033f to 0x50361 (34 bytes) (id=34)
    db $17 ; tileset
    db ROUTE_23_HEIGHT, ROUTE_23_WIDTH ; dimensions (y, x)
    dw Route23Blocks, Route23Texts, Route23Script ; blocks, texts, scripts
    db NORTH | SOUTH ; connections

    ; connections data

	db INDIGO_PLATEAU
    dw IndigoPlateauBlocks + (INDIGO_PLATEAU_HEIGHT - 3) * INDIGO_PLATEAU_WIDTH ; connection strip location
    dw $C6EB + 0 ; current map position
    db INDIGO_PLATEAU_WIDTH, INDIGO_PLATEAU_WIDTH ; bigness, width
    db (INDIGO_PLATEAU_HEIGHT * 2) - 1, (0 * -2) ; alignments (y, x)
    dw $C6E9 + INDIGO_PLATEAU_HEIGHT * (INDIGO_PLATEAU_WIDTH + 6) ; window

	db ROUTE_22
    dw Route22Blocks ; connection strip location
    dw $C6EB + (ROUTE_23_HEIGHT + 3) * (ROUTE_23_WIDTH + 6) + 0 ; current map position
    db $d, ROUTE_22_WIDTH ; bigness, width
    db 0, (0 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_22_WIDTH ; window

    ; end connections data

    dw Route23Object ; objects

Route23Object: ; 0x50361 (size=81)
    db $f ; border tile

    db $4 ; warps
    db $8b, $7, $2, ROUTE_22_GATE
    db $8b, $8, $3, ROUTE_22_GATE
    db $1f, $4, $0, VICTORY_ROAD_1
    db $1f, $e, $1, VICTORY_ROAD_2

    db $1 ; signs
    db $21, $3, $8 ; Route23Text8

    db $7 ; people
    db SPRITE_GUARD, $23 + 4, $4 + 4, $ff, $d0, $1 ; person
    db SPRITE_GUARD, $38 + 4, $a + 4, $ff, $d0, $2 ; person
    db SPRITE_SWIMMER, $55 + 4, $8 + 4, $ff, $d0, $3 ; person
    db SPRITE_SWIMMER, $60 + 4, $b + 4, $ff, $d0, $4 ; person
    db SPRITE_GUARD, $69 + 4, $c + 4, $ff, $d0, $5 ; person
    db SPRITE_GUARD, $77 + 4, $8 + 4, $ff, $d0, $6 ; person
    db SPRITE_GUARD, $88 + 4, $8 + 4, $ff, $d0, $7 ; person

    ; warp-to
    EVENT_DISP $a, $8b, $7 ; ROUTE_22_GATE
    EVENT_DISP $a, $8b, $8 ; ROUTE_22_GATE
    EVENT_DISP $a, $1f, $4 ; VICTORY_ROAD_1
    EVENT_DISP $a, $1f, $e ; VICTORY_ROAD_2

Route23Blocks: ; 720
    INCBIN "maps/route23.blk"

Route24_h: ; 0x50682 to 0x506a4 (34 bytes) (id=35)
    db $00 ; tileset
    db ROUTE_24_HEIGHT, ROUTE_24_WIDTH ; dimensions (y, x)
    dw Route24Blocks, Route24Texts, Route24Script ; blocks, texts, scripts
    db SOUTH | EAST ; connections

    ; connections data

	db CERULEAN_CITY
    dw CeruleanCityBlocks + 2 ; connection strip location
    dw $C6EB + (ROUTE_24_HEIGHT + 3) * (ROUTE_24_WIDTH + 6) + -3 ; current map position
    db $10, CERULEAN_CITY_WIDTH ; bigness, width
    db 0, (-5 * -2) ; alignments (y, x)
    dw $C6EF + CERULEAN_CITY_WIDTH ; window

	db ROUTE_25
    dw Route25Blocks + (ROUTE_25_WIDTH * 0) ; connection strip location
    dw $C6E5 + (ROUTE_24_WIDTH + 6) * (0 + 4) ; current map position
    db ROUTE_25_HEIGHT, ROUTE_25_WIDTH ; bigness, width
    db (0 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_25_WIDTH ; window

    ; end connections data

    dw Route24Object ; objects

Route24Object: ; 0x506a4 (size=67)
    db $2c ; border tile

    db $0 ; warps

    db $0 ; signs

    db $8 ; people
    db SPRITE_BLACK_HAIR_BOY_1, $f + 4, $b + 4, $ff, $d2, $41, ROCKET + $C8, $6 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $14 + 4, $5 + 4, $ff, $d1, $42, JR__TRAINER_M + $C8, $2 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $13 + 4, $b + 4, $ff, $d2, $43, JR__TRAINER_M + $C8, $3 ; trainer
    db SPRITE_LASS, $16 + 4, $a + 4, $ff, $d3, $44, LASS + $C8, $7 ; trainer
    db SPRITE_BUG_CATCHER, $19 + 4, $b + 4, $ff, $d2, $45, YOUNGSTER + $C8, $4 ; trainer
    db SPRITE_LASS, $1c + 4, $a + 4, $ff, $d3, $46, LASS + $C8, $8 ; trainer
    db SPRITE_BUG_CATCHER, $1f + 4, $b + 4, $ff, $d2, $47, BUG_CATCHER + $C8, $9 ; trainer
	db SPRITE_BALL, $5 + 4, $a + 4, $ff, $ff, $88, TM_45 ; item

Route24Blocks: ; 180
    INCBIN "maps/route24.blk"

Route25_h: ; 0x5079b to 0x507b2 (23 bytes) (id=36)
    db $00 ; tileset
    db ROUTE_25_HEIGHT, ROUTE_25_WIDTH ; dimensions (y, x)
    dw Route25Blocks, Route25Texts, Route25Script ; blocks, texts, scripts
    db WEST ; connections

    ; connections data

	db ROUTE_24
    dw Route24Blocks - 3 + (ROUTE_24_WIDTH) ; connection strip location
    dw $C6E8 + (ROUTE_25_WIDTH + 6) * (0 + 3) ; current map position
    db $c, ROUTE_24_WIDTH ; bigness, width
    db (0 * -2), (ROUTE_24_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_24_WIDTH ; window

    ; end connections data

    dw Route25Object ; objects

Route25Object: ; 0x507b2 (size=94)
    db $2c ; border tile

    db $1 ; warps
    db $3, $2d, $0, BILLS_HOUSE

    db $1 ; signs
    db $3, $2b, $b ; Route25Text11

    db $a ; people
    db SPRITE_BUG_CATCHER, $2 + 4, $e + 4, $ff, $d0, $41, YOUNGSTER + $C8, $5 ; trainer
    db SPRITE_BUG_CATCHER, $5 + 4, $12 + 4, $ff, $d1, $42, YOUNGSTER + $C8, $6 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $4 + 4, $18 + 4, $ff, $d0, $43, JR__TRAINER_M + $C8, $2 ; trainer
    db SPRITE_LASS, $8 + 4, $12 + 4, $ff, $d3, $44, LASS + $C8, $9 ; trainer
    db SPRITE_BUG_CATCHER, $3 + 4, $20 + 4, $ff, $d2, $45, YOUNGSTER + $C8, $7 ; trainer
    db SPRITE_LASS, $4 + 4, $25 + 4, $ff, $d0, $46, LASS + $C8, $a ; trainer
    db SPRITE_HIKER, $4 + 4, $8 + 4, $ff, $d3, $47, HIKER + $C8, $2 ; trainer
    db SPRITE_HIKER, $9 + 4, $17 + 4, $ff, $d1, $48, HIKER + $C8, $3 ; trainer
    db SPRITE_HIKER, $7 + 4, $d + 4, $ff, $d3, $49, HIKER + $C8, $4 ; trainer
	db SPRITE_BALL, $2 + 4, $16 + 4, $ff, $ff, $8a, TM_19 ; item

    ; warp-to
    EVENT_DISP $1e, $3, $2d ; BILLS_HOUSE

Route25Blocks: ; 270
    INCBIN "maps/route25.blk"

IndigoPlateau_h: ; 0x5091e to 0x50935 (23 bytes) (id=9)
    db $17 ; tileset
    db INDIGO_PLATEAU_HEIGHT, INDIGO_PLATEAU_WIDTH ; dimensions (y, x)
    dw IndigoPlateauBlocks, IndigoPlateauTexts, IndigoPlateauScript ; blocks, texts, scripts
    db SOUTH ; connections

    ; connections data

	db ROUTE_23
    dw Route23Blocks ; connection strip location
    dw $C6EB + (INDIGO_PLATEAU_HEIGHT + 3) * (INDIGO_PLATEAU_WIDTH + 6) + 0 ; current map position
    db ROUTE_23_WIDTH, ROUTE_23_WIDTH ; bigness, width
    db 0, (0 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_23_WIDTH ; window

    ; end connections data

    dw IndigoPlateauObject ; objects

IndigoPlateauScript: ; 0x50935
    ret
; 0x50936

IndigoPlateauTexts:
IndigoPlateauObject: ; 0x50936 (size=20)
    db $e ; border tile

    db $2 ; warps
    db $5, $9, $0, INDIGO_PLATEAU_LOBBY
    db $5, $a, $0, INDIGO_PLATEAU_LOBBY

    db $0 ; signs

    db $0 ; people

    ; warp-to
    EVENT_DISP $a, $5, $9 ; INDIGO_PLATEAU_LOBBY
    EVENT_DISP $a, $5, $a ; INDIGO_PLATEAU_LOBBY

IndigoPlateauBlocks: ; 90
    INCBIN "maps/indigoplateau.blk"

SaffronCity_h: ; 0x509a4 to 0x509dc (56 bytes) (id=10)
    db $00 ; tileset
    db SAFFRON_CITY_HEIGHT, SAFFRON_CITY_WIDTH ; dimensions (y, x)
    dw SaffronCityBlocks, SaffronCityTexts, SaffronCityScript ; blocks, texts, scripts
    db NORTH | SOUTH | WEST | EAST ; connections

    ; connections data

	db ROUTE_5
    dw Route5Blocks + (ROUTE_5_HEIGHT - 3) * ROUTE_5_WIDTH ; connection strip location
    dw $C6EB + 5 ; current map position
    db ROUTE_5_WIDTH, ROUTE_5_WIDTH ; bigness, width
    db (ROUTE_5_HEIGHT * 2) - 1, (5 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_5_HEIGHT * (ROUTE_5_WIDTH + 6) ; window

	db ROUTE_6
    dw Route6Blocks ; connection strip location
    dw $C6EB + (SAFFRON_CITY_HEIGHT + 3) * (SAFFRON_CITY_WIDTH + 6) + 5 ; current map position
    db ROUTE_6_WIDTH, ROUTE_6_WIDTH ; bigness, width
    db 0, (5 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_6_WIDTH ; window

	db ROUTE_7
    dw Route7Blocks - 3 + (ROUTE_7_WIDTH) ; connection strip location
    dw $C6E8 + (SAFFRON_CITY_WIDTH + 6) * (4 + 3) ; current map position
    db ROUTE_7_HEIGHT, ROUTE_7_WIDTH ; bigness, width
    db (4 * -2), (ROUTE_7_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_7_WIDTH ; window

	db ROUTE_8
    dw Route8Blocks + (ROUTE_8_WIDTH * 0) ; connection strip location
    dw $C6E5 + (SAFFRON_CITY_WIDTH + 6) * (4 + 4) ; current map position
    db ROUTE_8_HEIGHT, ROUTE_8_WIDTH ; bigness, width
    db (4 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_8_WIDTH ; window

    ; end connections data

    dw SaffronCityObject ; objects

SaffronCityObject: ; 0x509dc (size=188)
    db $f ; border tile

    db $8 ; warps
    db $5, $7, $0, COPYCATS_HOUSE_1F
    db $3, $1a, $0, FIGHTINGDOJO
    db $3, $22, $0, SAFFRON_GYM
    db $b, $d, $0, SAFFRON_HOUSE_1
    db $b, $19, $0, SAFFRON_MART
    db $15, $12, $0, SILPH_CO_1F
    db $1d, $9, $0, SAFFRON_POKECENTER
    db $1d, $1d, $0, SAFFRON_HOUSE_2

    db $a ; signs
    db $5, $11, $10 ; SaffronCityText16
    db $5, $1b, $11 ; SaffronCityText17
    db $5, $23, $12 ; SaffronCityText18
    db $b, $1a, $13 ; SaffronCityText19
    db $13, $27, $14 ; SaffronCityText20
    db $15, $5, $15 ; SaffronCityText21
    db $15, $f, $16 ; SaffronCityText22
    db $1d, $a, $17 ; SaffronCityText23
    db $1d, $1b, $18 ; SaffronCityText24
    db $13, $1, $19 ; SaffronCityText25

    db $f ; people
    db SPRITE_ROCKET, $6 + 4, $7 + 4, $ff, $ff, $1 ; person
    db SPRITE_ROCKET, $8 + 4, $14 + 4, $fe, $2, $2 ; person
    db SPRITE_ROCKET, $4 + 4, $22 + 4, $ff, $ff, $3 ; person
    db SPRITE_ROCKET, $c + 4, $d + 4, $ff, $ff, $4 ; person
    db SPRITE_ROCKET, $19 + 4, $b + 4, $fe, $2, $5 ; person
    db SPRITE_ROCKET, $d + 4, $20 + 4, $fe, $2, $6 ; person
    db SPRITE_ROCKET, $1e + 4, $12 + 4, $fe, $2, $7 ; person
    db SPRITE_OAK_AIDE, $e + 4, $8 + 4, $fe, $0, $8 ; person
    db SPRITE_LAPRAS_GIVER, $17 + 4, $17 + 4, $ff, $ff, $9 ; person
    db SPRITE_ERIKA, $1e + 4, $11 + 4, $fe, $2, $a ; person
    db SPRITE_GENTLEMAN, $c + 4, $1e + 4, $ff, $d0, $b ; person
    db SPRITE_BIRD, $c + 4, $1f + 4, $ff, $d0, $c ; person
    db SPRITE_ROCKER, $8 + 4, $12 + 4, $ff, $d1, $d ; person
    db SPRITE_ROCKET, $16 + 4, $12 + 4, $ff, $d0, $e ; person
    db SPRITE_ROCKET, $16 + 4, $13 + 4, $ff, $d0, $f ; person

    ; warp-to
    EVENT_DISP $14, $5, $7 ; COPYCATS_HOUSE_1F
    EVENT_DISP $14, $3, $1a ; FIGHTINGDOJO
    EVENT_DISP $14, $3, $22 ; SAFFRON_GYM
    EVENT_DISP $14, $b, $d ; SAFFRON_HOUSE_1
    EVENT_DISP $14, $b, $19 ; SAFFRON_MART
    EVENT_DISP $14, $15, $12 ; SILPH_CO_1F
    EVENT_DISP $14, $1d, $9 ; SAFFRON_POKECENTER
    EVENT_DISP $14, $1d, $1d ; SAFFRON_HOUSE_2

SaffronCityBlocks: ; 360
    INCBIN "maps/saffroncity.blk"

SaffronCityScript: ; 0x50c00
    jp $3c3c
; 0x50c03

SaffronCityTexts: ; 0x50c03
    dw SaffronCityText1, SaffronCityText2, SaffronCityText3, SaffronCityText4, SaffronCityText5, SaffronCityText6, SaffronCityText7, SaffronCityText8, SaffronCityText9, SaffronCityText10, SaffronCityText11, SaffronCityText12, SaffronCityText13, SaffronCityText14, SaffronCityText15, SaffronCityText16, SaffronCityText17, SaffronCityText18, SaffronCityText19, SaffronCityText20, SaffronCityText21, SaffronCityText22, SaffronCityText23, SaffronCityText24, SaffronCityText25

SaffronCityText1: ; 0x50c35
    TX_FAR _SaffronCityText1
    db $50

SaffronCityText2: ; 0x50c3a
    TX_FAR _SaffronCityText2
    db $50

SaffronCityText3: ; 0x50c3f
    TX_FAR _SaffronCityText3
    db $50

SaffronCityText4: ; 0x50c44
    TX_FAR _SaffronCityText4
    db $50

SaffronCityText5: ; 0x50c49
    TX_FAR _SaffronCityText5
    db $50

SaffronCityText6: ; 0x50c4e
    TX_FAR _SaffronCityText6
    db $50

SaffronCityText7: ; 0x50c53
    TX_FAR _SaffronCityText7
    db $50

SaffronCityText8: ; 0x50c58
    TX_FAR _SaffronCityText8
    db $50

SaffronCityText9: ; 0x50c5d
    TX_FAR _SaffronCityText9
    db $50

SaffronCityText10: ; 0x50c62
    TX_FAR _SaffronCityText10
    db $50

SaffronCityText11: ; 0x50c67
    TX_FAR _SaffronCityText11
    db $50

SaffronCityText12: ; 0x50c6c
    TX_FAR _SaffronCityText12

INCBIN "baserom.gbc",$50c70,$50c72 - $50c70

SaffronCityText13: ; 0x50c72
    TX_FAR _SaffronCityText13
    db $50

SaffronCityText14: ; 0x50c77
    TX_FAR _SaffronCityText14
    db $50

SaffronCityText15: ; 0x50c7c
    TX_FAR _SaffronCityText15
    db $50

SaffronCityText16: ; 0x50c81
    TX_FAR _SaffronCityText16
    db $50

SaffronCityText17: ; 0x50c86
    TX_FAR _SaffronCityText17
    db $50

SaffronCityText18: ; 0x50c8b
    TX_FAR _SaffronCityText18
    db $50

SaffronCityText20: ; 0x50c90
    TX_FAR _SaffronCityText20
    db $50

SaffronCityText21: ; 0x50c95
    TX_FAR _SaffronCityText21
    db $50

SaffronCityText22: ; 0x50c9a
    TX_FAR _SaffronCityText22
    db $50

SaffronCityText24: ; 0x50c9f
    TX_FAR _SaffronCityText24
    db $50

SaffronCityText25: ; 0x50ca4
    TX_FAR _SaffronCityText25
    db $50

Route20Script: ; 0x50ca9
    ld hl, $d7e7
    bit 0, [hl]
    res 0, [hl]
    call nz, $4cc6
    call $3c3c
    ld hl, $4d3a
    ld de, $4d1c
    ld a, [$d628]
    call $3160
    ld [$d628], a
    ret
; 0x50cc6

INCBIN "baserom.gbc",$50cc6,$5c

Route20Texts: ; 0x50d22
    dw Route20Text1, Route20Text2, Route20Text3, Route20Text4, Route20Text5, Route20Text6, Route20Text7, Route20Text8, Route20Text9, Route20Text10, Route20Text11, Route20Text12

INCBIN "baserom.gbc",$50d3a,$79

Route20Text1: ; 0x50db3
    db $08 ; asm
    ld hl, $4d3a
    call LoadTrainerHeader
    jp $24d7

Route20Text2: ; 0x50dbd
    db $08 ; asm
    ld hl, $4d46
    call LoadTrainerHeader
    jp $24d7

Route20Text3: ; 0x50dc7
    db $08 ; asm
    ld hl, $4d52
    call LoadTrainerHeader
    jp $24d7

Route20Text4: ; 0x50dd1
    db $08 ; asm
    ld hl, $4d5e
    call LoadTrainerHeader
    jp $24d7

Route20Text5: ; 0x50ddb
    db $08 ; asm
    ld hl, $4d6a
    call LoadTrainerHeader
    jp $24d7

Route20Text6: ; 0x50de5
    db $08 ; asm
    ld hl, $4d76
    call LoadTrainerHeader
    jp $24d7

Route20Text7: ; 0x50def
    db $08 ; asm
    ld hl, $4d82
    call LoadTrainerHeader
    jp $24d7

Route20Text8: ; 0x50df9
    db $08 ; asm
    ld hl, $4d8e
    call LoadTrainerHeader
    jp $24d7

Route20Text9: ; 0x50e03
    db $08 ; asm
    ld hl, $4d9a
    call LoadTrainerHeader
    jp $24d7

Route20Text10: ; 0x50e0d
    db $08 ; asm
    ld hl, $4da6
    call LoadTrainerHeader
    jp $24d7

UnnamedText_50e17: ; 0x50e17
    TX_FAR _UnnamedText_50e17
    db $50
; 0x50e17 + 5 bytes

UnnamedText_50e1c: ; 0x50e1c
    TX_FAR _UnnamedText_50e1c
    db $50
; 0x50e1c + 5 bytes

UnnamedText_50e21: ; 0x50e21
    TX_FAR _UnnamedText_50e21
    db $50
; 0x50e21 + 5 bytes

UnnamedText_50e26: ; 0x50e26
    TX_FAR _UnnamedText_50e26
    db $50
; 0x50e26 + 5 bytes

UnnamedText_50e2b: ; 0x50e2b
    TX_FAR _UnnamedText_50e2b
    db $50
; 0x50e2b + 5 bytes

UnnamedText_50e30: ; 0x50e30
    TX_FAR _UnnamedText_50e30
    db $50
; 0x50e30 + 5 bytes

UnnamedText_50e35: ; 0x50e35
    TX_FAR _UnnamedText_50e35
    db $50
; 0x50e35 + 5 bytes

UnnamedText_50e3a: ; 0x50e3a
    TX_FAR _UnnamedText_50e3a
    db $50
; 0x50e3a + 5 bytes

UnnamedText_50e3f: ; 0x50e3f
    TX_FAR _UnnamedText_50e3f
    db $50
; 0x50e3f + 5 bytes

UnnamedText_50e44: ; 0x50e44
    TX_FAR _UnnamedText_50e44
    db $50
; 0x50e44 + 5 bytes

UnnamedText_50e49: ; 0x50e49
    TX_FAR _UnnamedText_50e49
    db $50
; 0x50e49 + 5 bytes

UnnamedText_50e4e: ; 0x50e4e
    TX_FAR _UnnamedText_50e4e
    db $50
; 0x50e4e + 5 bytes

UnnamedText_50e53: ; 0x50e53
    TX_FAR _UnnamedText_50e53
    db $50
; 0x50e53 + 5 bytes

UnnamedText_50e58: ; 0x50e58
    TX_FAR _UnnamedText_50e58
    db $50
; 0x50e58 + 5 bytes

UnnamedText_50e5d: ; 0x50e5d
    TX_FAR _UnnamedText_50e5d
    db $50
; 0x50e5d + 5 bytes

UnnamedText_50e62: ; 0x50e62
    TX_FAR _UnnamedText_50e62
    db $50
; 0x50e62 + 5 bytes

UnnamedText_50e67: ; 0x50e67
    TX_FAR _UnnamedText_50e67
    db $50
; 0x50e67 + 5 bytes

UnnamedText_50e6c: ; 0x50e6c
    TX_FAR _UnnamedText_50e6c
    db $50
; 0x50e6c + 5 bytes

UnnamedText_50e71: ; 0x50e71
    TX_FAR _UnnamedText_50e71
    db $50
; 0x50e71 + 5 bytes

UnnamedText_50e76: ; 0x50e76
    TX_FAR _UnnamedText_50e76
    db $50
; 0x50e76 + 5 bytes

UnnamedText_50e7b: ; 0x50e7b
    TX_FAR _UnnamedText_50e7b
    db $50
; 0x50e7b + 5 bytes

UnnamedText_50e80: ; 0x50e80
    TX_FAR _UnnamedText_50e80
    db $50
; 0x50e80 + 5 bytes

UnnamedText_50e85: ; 0x50e85
    TX_FAR _UnnamedText_50e85
    db $50
; 0x50e85 + 5 bytes

UnnamedText_50e8a: ; 0x50e8a
    TX_FAR _UnnamedText_50e8a
    db $50
; 0x50e8a + 5 bytes

UnnamedText_50e8f: ; 0x50e8f
    TX_FAR _UnnamedText_50e8f
    db $50
; 0x50e8f + 5 bytes

UnnamedText_50e94: ; 0x50e94
    TX_FAR _UnnamedText_50e94
    db $50
; 0x50e94 + 5 bytes

UnnamedText_50e99: ; 0x50e99
    TX_FAR _UnnamedText_50e99
    db $50
; 0x50e99 + 5 bytes

UnnamedText_50e9e: ; 0x50e9e
    TX_FAR _UnnamedText_50e9e
    db $50
; 0x50e9e + 5 bytes

UnnamedText_50ea3: ; 0x50ea3
    TX_FAR _UnnamedText_50ea3
    db $50
; 0x50ea3 + 5 bytes

UnnamedText_50ea8: ; 0x50ea8
    TX_FAR _UnnamedText_50ea8
    db $50
; 0x50ea8 + 5 bytes

Route20Text12:
Route20Text11: ; 0x50ead
    TX_FAR _Route20Text11
    db $50

Route22Script: ; 0x50eb2
    call $3c3c
    ld hl, $4ebe
    ld a, [$d60a]
    jp $3d97
; 0x50ebe

Route22Scripts: ; 0x50ebe
    dw Route22Script0, Route22Script1, Route22Script2, Route22Script3

INCBIN "baserom.gbc",$50ec6,$3a

Route22Script0: ; 0x50f00
    ld a, [$d7eb]
    bit 7, a
    ret z
    ld hl, $4f2d
    call $34bf
    ret nc
    ld a, [$cd3d]
    ld [$cf0d], a
    xor a
    ld [$ff00+$b4], a
    ld a, $f0
    ld [$cd6b], a
    ld a, $2
    ld [$d528], a
    ld a, [$d7eb]
    bit 0, a
    jr nz, .asm_50f32 ; 0x50f25 $b
    bit 1, a
    jp nz, $504e
    ret
    inc b
    dec e
    dec b
    dec e
    rst $38
.asm_50f32
    ld a, $1
    ld [$cd4f], a
    xor a
    ld [$cd50], a
    ld a, $4c
    call Predef
    ld a, [$d700]
    and a
    jr z, .asm_50f4e ; 0x50f44 $8
    ld a, $ff
    ld [$c0ee], a
    call $23b1
.asm_50f4e
    ld c, $2
    ld a, $de
    call $23a1
    ld a, $1
    ld [$ff00+$8c], a
    call $4ee6
    ld a, $1
    ld [$d60a], a
    ret
; 0x50f62

Route22Script1: ; 0x50f62
    ld a, [$d730]
    bit 0, a
    ret nz
    ld a, [$cf0d]
    cp $1
    jr nz, .asm_50f78 ; 0x50f6d $9
    ld a, $4
    ld [$d528], a
    ld a, $4
    jr .asm_50f7a ; 0x50f76 $2
.asm_50f78
    ld a, $c
.asm_50f7a
    ld [$ff00+$8d], a
    ld a, $1
    ld [$ff00+$8c], a
    call $34a6
    xor a
    ld [$cd6b], a
    ld a, $1
    ld [$ff00+$8c], a
    call $2920
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $51b7
    ld de, $51bc
    call $3354
    ld a, $e1
    ld [$d059], a
    ld hl, $4faf
    call $4ed6
    ld a, $2
    ld [$d60a], a
    ret
; 0x50faf

INCBIN "baserom.gbc",$50faf,$50fb5 - $50faf

Route22Script2: ; 0x50fb5
    ld a, [$d057]
    cp $ff
    jp z, $4ece
    ld a, [$c109]
    and a
    jr nz, .asm_50fc7 ; 0x50fc1 $4
    ld a, $4
    jr .asm_50fc9 ; 0x50fc5 $2
.asm_50fc7
    ld a, $c
.asm_50fc9
    ld [$ff00+$8d], a
    ld a, $1
    ld [$ff00+$8c], a
    call $34a6
    ld a, $f0
    ld [$cd6b], a
    ld hl, $d7eb
    set 5, [hl]
    ld a, $1
    ld [$ff00+$8c], a
    call $2920
    ld a, $ff
    ld [$c0ee], a
    call $23b1
    ld b, $2
    ld hl, $5b47
    call Bankswitch
    ld a, [$cf0d]
    cp $1
    jr nz, .asm_50fff ; 0x50ff8 $5
    call $5008
    jr .asm_51002 ; 0x50ffd $3
.asm_50fff
    call $500d
.asm_51002
    ld a, $3
    ld [$d60a], a
    ret
; 0x51008

INCBIN "baserom.gbc",$51008,$5102a - $51008

Route22Script3: ; 0x5102a
    ld a, [$d730]
    bit 0, a
    ret nz
    xor a
    ld [$cd6b], a
    ld a, $22
    ld [$cc4d], a
    ld a, $11
    call Predef
    call $2307
    ld hl, $d7eb
    res 0, [hl]
    res 7, [hl]
    ld a, $0
    ld [$d60a], a
    ret
; 0x5104e

INCBIN "baserom.gbc",$5104e,$127

Route22Texts: ; 0x51175
    dw Route22Text1, Route22Text2, Route22Text3

Route22Text1: ; 0x5117b
    db $08 ; asm
    ld a, [$d7eb]
    bit 5, a
    jr z, .asm_a88cf ; 0x51181
    ld hl, $51b2
    call PrintText
    jr .asm_48088 ; 0x51189
.asm_a88cf ; 0x5118b
    ld hl, $51ad
    call PrintText
.asm_48088 ; 0x51191
    jp $24d7

Route22Text2: ; 0x51194
    db $08 ; asm
    ld a, [$d7eb]
    bit 6, a
    jr z, .asm_58c0a ; 0x5119a
    ld hl, $51c6
    call PrintText
    jr .asm_673ee ; 0x511a2
.asm_58c0a ; 0x511a4
    ld hl, $51c1
    call PrintText
.asm_673ee ; 0x511aa
    jp $24d7

UnnamedText_511ad: ; 0x511ad
    TX_FAR _UnnamedText_511ad
    db $50
; 0x511ad + 5 bytes

UnnamedText_511b2: ; 0x511b2
    TX_FAR _UnnamedText_511b2
    db $50
; 0x511b2 + 5 bytes

UnnamedText_511b7: ; 0x511b7
    TX_FAR _UnnamedText_511b7
    db $50
; 0x511b7 + 5 bytes

UnnamedText_511bc: ; 0x511bc
    TX_FAR _UnnamedText_511bc
    db $50
; 0x511bc + 5 bytes

UnnamedText_511c1: ; 0x511c1
    TX_FAR _UnnamedText_511c1
    db $50
; 0x511c1 + 5 bytes

UnnamedText_511c6: ; 0x511c6
    TX_FAR _UnnamedText_511c6
    db $50
; 0x511c6 + 5 bytes

UnnamedText_511cb: ; 0x511cb
    TX_FAR _UnnamedText_511cb
    db $50
; 0x511cb + 5 bytes

UnnamedText_511d0: ; 0x511d0
    TX_FAR _UnnamedText_511d0
    db $50
; 0x511d0 + 5 bytes

Route22Text3: ; 0x511d5
    TX_FAR _Route22Text3
    db $50

Route23Script: ; 0x511da
    call $51e9
    call $3c3c
    ld hl, $5213
    ld a, [$d667]
    jp $3d97
; 0x511e9

INCBIN "baserom.gbc",$511e9,$51213 - $511e9

Route23Scripts: ; 0x51213
    dw Route23Script0

INCBIN "baserom.gbc",$51215,$4

Route23Script0: ; 0x51219
    ld hl, $5255
    ld a, [$d361]
    ld b, a
    ld e, $0
    ld c, $7
.asm_51224
    ld a, [hli]
    cp $ff
    ret z
    inc e
    dec c
    cp b
    jr nz, .asm_51224 ; 0x5122b $f7
    cp $23
    jr nz, .asm_51237 ; 0x5122f $6
    ld a, [$d362]
    cp $e
    ret nc
.asm_51237
    ld a, e
    ld [$ff00+$8c], a
    ld a, c
    ld [$cd3d], a
    ld b, $2
    ld hl, $d7ed
    ld a, $10
    call Predef
    ld a, c
    and a
    ret nz
    call $525d
    call $2920
    xor a
    ld [$ff00+$b4], a
    ret
; 0x51255

INCBIN "baserom.gbc",$51255,$a2

Route23Texts: ; 0x512f7
    dw Route23Text1, Route23Text2, Route23Text3, Route23Text4, Route23Text5, Route23Text6, Route23Text7, Route23Text8

Route23Text1: ; 0x51307
    db $08 ; asm
    ld a, $6
    call $5346
    jp $24d7

Route23Text2: ; 0x51310
    db $08 ; asm
    ld a, $5
    call $5346
    jp $24d7

Route23Text3: ; 0x51319
    db $08 ; asm
    ld a, $4
    call $5346
    jp $24d7

Route23Text4: ; 0x51322
    db $08 ; asm
    ld a, $3
    call $5346
    jp $24d7

Route23Text5: ; 0x5132b
    db $08 ; asm
    ld a, $2
    call $5346
    jp $24d7

Route23Text6: ; 0x51334
    db $08 ; asm
    ld a, $1
    call $5346
    jp $24d7

Route23Text7: ; 0x5133d
    db $8
    ld a, $0
    call $5346
    jp $24d7
; 0x51346

INCBIN "baserom.gbc",$51346,$513a3 - $51346

UnnamedText_513a3: ; 0x513a3
    TX_FAR _UnnamedText_513a3
    db $50
; 0x513a3 + 5 bytes

Route23Text8: ; 0x513a8
    TX_FAR _Route23Text8
    db $50

Route24Script: ; 0x513ad
    call $3c3c
    ld hl, $545b
    ld de, $53cb
    ld a, [$d602]
    call $3160
    ld [$d602], a
    ret
; 0x513c0

INCBIN "baserom.gbc",$513c0,$8b

Route24Texts: ; 0x5144b
    dw Route24Text1, Route24Text2, Route24Text3, Route24Text4, Route24Text5, Route24Text6, Route24Text7, Route24Text8

INCBIN "baserom.gbc",$5145b,$49

Route24Text1: ; 0x514a4
    db $8
    ld hl, $d7f0
    res 1, [hl]
    ld a, [$d7ef]
    bit 0, a
    jr nz, .asm_a03f5 ; 0x514af $48
    ld hl, $5510
    call PrintText
    ld bc, $3101
    call GiveItem
    jr nc, .asm_3a23d ; 0x514bd $43
    ld hl, $d7ef
    set 0, [hl]
    ld hl, $551a
    call PrintText
    ld hl, $5526
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $552b
    ld de, $552b
    call $3354
    ld a, [$ff00+$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    xor a
    ld [$ff00+$b4], a
    ld a, $3
    ld [$d602], a
    ld [$da39], a
    jp $24d7
.asm_a03f5 ; 0x514f9
    ld hl, $5530
    call PrintText
    jp $24d7
.asm_3a23d ; 0x51502
    ld hl, $5521
    call PrintText
    ld hl, $d7f0
    set 1, [hl]
    jp $24d7
; 0x51510

INCBIN "baserom.gbc",$51510,$51515 - $51510

UnnamedText_51515: ; 0x51515
    TX_FAR _UnnamedText_51515
    db $50
; 0x51515 + 5 bytes

INCBIN "baserom.gbc",$5151a,$51521 - $5151a

UnnamedText_51521: ; 0x51521
    TX_FAR _UnnamedText_51521
    db $50
; 0x51521 + 5 bytes

UnnamedText_51526: ; 0x51526
    TX_FAR _UnnamedText_51526
    db $50
; 0x51526 + 5 bytes

UnnamedText_5152b: ; 0x5152b
    TX_FAR _UnnamedText_5152b
    db $50
; 0x5152b + 5 bytes

UnnamedText_51530: ; 0x51530
    TX_FAR _UnnamedText_51530
    db $50
; 0x51530 + 5 bytes

Route24Text2: ; 0x51535
    db $08 ; asm
    ld hl, $545b
    call LoadTrainerHeader
    jp $24d7

Route24Text3: ; 0x5153f
    db $08 ; asm
    ld hl, $5467
    call LoadTrainerHeader
    jp $24d7

Route24Text4: ; 0x51549
    db $08 ; asm
    ld hl, $5473
    call LoadTrainerHeader
    jp $24d7

Route24Text5: ; 0x51553
    db $08 ; asm
    ld hl, $547f
    call LoadTrainerHeader
    jp $24d7

Route24Text6: ; 0x5155d
    db $08 ; asm
    ld hl, $548b
    call LoadTrainerHeader
    jp $24d7

Route24Text7: ; 0x51567
    db $08 ; asm
    ld hl, $5497
    call LoadTrainerHeader
    jp $24d7

UnnamedText_51571: ; 0x51571
    TX_FAR _UnnamedText_51571
    db $50
; 0x51571 + 5 bytes

UnnamedText_51576: ; 0x51576
    TX_FAR _UnnamedText_51576
    db $50
; 0x51576 + 5 bytes

UnnamedText_5157b: ; 0x5157b
    TX_FAR _UnnamedText_5157b
    db $50
; 0x5157b + 5 bytes

UnnamedText_51580: ; 0x51580
    TX_FAR _UnnamedText_51580
    db $50
; 0x51580 + 5 bytes

UnnamedText_51585: ; 0x51585
    TX_FAR _UnnamedText_51585
    db $50
; 0x51585 + 5 bytes

UnnamedText_5158a: ; 0x5158a
    TX_FAR _UnnamedText_5158a
    db $50
; 0x5158a + 5 bytes

UnnamedText_5158f: ; 0x5158f
    TX_FAR _UnnamedText_5158f
    db $50
; 0x5158f + 5 bytes

UnnamedText_51594: ; 0x51594
    TX_FAR _UnnamedText_51594
    db $50
; 0x51594 + 5 bytes

UnnamedText_51599: ; 0x51599
    TX_FAR _UnnamedText_51599
    db $50
; 0x51599 + 5 bytes

UnnamedText_5159e: ; 0x5159e
    TX_FAR _UnnamedText_5159e
    db $50
; 0x5159e + 5 bytes

UnnamedText_515a3: ; 0x515a3
    TX_FAR _UnnamedText_515a3
    db $50
; 0x515a3 + 5 bytes

UnnamedText_515a8: ; 0x515a8
    TX_FAR _UnnamedText_515a8
    db $50
; 0x515a8 + 5 bytes

UnnamedText_515ad: ; 0x515ad
    TX_FAR _UnnamedText_515ad
    db $50
; 0x515ad + 5 bytes

UnnamedText_515b2: ; 0x515b2
    TX_FAR _UnnamedText_515b2
    db $50
; 0x515b2 + 5 bytes

UnnamedText_515b7: ; 0x515b7
    TX_FAR _UnnamedText_515b7
    db $50
; 0x515b7 + 5 bytes

UnnamedText_515bc: ; 0x515bc
    TX_FAR _UnnamedText_515bc
    db $50
; 0x515bc + 5 bytes

UnnamedText_515c1: ; 0x515c1
    TX_FAR _UnnamedText_515c1
    db $50
; 0x515c1 + 5 bytes

UnnamedText_515c6: ; 0x515c6
    TX_FAR _UnnamedText_515c6
    db $50
; 0x515c6 + 5 bytes

Route25Script: ; 0x515cb
    call $55e1
    call $3c3c
    ld hl, $563e
    ld de, $5622
    ld a, [$d603]
    call $3160
    ld [$d603], a
    ret
; 0x515e1

INCBIN "baserom.gbc",$515e1,$47

Route25Texts: ; 0x51628
    dw Route25Text1, Route25Text2, Route25Text3, Route25Text4, Route25Text5, Route25Text6, Route25Text7, Route25Text8, Route25Text9, Route25Text10, Route25Text11

INCBIN "baserom.gbc",$5163e,$6d

Route25Text1: ; 0x516ab
    db $08 ; asm
    ld hl, $563e
    call LoadTrainerHeader
    jp $24d7

Route25Text2: ; 0x516b5
    db $08 ; asm
    ld hl, $564a
    call LoadTrainerHeader
    jp $24d7

Route25Text3: ; 0x516bf
    db $08 ; asm
    ld hl, $5656
    call LoadTrainerHeader
    jp $24d7

Route25Text4: ; 0x516c9
    db $08 ; asm
    ld hl, $5662
    call LoadTrainerHeader
    jp $24d7

Route25Text5: ; 0x516d3
    db $08 ; asm
    ld hl, $566e
    call LoadTrainerHeader
    jp $24d7

Route25Text6: ; 0x516dd
    db $08 ; asm
    ld hl, $567a
    call LoadTrainerHeader
    jp $24d7

Route25Text7: ; 0x516e7
    db $08 ; asm
    ld hl, $5686
    call LoadTrainerHeader
    jp $24d7

Route25Text8: ; 0x516f1
    db $08 ; asm
    ld hl, $5692
    call LoadTrainerHeader
    jp $24d7

Route25Text9: ; 0x516fb
    db $08 ; asm
    ld hl, $569e
    call LoadTrainerHeader
    jp $24d7

UnnamedText_51705: ; 0x51705
    TX_FAR _UnnamedText_51705
    db $50
; 0x51705 + 5 bytes

UnnamedText_5170a: ; 0x5170a
    TX_FAR _UnnamedText_5170a
    db $50
; 0x5170a + 5 bytes

UnnamedText_5170f: ; 0x5170f
    TX_FAR _UnnamedText_5170f
    db $50
; 0x5170f + 5 bytes

UnnamedText_51714: ; 0x51714
    TX_FAR _UnnamedText_51714
    db $50
; 0x51714 + 5 bytes

UnnamedText_51719: ; 0x51719
    TX_FAR _UnnamedText_51719
    db $50
; 0x51719 + 5 bytes

UnnamedText_5171e: ; 0x5171e
    TX_FAR _UnnamedText_5171e
    db $50
; 0x5171e + 5 bytes

UnnamedText_51723: ; 0x51723
    TX_FAR _UnnamedText_51723
    db $50
; 0x51723 + 5 bytes

UnnamedText_51728: ; 0x51728
    TX_FAR _UnnamedText_51728
    db $50
; 0x51728 + 5 bytes

UnnamedText_5172d: ; 0x5172d
    TX_FAR _UnnamedText_5172d
    db $50
; 0x5172d + 5 bytes

UnnamedText_51732: ; 0x51732
    TX_FAR _UnnamedText_51732
    db $50
; 0x51732 + 5 bytes

UnnamedText_51737: ; 0x51737
    TX_FAR _UnnamedText_51737
    db $50
; 0x51737 + 5 bytes

UnnamedText_5173c: ; 0x5173c
    TX_FAR _UnnamedText_5173c
    db $50
; 0x5173c + 5 bytes

UnnamedText_51741: ; 0x51741
    TX_FAR _UnnamedText_51741
    db $50
; 0x51741 + 5 bytes

UnnamedText_51746: ; 0x51746
    TX_FAR _UnnamedText_51746
    db $50
; 0x51746 + 5 bytes

UnnamedText_5174b: ; 0x5174b
    TX_FAR _UnnamedText_5174b
    db $50
; 0x5174b + 5 bytes

UnnamedText_51750: ; 0x51750
    TX_FAR _UnnamedText_51750
    db $50
; 0x51750 + 5 bytes

UnnamedText_51755: ; 0x51755
    TX_FAR _UnnamedText_51755
    db $50
; 0x51755 + 5 bytes

UnnamedText_5175a: ; 0x5175a
    TX_FAR _UnnamedText_5175a
    db $50
; 0x5175a + 5 bytes

UnnamedText_5175f: ; 0x5175f
    TX_FAR _UnnamedText_5175f
    db $50
; 0x5175f + 5 bytes

UnnamedText_51764: ; 0x51764
    TX_FAR _UnnamedText_51764
    db $50
; 0x51764 + 5 bytes

UnnamedText_51769: ; 0x51769
    TX_FAR _UnnamedText_51769
    db $50
; 0x51769 + 5 bytes

UnnamedText_5176e: ; 0x5176e
    TX_FAR _UnnamedText_5176e
    db $50
; 0x5176e + 5 bytes

UnnamedText_51773: ; 0x51773
    TX_FAR _UnnamedText_51773
    db $50
; 0x51773 + 5 bytes

UnnamedText_51778: ; 0x51778
    TX_FAR _UnnamedText_51778
    db $50
; 0x51778 + 5 bytes

UnnamedText_5177d: ; 0x5177d
    TX_FAR _UnnamedText_5177d
    db $50
; 0x5177d + 5 bytes

UnnamedText_51782: ; 0x51782
    TX_FAR _UnnamedText_51782
    db $50
; 0x51782 + 5 bytes

UnnamedText_51787: ; 0x51787
    TX_FAR _UnnamedText_51787
    db $50
; 0x51787 + 5 bytes

Route25Text11: ; 0x5178c
    TX_FAR _Route25Text11
    db $50

VictoryRoad2_h: ; 0x51791 to 0x5179d (12 bytes) (id=194)
    db $11 ; tileset
    db VICTORY_ROAD_2_HEIGHT, VICTORY_ROAD_2_WIDTH ; dimensions (y, x)
    dw VictoryRoad2Blocks, VictoryRoad2Texts, VictoryRoad2Script ; blocks, texts, scripts
    db $00 ; connections

    dw VictoryRoad2Object ; objects

VictoryRoad2Script: ; 0x5179d
    ld hl, $d126
    bit 6, [hl]
    res 6, [hl]
    call nz, $57c4
    ld hl, $d126
    bit 5, [hl]
    res 5, [hl]
    call nz, $57c9
    call $3c3c
    ld hl, $5835
    ld de, $57eb
    ld a, [$d63f]
    call $3160
    ld [$d63f], a
    ret
; 0x517c4

INCBIN "baserom.gbc",$517c4,$57

VictoryRoad2Texts: ; 0x5181b
    dw VictoryRoad2Text1, VictoryRoad2Text2, VictoryRoad2Text3, VictoryRoad2Text4, VictoryRoad2Text5, VictoryRoad2Text6, VictoryRoad2Text7, VictoryRoad2Text8, VictoryRoad2Text9, VictoryRoad2Text10, VictoryRoad2Text11, VictoryRoad2Text12, VictoryRoad2Text13

INCBIN "baserom.gbc",$51835,$49

VictoryRoad2Text1: ; 0x5187e
    db $08 ; asm
    ld hl, $5835
    call LoadTrainerHeader
    jp $24d7

VictoryRoad2Text2: ; 0x51888
    db $08 ; asm
    ld hl, $5841
    call LoadTrainerHeader
    jp $24d7

VictoryRoad2Text3: ; 0x51892
    db $08 ; asm
    ld hl, $584d
    call LoadTrainerHeader
    jp $24d7

VictoryRoad2Text4: ; 0x5189c
    db $08 ; asm
    ld hl, $5859
    call LoadTrainerHeader
    jp $24d7

VictoryRoad2Text5: ; 0x518a6
    db $08 ; asm
    ld hl, $5865
    call LoadTrainerHeader
    jp $24d7

VictoryRoad2Text6: ; 0x518b0
    db $08 ; asm
    ld hl, $5871
    call LoadTrainerHeader
    jp $24d7

INCBIN "baserom.gbc",$518ba,$518ca - $518ba

UnnamedText_518ca: ; 0x518ca
    TX_FAR _UnnamedText_518ca
    db $50
; 0x518ca + 5 bytes

UnnamedText_518cf: ; 0x518cf
    TX_FAR _UnnamedText_518cf
    db $50
; 0x518cf + 5 bytes

UnnamedText_518d4: ; 0x518d4
    TX_FAR _UnnamedText_518d4
    db $50
; 0x518d4 + 5 bytes

UnnamedText_518d9: ; 0x518d9
    TX_FAR _UnnamedText_518d9
    db $50
; 0x518d9 + 5 bytes

UnnamedText_518de: ; 0x518de
    TX_FAR _UnnamedText_518de
    db $50
; 0x518de + 5 bytes

UnnamedText_518e3: ; 0x518e3
    TX_FAR _UnnamedText_518e3
    db $50
; 0x518e3 + 5 bytes

UnnamedText_518e8: ; 0x518e8
    TX_FAR _UnnamedText_518e8
    db $50
; 0x518e8 + 5 bytes

UnnamedText_518ed: ; 0x518ed
    TX_FAR _UnnamedText_518ed
    db $50
; 0x518ed + 5 bytes

UnnamedText_518f2: ; 0x518f2
    TX_FAR _UnnamedText_518f2
    db $50
; 0x518f2 + 5 bytes

UnnamedText_518f7: ; 0x518f7
    TX_FAR _UnnamedText_518f7
    db $50
; 0x518f7 + 5 bytes

UnnamedText_518fc: ; 0x518fc
    TX_FAR _UnnamedText_518fc
    db $50
; 0x518fc + 5 bytes

UnnamedText_51901: ; 0x51901
    TX_FAR _UnnamedText_51901
    db $50
; 0x51901 + 5 bytes

UnnamedText_51906: ; 0x51906
    TX_FAR _UnnamedText_51906
    db $50
; 0x51906 + 5 bytes

UnnamedText_5190b: ; 0x5190b
    TX_FAR _UnnamedText_5190b
    db $50
; 0x5190b + 5 bytes

UnnamedText_51910: ; 0x51910
    TX_FAR _UnnamedText_51910
    db $50
; 0x51910 + 5 bytes

VictoryRoad2Object: ; 0x51915 (size=154)
    db $7d ; border tile

    db $7 ; warps
    db $8, $0, $2, VICTORY_ROAD_1
    db $7, $1d, $3, $ff
    db $8, $1d, $3, $ff
    db $7, $17, $0, VICTORY_ROAD_3
    db $e, $19, $2, VICTORY_ROAD_3
    db $7, $1b, $1, VICTORY_ROAD_3
    db $1, $1, $3, VICTORY_ROAD_3

    db $0 ; signs

    db $d ; people
    db SPRITE_HIKER, $9 + 4, $c + 4, $ff, $d2, $41, BLACKBELT + $C8, $9 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $d + 4, $15 + 4, $ff, $d2, $42, JUGGLER + $C8, $2 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $8 + 4, $13 + 4, $ff, $d0, $43, TAMER + $C8, $5 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $2 + 4, $4 + 4, $ff, $d0, $44, POKEMANIAC + $C8, $6 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $3 + 4, $1a + 4, $ff, $d2, $45, JUGGLER + $C8, $5 ; trainer
    db SPRITE_BIRD, $5 + 4, $b + 4, $ff, $d1, $46, MOLTRES, $32 ; trainer
	db SPRITE_BALL, $5 + 4, $1b + 4, $ff, $ff, $87, TM_17 ; item
	db SPRITE_BALL, $9 + 4, $12 + 4, $ff, $ff, $88, FULL_HEAL ; item
	db SPRITE_BALL, $b + 4, $9 + 4, $ff, $ff, $89, TM_05 ; item
	db SPRITE_BALL, $0 + 4, $b + 4, $ff, $ff, $8a, GUARD_SPEC_ ; item
    db SPRITE_BOULDER, $e + 4, $4 + 4, $ff, $10, $b ; person
    db SPRITE_BOULDER, $5 + 4, $5 + 4, $ff, $10, $c ; person
    db SPRITE_BOULDER, $10 + 4, $17 + 4, $ff, $10, $d ; person

    ; warp-to
    EVENT_DISP $f, $8, $0 ; VICTORY_ROAD_1
    EVENT_DISP $f, $7, $1d
    EVENT_DISP $f, $8, $1d
    EVENT_DISP $f, $7, $17 ; VICTORY_ROAD_3
    EVENT_DISP $f, $e, $19 ; VICTORY_ROAD_3
    EVENT_DISP $f, $7, $1b ; VICTORY_ROAD_3
    EVENT_DISP $f, $1, $1 ; VICTORY_ROAD_3

VictoryRoad2Blocks: ; 135
    INCBIN "maps/victoryroad2.blk"

MtMoon2_h: ; 0x51a36 to 0x51a42 (12 bytes) (id=60)
    db $11 ; tileset
    db MT_MOON_2_HEIGHT, MT_MOON_2_WIDTH ; dimensions (y, x)
    dw MtMoon2Blocks, MtMoon2Texts, MtMoon2Script ; blocks, texts, scripts
    db $00 ; connections

    dw MtMoon2Object ; objects

MtMoon2Script: ; 0x51a42
    call $3c3c
    ret
; 0x51a46

MtMoon2Texts:
    dw MtMoonText1

MtMoonText1: ; 0x51a48
    TX_FAR _UnnamedText_51a48
    db $50
; 0x51a48 + 5 bytes

MtMoon2Object: ; 0x51a4d (size=68)
    db $3 ; border tile

    db $8 ; warps
    db $5, $5, $2, MT_MOON_1
    db $b, $11, $0, MT_MOON_3
    db $9, $19, $3, MT_MOON_1
    db $f, $19, $4, MT_MOON_1
    db $11, $15, $1, MT_MOON_3
    db $1b, $d, $2, MT_MOON_3
    db $3, $17, $3, MT_MOON_3
    db $3, $1b, $2, $ff

    db $0 ; signs

    db $0 ; people

    ; warp-to
    EVENT_DISP $e, $5, $5 ; MT_MOON_1
    EVENT_DISP $e, $b, $11 ; MT_MOON_3
    EVENT_DISP $e, $9, $19 ; MT_MOON_1
    EVENT_DISP $e, $f, $19 ; MT_MOON_1
    EVENT_DISP $e, $11, $15 ; MT_MOON_3
    EVENT_DISP $e, $1b, $d ; MT_MOON_3
    EVENT_DISP $e, $3, $17 ; MT_MOON_3
    EVENT_DISP $e, $3, $1b

MtMoon2Blocks: ; 196
    INCBIN "maps/mtmoon2.blk"

SilphCo7_h: ; 0x51b55 to 0x51b61 (12 bytes) (id=212)
    db $16 ; tileset
    db SILPH_CO_7F_HEIGHT, SILPH_CO_7F_WIDTH ; dimensions (y, x)
    dw SilphCo7Blocks, SilphCo7Texts, SilphCo7Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo7Object ; objects

SilphCo7Script: ; 0x51b61
    call $5b77
    call $3c3c
    ld hl, $5d5d
    ld de, $5c17
    ld a, [$d648]
    call $3160
    ld [$d648], a
    ret
; 0x51b77

INCBIN "baserom.gbc",$51b77,$1c8

SilphCo7Texts: ; 0x51d3f
    dw SilphCo7Text1, SilphCo7Text2, SilphCo7Text3, SilphCo7Text4, SilphCo7Text5, SilphCo7Text6, SilphCo7Text7, SilphCo7Text8, SilphCo7Text9, SilphCo7Text10, SilphCo7Text11, SilphCo7Text12, SilphCo7Text13, SilphCo7Text14, SilphCo7Text15

INCBIN "baserom.gbc",$51d55 + 8,$39 - 8

SilphCo7Text1: ; 0x51d8e
    db $08 ; asm
    ld a, [$d72e]
    bit 0, a
    jr z, .asm_d7e17 ; 0x51d94
    ld a, [$d838]
    bit 7, a
    jr nz, .asm_688b4 ; 0x51d9b
    ld hl, $5ddd
    call PrintText
    jr .asm_b3069 ; 0x51da3
.asm_d7e17 ; 0x51da5
    ld hl, $5dd3
    call PrintText
	ld bc,(LAPRAS << 8) | 15
    call GivePokemon
    jr nc, .asm_b3069 ; 0x51db1
    ld a, [$ccd3]
    and a
    call z, $3865
    call $3c3c
    ld hl, $5dd8
    call PrintText
    ld hl, $d72e
    set 0, [hl]
    jr .asm_b3069 ; 0x51dc8
.asm_688b4 ; 0x51dca
    ld hl, $5de2
    call PrintText
.asm_b3069 ; 0x51dd0
    jp $24d7

UnnamedText_51dd3: ; 0x51dd3
    TX_FAR _UnnamedText_51dd3
    db $50
; 0x51dd3 + 5 bytes

UnnamedText_51dd8: ; 0x51dd8
    TX_FAR _UnnamedText_51dd8
    db $50
; 0x51dd8 + 5 bytes

UnnamedText_51ddd: ; 0x51ddd
    TX_FAR _UnnamedText_51ddd
    db $50
; 0x51ddd + 5 bytes

UnnamedText_51de2: ; 0x51de2
    TX_FAR _UnnamedText_51de2
    db $50
; 0x51de2 + 5 bytes

SilphCo7Text2: ; 0x51de7
    db $8
    ld a, [$d838]
    bit 7, a
    jr nz, .asm_892ce ; 0x51ded $8
    ld hl, $5e00
    call PrintText
    jr .asm_e4d89 ; 0x51df5 $6
.asm_892ce ; 0x51df7
    ld hl, $5e05
    call PrintText
.asm_e4d89 ; 0x51dfd
    jp $24d7
; 0x51e00

UnnamedText_51e00: ; 0x51e00
    TX_FAR _UnnamedText_51e00
    db $50
; 0x51e00 + 5 bytes

UnnamedText_51e05: ; 0x51e05
    TX_FAR _UnnamedText_51e05
    db $50
; 0x51e05 + 5 bytes

SilphCo7Text3: ; 0x51e0a
    db $08 ; asm
    ld a, [$d838]
    bit 7, a
    jr nz, .asm_254aa ; 0x51e10
    ld hl, $5e23
    call PrintText
    jr .asm_6472b ; 0x51e18
.asm_254aa ; 0x51e1a
    ld hl, $5e28
    call PrintText
.asm_6472b ; 0x51e20
    jp $24d7

UnnamedText_51e23: ; 0x51e23
    TX_FAR _UnnamedText_51e23
    db $50
; 0x51e23 + 5 bytes

UnnamedText_51e28: ; 0x51e28
    TX_FAR _UnnamedText_51e28
    db $50
; 0x51e28 + 5 bytes

SilphCo7Text4: ; 0x51e2d
    db $08 ; asm
    ld a, [$d838]
    bit 7, a
    jr nz, .asm_0f7ee ; 0x51e33
    ld hl, $5e46
    call PrintText
    jr .asm_27a32 ; 0x51e3b
.asm_0f7ee ; 0x51e3d
    ld hl, $5e4b
    call PrintText
.asm_27a32 ; 0x51e43
    jp $24d7

UnnamedText_51e46: ; 0x51e46
    TX_FAR _UnnamedText_51e46
    db $50
; 0x51e46 + 5 bytes

UnnamedText_51e4b: ; 0x51e4b
    TX_FAR _UnnamedText_51e4b
    db $50
; 0x51e4b + 5 bytes

SilphCo7Text5: ; 0x51e50
    db $08 ; asm
    ld hl, $5d5d
    call LoadTrainerHeader
    jp $24d7

UnnamedText_51e5a: ; 0x51e5a
    TX_FAR _UnnamedText_51e5a
    db $50
; 0x51e5a + 5 bytes

UnnamedText_51e5f: ; 0x51e5f
    TX_FAR _UnnamedText_51e5f
    db $50
; 0x51e5f + 5 bytes

UnnamedText_51e64: ; 0x51e64
    TX_FAR _UnnamedText_51e64
    db $50
; 0x51e64 + 5 bytes

SilphCo7Text6: ; 0x51e69
    db $08 ; asm
    ld hl, $5d69
    call LoadTrainerHeader
    jp $24d7

UnnamedText_51e73: ; 0x51e73
    TX_FAR _UnnamedText_51e73
    db $50
; 0x51e73 + 5 bytes

UnnamedText_51e78: ; 0x51e78
    TX_FAR _UnnamedText_51e78
    db $50
; 0x51e78 + 5 bytes

UnnamedText_51e7d: ; 0x51e7d
    TX_FAR _UnnamedText_51e7d
    db $50
; 0x51e7d + 5 bytes

SilphCo7Text7: ; 0x51e82
    db $08 ; asm
    ld hl, $5d75
    call LoadTrainerHeader
    jp $24d7

UnnamedText_51e8c: ; 0x51e8c
    TX_FAR _UnnamedText_51e8c
    db $50
; 0x51e8c + 5 bytes

UnnamedText_51e91: ; 0x51e91
    TX_FAR _UnnamedText_51e91
    db $50
; 0x51e91 + 5 bytes

UnnamedText_51e96: ; 0x51e96
    TX_FAR _UnnamedText_51e96
    db $50
; 0x51e96 + 5 bytes

SilphCo7Text8: ; 0x51e9b
    db $08 ; asm
    ld hl, $5d81
    call LoadTrainerHeader
    jp $24d7

UnnamedText_51ea5: ; 0x51ea5
    TX_FAR _UnnamedText_51ea5
    db $50
; 0x51ea5 + 5 bytes

UnnamedText_51eaa: ; 0x51eaa
    TX_FAR _UnnamedText_51eaa
    db $50
; 0x51eaa + 5 bytes

UnnamedText_51eaf: ; 0x51eaf
    TX_FAR _UnnamedText_51eaf
    db $50
; 0x51eaf + 5 bytes

SilphCo7Text9: ; 0x51eb4
    db $08 ; asm
    ld hl, $5ebe
    call PrintText
    jp $24d7

UnnamedText_51ebe: ; 0x51ebe
    TX_FAR _UnnamedText_51ebe
    db $50
; 0x51ebe + 5 bytes

SilphCo7Text13: ; 0x51ec3
    TX_FAR _UnnamedText_51ec3
    db $50
; 0x51ec3 + 5 bytes

SilphCo7Text14: ; 0x51ec8
    TX_FAR _UnnamedText_51ec8
    db $50
; 0x51ec8 + 5 bytes

UnnamedText_51ecd: ; 0x51ecd
    TX_FAR _UnnamedText_51ecd
    db $50
; 0x51ecd + 5 bytes

SilphCo7Text15: ; 0x51ed2
    TX_FAR _UnnamedText_51ed2
    db $50
; 0x51ed2 + 5 bytes

SilphCo7Object: ; 0x51ed7 (size=128)
    db $2e ; border tile

    db $6 ; warps
    db $0, $10, $1, SILPH_CO_8F
    db $0, $16, $0, SILPH_CO_6F
    db $0, $12, $0, SILPH_CO_ELEVATOR
    db $7, $5, $3, SILPH_CO_11F
    db $3, $5, $8, SILPH_CO_3F
    db $f, $15, $3, SILPH_CO_5F

    db $0 ; signs

    db $b ; people
    db SPRITE_LAPRAS_GIVER, $5 + 4, $1 + 4, $ff, $ff, $1 ; person
    db SPRITE_LAPRAS_GIVER, $d + 4, $d + 4, $ff, $d1, $2 ; person
    db SPRITE_LAPRAS_GIVER, $a + 4, $7 + 4, $ff, $ff, $3 ; person
    db SPRITE_ERIKA, $8 + 4, $a + 4, $ff, $ff, $4 ; person
    db SPRITE_ROCKET, $1 + 4, $d + 4, $ff, $d0, $45, ROCKET + $C8, $20 ; trainer
    db SPRITE_OAK_AIDE, $d + 4, $2 + 4, $ff, $d0, $46, SCIENTIST + $C8, $8 ; trainer
    db SPRITE_ROCKET, $2 + 4, $14 + 4, $ff, $d2, $47, ROCKET + $C8, $21 ; trainer
    db SPRITE_ROCKET, $e + 4, $13 + 4, $ff, $d3, $48, ROCKET + $C8, $22 ; trainer
    db SPRITE_BLUE, $7 + 4, $3 + 4, $ff, $d1, $9 ; person
	db SPRITE_BALL, $9 + 4, $1 + 4, $ff, $ff, $8a, CALCIUM ; item
	db SPRITE_BALL, $b + 4, $18 + 4, $ff, $ff, $8b, TM_03 ; item

    ; warp-to
    EVENT_DISP $d, $0, $10 ; SILPH_CO_8F
    EVENT_DISP $d, $0, $16 ; SILPH_CO_6F
    EVENT_DISP $d, $0, $12 ; SILPH_CO_ELEVATOR
    EVENT_DISP $d, $7, $5 ; SILPH_CO_11F
    EVENT_DISP $d, $3, $5 ; SILPH_CO_3F
    EVENT_DISP $d, $f, $15 ; SILPH_CO_5F

SilphCo7Blocks: ; 117
    INCBIN "maps/silphco7.blk"

Mansion2_h: ; 0x51fcc to 0x51fd8 (12 bytes) (id=214)
    db $16 ; tileset
    db MANSION_2_HEIGHT, MANSION_2_WIDTH ; dimensions (y, x)
    dw Mansion2Blocks, Mansion2Texts, Mansion2Script ; blocks, texts, scripts
    db $00 ; connections

    dw Mansion2Object ; objects

Mansion2Script:
    call $5fee
    call $3c3c
    ld hl, $6057
    ld de, $6047
    ld a, [$d63c]
    call $3160
    ld [$d63c], a
    ret
; 0x51fee

INCBIN "baserom.gbc",$51fee,$5204d - $51fee

Mansion2Texts: ; 0x5204d

INCBIN "baserom.gbc",$5204d,23

Mansion2Text1: ; 0x52064
    db $08 ; asm
    ld hl, $6057
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5206e: ; 0x5206e
    TX_FAR _UnnamedText_5206e
    db $50
; 0x5206e + 5 bytes

UnnamedText_52073: ; 0x52073
    TX_FAR _UnnamedText_52073
    db $50
; 0x52073 + 5 bytes

UnnamedText_52078: ; 0x52078
    TX_FAR _UnnamedText_52078
    db $50
; 0x52078 + 5 bytes

Mansion2Text3: ; 0x5207d
    TX_FAR _Mansion2Text3
    db $50

Mansion2Text4: ; 0x52082
    TX_FAR _Mansion2Text4
    db $50

INCBIN "baserom.gbc",$52087,$520c2 - $52087

UnnamedText_520c2: ; 0x520c2
    TX_FAR _UnnamedText_520c2
    db $50
; 0x520c2 + 5 bytes

UnnamedText_520c7: ; 0x520c7
    TX_FAR _UnnamedText_520c7
    db $50
; 0x520c7 + 5 bytes

UnnamedText_520cc: ; 0x520cc
    TX_FAR _UnnamedText_520cc
    db $50
; 0x520cc + 5 bytes

Mansion2Object: ; 0x520d1 (size=63)
    db $1 ; border tile

    db $4 ; warps
    db $a, $5, $4, MANSION_1
    db $a, $7, $0, MANSION_3
    db $e, $19, $2, MANSION_3
    db $1, $6, $1, MANSION_3

    db $0 ; signs

    db $4 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $11 + 4, $3 + 4, $fe, $2, $41, BURGLAR + $C8, $7 ; trainer
	db SPRITE_BALL, $7 + 4, $1c + 4, $ff, $ff, $82, CALCIUM ; item
    db SPRITE_BOOK_MAP_DEX, $2 + 4, $12 + 4, $ff, $ff, $3 ; person
    db SPRITE_BOOK_MAP_DEX, $16 + 4, $3 + 4, $ff, $ff, $4 ; person

    ; warp-to
    EVENT_DISP $f, $a, $5 ; MANSION_1
    EVENT_DISP $f, $a, $7 ; MANSION_3
    EVENT_DISP $f, $e, $19 ; MANSION_3
    EVENT_DISP $f, $1, $6 ; MANSION_3

Mansion2Blocks:
    INCBIN "maps/mansion2.blk"

Mansion3_h: ; 0x521e2 to 0x521ee (12 bytes) (id=215)
    db $16 ; tileset
    db MANSION_3_HEIGHT, MANSION_3_WIDTH ; dimensions (y, x)
    dw Mansion3Blocks, Mansion3Texts, Mansion3Script ; blocks, texts, scripts
    db $00 ; connections

    dw Mansion3Object ; objects

Mansion3Script:
    call $6204
    call $3c3c
    ld hl, $6296
    ld de, $6235
    ld a, [$d63d]
    call $3160
    ld [$d63d], a
    ret
; 0x52204

INCBIN "baserom.gbc",$52204,$5228a - $52204

Mansion3Texts: ; 0x5228a

INCBIN "baserom.gbc",$5228a,$522af - $5228a

Mansion3Text1: ; 0x522af
    db $08 ; asm
    ld hl, $6296
    call LoadTrainerHeader
    jp $24d7

Mansion3Text2: ; 0x522b9
    db $08 ; asm
    ld hl, $62a2
    call LoadTrainerHeader
    jp $24d7

UnnamedText_522c3: ; 0x522c3
    TX_FAR _UnnamedText_522c3
    db $50
; 0x522c3 + 5 bytes

UnnamedText_522c8: ; 0x522c8
    TX_FAR _UnnamedText_522c8
    db $50
; 0x522c8 + 5 bytes

UnnamedText_522cd: ; 0x522cd
    TX_FAR _UnnamedText_522cd
    db $50
; 0x522cd + 5 bytes

UnnamedText_522d2: ; 0x522d2
    TX_FAR _UnnamedText_522d2
    db $50
; 0x522d2 + 5 bytes

UnnamedText_522d7: ; 0x522d7
    TX_FAR _UnnamedText_522d7
    db $50
; 0x522d7 + 5 bytes

UnnamedText_522dc: ; 0x522dc
    TX_FAR _UnnamedText_522dc
    db $50
; 0x522dc + 5 bytes

Mansion3Text5: ; 0x522e1
    TX_FAR _Mansion3Text5
    db $50

Mansion3Object: ; 0x522e6 (size=64)
    db $1 ; border tile

    db $3 ; warps
    db $a, $7, $1, MANSION_2
    db $1, $6, $3, MANSION_2
    db $e, $19, $2, MANSION_2

    db $0 ; signs

    db $5 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $b + 4, $5 + 4, $fe, $2, $41, BURGLAR + $C8, $8 ; trainer
    db SPRITE_OAK_AIDE, $b + 4, $14 + 4, $ff, $d2, $42, SCIENTIST + $C8, $c ; trainer
	db SPRITE_BALL, $10 + 4, $1 + 4, $ff, $ff, $83, MAX_POTION ; item
	db SPRITE_BALL, $5 + 4, $19 + 4, $ff, $ff, $84, IRON ; item
    db SPRITE_BOOK_MAP_DEX, $c + 4, $6 + 4, $ff, $ff, $5 ; person

    ; warp-to
    EVENT_DISP $f, $a, $7 ; MANSION_2
    EVENT_DISP $f, $1, $6 ; MANSION_2
    EVENT_DISP $f, $e, $19 ; MANSION_2

Mansion3Blocks:
    INCBIN "maps/mansion3.blk"

Mansion4_h: ; 0x523ad to 0x523b9 (12 bytes) (id=216)
    db $16 ; tileset
    db MANSION_4_HEIGHT, MANSION_4_WIDTH ; dimensions (y, x)
    dw Mansion4Blocks, Mansion4Texts, Mansion4Script ; blocks, texts, scripts
    db $00 ; connections

    dw Mansion4Object ; objects

Mansion4Script: ; 0x523b9
    call $63cf
    call $3c3c
    ld hl, $6448
    ld de, $6430
    ld a, [$d63e]
    call $3160
    ld [$d63e], a
    ret
; 0x523cf

INCBIN "baserom.gbc",$523cf,$52436 - $523cf

Mansion4Texts: ; 0x52436

INCBIN "baserom.gbc",$52436,$52461 - $52436

Mansion4Text1: ; 0x52461
    db $08 ; asm
    ld hl, $6448
    call LoadTrainerHeader
    jp $24d7

Mansion4Text2: ; 0x5246b
    db $08 ; asm
    ld hl, $6454
    call LoadTrainerHeader
    jp $24d7

UnnamedText_52475: ; 0x52475
    TX_FAR _UnnamedText_52475
    db $50
; 0x52475 + 5 bytes

UnnamedText_5247a: ; 0x5247a
    TX_FAR _UnnamedText_5247a
    db $50
; 0x5247a + 5 bytes

UnnamedText_5247f: ; 0x5247f
    TX_FAR _UnnamedText_5247f
    db $50
; 0x5247f + 5 bytes

UnnamedText_52484: ; 0x52484
    TX_FAR _UnnamedText_52484
    db $50
; 0x52484 + 5 bytes

UnnamedText_52489: ; 0x52489
    TX_FAR _UnnamedText_52489
    db $50
; 0x52489 + 5 bytes

UnnamedText_5248e: ; 0x5248e
    TX_FAR _UnnamedText_5248e
    db $50
; 0x5248e + 5 bytes

Mansion4Text7: ; 0x52493
    TX_FAR _Mansion4Text7
    db $50

Mansion4Object: ; 0x52498 (size=69)
    db $1 ; border tile

    db $1 ; warps
    db $16, $17, $5, MANSION_1

    db $0 ; signs

    db $8 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $17 + 4, $10 + 4, $ff, $ff, $41, BURGLAR + $C8, $9 ; trainer
    db SPRITE_OAK_AIDE, $b + 4, $1b + 4, $ff, $d0, $42, SCIENTIST + $C8, $d ; trainer
	db SPRITE_BALL, $2 + 4, $a + 4, $ff, $ff, $83, RARE_CANDY ; item
	db SPRITE_BALL, $16 + 4, $1 + 4, $ff, $ff, $84, FULL_RESTORE ; item
	db SPRITE_BALL, $19 + 4, $13 + 4, $ff, $ff, $85, TM_14 ; item
	db SPRITE_BALL, $4 + 4, $5 + 4, $ff, $ff, $86, TM_22 ; item
    db SPRITE_BOOK_MAP_DEX, $14 + 4, $10 + 4, $ff, $ff, $7 ; person
	db SPRITE_BALL, $d + 4, $5 + 4, $ff, $ff, $88, SECRET_KEY ; item

    ; warp-to
    EVENT_DISP $f, $16, $17 ; MANSION_1

Mansion4Blocks:
    INCBIN "maps/mansion4.blk"

INCBIN "baserom.gbc",$525af,$526f3 - $525af

UnnamedText_526f3: ; 0x526f3
    TX_FAR _UnnamedText_526f3
    db $50
; 0x526f3 + 5 bytes

UnnamedText_526f8: ; 0x526f8
    TX_FAR _UnnamedText_526f8
    db $50
; 0x526f8 + 5 bytes

INCBIN "baserom.gbc",$526fd,$1e

CeladonPrizeMenu: ; 14:671B 0x5271b
        ld b,COIN_CASE
        call IsItemInBag
        jr nz,.havingCoinCase\@
        ld hl,RequireCoinCaseTextPtr
        jp PrintText
.havingCoinCase\@
        ld hl,$D730
        set 6,[hl]
        ld hl,ExchangeCoinsForPrizesTextPtr
        call PrintText
; the following are the menu settings
        xor a
        ld [$CC26],a
        ld [$CC2A],a
        ld a,$03
        ld [$CC29],a
        ld a,$03
        ld [$CC28],a
        ld a,$04
        ld [$CC24],a
        ld a,$01
        ld [$CC25],a
        call PrintPrizePrice ; 687A
        FuncCoord 0,2
        ld hl,Coord
        ld b,$08
        ld c,$10
        call TextBoxBorder
        call GetPrizeMenuId ;678E
        call $2429
        ld hl,WhichPrizeTextPtr
        call PrintText
        call $3ABE ; menu choice handler
        bit 1,a ; keypress = B (Cancel)
        jr nz,.NoChoice\@
        ld a,[$CC26]
        cp a,$03 ; "NO,THANKS" choice
        jr z,.NoChoice\@
        call HandlePrizeChoice ; 14:68C6
.NoChoice\@
        ld hl,$D730
        res 6,[hl]
        ret

RequireCoinCaseTextPtr: ; 14:677E
        TX_FAR _RequireCoinCaseText ; 22:628E
        db $0D
        db "@"

ExchangeCoinsForPrizesTextPtr: ; 14:6784
        TX_FAR _ExchangeCoinsForPrizesText ; 22:62A9
        db "@"

WhichPrizeTextPtr: ; 14:6789
        TX_FAR _WhichPrizeText ; 22:62CD
        db "@"

GetPrizeMenuId: ; 14:678E
; determine which one among the three
; prize-texts has been selected
; using the text ID (stored in [$FF8C])
; load the three prizes at $D13D-$D13F
; load the three prices ar $D141-$D146
; display the three prizes' names
; (distinguishing between Pokemon names
; and Items (specifically TMs) names)
        ld a,[$FF8C]
        sub a,$03       ; prize-texts' id are 3, 4 and 5
        ld [$D12F],a    ; prize-texts' id (relative, i.e. 0, 1 or 2)
        add a
        add a
        ld d,$00
        ld e,a
        ld hl,PrizeDifferentMenuPtrs
        add hl,de
        ld a,[hli]
        ld d,[hl]
        ld e,a
        inc hl
        push hl
        ld hl,W_PRIZE1
        call $3829      ; XXX what does this do
        pop hl
        ld a,[hli]
        ld h,[hl]
        ld l,a
        ld de,$D141
        ld bc,$0006
        call CopyData
        ld a,[$D12F]
        cp a,$02        ;is TM_menu?
        jr nz,.putMonName\@
        ld a,[W_PRIZE1]
        ld [$D11E],a
        call GetItemName
        FuncCoord 2,4
        ld hl,Coord
        call PlaceString
        ld a,[W_PRIZE2]
        ld [$D11E],a
        call GetItemName
        FuncCoord 2,6
        ld hl,Coord
        call PlaceString
        ld a,[W_PRIZE3]
        ld [$D11E],a
        call GetItemName
        FuncCoord 2,8
        ld hl,Coord
        call PlaceString
        jr .putNoThanksText\@
.putMonName\@ ; 14:67EC
        ld a,[W_PRIZE1]
        ld [$D11E],a
        call GetMonName
        FuncCoord 2,4
        ld hl,Coord
        call PlaceString
        ld a,[W_PRIZE2]
        ld [$D11E],a
        call GetMonName
        FuncCoord 2,6
        ld hl,Coord
        call PlaceString
        ld a,[W_PRIZE3]
        ld [$D11E],a
        call GetMonName
        FuncCoord 2,8
        ld hl,Coord
        call PlaceString
.putNoThanksText\@ ; 14:6819
        FuncCoord 2,10
        ld hl,Coord
        ld de,NoThanksText
        call PlaceString
; put prices on the right side of the textbox
        ld de,$D141
        FuncCoord 13,5
        ld hl,Coord
; reg. c:
; [low nybble] number of bytes
; [bit 765 = %100] space-padding (not zero-padding)
        ld c,(1 << 7 | 2)
; Function $15CD displays BCD value (same routine
; used by text-command $02)
        call $15CD ; Print_BCD
        ld de,$D143
        FuncCoord 13,7
        ld hl,Coord
        ld c,(%1 << 7 | 2)
        call $15CD
        ld de,$D145
        FuncCoord 13,9
        ld hl,Coord
        ld c,(1 << 7 | 2)
        jp $15CD

PrizeDifferentMenuPtrs: ; 14:6843
        dw PrizeMenuMon1Entries
        dw PrizeMenuMon1Cost

        dw PrizeMenuMon2Entries
        dw PrizeMenuMon2Cost
 
        dw PrizeMenuTMsEntries
        dw PrizeMenuTMsCost

NoThanksText: ; 14:684F
        db "NO THANKS@"

PrizeMenuMon1Entries: ; 14:6859
        db ABRA
        db CLEFAIRY
		IF _RED
			db NIDORINA
		ENDC
		IF _BLUE
			db NIDORINO
		ENDC
        db "@"
PrizeMenuMon1Cost: ; 14:685D
		IF _RED
			db $01,$80
			db $05,$00
		ENDC
		IF _BLUE
			db $01,$20
			db $07,$50
		ENDC
        db $12,$00
        db "@"

PrizeMenuMon2Entries: ; 14:6864
		IF _RED
			db DRATINI
			db SCYTHER
		ENDC
		IF _BLUE
			db PINSIR
			db DRATINI
		ENDC
        db PORYGON
        db "@"
PrizeMenuMon2Cost: ; 14:6868
		IF _RED
			db $28,$00
			db $55,$00
			db $99,$99
		ENDC
		IF _BLUE
			db $25,$00
			db $46,$00
			db $65,$00
		ENDC
        db "@"

PrizeMenuTMsEntries: ; 14:686F
        db TM_23
        db TM_15
        db TM_50
        db "@"
PrizeMenuTMsCost: ; 14:6873
        db $33,$00 ; 3300 Coins
        db $55,$00 ; 5500 Coins
        db $77,$00 ; 7700 Coins
        db "@"

PrintPrizePrice: ; 14:687A
        FuncCoord 11,0
        ld hl,Coord
        ld b,$01
        ld c,$07
        call TextBoxBorder
        call $2429      ; XXX save OAM?
        FuncCoord 12,0
        ld hl,Coord
        ld de,.CoinText\@
        call PlaceString
        FuncCoord 13,1
        ld hl,Coord
        ld de,.SixSpacesText\@
        call PlaceString
        FuncCoord 13,1
        ld hl,Coord
        ld de,W_PLAYERCOINS1
        ld c,%10000010
        call $15CD
        ret

.CoinText\@ ; 14:68A5
        db "COIN@"

.SixSpacesText\@ ; 14:68AA
        db "      @"

LoadCoinsToSubtract: ; 14:68B1
        ld a,[$D139] ; backup of selected menu_entry
        add a
        ld d,$00
        ld e,a
        ld hl,$D141 ; first prize's price
        add hl,de ; get selected prize's price
        xor a
        ld [$FF9F],a
        ld a,[hli]
        ld [$FFA0],a
        ld a,[hl]
        ld [$FFA1],a
        ret

HandlePrizeChoice: ; 14:68C6
        ld a,[$CC26] ; selected menu_entry
        ld [$D139],a
        ld d,$00
        ld e,a
        ld hl,W_PRIZE1
        add hl,de
        ld a,[hl]
        ld [$D11E],a
        ld a,[$D12F]
        cp a,$02 ; is prize a TM?
        jr nz,.GetMonName\@
        call GetItemName
        jr .GivePrize\@
.GetMonName\@ ; 14:68E3
        call GetMonName
.GivePrize\@ ; 14:68E6
        ld hl,SoYouWantPrizeTextPtr
        call PrintText
        call $35EC ; yes/no textbox
        ld a,[$CC26] ; yes/no answer (Y=0, N=1)
        and a
        jr nz,.PrintOhFineThen\@
        call LoadCoinsToSubtract
        call $35B1 ; subtract COINs from COIN_CASE
        jr c,.NotEnoughCoins\@
        ld a,[$D12F]
        cp a,$02
        jr nz,.GiveMon\@
        ld a,[$D11E]
        ld b,a
        ld a,$01
        ld c,a
        call $3E2E ; GiveItem
        jr nc,.BagIsFull\@
        jr .SubtractCoins\@
.GiveMon\@ ; 14:6912
        ld a,[$D11E]
        ld [$CF91],a
        push af
        call GetPrizeMonLevel ; 14:6977
        ld c,a
        pop af
        ld b,a
        call $3E48 ; GivePokemon
        push af
        ld a,[$CCD3] ; XXX is there room?
        and a
        call z,$3865
        pop af
        ret nc
.SubtractCoins\@ ; 14:692C
        call LoadCoinsToSubtract
        ld hl,$FFA1
        ld de,W_PLAYERCOINS2
        ld c,$02 ; how many bytes
        ld a,$0C
        call Predef ; subtract coins (BCD daa operations)
        jp PrintPrizePrice
.BagIsFull\@ ; 14:693F
        ld hl,PrizeRoomBagIsFullTextPtr
        jp PrintText
.NotEnoughCoins\@ ; 14:6945
        ld hl,SorryNeedMoreCoinsTextPtr
        jp PrintText
.PrintOhFineThen\@ ; 14:694B
        ld hl,OhFineThenTextPtr
        jp PrintText

UnknownData52951: ; 14:6951
; XXX what's this?
        db $00,$01,$00,$01,$00,$01,$00,$00,$01

HereYouGoTextPtr:
        TX_FAR _HereYouGoText ; 22:62E7
        db $0D
        db "@"

SoYouWantPrizeTextPtr: ; 14:6960
        TX_FAR _SoYouWantPrizeText ; 22:62F6
        db "@"

SorryNeedMoreCoinsTextPtr: ; 14:6965
        TX_FAR _SorryNeedMoreCoins ; 22:630B
        db $0D
        db "@"

PrizeRoomBagIsFullTextPtr: ; 14:696B
        TX_FAR _OopsYouDontHaveEnoughRoomText ; 22:6329
        db $0D
        db "@"

OhFineThenTextPtr: ; 14:6971
        TX_FAR _OhFineThenText; 22:634C
        db $0D ; wait keypress (A/B) without blink
        db "@"

GetPrizeMonLevel: ; 14:6977
        ld a,[$CF91]
        ld b,a
        ld hl,PrizeMonLevelDictionary
.loop\@ ; 14:697E
        ld a,[hli]
        cp b
        jr z,.matchFound\@
        inc hl
        jr .loop\@
.matchFound\@ ; 14:6985
        ld a,[hl]
        ld [$D127],a
        ret

PrizeMonLevelDictionary: ; 14:698A
	IF _RED
		db ABRA,9
		db CLEFAIRY,8
		db NIDORINA,17

		db DRATINI,18
		db SCYTHER,25
		db PORYGON,26
	ENDC
	IF _BLUE
		db ABRA,6
		db CLEFAIRY,12
		db NIDORINO,17

		db PINSIR,20
		db DRATINI,24
		db PORYGON,18
	ENDC

INCBIN "baserom.gbc",$52996,$529e9 - $52996

UnnamedText_529e9: ; 0x529e9
    TX_FAR _UnnamedText_529e9
    db $50
; 0x529e9 + 5 bytes

INCBIN "baserom.gbc",$529ee,$529f4 - $529ee

UnnamedText_529f4: ; 0x529f4
    TX_FAR _UnnamedText_529f4
    db $50
; 0x529f4 + 5 bytes

UnnamedText_529f9: ; 0x529f9
    TX_FAR _UnnamedText_529f9
    db $50
; 0x529f9 + 5 bytes

UnnamedText_529fe: ; 0x529fe
    TX_FAR _UnnamedText_529fe
    db $50
; 0x529fe + 5 bytes

UnnamedText_52a03: ; 0x52a03
    TX_FAR _UnnamedText_52a03
    db $50
; 0x52a03 + 5 bytes

INCBIN "baserom.gbc",$52a08,$52a10 - $52a08

UnnamedText_52a10: ; 0x52a10
    TX_FAR _UnnamedText_52a10
    db $50
; 0x52a10 + 5 bytes

INCBIN "baserom.gbc",$52a15,$52a1d - $52a15

UnnamedText_52a1d: ; 0x52a1d
    TX_FAR _UnnamedText_52a1d
    db $50
; 0x52a1d + 5 bytes

INCBIN "baserom.gbc",$52a22,$52a2a - $52a22

UnnamedText_52a2a: ; 0x52a2a
    TX_FAR _UnnamedText_52a2a
    db $50
; 0x52a2a + 5 bytes

INCBIN "baserom.gbc",$52a2f,$52a3d - $52a2f

UnnamedText_52a3d: ; 0x52a3d
    TX_FAR _UnnamedText_52a3d
    db $50
; 0x52a3d + 5 bytes

INCBIN "baserom.gbc",$52a42,$15be

SECTION "bank15",DATA,BANK[$15]

Route2_h:
	db 00 ; Tileset
	db ROUTE_2_HEIGHT,ROUTE_2_WIDTH ;Height,Width blocks (1 block = 4x4 tiles)
	dw Route2Blocks ;Map-Pointer
	dw Route2Texts ;Maps text pointer
	dw Route2Script ;Maps script pointer
	db NORTH | SOUTH ;Connection Byte

	;Connection data
	db PEWTER_CITY ;Map
		dw $4714 ;y, x Strip Starting Point
		dw $C6E8 ;Strip X-Offset to current map
		db 16 ;"Bigness" (Unsure) ;Something to do with MapData
		db 20 ;"Map Width" (Unsure) ;Something to do with TileSet
		db 35 ;Player's new Y-Coordinates
		db 10 ;Player's new X-Coordinates
		dw $C8BD ;New UL Block Pos (Window)

	db VIRIDIAN_CITY ;Map
		dw $43EE ;y, x Strip Starting Point
		dw $C958 ;Strip X-Offset to current map
		db 16 ;"Bigness" (Unsure) ;Something to do with MapData
		db 20 ;"Map Width" (Unsure) ;Something to do with TileSet
		db 0 ;Player's new Y-Coordinates
		db 10 ;Player's new X-Coordinates
		dw $C703 ;New UL Block Pos (Window)

	dw Route2Object ;Object Data Pointer

Route2Object: ; 0x54022 (size=72)
    db $f ; border tile

    db $6 ; warps
    db $9, $c, $0, DIGLETTS_CAVE_EXIT
    db $b, $3, $1, VIRIDIAN_FOREST_EXIT
    db $13, $f, $0, ROUTE_2_HOUSE
    db $23, $10, $1, ROUTE_2_GATE
    db $27, $f, $2, ROUTE_2_GATE
    db $2b, $3, $2, VIRIDIAN_FOREST_ENTRANCE

    db $2 ; signs
    db $41, $5, $3 ; Route2Text3
    db $b, $b, $4 ; Route2Text4

    db $2 ; people
	db SPRITE_BALL, $36 + 4, $d + 4, $ff, $ff, $81, MOON_STONE ; item
	db SPRITE_BALL, $2d + 4, $d + 4, $ff, $ff, $82, HP_UP ; item

    ; warp-to
    EVENT_DISP $a, $9, $c ; DIGLETTS_CAVE_EXIT
    EVENT_DISP $a, $b, $3 ; VIRIDIAN_FOREST_EXIT
    EVENT_DISP $a, $13, $f ; ROUTE_2_HOUSE
    EVENT_DISP $a, $23, $10 ; ROUTE_2_GATE
    EVENT_DISP $a, $27, $f ; ROUTE_2_GATE
    EVENT_DISP $a, $2b, $3 ; VIRIDIAN_FOREST_ENTRANCE

INCBIN "baserom.gbc",$5406a,$14

Route2Blocks: ; 360
    INCBIN "maps/route2.blk"

Route3_h: ; 0x541e6 to 0x54208 (34 bytes) (id=14)
    db $00 ; tileset
    db ROUTE_3_HEIGHT, ROUTE_3_WIDTH ; dimensions (y, x)
    dw Route3Blocks, Route3Texts, Route3Script ; blocks, texts, scripts
    db NORTH | WEST ; connections

    ; connections data

	db ROUTE_4
    dw Route4Blocks + (ROUTE_4_HEIGHT - 3) * ROUTE_4_WIDTH ; connection strip location
    dw $C6EB + 25 ; current map position
    db $d, ROUTE_4_WIDTH ; bigness, width
    db (ROUTE_4_HEIGHT * 2) - 1, (25 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_4_HEIGHT * (ROUTE_4_WIDTH + 6) ; window

	db PEWTER_CITY
    dw PewterCityBlocks - 3 + (PEWTER_CITY_WIDTH * 2) ; connection strip location
    dw $C6E8 + (ROUTE_3_WIDTH + 6) * (-3 + 3) ; current map position
    db $f, PEWTER_CITY_WIDTH ; bigness, width
    db (-4 * -2), (PEWTER_CITY_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * PEWTER_CITY_WIDTH ; window

    ; end connections data

    dw Route3Object ; objects

Route3Object: ; 0x54208 (size=77)
    db $2c ; border tile

    db $0 ; warps

    db $1 ; signs
    db $9, $3b, $a ; Route3Text10

    db $9 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $b + 4, $39 + 4, $ff, $ff, $1 ; person
    db SPRITE_BUG_CATCHER, $6 + 4, $a + 4, $ff, $d3, $42, BUG_CATCHER + $C8, $4 ; trainer
    db SPRITE_BUG_CATCHER, $4 + 4, $e + 4, $ff, $d0, $43, YOUNGSTER + $C8, $1 ; trainer
    db SPRITE_LASS, $9 + 4, $10 + 4, $ff, $d2, $44, LASS + $C8, $1 ; trainer
    db SPRITE_BUG_CATCHER, $5 + 4, $13 + 4, $ff, $d0, $45, BUG_CATCHER + $C8, $5 ; trainer
    db SPRITE_LASS, $4 + 4, $17 + 4, $ff, $d2, $46, LASS + $C8, $2 ; trainer
    db SPRITE_BUG_CATCHER, $9 + 4, $16 + 4, $ff, $d2, $47, YOUNGSTER + $C8, $2 ; trainer
    db SPRITE_BUG_CATCHER, $6 + 4, $18 + 4, $ff, $d3, $48, BUG_CATCHER + $C8, $6 ; trainer
    db SPRITE_LASS, $a + 4, $21 + 4, $ff, $d1, $49, LASS + $C8, $3 ; trainer

Route3Blocks: ; 315
    INCBIN "maps/route3.blk"

Route4_h: ; 0x54390 to 0x543b2 (34 bytes) (id=15)
    db $00 ; tileset
    db ROUTE_4_HEIGHT, ROUTE_4_WIDTH ; dimensions (y, x)
    dw Route4Blocks, Route4Texts, Route4Script; blocks, texts, scripts
    db SOUTH | EAST ; connections

    ; connections data

	db ROUTE_3
    dw Route3Blocks + 22 ; connection strip location
    dw $C6EB + (ROUTE_4_HEIGHT + 3) * (ROUTE_4_WIDTH + 6) + -3 ; current map position
    db $d, ROUTE_3_WIDTH ; bigness, width
    db 0, (-25 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_3_WIDTH ; window

	db CERULEAN_CITY
    dw CeruleanCityBlocks + (CERULEAN_CITY_WIDTH) ; connection strip location
    dw $C6E5 + (ROUTE_4_WIDTH + 6) * (-3 + 4) ; current map position
    db $f, CERULEAN_CITY_WIDTH ; bigness, width
    db (-4 * -2), 0 ; alignments (y, x)
    dw $C6EF + CERULEAN_CITY_WIDTH ; window

    ; end connections data

    dw Route4Object ; objects

Route4Object: ; 0x543b2 (size=58)
    db $2c ; border tile

    db $3 ; warps
    db $5, $b, $0, MT_MOON_POKECENTER
    db $5, $12, $0, MT_MOON_1
    db $5, $18, $7, MT_MOON_2

    db $3 ; signs
    db $5, $c, $4 ; Route4Text4
    db $7, $11, $5 ; Route4Text5
    db $7, $1b, $6 ; Route4Text6

    db $3 ; people
    db SPRITE_LASS, $8 + 4, $9 + 4, $fe, $0, $1 ; person
    db SPRITE_LASS, $3 + 4, $3f + 4, $ff, $d3, $42, LASS + $C8, $4 ; trainer
	db SPRITE_BALL, $3 + 4, $39 + 4, $ff, $ff, $83, TM_04 ; item

    ; warp-to
    EVENT_DISP $2d, $5, $b ; MT_MOON_POKECENTER
    EVENT_DISP $2d, $5, $12 ; MT_MOON_1
    EVENT_DISP $2d, $5, $18 ; MT_MOON_2

Route4Blocks: ; 405
    INCBIN "maps/route4.blk"

Route5_h: ; 0x54581 to 0x545a3 (34 bytes) (id=16)
    db $00 ; tileset
    db ROUTE_5_HEIGHT, ROUTE_5_WIDTH ; dimensions (y, x)
    dw Route5Blocks, Route5Texts, Route5Script ; blocks, texts, scripts
    db NORTH | SOUTH ; connections

    ; connections data

	db CERULEAN_CITY
    dw CeruleanCityBlocks + (CERULEAN_CITY_HEIGHT - 3) * CERULEAN_CITY_WIDTH + 2 ; connection strip location
    dw $C6EB + -3 ; current map position
    db $10, CERULEAN_CITY_WIDTH ; bigness, width
    db (CERULEAN_CITY_HEIGHT * 2) - 1, (-5 * -2) ; alignments (y, x)
    dw $C6E9 + CERULEAN_CITY_HEIGHT * (CERULEAN_CITY_WIDTH + 6) ; window

	db SAFFRON_CITY
    dw SaffronCityBlocks + 2 ; connection strip location
    dw $C6EB + (ROUTE_5_HEIGHT + 3) * (ROUTE_5_WIDTH + 6) + -3 ; current map position
    db $10, SAFFRON_CITY_WIDTH ; bigness, width
    db 0, (-5 * -2) ; alignments (y, x)
    dw $C6EF + SAFFRON_CITY_WIDTH ; window

    ; end connections data

    dw Route5Object ; objects

Route5Object: ; 0x545a3 (size=47)
    db $a ; border tile

    db $5 ; warps
    db $1d, $a, $3, ROUTE_5_GATE
    db $1d, $9, $2, ROUTE_5_GATE
    db $21, $a, $0, ROUTE_5_GATE
    db $1b, $11, $0, PATH_ENTRANCE_ROUTE_5
    db $15, $a, $0, DAYCAREM

    db $1 ; signs
    db $1d, $11, $1 ; Route5Text1

    db $0 ; people

    ; warp-to
    EVENT_DISP $a, $1d, $a ; ROUTE_5_GATE
    EVENT_DISP $a, $1d, $9 ; ROUTE_5_GATE
    EVENT_DISP $a, $21, $a ; ROUTE_5_GATE
    EVENT_DISP $a, $1b, $11 ; PATH_ENTRANCE_ROUTE_5
    EVENT_DISP $a, $15, $a ; DAYCAREM

Route5Blocks: ; 180
    INCBIN "maps/route5.blk"

Route9_h: ; 0x54686 to 0x546a8 (34 bytes) (id=20)
    db $00 ; tileset
    db ROUTE_9_HEIGHT, ROUTE_9_WIDTH ; dimensions (y, x)
    dw Route9Blocks, Route9Texts, Route9Script ; blocks, texts, scripts
    db WEST | EAST ; connections

    ; connections data

	db CERULEAN_CITY
    dw CeruleanCityBlocks - 3 + (CERULEAN_CITY_WIDTH * 2) ; connection strip location
    dw $C6E8 + (ROUTE_9_WIDTH + 6) * (-3 + 3) ; current map position
    db $f, CERULEAN_CITY_WIDTH ; bigness, width
    db (-4 * -2), (CERULEAN_CITY_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * CERULEAN_CITY_WIDTH ; window

	db ROUTE_10
    dw Route10Blocks + (ROUTE_10_WIDTH * 0) ; connection strip location
    dw $C6E5 + (ROUTE_9_WIDTH + 6) * (0 + 4) ; current map position
    db $c, ROUTE_10_WIDTH ; bigness, width
    db (0 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_10_WIDTH ; window

    ; end connections data

    dw Route9Object ; objects

Route9Object: ; 0x546a8 (size=86)
    db $2c ; border tile

    db $0 ; warps

    db $1 ; signs
    db $7, $19, $b ; Route9Text11

    db $a ; people
    db SPRITE_LASS, $a + 4, $d + 4, $ff, $d2, $41, JR__TRAINER_F + $C8, $5 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $7 + 4, $18 + 4, $ff, $d2, $42, JR__TRAINER_M + $C8, $7 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $7 + 4, $1f + 4, $ff, $d3, $43, JR__TRAINER_M + $C8, $8 ; trainer
    db SPRITE_LASS, $8 + 4, $30 + 4, $ff, $d3, $44, JR__TRAINER_F + $C8, $6 ; trainer
    db SPRITE_HIKER, $f + 4, $10 + 4, $ff, $d2, $45, HIKER + $C8, $b ; trainer
    db SPRITE_HIKER, $3 + 4, $2b + 4, $ff, $d2, $46, HIKER + $C8, $6 ; trainer
    db SPRITE_BUG_CATCHER, $2 + 4, $16 + 4, $ff, $d0, $47, BUG_CATCHER + $C8, $d ; trainer
    db SPRITE_HIKER, $f + 4, $2d + 4, $ff, $d3, $48, HIKER + $C8, $5 ; trainer
    db SPRITE_BUG_CATCHER, $8 + 4, $28 + 4, $ff, $d3, $49, BUG_CATCHER + $C8, $e ; trainer
	db SPRITE_BALL, $f + 4, $a + 4, $ff, $ff, $8a, TM_30 ; item

Route9Blocks: ; 270
    INCBIN "maps/route9.blk"

Route13_h: ; 0x5480c to 0x5482e (34 bytes) (id=24)
    db $00 ; tileset
    db ROUTE_13_HEIGHT, ROUTE_13_WIDTH ; dimensions (y, x)
    dw Route13Blocks, Route13Texts, Route13Script ; blocks, texts, scripts
    db NORTH | WEST ; connections

    ; connections data

	db ROUTE_12
    dw Route12Blocks + (ROUTE_12_HEIGHT - 3) * ROUTE_12_WIDTH ; connection strip location
    dw $C6EB + 20 ; current map position
    db ROUTE_12_WIDTH, ROUTE_12_WIDTH ; bigness, width
    db (ROUTE_12_HEIGHT * 2) - 1, (20 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_12_HEIGHT * (ROUTE_12_WIDTH + 6) ; window

	db ROUTE_14
    dw Route14Blocks - 3 + (ROUTE_14_WIDTH) ; connection strip location
    dw $C6E8 + (ROUTE_13_WIDTH + 6) * (0 + 3) ; current map position
    db $c, ROUTE_14_WIDTH ; bigness, width
    db (0 * -2), (ROUTE_14_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_14_WIDTH ; window

    ; end connections data

    dw Route13Object ; objects

Route13Object: ; 0x5482e (size=93)
    db $43 ; border tile

    db $0 ; warps

    db $3 ; signs
    db $d, $f, $b ; Route13Text11
    db $5, $21, $c ; Route13Text12
    db $b, $1f, $d ; Route13Text13

    db $a ; people
    db SPRITE_BLACK_HAIR_BOY_1, $a + 4, $31 + 4, $ff, $d3, $41, BIRD_KEEPER + $C8, $1 ; trainer
    db SPRITE_LASS, $a + 4, $30 + 4, $ff, $d0, $42, JR__TRAINER_F + $C8, $c ; trainer
    db SPRITE_LASS, $9 + 4, $1b + 4, $ff, $d0, $43, JR__TRAINER_F + $C8, $d ; trainer
    db SPRITE_LASS, $a + 4, $17 + 4, $ff, $d2, $44, JR__TRAINER_F + $C8, $e ; trainer
    db SPRITE_LASS, $5 + 4, $32 + 4, $ff, $d0, $45, JR__TRAINER_F + $C8, $f ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $4 + 4, $c + 4, $ff, $d3, $46, BIRD_KEEPER + $C8, $2 ; trainer
    db SPRITE_FOULARD_WOMAN, $6 + 4, $21 + 4, $ff, $d0, $47, BEAUTY + $C8, $4 ; trainer
    db SPRITE_FOULARD_WOMAN, $6 + 4, $20 + 4, $ff, $d0, $48, BEAUTY + $C8, $5 ; trainer
    db SPRITE_BIKER, $7 + 4, $a + 4, $ff, $d1, $49, BIKER + $C8, $1 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $d + 4, $7 + 4, $ff, $d1, $4a, BIRD_KEEPER + $C8, $3 ; trainer

Route13Blocks: ; 270
    INCBIN "maps/route13.blk"

Route14_h: ; 0x54999 to 0x549bb (34 bytes) (id=25)
    db $00 ; tileset
    db ROUTE_14_HEIGHT, ROUTE_14_WIDTH ; dimensions (y, x)
    dw Route14Blocks, Route14Texts, Route14Script ; blocks, texts, scripts
    db WEST | EAST ; connections

    ; connections data

	db ROUTE_15
    dw Route15Blocks - 3 + (ROUTE_15_WIDTH) ; connection strip location
    dw $C6E8 + (ROUTE_14_WIDTH + 6) * (18 + 3) ; current map position
    db ROUTE_15_HEIGHT, ROUTE_15_WIDTH ; bigness, width
    db (18 * -2), (ROUTE_15_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_15_WIDTH ; window

	db ROUTE_13
    dw Route13Blocks + (ROUTE_13_WIDTH * 0) ; connection strip location
    dw $C6E5 + (ROUTE_14_WIDTH + 6) * (0 + 4) ; current map position
    db ROUTE_13_HEIGHT, ROUTE_13_WIDTH ; bigness, width
    db (0 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_13_WIDTH ; window

    ; end connections data

    dw Route14Object ; objects

Route14Object: ; 0x549bb (size=87)
    db $43 ; border tile

    db $0 ; warps

    db $1 ; signs
    db $d, $11, $b ; Route14Text11

    db $a ; people
    db SPRITE_BLACK_HAIR_BOY_1, $4 + 4, $4 + 4, $ff, $d0, $41, BIRD_KEEPER + $C8, $e ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $6 + 4, $f + 4, $ff, $d0, $42, BIRD_KEEPER + $C8, $f ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $b + 4, $c + 4, $ff, $d0, $43, BIRD_KEEPER + $C8, $10 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $f + 4, $e + 4, $ff, $d1, $44, BIRD_KEEPER + $C8, $11 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $1f + 4, $f + 4, $ff, $d2, $45, BIRD_KEEPER + $C8, $4 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $31 + 4, $6 + 4, $ff, $d1, $46, BIRD_KEEPER + $C8, $5 ; trainer
    db SPRITE_BIKER, $27 + 4, $5 + 4, $ff, $d0, $47, BIKER + $C8, $d ; trainer
    db SPRITE_BIKER, $1e + 4, $4 + 4, $ff, $d3, $48, BIKER + $C8, $e ; trainer
    db SPRITE_BIKER, $1e + 4, $f + 4, $ff, $d2, $49, BIKER + $C8, $f ; trainer
    db SPRITE_BIKER, $1f + 4, $4 + 4, $ff, $d3, $4a, BIKER + $C8, $2 ; trainer

Route14Blocks: ; 270
    INCBIN "maps/route14.blk"

Route17_h: ; 0x54b20 to 0x54b42 (34 bytes) (id=28)
    db $00 ; tileset
    db ROUTE_17_HEIGHT, ROUTE_17_WIDTH ; dimensions (y, x)
    dw Route17Blocks, Route17Texts, Route17Script ; blocks, texts, scripts
    db NORTH | SOUTH ; connections

    ; connections data

	db ROUTE_16
    dw Route16Blocks + (ROUTE_16_HEIGHT - 3) * ROUTE_16_WIDTH ; connection strip location
    dw $C6EB + 0 ; current map position
    db $d, ROUTE_16_WIDTH ; bigness, width
    db (ROUTE_16_HEIGHT * 2) - 1, (0 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_16_HEIGHT * (ROUTE_16_WIDTH + 6) ; window

	db ROUTE_18
    dw Route18Blocks ; connection strip location
    dw $C6EB + (ROUTE_17_HEIGHT + 3) * (ROUTE_17_WIDTH + 6) + 0 ; current map position
    db $d, ROUTE_18_WIDTH ; bigness, width
    db 0, (0 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_18_WIDTH ; window

    ; end connections data

    dw Route17Object ; objects

Route17Object: ; 0x54b42 (size=102)
    db $43 ; border tile

    db $0 ; warps

    db $6 ; signs
    db $33, $9, $b ; Route17Text11
    db $3f, $9, $c ; Route17Text12
    db $4b, $9, $d ; Route17Text13
    db $57, $9, $e ; Route17Text14
    db $6f, $9, $f ; Route17Text15
    db $8d, $9, $10 ; Route17Text16

    db $a ; people
    db SPRITE_BIKER, $13 + 4, $c + 4, $ff, $d2, $41, CUE_BALL + $C8, $4 ; trainer
    db SPRITE_BIKER, $10 + 4, $b + 4, $ff, $d3, $42, CUE_BALL + $C8, $5 ; trainer
    db SPRITE_BIKER, $12 + 4, $4 + 4, $ff, $d1, $43, BIKER + $C8, $8 ; trainer
    db SPRITE_BIKER, $20 + 4, $7 + 4, $ff, $d2, $44, BIKER + $C8, $9 ; trainer
    db SPRITE_BIKER, $22 + 4, $e + 4, $ff, $d3, $45, BIKER + $C8, $a ; trainer
    db SPRITE_BIKER, $3a + 4, $11 + 4, $ff, $d2, $46, CUE_BALL + $C8, $6 ; trainer
    db SPRITE_BIKER, $44 + 4, $2 + 4, $ff, $d3, $47, CUE_BALL + $C8, $7 ; trainer
    db SPRITE_BIKER, $62 + 4, $e + 4, $ff, $d3, $48, CUE_BALL + $C8, $8 ; trainer
    db SPRITE_BIKER, $62 + 4, $5 + 4, $ff, $d2, $49, BIKER + $C8, $b ; trainer
    db SPRITE_BIKER, $76 + 4, $a + 4, $ff, $d0, $4a, BIKER + $C8, $c ; trainer

Route17Blocks: ; 720
    INCBIN "maps/route17.blk"

Route19_h: ; 0x54e78 to 0x54e9a (34 bytes) (id=30)
    db $00 ; tileset
    db ROUTE_19_HEIGHT, ROUTE_19_WIDTH ; dimensions (y, x)
    dw Route19Blocks, Route19Texts, Route19Script ; blocks, texts, scripts
    db NORTH | WEST ; connections

    ; connections data

	db FUCHSIA_CITY
    dw FuchsiaCityBlocks + (FUCHSIA_CITY_HEIGHT - 3) * FUCHSIA_CITY_WIDTH + 2 ; connection strip location
    dw $C6EB + -3 ; current map position
    db $10, FUCHSIA_CITY_WIDTH ; bigness, width
    db (FUCHSIA_CITY_HEIGHT * 2) - 1, (-5 * -2) ; alignments (y, x)
    dw $C6E9 + FUCHSIA_CITY_HEIGHT * (FUCHSIA_CITY_WIDTH + 6) ; window

	db ROUTE_20
    dw Route20Blocks - 3 + (ROUTE_20_WIDTH) ; connection strip location
    dw $C6E8 + (ROUTE_19_WIDTH + 6) * (18 + 3) ; current map position
    db ROUTE_20_HEIGHT, ROUTE_20_WIDTH ; bigness, width
    db (18 * -2), (ROUTE_20_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_20_WIDTH ; window

    ; end connections data

    dw Route19Object ; objects

Route19Object: ; 0x54e9a (size=87)
    db $43 ; border tile

    db $0 ; warps

    db $1 ; signs
    db $9, $b, $b ; Route19Text11

    db $a ; people
    db SPRITE_BLACK_HAIR_BOY_1, $7 + 4, $8 + 4, $ff, $d2, $41, SWIMMER + $C8, $2 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $7 + 4, $d + 4, $ff, $d2, $42, SWIMMER + $C8, $3 ; trainer
    db SPRITE_SWIMMER, $19 + 4, $d + 4, $ff, $d2, $43, SWIMMER + $C8, $4 ; trainer
    db SPRITE_SWIMMER, $1b + 4, $4 + 4, $ff, $d3, $44, SWIMMER + $C8, $5 ; trainer
    db SPRITE_SWIMMER, $1f + 4, $10 + 4, $ff, $d1, $45, SWIMMER + $C8, $6 ; trainer
    db SPRITE_SWIMMER, $b + 4, $9 + 4, $ff, $d0, $46, SWIMMER + $C8, $7 ; trainer
    db SPRITE_SWIMMER, $2b + 4, $8 + 4, $ff, $d2, $47, BEAUTY + $C8, $c ; trainer
    db SPRITE_SWIMMER, $2b + 4, $b + 4, $ff, $d3, $48, BEAUTY + $C8, $d ; trainer
    db SPRITE_SWIMMER, $2a + 4, $9 + 4, $ff, $d1, $49, SWIMMER + $C8, $8 ; trainer
    db SPRITE_SWIMMER, $2c + 4, $a + 4, $ff, $d0, $4a, BEAUTY + $C8, $e ; trainer

Route19Blocks: ; 270
    INCBIN "maps/route19.blk"

Route21_h: ; 0x54fff to 0x55021 (34 bytes) (id=32)
    db $00 ; tileset
    db ROUTE_21_HEIGHT, ROUTE_21_WIDTH ; dimensions (y, x)
    dw Route21Blocks, Route21Texts, Route21Script ; blocks, texts, scripts
    db NORTH | SOUTH ; connections

    ; connections data

	db PALLET_TOWN
    dw PalletTownBlocks + (PALLET_TOWN_HEIGHT - 3) * PALLET_TOWN_WIDTH ; connection strip location
    dw $C6EB + 0 ; current map position
    db PALLET_TOWN_WIDTH, PALLET_TOWN_WIDTH ; bigness, width
    db (PALLET_TOWN_HEIGHT * 2) - 1, (0 * -2) ; alignments (y, x)
    dw $C6E9 + PALLET_TOWN_HEIGHT * (PALLET_TOWN_WIDTH + 6) ; window

	db CINNABAR_ISLAND
    dw CinnabarIslandBlocks ; connection strip location
    dw $C6EB + (ROUTE_21_HEIGHT + 3) * (ROUTE_21_WIDTH + 6) + 0 ; current map position
    db CINNABAR_ISLAND_WIDTH, CINNABAR_ISLAND_WIDTH ; bigness, width
    db 0, (0 * -2) ; alignments (y, x)
    dw $C6EF + CINNABAR_ISLAND_WIDTH ; window

    ; end connections data

    dw Route21Object ; objects

Route21Object: ; 0x55021 (size=76)
    db $43 ; border tile

    db $0 ; warps

    db $0 ; signs

    db $9 ; people
    db SPRITE_FISHER2, $18 + 4, $4 + 4, $ff, $d2, $41, FISHER + $C8, $7 ; trainer
    db SPRITE_FISHER2, $19 + 4, $6 + 4, $ff, $d0, $42, FISHER + $C8, $9 ; trainer
    db SPRITE_SWIMMER, $1f + 4, $a + 4, $ff, $d1, $43, SWIMMER + $C8, $c ; trainer
    db SPRITE_SWIMMER, $1e + 4, $c + 4, $ff, $d3, $44, CUE_BALL + $C8, $9 ; trainer
    db SPRITE_SWIMMER, $3f + 4, $10 + 4, $ff, $d0, $45, SWIMMER + $C8, $d ; trainer
    db SPRITE_SWIMMER, $47 + 4, $5 + 4, $ff, $d3, $46, SWIMMER + $C8, $e ; trainer
    db SPRITE_SWIMMER, $47 + 4, $f + 4, $ff, $d2, $47, SWIMMER + $C8, $f ; trainer
    db SPRITE_FISHER2, $38 + 4, $e + 4, $ff, $d2, $48, FISHER + $C8, $8 ; trainer
    db SPRITE_FISHER2, $39 + 4, $11 + 4, $ff, $d3, $49, FISHER + $C8, $a ; trainer

Route21Blocks: ; 450
    INCBIN "maps/route21.blk"

VermilionHouse2Blocks:
Route12HouseBlocks:
DayCareMBlocks: ; 16 0x5522f 522F
    INCBIN "maps/daycarem.blk"

FuchsiaHouse3Blocks: ; 16
    INCBIN "maps/fuchsiahouse3.blk"

INCBIN "baserom.gbc",$5524f,$554e3 - $5524f

Route2Script: ; 0x554e3
    jp $3c3c
; 0x554e6

Route2Texts:
dw Route2Text1, Route2Text2, Route2Text3, Route2Text4

Route2Text3: ; 0x554ee
    TX_FAR _Route2Text3
    db $50

Route2Text4: ; 0x554f3
    TX_FAR _Route2Text4
    db $50

Route3Script: ; 0x554f8
    call $3c3c
    ld hl, $5525
    ld de, $550b
    ld a, [$d5f8]
    call $3160
    ld [$d5f8], a
    ret
; 0x5550b

INCBIN "baserom.gbc",$5550b,$6

Route3Texts: ; 0x55511
    dw Route3Text1, Route3Text2, Route3Text3, Route3Text4, Route3Text5, Route3Text6, Route3Text7, Route3Text8, Route3Text9, Route3Text10

INCBIN "baserom.gbc",$55525,$61

Route3Text1: ; 0x55586
    TX_FAR _Route3Text1
    db $50

Route3Text2: ; 0x5558b
    db $08 ; asm
    ld hl, $5525
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55595: ; 0x55595
    TX_FAR _UnnamedText_55595
    db $50
; 0x55595 + 5 bytes

UnnamedText_5559a: ; 0x5559a
    TX_FAR _UnnamedText_5559a
    db $50
; 0x5559a + 5 bytes

UnnamedText_5559f: ; 0x5559f
    TX_FAR _UnnamedText_5559f
    db $50
; 0x5559f + 5 bytes

Route3Text3: ; 0x555a4
    db $08 ; asm
    ld hl, $5531
    call LoadTrainerHeader
    jp $24d7

UnnamedText_555ae: ; 0x555ae
    TX_FAR _UnnamedText_555ae
    db $50
; 0x555ae + 5 bytes

UnnamedText_555b3: ; 0x555b3
    TX_FAR _UnnamedText_555b3
    db $50
; 0x555b3 + 5 bytes

UnnamedText_555b8: ; 0x555b8
    TX_FAR _UnnamedText_555b8
    db $50
; 0x555b8 + 5 bytes

Route3Text4: ; 0x555bd
    db $08 ; asm
    ld hl, $553d
    call LoadTrainerHeader
    jp $24d7

UnnamedText_555c7: ; 0x555c7
    TX_FAR _UnnamedText_555c7
    db $50
; 0x555c7 + 5 bytes

UnnamedText_555cc: ; 0x555cc
    TX_FAR _UnnamedText_555cc
    db $50
; 0x555cc + 5 bytes

UnnamedText_555d1: ; 0x555d1
    TX_FAR _UnnamedText_555d1
    db $50
; 0x555d1 + 5 bytes

Route3Text5: ; 0x555d6
    db $08 ; asm
    ld hl, $5549
    call LoadTrainerHeader
    jp $24d7

UnnamedText_555e0: ; 0x555e0
    TX_FAR _UnnamedText_555e0
    db $50
; 0x555e0 + 5 bytes

UnnamedText_555e5: ; 0x555e5
    TX_FAR _UnnamedText_555e5
    db $50
; 0x555e5 + 5 bytes

UnnamedText_555ea: ; 0x555ea
    TX_FAR _UnnamedText_555ea
    db $50
; 0x555ea + 5 bytes

Route3Text6: ; 0x555ef
    db $08 ; asm
    ld hl, $5555
    call LoadTrainerHeader
    jp $24d7

UnnamedText_555f9: ; 0x555f9
    TX_FAR _UnnamedText_555f9
    db $50
; 0x555f9 + 5 bytes

UnnamedText_555fe: ; 0x555fe
    TX_FAR _UnnamedText_555fe
    db $50
; 0x555fe + 5 bytes

UnnamedText_55603: ; 0x55603
    TX_FAR _UnnamedText_55603
    db $50
; 0x55603 + 5 bytes

Route3Text7: ; 0x55608
    db $08 ; asm
    ld hl, $5561
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55612: ; 0x55612
    TX_FAR _UnnamedText_55612
    db $50
; 0x55612 + 5 bytes

UnnamedText_55617: ; 0x55617
    TX_FAR _UnnamedText_55617
    db $50
; 0x55617 + 5 bytes

UnnamedText_5561c: ; 0x5561c
    TX_FAR _UnnamedText_5561c
    db $50
; 0x5561c + 5 bytes

Route3Text8: ; 0x55621
    db $08 ; asm
    ld hl, $556d
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5562b: ; 0x5562b
    TX_FAR _UnnamedText_5562b
    db $50
; 0x5562b + 5 bytes

UnnamedText_55630: ; 0x55630
    TX_FAR _UnnamedText_55630
    db $50
; 0x55630 + 5 bytes

UnnamedText_55635: ; 0x55635
    TX_FAR _UnnamedText_55635
    db $50
; 0x55635 + 5 bytes

Route3Text9: ; 0x5563a
    db $08 ; asm
    ld hl, $5579
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55644: ; 0x55644
    TX_FAR _UnnamedText_55644
    db $50
; 0x55644 + 5 bytes

UnnamedText_55649: ; 0x55649
    TX_FAR _UnnamedText_55649
    db $50
; 0x55649 + 5 bytes

UnnamedText_5564e: ; 0x5564e
    TX_FAR _UnnamedText_5564e
    db $50
; 0x5564e + 5 bytes

Route3Text10: ; 0x55653
    TX_FAR _Route3Text10
    db $50

Route4Script: ; 0x55658
    call $3c3c
    ld hl, $567d
    ld de, $566b
    ld a, [$d5f9]
    call $3160
    ld [$d5f9], a
    ret
; 0x5566b

INCBIN "baserom.gbc",$5566b,$6

Route4Texts: ; 0x55671
    dw Route4Text1, Route4Text2, Route4Text3, Route4Text4, Route4Text5, Route4Text6

INCBIN "baserom.gbc",$5567d,$d

Route4Text1: ; 0x5568a
    TX_FAR _Route4Text1
    db $50

Route4Text2: ; 0x5568f
    db $08 ; asm
    ld hl, $567d
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55699: ; 0x55699
    TX_FAR _UnnamedText_55699
    db $50
; 0x55699 + 5 bytes

UnnamedText_5569e: ; 0x5569e
    TX_FAR _UnnamedText_5569e
    db $50
; 0x5569e + 5 bytes

UnnamedText_556a3: ; 0x556a3
    TX_FAR _UnnamedText_556a3
    db $50
; 0x556a3 + 5 bytes

Route4Text5: ; 0x556a8
    TX_FAR _Route4Text5
    db $50

Route4Text6: ; 0x556ad
    TX_FAR _Route4Text6
    db $50

Route5Script: ; 0x556b2
    jp $3c3c
; 0x556b5

Route5Texts: ; 0x556b5
    dw Route5Text1

Route5Text1: ; 0x556b7
    TX_FAR _Route5Text1
    db $50

Route9Script: ; 0x556bc
    call $3c3c
    ld hl, $56eb
    ld de, $56cf
    ld a, [$d604]
    call $3160
    ld [$d604], a
    ret
; 0x556cf

INCBIN "baserom.gbc",$556cf,$6

Route9Texts: ; 0x556d5
    dw Route9Text1, Route9Text2, Route9Text3, Route9Text4, Route9Text5, Route9Text6, Route9Text7, Route9Text8, Route9Text9, Route9Text10, Route9Text11

Route12Text13: ; 0x556eb

INCBIN "baserom.gbc",$556eb,$556f0 - $556eb

Route12Text14: ; 0x556f0

INCBIN "baserom.gbc",$556f0,$55758 - $556f0

Route9Text1: ; 0x55758
    db $8 ; asm
    ld hl, $56eb
    jr asm_8be3d ; 0x5575c $2e

Route9Text2:
    db $8 ; asm
    ld hl, $56f7
    jr asm_8be3d ; 0x55762 $28

Route9Text3:
    db $8 ; asm
    ld hl, $5703
    jr asm_8be3d ; 0x55768 $22

Route9Text4:
    db $8 ; asm
    ld hl, $570f
    jr asm_8be3d ; 0x5576e $1c

Route9Text5:
    db $8 ; asm
    ld hl, $571b
    jr asm_8be3d ; 0x55774 $16

Route9Text6:
    db $8 ; asm
    ld hl, $5727
    jr asm_8be3d ; 0x5577a $10

Route9Text7:
    db $8 ; asm
    ld hl, $5733
    jr asm_8be3d ; 0x55780 $a

Route9Text8:
    db $8 ; asm
    ld hl, $573f
    jr asm_8be3d ; 0x55786 $4

Route9Text9:
    db $8 ; asm
    ld hl, $574b
asm_8be3d: ; 0x5578c
    call $31cc
    jp $24d7
; 0x55792

UnnamedText_55792: ; 0x55792
    TX_FAR _UnnamedText_55792
    db $50
; 0x55792 + 5 bytes

UnnamedText_55797: ; 0x55797
    TX_FAR _UnnamedText_55797
    db $50
; 0x55797 + 5 bytes

UnnamedText_5579c: ; 0x5579c
    TX_FAR _UnnamedText_5579c
    db $50
; 0x5579c + 5 bytes

UnnamedText_557a1: ; 0x557a1
    TX_FAR _UnnamedText_557a1
    db $50
; 0x557a1 + 5 bytes

UnnamedText_557a6: ; 0x557a6
    TX_FAR _UnnamedText_557a6
    db $50
; 0x557a6 + 5 bytes

UnnamedText_557ab: ; 0x557ab
    TX_FAR _UnnamedText_557ab
    db $50
; 0x557ab + 5 bytes

UnnamedText_557b0: ; 0x557b0
    TX_FAR _UnnamedText_557b0
    db $50
; 0x557b0 + 5 bytes

UnnamedText_557b5: ; 0x557b5
    TX_FAR _UnnamedText_557b5
    db $50
; 0x557b5 + 5 bytes

UnnamedText_557ba: ; 0x557ba
    TX_FAR _UnnamedText_557ba
    db $50
; 0x557ba + 5 bytes

UnnamedText_557bf: ; 0x557bf
    TX_FAR _UnnamedText_557bf
    db $50
; 0x557bf + 5 bytes

UnnamedText_557c4: ; 0x557c4
    TX_FAR _UnnamedText_557c4
    db $50
; 0x557c4 + 5 bytes

UnnamedText_557c9: ; 0x557c9
    TX_FAR _UnnamedText_557c9
    db $50
; 0x557c9 + 5 bytes

UnnamedText_557ce: ; 0x557ce
    TX_FAR _UnnamedText_557ce
    db $50
; 0x557ce + 5 bytes

UnnamedText_557d3: ; 0x557d3
    TX_FAR _UnnamedText_557d3
    db $50
; 0x557d3 + 5 bytes

UnnamedText_557d8: ; 0x557d8
    TX_FAR _UnnamedText_557d8
    db $50
; 0x557d8 + 5 bytes

UnnamedText_557dd: ; 0x557dd
    TX_FAR _UnnamedText_557dd
    db $50
; 0x557dd + 5 bytes

UnnamedText_557e2: ; 0x557e2
    TX_FAR _UnnamedText_557e2
    db $50
; 0x557e2 + 5 bytes

UnnamedText_557e7: ; 0x557e7
    TX_FAR _UnnamedText_557e7
    db $50
; 0x557e7 + 5 bytes

UnnamedText_557ec: ; 0x557ec
    TX_FAR _UnnamedText_557ec
    db $50
; 0x557ec + 5 bytes

UnnamedText_557f1: ; 0x557f1
    TX_FAR _UnnamedText_557f1
    db $50
; 0x557f1 + 5 bytes

UnnamedText_557f6: ; 0x557f6
    TX_FAR _UnnamedText_557f6
    db $50
; 0x557f6 + 5 bytes

UnnamedText_557fb: ; 0x557fb
    TX_FAR _UnnamedText_557fb
    db $50
; 0x557fb + 5 bytes

UnnamedText_55800: ; 0x55800
    TX_FAR _UnnamedText_55800
    db $50
; 0x55800 + 5 bytes

UnnamedText_55805: ; 0x55805
    TX_FAR _UnnamedText_55805
    db $50
; 0x55805 + 5 bytes

UnnamedText_5580a: ; 0x5580a
    TX_FAR _UnnamedText_5580a
    db $50
; 0x5580a + 5 bytes

UnnamedText_5580f: ; 0x5580f
    TX_FAR _UnnamedText_5580f
    db $50
; 0x5580f + 5 bytes

UnnamedText_55814: ; 0x55814
    TX_FAR _UnnamedText_55814
    db $50
; 0x55814 + 5 bytes

Route9Text11: ; 0x55819
    TX_FAR _Route9Text11
    db $50

Route13Script: ; 0x5581e
    call $3c3c
    ld hl, $5851
    ld de, $5831
    ld a, [$d61a]
    call $3160
    ld [$d61a], a
    ret
; 0x55831

INCBIN "baserom.gbc",$55831,$6

Route13Texts: ; 0x55837
    dw Route13Text1, Route13Text2, Route13Text3, Route13Text4, Route13Text5, Route13Text6, Route13Text7, Route13Text8, Route13Text9, Route13Text10, Route13Text11, Route13Text12, Route13Text13

INCBIN "baserom.gbc",$55851,$79

Route13Text1: ; 0x558ca
    db $08 ; asm
    ld hl, $5851
    call LoadTrainerHeader
    jp $24d7

UnnamedText_558d4: ; 0x558d4
    TX_FAR _UnnamedText_558d4
    db $50
; 0x558d4 + 5 bytes

UnnamedText_558d9: ; 0x558d9
    TX_FAR _UnnamedText_558d9
    db $50
; 0x558d9 + 5 bytes

UnnamedText_558de: ; 0x558de
    TX_FAR _UnnamedText_558de
    db $50
; 0x558de + 5 bytes

Route13Text2: ; 0x558e3
    db $08 ; asm
    ld hl, $585d
    call LoadTrainerHeader
    jp $24d7

UnnamedText_558ed: ; 0x558ed
    TX_FAR _UnnamedText_558ed
    db $50
; 0x558ed + 5 bytes

UnnamedText_558f2: ; 0x558f2
    TX_FAR _UnnamedText_558f2
    db $50
; 0x558f2 + 5 bytes

UnnamedText_558f7: ; 0x558f7
    TX_FAR _UnnamedText_558f7
    db $50
; 0x558f7 + 5 bytes

Route13Text3: ; 0x558fc
    db $08 ; asm
    ld hl, $5869
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55906: ; 0x55906
    TX_FAR _UnnamedText_55906
    db $50
; 0x55906 + 5 bytes

UnnamedText_5590b: ; 0x5590b
    TX_FAR _UnnamedText_5590b
    db $50
; 0x5590b + 5 bytes

UnnamedText_55910: ; 0x55910
    TX_FAR _UnnamedText_55910
    db $50
; 0x55910 + 5 bytes

Route13Text4: ; 0x55915
    db $08 ; asm
    ld hl, $5875
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5591f: ; 0x5591f
    TX_FAR _UnnamedText_5591f
    db $50
; 0x5591f + 5 bytes

UnnamedText_55924: ; 0x55924
    TX_FAR _UnnamedText_55924
    db $50
; 0x55924 + 5 bytes

UnnamedText_55929: ; 0x55929
    TX_FAR _UnnamedText_55929
    db $50
; 0x55929 + 5 bytes

Route13Text5: ; 0x5592e
    db $08 ; asm
    ld hl, $5881
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55938: ; 0x55938
    TX_FAR _UnnamedText_55938
    db $50
; 0x55938 + 5 bytes

UnnamedText_5593d: ; 0x5593d
    TX_FAR _UnnamedText_5593d
    db $50
; 0x5593d + 5 bytes

UnnamedText_55942: ; 0x55942
    TX_FAR _UnnamedText_55942
    db $50
; 0x55942 + 5 bytes

Route13Text6: ; 0x55947
    db $08 ; asm
    ld hl, $588d
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55951: ; 0x55951
    TX_FAR _UnnamedText_55951
    db $50
; 0x55951 + 5 bytes

UnnamedText_55956: ; 0x55956
    TX_FAR _UnnamedText_55956
    db $50
; 0x55956 + 5 bytes

UnnamedText_5595b: ; 0x5595b
    TX_FAR _UnnamedText_5595b
    db $50
; 0x5595b + 5 bytes

Route13Text7: ; 0x55960
    db $08 ; asm
    ld hl, $5899
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5596a: ; 0x5596a
    TX_FAR _UnnamedText_5596a
    db $50
; 0x5596a + 5 bytes

UnnamedText_5596f: ; 0x5596f
    TX_FAR _UnnamedText_5596f
    db $50
; 0x5596f + 5 bytes

UnnamedText_55974: ; 0x55974
    TX_FAR _UnnamedText_55974
    db $50
; 0x55974 + 5 bytes

Route13Text8: ; 0x55979
    db $08 ; asm
    ld hl, $58a5
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55983: ; 0x55983
    TX_FAR _UnnamedText_55983
    db $50
; 0x55983 + 5 bytes

UnnamedText_55988: ; 0x55988
    TX_FAR _UnnamedText_55988
    db $50
; 0x55988 + 5 bytes

UnnamedText_5598d: ; 0x5598d
    TX_FAR _UnnamedText_5598d
    db $50
; 0x5598d + 5 bytes

Route13Text9: ; 0x55992
    db $08 ; asm
    ld hl, $58b1
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5599c: ; 0x5599c
    TX_FAR _UnnamedText_5599c
    db $50
; 0x5599c + 5 bytes

UnnamedText_559a1: ; 0x559a1
    TX_FAR _UnnamedText_559a1
    db $50
; 0x559a1 + 5 bytes

UnnamedText_559a6: ; 0x559a6
    TX_FAR _UnnamedText_559a6
    db $50
; 0x559a6 + 5 bytes

Route13Text10: ; 0x559ab
    db $08 ; asm
    ld hl, $58bd
    call LoadTrainerHeader
    jp $24d7

UnnamedText_559b5: ; 0x559b5
    TX_FAR _UnnamedText_559b5
    db $50
; 0x559b5 + 5 bytes

UnnamedText_559ba: ; 0x559ba
    TX_FAR _UnnamedText_559ba
    db $50
; 0x559ba + 5 bytes

UnnamedText_559bf: ; 0x559bf
    TX_FAR _UnnamedText_559bf
    db $50
; 0x559bf + 5 bytes

Route13Text11: ; 0x559c4
    TX_FAR _Route13Text11
    db $50

Route13Text12: ; 0x559c9
    TX_FAR _Route13Text12
    db $50

Route13Text13: ; 0x559ce
    TX_FAR _Route13Text13
    db $50

Route14Script: ; 0x559d3
    call $3c3c
    ld hl, $5a02
    ld de, $59e6
    ld a, [$d61b]
    call $3160
    ld [$d61b], a
    ret
; 0x559e6

INCBIN "baserom.gbc",$559e6,$6

Route14Texts: ; 0x559ec
    dw Route14Text1, Route14Text2, Route14Text3, Route14Text4, Route14Text5, Route14Text6, Route14Text7, Route14Text8, Route14Text9, Route14Text10, Route14Text11

INCBIN "baserom.gbc",$55a02,$79

Route14Text1: ; 0x55a7b
    db $08 ; asm
    ld hl, $5a02
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55a85: ; 0x55a85
    TX_FAR _UnnamedText_55a85
    db $50
; 0x55a85 + 5 bytes

UnnamedText_55a8a: ; 0x55a8a
    TX_FAR _UnnamedText_55a8a
    db $50
; 0x55a8a + 5 bytes

UnnamedText_55a8f: ; 0x55a8f
    TX_FAR _UnnamedText_55a8f
    db $50
; 0x55a8f + 5 bytes

Route14Text2: ; 0x55a94
    db $08 ; asm
    ld hl, $5a0e
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55a9e: ; 0x55a9e
    TX_FAR _UnnamedText_55a9e
    db $50
; 0x55a9e + 5 bytes

UnnamedText_55aa3: ; 0x55aa3
    TX_FAR _UnnamedText_55aa3
    db $50
; 0x55aa3 + 5 bytes

UnnamedText_55aa8: ; 0x55aa8
    TX_FAR _UnnamedText_55aa8
    db $50
; 0x55aa8 + 5 bytes

Route14Text3: ; 0x55aad
    db $08 ; asm
    ld hl, $5a1a
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55ab7: ; 0x55ab7
    TX_FAR _UnnamedText_55ab7
    db $50
; 0x55ab7 + 5 bytes

UnnamedText_55abc: ; 0x55abc
    TX_FAR _UnnamedText_55abc
    db $50
; 0x55abc + 5 bytes

UnnamedText_55ac1: ; 0x55ac1
    TX_FAR _UnnamedText_55ac1
    db $50
; 0x55ac1 + 5 bytes

Route14Text4: ; 0x55ac6
    db $08 ; asm
    ld hl, $5a26
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55ad0: ; 0x55ad0
    TX_FAR _UnnamedText_55ad0
    db $50
; 0x55ad0 + 5 bytes

UnnamedText_55ad5: ; 0x55ad5
    TX_FAR _UnnamedText_55ad5
    db $50
; 0x55ad5 + 5 bytes

UnnamedText_55ada: ; 0x55ada
    TX_FAR _UnnamedText_55ada
    db $50
; 0x55ada + 5 bytes

Route14Text5: ; 0x55adf
    db $08 ; asm
    ld hl, $5a32
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55ae9: ; 0x55ae9
    TX_FAR _UnnamedText_55ae9
    db $50
; 0x55ae9 + 5 bytes

UnnamedText_55aee: ; 0x55aee
    TX_FAR _UnnamedText_55aee
    db $50
; 0x55aee + 5 bytes

UnnamedText_55af3: ; 0x55af3
    TX_FAR _UnnamedText_55af3
    db $50
; 0x55af3 + 5 bytes

Route14Text6: ; 0x55af8
    db $08 ; asm
    ld hl, $5a3e
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55b02: ; 0x55b02
    TX_FAR _UnnamedText_55b02
    db $50
; 0x55b02 + 5 bytes

UnnamedText_55b07: ; 0x55b07
    TX_FAR _UnnamedText_55b07
    db $50
; 0x55b07 + 5 bytes

UnnamedText_55b0c: ; 0x55b0c
    TX_FAR _UnnamedText_55b0c
    db $50
; 0x55b0c + 5 bytes

Route14Text7: ; 0x55b11
    db $08 ; asm
    ld hl, $5a4a
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55b1b: ; 0x55b1b
    TX_FAR _UnnamedText_55b1b
    db $50
; 0x55b1b + 5 bytes

UnnamedText_55b20: ; 0x55b20
    TX_FAR _UnnamedText_55b20
    db $50
; 0x55b20 + 5 bytes

UnnamedText_55b25: ; 0x55b25
    TX_FAR _UnnamedText_55b25
    db $50
; 0x55b25 + 5 bytes

Route14Text8: ; 0x55b2a
    db $08 ; asm
    ld hl, $5a56
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55b34: ; 0x55b34
    TX_FAR _UnnamedText_55b34
    db $50
; 0x55b34 + 5 bytes

UnnamedText_55b39: ; 0x55b39
    TX_FAR _UnnamedText_55b39
    db $50
; 0x55b39 + 5 bytes

UnnamedText_55b3e: ; 0x55b3e
    TX_FAR _UnnamedText_55b3e
    db $50
; 0x55b3e + 5 bytes

Route14Text9: ; 0x55b43
    db $08 ; asm
    ld hl, $5a62
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55b4d: ; 0x55b4d
    TX_FAR _UnnamedText_55b4d
    db $50
; 0x55b4d + 5 bytes

UnnamedText_55b52: ; 0x55b52
    TX_FAR _UnnamedText_55b52
    db $50
; 0x55b52 + 5 bytes

UnnamedText_55b57: ; 0x55b57
    TX_FAR _UnnamedText_55b57
    db $50
; 0x55b57 + 5 bytes

Route14Text10: ; 0x55b5c
    db $08 ; asm
    ld hl, $5a6e
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55b66: ; 0x55b66
    TX_FAR _UnnamedText_55b66
    db $50
; 0x55b66 + 5 bytes

UnnamedText_55b6b: ; 0x55b6b
    TX_FAR _UnnamedText_55b6b
    db $50
; 0x55b6b + 5 bytes

UnnamedText_55b70: ; 0x55b70
    TX_FAR _UnnamedText_55b70
    db $50
; 0x55b70 + 5 bytes

Route14Text11: ; 0x55b75
    TX_FAR _Route14Text11
    db $50

Route17Script: ; 0x55b7a
    call $3c3c
    ld hl, $5bb3
    ld de, $5b8d
    ld a, [$d61c]
    call $3160
    ld [$d61c], a
    ret
; 0x55b8d

INCBIN "baserom.gbc",$55b8d,$6

Route17Texts: ; 0x55b93
    dw Route17Text1, Route17Text2, Route17Text3, Route17Text4, Route17Text5, Route17Text6, Route17Text7, Route17Text8, Route17Text9, Route17Text10, Route17Text11, Route17Text12, Route17Text13, Route17Text14, Route17Text15, Route17Text16

INCBIN "baserom.gbc",$55bb3,$79

Route17Text1: ; 0x55c2c
    db $08 ; asm
    ld hl, $5bb3
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55c36: ; 0x55c36
    TX_FAR _UnnamedText_55c36
    db $50
; 0x55c36 + 5 bytes

UnnamedText_55c3b: ; 0x55c3b
    TX_FAR _UnnamedText_55c3b
    db $50
; 0x55c3b + 5 bytes

UnnamedText_55c40: ; 0x55c40
    TX_FAR _UnnamedText_55c40
    db $50
; 0x55c40 + 5 bytes

Route17Text2: ; 0x55c45
    db $08 ; asm
    ld hl, $5bbf
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55c4f: ; 0x55c4f
    TX_FAR _UnnamedText_55c4f
    db $50
; 0x55c4f + 5 bytes

UnnamedText_55c54: ; 0x55c54
    TX_FAR _UnnamedText_55c54
    db $50
; 0x55c54 + 5 bytes

UnnamedText_55c59: ; 0x55c59
    TX_FAR _UnnamedText_55c59
    db $50
; 0x55c59 + 5 bytes

Route17Text3: ; 0x55c5e
    db $08 ; asm
    ld hl, $5bcb
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55c68: ; 0x55c68
    TX_FAR _UnnamedText_55c68
    db $50
; 0x55c68 + 5 bytes

UnnamedText_55c6d: ; 0x55c6d
    TX_FAR _UnnamedText_55c6d
    db $50
; 0x55c6d + 5 bytes

UnnamedText_55c72: ; 0x55c72
    TX_FAR _UnnamedText_55c72
    db $50
; 0x55c72 + 5 bytes

Route17Text4: ; 0x55c77
    db $08 ; asm
    ld hl, $5bd7
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55c81: ; 0x55c81
    TX_FAR _UnnamedText_55c81
    db $50
; 0x55c81 + 5 bytes

UnnamedText_55c86: ; 0x55c86
    TX_FAR _UnnamedText_55c86
    db $50
; 0x55c86 + 5 bytes

UnnamedText_55c8b: ; 0x55c8b
    TX_FAR _UnnamedText_55c8b
    db $50
; 0x55c8b + 5 bytes

Route17Text5: ; 0x55c90
    db $08 ; asm
    ld hl, $5be3
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55c9a: ; 0x55c9a
    TX_FAR _UnnamedText_55c9a
    db $50
; 0x55c9a + 5 bytes

UnnamedText_55c9f: ; 0x55c9f
    TX_FAR _UnnamedText_55c9f
    db $50
; 0x55c9f + 5 bytes

UnnamedText_55ca4: ; 0x55ca4
    TX_FAR _UnnamedText_55ca4
    db $50
; 0x55ca4 + 5 bytes

Route17Text6: ; 0x55ca9
    db $08 ; asm
    ld hl, $5bef
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55cb3: ; 0x55cb3
    TX_FAR _UnnamedText_55cb3
    db $50
; 0x55cb3 + 5 bytes

UnnamedText_55cb8: ; 0x55cb8
    TX_FAR _UnnamedText_55cb8
    db $50
; 0x55cb8 + 5 bytes

UnnamedText_55cbd: ; 0x55cbd
    TX_FAR _UnnamedText_55cbd
    db $50
; 0x55cbd + 5 bytes

Route17Text7: ; 0x55cc2
    db $08 ; asm
    ld hl, $5bfb
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55ccc: ; 0x55ccc
    TX_FAR _UnnamedText_55ccc
    db $50
; 0x55ccc + 5 bytes

UnnamedText_55cd1: ; 0x55cd1
    TX_FAR _UnnamedText_55cd1
    db $50
; 0x55cd1 + 5 bytes

UnnamedText_55cd6: ; 0x55cd6
    TX_FAR _UnnamedText_55cd6
    db $50
; 0x55cd6 + 5 bytes

Route17Text8: ; 0x55cdb
    db $08 ; asm
    ld hl, $5c07
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55ce5: ; 0x55ce5
    TX_FAR _UnnamedText_55ce5
    db $50
; 0x55ce5 + 5 bytes

UnnamedText_55cea: ; 0x55cea
    TX_FAR _UnnamedText_55cea
    db $50
; 0x55cea + 5 bytes

UnnamedText_55cef: ; 0x55cef
    TX_FAR _UnnamedText_55cef
    db $50
; 0x55cef + 5 bytes

Route17Text9: ; 0x55cf4
    db $08 ; asm
    ld hl, $5c13
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55cfe: ; 0x55cfe
    TX_FAR _UnnamedText_55cfe
    db $50
; 0x55cfe + 5 bytes

UnnamedText_55d03: ; 0x55d03
    TX_FAR _UnnamedText_55d03
    db $50
; 0x55d03 + 5 bytes

UnnamedText_55d08: ; 0x55d08
    TX_FAR _UnnamedText_55d08
    db $50
; 0x55d08 + 5 bytes

Route17Text10: ; 0x55d0d
    db $08 ; asm
    ld hl, $5c1f
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55d17: ; 0x55d17
    TX_FAR _UnnamedText_55d17
    db $50
; 0x55d17 + 5 bytes

UnnamedText_55d1c: ; 0x55d1c
    TX_FAR _UnnamedText_55d1c
    db $50
; 0x55d1c + 5 bytes

UnnamedText_55d21: ; 0x55d21
    TX_FAR _UnnamedText_55d21
    db $50
; 0x55d21 + 5 bytes

Route17Text11: ; 0x55d26
    TX_FAR _Route17Text11
    db $50

Route17Text12: ; 0x55d2b
    TX_FAR _Route17Text12
    db $50

Route17Text13: ; 0x55d30
    TX_FAR _Route17Text13
    db $50

Route17Text14: ; 0x55d35
    TX_FAR _Route17Text14
    db $50

Route17Text15: ; 0x55d3a
    TX_FAR _Route17Text15
    db $50

Route17Text16: ; 0x55d3f
    TX_FAR _Route17Text16
    db $50

Route19Script: ; 0x55d44
    call $3c3c
    ld hl, $5d73
    ld de, $5d57
    ld a, [$d61d]
    call $3160
    ld [$d61d], a
    ret
; 0x55d57

INCBIN "baserom.gbc",$55d57,$6

Route19Texts: ; 0x55d5d
    dw Route19Text1, Route19Text2, Route19Text3, Route19Text4, Route19Text5, Route19Text6, Route19Text7, Route19Text8, Route19Text9, Route19Text10, Route19Text11

INCBIN "baserom.gbc",$55d73,$79

Route19Text1: ; 0x55dec
    db $08 ; asm
    ld hl, $5d73
    call LoadTrainerHeader
    jp $24d7

Route19Text2: ; 0x55df6
    db $08 ; asm
    ld hl, $5d7f
    call LoadTrainerHeader
    jp $24d7

Route19Text3: ; 0x55e00
    db $08 ; asm
    ld hl, $5d8b
    call LoadTrainerHeader
    jp $24d7

Route19Text4: ; 0x55e0a
    db $08 ; asm
    ld hl, $5d97
    call LoadTrainerHeader
    jp $24d7

Route19Text5: ; 0x55e14
    db $08 ; asm
    ld hl, $5da3
    call LoadTrainerHeader
    jp $24d7

Route19Text6: ; 0x55e1e
    db $08 ; asm
    ld hl, $5daf
    call LoadTrainerHeader
    jp $24d7

Route19Text7: ; 0x55e28
    db $08 ; asm
    ld hl, $5dbb
    call LoadTrainerHeader
    jp $24d7

Route19Text8: ; 0x55e32
    db $08 ; asm
    ld hl, $5dc7
    call LoadTrainerHeader
    jp $24d7

Route19Text9: ; 0x55e3c
    db $08 ; asm
    ld hl, $5dd3
    call LoadTrainerHeader
    jp $24d7

Route19Text10: ; 0x55e46
    db $08 ; asm
    ld hl, $5ddf
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55e50: ; 0x55e50
    TX_FAR _UnnamedText_55e50
    db $50
; 0x55e50 + 5 bytes

UnnamedText_55e55: ; 0x55e55
    TX_FAR _UnnamedText_55e55
    db $50
; 0x55e55 + 5 bytes

UnnamedText_55e5a: ; 0x55e5a
    TX_FAR _UnnamedText_55e5a
    db $50
; 0x55e5a + 5 bytes

UnnamedText_55e5f: ; 0x55e5f
    TX_FAR _UnnamedText_55e5f
    db $50
; 0x55e5f + 5 bytes

UnnamedText_55e64: ; 0x55e64
    TX_FAR _UnnamedText_55e64
    db $50
; 0x55e64 + 5 bytes

UnnamedText_55e69: ; 0x55e69
    TX_FAR _UnnamedText_55e69
    db $50
; 0x55e69 + 5 bytes

UnnamedText_55e6e: ; 0x55e6e
    TX_FAR _UnnamedText_55e6e
    db $50
; 0x55e6e + 5 bytes

UnnamedText_55e73: ; 0x55e73
    TX_FAR _UnnamedText_55e73
    db $50
; 0x55e73 + 5 bytes

UnnamedText_55e78: ; 0x55e78
    TX_FAR _UnnamedText_55e78
    db $50
; 0x55e78 + 5 bytes

UnnamedText_55e7d: ; 0x55e7d
    TX_FAR _UnnamedText_55e7d
    db $50
; 0x55e7d + 5 bytes

UnnamedText_55e82: ; 0x55e82
    TX_FAR _UnnamedText_55e82
    db $50
; 0x55e82 + 5 bytes

UnnamedText_55e87: ; 0x55e87
    TX_FAR _UnnamedText_55e87
    db $50
; 0x55e87 + 5 bytes

UnnamedText_55e8c: ; 0x55e8c
    TX_FAR _UnnamedText_55e8c
    db $50
; 0x55e8c + 5 bytes

UnnamedText_55e91: ; 0x55e91
    TX_FAR _UnnamedText_55e91
    db $50
; 0x55e91 + 5 bytes

UnnamedText_55e96: ; 0x55e96
    TX_FAR _UnnamedText_55e96
    db $50
; 0x55e96 + 5 bytes

UnnamedText_55e9b: ; 0x55e9b
    TX_FAR _UnnamedText_55e9b
    db $50
; 0x55e9b + 5 bytes

UnnamedText_55ea0: ; 0x55ea0
    TX_FAR _UnnamedText_55ea0
    db $50
; 0x55ea0 + 5 bytes

UnnamedText_55ea5: ; 0x55ea5
    TX_FAR _UnnamedText_55ea5
    db $50
; 0x55ea5 + 5 bytes

UnnamedText_55eaa: ; 0x55eaa
    TX_FAR _UnnamedText_55eaa
    db $50
; 0x55eaa + 5 bytes

UnnamedText_55eaf: ; 0x55eaf
    TX_FAR _UnnamedText_55eaf
    db $50
; 0x55eaf + 5 bytes

UnnamedText_55eb4: ; 0x55eb4
    TX_FAR _UnnamedText_55eb4
    db $50
; 0x55eb4 + 5 bytes

UnnamedText_55eb9: ; 0x55eb9
    TX_FAR _UnnamedText_55eb9
    db $50
; 0x55eb9 + 5 bytes

UnnamedText_55ebe: ; 0x55ebe
    TX_FAR _UnnamedText_55ebe
    db $50
; 0x55ebe + 5 bytes

UnnamedText_55ec3: ; 0x55ec3
    TX_FAR _UnnamedText_55ec3
    db $50
; 0x55ec3 + 5 bytes

UnnamedText_55ec8: ; 0x55ec8
    TX_FAR _UnnamedText_55ec8
    db $50
; 0x55ec8 + 5 bytes

UnnamedText_55ecd: ; 0x55ecd
    TX_FAR _UnnamedText_55ecd
    db $50
; 0x55ecd + 5 bytes

UnnamedText_55ed2: ; 0x55ed2
    TX_FAR _UnnamedText_55ed2
    db $50
; 0x55ed2 + 5 bytes

UnnamedText_55ed7: ; 0x55ed7
    TX_FAR _UnnamedText_55ed7
    db $50
; 0x55ed7 + 5 bytes

UnnamedText_55edc: ; 0x55edc
    TX_FAR _UnnamedText_55edc
    db $50
; 0x55edc + 5 bytes

UnnamedText_55ee1: ; 0x55ee1
    TX_FAR _UnnamedText_55ee1
    db $50
; 0x55ee1 + 5 bytes

Route19Text11: ; 0x55ee6
    TX_FAR _Route19Text11
    db $50

Route21Script: ; 0x55eeb
    call $3c3c
    ld hl, $5f16
    ld de, $5efe
    ld a, [$d61e]
    call $3160
    ld [$d61e], a
    ret
; 0x55efe

INCBIN "baserom.gbc",$55efe,$6

Route21Texts: ; 0x55f04
    dw Route21Text1, Route21Text2, Route21Text3, Route21Text4, Route21Text5, Route21Text6, Route21Text7, Route21Text8, Route21Text9

INCBIN "baserom.gbc",$55f16,$6d

Route21Text1: ; 0x55f83
    db $08 ; asm
    ld hl, $5f16
    call LoadTrainerHeader
    jp $24d7

Route21Text2: ; 0x55f8d
    db $08 ; asm
    ld hl, $5f22
    call LoadTrainerHeader
    jp $24d7

Route21Text3: ; 0x55f97
    db $08 ; asm
    ld hl, $5f2e
    call LoadTrainerHeader
    jp $24d7

Route21Text4: ; 0x55fa1
    db $08 ; asm
    ld hl, $5f3a
    call LoadTrainerHeader
    jp $24d7

Route21Text5: ; 0x55fab
    db $08 ; asm
    ld hl, $5f46
    call LoadTrainerHeader
    jp $24d7

Route21Text6: ; 0x55fb5
    db $08 ; asm
    ld hl, $5f52
    call LoadTrainerHeader
    jp $24d7

Route21Text7: ; 0x55fbf
    db $08 ; asm
    ld hl, $5f5e
    call LoadTrainerHeader
    jp $24d7

Route21Text8: ; 0x55fc9
    db $08 ; asm
    ld hl, $5f6a
    call LoadTrainerHeader
    jp $24d7

Route21Text9: ; 0x55fd3
    db $08 ; asm
    ld hl, $5f76
    call LoadTrainerHeader
    jp $24d7

UnnamedText_55fdd: ; 0x55fdd
    TX_FAR _UnnamedText_55fdd
    db $50
; 0x55fdd + 5 bytes

UnnamedText_55fe2: ; 0x55fe2
    TX_FAR _UnnamedText_55fe2
    db $50
; 0x55fe2 + 5 bytes

UnnamedText_55fe7: ; 0x55fe7
    TX_FAR _UnnamedText_55fe7
    db $50
; 0x55fe7 + 5 bytes

UnnamedText_55fec: ; 0x55fec
    TX_FAR _UnnamedText_55fec
    db $50
; 0x55fec + 5 bytes

UnnamedText_55ff1: ; 0x55ff1
    TX_FAR _UnnamedText_55ff1
    db $50
; 0x55ff1 + 5 bytes

UnnamedText_55ff6: ; 0x55ff6
    TX_FAR _UnnamedText_55ff6
    db $50
; 0x55ff6 + 5 bytes

UnnamedText_55ffb: ; 0x55ffb
    TX_FAR _UnnamedText_55ffb
    db $50
; 0x55ffb + 5 bytes

UnnamedText_56000: ; 0x56000
    TX_FAR _UnnamedText_56000
    db $50
; 0x56000 + 5 bytes

UnnamedText_56005: ; 0x56005
    TX_FAR _UnnamedText_56005
    db $50
; 0x56005 + 5 bytes

UnnamedText_5600a: ; 0x5600a
    TX_FAR _UnnamedText_5600a
    db $50
; 0x5600a + 5 bytes

UnnamedText_5600f: ; 0x5600f
    TX_FAR _UnnamedText_5600f
    db $50
; 0x5600f + 5 bytes

UnnamedText_56014: ; 0x56014
    TX_FAR _UnnamedText_56014
    db $50
; 0x56014 + 5 bytes

UnnamedText_56019: ; 0x56019
    TX_FAR _UnnamedText_56019
    db $50
; 0x56019 + 5 bytes

UnnamedText_5601e: ; 0x5601e
    TX_FAR _UnnamedText_5601e
    db $50
; 0x5601e + 5 bytes

UnnamedText_56023: ; 0x56023
    TX_FAR _UnnamedText_56023
    db $50
; 0x56023 + 5 bytes

UnnamedText_56028: ; 0x56028
    TX_FAR _UnnamedText_56028
    db $50
; 0x56028 + 5 bytes

UnnamedText_5602d: ; 0x5602d
    TX_FAR _UnnamedText_5602d
    db $50
; 0x5602d + 5 bytes

UnnamedText_56032: ; 0x56032
    TX_FAR _UnnamedText_56032
    db $50
; 0x56032 + 5 bytes

UnnamedText_56037: ; 0x56037
    TX_FAR _UnnamedText_56037
    db $50
; 0x56037 + 5 bytes

UnnamedText_5603c: ; 0x5603c
    TX_FAR _UnnamedText_5603c
    db $50
; 0x5603c + 5 bytes

UnnamedText_56041: ; 0x56041
    TX_FAR _UnnamedText_56041
    db $50
; 0x56041 + 5 bytes

UnnamedText_56046: ; 0x56046
    TX_FAR _UnnamedText_56046
    db $50
; 0x56046 + 5 bytes

UnnamedText_5604b: ; 0x5604b
    TX_FAR _UnnamedText_5604b
    db $50
; 0x5604b + 5 bytes

UnnamedText_56050: ; 0x56050
    TX_FAR _UnnamedText_56050
    db $50
; 0x56050 + 5 bytes

UnnamedText_56055: ; 0x56055
    TX_FAR _UnnamedText_56055
    db $50
; 0x56055 + 5 bytes

UnnamedText_5605a: ; 0x5605a
    TX_FAR _UnnamedText_5605a
    db $50
; 0x5605a + 5 bytes

UnnamedText_5605f: ; 0x5605f
    TX_FAR _UnnamedText_5605f
    db $50
; 0x5605f + 5 bytes

VermilionHouse2_h: ; 0x56064 to 0x56070 (12 bytes) (id=163)
    db $08 ; tileset
    db VERMILION_HOUSE_2_HEIGHT, VERMILION_HOUSE_2_WIDTH ; dimensions (y, x)
    dw VermilionHouse2Blocks, VermilionHouse2Texts, VermilionHouse2Script ; blocks, texts, scripts
    db $00 ; connections

    dw VermilionHouse2Object ; objects

VermilionHouse2Script: ; 0x56070
    jp $3c3c
; 0x56073

VermilionHouse2Texts: ; 0x56073
    dw VermilionHouse2Text1

VermilionHouse2Text1: ; 0x56075
    db $08 ; asm
    ld a, [$d728]
    bit 3, a
    jr nz, asm_03ef5 ; 0x5607b
    ld hl, $60b1
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, asm_eb1b7 ; 0x5608a
    ld bc,(OLD_ROD << 8) | 1
    call $3e2e
    jr nc, asm_fd67b ; 0x56092
    ld hl, $d728
    set 3, [hl]
    ld hl, $60b6
    jr asm_5dd95 ; 0x5609c
asm_fd67b ; 0x5609e
    ld hl, $60ca
    jr asm_5dd95 ; 0x560a1
asm_eb1b7 ; 0x560a3
    ld hl, $60c0
    jr asm_5dd95 ; 0x560a6
asm_03ef5 ; 0x560a8
    ld hl, $60c5
asm_5dd95 ; 0x560ab
    call PrintText
    jp $24d7

UnnamedText_560b1: ; 0x560b1
    TX_FAR _UnnamedText_560b1
    db $50
; 0x560b1 + 5 bytes

INCBIN "baserom.gbc",$560b6,$560bb - $560b6

UnnamedText_560bb: ; 0x560bb
    TX_FAR _UnnamedText_560bb
    db $50
; 0x560bb + 5 bytes

UnnamedText_560c0: ; 0x560c0
    TX_FAR _UnnamedText_560c0
    db $50
; 0x560c0 + 5 bytes

UnnamedText_560c5: ; 0x560c5
    TX_FAR _UnnamedText_560c5
    db $50
; 0x560c5 + 5 bytes

UnnamedText_560ca: ; 0x560ca
    TX_FAR _UnnamedText_560ca
    db $50
; 0x560ca + 5 bytes

VermilionHouse2Object: ; 0x560cf (size=26)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $8, $ff
    db $7, $3, $8, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_FISHER, $4 + 4, $2 + 4, $ff, $d3, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

CeladonMart2_h: ; 0x560e9 to 0x560f5 (12 bytes) (id=123)
    db $12 ; tileset
    db CELADON_MART_2_HEIGHT, CELADON_MART_2_WIDTH ; dimensions (y, x)
    dw CeladonMart2Blocks, CeladonMart2Texts, CeladonMart2Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMart2Object ; objects

CeladonMart2Script: ; 0x560f5
    jp $3c3c
; 0x560f8

CeladonMart2Texts: ; 0x560f8
    dw CeladonMart2Text1, CeladonMart2Text2, CeladonMart2Text3, CeladonMart2Text4, CeladonMart2Text5

CeladonMart2Text3: ; 0x56102
    TX_FAR _CeladonMart2Text3
    db $50

CeladonMart2Text4: ; 0x56107
    TX_FAR _CeladonMart2Text4
    db $50

CeladonMart2Text5: ; 0x5610c
    TX_FAR _CeladonMart2Text5
    db $50

CeladonMart2Object: ; 0x56111 (size=55)
    db $f ; border tile

    db $3 ; warps
    db $1, $c, $4, CELADON_MART_1
    db $1, $10, $1, CELADON_MART_3
    db $1, $1, $0, CELADON_MART_ELEVATOR

    db $1 ; signs
    db $1, $e, $5 ; CeladonMart2Text5

    db $4 ; people
    db SPRITE_MART_GUY, $3 + 4, $5 + 4, $ff, $d0, $1 ; person
    db SPRITE_MART_GUY, $3 + 4, $6 + 4, $ff, $d0, $2 ; person
    db SPRITE_FAT_BALD_GUY, $5 + 4, $13 + 4, $ff, $ff, $3 ; person
    db SPRITE_GIRL, $4 + 4, $e + 4, $fe, $1, $4 ; person

    ; warp-to
    EVENT_DISP $a, $1, $c ; CELADON_MART_1
    EVENT_DISP $a, $1, $10 ; CELADON_MART_3
    EVENT_DISP $a, $1, $1 ; CELADON_MART_ELEVATOR

CeladonMart2Blocks: ; 40
    INCBIN "maps/celadonmart2.blk"

FuchsiaHouse3_h: ; 0x56170 to 0x5617c (12 bytes) (id=164)
    db $0d ; tileset
    db FUCHSIA_HOUSE_3_HEIGHT, FUCHSIA_HOUSE_3_WIDTH ; dimensions (y, x)
    dw FuchsiaHouse3Blocks, FuchsiaHouse3Texts, FuchsiaHouse3Script ; blocks, texts, scripts
    db $00 ; connections

    dw FuchsiaHouse3Object ; objects

FuchsiaHouse3Script: ; 0x5617c
    jp $3c3c
; 0x5617f

FuchsiaHouse3Texts: ; 0x5617f
    dw FuchsiaHouse3Text1

FuchsiaHouse3Text1: ; 0x56181
    db $08 ; asm
    ld a, [$d728]
    bit 4, a
    jr nz, asm_6084e ; 0x56187
    ld hl, $61bd
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, asm_3ace4 ; 0x56196
    ld bc,(GOOD_ROD << 8) | 1
    call $3e2e
    jr nc, asm_628ee ; 0x5619e
    ld hl, $d728
    set 4, [hl]
    ld hl, $61c2
    jr asm_1b09c ; 0x561a8
asm_628ee ; 0x561aa
    ld hl, $621c
    jr asm_1b09c ; 0x561ad
asm_3ace4 ; 0x561af
    ld hl, $6212
    jr asm_1b09c ; 0x561b2
asm_6084e ; 0x561b4
    ld hl, $6217
asm_1b09c ; 0x561b7
    call PrintText
    jp $24d7

UnnamedText_561bd: ; 0x561bd
    TX_FAR _UnnamedText_561bd
    db $50
; 0x561bd + 5 bytes

INCBIN "baserom.gbc",$561c2,$56212 - $561c2

UnnamedText_56212: ; 0x56212
    TX_FAR _UnnamedText_56212
    db $50
; 0x56212 + 5 bytes

UnnamedText_56217: ; 0x56217
    TX_FAR _UnnamedText_56217
    db $50
; 0x56217 + 5 bytes

UnnamedText_5621c: ; 0x5621c
    TX_FAR _UnnamedText_5621c
    db $50
; 0x5621c + 5 bytes

FuchsiaHouse3Object: ; 0x56221 (size=34)
    db $c ; border tile

    db $3 ; warps
    db $0, $2, $8, $ff
    db $7, $2, $7, $ff
    db $7, $3, $7, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_FISHER, $3 + 4, $5 + 4, $ff, $d3, $1 ; person

    ; warp-to
    EVENT_DISP $4, $0, $2
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

DayCareM_h: ; 0x56243 to 0x5624f (12 bytes) (id=72)
    db $08 ; tileset
    db DAYCAREM_HEIGHT, DAYCAREM_WIDTH ; dimensions (y, x)
    dw DayCareMBlocks, DayCareMTexts, DayCareMScript ; blocks, texts, scripts
    db $00 ; connections

    dw DayCareMObject ; objects

DayCareMScript: ; 0x5624f
    jp $3c3c
; 0x56252

DayCareMTexts: ; 0x56252
    dw DayCareMText1

DayCareMText1: ; 0x56254
    db $8
    call $36f4
    ld a, [$da48]
    and a
    jp nz, $62e1
    ld hl, $640f
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    ld hl, $643b
    jp nz, $6409
    ld a, [$d163]
    dec a
    ld hl, $6445
    jp z, $6409
    ld hl, $6414
    call PrintText
    xor a
    ld [$cfcb], a
    ld [$d07d], a
    ld [$cc35], a
    call $13fc
    push af
    call $3dd4
    call $3dbe
    call $20ba
    pop af
    ld hl, $6437
    jp c, $6409
    ld hl, $571b
    ld b, $8
    call Bankswitch
    ld hl, $644a
    jp c, $6409
    xor a
    ld [$cc2b], a
    ld a, [$cf92]
    ld hl, $d2b5
    call $15ba
    ld hl, $6419
    call PrintText
    ld a, $1
    ld [$da48], a
    ld a, $3
    ld [$cf95], a
    call $3a68
    xor a
    ld [$cf95], a
    call $391f
    ld a, [$cf91]
    call $13d0
    ld hl, $641e
    jp $6409
; 0x562e1

INCBIN "baserom.gbc",$562e1,$5640f - $562e1

UnnamedText_5640f: ; 0x5640f
    TX_FAR _UnnamedText_5640f
    db $50
; 0x5640f + 5 bytes

UnnamedText_56414: ; 0x56414
    TX_FAR _UnnamedText_56414
    db $50
; 0x56414 + 5 bytes

UnnamedText_56419: ; 0x56419
    TX_FAR _UnnamedText_56419
    db $50
; 0x56419 + 5 bytes

UnnamedText_5641e: ; 0x5641e
    TX_FAR _UnnamedText_5641e
    db $50
; 0x5641e + 5 bytes

UnnamedText_56423: ; 0x56423
    TX_FAR _UnnamedText_56423
    db $50
; 0x56423 + 5 bytes

UnnamedText_56428: ; 0x56428
    TX_FAR _UnnamedText_56428
    db $50
; 0x56428 + 5 bytes

UnnamedText_5642d: ; 0x5642d
    TX_FAR _UnnamedText_5642d
    db $50
; 0x5642d + 5 bytes

UnnamedText_56432: ; 0x56432
    TX_FAR _UnnamedText_56432
    db $50
; 0x56432 + 5 bytes

INCBIN "baserom.gbc",$56437,$5643b - $56437

UnnamedText_5643b: ; 0x5643b
    TX_FAR _UnnamedText_5643b
    db $50
; 0x5643b + 5 bytes

UnnamedText_56440: ; 0x56440
    TX_FAR _UnnamedText_56440
    db $50
; 0x56440 + 5 bytes

UnnamedText_56445: ; 0x56445
    TX_FAR _UnnamedText_56445
    db $50
; 0x56445 + 5 bytes

UnnamedText_5644a: ; 0x5644a
    TX_FAR _UnnamedText_5644a
    db $50
; 0x5644a + 5 bytes

UnnamedText_5644f: ; 0x5644f
    TX_FAR _UnnamedText_5644f
    db $50
; 0x5644f + 5 bytes

UnnamedText_56454: ; 0x56454
    TX_FAR _UnnamedText_56454
    db $50
; 0x56454 + 5 bytes

DayCareMObject: ; 0x56459 (size=26)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $4, $ff
    db $7, $3, $4, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_GENTLEMAN, $3 + 4, $2 + 4, $ff, $d3, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

Route12House_h: ; 0x56473 to 0x5647f (12 bytes) (id=189)
    db $08 ; tileset
    db ROUTE_12_HOUSE_HEIGHT, ROUTE_12_HOUSE_WIDTH ; dimensions (y, x)
    dw Route12HouseBlocks, Route12HouseTexts, Route12HouseScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route12HouseObject ; objects

Route12HouseScript: ; 0x5647f
    jp $3c3c
; 0x56482

Route12HouseTexts: ; 0x56482
    dw Route12HouseText1

Route12HouseText1: ; 0x56484
    db $08 ; asm
    ld a, [$d728]
    bit 5, a
    jr nz, asm_b4cad ; 0x5648a
    ld hl, $64c0
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, asm_a2d76 ; 0x56499
    ld bc,(SUPER_ROD << 8) | 1
    call $3e2e
    jr nc, asm_e3b89 ; 0x564a1
    ld hl, $d728
    set 5, [hl]
    ld hl, $64c5
    jr asm_df984 ; 0x564ab
asm_e3b89 ; 0x564ad
    ld hl, $64d9
    jr asm_df984 ; 0x564b0
asm_a2d76 ; 0x564b2
    ld hl, $64cf
    jr asm_df984 ; 0x564b5
asm_b4cad ; 0x564b7
    ld hl, $64d4
asm_df984 ; 0x564ba
    call PrintText
    jp $24d7

UnnamedText_564c0: ; 0x564c0
    TX_FAR _UnnamedText_564c0
    db $50
; 0x564c0 + 5 bytes

INCBIN "baserom.gbc",$564c5,$564ca - $564c5

UnnamedText_564ca: ; 0x564ca
    TX_FAR _UnnamedText_564ca
    db $50
; 0x564ca + 5 bytes

UnnamedText_564cf: ; 0x564cf
    TX_FAR _UnnamedText_564cf
    db $50
; 0x564cf + 5 bytes

UnnamedText_564d4: ; 0x564d4
    TX_FAR _UnnamedText_564d4
    db $50
; 0x564d4 + 5 bytes

UnnamedText_564d9: ; 0x564d9
    TX_FAR _UnnamedText_564d9
    db $50
; 0x564d9 + 5 bytes

Route12HouseObject: ; 0x564de (size=26)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $3, $ff
    db $7, $3, $3, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_FISHER, $4 + 4, $2 + 4, $ff, $d3, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

SilphCo8_h: ; 0x564f8 to 0x56504 (12 bytes) (id=213)
    db $16 ; tileset
    db SILPH_CO_8F_HEIGHT, SILPH_CO_8F_WIDTH ; dimensions (y, x)
    dw SilphCo8Blocks, SilphCo8Texts, SilphCo8Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo8Object ; objects

SilphCo8Script: ; 0x56504
    call $651a
    call $3c3c
    ld hl, $6585
    ld de, $6577
    ld a, [$d649]
    call $3160
    ld [$d649], a
    ret
; 0x5651a

INCBIN "baserom.gbc",$5651a,$63

SilphCo8Texts: ; 0x5657d
    dw SilphCo8Text1, SilphCo8Text2, SilphCo8Text3, SilphCo8Text4

INCBIN "baserom.gbc",$56585,$25

SilphCo8Text1: ; 0x565aa
    db $08 ; asm
    ld a, [$d838]
    bit 7, a
    ld hl, $65c3
    jr nz, asm_a468f ; 0x565b3
    ld hl, $65be
asm_a468f ; 0x565b8
    call PrintText
    jp $24d7

UnnamedText_565be: ; 0x565be
    TX_FAR _UnnamedText_565be
    db $50
; 0x565be + 5 bytes

UnnamedText_565c3: ; 0x565c3
    TX_FAR _UnnamedText_565c3
    db $50
; 0x565c3 + 5 bytes

SilphCo8Text2: ; 0x565c8
    db $08 ; asm
    ld hl, $6585
    call LoadTrainerHeader
    jp $24d7

SilphCo8Text3: ; 0x565d2
    db $08 ; asm
    ld hl, $6591
    call LoadTrainerHeader
    jp $24d7

SilphCo8Text4: ; 0x565dc
    db $08 ; asm
    ld hl, $659d
    call LoadTrainerHeader
    jp $24d7

UnnamedText_565e6: ; 0x565e6
    TX_FAR _UnnamedText_565e6
    db $50
; 0x565e6 + 5 bytes

UnnamedText_565eb: ; 0x565eb
    TX_FAR _UnnamedText_565eb
    db $50
; 0x565eb + 5 bytes

UnnamedText_565f0: ; 0x565f0
    TX_FAR _UnnamedText_565f0
    db $50
; 0x565f0 + 5 bytes

UnnamedText_565f5: ; 0x565f5
    TX_FAR _UnnamedText_565f5
    db $50
; 0x565f5 + 5 bytes

UnnamedText_565fa: ; 0x565fa
    TX_FAR _UnnamedText_565fa
    db $50
; 0x565fa + 5 bytes

UnnamedText_565ff: ; 0x565ff
    TX_FAR _UnnamedText_565ff
    db $50
; 0x565ff + 5 bytes

UnnamedText_56604: ; 0x56604
    TX_FAR _UnnamedText_56604
    db $50
; 0x56604 + 5 bytes

UnnamedText_56609: ; 0x56609
    TX_FAR _UnnamedText_56609
    db $50
; 0x56609 + 5 bytes

UnnamedText_5660e: ; 0x5660e
    TX_FAR _UnnamedText_5660e
    db $50
; 0x5660e + 5 bytes

SilphCo8Object: ; 0x56613 (size=90)
    db $2e ; border tile

    db $7 ; warps
    db $0, $10, $1, SILPH_CO_9F
    db $0, $e, $0, SILPH_CO_7F
    db $0, $12, $0, SILPH_CO_ELEVATOR
    db $b, $3, $6, SILPH_CO_8F
    db $f, $3, $4, SILPH_CO_2F
    db $5, $b, $5, SILPH_CO_2F
    db $9, $b, $3, SILPH_CO_8F

    db $0 ; signs

    db $4 ; people
    db SPRITE_LAPRAS_GIVER, $2 + 4, $4 + 4, $ff, $ff, $1 ; person
    db SPRITE_ROCKET, $2 + 4, $13 + 4, $ff, $d2, $42, ROCKET + $C8, $23 ; trainer
    db SPRITE_OAK_AIDE, $2 + 4, $a + 4, $ff, $d0, $43, SCIENTIST + $C8, $9 ; trainer
    db SPRITE_ROCKET, $f + 4, $c + 4, $ff, $d3, $44, ROCKET + $C8, $24 ; trainer

    ; warp-to
    EVENT_DISP $d, $0, $10 ; SILPH_CO_9F
    EVENT_DISP $d, $0, $e ; SILPH_CO_7F
    EVENT_DISP $d, $0, $12 ; SILPH_CO_ELEVATOR
    EVENT_DISP $d, $b, $3 ; SILPH_CO_8F
    EVENT_DISP $d, $f, $3 ; SILPH_CO_2F
    EVENT_DISP $d, $5, $b ; SILPH_CO_2F
    EVENT_DISP $d, $9, $b ; SILPH_CO_8F

SilphCo8Blocks: ; 117
    INCBIN "maps/silphco8.blk"

INCBIN "baserom.gbc",$566e2,$191e

SECTION "bank16",DATA,BANK[$16]

Route6_h: ; 0x58000 to 0x58022 (34 bytes) (id=17)
    db $00 ; tileset
    db ROUTE_6_HEIGHT, ROUTE_6_WIDTH ; dimensions (y, x)
    dw Route6Blocks, Route6Texts, Route6Script ; blocks, texts, scripts
    db NORTH | SOUTH ; connections

    ; connections data

	db SAFFRON_CITY
    dw SaffronCityBlocks + (SAFFRON_CITY_HEIGHT - 3) * SAFFRON_CITY_WIDTH + 2 ; connection strip location
    dw $C6EB + -3 ; current map position
    db $10, SAFFRON_CITY_WIDTH ; bigness, width
    db (SAFFRON_CITY_HEIGHT * 2) - 1, (-5 * -2) ; alignments (y, x)
    dw $C6E9 + SAFFRON_CITY_HEIGHT * (SAFFRON_CITY_WIDTH + 6) ; window

	db VERMILION_CITY
    dw VermilionCityBlocks + 2 ; connection strip location
    dw $C6EB + (ROUTE_6_HEIGHT + 3) * (ROUTE_6_WIDTH + 6) + -3 ; current map position
    db $10, VERMILION_CITY_WIDTH ; bigness, width
    db 0, (-5 * -2) ; alignments (y, x)
    dw $C6EF + VERMILION_CITY_WIDTH ; window

    ; end connections data

    dw Route6Object ; objects

Route6Object: ; 0x58022 (size=87)
    db $f ; border tile

    db $4 ; warps
    db $1, $9, $2, ROUTE_6_GATE
    db $1, $a, $2, ROUTE_6_GATE
    db $7, $a, $0, ROUTE_6_GATE
    db $d, $11, $0, PATH_ENTRANCE_ROUTE_6

    db $1 ; signs
    db $f, $13, $7 ; Route6Text7

    db $6 ; people
    db SPRITE_BLACK_HAIR_BOY_1, $15 + 4, $a + 4, $ff, $d3, $41, JR__TRAINER_M + $C8, $4 ; trainer
    db SPRITE_LASS, $15 + 4, $b + 4, $ff, $d2, $42, JR__TRAINER_F + $C8, $2 ; trainer
    db SPRITE_BUG_CATCHER, $f + 4, $0 + 4, $ff, $d3, $43, BUG_CATCHER + $C8, $a ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $1f + 4, $b + 4, $ff, $d2, $44, JR__TRAINER_M + $C8, $5 ; trainer
    db SPRITE_LASS, $1e + 4, $b + 4, $ff, $d2, $45, JR__TRAINER_F + $C8, $3 ; trainer
    db SPRITE_BUG_CATCHER, $1a + 4, $13 + 4, $ff, $d2, $46, BUG_CATCHER + $C8, $b ; trainer

    ; warp-to
    EVENT_DISP $a, $1, $9 ; ROUTE_6_GATE
    EVENT_DISP $a, $1, $a ; ROUTE_6_GATE
    EVENT_DISP $a, $7, $a ; ROUTE_6_GATE
    EVENT_DISP $a, $d, $11 ; PATH_ENTRANCE_ROUTE_6

Route6Blocks: ; 180
    INCBIN "maps/route6.blk"

Route8_h: ; 0x5812d to 0x5814f (34 bytes) (id=19)
    db $00 ; tileset
    db ROUTE_8_HEIGHT, ROUTE_8_WIDTH ; dimensions (y, x)
    dw Route8Blocks, Route8Texts, Route8Script ; blocks, texts, scripts
    db WEST | EAST ; connections

    ; connections data

	db SAFFRON_CITY
    dw SaffronCityBlocks - 3 + (SAFFRON_CITY_WIDTH * 2) ; connection strip location
    dw $C6E8 + (ROUTE_8_WIDTH + 6) * (-3 + 3) ; current map position
    db $f, SAFFRON_CITY_WIDTH ; bigness, width
    db (-4 * -2), (SAFFRON_CITY_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * SAFFRON_CITY_WIDTH ; window

	db LAVENDER_TOWN
    dw LavenderTownBlocks + (LAVENDER_TOWN_WIDTH * 0) ; connection strip location
    dw $C6E5 + (ROUTE_8_WIDTH + 6) * (0 + 4) ; current map position
    db LAVENDER_TOWN_HEIGHT, LAVENDER_TOWN_WIDTH ; bigness, width
    db (0 * -2), 0 ; alignments (y, x)
    dw $C6EF + LAVENDER_TOWN_WIDTH ; window

    ; end connections data

    dw Route8Object ; objects

Route8Object: ; 0x5814f (size=119)
    db $2c ; border tile

    db $5 ; warps
    db $9, $1, $0, ROUTE_8_GATE
    db $a, $1, $1, ROUTE_8_GATE
    db $9, $8, $2, ROUTE_8_GATE
    db $a, $8, $3, ROUTE_8_GATE
    db $3, $d, $0, PATH_ENTRANCE_ROUTE_8

    db $1 ; signs
    db $3, $11, $a ; Route8Text10

    db $9 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $5 + 4, $8 + 4, $ff, $d3, $41, SUPER_NERD + $C8, $3 ; trainer
    db SPRITE_GAMBLER, $9 + 4, $d + 4, $ff, $d1, $42, GAMBLER + $C8, $5 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $6 + 4, $2a + 4, $ff, $d1, $43, SUPER_NERD + $C8, $4 ; trainer
    db SPRITE_LASS, $3 + 4, $1a + 4, $ff, $d2, $44, LASS + $C8, $d ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $4 + 4, $1a + 4, $ff, $d3, $45, SUPER_NERD + $C8, $5 ; trainer
    db SPRITE_LASS, $5 + 4, $1a + 4, $ff, $d2, $46, LASS + $C8, $e ; trainer
    db SPRITE_LASS, $6 + 4, $1a + 4, $ff, $d3, $47, LASS + $C8, $f ; trainer
    db SPRITE_GAMBLER, $d + 4, $2e + 4, $ff, $d0, $48, GAMBLER + $C8, $7 ; trainer
    db SPRITE_LASS, $c + 4, $33 + 4, $ff, $d2, $49, LASS + $C8, $10 ; trainer

    ; warp-to
    EVENT_DISP $1e, $9, $1 ; ROUTE_8_GATE
    EVENT_DISP $1e, $a, $1 ; ROUTE_8_GATE
    EVENT_DISP $1e, $9, $8 ; ROUTE_8_GATE
    EVENT_DISP $1e, $a, $8 ; ROUTE_8_GATE
    EVENT_DISP $1e, $3, $d ; PATH_ENTRANCE_ROUTE_8

Route8Blocks: ; 270
    INCBIN "maps/route8.blk"

Route10_h: ; 0x582d4 to 0x582f6 (34 bytes) (id=21)
    db $00 ; tileset
    db ROUTE_10_HEIGHT, ROUTE_10_WIDTH ; dimensions (y, x)
    dw Route10Blocks, Route10Texts, Route10Script ; blocks, texts, scripts
    db SOUTH | WEST ; connections

    ; connections data

	db LAVENDER_TOWN
    dw LavenderTownBlocks ; connection strip location
    dw $C6EB + (ROUTE_10_HEIGHT + 3) * (ROUTE_10_WIDTH + 6) + 0 ; current map position
    db LAVENDER_TOWN_WIDTH, LAVENDER_TOWN_WIDTH ; bigness, width
    db 0, (0 * -2) ; alignments (y, x)
    dw $C6EF + LAVENDER_TOWN_WIDTH ; window

	db ROUTE_9
    dw Route9Blocks - 3 + (ROUTE_9_WIDTH) ; connection strip location
    dw $C6E8 + (ROUTE_10_WIDTH + 6) * (0 + 3) ; current map position
    db ROUTE_9_HEIGHT, ROUTE_9_WIDTH ; bigness, width
    db (0 * -2), (ROUTE_9_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_9_WIDTH ; window

    ; end connections data

    dw Route10Object ; objects

Route10Object: ; 0x582f6 (size=96)
    db $2c ; border tile

    db $4 ; warps
    db $13, $b, $0, ROCK_TUNNEL_POKECENTER
    db $11, $8, $0, ROCK_TUNNEL_1
    db $35, $8, $2, ROCK_TUNNEL_1
    db $27, $6, $0, POWER_PLANT

    db $4 ; signs
    db $13, $7, $7 ; Route10Text7
    db $13, $c, $8 ; Route10Text8
    db $37, $9, $9 ; Route10Text9
    db $29, $5, $a ; Route10Text10

    db $6 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $2c + 4, $a + 4, $ff, $d2, $41, POKEMANIAC + $C8, $1 ; trainer
    db SPRITE_HIKER, $39 + 4, $3 + 4, $ff, $d1, $42, HIKER + $C8, $7 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $40 + 4, $e + 4, $ff, $d2, $43, POKEMANIAC + $C8, $2 ; trainer
    db SPRITE_LASS, $19 + 4, $7 + 4, $ff, $d2, $44, JR__TRAINER_F + $C8, $7 ; trainer
    db SPRITE_HIKER, $3d + 4, $3 + 4, $ff, $d0, $45, HIKER + $C8, $8 ; trainer
    db SPRITE_LASS, $36 + 4, $7 + 4, $ff, $d0, $46, JR__TRAINER_F + $C8, $8 ; trainer

    ; warp-to
    EVENT_DISP $a, $13, $b ; ROCK_TUNNEL_POKECENTER
    EVENT_DISP $a, $11, $8 ; ROCK_TUNNEL_1
    EVENT_DISP $a, $35, $8 ; ROCK_TUNNEL_1
    EVENT_DISP $a, $27, $6 ; POWER_PLANT

Route10Blocks: ; 360
    INCBIN "maps/route10.blk"

Route11_h: ; 0x584be to 0x584e0 (34 bytes) (id=22)
    db $00 ; tileset
    db ROUTE_11_HEIGHT, ROUTE_11_WIDTH ; dimensions (y, x)
    dw Route11Blocks, Route11Texts, Route11Script ; blocks, texts, scripts
    db WEST | EAST ; connections

    ; connections data

	db VERMILION_CITY
    dw VermilionCityBlocks - 3 + (VERMILION_CITY_WIDTH * 2) ; connection strip location
    dw $C6E8 + (ROUTE_11_WIDTH + 6) * (-3 + 3) ; current map position
    db $f, VERMILION_CITY_WIDTH ; bigness, width
    db (-4 * -2), (VERMILION_CITY_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * VERMILION_CITY_WIDTH ; window

	db ROUTE_12
    dw Route12Blocks + (ROUTE_12_WIDTH * 24) ; connection strip location
    dw $C6E5 + (ROUTE_11_WIDTH + 6) * (-3 + 4) ; current map position
    db $f, ROUTE_12_WIDTH ; bigness, width
    db (-27 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_12_WIDTH ; window

    ; end connections data

    dw Route11Object ; objects

Route11Object: ; 0x584e0 (size=127)
    db $f ; border tile

    db $5 ; warps
    db $8, $31, $0, ROUTE_11_GATE_1F
    db $9, $31, $1, ROUTE_11_GATE_1F
    db $8, $3a, $2, ROUTE_11_GATE_1F
    db $9, $3a, $3, ROUTE_11_GATE_1F
    db $5, $4, $0, DIGLETTS_CAVE_ENTRANCE

    db $1 ; signs
    db $5, $1, $b ; Route11Text11

    db $a ; people
    db SPRITE_GAMBLER, $e + 4, $a + 4, $ff, $d0, $41, GAMBLER + $C8, $1 ; trainer
    db SPRITE_GAMBLER, $9 + 4, $1a + 4, $ff, $d0, $42, GAMBLER + $C8, $2 ; trainer
    db SPRITE_BUG_CATCHER, $5 + 4, $d + 4, $ff, $d2, $43, YOUNGSTER + $C8, $9 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $b + 4, $24 + 4, $ff, $d0, $44, ENGINEER + $C8, $2 ; trainer
    db SPRITE_BUG_CATCHER, $4 + 4, $16 + 4, $ff, $d1, $45, YOUNGSTER + $C8, $a ; trainer
    db SPRITE_GAMBLER, $7 + 4, $2d + 4, $ff, $d0, $46, GAMBLER + $C8, $3 ; trainer
    db SPRITE_GAMBLER, $3 + 4, $21 + 4, $ff, $d1, $47, GAMBLER + $C8, $4 ; trainer
    db SPRITE_BUG_CATCHER, $5 + 4, $2b + 4, $ff, $d3, $48, YOUNGSTER + $C8, $b ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $10 + 4, $2d + 4, $ff, $d2, $49, ENGINEER + $C8, $3 ; trainer
    db SPRITE_BUG_CATCHER, $c + 4, $16 + 4, $ff, $d1, $4a, YOUNGSTER + $C8, $c ; trainer

    ; warp-to
    EVENT_DISP $1e, $8, $31 ; ROUTE_11_GATE_1F
    EVENT_DISP $1e, $9, $31 ; ROUTE_11_GATE_1F
    EVENT_DISP $1e, $8, $3a ; ROUTE_11_GATE_1F
    EVENT_DISP $1e, $9, $3a ; ROUTE_11_GATE_1F
    EVENT_DISP $1e, $5, $4 ; DIGLETTS_CAVE_ENTRANCE

Route11Blocks: ; 270
    INCBIN "maps/route11.blk"

Route12_h: ; 0x5866d to 0x5869a (45 bytes) (id=23)
    db $00 ; tileset
    db ROUTE_12_HEIGHT, ROUTE_12_WIDTH ; dimensions (y, x)
    dw Route12Blocks, Route12Texts, Route12Script ; blocks, texts, scripts
    db NORTH | SOUTH | WEST ; connections

    ; connections data

	db LAVENDER_TOWN
    dw LavenderTownBlocks + (LAVENDER_TOWN_HEIGHT - 3) * LAVENDER_TOWN_WIDTH ; connection strip location
    dw $C6EB + 0 ; current map position
    db LAVENDER_TOWN_WIDTH, LAVENDER_TOWN_WIDTH ; bigness, width
    db (LAVENDER_TOWN_HEIGHT * 2) - 1, (0 * -2) ; alignments (y, x)
    dw $C6E9 + LAVENDER_TOWN_HEIGHT * (LAVENDER_TOWN_WIDTH + 6) ; window

	db ROUTE_13
    dw Route13Blocks + 17 ; connection strip location
    dw $C6EB + (ROUTE_12_HEIGHT + 3) * (ROUTE_12_WIDTH + 6) + -3 ; current map position
    db $d, ROUTE_13_WIDTH ; bigness, width
    db 0, (-20 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_13_WIDTH ; window

	db ROUTE_11
    dw Route11Blocks - 3 + (ROUTE_11_WIDTH) ; connection strip location
    dw $C6E8 + (ROUTE_12_WIDTH + 6) * (27 + 3) ; current map position
    db ROUTE_11_HEIGHT, ROUTE_11_WIDTH ; bigness, width
    db (27 * -2), (ROUTE_11_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * ROUTE_11_WIDTH ; window

    ; end connections data

    dw Route12Object ; objects

Route12Object: ; 0x5869a (size=118)
    db $43 ; border tile

    db $4 ; warps
    db $f, $a, $0, ROUTE_12_GATE
    db $f, $b, $1, ROUTE_12_GATE
    db $15, $a, $2, ROUTE_12_GATE
    db $4d, $b, $0, ROUTE_12_HOUSE

    db $2 ; signs
    db $d, $d, $b ; Route12Text11
    db $3f, $b, $c ; Route12Text12

    db $a ; people
    db SPRITE_SNORLAX, $3e + 4, $a + 4, $ff, $d0, $1 ; person
    db SPRITE_FISHER2, $1f + 4, $e + 4, $ff, $d2, $42, FISHER + $C8, $3 ; trainer
    db SPRITE_FISHER2, $27 + 4, $5 + 4, $ff, $d1, $43, FISHER + $C8, $4 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $5c + 4, $b + 4, $ff, $d2, $44, JR__TRAINER_M + $C8, $9 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $4c + 4, $e + 4, $ff, $d1, $45, ROCKER + $C8, $2 ; trainer
    db SPRITE_FISHER2, $28 + 4, $c + 4, $ff, $d2, $46, FISHER + $C8, $5 ; trainer
    db SPRITE_FISHER2, $34 + 4, $9 + 4, $ff, $d3, $47, FISHER + $C8, $6 ; trainer
    db SPRITE_FISHER2, $57 + 4, $6 + 4, $ff, $d0, $48, FISHER + $C8, $b ; trainer
	db SPRITE_BALL, $23 + 4, $e + 4, $ff, $ff, $89, TM_16 ; item
	db SPRITE_BALL, $59 + 4, $5 + 4, $ff, $ff, $8a, IRON ; item

    ; warp-to
    EVENT_DISP $a, $f, $a ; ROUTE_12_GATE
    EVENT_DISP $a, $f, $b ; ROUTE_12_GATE
    EVENT_DISP $a, $15, $a ; ROUTE_12_GATE
    EVENT_DISP $a, $4d, $b ; ROUTE_12_HOUSE

Route12Blocks: ; 540
    INCBIN "maps/route12.blk"

Route15_h: ; 0x5892c to 0x5894e (34 bytes) (id=26)
    db $00 ; tileset
    db ROUTE_15_HEIGHT, ROUTE_15_WIDTH ; dimensions (y, x)
    dw Route15Blocks, Route15Texts, Route15Script ; blocks, texts, scripts
    db WEST | EAST ; connections

    ; connections data

	db FUCHSIA_CITY
    dw FuchsiaCityBlocks - 3 + (FUCHSIA_CITY_WIDTH * 2) ; connection strip location
    dw $C6E8 + (ROUTE_15_WIDTH + 6) * (-3 + 3) ; current map position
    db $f, FUCHSIA_CITY_WIDTH ; bigness, width
    db (-4 * -2), (FUCHSIA_CITY_WIDTH * 2) - 1 ; alignments (y, x)
    dw $C6EE + 2 * FUCHSIA_CITY_WIDTH ; window

	db ROUTE_14
    dw Route14Blocks + (ROUTE_14_WIDTH * 15) ; connection strip location
    dw $C6E5 + (ROUTE_15_WIDTH + 6) * (-3 + 4) ; current map position
    db $c, ROUTE_14_WIDTH ; bigness, width
    db (-18 * -2), 0 ; alignments (y, x)
    dw $C6EF + ROUTE_14_WIDTH ; window

    ; end connections data

    dw Route15Object ; objects

Route15Object: ; 0x5894e (size=126)
    db $43 ; border tile

    db $4 ; warps
    db $8, $7, $0, ROUTE_15_GATE
    db $9, $7, $1, ROUTE_15_GATE
    db $8, $e, $2, ROUTE_15_GATE
    db $9, $e, $3, ROUTE_15_GATE

    db $1 ; signs
    db $9, $27, $c ; Route15Text12

    db $b ; people
    db SPRITE_LASS, $b + 4, $29 + 4, $ff, $d0, $41, JR__TRAINER_F + $C8, $14 ; trainer
    db SPRITE_LASS, $a + 4, $35 + 4, $ff, $d2, $42, JR__TRAINER_F + $C8, $15 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $d + 4, $1f + 4, $ff, $d1, $43, BIRD_KEEPER + $C8, $6 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $d + 4, $23 + 4, $ff, $d1, $44, BIRD_KEEPER + $C8, $7 ; trainer
    db SPRITE_FOULARD_WOMAN, $b + 4, $35 + 4, $ff, $d0, $45, BEAUTY + $C8, $9 ; trainer
    db SPRITE_FOULARD_WOMAN, $a + 4, $29 + 4, $ff, $d3, $46, BEAUTY + $C8, $a ; trainer
    db SPRITE_BIKER, $a + 4, $30 + 4, $ff, $d0, $47, BIKER + $C8, $3 ; trainer
    db SPRITE_BIKER, $a + 4, $2e + 4, $ff, $d0, $48, BIKER + $C8, $4 ; trainer
    db SPRITE_LASS, $5 + 4, $25 + 4, $ff, $d3, $49, JR__TRAINER_F + $C8, $16 ; trainer
    db SPRITE_LASS, $d + 4, $12 + 4, $ff, $d1, $4a, JR__TRAINER_F + $C8, $17 ; trainer
	db SPRITE_BALL, $5 + 4, $12 + 4, $ff, $ff, $8b, TM_20 ; item

    ; warp-to
    EVENT_DISP $1e, $8, $7 ; ROUTE_15_GATE
    EVENT_DISP $1e, $9, $7 ; ROUTE_15_GATE
    EVENT_DISP $1e, $8, $e ; ROUTE_15_GATE
    EVENT_DISP $1e, $9, $e ; ROUTE_15_GATE

Route15Blocks: ; 270
    INCBIN "maps/route15.blk"

Route16_h: ; 0x58ada to 0x58afc (34 bytes) (id=27)
    db $00 ; tileset
    db ROUTE_16_HEIGHT, ROUTE_16_WIDTH ; dimensions (y, x)
    dw Route16Blocks, Route16Texts, Route16Script ; blocks, texts, scripts
    db SOUTH | EAST ; connections

    ; connections data

	db ROUTE_17
    dw Route17Blocks ; connection strip location
    dw $C6EB + (ROUTE_16_HEIGHT + 3) * (ROUTE_16_WIDTH + 6) + 0 ; current map position
    db ROUTE_17_WIDTH, ROUTE_17_WIDTH ; bigness, width
    db 0, (0 * -2) ; alignments (y, x)
    dw $C6EF + ROUTE_17_WIDTH ; window

	db CELADON_CITY
    dw CeladonCityBlocks + (CELADON_CITY_WIDTH) ; connection strip location
    dw $C6E5 + (ROUTE_16_WIDTH + 6) * (-3 + 4) ; current map position
    db $f, CELADON_CITY_WIDTH ; bigness, width
    db (-4 * -2), 0 ; alignments (y, x)
    dw $C6EF + CELADON_CITY_WIDTH ; window

    ; end connections data

    dw Route16Object ; objects

Route16Object: ; 0x58afc (size=136)
    db $f ; border tile

    db $9 ; warps
    db $a, $11, $0, ROUTE_16_GATE_1F
    db $b, $11, $1, ROUTE_16_GATE_1F
    db $a, $18, $2, ROUTE_16_GATE_1F
    db $b, $18, $3, ROUTE_16_GATE_1F
    db $4, $11, $4, ROUTE_16_GATE_1F
    db $5, $11, $5, ROUTE_16_GATE_1F
    db $4, $18, $6, ROUTE_16_GATE_1F
    db $5, $18, $7, ROUTE_16_GATE_1F
    db $5, $7, $0, ROUTE_16_HOUSE

    db $2 ; signs
    db $b, $1b, $8 ; Route16Text8
    db $11, $5, $9 ; Route16Text9

    db $7 ; people
    db SPRITE_BIKER, $c + 4, $11 + 4, $ff, $d2, $41, BIKER + $C8, $5 ; trainer
    db SPRITE_BIKER, $d + 4, $e + 4, $ff, $d3, $42, CUE_BALL + $C8, $1 ; trainer
    db SPRITE_BIKER, $c + 4, $b + 4, $ff, $d1, $43, CUE_BALL + $C8, $2 ; trainer
    db SPRITE_BIKER, $b + 4, $9 + 4, $ff, $d2, $44, BIKER + $C8, $6 ; trainer
    db SPRITE_BIKER, $a + 4, $6 + 4, $ff, $d3, $45, CUE_BALL + $C8, $3 ; trainer
    db SPRITE_BIKER, $c + 4, $3 + 4, $ff, $d3, $46, BIKER + $C8, $7 ; trainer
    db SPRITE_SNORLAX, $a + 4, $1a + 4, $ff, $d0, $7 ; person

    ; warp-to
    EVENT_DISP $14, $a, $11 ; ROUTE_16_GATE_1F
    EVENT_DISP $14, $b, $11 ; ROUTE_16_GATE_1F
    EVENT_DISP $14, $a, $18 ; ROUTE_16_GATE_1F
    EVENT_DISP $14, $b, $18 ; ROUTE_16_GATE_1F
    EVENT_DISP $14, $4, $11 ; ROUTE_16_GATE_1F
    EVENT_DISP $14, $5, $11 ; ROUTE_16_GATE_1F
    EVENT_DISP $14, $4, $18 ; ROUTE_16_GATE_1F
    EVENT_DISP $14, $5, $18 ; ROUTE_16_GATE_1F
    EVENT_DISP $14, $5, $7 ; ROUTE_16_HOUSE

Route16Blocks: ; 180
    INCBIN "maps/route16.blk"

Route18_h: ; 0x58c38 to 0x58c5a (34 bytes) (id=29)
    db $00 ; tileset
    db ROUTE_18_HEIGHT, ROUTE_18_WIDTH ; dimensions (y, x)
    dw Route18Blocks, Route18Texts, Route18Script ; blocks, texts, scripts
    db NORTH | EAST ; connections

    ; connections data

	db ROUTE_17
    dw Route17Blocks + (ROUTE_17_HEIGHT - 3) * ROUTE_17_WIDTH ; connection strip location
    dw $C6EB + 0 ; current map position
    db ROUTE_17_WIDTH, ROUTE_17_WIDTH ; bigness, width
    db (ROUTE_17_HEIGHT * 2) - 1, (0 * -2) ; alignments (y, x)
    dw $C6E9 + ROUTE_17_HEIGHT * (ROUTE_17_WIDTH + 6) ; window

	db FUCHSIA_CITY
    dw FuchsiaCityBlocks + (FUCHSIA_CITY_WIDTH) ; connection strip location
    dw $C6E5 + (ROUTE_18_WIDTH + 6) * (-3 + 4) ; current map position
    db $f, FUCHSIA_CITY_WIDTH ; bigness, width
    db (-4 * -2), 0 ; alignments (y, x)
    dw $C6EF + FUCHSIA_CITY_WIDTH ; window

    ; end connections data

    dw Route18Object ; objects

Route18Object: ; 0x58c5a (size=66)
    db $43 ; border tile

    db $4 ; warps
    db $8, $21, $0, ROUTE_18_GATE_1F
    db $9, $21, $1, ROUTE_18_GATE_1F
    db $8, $28, $2, ROUTE_18_GATE_1F
    db $9, $28, $3, ROUTE_18_GATE_1F

    db $2 ; signs
    db $7, $2b, $4 ; Route18Text4
    db $5, $21, $5 ; Route18Text5

    db $3 ; people
    db SPRITE_BLACK_HAIR_BOY_1, $b + 4, $24 + 4, $ff, $d3, $41, BIRD_KEEPER + $C8, $8 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $f + 4, $28 + 4, $ff, $d2, $42, BIRD_KEEPER + $C8, $9 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $d + 4, $2a + 4, $ff, $d2, $43, BIRD_KEEPER + $C8, $a ; trainer

    ; warp-to
    EVENT_DISP $19, $8, $21 ; ROUTE_18_GATE_1F
    EVENT_DISP $19, $9, $21 ; ROUTE_18_GATE_1F
    EVENT_DISP $19, $8, $28 ; ROUTE_18_GATE_1F
    EVENT_DISP $19, $9, $28 ; ROUTE_18_GATE_1F

Route18Blocks: ; 225
    INCBIN "maps/route18.blk"

INCBIN "baserom.gbc",$58d7d,$58e3b - $58d7d

UnnamedText_58e3b: ; 0x58e3b
    TX_FAR _UnnamedText_58e3b
    db $50
; 0x58e3b + 5 bytes

UnnamedText_58e40: ; 0x58e40
    TX_FAR _UnnamedText_58e40
    db $50
; 0x58e40 + 5 bytes

UnnamedText_58e45: ; 0x58e45
    TX_FAR _UnnamedText_58e45
    db $50
; 0x58e45 + 5 bytes

UnnamedText_58e4a: ; 0x58e4a
    TX_FAR _UnnamedText_58e4a
    db $50
; 0x58e4a + 5 bytes

UnnamedText_58e4f: ; 0x58e4f
    TX_FAR _UnnamedText_58e4f
    db $50
; 0x58e4f + 5 bytes

UnnamedText_58e54: ; 0x58e54
    TX_FAR _UnnamedText_58e54
    db $50
; 0x58e54 + 5 bytes

INCBIN "baserom.gbc",$58e59,$58ecc - $58e59

UnnamedText_58ecc: ; 0x58ecc
    TX_FAR _UnnamedText_58ecc
    db $50
; 0x58ecc + 5 bytes

INCBIN "baserom.gbc",$58ed1,$58f3e - $58ed1

UnnamedText_58f3e: ; 0x58f3e
    TX_FAR _UnnamedText_58f3e
    db $50
; 0x58f3e + 5 bytes

INCBIN "baserom.gbc",$58f43,$59091 - $58f43

UnnamedText_59091: ; 0x59091
    TX_FAR _UnnamedText_59091
    db $50
; 0x59091 + 5 bytes

UnnamedText_59096: ; 0x59096
    TX_FAR _UnnamedText_59096
    db $50
; 0x59096 + 5 bytes

UnnamedText_5909b: ; 0x5909b
    TX_FAR _UnnamedText_5909b
    db $50
; 0x5909b + 5 bytes

UnnamedText_590a0: ; 0x590a0
    TX_FAR _UnnamedText_590a0
    db $50
; 0x590a0 + 5 bytes

INCBIN "baserom.gbc",$590a5,$590ab - $590a5

UnnamedText_590ab: ; 0x590ab
    TX_FAR _UnnamedText_590ab
    db $50
; 0x590ab + 5 bytes

Route6Script: ; 0x590b0
    call $3c3c
    ld hl, $50d7
    ld de, $50c3
    ld a, [$d600]
    call $3160
    ld [$d600], a
    ret
; 0x590c3

INCBIN "baserom.gbc",$590c3,$590c9 - $590c3

Route6Texts:

INCBIN "baserom.gbc",$590c9,$59120 - $590c9

Route6Text1: ; 0x59120
    db $8
    ld hl, $50d7
    call $31cc
    jp $24d7
; 0x5912a

UnnamedText_5912a: ; 0x5912a
    TX_FAR _UnnamedText_5912a
    db $50
; 0x5912a + 5 bytes

UnnamedText_5912f: ; 0x5912f
    TX_FAR _UnnamedText_5912f
    db $50
; 0x5912f + 5 bytes

UnnamedText_59134: ; 0x59134
    TX_FAR _UnnamedText_59134
    db $50
; 0x59134 + 5 bytes

Route6Text2: ; 0x59139
    db $08 ; asm
    ld hl, $50e3
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59143: ; 0x59143
    TX_FAR _UnnamedText_59143
    db $50
; 0x59143 + 5 bytes

UnnamedText_59148: ; 0x59148
    TX_FAR _UnnamedText_59148
    db $50
; 0x59148 + 5 bytes

Route6Text3: ; 0x5914d
    db $08 ; asm
    ld hl, $50ef
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59157: ; 0x59157
    TX_FAR _UnnamedText_59157
    db $50
; 0x59157 + 5 bytes

UnnamedText_5915c: ; 0x5915c
    TX_FAR _UnnamedText_5915c
    db $50
; 0x5915c + 5 bytes

UnnamedText_59161: ; 0x59161
    TX_FAR _UnnamedText_59161
    db $50
; 0x59161 + 5 bytes

Route6Text4: ; 0x59166
    db $08 ; asm
    ld hl, $50fb
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59170: ; 0x59170
    TX_FAR _UnnamedText_59170
    db $50
; 0x59170 + 5 bytes

UnnamedText_59175: ; 0x59175
    TX_FAR _UnnamedText_59175
    db $50
; 0x59175 + 5 bytes

UnnamedText_5917a: ; 0x5917a
    TX_FAR _UnnamedText_5917a
    db $50
; 0x5917a + 5 bytes

Route6Text5: ; 0x5917f
    db $08 ; asm
    ld hl, $5107
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59189: ; 0x59189
    TX_FAR _UnnamedText_59189
    db $50
; 0x59189 + 5 bytes

UnnamedText_5918e: ; 0x5918e
    TX_FAR _UnnamedText_5918e
    db $50
; 0x5918e + 5 bytes

UnnamedText_59193: ; 0x59193
    TX_FAR _UnnamedText_59193
    db $50
; 0x59193 + 5 bytes

Route6Text6: ; 0x59198
    db $08 ; asm
    ld hl, $5113
    call LoadTrainerHeader
    jp $24d7

UnnamedText_591a2: ; 0x591a2
    TX_FAR _UnnamedText_591a2
    db $50
; 0x591a2 + 5 bytes

UnnamedText_591a7: ; 0x591a7
    TX_FAR _UnnamedText_591a7
    db $50
; 0x591a7 + 5 bytes

UnnamedText_591ac: ; 0x591ac
    TX_FAR _UnnamedText_591ac
    db $50
; 0x591ac + 5 bytes

Route6Text7: ; 0x591b1
    TX_FAR _Route6Text7
    db $50

Route8Script: ; 0x591b6
    call $3c3c
    ld hl, $51e3
    ld de, $51c9
    ld a, [$d601]
    call $3160
    ld [$d601], a
    ret
; 0x591c9

INCBIN "baserom.gbc",$591c9,$591cf - $591c9

Route8Texts: ; 0x591cf

INCBIN "baserom.gbc",$591cf,$5925a - $591cf

UnnamedText_5925a: ; 0x5925a
    TX_FAR _UnnamedText_5925a
    db $50
; 0x5925a + 5 bytes

UnnamedText_5925f: ; 0x5925f
    TX_FAR _UnnamedText_5925f
    db $50
; 0x5925f + 5 bytes

UnnamedText_59264: ; 0x59264
    TX_FAR _UnnamedText_59264
    db $50
; 0x59264 + 5 bytes

Route8Text2: ; 0x59269
    db $08 ; asm
    ld hl, $51ef
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59273: ; 0x59273
    TX_FAR _UnnamedText_59273
    db $50
; 0x59273 + 5 bytes

UnnamedText_59278: ; 0x59278
    TX_FAR _UnnamedText_59278
    db $50
; 0x59278 + 5 bytes

UnnamedText_5927d: ; 0x5927d
    TX_FAR _UnnamedText_5927d
    db $50
; 0x5927d + 5 bytes

Route8Text3: ; 0x59282
    db $08 ; asm
    ld hl, $51fb
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5928c: ; 0x5928c
    TX_FAR _UnnamedText_5928c
    db $50
; 0x5928c + 5 bytes

UnnamedText_59291: ; 0x59291
    TX_FAR _UnnamedText_59291
    db $50
; 0x59291 + 5 bytes

UnnamedText_59296: ; 0x59296
    TX_FAR _UnnamedText_59296
    db $50
; 0x59296 + 5 bytes

Route8Text4: ; 0x5929b
    db $08 ; asm
    ld hl, $5207
    call LoadTrainerHeader
    jp $24d7

UnnamedText_592a5: ; 0x592a5
    TX_FAR _UnnamedText_592a5
    db $50
; 0x592a5 + 5 bytes

UnnamedText_592aa: ; 0x592aa
    TX_FAR _UnnamedText_592aa
    db $50
; 0x592aa + 5 bytes

UnnamedText_592af: ; 0x592af
    TX_FAR _UnnamedText_592af
    db $50
; 0x592af + 5 bytes

Route8Text5: ; 0x592b4
    db $08 ; asm
    ld hl, $5213
    call LoadTrainerHeader
    jp $24d7

UnnamedText_592be: ; 0x592be
    TX_FAR _UnnamedText_592be
    db $50
; 0x592be + 5 bytes

UnnamedText_592c3: ; 0x592c3
    TX_FAR _UnnamedText_592c3
    db $50
; 0x592c3 + 5 bytes

UnnamedText_592c8: ; 0x592c8
    TX_FAR _UnnamedText_592c8
    db $50
; 0x592c8 + 5 bytes

Route8Text6: ; 0x592cd
    db $08 ; asm
    ld hl, $521f
    call LoadTrainerHeader
    jp $24d7

UnnamedText_592d7: ; 0x592d7
    TX_FAR _UnnamedText_592d7
    db $50
; 0x592d7 + 5 bytes

UnnamedText_592dc: ; 0x592dc
    TX_FAR _UnnamedText_592dc
    db $50
; 0x592dc + 5 bytes

UnnamedText_592e1: ; 0x592e1
    TX_FAR _UnnamedText_592e1
    db $50
; 0x592e1 + 5 bytes

Route8Text7: ; 0x592e6
    db $08 ; asm
    ld hl, $522b
    call LoadTrainerHeader
    jp $24d7

UnnamedText_592f0: ; 0x592f0
    TX_FAR _UnnamedText_592f0
    db $50
; 0x592f0 + 5 bytes

UnnamedText_592f5: ; 0x592f5
    TX_FAR _UnnamedText_592f5
    db $50
; 0x592f5 + 5 bytes

UnnamedText_592fa: ; 0x592fa
    TX_FAR _UnnamedText_592fa
    db $50
; 0x592fa + 5 bytes

Route8Text8: ; 0x592ff
    db $08 ; asm
    ld hl, $5237
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59309: ; 0x59309
    TX_FAR _UnnamedText_59309
    db $50
; 0x59309 + 5 bytes

UnnamedText_5930e: ; 0x5930e
    TX_FAR _UnnamedText_5930e
    db $50
; 0x5930e + 5 bytes

UnnamedText_59313: ; 0x59313
    TX_FAR _UnnamedText_59313
    db $50
; 0x59313 + 5 bytes

Route8Text9: ; 0x59318
    db $08 ; asm
    ld hl, $5243
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59322: ; 0x59322
    TX_FAR _UnnamedText_59322
    db $50
; 0x59322 + 5 bytes

UnnamedText_59327: ; 0x59327
    TX_FAR _UnnamedText_59327
    db $50
; 0x59327 + 5 bytes

UnnamedText_5932c: ; 0x5932c
    TX_FAR _UnnamedText_5932c
    db $50
; 0x5932c + 5 bytes

Route8Text10: ; 0x59331
    TX_FAR _Route8Text10
    db $50

Route10Script: ; 0x59336
    call $3c3c
    ld hl, $5363
    ld de, $5349
    ld a, [$d605]
    call $3160
    ld [$d605], a
    ret
; 0x59349

INCBIN "baserom.gbc",$59349,$6

Route10Texts: ; 0x5934f
    dw Route10Text1, Route10Text2, Route10Text3, Route10Text4, Route10Text5, Route10Text6, Route10Text7, Route10Text8, Route10Text9, Route10Text10

INCBIN "baserom.gbc",$59363,$49

Route10Text1: ; 0x593ac
    db $08 ; asm
    ld hl, $5363
    call LoadTrainerHeader
    jp $24d7

UnnamedText_593b6: ; 0x593b6
    TX_FAR _UnnamedText_593b6
    db $50
; 0x593b6 + 5 bytes

UnnamedText_593bb: ; 0x593bb
    TX_FAR _UnnamedText_593bb
    db $50
; 0x593bb + 5 bytes

UnnamedText_593c0: ; 0x593c0
    TX_FAR _UnnamedText_593c0
    db $50
; 0x593c0 + 5 bytes

Route10Text2: ; 0x593c5
    db $08 ; asm
    ld hl, $536f
    call LoadTrainerHeader
    jp $24d7

UnnamedText_593cf: ; 0x593cf
    TX_FAR _UnnamedText_593cf
    db $50
; 0x593cf + 5 bytes

UnnamedText_593d4: ; 0x593d4
    TX_FAR _UnnamedText_593d4
    db $50
; 0x593d4 + 5 bytes

UnnamedText_593d9: ; 0x593d9
    TX_FAR _UnnamedText_593d9
    db $50
; 0x593d9 + 5 bytes

Route10Text3: ; 0x593de
    db $08 ; asm
    ld hl, $537b
    call LoadTrainerHeader
    jp $24d7

UnnamedText_593e8: ; 0x593e8
    TX_FAR _UnnamedText_593e8
    db $50
; 0x593e8 + 5 bytes

UnnamedText_593ed: ; 0x593ed
    TX_FAR _UnnamedText_593ed
    db $50
; 0x593ed + 5 bytes

UnnamedText_593f2: ; 0x593f2
    TX_FAR _UnnamedText_593f2
    db $50
; 0x593f2 + 5 bytes

Route10Text4: ; 0x593f7
    db $08 ; asm
    ld hl, $5387
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59401: ; 0x59401
    TX_FAR _UnnamedText_59401
    db $50
; 0x59401 + 5 bytes

UnnamedText_59406: ; 0x59406
    TX_FAR _UnnamedText_59406
    db $50
; 0x59406 + 5 bytes

UnnamedText_5940b: ; 0x5940b
    TX_FAR _UnnamedText_5940b
    db $50
; 0x5940b + 5 bytes

Route10Text5: ; 0x59410
    db $08 ; asm
    ld hl, $5393
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5941a: ; 0x5941a
    TX_FAR _UnnamedText_5941a
    db $50
; 0x5941a + 5 bytes

UnnamedText_5941f: ; 0x5941f
    TX_FAR _UnnamedText_5941f
    db $50
; 0x5941f + 5 bytes

UnnamedText_59424: ; 0x59424
    TX_FAR _UnnamedText_59424
    db $50
; 0x59424 + 5 bytes

Route10Text6: ; 0x59429
    db $08 ; asm
    ld hl, $539f
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59433: ; 0x59433
    TX_FAR _UnnamedText_59433
    db $50
; 0x59433 + 5 bytes

UnnamedText_59438: ; 0x59438
    TX_FAR _UnnamedText_59438
    db $50
; 0x59438 + 5 bytes

UnnamedText_5943d: ; 0x5943d
    TX_FAR _UnnamedText_5943d
    db $50
; 0x5943d + 5 bytes

Route10Text9: ; 0x59442
Route10Text7: ; 0x59442
    TX_FAR _Route10Text7 ; _Route10Text9
    db $50

Route10Text10: ; 0x59447
    TX_FAR _Route10Text10
    db $50

Route11Script: ; 0x5944c
    call $3c3c
    ld hl, $547b
    ld de, $545f
    ld a, [$d623]
    call $3160
    ld [$d623], a
    ret
; 0x5945f

INCBIN "baserom.gbc",$5945f,$59465 - $5945f

Route11Texts: ; 0x59465

INCBIN "baserom.gbc",$59465,$594fe - $59465

UnnamedText_594fe: ; 0x594fe
    TX_FAR _UnnamedText_594fe
    db $50
; 0x594fe + 5 bytes

UnnamedText_59503: ; 0x59503
    TX_FAR _UnnamedText_59503
    db $50
; 0x59503 + 5 bytes

UnnamedText_59508: ; 0x59508
    TX_FAR _UnnamedText_59508
    db $50
; 0x59508 + 5 bytes

Route11Text2: ; 0x5950d
    db $08 ; asm
    ld hl, $5487
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59517: ; 0x59517
    TX_FAR _UnnamedText_59517
    db $50
; 0x59517 + 5 bytes

UnnamedText_5951c: ; 0x5951c
    TX_FAR _UnnamedText_5951c
    db $50
; 0x5951c + 5 bytes

UnnamedText_59521: ; 0x59521
    TX_FAR _UnnamedText_59521
    db $50
; 0x59521 + 5 bytes

Route11Text3: ; 0x59526
    db $08 ; asm
    ld hl, $5493
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59530: ; 0x59530
    TX_FAR _UnnamedText_59530
    db $50
; 0x59530 + 5 bytes

UnnamedText_59535: ; 0x59535
    TX_FAR _UnnamedText_59535
    db $50
; 0x59535 + 5 bytes

UnnamedText_5953a: ; 0x5953a
    TX_FAR _UnnamedText_5953a
    db $50
; 0x5953a + 5 bytes

Route11Text4: ; 0x5953f
    db $08 ; asm
    ld hl, $549f
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59549: ; 0x59549
    TX_FAR _UnnamedText_59549
    db $50
; 0x59549 + 5 bytes

UnnamedText_5954e: ; 0x5954e
    TX_FAR _UnnamedText_5954e
    db $50
; 0x5954e + 5 bytes

UnnamedText_59553: ; 0x59553
    TX_FAR _UnnamedText_59553
    db $50
; 0x59553 + 5 bytes

Route11Text5: ; 0x59558
    db $08 ; asm
    ld hl, $54ab
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59562: ; 0x59562
    TX_FAR _UnnamedText_59562
    db $50
; 0x59562 + 5 bytes

UnnamedText_59567: ; 0x59567
    TX_FAR _UnnamedText_59567
    db $50
; 0x59567 + 5 bytes

UnnamedText_5956c: ; 0x5956c
    TX_FAR _UnnamedText_5956c
    db $50
; 0x5956c + 5 bytes

Route11Text6: ; 0x59571
    db $08 ; asm
    ld hl, $54b7
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5957b: ; 0x5957b
    TX_FAR _UnnamedText_5957b
    db $50
; 0x5957b + 5 bytes

UnnamedText_59580: ; 0x59580
    TX_FAR _UnnamedText_59580
    db $50
; 0x59580 + 5 bytes

UnnamedText_59585: ; 0x59585
    TX_FAR _UnnamedText_59585
    db $50
; 0x59585 + 5 bytes

Route11Text7: ; 0x5958a
    db $08 ; asm
    ld hl, $54c3
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59594: ; 0x59594
    TX_FAR _UnnamedText_59594
    db $50
; 0x59594 + 5 bytes

UnnamedText_59599: ; 0x59599
    TX_FAR _UnnamedText_59599
    db $50
; 0x59599 + 5 bytes

UnnamedText_5959e: ; 0x5959e
    TX_FAR _UnnamedText_5959e
    db $50
; 0x5959e + 5 bytes

Route11Text8: ; 0x595a3
    db $08 ; asm
    ld hl, $54cf
    call LoadTrainerHeader
    jp $24d7

UnnamedText_595ad: ; 0x595ad
    TX_FAR _UnnamedText_595ad
    db $50
; 0x595ad + 5 bytes

UnnamedText_595b2: ; 0x595b2
    TX_FAR _UnnamedText_595b2
    db $50
; 0x595b2 + 5 bytes

UnnamedText_595b7: ; 0x595b7
    TX_FAR _UnnamedText_595b7
    db $50
; 0x595b7 + 5 bytes

Route11Text9: ; 0x595bc
    db $08 ; asm
    ld hl, $54db
    call LoadTrainerHeader
    jp $24d7

UnnamedText_595c6: ; 0x595c6
    TX_FAR _UnnamedText_595c6
    db $50
; 0x595c6 + 5 bytes

UnnamedText_595cb: ; 0x595cb
    TX_FAR _UnnamedText_595cb
    db $50
; 0x595cb + 5 bytes

UnnamedText_595d0: ; 0x595d0
    TX_FAR _UnnamedText_595d0
    db $50
; 0x595d0 + 5 bytes

Route11Text10: ; 0x595d5
    db $08 ; asm
    ld hl, $54e7
    call LoadTrainerHeader
    jp $24d7

UnnamedText_595df: ; 0x595df
    TX_FAR _UnnamedText_595df
    db $50
; 0x595df + 5 bytes

UnnamedText_595e4: ; 0x595e4
    TX_FAR _UnnamedText_595e4
    db $50
; 0x595e4 + 5 bytes

UnnamedText_595e9: ; 0x595e9
    TX_FAR _UnnamedText_595e9
    db $50
; 0x595e9 + 5 bytes

Route11Text11: ; 0x595ee
    TX_FAR _Route11Text11
    db $50

Route12Script: ; 0x595f3
    call $3c3c
    ld hl, $5691
    ld de, $5611
    ld a, [$d624]
    call $3160
    ld [$d624], a
    ret
; 0x59606

INCBIN "baserom.gbc",$59606,$6f

Route12Texts: ; 0x59675
    dw Route12Text1, Route12Text2, Route12Text3, Route12Text4, Route12Text5, Route12Text6, Route12Text7, Route12Text8, Route12Text9, Route12Text10, Route12Text11, Route12Text12, Route12Text13, Route12Text14

INCBIN "baserom.gbc",$59691,$55

Route12Text1: ; 0x596e6
    TX_FAR _Route12Text1
    db $50

UnnamedText_596eb: ; 0x596eb
    TX_FAR _UnnamedText_596eb
    db $50
; 0x596eb + 5 bytes

UnnamedText_596f0: ; 0x596f0
    TX_FAR _UnnamedText_596f0
    db $50
; 0x596f0 + 5 bytes

Route12Text2: ; 0x596f5
    db $08 ; asm
    ld hl, $5691
    call LoadTrainerHeader
    jp $24d7

UnnamedText_596ff: ; 0x596ff
    TX_FAR _UnnamedText_596ff
    db $50
; 0x596ff + 5 bytes

UnnamedText_59704: ; 0x59704
    TX_FAR _UnnamedText_59704
    db $50
; 0x59704 + 5 bytes

UnnamedText_59709: ; 0x59709
    TX_FAR _UnnamedText_59709
    db $50
; 0x59709 + 5 bytes

Route12Text3: ; 0x5970e
    db $08 ; asm
    ld hl, $569d
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59718: ; 0x59718
    TX_FAR _UnnamedText_59718
    db $50
; 0x59718 + 5 bytes

UnnamedText_5971d: ; 0x5971d
    TX_FAR _UnnamedText_5971d
    db $50
; 0x5971d + 5 bytes

UnnamedText_59722: ; 0x59722
    TX_FAR _UnnamedText_59722
    db $50
; 0x59722 + 5 bytes

Route12Text4: ; 0x59727
    db $08 ; asm
    ld hl, $56a9
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59731: ; 0x59731
    TX_FAR _UnnamedText_59731
    db $50
; 0x59731 + 5 bytes

UnnamedText_59736: ; 0x59736
    TX_FAR _UnnamedText_59736
    db $50
; 0x59736 + 5 bytes

UnnamedText_5973b: ; 0x5973b
    TX_FAR _UnnamedText_5973b
    db $50
; 0x5973b + 5 bytes

Route12Text5: ; 0x59740
    db $08 ; asm
    ld hl, $56b5
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5974a: ; 0x5974a
    TX_FAR _UnnamedText_5974a
    db $50
; 0x5974a + 5 bytes

UnnamedText_5974f: ; 0x5974f
    TX_FAR _UnnamedText_5974f
    db $50
; 0x5974f + 5 bytes

UnnamedText_59754: ; 0x59754
    TX_FAR _UnnamedText_59754
    db $50
; 0x59754 + 5 bytes

Route12Text6: ; 0x59759
    db $08 ; asm
    ld hl, $56c1
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59763: ; 0x59763
    TX_FAR _UnnamedText_59763
    db $50
; 0x59763 + 5 bytes

UnnamedText_59768: ; 0x59768
    TX_FAR _UnnamedText_59768
    db $50
; 0x59768 + 5 bytes

UnnamedText_5976d: ; 0x5976d
    TX_FAR _UnnamedText_5976d
    db $50
; 0x5976d + 5 bytes

Route12Text7: ; 0x59772
    db $08 ; asm
    ld hl, $56cd
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5977c: ; 0x5977c
    TX_FAR _UnnamedText_5977c
    db $50
; 0x5977c + 5 bytes

UnnamedText_59781: ; 0x59781
    TX_FAR _UnnamedText_59781
    db $50
; 0x59781 + 5 bytes

UnnamedText_59786: ; 0x59786
    TX_FAR _UnnamedText_59786
    db $50
; 0x59786 + 5 bytes

Route12Text8: ; 0x5978b
    db $08 ; asm
    ld hl, $56d9
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59795: ; 0x59795
    TX_FAR _UnnamedText_59795
    db $50
; 0x59795 + 5 bytes

UnnamedText_5979a: ; 0x5979a
    TX_FAR _UnnamedText_5979a
    db $50
; 0x5979a + 5 bytes

UnnamedText_5979f: ; 0x5979f
    TX_FAR _UnnamedText_5979f
    db $50
; 0x5979f + 5 bytes

Route12Text11: ; 0x597a4
    TX_FAR _Route12Text11
    db $50

Route12Text12: ; 0x597a9
    TX_FAR _Route12Text12
    db $50

Route15Script: ; 0x597ae
    call $3c3c
    ld hl, $57df
    ld de, $57c1
    ld a, [$d625]
    call $3160
    ld [$d625], a
    ret
; 0x597c1

INCBIN "baserom.gbc",$597c1,$6

Route15Texts: ; 0x597c7
    dw Route15Text1, Route15Text2, Route15Text3, Route15Text4, Route15Text5, Route15Text6, Route15Text7, Route15Text8, Route15Text9, Route15Text10, Route15Text11, Route15Text12

INCBIN "baserom.gbc",$597df,$79

Route15Text1: ; 0x59858
    db $8 ; asm
    ld hl, $57df
    jr asm_33cb7 ; 0x5985c $34

Route15Text2:
    db $8 ; asm
    ld hl, $57eb
    jr asm_33cb7 ; 0x59862 $2e

Route15Text3:
    db $8 ; asm
    ld hl, $57f7
    jr asm_33cb7 ; 0x59868 $28

Route15Text4:
    db $8 ; asm
    ld hl, $5803
    jr asm_33cb7 ; 0x5986e $22

Route15Text5:
    db $8 ; asm
    ld hl, $580f
    jr asm_33cb7 ; 0x59874 $1c

Route15Text6:
    db $8 ; asm
    ld hl, $581b
    jr asm_33cb7 ; 0x5987a $16

Route15Text7:
    db $8 ; asm
    ld hl, $5827
    jr asm_33cb7 ; 0x59880 $10

Route15Text8:
    db $8 ; asm
    ld hl, $5833
    jr asm_33cb7 ; 0x59886 $a

Route15Text9:
    db $8 ; asm
    ld hl, $583f
    jr asm_33cb7 ; 0x5988c $4

Route15Text10:
    db $8 ; asm
    ld hl, $584b
asm_33cb7: ; 0x59892
    call $31cc
    jp $24d7
; 0x59898

UnnamedText_59898: ; 0x59898
    TX_FAR _UnnamedText_59898
    db $50
; 0x59898 + 5 bytes

UnnamedText_5989d: ; 0x5989d
    TX_FAR _UnnamedText_5989d
    db $50
; 0x5989d + 5 bytes

UnnamedText_598a2: ; 0x598a2
    TX_FAR _UnnamedText_598a2
    db $50
; 0x598a2 + 5 bytes

UnnamedText_598a7: ; 0x598a7
    TX_FAR _UnnamedText_598a7
    db $50
; 0x598a7 + 5 bytes

UnnamedText_598ac: ; 0x598ac
    TX_FAR _UnnamedText_598ac
    db $50
; 0x598ac + 5 bytes

UnnamedText_598b1: ; 0x598b1
    TX_FAR _UnnamedText_598b1
    db $50
; 0x598b1 + 5 bytes

UnnamedText_598b6: ; 0x598b6
    TX_FAR _UnnamedText_598b6
    db $50
; 0x598b6 + 5 bytes

UnnamedText_598bb: ; 0x598bb
    TX_FAR _UnnamedText_598bb
    db $50
; 0x598bb + 5 bytes

UnnamedText_598c0: ; 0x598c0
    TX_FAR _UnnamedText_598c0
    db $50
; 0x598c0 + 5 bytes

UnnamedText_598c5: ; 0x598c5
    TX_FAR _UnnamedText_598c5
    db $50
; 0x598c5 + 5 bytes

UnnamedText_598ca: ; 0x598ca
    TX_FAR _UnnamedText_598ca
    db $50
; 0x598ca + 5 bytes

UnnamedText_598cf: ; 0x598cf
    TX_FAR _UnnamedText_598cf
    db $50
; 0x598cf + 5 bytes

UnnamedText_598d4: ; 0x598d4
    TX_FAR _UnnamedText_598d4
    db $50
; 0x598d4 + 5 bytes

UnnamedText_598d9: ; 0x598d9
    TX_FAR _UnnamedText_598d9
    db $50
; 0x598d9 + 5 bytes

UnnamedText_598de: ; 0x598de
    TX_FAR _UnnamedText_598de
    db $50
; 0x598de + 5 bytes

UnnamedText_598e3: ; 0x598e3
    TX_FAR _UnnamedText_598e3
    db $50
; 0x598e3 + 5 bytes

UnnamedText_598e8: ; 0x598e8
    TX_FAR _UnnamedText_598e8
    db $50
; 0x598e8 + 5 bytes

UnnamedText_598ed: ; 0x598ed
    TX_FAR _UnnamedText_598ed
    db $50
; 0x598ed + 5 bytes

UnnamedText_598f2: ; 0x598f2
    TX_FAR _UnnamedText_598f2
    db $50
; 0x598f2 + 5 bytes

UnnamedText_598f7: ; 0x598f7
    TX_FAR _UnnamedText_598f7
    db $50
; 0x598f7 + 5 bytes

UnnamedText_598fc: ; 0x598fc
    TX_FAR _UnnamedText_598fc
    db $50
; 0x598fc + 5 bytes

UnnamedText_59901: ; 0x59901
    TX_FAR _UnnamedText_59901
    db $50
; 0x59901 + 5 bytes

UnnamedText_59906: ; 0x59906
    TX_FAR _UnnamedText_59906
    db $50
; 0x59906 + 5 bytes

UnnamedText_5990b: ; 0x5990b
    TX_FAR _UnnamedText_5990b
    db $50
; 0x5990b + 5 bytes

UnnamedText_59910: ; 0x59910
    TX_FAR _UnnamedText_59910
    db $50
; 0x59910 + 5 bytes

UnnamedText_59915: ; 0x59915
    TX_FAR _UnnamedText_59915
    db $50
; 0x59915 + 5 bytes

UnnamedText_5991a: ; 0x5991a
    TX_FAR _UnnamedText_5991a
    db $50
; 0x5991a + 5 bytes

UnnamedText_5991f: ; 0x5991f
    TX_FAR _UnnamedText_5991f
    db $50
; 0x5991f + 5 bytes

UnnamedText_59924: ; 0x59924
    TX_FAR _UnnamedText_59924
    db $50
; 0x59924 + 5 bytes

UnnamedText_59929: ; 0x59929
    TX_FAR _UnnamedText_59929
    db $50
; 0x59929 + 5 bytes

Route15Text12: ; 0x5992e
    TX_FAR _Route15Text12
    db $50

Route16Script: ; 0x59933
    call $3c3c
    ld hl, $59cf
    ld de, $5951
    ld a, [$d626]
    call $3160
    ld [$d626], a
    ret
; 0x59946

INCBIN "baserom.gbc",$59946,$73

Route16Texts: ; 0x599b9
    dw Route16Text1, Route16Text2, Route16Text3, Route16Text4, Route16Text5, Route16Text6, Route16Text7, Route16Text8, Route16Text9, Route16Text10, Route16Text11

INCBIN "baserom.gbc",$599cb + 4,$4d - 4

Route16Text1: ; 0x59a18
    db $08 ; asm
    ld hl, $59cf
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59a22: ; 0x59a22
    TX_FAR _UnnamedText_59a22
    db $50
; 0x59a22 + 5 bytes

UnnamedText_59a27: ; 0x59a27
    TX_FAR _UnnamedText_59a27
    db $50
; 0x59a27 + 5 bytes

UnnamedText_59a2c: ; 0x59a2c
    TX_FAR _UnnamedText_59a2c
    db $50
; 0x59a2c + 5 bytes

Route16Text2: ; 0x59a31
    db $08 ; asm
    ld hl, $59db
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59a3b: ; 0x59a3b
    TX_FAR _UnnamedText_59a3b
    db $50
; 0x59a3b + 5 bytes

UnnamedText_59a40: ; 0x59a40
    TX_FAR _UnnamedText_59a40
    db $50
; 0x59a40 + 5 bytes

UnnamedText_59a45: ; 0x59a45
    TX_FAR _UnnamedText_59a45
    db $50
; 0x59a45 + 5 bytes

Route16Text3: ; 0x59a4a
    db $08 ; asm
    ld hl, $59e7
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59a54: ; 0x59a54
    TX_FAR _UnnamedText_59a54
    db $50
; 0x59a54 + 5 bytes

UnnamedText_59a59: ; 0x59a59
    TX_FAR _UnnamedText_59a59
    db $50
; 0x59a59 + 5 bytes

UnnamedText_59a5e: ; 0x59a5e
    TX_FAR _UnnamedText_59a5e
    db $50
; 0x59a5e + 5 bytes

Route16Text4: ; 0x59a63
    db $08 ; asm
    ld hl, $59f3
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59a6d: ; 0x59a6d
    TX_FAR _UnnamedText_59a6d
    db $50
; 0x59a6d + 5 bytes

UnnamedText_59a72: ; 0x59a72
    TX_FAR _UnnamedText_59a72
    db $50
; 0x59a72 + 5 bytes

UnnamedText_59a77: ; 0x59a77
    TX_FAR _UnnamedText_59a77
    db $50
; 0x59a77 + 5 bytes

Route16Text5: ; 0x59a7c
    db $08 ; asm
    ld hl, $59ff
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59a86: ; 0x59a86
    TX_FAR _UnnamedText_59a86
    db $50
; 0x59a86 + 5 bytes

UnnamedText_59a8b: ; 0x59a8b
    TX_FAR _UnnamedText_59a8b
    db $50
; 0x59a8b + 5 bytes

UnnamedText_59a90: ; 0x59a90
    TX_FAR _UnnamedText_59a90
    db $50
; 0x59a90 + 5 bytes

Route16Text6: ; 0x59a95
    db $08 ; asm
    ld hl, $5a0b
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59a9f: ; 0x59a9f
    TX_FAR _UnnamedText_59a9f
    db $50
; 0x59a9f + 5 bytes

UnnamedText_59aa4: ; 0x59aa4
    TX_FAR _UnnamedText_59aa4
    db $50
; 0x59aa4 + 5 bytes

UnnamedText_59aa9: ; 0x59aa9
    TX_FAR _UnnamedText_59aa9
    db $50
; 0x59aa9 + 5 bytes

Route16Text7: ; 0x59aae
    TX_FAR _Route16Text7
    db $50

Route16Text10: ; 0x59ab3
    TX_FAR _UnnamedText_59ab3
    db $50
; 0x59ab3 + 5 bytes

Route16Text11: ; 0x59ab8
    TX_FAR _UnnamedText_59ab8
    db $50
; 0x59ab8 + 5 bytes

Route16Text8: ; 0x59abd
    TX_FAR _Route16Text8
    db $50

Route16Text9: ; 0x59ac2
    TX_FAR _Route16Text9
    db $50

Route18Script: ; 0x59ac7
    call $3c3c
    ld hl, $5aea
    ld de, $5ada
    ld a, [$d627]
    call $3160
    ld [$d627], a
    ret
; 0x59ada

INCBIN "baserom.gbc",$59ada,$6

Route18Texts: ; 0x59ae0
    dw Route18Text1, Route18Text2, Route18Text3, Route18Text4, Route18Text5

INCBIN "baserom.gbc",$59aea,$25

Route18Text1: ; 0x59b0f
    db $08 ; asm
    ld hl, $5aea
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59b19: ; 0x59b19
    TX_FAR _UnnamedText_59b19
    db $50
; 0x59b19 + 5 bytes

UnnamedText_59b1e: ; 0x59b1e
    TX_FAR _UnnamedText_59b1e
    db $50
; 0x59b1e + 5 bytes

UnnamedText_59b23: ; 0x59b23
    TX_FAR _UnnamedText_59b23
    db $50
; 0x59b23 + 5 bytes

Route18Text2: ; 0x59b28
    db $08 ; asm
    ld hl, $5af6
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59b32: ; 0x59b32
    TX_FAR _UnnamedText_59b32
    db $50
; 0x59b32 + 5 bytes

UnnamedText_59b37: ; 0x59b37
    TX_FAR _UnnamedText_59b37
    db $50
; 0x59b37 + 5 bytes

UnnamedText_59b3c: ; 0x59b3c
    TX_FAR _UnnamedText_59b3c
    db $50
; 0x59b3c + 5 bytes

Route18Text3: ; 0x59b41
    db $08 ; asm
    ld hl, $5b02
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59b4b: ; 0x59b4b
    TX_FAR _UnnamedText_59b4b
    db $50
; 0x59b4b + 5 bytes

UnnamedText_59b50: ; 0x59b50
    TX_FAR _UnnamedText_59b50
    db $50
; 0x59b50 + 5 bytes

UnnamedText_59b55: ; 0x59b55
    TX_FAR _UnnamedText_59b55
    db $50
; 0x59b55 + 5 bytes

Route18Text4: ; 0x59b5a
    TX_FAR _Route18Text4
    db $50

Route18Text5: ; 0x59b5f
    TX_FAR _Route18Text5
    db $50

FanClub_h: ; 0x59b64 to 0x59b70 (12 bytes) (id=90)
    db $10 ; tileset
    db POKEMON_FAN_CLUB_HEIGHT, POKEMON_FAN_CLUB_WIDTH ; dimensions (y, x)
    dw FanClubBlocks, FanClubTexts, FanClubScript ; blocks, texts, scripts
    db $00 ; connections

    dw FanClubObject ; objects

FanClubScript: ; 0x59b70
    jp $3c3c
; 0x59b73

INCBIN "baserom.gbc",$59b73,$11

FanClubTexts: ; 0x59b84
    dw FanClubText1, FanClubText2, FanClubText3, FanClubText4, FanClubText5, FanClubText6, FanClubText7, FanClubText8

FanClubText1: ; 0x59b94
    db $08 ; asm
    ld a, [$d771]
    bit 7, a
    jr nz, asm_67b22 ; 0x59b9a
    ld hl, $5bb7
    call PrintText
    ld hl, $d771
    set 6, [hl]
    jr asm_64f01 ; 0x59ba7
asm_67b22 ; 0x59ba9
    ld hl, $5bbc
    call PrintText
    ld hl, $d771
    res 7, [hl]
asm_64f01 ; 0x59bb4
    jp $24d7

UnnamedText_59bb7: ; 0x59bb7
    TX_FAR _UnnamedText_59bb7
    db $50
; 0x59bb7 + 5 bytes

UnnamedText_59bbc: ; 0x59bbc
    TX_FAR _UnnamedText_59bbc
    db $50
; 0x59bbc + 5 bytes

FanClubText2: ; 0x59bc1
    db $08 ; asm
    ld a, [$d771]
    bit 6, a
    jr nz, asm_5cd59 ; 0x59bc7
    ld hl, $5be4
    call PrintText
    ld hl, $d771
    set 7, [hl]
    jr asm_59625 ; 0x59bd4
asm_5cd59 ; 0x59bd6
    ld hl, $5be9
    call PrintText
    ld hl, $d771
    res 6, [hl]
asm_59625 ; 0x59be1
    jp $24d7

UnnamedText_59be4: ; 0x59be4
    TX_FAR _UnnamedText_59be4
    db $50
; 0x59be4 + 5 bytes

UnnamedText_59be9: ; 0x59be9
    TX_FAR _UnnamedText_59be9
    db $50
; 0x59be9 + 5 bytes

FanClubText3: ; 0x59bee
    db $8
    ld hl, $5c00
    call PrintText
    ld a, $54
    call $13d0
    call $3748
    jp $24d7
; 0x59c00

UnnamedText_59c00: ; 0x59c00
    TX_FAR _UnnamedText_59c00
    db $50
; 0x59c00 + 5 bytes

FanClubText4: ; 0x59c05
    db $08 ; asm
    ld hl, $5c17
    call PrintText
	ld a,SEEL
    call $13d0
    call $3748
    jp $24d7

UnnamedText_59c17: ; 0x59c17
    TX_FAR _UnnamedText_59c17
    db $50
; 0x59c17 + 5 bytes

FanClubText5: ; 0x59c1c
    db $08 ; asm
    call $5b73
    jr nz, asm_38bb3 ; 0x59c20
    ld hl, $5c65
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, asm_2c8d7 ; 0x59c2f
    ld hl, $5c6a
    call PrintText
    ld bc,(BIKE_VOUCHER << 8) | 1
    call $3e2e
    jr nc, asm_867d4 ; 0x59c3d
    ld hl, $5c6f
    call PrintText
    ld hl, $d771
    set 1, [hl]
    jr asm_d3c26 ; 0x59c4a
asm_867d4 ; 0x59c4c
    ld hl, $5c83
    call PrintText
    jr asm_d3c26 ; 0x59c52
asm_2c8d7 ; 0x59c54
    ld hl, $5c79
    call PrintText
    jr asm_d3c26 ; 0x59c5a
asm_38bb3 ; 0x59c5c
    ld hl, $5c7e
    call PrintText
asm_d3c26 ; 0x59c62
    jp $24d7

UnnamedText_59c65: ; 0x59c65
    TX_FAR _UnnamedText_59c65
    db $50
; 0x59c65 + 5 bytes

UnnamedText_59c6a: ; 0x59c6a
    TX_FAR _UnnamedText_59c6a
    db $50
; 0x59c6a + 5 bytes

INCBIN "baserom.gbc",$59c6f,$59c74 - $59c6f

UnnamedText_59c74: ; 0x59c74
    TX_FAR _UnnamedText_59c74
    db $50
; 0x59c74 + 5 bytes

UnnamedText_59c79: ; 0x59c79
    TX_FAR _UnnamedText_59c79
    db $50
; 0x59c79 + 5 bytes

UnnamedText_59c7e: ; 0x59c7e
    TX_FAR _UnnamedText_59c7e
    db $50
; 0x59c7e + 5 bytes

UnnamedText_59c83: ; 0x59c83
    TX_FAR _UnnamedText_59c83
    db $50
; 0x59c83 + 5 bytes

FanClubText6:
    TX_FAR _FanClubText6
    db $50

FanClubText7:
    TX_FAR _FanClubText7
    db $50

FanClubText8: ; 0x59c92
    TX_FAR _FanClubText8
    db $50

FanClubObject: ; 0x59c97 (size=62)
    db $d ; border tile

    db $2 ; warps
    db $7, $2, $1, $ff
    db $7, $3, $1, $ff

    db $2 ; signs
    db $0, $1, $7 ; FanClubText7
    db $0, $6, $8 ; FanClubText8

    db $6 ; people
    db SPRITE_FISHER2, $3 + 4, $6 + 4, $ff, $d2, $1 ; person
    db SPRITE_GIRL, $3 + 4, $1 + 4, $ff, $d3, $2 ; person
    db SPRITE_CLEFAIRY, $4 + 4, $6 + 4, $ff, $d2, $3 ; person
    db SPRITE_SEEL, $4 + 4, $1 + 4, $ff, $d3, $4 ; person
    db SPRITE_GENTLEMAN, $1 + 4, $3 + 4, $ff, $d0, $5 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $1 + 4, $5 + 4, $ff, $d0, $6 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

FanClubBlocks: ; 16
    INCBIN "maps/fanclub.blk"

SilphCo2_h: ; 0x59ce5 to 0x59cf1 (12 bytes) (id=207)
    db $16 ; tileset
    db SILPH_CO_2F_HEIGHT, SILPH_CO_2F_WIDTH ; dimensions (y, x)
    dw SilphCo2Blocks, SilphCo2Texts, SilphCo2Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo2Object ; objects

SilphCo2Script: ; 0x59cf1
    call $5d07
    call $3c3c
    ld hl, $5d90
    ld de, $5d80
    ld a, [$d643]
    call $3160
    ld [$d643], a
    ret
; 0x59d07

INCBIN "baserom.gbc",$59d07,$7f

SilphCo2Texts: ; 0x59d86
    dw SilphCo2Text1, SilphCo2Text2, SilphCo2Text3, SilphCo2Text4, SilphCo2Text5

INCBIN "baserom.gbc",$59d90,$31

SilphCo2Text1: ; 0x59dc1
    db $08 ; asm
    ld a, [$d826]
    bit 7, a
    jr nz, asm_b8a0d ; 0x59dc7
    ld hl, $5ded
    call PrintText
    ld bc,(TM_36 << 8) | 1
    call $3e2e
    ld hl, $5dfd
    jr nc, asm_2c1e0 ; 0x59dd8
    ld hl, $d826
    set 7, [hl]
    ld hl, $5df2
    jr asm_2c1e0 ; 0x59de2
asm_b8a0d ; 0x59de4
    ld hl, $5df8
asm_2c1e0 ; 0x59de7
    call PrintText
    jp $24d7

UnnamedText_59ded: ; 0x59ded
    TX_FAR _UnnamedText_59ded
    db $50
; 0x59ded + 5 bytes

INCBIN "baserom.gbc",$59df2,$59df8 - $59df2

UnnamedText_59df8: ; 0x59df8
    TX_FAR _UnnamedText_59df8
    db $50
; 0x59df8 + 5 bytes

UnnamedText_59dfd: ; 0x59dfd
    TX_FAR _UnnamedText_59dfd
    db $50
; 0x59dfd + 5 bytes

SilphCo2Text2: ; 0x59e02
    db $08 ; asm
    ld hl, $5d90
    call LoadTrainerHeader
    jp $24d7

SilphCo2Text3: ; 0x59e0c
    db $08 ; asm
    ld hl, $5d9c
    call LoadTrainerHeader
    jp $24d7

SilphCo2Text4: ; 0x59e16
    db $08 ; asm
    ld hl, $5da8
    call LoadTrainerHeader
    jp $24d7

SilphCo2Text5: ; 0x59e20
    db $08 ; asm
    ld hl, $5db4
    call LoadTrainerHeader
    jp $24d7

UnnamedText_59e2a: ; 0x59e2a
    TX_FAR _UnnamedText_59e2a
    db $50
; 0x59e2a + 5 bytes

UnnamedText_59e2f: ; 0x59e2f
    TX_FAR _UnnamedText_59e2f
    db $50
; 0x59e2f + 5 bytes

UnnamedText_59e34: ; 0x59e34
    TX_FAR _UnnamedText_59e34
    db $50
; 0x59e34 + 5 bytes

UnnamedText_59e39: ; 0x59e39
    TX_FAR _UnnamedText_59e39
    db $50
; 0x59e39 + 5 bytes

UnnamedText_59e3e: ; 0x59e3e
    TX_FAR _UnnamedText_59e3e
    db $50
; 0x59e3e + 5 bytes

UnnamedText_59e43: ; 0x59e43
    TX_FAR _UnnamedText_59e43
    db $50
; 0x59e43 + 5 bytes

UnnamedText_59e48: ; 0x59e48
    TX_FAR _UnnamedText_59e48
    db $50
; 0x59e48 + 5 bytes

UnnamedText_59e4d: ; 0x59e4d
    TX_FAR _UnnamedText_59e4d
    db $50
; 0x59e4d + 5 bytes

UnnamedText_59e52: ; 0x59e52
    TX_FAR _UnnamedText_59e52
    db $50
; 0x59e52 + 5 bytes

UnnamedText_59e57: ; 0x59e57
    TX_FAR _UnnamedText_59e57
    db $50
; 0x59e57 + 5 bytes

UnnamedText_59e5c: ; 0x59e5c
    TX_FAR _UnnamedText_59e5c
    db $50
; 0x59e5c + 5 bytes

UnnamedText_59e61: ; 0x59e61
    TX_FAR _UnnamedText_59e61
    db $50
; 0x59e61 + 5 bytes

SilphCo2Object: ; 0x59e66 (size=98)
    db $2e ; border tile

    db $7 ; warps
    db $0, $18, $2, SILPH_CO_1F
    db $0, $1a, $0, SILPH_CO_3F
    db $0, $14, $0, SILPH_CO_ELEVATOR
    db $3, $3, $6, SILPH_CO_3F
    db $3, $d, $4, SILPH_CO_8F
    db $f, $1b, $5, SILPH_CO_8F
    db $f, $9, $4, SILPH_CO_6F

    db $0 ; signs

    db $5 ; people
    db SPRITE_ERIKA, $1 + 4, $a + 4, $ff, $d1, $1 ; person
    db SPRITE_OAK_AIDE, $c + 4, $5 + 4, $ff, $d0, $42, SCIENTIST + $C8, $2 ; trainer
    db SPRITE_OAK_AIDE, $d + 4, $18 + 4, $ff, $d2, $43, SCIENTIST + $C8, $3 ; trainer
    db SPRITE_ROCKET, $b + 4, $10 + 4, $ff, $d1, $44, ROCKET + $C8, $17 ; trainer
    db SPRITE_ROCKET, $7 + 4, $18 + 4, $ff, $d1, $45, ROCKET + $C8, $18 ; trainer

    ; warp-to
    EVENT_DISP $f, $0, $18 ; SILPH_CO_1F
    EVENT_DISP $f, $0, $1a ; SILPH_CO_3F
    EVENT_DISP $f, $0, $14 ; SILPH_CO_ELEVATOR
    EVENT_DISP $f, $3, $3 ; SILPH_CO_3F
    EVENT_DISP $f, $3, $d ; SILPH_CO_8F
    EVENT_DISP $f, $f, $1b ; SILPH_CO_8F
    EVENT_DISP $f, $f, $9 ; SILPH_CO_6F

SilphCo2Blocks: ; 135
    INCBIN "maps/silphco2.blk"

SilphCo3_h: ; 0x59f4f to 0x59f5b (12 bytes) (id=208)
    db $16 ; tileset
    db SILPH_CO_3F_HEIGHT, SILPH_CO_3F_WIDTH ; dimensions (y, x)
    dw SilphCo3Blocks, SilphCo3Texts, SilphCo3Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo3Object ; objects

SilphCo3Script: ; 0x59f5b
    call $5f71
    call $3c3c
    ld hl, $5fcc
    ld de, $5fbe
    ld a, [$d644]
    call $3160
    ld [$d644], a
    ret
; 0x59f71

INCBIN "baserom.gbc",$59f71,$53

SilphCo3Texts: ; 0x59fc4
    dw SilphCo3Text1, SilphCo3Text2, SilphCo3Text3, SilphCo3Text4

INCBIN "baserom.gbc",$59fcc,$19

SilphCo3Text1: ; 0x59fe5
    db $08 ; asm
    ld a, [$d838]
    bit 7, a
    ld hl, $5ffe
    jr nz, asm_8c56f ; 0x59fee
    ld hl, $5ff9
asm_8c56f ; 0x59ff3
    call PrintText
    jp $24d7

UnnamedText_59ff9: ; 0x59ff9
    TX_FAR _UnnamedText_59ff9
    db $50
; 0x59ff9 + 5 bytes

UnnamedText_59ffe: ; 0x59ffe
    TX_FAR _UnnamedText_59ffe
    db $50
; 0x59ffe + 5 bytes

SilphCo3Text2: ; 0x5a003
    db $08 ; asm
    ld hl, $5fcc
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5a00d: ; 0x5a00d
    TX_FAR _UnnamedText_5a00d
    db $50
; 0x5a00d + 5 bytes

UnnamedText_5a012: ; 0x5a012
    TX_FAR _UnnamedText_5a012
    db $50
; 0x5a012 + 5 bytes

UnnamedText_5a017: ; 0x5a017
    TX_FAR _UnnamedText_5a017
    db $50
; 0x5a017 + 5 bytes

SilphCo3Text3: ; 0x5a01c
    db $08 ; asm
    ld hl, $5fd8
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5a026: ; 0x5a026
    TX_FAR _UnnamedText_5a026
    db $50
; 0x5a026 + 5 bytes

UnnamedText_5a02b: ; 0x5a02b
    TX_FAR _UnnamedText_5a02b
    db $50
; 0x5a02b + 5 bytes

UnnamedText_5a030: ; 0x5a030
    TX_FAR _UnnamedText_5a030
    db $50
; 0x5a030 + 5 bytes

SilphCo3Object: ; 0x5a035 (size=113)
    db $2e ; border tile

    db $a ; warps
    db $0, $1a, $1, SILPH_CO_2F
    db $0, $18, $0, SILPH_CO_4F
    db $0, $14, $0, SILPH_CO_ELEVATOR
    db $b, $17, $9, SILPH_CO_3F
    db $3, $3, $5, SILPH_CO_5F
    db $f, $3, $6, SILPH_CO_5F
    db $3, $1b, $3, SILPH_CO_2F
    db $b, $3, $3, SILPH_CO_9F
    db $b, $b, $4, SILPH_CO_7F
    db $f, $1b, $3, SILPH_CO_3F

    db $0 ; signs

    db $4 ; people
    db SPRITE_LAPRAS_GIVER, $8 + 4, $18 + 4, $ff, $ff, $1 ; person
    db SPRITE_ROCKET, $7 + 4, $14 + 4, $ff, $d2, $42, ROCKET + $C8, $19 ; trainer
    db SPRITE_OAK_AIDE, $9 + 4, $7 + 4, $ff, $d0, $43, SCIENTIST + $C8, $4 ; trainer
	db SPRITE_BALL, $5 + 4, $8 + 4, $ff, $ff, $84, HYPER_POTION ; item

    ; warp-to
    EVENT_DISP $f, $0, $1a ; SILPH_CO_2F
    EVENT_DISP $f, $0, $18 ; SILPH_CO_4F
    EVENT_DISP $f, $0, $14 ; SILPH_CO_ELEVATOR
    EVENT_DISP $f, $b, $17 ; SILPH_CO_3F
    EVENT_DISP $f, $3, $3 ; SILPH_CO_5F
    EVENT_DISP $f, $f, $3 ; SILPH_CO_5F
    EVENT_DISP $f, $3, $1b ; SILPH_CO_2F
    EVENT_DISP $f, $b, $3 ; SILPH_CO_9F
    EVENT_DISP $f, $b, $b ; SILPH_CO_7F
    EVENT_DISP $f, $f, $1b ; SILPH_CO_3F

SilphCo3Blocks: ; 135
    INCBIN "maps/silphco3.blk"

SilphCo10_h: ; 0x5a12d to 0x5a139 (12 bytes) (id=234)
    db $16 ; tileset
    db SILPH_CO_10F_HEIGHT, SILPH_CO_10F_WIDTH ; dimensions (y, x)
    dw SilphCo10Blocks, SilphCo10Texts, SilphCo10Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo10Object ; objects

SilphCo10Script: ; 0x5a139
    call $614f
    call $3c3c
    ld hl, $6192
    ld de, $6180
    ld a, [$d658]
    call $3160
    ld [$d658], a
    ret
; 0x5a14f

INCBIN "baserom.gbc",$5a14f,$37

SilphCo10Texts: ; 0x5a186
    dw SilphCo10Text1, SilphCo10Text2, SilphCo10Text3, SilphCo10Text4, SilphCo10Text5, SilphCo10Text6

INCBIN "baserom.gbc",$5a192,$19

SilphCo10Text1: ; 0x5a1ab
    db $08 ; asm
    ld hl, $6192
    call LoadTrainerHeader
    jp $24d7

SilphCo10Text2: ; 0x5a1b5
    db $08 ; asm
    ld hl, $619e
    call LoadTrainerHeader
    jp $24d7

SilphCo10Text3: ; 0x5a1bf
    db $08 ; asm
    ld a, [$d838]
    bit 7, a
    ld hl, $61d8
    jr nz, asm_cf85f ; 0x5a1c8
    ld hl, $61d3
asm_cf85f ; 0x5a1cd
    call PrintText
    jp $24d7

UnnamedText_5a1d3: ; 0x5a1d3
    TX_FAR _UnnamedText_5a1d3
    db $50
; 0x5a1d3 + 5 bytes

UnnamedText_5a1d8: ; 0x5a1d8
    TX_FAR _UnnamedText_5a1d8
    db $50
; 0x5a1d8 + 5 bytes

UnnamedText_5a1dd: ; 0x5a1dd
    TX_FAR _UnnamedText_5a1dd
    db $50
; 0x5a1dd + 5 bytes

UnnamedText_5a1e2: ; 0x5a1e2
    TX_FAR _UnnamedText_5a1e2
    db $50
; 0x5a1e2 + 5 bytes

UnnamedText_5a1e7: ; 0x5a1e7
    TX_FAR _UnnamedText_5a1e7
    db $50
; 0x5a1e7 + 5 bytes

UnnamedText_5a1ec: ; 0x5a1ec
    TX_FAR _UnnamedText_5a1ec
    db $50
; 0x5a1ec + 5 bytes

UnnamedText_5a1f1: ; 0x5a1f1
    TX_FAR _UnnamedText_5a1f1
    db $50
; 0x5a1f1 + 5 bytes

UnnamedText_5a1f6: ; 0x5a1f6
    TX_FAR _UnnamedText_5a1f6
    db $50
; 0x5a1f6 + 5 bytes

SilphCo10Object: ; 0x5a1fb (size=95)
    db $2e ; border tile

    db $6 ; warps
    db $0, $8, $0, SILPH_CO_9F
    db $0, $a, $0, SILPH_CO_11F
    db $0, $c, $0, SILPH_CO_ELEVATOR
    db $b, $9, $3, SILPH_CO_4F
    db $f, $d, $5, SILPH_CO_4F
    db $7, $d, $6, SILPH_CO_4F

    db $0 ; signs

    db $6 ; people
    db SPRITE_ROCKET, $9 + 4, $1 + 4, $ff, $d3, $41, ROCKET + $C8, $27 ; trainer
    db SPRITE_OAK_AIDE, $2 + 4, $a + 4, $ff, $d2, $42, SCIENTIST + $C8, $b ; trainer
    db SPRITE_ERIKA, $f + 4, $9 + 4, $fe, $0, $3 ; person
	db SPRITE_BALL, $c + 4, $2 + 4, $ff, $ff, $84, TM_26 ; item
	db SPRITE_BALL, $e + 4, $4 + 4, $ff, $ff, $85, RARE_CANDY ; item
	db SPRITE_BALL, $b + 4, $5 + 4, $ff, $ff, $86, CARBOS ; item

    ; warp-to
    EVENT_DISP $8, $0, $8 ; SILPH_CO_9F
    EVENT_DISP $8, $0, $a ; SILPH_CO_11F
    EVENT_DISP $8, $0, $c ; SILPH_CO_ELEVATOR
    EVENT_DISP $8, $b, $9 ; SILPH_CO_4F
    EVENT_DISP $8, $f, $d ; SILPH_CO_4F
    EVENT_DISP $8, $7, $d ; SILPH_CO_4F

SilphCo10Blocks: ; 72
    INCBIN "maps/silphco10.blk"

Lance_h: ; 0x5a2a2 to 0x5a2ae (12 bytes) (id=113)
    db $05 ; tileset
    db LANCES_ROOM_HEIGHT, LANCES_ROOM_WIDTH ; dimensions (y, x)
    dw LanceBlocks, LanceTexts, LanceScript ; blocks, texts, scripts
    db $00 ; connections

    dw LanceObject ; objects

LanceScript: ; 0x5a2ae
    call $62c4
    call $3c3c
    ld hl, $6397
    ld de, $62fa
    ld a, [$d653]
    call $3160
    ld [$d653], a
    ret
; 0x5a2c4

INCBIN "baserom.gbc",$5a2c4,$d1

LanceTexts: ; 0x5a395
    dw LanceText1

INCBIN "baserom.gbc",$5a397,$d

LanceText1: ; 0x5a3a4
    db $08 ; asm
    ld hl, $6397
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5a3ae: ; 0x5a3ae
    TX_FAR _UnnamedText_5a3ae
    db $50
; 0x5a3ae + 5 bytes

UnnamedText_5a3b3: ; 0x5a3b3
    TX_FAR _UnnamedText_5a3b3
    db $50
; 0x5a3b3 + 5 bytes

INCBIN "baserom.gbc",$5a3b8,$d

LanceObject: ; 0x5a3c5 (size=36)
    db $3 ; border tile

    db $3 ; warps
    db $10, $18, $2, AGATHAS_ROOM
    db $0, $5, $0, CHAMPIONS_ROOM
    db $0, $6, $0, CHAMPIONS_ROOM

    db $0 ; signs

    db $1 ; people
    db SPRITE_LANCE, $1 + 4, $6 + 4, $ff, $d0, $41, LANCE + $C8, $1 ; trainer

    ; warp-to
    EVENT_DISP $d, $10, $18 ; AGATHAS_ROOM
    EVENT_DISP $d, $0, $5 ; CHAMPIONS_ROOM
    EVENT_DISP $d, $0, $6 ; CHAMPIONS_ROOM

LanceBlocks: ; 169
    INCBIN "maps/lance.blk"

HallofFameRoom_h: ; 0x5a492 to 0x5a49e (12 bytes) (id=118)
    db $07 ; tileset
    db HALL_OF_FAME_HEIGHT, HALL_OF_FAME_WIDTH ; dimensions (y, x)
    dw HallofFameRoomBlocks, HallofFameRoomTexts, HallofFameRoomScript ; blocks, texts, scripts
    db $00 ; connections

    dw HallofFameRoomObject ; objects

HallofFameRoomScript: ; 0x5a49e
    call $3c3c
    ld hl, $64b2
    ld a, [$d64b]
    jp $3d97
; 0x5a4aa

INCBIN "baserom.gbc",$5a4aa,$5a4b2 - $5a4aa

HallofFameRoomScripts: ; 0x5a4b2
    dw HallofFameRoomScript0, HallofFameRoomScript1, HallofFameRoomScript2

INCBIN "baserom.gbc",$5a4b8,$3

HallofFameRoomScript2: ; 0x5a4bb
    call Delay3
    ld a, [$d358]
    push af
    xor a
    ld [$cd6b], a
    ld a, $55
    call Predef
    pop af
    ld [$d358], a
    ld hl, $d733
    res 1, [hl]
    inc hl
    set 0, [hl]
    xor a
    ld hl, $d64d
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld [$d653], a
    ld [$d64b], a
    ld hl, $d863
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    xor a
    ld [$d64b], a
    ld a, $0
    ld [$d719], a
    ld b, $1c
    ld hl, $7848
    call Bankswitch
    ld b, $5
.asm_5a4ff
    ld c, $78
    call $3739
    dec b
    jr nz, .asm_5a4ff ; 0x5a505 $f8
    call $3865
    jp $1f54
; 0x5a50d

HallofFameRoomScript0: ; 0x5a50d
    ld a, $ff
    ld [$cd6b], a
    ld hl, $ccd3
    ld de, $6528
    call $350c
    dec a
    ld [$cd38], a
    call $3486
    ld a, $1
    ld [$d64b], a
    ret
; 0x5a528

INCBIN "baserom.gbc",$5a528,$5a52b - $5a528

HallofFameRoomScript1: ; 0x5a52b
    ld a, [$cd38]
    and a
    ret nz
    ld a, $1
    ld [$d528], a
    ld a, $1
    ld [$ff00+$8c], a
    call $3541
    ld a, $8
    ld [$ff00+$8d], a
    call $34a6
    call Delay3
    xor a
    ld [$cd6b], a
    inc a
    ld [$d528], a
    ld a, $1
    ld [$ff00+$8c], a
    call $2920
    ld a, $ff
    ld [$cd6b], a
    ld a, $8
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld a, $2
    ld [$d64b], a
    ret
; 0x5a56a

HallofFameRoomTexts: ; 0x5a56a
    dw HallofFameRoomText1

HallofFameRoomText1: ; 0x5a56c
    TX_FAR _HallofFameRoomText1
    db $50

HallofFameRoomObject: ; 0x5a571 (size=26)
    db $3 ; border tile

    db $2 ; warps
    db $7, $4, $2, CHAMPIONS_ROOM
    db $7, $5, $3, CHAMPIONS_ROOM

    db $0 ; signs

    db $1 ; people
    db SPRITE_OAK, $2 + 4, $5 + 4, $ff, $d0, $1 ; person

    ; warp-to
    EVENT_DISP $5, $7, $4 ; CHAMPIONS_ROOM
    EVENT_DISP $5, $7, $5 ; CHAMPIONS_ROOM

HallofFameRoomBlocks: ; 20
    INCBIN "maps/halloffameroom.blk"

INCBIN "baserom.gbc",$5a59f,$1a61

SECTION "bank17",DATA,BANK[$17]

SaffronMartBlocks:
LavenderMartBlocks:
CeruleanMartBlocks:
VermilionMartBlocks: ; 16
    INCBIN "maps/vermilionmart.blk"

CopycatsHouseF2Blocks:
RedsHouse2FBlocks:
	INCBIN "maps/redshouse2f.blk"

MuseumF1Blocks: ; 40
    INCBIN "maps/museumf1.blk"

MuseumF2Blocks: ; 28
    INCBIN "maps/museumf2.blk"

SaffronPokecenterBlocks:
VermilionPokecenterBlocks:
LavenderPokecenterBlocks:
PewterPokecenterBlocks: ; 28
    INCBIN "maps/pewterpokecenter.blk"

UndergroundTunnelEntranceRoute7Blocks:
UndergroundTunnelEntranceRoute6Blocks:
UndergroundTunnelEntranceRoute5Blocks: ; 16
    INCBIN "maps/undergroundtunnelentranceroute5.blk"

Route2GateBlocks:
ViridianForestEntranceBlocks:
ViridianForestexitBlocks: ; 20
    INCBIN "maps/viridianforestexit.blk"

RedsHouse2F_h:
	db $04 ; tileset
	db $04,$04 ; dimensions
	dw RedsHouse2FBlocks, RedsHouse2FTexts, RedsHouse2FScript
	db 0 ; no connections
	dw RedsHouse2FObject

RedsHouse2FScript:
	call $3C3C
	ld hl,RedsHouse2FScriptPointers
	ld a,[$D60C]
	jp $3D97

RedsHouse2FScriptPointers:
	dw RedsHouse2FScript1,RedsHouse2FScript2

RedsHouse2FScript1:
	xor a
	ld [$FFB4],a
	ld a,8
	ld [$D528],a
	ld a,1
	ld [$D60C],a
	ret

RedsHouse2FScript2:
	ret

RedsHouse2FTexts:
	db "@"

RedsHouse2FObject:
	db $0A ; border tile

	db 1 ; warps
	db 1,7,2,$25

	db 0 ; signs

	db 0 ; people

	dw $C6EF + 4 + (4 + 6) * 0 + 3
	db 1,7

INCBIN "baserom.gbc",$5c0dc,$5c0eb - $5c0dc

MuseumF1_h: ; 0x5c0eb to 0x5c0f7 (12 bytes) (id=52)
    db $0a ; tileset
    db MUSEUM_1F_HEIGHT, MUSEUM_1F_WIDTH ; dimensions (y, x)
    dw MuseumF1Blocks, MuseumF1Texts, MuseumF1Script ; blocks, texts, scripts
    db $00 ; connections

    dw MuseumF1Object ; objects

MuseumF1Script: ; 0x5c0f7
    ld a, $1
    ld [$cf0c], a
    xor a
    ld [$cc3c], a
    ld hl, $4109
    ld a, [$d619]
    jp $3d97
; 0x5c109

MuseumF1Scripts: ; 0x5c109
    dw MuseumF1Script0, MuseumF1Script1

MuseumF1Script0: ; 0x5c10d
    ld a, [$d361]
    cp $4
    ret nz
    ld a, [$d362]
    cp $9
    jr z, .asm_5c120 ; 0x5c118 $6
    ld a, [$d362]
    cp $a
    ret nz
.asm_5c120
    xor a
    ld [$ff00+$b4], a
    ld a, $1
    ld [$ff00+$8c], a
    jp $2920
; 0x5c12a

MuseumF1Script1: ; 0x5c12a
    ret
; 0x5c12b

MuseumF1Texts: ; 0x5c12b
    dw MuseumF1Text1, MuseumF1Text2, MuseumF1Text3, MuseumF1Text4, MuseumF1Text5

MuseumF1Text1: ; 0x5c135
    db $8
    ld a, [$d361]
    cp $4
    jr nz, asm_8774b ; 0x5c13b $a
    ld a, [$d362]
    cp $d
    jp z, $41f9
    jr asm_b8709 ; 0x5c145 $1c
asm_8774b: ; 0x5c147
    cp $3
    jr nz, asm_d49e7 ; 0x5c149 $8
    ld a, [$d362]
    cp $c
    jp z, $41f9
asm_d49e7: ; 0x5c153
    ld a, [$d754]
    bit 0, a
    jr nz, asm_31a16 ; 0x5c158 $10
    ld hl, $423d
    call PrintText
    jp $4217
asm_b8709: ; 0x5c163
    ld a, [$d754]
    bit 0, a
    jr z, asm_3ded4 ; 0x5c168 $9
asm_31a16: ; 0x5c16a
    ld hl, $4242
    call PrintText
    jp $4217
asm_3ded4: ; 0x5c173
    ld a, $13
    ld [$d125], a
    call $30e8
    xor a
    ld [$ff00+$b4], a
    ld hl, $421f
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, asm_de133 ; 0x5c18b $4d
    xor a
    ld [$ff00+$9f], a
    ld [$ff00+$a0], a
    ld a, $50
    ld [$ff00+$a1], a
    call $35a6
    jr nc, asm_0f3e3 ; 0x5c199 $9
    ld hl, $4229
    call PrintText
    jp $41da
asm_0f3e3: ; 0x5c1a4
    ld hl, $4224
    call PrintText
    ld hl, $d754
    set 0, [hl]
    xor a
    ld [$cd3d], a
    ld [$cd3e], a
    ld a, $50
    ld [$cd3f], a
    ld hl, $cd3f
    ld de, $d349
    ld c, $3
    ld a, $c
    call Predef
    ld a, $13
    ld [$d125], a
    call $30e8
    ld a, $b2
    call $3740
    call $3748
    jr asm_0b094 ; 0x5c1d8 $18
asm_de133: ; 0x5c1da
    ld hl, $421a
    call PrintText
    ld a, $1
    ld [$cd38], a
    ld a, $80
    ld [$ccd3], a
    call $3486
    call $2429
    jr asm_d1145 ; 0x5c1f0 $25
asm_0b094: ; 0x5c1f2
    ld a, $1
    ld [$d619], a
    jr asm_d1145 ; 0x5c1f7 $1e
;XXX what calls this?
    ld hl, $422e
    call PrintText
    call $35ec
    ld a, [$cc26]
    cp $0
    jr nz, asm_d1144
    ld hl, $4233
    call PrintText
    jr asm_d1145 ; 0x5c20f $6
asm_d1144:
    ld hl, $4238
    call PrintText
asm_d1145: ; 0x5c217
    jp $24d7
; 0x5c21a

UnnamedText_5c21a: ; 0x5c21a
    TX_FAR _UnnamedText_5c21a
    db $50
; 0x5c21a + 5 bytes

UnnamedText_5c21f: ; 0x5c21f
    TX_FAR _UnnamedText_5c21f
    db $50
; 0x5c21f + 5 bytes

UnnamedText_5c224: ; 0x5c224
    TX_FAR _UnnamedText_5c224
    db $50
; 0x5c224 + 5 bytes

UnnamedText_5c229: ; 0x5c229
    TX_FAR _UnnamedText_5c229
    db $50
; 0x5c229 + 5 bytes

UnnamedText_5c22e: ; 0x5c22e
    TX_FAR _UnnamedText_5c22e
    db $50
; 0x5c22e + 5 bytes

UnnamedText_5c233: ; 0x5c233
    TX_FAR _UnnamedText_5c233
    db $50
; 0x5c233 + 5 bytes

UnnamedText_5c238: ; 0x5c238
    TX_FAR _UnnamedText_5c238
    db $50
; 0x5c238 + 5 bytes

UnnamedText_5c23d: ; 0x5c23d
    TX_FAR _UnnamedText_5c23d
    db $50
; 0x5c23d + 5 bytes

UnnamedText_5c242: ; 0x5c242
    TX_FAR _UnnamedText_5c242
    db $50
; 0x5c242 + 5 bytes

MuseumF1Text2: ; 0x5c247
    db $08 ; asm
    ld hl, $4251
    call PrintText
    jp $24d7

UnnamedText_5c251: ; 0x5c251
    TX_FAR _UnnamedText_5c251
    db $50
; 0x5c251 + 5 bytes

MuseumF1Text3: ; 0x5c256
    db $08 ; asm
    ld a, [$d754]
    bit 1, a
    jr nz, .asm_16599 ; 0x5c25c
    ld hl, $428e
    call PrintText
    ld bc,(OLD_AMBER << 8) | 1
    call $3e2e
    jr nc, .asm_91ebf ; 0x5c26a
    ld hl, $d754
    set 1, [hl]
    ld a, $34
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld hl, $4293
    jr .asm_52e0f ; 0x5c27e
.asm_91ebf ; 0x5c280
    ld hl, $429e
    jr .asm_52e0f ; 0x5c283
.asm_16599 ; 0x5c285
    ld hl, $4299
.asm_52e0f ; 0x5c288
    call PrintText
    jp $24d7

UnnamedText_5c28e: ; 0x5c28e
    TX_FAR _UnnamedText_5c28e
    db $50
; 0x5c28e + 5 bytes

INCBIN "baserom.gbc",$5c293,$5c299 - $5c293

UnnamedText_5c299: ; 0x5c299
    TX_FAR _UnnamedText_5c299
    db $50
; 0x5c299 + 5 bytes

UnnamedText_5c29e: ; 0x5c29e
    TX_FAR _UnnamedText_5c29e
    db $50
; 0x5c29e + 5 bytes

MuseumF1Text4: ; 0x5c2a3
    db $08 ; asm
    ld hl, $42ad
    call PrintText
    jp $24d7

UnnamedText_5c2ad: ; 0x5c2ad
    TX_FAR _UnnamedText_5c2ad
    db $50
; 0x5c2ad + 5 bytes

MuseumF1Text5: ; 0x5c2b2
    db $08 ; asm
    ld hl, $42bc
    call PrintText
    jp $24d7

UnnamedText_5c2bc: ; 0x5c2bc
    TX_FAR _UnnamedText_5c2bc
    db $50
; 0x5c2bc + 5 bytes

MuseumF1Object: ; 0x5c2c1 (size=74)
    db $a ; border tile

    db $5 ; warps
    db $7, $a, $0, $ff
    db $7, $b, $0, $ff
    db $7, $10, $1, $ff
    db $7, $11, $1, $ff
    db $7, $7, $0, MUSEUM_2F

    db $0 ; signs

    db $5 ; people
    db SPRITE_OAK_AIDE, $4 + 4, $c + 4, $ff, $d2, $1 ; person
    db SPRITE_GAMBLER, $4 + 4, $1 + 4, $ff, $ff, $2 ; person
    db SPRITE_OAK_AIDE, $2 + 4, $f + 4, $ff, $d0, $3 ; person
    db SPRITE_OAK_AIDE, $4 + 4, $11 + 4, $ff, $ff, $4 ; person
    db SPRITE_OLD_AMBER, $2 + 4, $10 + 4, $ff, $ff, $5 ; person

    ; warp-to
    EVENT_DISP $a, $7, $a
    EVENT_DISP $a, $7, $b
    EVENT_DISP $a, $7, $10
    EVENT_DISP $a, $7, $11
    EVENT_DISP $a, $7, $7 ; MUSEUM_2F

MuseumF2_h: ; 0x5c30b to 0x5c317 (12 bytes) (id=53)
    db $0a ; tileset
    db MUSEUM_2F_HEIGHT, MUSEUM_2F_WIDTH ; dimensions (y, x)
    dw MuseumF2Blocks, MuseumF2Texts, MuseumF2Script ; blocks, texts, scripts
    db $00 ; connections

    dw MuseumF2Object ; objects

MuseumF2Script: ; 0x5c317
    jp $3c3c
; 0x5c31a

MuseumF2Texts: ; 0x5c31a
    dw MuseumF2Text1, MuseumF2Text2, MuseumF2Text3, MuseumF2Text4, MuseumF2Text5, MuseumF2Text6, MuseumF2Text7

MuseumF2Text1: ; 0x5c328
    TX_FAR _MuseumF2Text1
    db $50

MuseumF2Text2: ; 0x5c32d
    TX_FAR _MuseumF2Text2
    db $50

MuseumF2Text3: ; 0x5c332
    TX_FAR _MuseumF2Text3
    db $50

MuseumF2Text4: ; 0x5c337
    TX_FAR _MuseumF2Text4
    db $50

MuseumF2Text5: ; 0x5c33c
    TX_FAR _MuseumF2Text5
    db $50

MuseumF2Text6: ; 0x5c341
    TX_FAR _MuseumF2Text6
    db $50

MuseumF2Text7: ; 0x5c346
    TX_FAR _MuseumF2Text7
    db $50

MuseumF2Object: ; 0x5c34b (size=48)
    db $a ; border tile

    db $1 ; warps
    db $7, $7, $4, MUSEUM_1F

    db $2 ; signs
    db $2, $b, $6 ; MuseumF2Text6
    db $5, $2, $7 ; MuseumF2Text7

    db $5 ; people
    db SPRITE_BUG_CATCHER, $7 + 4, $1 + 4, $fe, $2, $1 ; person
    db SPRITE_OLD_PERSON, $5 + 4, $0 + 4, $ff, $d0, $2 ; person
    db SPRITE_OAK_AIDE, $5 + 4, $7 + 4, $ff, $d0, $3 ; person
    db SPRITE_BRUNETTE_GIRL, $5 + 4, $b + 4, $ff, $ff, $4 ; person
    db SPRITE_HIKER, $5 + 4, $c + 4, $ff, $d0, $5 ; person

    ; warp-to
    EVENT_DISP $7, $7, $7 ; MUSEUM_1F

PewterGym_h: ; 0x5c37b to 0x5c387 (12 bytes) (id=54)
    db $07 ; tileset
    db PEWTER_GYM_HEIGHT, PEWTER_GYM_WIDTH ; dimensions (y, x)
    dw PewterGymBlocks, PewterGymTexts, PewterGymScript ; blocks, texts, scripts
    db $00 ; connections

    dw PewterGymObject ; objects

PewterGymScript: ; 0x5c387
    ld hl, $d126
    bit 6, [hl]
    res 6, [hl]
    call nz, $43a4
    call $3c3c
    ld hl, $4441
    ld de, $43ca
    ld a, [$d5fc]
    call $3160
    ld [$d5fc], a
    ret
; 0x5c3a4

INCBIN "baserom.gbc",$5c3a4,$91

PewterGymTexts: ; 0x5c435
    dw PewterGymText1, PewterGymText2, PewterGymText3, PewterGymText4, PewterGymText5, PewterGymText6

INCBIN "baserom.gbc",$5c43b + 6,$13 - 6

PewterGymText1: ; 0x5c44e
    db $08 ; asm
    ld a, [$d755]
    bit 7, a
    jr z, .asm_4a735 ; 0x5c454
    bit 6, a
    jr nz, .asm_ff7d0 ; 0x5c458
    call z, $43df
    call $30b6
    jr .asm_e0ffb ; 0x5c460
.asm_ff7d0 ; 0x5c462
    ld hl, $44a3
    call PrintText
    jr .asm_e0ffb ; 0x5c468
.asm_4a735 ; 0x5c46a
    ld hl, $449e
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $44bc
    ld de, $44bc
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    ld a, $1
    ld [$d05c], a
    xor a
    ldh [$b4], a
    ld a, $3
    ld [$d5fc], a
    ld [$da39], a
.asm_e0ffb ; 0x5c49b
    jp $24d7

UnnamedText_5c49e: ; 0x5c49e
    TX_FAR _UnnamedText_5c49e
    db $50
; 0x5c49e + 5 bytes

UnnamedText_5c4a3: ; 0x5c4a3
    TX_FAR _UnnamedText_5c4a3
    db $50
; 0x5c4a3 + 5 bytes

PewterGymText4: ; 0x5c4a8
    TX_FAR _UnnamedText_5c4a8
    db $50
; 0x5c4a8 + 5 bytes

PewterGymText5: ; 0x5c4ad
INCBIN "baserom.gbc",$5c4ad,6

INCBIN "baserom.gbc",$5c4b3,$5c4b7 - $5c4b3

PewterGymText6: ; 0x5c4b7
INCBIN "baserom.gbc",$5c4b7,5

INCBIN "baserom.gbc",$5c4bc,$5c4c1 - $5c4bc

UnnamedText_5c4c1: ; 0x5c4c1
    TX_FAR _UnnamedText_5c4c1
    db $50
; 0x5c4c1 + 5 bytes

PewterGymText2: ; 0x5c4c6
    db $08 ; asm
    ld hl, $4441
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5c4d0: ; 0x5c4d0
    TX_FAR _UnnamedText_5c4d0
    db $50
; 0x5c4d0 + 5 bytes

UnnamedText_5c4d5: ; 0x5c4d5
    TX_FAR _UnnamedText_5c4d5
    db $50
; 0x5c4d5 + 5 bytes

UnnamedText_5c4da: ; 0x5c4da
    TX_FAR _UnnamedText_5c4da
    db $50
; 0x5c4da + 5 bytes

PewterGymText3: ; 0x5c4df
    db $08 ; asm
    ld a, [$d72a]
    bit 0, a
    jr nz, .asm_71369 ; 0x5c4e5
    ld hl, $4515
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, .asm_6123a ; 0x5c4f4
    ld hl, $451a
    call PrintText
    jr .asm_d1578 ; 0x5c4fc
.asm_6123a ; 0x5c4fe
    ld hl, $4524
    call PrintText
.asm_d1578 ; 0x5c504
    ld hl, $451f
    call PrintText
    jr .asm_07013 ; 0x5c50a
.asm_71369 ; 0x5c50c
    ld hl, $4529
    call PrintText
.asm_07013 ; 0x5c512
    jp $24d7

UnnamedText_5c515: ; 0x5c515
    TX_FAR _UnnamedText_5c515
    db $50
; 0x5c515 + 5 bytes

UnnamedText_5c51a: ; 0x5c51a
    TX_FAR _UnnamedText_5c51a
    db $50
; 0x5c51a + 5 bytes

UnnamedText_5c51f: ; 0x5c51f
    TX_FAR _UnnamedText_5c51f
    db $50
; 0x5c51f + 5 bytes

UnnamedText_5c524: ; 0x5c524
    TX_FAR _UnnamedText_5c524
    db $50
; 0x5c524 + 5 bytes

UnnamedText_5c529: ; 0x5c529
    TX_FAR _UnnamedText_5c529
    db $50
; 0x5c529 + 5 bytes

PewterGymObject: ; 0x5c52e (size=42)
    db $3 ; border tile

    db $2 ; warps
    db $d, $4, $2, $ff
    db $d, $5, $2, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $1 + 4, $4 + 4, $ff, $d0, $41, BROCK + $C8, $1 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $6 + 4, $3 + 4, $ff, $d3, $42, JR__TRAINER_M + $C8, $1 ; trainer
    db SPRITE_GYM_HELPER, $a + 4, $7 + 4, $ff, $d0, $3 ; person

    ; warp-to
    EVENT_DISP $5, $d, $4
    EVENT_DISP $5, $d, $5

PewterGymBlocks: ; 35
    INCBIN "maps/pewtergym.blk"

PewterPokecenter_h: ; 0x5c57b to 0x5c587 (12 bytes) (id=58)
    db $06 ; tileset
    db PEWTER_POKECENTER_HEIGHT, PEWTER_POKECENTER_WIDTH ; dimensions (y, x)
    dw PewterPokecenterBlocks, PewterPokecenterTexts, PewterPokecenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw PewterPokecenterObject ; objects

PewterPokecenterScript: ; 0x5c587
    call $22fa
    jp $3c3c
; 0x5c58d

PewterPokecenterTexts: ; 0x5c58d
    dw PewterPokecenterText1, PewterPokecenterText2, PewterPokecenterText3, PewterPokecenterText4

PewterPokecenterText1: ; 0x5c595
    db $ff

PewterPokecenterText2: ; 0x5c596
    TX_FAR _PewterPokecenterText1
    db $50

PewterPokecenterText3: ; 0x5c59b
    db $8
    ld a, $1
    ld [$cc3c], a
    ld hl, $4603
    call PrintText
    ld a, $ff
    call $23b1
    ld c, $20
    call $3739
    ld hl, $4608
    ld de, $cd3f
    ld bc, $0004
    call CopyData
    ld a, [$c132]
    ld hl, $cd3f
.asm_5c5c3
    cp [hl]
    inc hl
    jr nz, .asm_5c5c3 ; 0x5c5c5 $fc
    dec hl
    push hl
    ld c, $1f
    ld a, $d0
    call $23a1
    pop hl
.asm_5c5d1
    ld a, [hl]
    ld [$c132], a
    push hl
    ld hl, $cd3f
    ld de, $cd3e
    ld bc, $0004
    call CopyData
    ld a, [$cd3e]
    ld [$cd42], a
    pop hl
    ld c, $18
    call $3739
    ld a, [$c026]
    ld b, a
    ld a, [$c027]
    or b
    jr nz, .asm_5c5d1 ; 0x5c5f6 $d9
    ld c, $30
    call $3739
    call $2307
    jp $24d7
; 0x5c603

PewterPokecenterText5: ; broken TX_FAR to _PewterPokecenterText4
    db $17, $44, $47, $26
    db $50

;XXX wtf?
db $30, $38, $34, $3c

PewterPokecenterText4: ; XXX confirm text_id number
    db $f6

PewterPokecenterObject: ; 0x5c60d (size=44)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $6, $ff
    db $7, $4, $6, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_GENTLEMAN, $7 + 4, $b + 4, $ff, $d2, $2 ; person
    db SPRITE_CLEFAIRY, $3 + 4, $1 + 4, $ff, $d0, $3 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

CeruleanPokecenter_h: ; 0x5c639 to 0x5c645 (12 bytes) (id=64)
    db $06 ; tileset
    db CERULEAN_POKECENTER_HEIGHT, CERULEAN_POKECENTER_WIDTH ; dimensions (y, x)
    dw CeruleanPokecenterBlocks, CeruleanPokecenterTexts, CeruleanPokecenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeruleanPokecenterObject ; objects

CeruleanPokecenterScript: ; 0x5c645
    call $22fa
    jp $3c3c
; 0x5c64b

CeruleanPokecenterTexts:
    dw CeruleanPokecenterText1, CeruleanPokecenterText2, CeruleanPokecenterText3, CeruleanPokecenterText4

CeruleanPokecenterText4:
    db $f6

CeruleanPokecenterText1: ; 0x5c654
    db $ff

CeruleanPokecenterText2: ; 0x5c655
    TX_FAR _CeruleanPokecenterText1
    db $50

CeruleanPokecenterText3:
    TX_FAR _CeruleanPokecenterText3
    db $50

CeruleanPokecenterObject: ; 0x5c65f (size=44)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $2, $ff
    db $7, $4, $2, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $5 + 4, $a + 4, $fe, $0, $2 ; person
    db SPRITE_GENTLEMAN, $3 + 4, $4 + 4, $ff, $d0, $3 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

CeruleanPokecenterBlocks: ; 28
    INCBIN "maps/ceruleanpokecenter.blk"

CeruleanGym_h: ; 0x5c6a7 to 0x5c6b3 (12 bytes) (id=65)
    db $07 ; tileset
    db CERULEAN_GYM_HEIGHT, CERULEAN_GYM_WIDTH ; dimensions (y, x)
    dw CeruleanGymBlocks, CeruleanGymTexts, CeruleanGymScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeruleanGymObject ; objects

CeruleanGymScript: ; 0x5c6b3
    ld hl, $d126
    bit 6, [hl]
    res 6, [hl]
    call nz, $46d0
    call $3c3c
    ld hl, $4758
    ld de, $46f8
    ld a, [$d5fd]
    call $3160
    ld [$d5fd], a
    ret
; 0x5c6d0

INCBIN "baserom.gbc",$5c6d0,$7a

CeruleanGymTexts: ; 0x5c74a
    dw CeruleanGymText1, CeruleanGymText2, CeruleanGymText3, CeruleanGymText4, CeruleanGymText5, CeruleanGymText6, CeruleanGymText7

INCBIN "baserom.gbc",$5c752 + 6,$1f - 6

CeruleanGymText1: ; 0x5c771
    db $08 ; asm
    ld a, [$d75e]
    bit 7, a
    jr z, .asm_10854 ; 0x5c777
    bit 6, a
    jr nz, .asm_37a1b ; 0x5c77b
    call z, $470d
    call $30b6
    jr .asm_95b04 ; 0x5c783
.asm_37a1b ; 0x5c785
    ld hl, $47c3
    call PrintText
    jr .asm_95b04 ; 0x5c78b
.asm_10854 ; 0x5c78d
    ld hl, $47be
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $47d8
    ld de, $47d8
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    ld a, $2
    ld [$d05c], a
    xor a
    ldh [$b4], a
    ld a, $3
    ld [$d5fd], a
.asm_95b04 ; 0x5c7bb
    jp $24d7

UnnamedText_5c7be: ; 0x5c7be
    TX_FAR _UnnamedText_5c7be
    db $50
; 0x5c7be + 5 bytes

UnnamedText_5c7c3: ; 0x5c7c3
    TX_FAR _UnnamedText_5c7c3
    db $50
; 0x5c7c3 + 5 bytes

CeruleanGymText5: ; 0x5c7c8
    TX_FAR _UnnamedText_5c7c8
    db $50
; 0x5c7c8 + 5 bytes

CeruleanGymText6: ; 0x5c7cd
INCBIN "baserom.gbc",$5c7cd,4
db $0b
db $50

CeruleanGymText7: ; 0x5c7d3
    TX_FAR _UnnamedText_5c7d3
    db $50
; 0x5c7d3 + 5 bytes

INCBIN "baserom.gbc",$5c7d8,$5c7df - $5c7d8

CeruleanGymText2: ; 0x5c7df
    db $08 ; asm
    ld hl, $4758
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5c7e9: ; 0x5c7e9
    TX_FAR _UnnamedText_5c7e9
    db $50
; 0x5c7e9 + 5 bytes

UnnamedText_5c7ee: ; 0x5c7ee
    TX_FAR _UnnamedText_5c7ee
    db $50
; 0x5c7ee + 5 bytes

UnnamedText_5c7f3: ; 0x5c7f3
    TX_FAR _UnnamedText_5c7f3
    db $50
; 0x5c7f3 + 5 bytes

CeruleanGymText3: ; 0x5c7f8
    db $08 ; asm
    ld hl, $4764
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5c802: ; 0x5c802
    TX_FAR _UnnamedText_5c802
    db $50
; 0x5c802 + 5 bytes

UnnamedText_5c807: ; 0x5c807
    TX_FAR _UnnamedText_5c807
    db $50
; 0x5c807 + 5 bytes

UnnamedText_5c80c: ; 0x5c80c
    TX_FAR _UnnamedText_5c80c
    db $50
; 0x5c80c + 5 bytes

CeruleanGymText4: ; 0x5c811
    db $08 ; asm
    ld a, [$d75e]
    bit 7, a
    jr nz, .asm_f80ce ; 0x5c817
    ld hl, $482a
    call PrintText
    jr .asm_18a31 ; 0x5c81f
.asm_f80ce ; 0x5c821
    ld hl, $482f
    call PrintText
.asm_18a31 ; 0x5c827
    jp $24d7

UnnamedText_5c82a: ; 0x5c82a
    TX_FAR _UnnamedText_5c82a
    db $50
; 0x5c82a + 5 bytes

UnnamedText_5c82f: ; 0x5c82f
    TX_FAR _UnnamedText_5c82f
    db $50
; 0x5c82f + 5 bytes

CeruleanGymObject: ; 0x5c834 (size=50)
    db $3 ; border tile

    db $2 ; warps
    db $d, $4, $3, $ff
    db $d, $5, $3, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_BRUNETTE_GIRL, $2 + 4, $4 + 4, $ff, $d0, $41, MISTY + $C8, $1 ; trainer
    db SPRITE_LASS, $3 + 4, $2 + 4, $ff, $d3, $42, JR__TRAINER_F + $C8, $1 ; trainer
    db SPRITE_SWIMMER, $7 + 4, $8 + 4, $ff, $d2, $43, SWIMMER + $C8, $1 ; trainer
    db SPRITE_GYM_HELPER, $a + 4, $7 + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $5, $d, $4
    EVENT_DISP $5, $d, $5

CeruleanGymBlocks: ; 35
    INCBIN "maps/ceruleangym.blk"

CeruleanMart_h: ; 0x5c889 to 0x5c895 (12 bytes) (id=67)
    db $02 ; tileset
    db CERULEAN_MART_HEIGHT, CERULEAN_MART_WIDTH ; dimensions (y, x)
    dw CeruleanMartBlocks, CeruleanMartTexts, CeruleanMartScript ; blocks, texts, scripts
    db $00 ; connections

    dw CeruleanMartObject ; objects

CeruleanMartScript: ; 0x5c895
    jp $3c3c
; 0x5c898

CeruleanMartTexts: ; 0x5c898
    dw CeruleanMartText1, CeruleanMartText2, CeruleanMartText3

CeruleanMartText2: ; 0x5c89e
    TX_FAR _CeruleanMartText2
    db $50

CeruleanMartText3: ; 0x5c8a3
    TX_FAR _CeruleanMartText3
    db $50

CeruleanMartObject: ; 0x5c8a8 (size=38)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $5, $ff
    db $7, $4, $5, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_MART_GUY, $5 + 4, $0 + 4, $ff, $d3, $1 ; person
    db SPRITE_BLACK_HAIR_BOY_1, $4 + 4, $3 + 4, $fe, $1, $2 ; person
    db SPRITE_LASS, $2 + 4, $6 + 4, $fe, $2, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4

LavenderPokecenter_h: ; 0x5c8ce to 0x5c8da (12 bytes) (id=141)
    db $06 ; tileset
    db LAVENDER_POKECENTER_HEIGHT, LAVENDER_POKECENTER_WIDTH ; dimensions (y, x)
    dw LavenderPokecenterBlocks, LavenderPokecenterTexts, LavenderPokecenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw LavenderPokecenterObject ; objects

LavenderPokecenterScript: ; 0x5c8da
    call $22fa
    jp $3c3c
; 0x5c8e0

LavenderPokecenterTexts:
    dw LavenderPokecenterText1, LavenderPokecenterText2, LavenderPokecenterText3, LavenderPokecenterText4

LavenderPokecenterText4:
    db $f6

LavenderPokecenterText1: ; 0x5c8ea
    db $ff

LavenderPokecenterText2: ; 0x5c8eb
    TX_FAR _LavenderPokecenterText1
    db $50

LavenderPokecenterText3: ; 0x5c8ef
    TX_FAR _LavenderPokecenterText3
    db $50

LavenderPokecenterObject: ; 0x5c8f4 (size=44)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $0, $ff
    db $7, $4, $0, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_GENTLEMAN, $3 + 4, $5 + 4, $ff, $ff, $2 ; person
    db SPRITE_LITTLE_GIRL, $6 + 4, $2 + 4, $fe, $1, $3 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

LavenderMart_h: ; 0x5c920 to 0x5c92c (12 bytes) (id=150)
    db $02 ; tileset
    db LAVENDER_MART_HEIGHT, LAVENDER_MART_WIDTH ; dimensions (y, x)
    dw LavenderMartBlocks, LavenderMartTexts, LavenderMartScript ; blocks, texts, scripts
    db $00 ; connections

    dw LavenderMartObject ; objects

LavenderMartScript: ; 0x5c92c
    jp $3c3c
; 0x5c92f

LavenderMartTexts: ; 0x5c92f
    dw LavenderMartText1, LavenderMartText2, LavenderMartText3

LavenderMartText2: ; 0x5c935
    TX_FAR _LavenderMartText2
    db $50

LavenderMartText3: ; 0x5c93a
    db $08 ; asm
    ld a, [$d7e0]
    bit 7, a
    jr nz, .asm_c88d4 ; 0x5c940
    ld hl, $4953
    call PrintText
    jr .asm_6d225 ; 0x5c948
.asm_c88d4 ; 0x5c94a
    ld hl, $4958
    call PrintText
.asm_6d225 ; 0x5c950
    jp $24d7

UnnamedText_5c953: ; 0x5c953
    TX_FAR _UnnamedText_5c953
    db $50
; 0x5c953 + 5 bytes

UnnamedText_5c958: ; 0x5c958
    TX_FAR _UnnamedText_5c958
    db $50
; 0x5c958 + 5 bytes

LavenderMartObject: ; 0x5c95d (size=38)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $3, $ff
    db $7, $4, $3, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_MART_GUY, $5 + 4, $0 + 4, $ff, $d3, $1 ; person
    db SPRITE_BALDING_GUY, $4 + 4, $3 + 4, $ff, $ff, $2 ; person
    db SPRITE_BLACK_HAIR_BOY_1, $2 + 4, $7 + 4, $ff, $ff, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4

VermilionPokecenter_h: ; 0x5c983 to 0x5c98f (12 bytes) (id=89)
    db $06 ; tileset
    db VERMILION_POKECENTER_HEIGHT, VERMILION_POKECENTER_WIDTH ; dimensions (y, x)
    dw VermilionPokecenterBlocks, VermilionPokecenterTexts, VermilionPokecenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw VermilionPokecenterObject ; objects

VermilionPokecenterScript: ; 0x5c98f
    call $22fa
    jp $3c3c
; 0x5c995

VermilionPokecenterTexts:
    dw VermilionPokecenterText1, VermilionPokecenterText2, VermilionPokecenterText3, VermilionPokecenterText4

VermilionPokecenterText1: ; 0x5c99d
    db $ff

VermilionPokecenterText2: ; 0x5c99e
    TX_FAR _VermilionPokecenterText1
    db $50

VermilionPokecenterText3: ; 0x5c9a3
    TX_FAR _VermilionPokecenterText3
    db $50

VermilionPokecenterText4: ; 0x5c9a8
    db $f6

VermilionPokecenterObject: ; 0x5c9a9 (size=44)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $0, $ff
    db $7, $4, $0, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_FISHER, $5 + 4, $a + 4, $ff, $ff, $2 ; person
    db SPRITE_SAILOR, $4 + 4, $5 + 4, $ff, $ff, $3 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

VermilionMart_h: ; 0x5c9d5 to 0x5c9e1 (12 bytes) (id=91)
    db $02 ; tileset
    db VERMILION_MART_HEIGHT, VERMILION_MART_WIDTH ; dimensions (y, x)
    dw VermilionMartBlocks, VermilionMartTexts, VermilionMartScript ; blocks, texts, scripts
    db $00 ; connections

    dw VermilionMartObject ; objects

VermilionMartScript: ; 0x5c9e1
    jp $3c3c
; 0x5c9e4

VermilionMartTexts: ; 0x5c9e4
    dw VermilionMartText1, VermilionMartText2, VermilionMartText3

VermilionMartText2: ; 0x5c9ea
    TX_FAR _VermilionMartText2
    db $50

VermilionMartText3: ; 0x5c9ef
    TX_FAR _VermilionMartText3
    db $50

VermilionMartObject: ; 0x5c9f4 (size=38)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $2, $ff
    db $7, $4, $2, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_MART_GUY, $5 + 4, $0 + 4, $ff, $d3, $1 ; person
    db SPRITE_BLACK_HAIR_BOY_1, $6 + 4, $5 + 4, $ff, $ff, $2 ; person
    db SPRITE_LASS, $3 + 4, $3 + 4, $fe, $2, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4

VermilionGym_h: ; 0x5ca1a to 0x5ca26 (12 bytes) (id=92)
    db $07 ; tileset
    db VERMILION_GYM_HEIGHT, VERMILION_GYM_WIDTH ; dimensions (y, x)
    dw VermilionGymBlocks, VermilionGymTexts, VermilionGymScript ; blocks, texts, scripts
    db $00 ; connections

    dw VermilionGymObject ; objects

VermilionGymScript: ; 0x5ca26
    ld hl, $d126
    bit 5, [hl]
    res 5, [hl]
    push hl
    call nz, $4a4c
    pop hl
    bit 6, [hl]
    res 6, [hl]
    call nz, $4a6d
    call $3c3c
    ld hl, $4af8
    ld de, $4a95
    ld a, [$d5fe]
    call $3160
    ld [$d5fe], a
    ret
; 0x5ca4c

INCBIN "baserom.gbc",$5ca4c,$9c

VermilionGymTexts: ; 0x5cae8
    dw VermilionGymText1, VermilionGymText2, VermilionGymText3, VermilionGymText4, VermilionGymText5, VermilionGymText6, VermilionGymText7, VermilionGymText8

INCBIN "baserom.gbc",$5caf8,37

VermilionGymText1: ; 0x5cb1d
    db $08 ; asm
    ld a, [$d773]
    bit 7, a
    jr z, .asm_7cc29 ; 0x5cb23
    bit 6, a
    jr nz, .asm_41203 ; 0x5cb27
    call z, $4aaa
    call $30b6
    jr .asm_23621 ; 0x5cb2f
.asm_41203 ; 0x5cb31
    ld hl, $4b72
    call PrintText
    jr .asm_23621 ; 0x5cb37
.asm_7cc29 ; 0x5cb39
    ld hl, $4b6d
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $4b8b
    ld de, $4b8b
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    ld a, $3
    ld [$d05c], a
    xor a
    ldh [$b4], a
    ld a, $3
    ld [$d5fe], a
    ld [$da39], a
.asm_23621 ; 0x5cb6a
    jp $24d7

UnnamedText_5cb6d: ; 0x5cb6d
    TX_FAR _UnnamedText_5cb6d
    db $50
; 0x5cb6d + 5 bytes

UnnamedText_5cb72: ; 0x5cb72
    TX_FAR _UnnamedText_5cb72
    db $50
; 0x5cb72 + 5 bytes

VermilionGymText6:
    TX_FAR _UnnamedText_5cb77
    db $50
; 0x5cb77 + 5 bytes

VermilionGymText7: ; 0x5cb7c

INCBIN "baserom.gbc",$5cb7c,5

UnnamedText_5cb81:
    TX_FAR _UnnamedText_5cb81
    db $50

VermilionGymText8: ; 0x5cb86
    TX_FAR _UnnamedText_5cb86
    db $50

UnnamedText_5cb8b:
    TX_FAR _UnnamedText_5cb8b
    db $50

VermilionGymText2: ; 0x5cb90
    db $08 ; asm
    ld hl, $4af8
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5cb9a: ; 0x5cb9a
    TX_FAR _UnnamedText_5cb9a
    db $50
; 0x5cb9a + 5 bytes

UnnamedText_5cb9f: ; 0x5cb9f
    TX_FAR _UnnamedText_5cb9f
    db $50
; 0x5cb9f + 5 bytes

UnnamedText_5cba4: ; 0x5cba4
    TX_FAR _UnnamedText_5cba4
    db $50
; 0x5cba4 + 5 bytes

VermilionGymText3: ; 0x5cba9
    db $08 ; asm
    ld hl, $4b04
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5cbb3: ; 0x5cbb3
    TX_FAR _UnnamedText_5cbb3
    db $50
; 0x5cbb3 + 5 bytes

UnnamedText_5cbb8: ; 0x5cbb8
    TX_FAR _UnnamedText_5cbb8
    db $50
; 0x5cbb8 + 5 bytes

UnnamedText_5cbbd: ; 0x5cbbd
    TX_FAR _UnnamedText_5cbbd
    db $50
; 0x5cbbd + 5 bytes

VermilionGymText4: ; 0x5cbc2
    db $08 ; asm
    ld hl, $4b10
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5cbcc: ; 0x5cbcc
    TX_FAR _UnnamedText_5cbcc
    db $50
; 0x5cbcc + 5 bytes

UnnamedText_5cbd1: ; 0x5cbd1
    TX_FAR _UnnamedText_5cbd1
    db $50
; 0x5cbd1 + 5 bytes

UnnamedText_5cbd6: ; 0x5cbd6
    TX_FAR _UnnamedText_5cbd6
    db $50
; 0x5cbd6 + 5 bytes

VermilionGymText5: ; 0x5cbdb
    db $08 ; asm
    ld a, [$d72a]
    bit 2, a
    jr nz, .asm_13b67 ; 0x5cbe1
    ld hl, $4bf4
    call PrintText
    jr .asm_c2b38 ; 0x5cbe9
.asm_13b67 ; 0x5cbeb
    ld hl, $4bf9
    call PrintText
.asm_c2b38 ; 0x5cbf1
    jp $24d7

UnnamedText_5cbf4: ; 0x5cbf4
    TX_FAR _UnnamedText_5cbf4
    db $50
; 0x5cbf4 + 5 bytes

UnnamedText_5cbf9: ; 0x5cbf9
    TX_FAR _UnnamedText_5cbf9
    db $50
; 0x5cbf9 + 5 bytes

VermilionGymObject: ; 0x5cbfe (size=58)
    db $3 ; border tile

    db $2 ; warps
    db $11, $4, $3, $ff
    db $11, $5, $3, $ff

    db $0 ; signs

    db $5 ; people
    db SPRITE_ROCKER, $1 + 4, $5 + 4, $ff, $d0, $41, LT__SURGE + $C8, $1 ; trainer
    db SPRITE_GENTLEMAN, $6 + 4, $9 + 4, $ff, $d2, $42, GENTLEMAN + $C8, $3 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $8 + 4, $3 + 4, $ff, $d2, $43, ROCKER + $C8, $1 ; trainer
    db SPRITE_SAILOR, $a + 4, $0 + 4, $ff, $d3, $44, SAILOR + $C8, $8 ; trainer
    db SPRITE_GYM_HELPER, $e + 4, $4 + 4, $ff, $d0, $5 ; person

    ; warp-to
    EVENT_DISP $5, $11, $4
    EVENT_DISP $5, $11, $5

VermilionGymBlocks: ; 45
    INCBIN "maps/vermiliongym.blk"

CopycatsHouseF2_h: ; 0x5cc65 to 0x5cc71 (12 bytes) (id=176)
    db $04 ; tileset
    db COPYCATS_HOUSE_2F_HEIGHT, COPYCATS_HOUSE_2F_WIDTH ; dimensions (y, x)
    dw CopycatsHouseF2Blocks, CopycatsHouseF2Texts, CopycatsHouseF2Script ; blocks, texts, scripts
    db $00 ; connections

    dw CopycatsHouseF2Object ; objects

CopycatsHouseF2Script: ; 0x5cc71
    jp $3c3c
; 0x5cc74

CopycatsHouseF2Texts: ; 0x5cc74
    dw CopycatsHouseF2Text1, CopycatsHouseF2Text2, CopycatsHouseF2Text3, CopycatsHouseF2Text4, CopycatsHouseF2Text5, CopycatsHouseF2Text6, CopycatsHouseF2Text7

CopycatsHouseF2Text1: ; 0x5cc82
    db $08 ; asm
    ld a, [$d7af]
    bit 0, a
    jr nz, .asm_7ccf3 ; 0x5cc88
    ld a, $1
    ld [$cc3c], a
    ld hl, $4cd4
    call PrintText
    ld b,POKE_DOLL
    call $3493
    jr z, .asm_62ecd ; 0x5cc9a
    ld hl, $4cd9
    call PrintText
    ld bc,(TM_31 << 8) | 1
    call $3e2e
    jr nc, .asm_16690 ; 0x5cca8
    ld hl, $4cde
    call PrintText
    ld a, $33
    ldh [$db], a
    ld b, $5 ; BANK(MyFunction)
    ld hl, $7f37 ; MyFunction
    call Bankswitch
    ld hl, $d7af
    set 0, [hl]
    jr .asm_62ecd ; 0x5ccc1
.asm_16690 ; 0x5ccc3
    ld hl, $4cee
    call PrintText
    jr .asm_62ecd ; 0x5ccc9
.asm_7ccf3 ; 0x5cccb
    ld hl, $4ce9
    call PrintText
.asm_62ecd ; 0x5ccd1
    jp $24d7

UnnamedText_5ccd4: ; 0x5ccd4
    TX_FAR _UnnamedText_5ccd4
    db $50
; 0x5ccd4 + 5 bytes

UnnamedText_5ccd9: ; 0x5ccd9
    TX_FAR _UnnamedText_5ccd9
    db $50
; 0x5ccd9 + 5 bytes

INCBIN "baserom.gbc",$5ccde,$5cce9 - $5ccde

UnnamedText_5cce9: ; 0x5cce9
    TX_FAR _UnnamedText_5cce9
    db $50
; 0x5cce9 + 5 bytes

INCBIN "baserom.gbc",$5ccee,$6

CopycatsHouseF2Text2: ; 0x5ccf4
    TX_FAR _CopycatsHouseF2Text2
    db $50

CopycatsHouseF2Text5:
CopycatsHouseF2Text4:
CopycatsHouseF2Text3: ; 0x5ccf9
    TX_FAR _CopycatsHouseF2Text3
    db $50

CopycatsHouseF2Text6: ; 0x5ccfe
    TX_FAR _CopycatsHouseF2Text6
    db $50

CopycatsHouseF2Text7: ; 0x5cd03
    db $08 ; asm
    ld a, [$c109]
    cp $4
    ld hl, $4d1c
    jr nz, .asm_399a4 ; 0x5cd0c
    ld hl, $4d17
.asm_399a4 ; 0x5cd11
    call PrintText
    jp $24d7

UnnamedText_5cd17: ; 0x5cd17
    TX_FAR _UnnamedText_5cd17
    db $50
; 0x5cd17 + 5 bytes

UnnamedText_5cd1c: ; 0x5cd1c
    TX_FAR _UnnamedText_5cd1c
    db $50
; 0x5cd1c + 5 bytes

CopycatsHouseF2Object: ; 0x5cd21 (size=48)
    db $a ; border tile

    db $1 ; warps
    db $1, $7, $2, COPYCATS_HOUSE_1F

    db $2 ; signs
    db $5, $3, $6 ; CopycatsHouseF2Text6
    db $1, $0, $7 ; CopycatsHouseF2Text7

    db $5 ; people
    db SPRITE_BRUNETTE_GIRL, $3 + 4, $4 + 4, $fe, $0, $1 ; person
    db SPRITE_BIRD, $6 + 4, $4 + 4, $fe, $2, $2 ; person
    db SPRITE_SLOWBRO, $1 + 4, $5 + 4, $ff, $d0, $3 ; person
    db SPRITE_BIRD, $0 + 4, $2 + 4, $ff, $d0, $4 ; person
    db SPRITE_CLEFAIRY, $6 + 4, $1 + 4, $ff, $d3, $5 ; person

    ; warp-to
    EVENT_DISP $4, $1, $7 ; COPYCATS_HOUSE_1F

FightingDojo_h: ; 0x5cd51 to 0x5cd5d (12 bytes) (id=177)
    db $05 ; tileset
    db FIGHTINGDOJO_HEIGHT, FIGHTINGDOJO_WIDTH ; dimensions (y, x)
    dw FightingDojoBlocks, FightingDojoTexts, FightingDojoScript ; blocks, texts, scripts
    db $00 ; connections

    dw FightingDojoObject ; objects

FightingDojoScript: ; 0x5cd5d
    call $3c3c
    ld hl, $4e13
    ld de, $4d7b
    ld a, [$d642]
    call $3160
    ld [$d642], a
    ret
; 0x5cd70

INCBIN "baserom.gbc",$5cd70,$93

FightingDojoTexts: ; 0x5ce03
    dw FightingDojoText1, FightingDojoText2, FightingDojoText3, FightingDojoText4, FightingDojoText5, FightingDojoText6, FightingDojoText7, FightingDojoText8

INCBIN "baserom.gbc",$5ce13,$31

FightingDojoText1: ; 0x5ce44
    db $08 ; asm
    ld a, [$d7b1]
    bit 0, a
    jp nz, $4e7d
    bit 1, a
    jp nz, $4e85
    ld hl, $4e8e
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $4e93
    ld de, $4e93
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    ld a, $3
    ld [$d642], a
    ld [$da39], a
    jr .asm_9dba4 ; 0x5ce7b
    ld hl, $4e9d
    call PrintText
    jr .asm_9dba4 ; 0x5ce83
    ld hl, $4e98
    call PrintText
.asm_9dba4 ; 0x5ce8b
    jp $24d7

UnnamedText_5ce8e: ; 0x5ce8e
    TX_FAR _UnnamedText_5ce8e
    db $50
; 0x5ce8e + 5 bytes

UnnamedText_5ce93: ; 0x5ce93
    TX_FAR _UnnamedText_5ce93
    db $50
; 0x5ce93 + 5 bytes

FightingDojoText8: ; 0x5ce98
    TX_FAR _UnnamedText_5ce98
    db $50
; 0x5ce98 + 5 bytes

UnnamedText_5ce9d: ; 0x5ce9d
    TX_FAR _UnnamedText_5ce9d
    db $50
; 0x5ce9d + 5 bytes

FightingDojoText2: ; 0x5cea2
    db $08 ; asm
    ld hl, $4e13
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5ceac: ; 0x5ceac
    TX_FAR _UnnamedText_5ceac
    db $50
; 0x5ceac + 5 bytes

UnnamedText_5ceb1: ; 0x5ceb1
    TX_FAR _UnnamedText_5ceb1
    db $50
; 0x5ceb1 + 5 bytes

UnnamedText_5ceb6: ; 0x5ceb6
    TX_FAR _UnnamedText_5ceb6
    db $50
; 0x5ceb6 + 5 bytes

FightingDojoText3: ; 0x5cebb
    db $08 ; asm
    ld hl, $4e1f
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5cec5: ; 0x5cec5
    TX_FAR _UnnamedText_5cec5
    db $50
; 0x5cec5 + 5 bytes

UnnamedText_5ceca: ; 0x5ceca
    TX_FAR _UnnamedText_5ceca
    db $50
; 0x5ceca + 5 bytes

UnnamedText_5cecf: ; 0x5cecf
    TX_FAR _UnnamedText_5cecf
    db $50
; 0x5cecf + 5 bytes

FightingDojoText4: ; 0x5ced4
    db $08 ; asm
    ld hl, $4e2b
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5cede: ; 0x5cede
    TX_FAR _UnnamedText_5cede
    db $50
; 0x5cede + 5 bytes

UnnamedText_5cee3: ; 0x5cee3
    TX_FAR _UnnamedText_5cee3
    db $50
; 0x5cee3 + 5 bytes

UnnamedText_5cee8: ; 0x5cee8
    TX_FAR _UnnamedText_5cee8
    db $50
; 0x5cee8 + 5 bytes

FightingDojoText5: ; 0x5ceed
    db $08 ; asm
    ld hl, $4e37
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5cef7: ; 0x5cef7
    TX_FAR _UnnamedText_5cef7
    db $50
; 0x5cef7 + 5 bytes

UnnamedText_5cefc: ; 0x5cefc
    TX_FAR _UnnamedText_5cefc
    db $50
; 0x5cefc + 5 bytes

UnnamedText_5cf01: ; 0x5cf01
    TX_FAR _UnnamedText_5cf01
    db $50
; 0x5cf01 + 5 bytes

FightingDojoText6: ; 0x5cf06
    db $08 ; asm
    ld a, [$d7b1]
    and $c0
    jr z, .asm_f8e28 ; 0x5cf0c
    ld hl, $4f96
    call PrintText
    jr .asm_3a2c8 ; 0x5cf14
.asm_f8e28 ; 0x5cf16
    ld a, $2b
    call $349b
    ld hl, $4f49
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, .asm_3a2c8 ; 0x5cf28
    ld a, [$cf91]
    ld b, a
	ld c,30
    call GivePokemon
    jr nc, .asm_3a2c8 ; 0x5cf33
    ld a, $4a
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld hl, $d7b1
    set 6, [hl]
    set 0, [hl]
.asm_3a2c8 ; 0x5cf46
    jp $24d7

UnnamedText_5cf49: ; 0x5cf49
    TX_FAR _UnnamedText_5cf49
    db $50
; 0x5cf49 + 5 bytes

FightingDojoText7: ; 0x5cf4e
    db $08 ; asm
    ld a, [$d7b1]
    and $c0
    jr z, .asm_170a9 ; 0x5cf54
    ld hl, $4f96
    call PrintText
    jr .asm_f1f47 ; 0x5cf5c
.asm_170a9 ; 0x5cf5e
    ld a, $2c
    call $349b
    ld hl, $4f91
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, .asm_f1f47 ; 0x5cf70
    ld a, [$cf91]
    ld b, a
	ld c,30
    call GivePokemon
    jr nc, .asm_f1f47 ; 0x5cf7b
    ld hl, $d7b1
    set 7, [hl]
    set 0, [hl]
    ld a, $4b
    ld [$cc4d], a
    ld a, $11
    call Predef
.asm_f1f47 ; 0x5cf8e
    jp $24d7

UnnamedText_5cf91: ; 0x5cf91
    TX_FAR _UnnamedText_5cf91
    db $50
; 0x5cf91 + 5 bytes

UnnamedText_5cf96: ; 0x5cf96
    TX_FAR _UnnamedText_5cf96
    db $50
; 0x5cf96 + 5 bytes

FightingDojoObject: ; 0x5cf9b (size=72)
    db $3 ; border tile

    db $2 ; warps
    db $b, $4, $1, $ff
    db $b, $5, $1, $ff

    db $0 ; signs

    db $7 ; people
    db SPRITE_HIKER, $3 + 4, $5 + 4, $ff, $d0, $41, BLACKBELT + $C8, $1 ; trainer
    db SPRITE_HIKER, $4 + 4, $3 + 4, $ff, $d3, $42, BLACKBELT + $C8, $2 ; trainer
    db SPRITE_HIKER, $6 + 4, $3 + 4, $ff, $d3, $43, BLACKBELT + $C8, $3 ; trainer
    db SPRITE_HIKER, $5 + 4, $5 + 4, $ff, $d2, $44, BLACKBELT + $C8, $4 ; trainer
    db SPRITE_HIKER, $7 + 4, $5 + 4, $ff, $d2, $45, BLACKBELT + $C8, $5 ; trainer
    db SPRITE_BALL, $1 + 4, $4 + 4, $ff, $ff, $6 ; person
    db SPRITE_BALL, $1 + 4, $5 + 4, $ff, $ff, $7 ; person

    ; warp-to
    EVENT_DISP $5, $b, $4
    EVENT_DISP $5, $b, $5

FightingDojoBlocks: ; 30
    INCBIN "maps/fightingdojo.blk"

SaffronGym_h: ; 0x5d001 to 0x5d00d (12 bytes) (id=178)
    db $16 ; tileset
    db SAFFRON_GYM_HEIGHT, SAFFRON_GYM_WIDTH ; dimensions (y, x)
    dw SaffronGymBlocks, SaffronGymTexts, SaffronGymScript ; blocks, texts, scripts
    db $00 ; connections

    dw SaffronGymObject ; objects

SaffronGymScript: ; 0x5d00d
    ld hl, $d126
    bit 6, [hl]
    res 6, [hl]
    call nz, $502a
    call $3c3c
    ld hl, $50c3
    ld de, $5053
    ld a, [$d65c]
    call $3160
    ld [$d65c], a
    ret
; 0x5d02a

INCBIN "baserom.gbc",$5d02a,$81

SaffronGymTexts: ; 0x5d0ab
    dw SaffronGymText1, SaffronGymText2, SaffronGymText3, SaffronGymText4, SaffronGymText5, SaffronGymText6, SaffronGymText7, SaffronGymText8, SaffronGymText9, SaffronGymText10, SaffronGymText11, SaffronGymText12

INCBIN "baserom.gbc",$5d0bd + 6,$5b - 6

SaffronGymText1: ; 0x5d118
    db $08 ; asm
    ld a, [$d7b3]
    bit 1, a
    jr z, .asm_e3544 ; 0x5d11e
    bit 0, a
    jr nz, .asm_8d2f6 ; 0x5d122
    call z, $5068
    call $30b6
    jr .asm_34c2c ; 0x5d12a
.asm_8d2f6 ; 0x5d12c
    ld hl, $516e
    call PrintText
    jr .asm_34c2c ; 0x5d132
.asm_e3544 ; 0x5d134
    ld hl, $5162
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $5167
    ld de, $5167
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    ld a, $6
    ld [$d05c], a
    ld a, $3
    ld [$d65c], a
.asm_34c2c ; 0x5d15f
    jp $24d7

UnnamedText_5d162: ; 0x5d162
    TX_FAR _UnnamedText_5d162
    db $50
; 0x5d162 + 5 bytes

INCBIN "baserom.gbc",$5d167,$5d16e - $5d167

UnnamedText_5d16e: ; 0x5d16e
    TX_FAR _UnnamedText_5d16e
    db $50
; 0x5d16e + 5 bytes

SaffronGymText10: ; 0x5d173
    TX_FAR _UnnamedText_5d173
    db $50
; 0x5d173 + 5 bytes

SaffronGymText11: ; 0x5d178

INCBIN "baserom.gbc",$5d178,5

INCBIN "baserom.gbc",$5d17d,$5d182 - $5d17d

SaffronGymText12: ; 0x5d182
    TX_FAR _UnnamedText_5d182
    db $50
; 0x5d182 + 5 bytes

SaffronGymText2: ; 0x5d187
    db $08 ; asm
    ld hl, $50c3
    call LoadTrainerHeader
    jp $24d7

SaffronGymText3: ; 0x5d191
    db $08 ; asm
    ld hl, $50cf
    call LoadTrainerHeader
    jp $24d7

SaffronGymText4: ; 0x5d19b
    db $08 ; asm
    ld hl, $50db
    call LoadTrainerHeader
    jp $24d7

SaffronGymText5: ; 0x5d1a5
    db $08 ; asm
    ld hl, $50e7
    call LoadTrainerHeader
    jp $24d7

SaffronGymText6: ; 0x5d1af
    db $08 ; asm
    ld hl, $50f3
    call LoadTrainerHeader
    jp $24d7

SaffronGymText7: ; 0x5d1b9
    db $08 ; asm
    ld hl, $50ff
    call LoadTrainerHeader
    jp $24d7

SaffronGymText8: ; 0x5d1c3
    db $08 ; asm
    ld hl, $510b
    call LoadTrainerHeader
    jp $24d7

SaffronGymText9: ; 0x5d1cd
    db $08 ; asm
    ld a, [$d7b3]
    bit 1, a
    jr nz, .asm_13f3c ; 0x5d1d3
    ld hl, $51e6
    call PrintText
    jr .asm_e9907 ; 0x5d1db
.asm_13f3c ; 0x5d1dd
    ld hl, $51eb
    call PrintText
.asm_e9907 ; 0x5d1e3
    jp $24d7

UnnamedText_5d1e6: ; 0x5d1e6
    TX_FAR _UnnamedText_5d1e6
    db $50
; 0x5d1e6 + 5 bytes

UnnamedText_5d1eb: ; 0x5d1eb
    TX_FAR _UnnamedText_5d1eb
    db $50
; 0x5d1eb + 5 bytes

UnnamedText_5d1f0: ; 0x5d1f0
    TX_FAR _UnnamedText_5d1f0
    db $50
; 0x5d1f0 + 5 bytes

UnnamedText_5d1f5: ; 0x5d1f5
    TX_FAR _UnnamedText_5d1f5
    db $50
; 0x5d1f5 + 5 bytes

UnnamedText_5d1fa: ; 0x5d1fa
    TX_FAR _UnnamedText_5d1fa
    db $50
; 0x5d1fa + 5 bytes

UnnamedText_5d1ff: ; 0x5d1ff
    TX_FAR _UnnamedText_5d1ff
    db $50
; 0x5d1ff + 5 bytes

UnnamedText_5d204: ; 0x5d204
    TX_FAR _UnnamedText_5d204
    db $50
; 0x5d204 + 5 bytes

UnnamedText_5d209: ; 0x5d209
    TX_FAR _UnnamedText_5d209
    db $50
; 0x5d209 + 5 bytes

UnnamedText_5d20e: ; 0x5d20e
    TX_FAR _UnnamedText_5d20e
    db $50
; 0x5d20e + 5 bytes

UnnamedText_5d213: ; 0x5d213
    TX_FAR _UnnamedText_5d213
    db $50
; 0x5d213 + 5 bytes

UnnamedText_5d218: ; 0x5d218
    TX_FAR _UnnamedText_5d218
    db $50
; 0x5d218 + 5 bytes

UnnamedText_5d21d: ; 0x5d21d
    TX_FAR _UnnamedText_5d21d
    db $50
; 0x5d21d + 5 bytes

UnnamedText_5d222: ; 0x5d222
    TX_FAR _UnnamedText_5d222
    db $50
; 0x5d222 + 5 bytes

UnnamedText_5d227: ; 0x5d227
    TX_FAR _UnnamedText_5d227
    db $50
; 0x5d227 + 5 bytes

UnnamedText_5d22c: ; 0x5d22c
    TX_FAR _UnnamedText_5d22c
    db $50
; 0x5d22c + 5 bytes

UnnamedText_5d231: ; 0x5d231
    TX_FAR _UnnamedText_5d231
    db $50
; 0x5d231 + 5 bytes

UnnamedText_5d236: ; 0x5d236
    TX_FAR _UnnamedText_5d236
    db $50
; 0x5d236 + 5 bytes

UnnamedText_5d23b: ; 0x5d23b
    TX_FAR _UnnamedText_5d23b
    db $50
; 0x5d23b + 5 bytes

UnnamedText_5d240: ; 0x5d240
    TX_FAR _UnnamedText_5d240
    db $50
; 0x5d240 + 5 bytes

UnnamedText_5d245: ; 0x5d245
    TX_FAR _UnnamedText_5d245
    db $50
; 0x5d245 + 5 bytes

UnnamedText_5d24a: ; 0x5d24a
    TX_FAR _UnnamedText_5d24a
    db $50
; 0x5d24a + 5 bytes

UnnamedText_5d24f: ; 0x5d24f
    TX_FAR _UnnamedText_5d24f
    db $50
; 0x5d24f + 5 bytes

UnnamedText_5d254: ; 0x5d254
    TX_FAR _UnnamedText_5d254
    db $50
; 0x5d254 + 5 bytes

SaffronGymObject: ; 0x5d259 (size=330)
    db $2e ; border tile

    db $20 ; warps
    db $11, $8, $2, $ff
    db $11, $9, $2, $ff
    db $3, $1, $16, SAFFRON_GYM
    db $3, $5, $f, SAFFRON_GYM
    db $5, $1, $12, SAFFRON_GYM
    db $5, $5, $8, SAFFRON_GYM
    db $9, $1, $1b, SAFFRON_GYM
    db $9, $5, $10, SAFFRON_GYM
    db $b, $1, $5, SAFFRON_GYM
    db $b, $5, $d, SAFFRON_GYM
    db $f, $1, $17, SAFFRON_GYM
    db $f, $5, $1e, SAFFRON_GYM
    db $11, $1, $11, SAFFRON_GYM
    db $11, $5, $9, SAFFRON_GYM
    db $3, $9, $1a, SAFFRON_GYM
    db $3, $b, $3, SAFFRON_GYM
    db $5, $9, $7, SAFFRON_GYM
    db $5, $b, $c, SAFFRON_GYM
    db $b, $b, $4, SAFFRON_GYM
    db $f, $b, $1f, SAFFRON_GYM
    db $3, $f, $18, SAFFRON_GYM
    db $3, $13, $1c, SAFFRON_GYM
    db $5, $f, $2, SAFFRON_GYM
    db $5, $13, $a, SAFFRON_GYM
    db $9, $f, $14, SAFFRON_GYM
    db $9, $13, $1d, SAFFRON_GYM
    db $b, $f, $e, SAFFRON_GYM
    db $b, $13, $6, SAFFRON_GYM
    db $f, $f, $15, SAFFRON_GYM
    db $f, $13, $19, SAFFRON_GYM
    db $11, $f, $b, SAFFRON_GYM
    db $11, $13, $13, SAFFRON_GYM

    db $0 ; signs

    db $9 ; people
    db SPRITE_GIRL, $8 + 4, $9 + 4, $ff, $d0, $41, SABRINA + $C8, $1 ; trainer
    db SPRITE_MEDIUM, $1 + 4, $a + 4, $ff, $d0, $42, CHANNELER + $C8, $16 ; trainer
    db SPRITE_BUG_CATCHER, $1 + 4, $11 + 4, $ff, $d0, $43, PSYCHIC_TR + $C8, $1 ; trainer
    db SPRITE_MEDIUM, $7 + 4, $3 + 4, $ff, $d0, $44, CHANNELER + $C8, $17 ; trainer
    db SPRITE_BUG_CATCHER, $7 + 4, $11 + 4, $ff, $d0, $45, PSYCHIC_TR + $C8, $2 ; trainer
    db SPRITE_MEDIUM, $d + 4, $3 + 4, $ff, $d0, $46, CHANNELER + $C8, $18 ; trainer
    db SPRITE_BUG_CATCHER, $d + 4, $11 + 4, $ff, $d0, $47, PSYCHIC_TR + $C8, $3 ; trainer
    db SPRITE_BUG_CATCHER, $1 + 4, $3 + 4, $ff, $d0, $48, PSYCHIC_TR + $C8, $4 ; trainer
    db SPRITE_GYM_HELPER, $f + 4, $a + 4, $ff, $d0, $9 ; person

    ; warp-to
    EVENT_DISP $a, $11, $8
    EVENT_DISP $a, $11, $9
    EVENT_DISP $a, $3, $1 ; SAFFRON_GYM
    EVENT_DISP $a, $3, $5 ; SAFFRON_GYM
    EVENT_DISP $a, $5, $1 ; SAFFRON_GYM
    EVENT_DISP $a, $5, $5 ; SAFFRON_GYM
    EVENT_DISP $a, $9, $1 ; SAFFRON_GYM
    EVENT_DISP $a, $9, $5 ; SAFFRON_GYM
    EVENT_DISP $a, $b, $1 ; SAFFRON_GYM
    EVENT_DISP $a, $b, $5 ; SAFFRON_GYM
    EVENT_DISP $a, $f, $1 ; SAFFRON_GYM
    EVENT_DISP $a, $f, $5 ; SAFFRON_GYM
    EVENT_DISP $a, $11, $1 ; SAFFRON_GYM
    EVENT_DISP $a, $11, $5 ; SAFFRON_GYM
    EVENT_DISP $a, $3, $9 ; SAFFRON_GYM
    EVENT_DISP $a, $3, $b ; SAFFRON_GYM
    EVENT_DISP $a, $5, $9 ; SAFFRON_GYM
    EVENT_DISP $a, $5, $b ; SAFFRON_GYM
    EVENT_DISP $a, $b, $b ; SAFFRON_GYM
    EVENT_DISP $a, $f, $b ; SAFFRON_GYM
    EVENT_DISP $a, $3, $f ; SAFFRON_GYM
    EVENT_DISP $a, $3, $13 ; SAFFRON_GYM
    EVENT_DISP $a, $5, $f ; SAFFRON_GYM
    EVENT_DISP $a, $5, $13 ; SAFFRON_GYM
    EVENT_DISP $a, $9, $f ; SAFFRON_GYM
    EVENT_DISP $a, $9, $13 ; SAFFRON_GYM
    EVENT_DISP $a, $b, $f ; SAFFRON_GYM
    EVENT_DISP $a, $b, $13 ; SAFFRON_GYM
    EVENT_DISP $a, $f, $f ; SAFFRON_GYM
    EVENT_DISP $a, $f, $13 ; SAFFRON_GYM
    EVENT_DISP $a, $11, $f ; SAFFRON_GYM
    EVENT_DISP $a, $11, $13 ; SAFFRON_GYM

SaffronGymBlocks: ; 90
    INCBIN "maps/saffrongym.blk"

SaffronMart_h: ; 0x5d3fd to 0x5d409 (12 bytes) (id=180)
    db $02 ; tileset
    db SAFFRON_MART_HEIGHT, SAFFRON_MART_WIDTH ; dimensions (y, x)
    dw SaffronMartBlocks, SaffronMartTexts, SaffronMartScript ; blocks, texts, scripts
    db $00 ; connections

    dw SaffronMartObject ; objects

SaffronMartScript: ; 0x5d409
    jp $3c3c
; 0x5d40c

SaffronMartTexts: ; 0x5d40c
    dw SaffronMartText1, SaffronMartText2, SaffronMartText3

SaffronMartText2: ; 0x5d412
    TX_FAR _SaffronMartText2
    db $50

SaffronMartText3: ; 0x5d417
    TX_FAR _SaffronMartText3
    db $50

SaffronMartObject: ; 0x5d41c (size=38)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $4, $ff
    db $7, $4, $4, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_MART_GUY, $5 + 4, $0 + 4, $ff, $d3, $1 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $2 + 4, $4 + 4, $ff, $ff, $2 ; person
    db SPRITE_LASS, $5 + 4, $6 + 4, $fe, $0, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4

SilphCo1_h: ; 0x5d442 to 0x5d44e (12 bytes) (id=181)
    db $16 ; tileset
    db SILPH_CO_1F_HEIGHT, SILPH_CO_1F_WIDTH ; dimensions (y, x)
    dw SilphCo1Blocks, SilphCo1Texts, SilphCo1Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo1Object ; objects

SilphCo1Script: ; 0x5d44e
    call $3c3c
    ld a, [$d838]
    bit 7, a
    ret z
    ld hl, $d7b9
    bit 7, [hl]
    set 7, [hl]
    ret nz
    ld a, $4c
    ld [$cc4d], a
    ld a, $15
    jp $3e6d
; 0x5d469

SilphCo1Texts: ; 0x5d469
    dw SilphCo1Text1

SilphCo1Text1: ; 0x5d46b
    TX_FAR _SilphCo1Text1
    db $50

SilphCo1Object: ; 0x5d470 (size=50)
    db $2e ; border tile

    db $5 ; warps
    db $11, $a, $5, $ff
    db $11, $b, $5, $ff
    db $0, $1a, $0, SILPH_CO_2F
    db $0, $14, $0, SILPH_CO_ELEVATOR
    db $a, $10, $6, SILPH_CO_3F

    db $0 ; signs

    db $1 ; people
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $4 + 4, $ff, $d0, $1 ; person

    ; warp-to
    EVENT_DISP $f, $11, $a
    EVENT_DISP $f, $11, $b
    EVENT_DISP $f, $0, $1a ; SILPH_CO_2F
    EVENT_DISP $f, $0, $14 ; SILPH_CO_ELEVATOR
    EVENT_DISP $f, $a, $10 ; SILPH_CO_3F

SilphCo1Blocks: ; 135
    INCBIN "maps/silphco1.blk"

SaffronPokecenter_h: ; 0x5d529 to 0x5d535 (12 bytes) (id=182)
    db $06 ; tileset
    db SAFFRON_POKECENTER_HEIGHT, SAFFRON_POKECENTER_WIDTH ; dimensions (y, x)
    dw SaffronPokecenterBlocks, SaffronPokecenterTexts, SaffronPokecenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw SaffronPokecenterObject ; objects

SaffronPokecenterScript: ; 0x5d535
    call $22fa
    jp $3c3c
; 0x5d53b

SaffronPokecenterTexts:
    dw SaffronPokecenterText1, SaffronPokecenterText2, SaffronPokecenterText3, SaffronPokecenterText4

SaffronPokecenterText1: ; 0x5d542
    db $ff

SaffronPokecenterText2: ; 0x5d543
    TX_FAR _SaffronPokecenterText1

INCBIN "baserom.gbc",$5d548,$5d549 - $5d548

SaffronPokecenterText3: ; 0x5d549
    TX_FAR _SaffronPokecenterText3
    db $50

SaffronPokecenterText4:
    db $f6

SaffronPokecenterObject: ; 0x5d54f (size=44)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $6, $ff
    db $7, $4, $6, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_FOULARD_WOMAN, $5 + 4, $5 + 4, $ff, $ff, $2 ; person
    db SPRITE_GENTLEMAN, $3 + 4, $8 + 4, $ff, $d0, $3 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

ViridianForestexit_h: ; 0x5d57b to 0x5d587 (12 bytes) (id=47)
    db $09 ; tileset
    db VIRIDIAN_FOREST_EXIT_HEIGHT, VIRIDIAN_FOREST_EXIT_WIDTH ; dimensions (y, x)
    dw ViridianForestexitBlocks, ViridianForestexitTexts, ViridianForestexitScript ; blocks, texts, scripts
    db $00 ; connections

    dw ViridianForestexitObject ; objects

ViridianForestexitScript: ; 0x5d587
    jp $3c3c
; 0x5d58a

ViridianForestexitTexts: ; 0x5d58a
    dw ViridianForestexitText1, ViridianForestexitText2

ViridianForestexitText1: ; 0x5d58e
    TX_FAR _ViridianForestexitText1
    db $50

ViridianForestexitText2: ; 0x5d593
    TX_FAR _ViridianForestexitText2
    db $50

ViridianForestexitObject: ; 0x5d598 (size=48)
    db $a ; border tile

    db $4 ; warps
    db $0, $4, $1, $ff
    db $0, $5, $1, $ff
    db $7, $4, $0, VIRIDIAN_FOREST
    db $7, $5, $0, VIRIDIAN_FOREST

    db $0 ; signs

    db $2 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $2 + 4, $3 + 4, $ff, $ff, $1 ; person
    db SPRITE_OLD_PERSON, $5 + 4, $2 + 4, $ff, $ff, $2 ; person

    ; warp-to
    EVENT_DISP $5, $0, $4
    EVENT_DISP $5, $0, $5
    EVENT_DISP $5, $7, $4 ; VIRIDIAN_FOREST
    EVENT_DISP $5, $7, $5 ; VIRIDIAN_FOREST

Route2Gate_h: ; 0x5d5c8 to 0x5d5d4 (12 bytes) (id=49)
    db $0c ; tileset
    db ROUTE_2_GATE_HEIGHT, ROUTE_2_GATE_WIDTH ; dimensions (y, x)
    dw Route2GateBlocks, Route2GateTexts, Route2GateScript ; blocks, texts, scripts
    db $00 ; connections

    dw Route2GateObject ; objects

Route2GateScript: ; 0x5d5d4
    jp $3c3c
; 0x5d5d7

Route2GateTexts: ; 0x5d5d7
    dw Route2GateText1, Route2GateText2

Route2GateText1: ; 0x5d5db
    db $08 ; asm
    ld a, [$d7c2]
    bit 0, a
    jr nz, .asm_6592c ; 0x5d5e1
    ld a, $a
    ldh [$db], a
    ld a, $c8
    ldh [$dc], a
    ld [$d11e], a
    call GetItemName ; $2fcf
    ld hl, $cd6d
    ld de, $cc5b
    ld bc, $000d
    call CopyData
    ld a, $62
    call Predef
    ldh a, [$db]
    cp $1
    jr nz, .asm_ad646 ; 0x5d606
    ld hl, $d7c2
    set 0, [hl]
.asm_6592c ; 0x5d60d
    ld hl, $5616
    call PrintText
.asm_ad646 ; 0x5d613
    jp $24d7

UnnamedText_5d616: ; 0x5d616
    TX_FAR _UnnamedText_5d616
    db $50
; 0x5d616 + 5 bytes

Route2GateText2: ; 0x5d61b
    TX_FAR _Route2GateText2
    db $50

Route2GateObject: ; 0x5d620 (size=48)
    db $a ; border tile

    db $4 ; warps
    db $0, $4, $3, $ff
    db $0, $5, $3, $ff
    db $7, $4, $4, $ff
    db $7, $5, $4, $ff

    db $0 ; signs

    db $2 ; people
    db SPRITE_OAK_AIDE, $4 + 4, $1 + 4, $ff, $d2, $1 ; person
    db SPRITE_BUG_CATCHER, $4 + 4, $5 + 4, $fe, $2, $2 ; person

    ; warp-to
    EVENT_DISP $5, $0, $4
    EVENT_DISP $5, $0, $5
    EVENT_DISP $5, $7, $4
    EVENT_DISP $5, $7, $5

ViridianForestEntrance_h: ; 0x5d650 to 0x5d65c (12 bytes) (id=50)
    db $09 ; tileset
    db VIRIDIAN_FOREST_ENTRANCE_HEIGHT, VIRIDIAN_FOREST_ENTRANCE_WIDTH ; dimensions (y, x)
    dw ViridianForestEntranceBlocks, ViridianForestEntranceTexts, ViridianForestEntranceScript ; blocks, texts, scripts
    db $00 ; connections

    dw ViridianForestEntranceObject ; objects

ViridianForestEntranceScript: ; 0x5d65c
    jp $3c3c
; 0x5d65f

ViridianForestEntranceTexts: ; 0x5d65f
    dw ViridianForestEntranceText1, ViridianForestEntranceText2

ViridianForestEntranceText1: ; 0x5d663
    TX_FAR _ViridianForestEntranceText1
    db $50

ViridianForestEntranceText2: ; 0x5d668
    TX_FAR _ViridianForestEntranceText2
    db $50

ViridianForestEntranceObject: ; 0x5d66d (size=48)
    db $a ; border tile

    db $4 ; warps
    db $0, $4, $3, VIRIDIAN_FOREST
    db $0, $5, $4, VIRIDIAN_FOREST
    db $7, $4, $5, $ff
    db $7, $5, $5, $ff

    db $0 ; signs

    db $2 ; people
    db SPRITE_GIRL, $4 + 4, $8 + 4, $ff, $d2, $1 ; person
    db SPRITE_LITTLE_GIRL, $4 + 4, $2 + 4, $fe, $1, $2 ; person

    ; warp-to
    EVENT_DISP $5, $0, $4 ; VIRIDIAN_FOREST
    EVENT_DISP $5, $0, $5 ; VIRIDIAN_FOREST
    EVENT_DISP $5, $7, $4
    EVENT_DISP $5, $7, $5

UndergroundTunnelEntranceRoute5_h: ; 0x5d69d to 0x5d6a9 (12 bytes) (id=71)
    db $0c ; tileset
    db PATH_ENTRANCE_ROUTE_5_HEIGHT, PATH_ENTRANCE_ROUTE_5_WIDTH ; dimensions (y, x)
    dw UndergroundTunnelEntranceRoute5Blocks, UndergroundTunnelEntranceRoute5Texts, UndergroundTunnelEntranceRoute5Script ; blocks, texts, scripts
    db $00 ; connections

    dw UndergroundTunnelEntranceRoute5Object ; objects

UndergroundTunnelEntranceRoute5Script: ; 0x5d6a9
    ld a, $10
    ld [$d365], a
    ret
; 0x5d6af

INCBIN "baserom.gbc",$5d6af,$1

UndergroundTunnelEntranceRoute5Texts: ; 0x5d6b0
    dw UndergroundTunnelEntranceRoute5Text1

UndergroundTunnelEntranceRoute5Text1: ; 0x5d6b2
    db $08 ; asm
    ld a, $9
    ld [W_WHICHTRADE], a
    ld a, $54
    call Predef
    ld hl, $56af
    ret

UndergroundTunnelEntranceRoute5Object: ; 0x5d6c1 (size=34)
    db $a ; border tile

    db $3 ; warps
    db $7, $3, $3, $ff
    db $7, $4, $3, $ff
    db $4, $4, $0, UNDERGROUND_PATH_NS

    db $0 ; signs

    db $1 ; people
    db SPRITE_LITTLE_GIRL, $3 + 4, $2 + 4, $ff, $ff, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4
    EVENT_DISP $4, $4, $4 ; UNDERGROUND_PATH_NS

UndergroundTunnelEntranceRoute6_h: ; 0x5d6e3 to 0x5d6ef (12 bytes) (id=74)
    db $0c ; tileset
    db PATH_ENTRANCE_ROUTE_6_HEIGHT, PATH_ENTRANCE_ROUTE_6_WIDTH ; dimensions (y, x)
    dw UndergroundTunnelEntranceRoute6Blocks, UndergroundTunnelEntranceRoute6Texts, UndergroundTunnelEntranceRoute6Script ; blocks, texts, scripts
    db $00 ; connections

    dw UndergroundTunnelEntranceRoute6Object ; objects

UndergroundTunnelEntranceRoute6Script: ; 0x5d6ef
    ld a, $11
    ld [$d365], a
    jp $3c3c
; 0x5d6f7

UndergroundTunnelEntranceRoute6Texts: ; 0x5d6f7
    dw UndergroundTunnelEntranceRoute6Text1

;XXX wtf? syntax error on TX_FAR?
UndergroundTunnelEntranceRoute6Text1: ; 0x5d6f9
    db $17, $cb, $40, $23
    ;TX_FAR _UndergroundTunnelEntranceRoute6Text1 ; $cb, $40, $23
    db $50

UndergroundTunnelEntranceRoute6Object: ; 0x5d6fe (size=34)
    db $a ; border tile

    db $3 ; warps
    db $7, $3, $3, $ff
    db $7, $4, $3, $ff
    db $4, $4, $1, UNDERGROUND_PATH_NS

    db $0 ; signs

    db $1 ; people
    db SPRITE_GIRL, $3 + 4, $2 + 4, $ff, $ff, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4
    EVENT_DISP $4, $4, $4 ; UNDERGROUND_PATH_NS

UndergroundPathEntranceRoute7_h: ; 0x5d720 to 0x5d72c (12 bytes) (id=77)
    db $0c ; tileset
    db PATH_ENTRANCE_ROUTE_7_HEIGHT, PATH_ENTRANCE_ROUTE_7_WIDTH ; dimensions (y, x)
    dw UndergroundTunnelEntranceRoute7Blocks, UndergroundPathEntranceRoute7Texts, UndergroundPathEntranceRoute7Script ; blocks, texts, scripts
    db $00 ; connections

    dw UndergroundPathEntranceRoute7Object ; objects

UndergroundPathEntranceRoute7Script: ; 0x5d72c
    ld a, $12
    ld [$d365], a
    jp $3c3c
; 0x5d734

UndergroundPathEntranceRoute7Texts: ; 0x5d734
    dw UndergroundPathEntranceRoute7Text1

UndergroundPathEntranceRoute7Text1: ; 0x5d736
    db $17, $ff, $40, $23
    ;TX_FAR _UndergroundPathEntranceRoute7Text1
    db $50

UndergroundPathEntranceRoute7Object: ; 0x5d73b (size=34)
    db $a ; border tile

    db $3 ; warps
    db $7, $3, $4, $ff
    db $7, $4, $4, $ff
    db $4, $4, $0, UNDERGROUND_PATH_WE

    db $0 ; signs

    db $1 ; people
    db SPRITE_FAT_BALD_GUY, $4 + 4, $2 + 4, $ff, $ff, $1 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4
    EVENT_DISP $4, $4, $4 ; UNDERGROUND_PATH_WE

INCBIN "baserom.gbc",$5d75d,$5d773 - $5d75d

UnnamedText_5d773: ; 0x5d773
    TX_FAR _UnnamedText_5d773
    db $50
; 0x5d773 + 5 bytes

UnnamedText_5d778: ; 0x5d778
    TX_FAR _UnnamedText_5d778
    db $50
; 0x5d778 + 5 bytes

UnnamedText_5d77d: ; 0x5d77d
    TX_FAR _UnnamedText_5d77d
    db $50
; 0x5d77d + 5 bytes

UnnamedText_5d782: ; 0x5d782
    TX_FAR _UnnamedText_5d782
    db $50
; 0x5d782 + 5 bytes

INCBIN "baserom.gbc",$5d787,$28

SilphCo9_h: ; 0x5d7af to 0x5d7bb (12 bytes) (id=233)
    db $16 ; tileset
    db SILPH_CO_9F_HEIGHT, SILPH_CO_9F_WIDTH ; dimensions (y, x)
    dw SilphCo9Blocks, SilphCo9Texts, SilphCo9Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo9Object ; objects

SilphCo9Script: ; 0x5d7bb
    call $57d1
    call $3c3c
    ld hl, $5893
    ld de, $5885
    ld a, [$d64a]
    call $3160
    ld [$d64a], a
    ret
; 0x5d7d1

INCBIN "baserom.gbc",$5d7d1,$ba

SilphCo9Texts: ; 0x5d88b
    dw SilphCo9Text1, SilphCo9Text2, SilphCo9Text3, SilphCo9Text4

INCBIN "baserom.gbc",$5d893,$25

SilphCo9Text1: ; 0x5d8b8
    db $08 ; asm
    ld a, [$d838]
    bit 7, a
    jr nz, .asm_a14c3 ; 0x5d8be
    ld hl, $58e5
    call PrintText
    ld a, $7
    call Predef
    call $20d8
    call Delay3
    call $20f6
    ld hl, $58ea
    call PrintText
    jr .asm_b6e28 ; 0x5d8da
.asm_a14c3 ; 0x5d8dc
    ld hl, $58ef
    call PrintText
.asm_b6e28 ; 0x5d8e2
    jp $24d7

UnnamedText_5d8e5: ; 0x5d8e5
    TX_FAR _UnnamedText_5d8e5
    db $50
; 0x5d8e5 + 5 bytes

UnnamedText_5d8ea: ; 0x5d8ea
    TX_FAR _UnnamedText_5d8ea
    db $50
; 0x5d8ea + 5 bytes

UnnamedText_5d8ef: ; 0x5d8ef
    TX_FAR _UnnamedText_5d8ef
    db $50
; 0x5d8ef + 5 bytes

SilphCo9Text2: ; 0x5d8f4
    db $08 ; asm
    ld hl, $5893
    call LoadTrainerHeader
    jp $24d7

SilphCo9Text3: ; 0x5d8fe
    db $08 ; asm
    ld hl, $589f
    call LoadTrainerHeader
    jp $24d7

SilphCo9Text4: ; 0x5d908
    db $08 ; asm
    ld hl, $58ab
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5d912: ; 0x5d912
    TX_FAR _UnnamedText_5d912
    db $50
; 0x5d912 + 5 bytes

UnnamedText_5d917: ; 0x5d917
    TX_FAR _UnnamedText_5d917
    db $50
; 0x5d917 + 5 bytes

UnnamedText_5d91c: ; 0x5d91c
    TX_FAR _UnnamedText_5d91c
    db $50
; 0x5d91c + 5 bytes

UnnamedText_5d921: ; 0x5d921
    TX_FAR _UnnamedText_5d921
    db $50
; 0x5d921 + 5 bytes

UnnamedText_5d926: ; 0x5d926
    TX_FAR _UnnamedText_5d926
    db $50
; 0x5d926 + 5 bytes

UnnamedText_5d92b: ; 0x5d92b
    TX_FAR _UnnamedText_5d92b
    db $50
; 0x5d92b + 5 bytes

UnnamedText_5d930: ; 0x5d930
    TX_FAR _UnnamedText_5d930
    db $50
; 0x5d930 + 5 bytes

UnnamedText_5d935: ; 0x5d935
    TX_FAR _UnnamedText_5d935
    db $50
; 0x5d935 + 5 bytes

UnnamedText_5d93a: ; 0x5d93a
    TX_FAR _UnnamedText_5d93a
    db $50
; 0x5d93a + 5 bytes

SilphCo9Object: ; 0x5d93f (size=74)
    db $2e ; border tile

    db $5 ; warps
    db $0, $e, $0, SILPH_CO_10F
    db $0, $10, $0, SILPH_CO_8F
    db $0, $12, $0, SILPH_CO_ELEVATOR
    db $3, $9, $7, SILPH_CO_3F
    db $f, $11, $4, SILPH_CO_5F

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $e + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_ROCKET, $4 + 4, $2 + 4, $ff, $d1, $42, ROCKET + $C8, $25 ; trainer
    db SPRITE_OAK_AIDE, $d + 4, $15 + 4, $ff, $d0, $43, SCIENTIST + $C8, $a ; trainer
    db SPRITE_ROCKET, $10 + 4, $d + 4, $ff, $d1, $44, ROCKET + $C8, $26 ; trainer

    ; warp-to
    EVENT_DISP $d, $0, $e ; SILPH_CO_10F
    EVENT_DISP $d, $0, $10 ; SILPH_CO_8F
    EVENT_DISP $d, $0, $12 ; SILPH_CO_ELEVATOR
    EVENT_DISP $d, $3, $9 ; SILPH_CO_3F
    EVENT_DISP $d, $f, $11 ; SILPH_CO_5F

SilphCo9Blocks: ; 117
    INCBIN "maps/silphco9.blk"

VictoryRoad1_h: ; 0x5d9fe to 0x5da0a (12 bytes) (id=108)
    db $11 ; tileset
    db VICTORY_ROAD_1_HEIGHT, VICTORY_ROAD_1_WIDTH ; dimensions (y, x)
    dw VictoryRoad1Blocks, VictoryRoad1Texts, VictoryRoad1Script ; blocks, texts, scripts
    db $00 ; connections

    dw VictoryRoad1Object ; objects

VictoryRoad1Script: ; 0x5da0a
    ld hl, $d126
    bit 5, [hl]
    res 5, [hl]
    call nz, $5a27
    call $3c3c
    ld hl, $5a6d
    ld de, $5a3a
    ld a, [$d651]
    call $3160
    ld [$d651], a
    ret
; 0x5da27

INCBIN "baserom.gbc",$5da27,$38

VictoryRoad1Texts: ; 0x5da5f
    dw VictoryRoad1Text1, VictoryRoad1Text2, VictoryRoad1Text3, VictoryRoad1Text4, VictoryRoad1Text5, VictoryRoad1Text6, VictoryRoad1Text7

INCBIN "baserom.gbc",$5da6d,$19

VictoryRoad1Text1: ; 0x5da86
    db $08 ; asm
    ld hl, $5a6d
    call LoadTrainerHeader
    jp $24d7

VictoryRoad1Text2: ; 0x5da90
    db $08 ; asm
    ld hl, $5a79
    call LoadTrainerHeader
    jp $24d7

UnnamedText_5da9a: ; 0x5da9a
    TX_FAR _UnnamedText_5da9a
    db $50
; 0x5da9a + 5 bytes

UnnamedText_5da9f: ; 0x5da9f
    TX_FAR _UnnamedText_5da9f
    db $50
; 0x5da9f + 5 bytes

UnnamedText_5daa4: ; 0x5daa4
    TX_FAR _UnnamedText_5daa4
    db $50
; 0x5daa4 + 5 bytes

UnnamedText_5daa9: ; 0x5daa9
    TX_FAR _UnnamedText_5daa9
    db $50
; 0x5daa9 + 5 bytes

UnnamedText_5daae: ; 0x5daae
    TX_FAR _UnnamedText_5daae
    db $50
; 0x5daae + 5 bytes

UnnamedText_5dab3: ; 0x5dab3
    TX_FAR _UnnamedText_5dab3
    db $50
; 0x5dab3 + 5 bytes

VictoryRoad1Object: ; 0x5dab8 (size=76)
    db $7d ; border tile

    db $3 ; warps
    db $11, $8, $2, $ff
    db $11, $9, $2, $ff
    db $1, $1, $0, VICTORY_ROAD_2

    db $0 ; signs

    db $7 ; people
    db SPRITE_LASS, $5 + 4, $7 + 4, $ff, $d3, $41, COOLTRAINER_F + $C8, $5 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $2 + 4, $3 + 4, $ff, $d0, $42, COOLTRAINER_M + $C8, $5 ; trainer
	db SPRITE_BALL, $0 + 4, $b + 4, $ff, $ff, $83, TM_43 ; item
	db SPRITE_BALL, $2 + 4, $9 + 4, $ff, $ff, $84, RARE_CANDY ; item
    db SPRITE_BOULDER, $f + 4, $5 + 4, $ff, $10, $5 ; person
    db SPRITE_BOULDER, $2 + 4, $e + 4, $ff, $10, $6 ; person
    db SPRITE_BOULDER, $a + 4, $2 + 4, $ff, $10, $7 ; person

    ; warp-to
    EVENT_DISP $a, $11, $8
    EVENT_DISP $a, $11, $9
    EVENT_DISP $a, $1, $1 ; VICTORY_ROAD_2

VictoryRoad1Blocks: ; 90
    INCBIN "maps/victoryroad1.blk"

INCBIN "baserom.gbc",$5db5e,$5db81 - $5db5e

UnnamedText_5db81: ; 0x5db81
    TX_FAR _UnnamedText_5db81
    db $50
; 0x5db81 + 5 bytes

INCBIN "baserom.gbc",$5db86,$5dba8 - $5db86

UnnamedText_5dba8: ; 0x5dba8
    TX_FAR _UnnamedText_5dba8
    db $50
; 0x5dba8 + 5 bytes

INCBIN "baserom.gbc",$5dbad,$5dbbe - $5dbad

UnnamedText_5dbbe: ; 0x5dbbe
    TX_FAR _UnnamedText_5dbbe
    db $50
; 0x5dbbe + 5 bytes

INCBIN "baserom.gbc",$5dbc3,$5dbd4 - $5dbc3

UnnamedText_5dbd4: ; 0x5dbd4
    TX_FAR _UnnamedText_5dbd4
    db $50
; 0x5dbd4 + 5 bytes

INCBIN "baserom.gbc",$5dbd9,$5dc9e - $5dbd9

UnnamedText_5dc9e: ; 0x5dc9e
    TX_FAR _UnnamedText_5dc9e
    db $50
; 0x5dc9e + 5 bytes

UnnamedText_5dca3: ; 0x5dca3
    TX_FAR _UnnamedText_5dca3
    db $50
; 0x5dca3 + 5 bytes

INCBIN "baserom.gbc",$5dca8,$5dcde - $5dca8

UnnamedText_5dcde: ; 0x5dcde
    TX_FAR _UnnamedText_5dcde
    db $50
; 0x5dcde + 5 bytes

UnnamedText_5dce3: ; 0x5dce3
    TX_FAR _UnnamedText_5dce3
    db $50
; 0x5dce3 + 5 bytes

UnnamedText_5dce8: ; 0x5dce8
    TX_FAR _UnnamedText_5dce8
    db $50
; 0x5dce8 + 5 bytes

INCBIN "baserom.gbc",$5dced,$5dda2 - $5dced

UnnamedText_5dda2: ; 0x5dda2
    TX_FAR _UnnamedText_5dda2
    db $50
; 0x5dda2 + 5 bytes

UnnamedText_5dda7: ; 0x5dda7
    TX_FAR _UnnamedText_5dda7
    db $50
; 0x5dda7 + 5 bytes

INCBIN "baserom.gbc",$5ddac,$5ddd6 - $5ddac

UnnamedText_5ddd6: ; 0x5ddd6
    TX_FAR _UnnamedText_5ddd6
    db $50
; 0x5ddd6 + 5 bytes

UnnamedText_5dddb: ; 0x5dddb
    TX_FAR _UnnamedText_5dddb
    db $50
; 0x5dddb + 5 bytes

UnnamedText_5dde0: ; 0x5dde0
    TX_FAR _UnnamedText_5dde0
    db $50
; 0x5dde0 + 5 bytes

UnnamedText_5dde5: ; 0x5dde5
    TX_FAR _UnnamedText_5dde5
    db $50
; 0x5dde5 + 5 bytes

UnnamedText_5ddea: ; 0x5ddea
    TX_FAR _UnnamedText_5ddea
    db $50
; 0x5ddea + 5 bytes

INCBIN "baserom.gbc",$5ddef,$5ddf7 - $5ddef

UnnamedText_5ddf7: ; 0x5ddf7
    TX_FAR _UnnamedText_5ddf7
    db $50
; 0x5ddf7 + 5 bytes

INCBIN "baserom.gbc",$5ddfc,$5dedb - $5ddfc

UnnamedText_5dedb: ; 0x5dedb
    TX_FAR _UnnamedText_5dedb
    db $50
; 0x5dedb + 5 bytes

INCBIN "baserom.gbc",$5dee0,$2120

SECTION "bank18",DATA,BANK[$18]

ViridianForestBlocks:
    INCBIN "maps/viridianforest.blk"

UndergroundPathNSBlocks: ; 96
    INCBIN "maps/undergroundpathns.blk"

INCBIN "baserom.gbc",$601f8,$1c8

SSAnne10Blocks:
SSAnne9Blocks: ; 96
    INCBIN "maps/ssanne9.blk"

PokemonTower1_h: ; 0x60420 to 0x6042c (12 bytes) (id=142)
    db $0f ; tileset
    db POKEMONTOWER_1_HEIGHT, POKEMONTOWER_1_WIDTH ; dimensions (y, x)
    dw PokemonTower1Blocks, PokemonTower1Texts, PokemonTower1Script ; blocks, texts, scripts
    db $00 ; connections

    dw PokemonTower1Object ; objects

PokemonTower1Script: ; 0x6042c
    jp $3c3c
; 0x6042f

PokemonTower1Texts: ; 0x6042f
    dw PokemonTower1Text1, PokemonTower1Text2, PokemonTower1Text3, PokemonTower1Text4, PokemonTower1Text5

PokemonTower1Text1: ; 0x60439
    TX_FAR _PokemonTower1Text1
    db $50

PokemonTower1Text2: ; 0x6043e
    TX_FAR _PokemonTower1Text2
    db $50

PokemonTower1Text3: ; 0x60443
    TX_FAR _PokemonTower1Text3
    db $50

PokemonTower1Text4: ; 0x60448
    TX_FAR _PokemonTower1Text4
    db $50

PokemonTower1Text5: ; 0x6044d
    TX_FAR _PokemonTower1Text5
    db $50

PokemonTower1Object: ; 0x60452 (size=58)
    db $1 ; border tile

    db $3 ; warps
    db $11, $a, $1, $ff
    db $11, $b, $1, $ff
    db $9, $12, $1, POKEMONTOWER_2

    db $0 ; signs

    db $5 ; people
    db SPRITE_CABLE_CLUB_WOMAN, $d + 4, $f + 4, $ff, $d1, $1 ; person
    db SPRITE_MOM_GEISHA, $8 + 4, $6 + 4, $ff, $ff, $2 ; person
    db SPRITE_BALDING_GUY, $c + 4, $8 + 4, $ff, $ff, $3 ; person
    db SPRITE_GIRL, $7 + 4, $d + 4, $ff, $ff, $4 ; person
    db SPRITE_MEDIUM, $7 + 4, $11 + 4, $ff, $d2, $5 ; person

    ; warp-to
    EVENT_DISP $a, $11, $a
    EVENT_DISP $a, $11, $b
    EVENT_DISP $a, $9, $12 ; POKEMONTOWER_2

PokemonTower1Blocks: ; 90
    INCBIN "maps/pokemontower1.blk"

PokemonTower2_h: ; 0x604e6 to 0x604f2 (12 bytes) (id=143)
    db $0f ; tileset
    db POKEMONTOWER_2_HEIGHT, POKEMONTOWER_2_WIDTH ; dimensions (y, x)
    dw PokemonTower2Blocks, PokemonTower2Texts, PokemonTower2Script ; blocks, texts, scripts
    db $00 ; connections

    dw PokemonTower2Object ; objects

PokemonTower2Script: ; 0x604f2
    call $3c3c
    ld hl, $4509
    ld a, [$d62b]
    jp $3d97
; 0x604fe

INCBIN "baserom.gbc",$604fe,$60509 - $604fe

PokemonTower2Scripts: ; 0x60509
    dw PokemonTower2Script0, PokemonTower2Script1, PokemonTower2Script2

PokemonTower2Script0: ; 0x6050f
    ld a, [$d764]
    bit 7, a
    ret nz
    ld hl, $455e
    call $34bf
    ret nc
    ld a, $ff
    ld [$c0ee], a
    call $23b1
    ld c, $2
    ld a, $de
    call $23a1
    ld hl, $d764
    res 6, [hl]
    ld a, [$cd3d]
    cp $1
    ld a, $8
    ld b, $0
    jr nz, .asm_60544 ; 0x60539 $9
    ld hl, $d764
    set 6, [hl]
    ld a, $2
    ld b, $c
.asm_60544
    ld [$d528], a
    ld a, $1
    ld [$ff00+$8c], a
    ld a, b
    ld [$ff00+$8d], a
    call $34a6
    ld a, $1
    ld [$ff00+$8c], a
    call $2920
    xor a
    ld [$ff00+$b4], a
    ld [$ff00+$b3], a
    ret
; 0x6055e

INCBIN "baserom.gbc",$6055e,$60563 - $6055e

PokemonTower2Script1: ; 0x60563
    ld a, [$d057]
    cp $ff
    jp z, $44fe
    ld a, $f0
    ld [$cd6b], a
    ld hl, $d764
    set 7, [hl]
    ld a, $1
    ld [$ff00+$8c], a
    call $2920
    ld de, $45b2
    ld a, [$d764]
    bit 6, a
    jr nz, .asm_60589 ; 0x60584 $3
    ld de, $45a9
.asm_60589
    ld a, $1
    ld [$ff00+$8c], a
    call $363a
    ld a, $ff
    ld [$c0ee], a
    call $23b1
    ld b, $2
    ld hl, $5b47
    call Bankswitch
    ld a, $2
    ld [$d62b], a
    ld [$da39], a
    ret
; 0x605a9

INCBIN "baserom.gbc",$605a9,$605bb - $605a9

PokemonTower2Script2: ; 0x605bb
    ld a, [$d730]
    bit 0, a
    ret nz
    ld a, $38
    ld [$cc4d], a
    ld a, $11
    call Predef
    xor a
    ld [$cd6b], a
    call $2307
    ld a, $0
    ld [$d62b], a
    ld [$da39], a
    ret
; 0x605db

PokemonTower2Texts: ; 0x605db
    dw PokemonTower2Text1, PokemonTower2Text2

PokemonTower2Text1: ; 0x605df
    db $08 ; asm
    ld a, [$d764]
    bit 7, a
    jr z, .asm_16f24 ; 0x605e5
    ld hl, $463c
    call PrintText
    jr .asm_41852 ; 0x605ed
.asm_16f24 ; 0x605ef
    ld hl, $462d
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $4632
    ld de, $4637
    call $3354
    ld a, $f2
    ld [$d059], a
    ld a, [$d715]
    cp $b1
    jr nz, .asm_0860c ; 0x6060f
    ld a, $4
    jr .asm_99cea ; 0x60613
.asm_0860c ; 0x60615
    cp $99
    jr nz, .asm_b3e6e ; 0x60617
    ld a, $5
    jr .asm_99cea ; 0x6061b
.asm_b3e6e ; 0x6061d
    ld a, $6
.asm_99cea ; 0x6061f
    ld [$d05d], a
    ld a, $1
    ld [$d62b], a
    ld [$da39], a
.asm_41852 ; 0x6062a
    jp $24d7

UnnamedText_6062d: ; 0x6062d
    TX_FAR _UnnamedText_6062d
    db $50
; 0x6062d + 5 bytes

UnnamedText_60632: ; 0x60632
    TX_FAR _UnnamedText_60632
    db $50
; 0x60632 + 5 bytes

UnnamedText_60637: ; 0x60637
    TX_FAR _UnnamedText_60637
    db $50
; 0x60637 + 5 bytes

UnnamedText_6063c: ; 0x6063c
    TX_FAR _UnnamedText_6063c
    db $50
; 0x6063c + 5 bytes

PokemonTower2Text2: ; 0x60641
    TX_FAR _PokemonTower2Text2
    db $50

PokemonTower2Object: ; 0x60646 (size=32)
    db $1 ; border tile

    db $2 ; warps
    db $9, $3, $0, POKEMONTOWER_3
    db $9, $12, $2, POKEMONTOWER_1

    db $0 ; signs

    db $2 ; people
    db SPRITE_BLUE, $5 + 4, $e + 4, $ff, $ff, $1 ; person
    db SPRITE_MEDIUM, $7 + 4, $3 + 4, $ff, $d3, $2 ; person

    ; warp-to
    EVENT_DISP $a, $9, $3 ; POKEMONTOWER_3
    EVENT_DISP $a, $9, $12 ; POKEMONTOWER_1

PokemonTower2Blocks: ; 90
    INCBIN "maps/pokemontower2.blk"

PokemonTower3_h: ; 0x606c0 to 0x606cc (12 bytes) (id=144)
    db $0f ; tileset
    db POKEMONTOWER_3_HEIGHT, POKEMONTOWER_3_WIDTH ; dimensions (y, x)
    dw PokemonTower3Blocks, PokemonTower3Texts, PokemonTower3Script ; blocks, texts, scripts
    db $00 ; connections

    dw PokemonTower3Object ; objects

PokemonTower3Script: ; 0x606cc
    call $3c3c
    ld hl, $46ed
    ld de, $46df
    ld a, [$d62c]
    call $3160
    ld [$d62c], a
    ret
; 0x606df

INCBIN "baserom.gbc",$606df,$6

PokemonTower3Texts: ; 0x606e5
    dw PokemonTower3Text1, PokemonTower3Text2, PokemonTower3Text3, PokemonTower3Text4

INCBIN "baserom.gbc",$606ed,$25

PokemonTower3Text1: ; 0x60712
    db $08 ; asm
    ld hl, $46ed
    call LoadTrainerHeader
    jp $24d7

PokemonTower3Text2: ; 0x6071c
    db $08 ; asm
    ld hl, $46f9
    call LoadTrainerHeader
    jp $24d7

PokemonTower3Text3: ; 0x60726
    db $08 ; asm
    ld hl, $4705
    call LoadTrainerHeader
    jp $24d7

UnnamedText_60730: ; 0x60730
    TX_FAR _UnnamedText_60730
    db $50
; 0x60730 + 5 bytes

UnnamedText_60735: ; 0x60735
    TX_FAR _UnnamedText_60735
    db $50
; 0x60735 + 5 bytes

UnnamedText_6073a: ; 0x6073a
    TX_FAR _UnnamedText_6073a
    db $50
; 0x6073a + 5 bytes

UnnamedText_6073f: ; 0x6073f
    TX_FAR _UnnamedText_6073f
    db $50
; 0x6073f + 5 bytes

UnnamedText_60744: ; 0x60744
    TX_FAR _UnnamedText_60744
    db $50
; 0x60744 + 5 bytes

UnnamedText_60749: ; 0x60749
    TX_FAR _UnnamedText_60749
    db $50
; 0x60749 + 5 bytes

UnnamedText_6074e: ; 0x6074e
    TX_FAR _UnnamedText_6074e
    db $50
; 0x6074e + 5 bytes

UnnamedText_60753: ; 0x60753
    TX_FAR _UnnamedText_60753
    db $50
; 0x60753 + 5 bytes

UnnamedText_60758: ; 0x60758
    TX_FAR _UnnamedText_60758
    db $50
; 0x60758 + 5 bytes

PokemonTower3Object: ; 0x6075d (size=51)
    db $1 ; border tile

    db $2 ; warps
    db $9, $3, $0, POKEMONTOWER_2
    db $9, $12, $1, POKEMONTOWER_4

    db $0 ; signs

    db $4 ; people
    db SPRITE_MEDIUM, $3 + 4, $c + 4, $ff, $d2, $41, CHANNELER + $C8, $5 ; trainer
    db SPRITE_MEDIUM, $8 + 4, $9 + 4, $ff, $d0, $42, CHANNELER + $C8, $6 ; trainer
    db SPRITE_MEDIUM, $d + 4, $a + 4, $ff, $d0, $43, CHANNELER + $C8, $8 ; trainer
	db SPRITE_BALL, $1 + 4, $c + 4, $ff, $ff, $84, ESCAPE_ROPE ; item

    ; warp-to
    EVENT_DISP $a, $9, $3 ; POKEMONTOWER_2
    EVENT_DISP $a, $9, $12 ; POKEMONTOWER_4

PokemonTower3Blocks: ; 90
    INCBIN "maps/pokemontower3.blk"

PokemonTower4_h: ; 0x607ea to 0x607f6 (12 bytes) (id=145)
    db $0f ; tileset
    db POKEMONTOWER_4_HEIGHT, POKEMONTOWER_4_WIDTH ; dimensions (y, x)
    dw PokemonTower4Blocks, PokemonTower4Texts, PokemonTower4Script ; blocks, texts, scripts
    db $00 ; connections

    dw PokemonTower4Object ; objects

PokemonTower4Script: ; 0x607f6
    call $3c3c
    ld hl, $481b
    ld de, $4809
    ld a, [$d62d]
    call $3160
    ld [$d62d], a
    ret
; 0x60809

INCBIN "baserom.gbc",$60809,$6

PokemonTower4Texts: ; 0x6080f
    dw PokemonTower4Text1, PokemonTower4Text2, PokemonTower4Text3, PokemonTower4Text4, PokemonTower4Text5, PokemonTower4Text6

INCBIN "baserom.gbc",$6081b,$25

PokemonTower4Text1: ; 0x60840
    db $08 ; asm
    ld hl, $481b
    call LoadTrainerHeader
    jp $24d7

PokemonTower4Text2: ; 0x6084a
    db $08 ; asm
    ld hl, $4827
    call LoadTrainerHeader
    jp $24d7

PokemonTower4Text3: ; 0x60854
    db $08 ; asm
    ld hl, $4833
    call LoadTrainerHeader
    jp $24d7

UnnamedText_6085e: ; 0x6085e
    TX_FAR _UnnamedText_6085e
    db $50
; 0x6085e + 5 bytes

UnnamedText_60863: ; 0x60863
    TX_FAR _UnnamedText_60863
    db $50
; 0x60863 + 5 bytes

UnnamedText_60868: ; 0x60868
    TX_FAR _UnnamedText_60868
    db $50
; 0x60868 + 5 bytes

UnnamedText_6086d: ; 0x6086d
    TX_FAR _UnnamedText_6086d
    db $50
; 0x6086d + 5 bytes

UnnamedText_60872: ; 0x60872
    TX_FAR _UnnamedText_60872
    db $50
; 0x60872 + 5 bytes

UnnamedText_60877: ; 0x60877
    TX_FAR _UnnamedText_60877
    db $50
; 0x60877 + 5 bytes

UnnamedText_6087c: ; 0x6087c
    TX_FAR _UnnamedText_6087c
    db $50
; 0x6087c + 5 bytes

UnnamedText_60881: ; 0x60881
    TX_FAR _UnnamedText_60881
    db $50
; 0x60881 + 5 bytes

UnnamedText_60886: ; 0x60886
    TX_FAR _UnnamedText_60886
    db $50
; 0x60886 + 5 bytes

PokemonTower4Object: ; 0x6088b (size=65)
    db $1 ; border tile

    db $2 ; warps
    db $9, $3, $0, POKEMONTOWER_5
    db $9, $12, $1, POKEMONTOWER_3

    db $0 ; signs

    db $6 ; people
    db SPRITE_MEDIUM, $a + 4, $5 + 4, $ff, $d3, $41, CHANNELER + $C8, $9 ; trainer
    db SPRITE_MEDIUM, $7 + 4, $f + 4, $ff, $d0, $42, CHANNELER + $C8, $a ; trainer
    db SPRITE_MEDIUM, $c + 4, $e + 4, $ff, $d2, $43, CHANNELER + $C8, $c ; trainer
	db SPRITE_BALL, $a + 4, $c + 4, $ff, $ff, $84, ELIXER ; item
	db SPRITE_BALL, $a + 4, $9 + 4, $ff, $ff, $85, AWAKENING ; item
	db SPRITE_BALL, $10 + 4, $c + 4, $ff, $ff, $86, HP_UP ; item

    ; warp-to
    EVENT_DISP $a, $9, $3 ; POKEMONTOWER_5
    EVENT_DISP $a, $9, $12 ; POKEMONTOWER_3

PokemonTower4Blocks: ; 90
    INCBIN "maps/pokemontower4.blk"

PokemonTower5_h: ; 0x60926 to 0x60932 (12 bytes) (id=146)
    db $0f ; tileset
    db POKEMONTOWER_5_HEIGHT, POKEMONTOWER_5_WIDTH ; dimensions (y, x)
    dw PokemonTower5Blocks, PokemonTower5Texts, PokemonTower5Script ; blocks, texts, scripts
    db $00 ; connections

    dw PokemonTower5Object ; objects

PokemonTower5Script: ; 0x60932
    call $3c3c
    ld hl, $49a9
    ld de, $4945
    ld a, [$d62e]
    call $3160
    ld [$d62e], a
    ret
; 0x60945

INCBIN "baserom.gbc",$60945,$56

PokemonTower5Texts: ; 0x6099b
    dw PokemonTower5Text1, PokemonTower5Text2, PokemonTower5Text3, PokemonTower5Text4, PokemonTower5Text5, PokemonTower5Text6, PokemonTower5Text7

INCBIN "baserom.gbc",$609a9,$31

PokemonTower5Text1: ; 0x609da
    TX_FAR _PokemonTower5Text1
    db $50

PokemonTower5Text2: ; 0x609df
    db $08 ; asm
    ld hl, $49a9
    call LoadTrainerHeader
    jp $24d7

UnnamedText_609e9: ; 0x609e9
    TX_FAR _UnnamedText_609e9
    db $50
; 0x609e9 + 5 bytes

UnnamedText_609ee: ; 0x609ee
    TX_FAR _UnnamedText_609ee
    db $50
; 0x609ee + 5 bytes

UnnamedText_609f3: ; 0x609f3
    TX_FAR _UnnamedText_609f3
    db $50
; 0x609f3 + 5 bytes

PokemonTower5Text3: ; 0x609f8
    db $08 ; asm
    ld hl, $49b5
    call LoadTrainerHeader
    jp $24d7

UnnamedText_60a02: ; 0x60a02
    TX_FAR _UnnamedText_60a02
    db $50
; 0x60a02 + 5 bytes

UnnamedText_60a07: ; 0x60a07
    TX_FAR _UnnamedText_60a07
    db $50
; 0x60a07 + 5 bytes

UnnamedText_60a0c: ; 0x60a0c
    TX_FAR _UnnamedText_60a0c
    db $50
; 0x60a0c + 5 bytes

PokemonTower5Text4: ; 0x60a11
    db $08 ; asm
    ld hl, $49c1
    call LoadTrainerHeader
    jp $24d7

UnnamedText_60a1b: ; 0x60a1b
    TX_FAR _UnnamedText_60a1b
    db $50
; 0x60a1b + 5 bytes

UnnamedText_60a20: ; 0x60a20
    TX_FAR _UnnamedText_60a20
    db $50
; 0x60a20 + 5 bytes

UnnamedText_60a25: ; 0x60a25
    TX_FAR _UnnamedText_60a25
    db $50
; 0x60a25 + 5 bytes

PokemonTower5Text5: ; 0x60a2a
    db $08 ; asm
    ld hl, $49cd
    call LoadTrainerHeader
    jp $24d7

UnnamedText_60a34: ; 0x60a34
    TX_FAR _UnnamedText_60a34
    db $50
; 0x60a34 + 5 bytes

UnnamedText_60a39: ; 0x60a39
    TX_FAR _UnnamedText_60a39
    db $50
; 0x60a39 + 5 bytes

UnnamedText_60a3e: ; 0x60a3e
    TX_FAR _UnnamedText_60a3e
    db $50
; 0x60a3e + 5 bytes

PokemonTower5Text7: ; 0x60a43
    TX_FAR _UnnamedText_60a43
    db $50
; 0x60a43 + 5 bytes

PokemonTower5Object: ; 0x60a48 (size=65)
    db $1 ; border tile

    db $2 ; warps
    db $9, $3, $0, POKEMONTOWER_4
    db $9, $12, $0, POKEMONTOWER_6

    db $0 ; signs

    db $6 ; people
    db SPRITE_MEDIUM, $8 + 4, $c + 4, $ff, $ff, $1 ; person
    db SPRITE_MEDIUM, $7 + 4, $11 + 4, $ff, $d2, $42, CHANNELER + $C8, $e ; trainer
    db SPRITE_MEDIUM, $3 + 4, $e + 4, $ff, $d2, $43, CHANNELER + $C8, $10 ; trainer
    db SPRITE_MEDIUM, $a + 4, $6 + 4, $ff, $d3, $44, CHANNELER + $C8, $11 ; trainer
    db SPRITE_MEDIUM, $10 + 4, $9 + 4, $ff, $d3, $45, CHANNELER + $C8, $12 ; trainer
	db SPRITE_BALL, $e + 4, $6 + 4, $ff, $ff, $86, NUGGET ; item

    ; warp-to
    EVENT_DISP $a, $9, $3 ; POKEMONTOWER_4
    EVENT_DISP $a, $9, $12 ; POKEMONTOWER_6

PokemonTower5Blocks: ; 90
    INCBIN "maps/pokemontower5.blk"

PokemonTower6_h: ; 0x60ae3 to 0x60aef (12 bytes) (id=147)
    db $0f ; tileset
    db POKEMONTOWER_6_HEIGHT, POKEMONTOWER_6_WIDTH ; dimensions (y, x)
    dw PokemonTower6Blocks, PokemonTower6Texts, PokemonTower6Script ; blocks, texts, scripts
    db $00 ; connections

    dw PokemonTower6Object ; objects

PokemonTower6Script: ; 0x60aef
    call $3c3c
    ld hl, $4bbf
    ld de, $4b0d
    ld a, [$d62f]
    call $3160
    ld [$d62f], a
    ret
; 0x60b02

INCBIN "baserom.gbc",$60b02,$af

PokemonTower6Texts: ; 0x60bb1
    dw PokemonTower6Text1, PokemonTower6Text2, PokemonTower6Text3, PokemonTower6Text4, PokemonTower6Text5, PokemonTower6Text6, PokemonTower6Text7

INCBIN "baserom.gbc",$60bbb + 4,$29 - 4

PokemonTower6Text1: ; 0x60be4
    db $08 ; asm
    ld hl, $4bbf
    call LoadTrainerHeader
    jp $24d7

PokemonTower6Text2: ; 0x60bee
    db $08 ; asm
    ld hl, $4bcb
    call LoadTrainerHeader
    jp $24d7

PokemonTower6Text3: ; 0x60bf8
    db $08 ; asm
    ld hl, $4bd7
    call LoadTrainerHeader
    jp $24d7

PokemonTower6Text7: ; 0x60c02
INCBIN "baserom.gbc",$60c02,$60c1f - $60c02

UnnamedText_60c1f: ; 0x60c1f
    TX_FAR _UnnamedText_60c1f
    db $50
; 0x60c1f + 5 bytes

UnnamedText_60c24: ; 0x60c24
    TX_FAR _UnnamedText_60c24
    db $50
; 0x60c24 + 5 bytes

UnnamedText_60c29: ; 0x60c29
    TX_FAR _UnnamedText_60c29
    db $50
; 0x60c29 + 5 bytes

UnnamedText_60c2e: ; 0x60c2e
    TX_FAR _UnnamedText_60c2e
    db $50
; 0x60c2e + 5 bytes

UnnamedText_60c33: ; 0x60c33
    TX_FAR _UnnamedText_60c33
    db $50
; 0x60c33 + 5 bytes

UnnamedText_60c38: ; 0x60c38
    TX_FAR _UnnamedText_60c38
    db $50
; 0x60c38 + 5 bytes

UnnamedText_60c3d: ; 0x60c3d
    TX_FAR _UnnamedText_60c3d
    db $50
; 0x60c3d + 5 bytes

UnnamedText_60c42: ; 0x60c42
    TX_FAR _UnnamedText_60c42
    db $50
; 0x60c42 + 5 bytes

UnnamedText_60c47: ; 0x60c47
    TX_FAR _UnnamedText_60c47
    db $50
; 0x60c47 + 5 bytes

UnnamedText_60c4c: ; 0x60c4c
    TX_FAR _UnnamedText_60c4c
    db $50
; 0x60c4c + 5 bytes

UnnamedText_60c51: ; 0x60c51
    TX_FAR _UnnamedText_60c51
    db $50
; 0x60c51 + 5 bytes

PokemonTower6Text6: ; 0x60c56
    TX_FAR _UnnamedText_60c56
    db $50
; 0x60c56 + 5 bytes

PokemonTower6Object: ; 0x60c5b (size=58)
    db $1 ; border tile

    db $2 ; warps
    db $9, $12, $1, POKEMONTOWER_5
    db $10, $9, $0, POKEMONTOWER_7

    db $0 ; signs

    db $5 ; people
    db SPRITE_MEDIUM, $a + 4, $c + 4, $ff, $d3, $41, CHANNELER + $C8, $13 ; trainer
    db SPRITE_MEDIUM, $5 + 4, $9 + 4, $ff, $d0, $42, CHANNELER + $C8, $14 ; trainer
    db SPRITE_MEDIUM, $5 + 4, $10 + 4, $ff, $d2, $43, CHANNELER + $C8, $15 ; trainer
	db SPRITE_BALL, $8 + 4, $6 + 4, $ff, $ff, $84, RARE_CANDY ; item
	db SPRITE_BALL, $e + 4, $e + 4, $ff, $ff, $85, X_ACCURACY ; item

    ; warp-to
    EVENT_DISP $a, $9, $12 ; POKEMONTOWER_5
    EVENT_DISP $a, $10, $9 ; POKEMONTOWER_7

PokemonTower6Blocks: ; 90
    INCBIN "maps/pokemontower6.blk"

INCBIN "baserom.gbc",$60cef,$a

PokemonTower7_h: ; 0x60cf9 to 0x60d05 (12 bytes) (id=148)
    db $0f ; tileset
    db POKEMONTOWER_7_HEIGHT, POKEMONTOWER_7_WIDTH ; dimensions (y, x)
    dw PokemonTower7Blocks, PokemonTower7Texts, PokemonTower7Script ; blocks, texts, scripts
    db $00 ; connections

    dw PokemonTower7Object ; objects

PokemonTower7Script: ; 0x60d05
    call $3c3c
    ld hl, $4e47
    ld de, $4d23
    ld a, [$d630]
    call $3160
    ld [$d630], a
    ret
; 0x60d18

INCBIN "baserom.gbc",$60d18,$127

PokemonTower7Texts: ; 0x60e3f
    dw PokemonTower7Text1, PokemonTower7Text2, PokemonTower7Text3, PokemonTower7Text4

INCBIN "baserom.gbc",$60e47,$25

PokemonTower7Text1: ; 0x60e6c
    db $08 ; asm
    ld hl, $4e47
    call LoadTrainerHeader
    jp $24d7

PokemonTower7Text2: ; 0x60e76
    db $08 ; asm
    ld hl, $4e53
    call LoadTrainerHeader
    jp $24d7

PokemonTower7Text3: ; 0x60e80
    db $08 ; asm
    ld hl, $4e5f
    call LoadTrainerHeader
    jp $24d7

PokemonTower7Text4: ; 0x60e8a
    db $08 ; asm
    ld hl, $4ec4
    call PrintText
    ld hl, $d7e0
    set 7, [hl]
    ld hl, $d769
    set 7, [hl]
    ld a, $44
    ld [$cc4d], a
    ld a, $15
    call Predef
    ld a, $17
    ld [$cc4d], a
    ld a, $11
    call Predef
    ld a, $18
    ld [$cc4d], a
    ld a, $15
    call Predef
    ld a, $4
    ld [$d630], a
    ld [$da39], a
    jp $24d7

UnnamedText_60ec4: ; 0x60ec4
    TX_FAR _UnnamedText_60ec4
    db $50
; 0x60ec4 + 5 bytes

UnnamedText_60ec9: ; 0x60ec9
    TX_FAR _UnnamedText_60ec9
    db $50
; 0x60ec9 + 5 bytes

UnnamedText_60ece: ; 0x60ece
    TX_FAR _UnnamedText_60ece
    db $50
; 0x60ece + 5 bytes

UnnamedText_60ed3: ; 0x60ed3
    TX_FAR _UnnamedText_60ed3
    db $50
; 0x60ed3 + 5 bytes

UnnamedText_60ed8: ; 0x60ed8
    TX_FAR _UnnamedText_60ed8
    db $50
; 0x60ed8 + 5 bytes

UnnamedText_60edd: ; 0x60edd
    TX_FAR _UnnamedText_60edd
    db $50
; 0x60edd + 5 bytes

UnnamedText_60ee2: ; 0x60ee2
    TX_FAR _UnnamedText_60ee2
    db $50
; 0x60ee2 + 5 bytes

UnnamedText_60ee7: ; 0x60ee7
    TX_FAR _UnnamedText_60ee7
    db $50
; 0x60ee7 + 5 bytes

UnnamedText_60eec: ; 0x60eec
    TX_FAR _UnnamedText_60eec
    db $50
; 0x60eec + 5 bytes

UnnamedText_60ef1: ; 0x60ef1
    TX_FAR _UnnamedText_60ef1
    db $50
; 0x60ef1 + 5 bytes

PokemonTower7Object: ; 0x60ef6 (size=42)
    db $1 ; border tile

    db $1 ; warps
    db $10, $9, $1, POKEMONTOWER_6

    db $0 ; signs

    db $4 ; people
    db SPRITE_ROCKET, $b + 4, $9 + 4, $ff, $d3, $41, ROCKET + $C8, $13 ; trainer
    db SPRITE_ROCKET, $9 + 4, $c + 4, $ff, $d2, $42, ROCKET + $C8, $14 ; trainer
    db SPRITE_ROCKET, $7 + 4, $9 + 4, $ff, $d3, $43, ROCKET + $C8, $15 ; trainer
    db SPRITE_MR_FUJI, $3 + 4, $a + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $a, $10, $9 ; POKEMONTOWER_6

PokemonTower7Blocks: ; 90
    INCBIN "maps/pokemontower7.blk"

CeladonMart1_h: ; 0x60f7a to 0x60f86 (12 bytes) (id=122)
    db $12 ; tileset
    db CELADON_MART_1_HEIGHT, CELADON_MART_1_WIDTH ; dimensions (y, x)
    dw CeladonMart1Blocks, CeladonMart1Texts, CeladonMart1Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeladonMart1Object ; objects

CeladonMart1Script: ; 0x60f86
    jp $3c3c
; 0x60f89

CeladonMart1Texts: ; 0x60f89
    dw CeladonMart1Text1, CeladonMart1Text2, CeladonMart1Text3

CeladonMart1Text1: ; 0x60f8f
    TX_FAR _CeladonMart1Text1
    db $50

CeladonMart1Text2: ; 0x60f94
    TX_FAR _CeladonMart1Text2
    db $50

CeladonMart1Text3: ; 0x60f99
    TX_FAR _CeladonMart1Text3
    db $50

CeladonMart1Object: ; 0x60f9e (size=64)
    db $f ; border tile

    db $6 ; warps
    db $7, $2, $0, $ff
    db $7, $3, $0, $ff
    db $7, $10, $1, $ff
    db $7, $11, $1, $ff
    db $1, $c, $0, CELADON_MART_2
    db $1, $1, $0, CELADON_MART_ELEVATOR

    db $2 ; signs
    db $4, $b, $2 ; CeladonMart1Text2
    db $1, $e, $3 ; CeladonMart1Text3

    db $1 ; people
    db SPRITE_CABLE_CLUB_WOMAN, $3 + 4, $8 + 4, $ff, $d0, $1 ; person

    ; warp-to
    EVENT_DISP $a, $7, $2
    EVENT_DISP $a, $7, $3
    EVENT_DISP $a, $7, $10
    EVENT_DISP $a, $7, $11
    EVENT_DISP $a, $1, $c ; CELADON_MART_2
    EVENT_DISP $a, $1, $1 ; CELADON_MART_ELEVATOR

CeladonMart1Blocks: ; 40
    INCBIN "maps/celadonmart1.blk"

INCBIN "baserom.gbc",$61006,$610ae - $61006

UnnamedText_610ae: ; 0x610ae
    TX_FAR _UnnamedText_610ae
    db $50
; 0x610ae + 5 bytes

UnnamedText_610b3: ; 0x610b3
    TX_FAR _UnnamedText_610b3
    db $50
; 0x610b3 + 5 bytes

UnnamedText_610b8: ; 0x610b8
    TX_FAR _UnnamedText_610b8
    db $50
; 0x610b8 + 5 bytes

UnnamedText_610bd: ; 0x610bd
    TX_FAR _UnnamedText_610bd
    db $50
; 0x610bd + 5 bytes

INCBIN "baserom.gbc",$610c2,$3f

ViridianForest_h: ; 0x61101 to 0x6110d (12 bytes) (id=51)
    db $03 ; tileset
    db VIRIDIAN_FOREST_HEIGHT, VIRIDIAN_FOREST_WIDTH ; dimensions (y, x)
    dw ViridianForestBlocks, ViridianForestTexts, ViridianForestScript ; blocks, texts, scripts
    db $00 ; connections

    dw ViridianForestObject ; objects

ViridianForestScript: ; 0x6110d
    call $3c3c
    ld hl, $5142
    ld de, $5120
    ld a, [$d618]
    call $3160
    ld [$d618], a
    ret
; 0x61120

INCBIN "baserom.gbc",$61120,$6

ViridianForestTexts: ; 0x61126
    dw ViridianForestText1, ViridianForestText2, ViridianForestText3, ViridianForestText4, ViridianForestText5, ViridianForestText6, ViridianForestText7, ViridianForestText8, ViridianForestText9, ViridianForestText10, ViridianForestText11, ViridianForestText12, ViridianForestText13, ViridianForestText14

INCBIN "baserom.gbc",$61142,$25

ViridianForestText1: ; 0x61167
    TX_FAR _ViridianForestText1
    db $50

ViridianForestText2: ; 0x6116c
    db $08 ; asm
    ld hl, $5142
    call LoadTrainerHeader
    jp $24d7

ViridianForestText3: ; 0x61176
    db $08 ; asm
    ld hl, $514e
    call LoadTrainerHeader
    jp $24d7

ViridianForestText4: ; 0x61180
    db $08 ; asm
    ld hl, $515a
    call LoadTrainerHeader
    jp $24d7

UnnamedText_6118a: ; 0x6118a
    TX_FAR _UnnamedText_6118a
    db $50
; 0x6118a + 5 bytes

UnnamedText_6118f: ; 0x6118f
    TX_FAR _UnnamedText_6118f
    db $50
; 0x6118f + 5 bytes

UnnamedText_61194: ; 0x61194
    TX_FAR _UnnamedText_61194
    db $50
; 0x61194 + 5 bytes

UnnamedText_61199: ; 0x61199
    TX_FAR _UnnamedText_61199
    db $50
; 0x61199 + 5 bytes

UnnamedText_6119e: ; 0x6119e
    TX_FAR _UnnamedText_6119e
    db $50
; 0x6119e + 5 bytes

UnnamedText_611a3: ; 0x611a3
    TX_FAR _UnnamedText_611a3
    db $50
; 0x611a3 + 5 bytes

UnnamedText_611a8: ; 0x611a8
    TX_FAR _UnnamedText_611a8
    db $50
; 0x611a8 + 5 bytes

UnnamedText_611ad: ; 0x611ad
    TX_FAR _UnnamedText_611ad
    db $50
; 0x611ad + 5 bytes

UnnamedText_611b2: ; 0x611b2
    TX_FAR _UnnamedText_611b2
    db $50
; 0x611b2 + 5 bytes

ViridianForestText8: ; 0x611b7
    TX_FAR _ViridianForestText8
    db $50

ViridianForestText9: ; 0x611bc
    TX_FAR _ViridianForestText9
    db $50

ViridianForestText10: ; 0x611c1
    TX_FAR _ViridianForestText10
    db $50

ViridianForestText11: ; 0x611c6
    TX_FAR _ViridianForestText11
    db $50

ViridianForestText12: ; 0x611cb
    TX_FAR _ViridianForestText12
    db $50

ViridianForestText13: ; 0x611d0
    TX_FAR _ViridianForestText13
    db $50

ViridianForestText14: ; 0x611d5
    TX_FAR _ViridianForestText14
    db $50

ViridianForestObject: ; 0x611da (size=127)
    db $3 ; border tile

    db $6 ; warps
    db $0, $1, $2, VIRIDIAN_FOREST_EXIT
    db $0, $2, $3, VIRIDIAN_FOREST_EXIT
    db $2f, $f, $1, VIRIDIAN_FOREST_ENTRANCE
    db $2f, $10, $1, VIRIDIAN_FOREST_ENTRANCE
    db $2f, $11, $1, VIRIDIAN_FOREST_ENTRANCE
    db $2f, $12, $1, VIRIDIAN_FOREST_ENTRANCE

    db $6 ; signs
    db $28, $18, $9 ; ViridianForestText9
    db $20, $10, $a ; ViridianForestText10
    db $11, $1a, $b ; ViridianForestText11
    db $18, $4, $c ; ViridianForestText12
    db $2d, $12, $d ; ViridianForestText13
    db $1, $2, $e ; ViridianForestText14

    db $8 ; people
    db SPRITE_BUG_CATCHER, $2b + 4, $10 + 4, $ff, $ff, $1 ; person
    db SPRITE_BUG_CATCHER, $21 + 4, $1e + 4, $ff, $d2, $42, BUG_CATCHER + $C8, $1 ; trainer
    db SPRITE_BUG_CATCHER, $13 + 4, $1e + 4, $ff, $d2, $43, BUG_CATCHER + $C8, $2 ; trainer
    db SPRITE_BUG_CATCHER, $12 + 4, $2 + 4, $ff, $d2, $44, BUG_CATCHER + $C8, $3 ; trainer
	db SPRITE_BALL, $b + 4, $19 + 4, $ff, $ff, $85, ANTIDOTE ; item
	db SPRITE_BALL, $1d + 4, $c + 4, $ff, $ff, $86, POTION ; item
	db SPRITE_BALL, $1f + 4, $1 + 4, $ff, $ff, $87, POKE_BALL ; item
    db SPRITE_BUG_CATCHER, $28 + 4, $1b + 4, $ff, $ff, $8 ; person

    ; warp-to
    EVENT_DISP $11, $0, $1 ; VIRIDIAN_FOREST_EXIT
    EVENT_DISP $11, $0, $2 ; VIRIDIAN_FOREST_EXIT
    EVENT_DISP $11, $2f, $f ; VIRIDIAN_FOREST_ENTRANCE
    EVENT_DISP $11, $2f, $10 ; VIRIDIAN_FOREST_ENTRANCE
    EVENT_DISP $11, $2f, $11 ; VIRIDIAN_FOREST_ENTRANCE
    EVENT_DISP $11, $2f, $12 ; VIRIDIAN_FOREST_ENTRANCE

SSAnne1_h: ; 0x61259 to 0x61265 (12 bytes) (id=95)
    db $0d ; tileset
    db SS_ANNE_1_HEIGHT, SS_ANNE_1_WIDTH ; dimensions (y, x)
    dw SSAnne1Blocks, SSAnne1Texts, SSAnne1Script ; blocks, texts, scripts
    db $00 ; connections

    dw SSAnne1Object ; objects

SSAnne1Script: ; 0x61265
    call $3c3c
    ret
; 0x61269

SSAnne1Texts: ; 0x61269
    dw SSAnne1Text1, SSAnne1Text2

SSAnne1Text1: ; 0x6126d
    TX_FAR _SSAnne1Text1
    db $50

SSAnne1Text2: ; 0x61272
    TX_FAR _SSAnne1Text2
    db $50

SSAnne1Object: ; 0x61277 (size=104)
    db $c ; border tile

    db $b ; warps
    db $0, $1a, $1, VERMILION_DOCK
    db $0, $1b, $1, VERMILION_DOCK
    db $8, $1f, $0, SS_ANNE_8
    db $8, $17, $1, SS_ANNE_8
    db $8, $13, $2, SS_ANNE_8
    db $8, $f, $3, SS_ANNE_8
    db $8, $b, $4, SS_ANNE_8
    db $8, $7, $5, SS_ANNE_8
    db $6, $2, $6, SS_ANNE_2
    db $f, $25, $5, SS_ANNE_4
    db $10, $3, $0, SS_ANNE_6

    db $0 ; signs

    db $2 ; people
    db SPRITE_WAITER, $6 + 4, $c + 4, $fe, $2, $1 ; person
    db SPRITE_SAILOR, $5 + 4, $1b + 4, $ff, $ff, $2 ; person

    ; warp-to
    EVENT_DISP $14, $0, $1a ; VERMILION_DOCK
    EVENT_DISP $14, $0, $1b ; VERMILION_DOCK
    EVENT_DISP $14, $8, $1f ; SS_ANNE_8
    EVENT_DISP $14, $8, $17 ; SS_ANNE_8
    EVENT_DISP $14, $8, $13 ; SS_ANNE_8
    EVENT_DISP $14, $8, $f ; SS_ANNE_8
    EVENT_DISP $14, $8, $b ; SS_ANNE_8
    EVENT_DISP $14, $8, $7 ; SS_ANNE_8
    EVENT_DISP $14, $6, $2 ; SS_ANNE_2
    EVENT_DISP $14, $f, $25 ; SS_ANNE_4
    EVENT_DISP $14, $10, $3 ; SS_ANNE_6

SSAnne1Blocks: ; 180
    INCBIN "maps/ssanne1.blk"

SSAnne2_h: ; 0x61393 to 0x6139f (12 bytes) (id=96)
    db $0d ; tileset
    db SS_ANNE_2_HEIGHT, SS_ANNE_2_WIDTH ; dimensions (y, x)
    dw SSAnne2Blocks, SSAnne2Texts, SSAnne2Script ; blocks, texts, scripts
    db $00 ; connections

    dw SSAnne2Object ; objects

SSAnne2Script: ; 0x6139f
    call $3c3c
    ld hl, $53b3
    ld a, [$d665]
    jp $3d97
; 0x613ab

INCBIN "baserom.gbc",$613ab,$613b3 - $613ab

SSAnne2Scripts: ; 0x613b3
    dw SSAnne2Script0, SSAnne2Script1, SSAnne2Script2, SSAnne2Script3, SSAnne2Script4

SSAnne2Script4: ; 0x613bd
    ret
; 0x613be

SSAnne2Script0: ; 0x613be
    ld hl, $5411
    call $34bf
    ret nc
    ld a, $ff
    ld [$c0ee], a
    call $23b1
    ld c, $2
    ld a, $de
    call $23a1
    ld a, [$cd3d]
    ld [$ff00+$db], a
    ld a, $71
    ld [$cc4d], a
    ld a, $15
    call Predef
    call Delay3
    ld a, $2
    ld [$ff00+$8c], a
    call $3541
    xor a
    ld [$ff00+$b4], a
    ld a, $f0
    ld [$cd6b], a
    ld a, [$ff00+$db]
    cp $2
    jr nz, .asm_61400 ; 0x613f9 $5
    ld de, $540c
    jr .asm_61403 ; 0x613fe $3
.asm_61400
    ld de, $540d
.asm_61403
    call $363a
    ld a, $1
    ld [$d665], a
    ret
; 0x6140c

INCBIN "baserom.gbc",$6140c,$61430 - $6140c

SSAnne2Script1: ; 0x61430
    ld a, [$d730]
    bit 0, a
    ret nz
    call $5416
    xor a
    ld [$cd6b], a
    ld a, $2
    ld [$ff00+$8c], a
    call $2920
    call Delay3
    ld a, $f2
    ld [$d059], a
    ld a, [$d715]
    cp $b1
    jr nz, .asm_61457 ; 0x61451 $4
    ld a, $1
    jr .asm_61461 ; 0x61455 $a
.asm_61457
    cp $99
    jr nz, .asm_6145f ; 0x61459 $4
    ld a, $2
    jr .asm_61461 ; 0x6145d $2
.asm_6145f
    ld a, $3
.asm_61461
    ld [$d05d], a
    call $5416
    ld a, $2
    ld [$d665], a
    ret
; 0x6146d

SSAnne2Script2: ; 0x6146d
    ld a, [$d057]
    cp $ff
    jp z, $53ab
    call $5416
    ld a, $f0
    ld [$cd6b], a
    ld a, $3
    ld [$ff00+$8c], a
    call $2920
    ld a, $2
    ld [$ff00+$8c], a
    call $3541
    ld a, [$d362]
    cp $25
    jr nz, .asm_61497 ; 0x61490 $5
    ld de, $54b9
    jr .asm_6149a ; 0x61495 $3
.asm_61497
    ld de, $54b7
.asm_6149a
    ld a, $2
    ld [$ff00+$8c], a
    call $363a
    ld a, $ff
    ld [$c0ee], a
    call $23b1
    ld b, $2
    ld hl, $5b47
    call Bankswitch
    ld a, $3
    ld [$d665], a
    ret
; 0x614b7

INCBIN "baserom.gbc",$614b7,$614be - $614b7

SSAnne2Script3: ; 0x614be
    ld a, [$d730]
    bit 0, a
    ret nz
    xor a
    ld [$cd6b], a
    ld a, $71
    ld [$cc4d], a
    ld a, $11
    call Predef
    call $2307
    ld a, $4
    ld [$d665], a
    ret
; 0x614db

SSAnne2Texts: ; 0x614db
    dw SSAnne2Text1, SSAnne2Text2, SSAnne2Text3

SSAnne2Text1: ; 0x614e1
    TX_FAR _SSAnne2Text1
    db $50

SSAnne2Text2: ; 0x614e6
    db $8
    ld hl, $5500
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $5505
    ld de, $550a
    call $3354
    jp $24d7
; 0x61500

UnnamedText_61500: ; 0x61500
    TX_FAR _UnnamedText_61500
    db $50
; 0x61500 + 5 bytes

UnnamedText_61505: ; 0x61505
    TX_FAR _UnnamedText_61505
    db $50
; 0x61505 + 5 bytes

UnnamedText_6150a: ; 0x6150a
    TX_FAR _UnnamedText_6150a
    db $50
; 0x6150a + 5 bytes

SSAnne2Text3: ; 0x6150f
    TX_FAR _UnnamedText_6150f
    db $50
; 0x6150f + 5 bytes

SSAnne2Object: ; 0x61514 (size=90)
    db $c ; border tile

    db $9 ; warps
    db $b, $9, $0, SS_ANNE_9
    db $b, $d, $2, SS_ANNE_9
    db $b, $11, $4, SS_ANNE_9
    db $b, $15, $6, SS_ANNE_9
    db $b, $19, $8, SS_ANNE_9
    db $b, $1d, $a, SS_ANNE_9
    db $4, $2, $8, SS_ANNE_1
    db $c, $2, $1, SS_ANNE_3
    db $4, $24, $0, SS_ANNE_7

    db $0 ; signs

    db $2 ; people
    db SPRITE_WAITER, $7 + 4, $3 + 4, $fe, $1, $1 ; person
    db SPRITE_BLUE, $4 + 4, $24 + 4, $ff, $d0, $42, SONY1 + $C8, $1 ; trainer

    ; warp-to
    EVENT_DISP $14, $b, $9 ; SS_ANNE_9
    EVENT_DISP $14, $b, $d ; SS_ANNE_9
    EVENT_DISP $14, $b, $11 ; SS_ANNE_9
    EVENT_DISP $14, $b, $15 ; SS_ANNE_9
    EVENT_DISP $14, $b, $19 ; SS_ANNE_9
    EVENT_DISP $14, $b, $1d ; SS_ANNE_9
    EVENT_DISP $14, $4, $2 ; SS_ANNE_1
    EVENT_DISP $14, $c, $2 ; SS_ANNE_3
    EVENT_DISP $14, $4, $24 ; SS_ANNE_7

SSAnne2Blocks: ; 180
    INCBIN "maps/ssanne2.blk"

SSAnne4_h: ; 0x61622 to 0x6162e (12 bytes) (id=98)
    db $0d ; tileset
    db SS_ANNE_4_HEIGHT, SS_ANNE_4_WIDTH ; dimensions (y, x)
    dw SSAnne4Blocks, SSAnne4Texts, SSAnne4Script ; blocks, texts, scripts
    db $00 ; connections

    dw SSAnne4Object ; objects

SSAnne4Script: ; 0x6162e
    jp $3c3c
; 0x61631

SSAnne4Texts:

INCBIN "baserom.gbc",$61631,$1

SSAnne4Object: ; 0x61632 (size=52)
    db $c ; border tile

    db $6 ; warps
    db $3, $17, $8, SS_ANNE_10
    db $3, $13, $6, SS_ANNE_10
    db $3, $f, $4, SS_ANNE_10
    db $3, $b, $2, SS_ANNE_10
    db $3, $7, $0, SS_ANNE_10
    db $5, $1b, $9, SS_ANNE_1

    db $0 ; signs

    db $0 ; people

    ; warp-to
    EVENT_DISP $f, $3, $17 ; SS_ANNE_10
    EVENT_DISP $f, $3, $13 ; SS_ANNE_10
    EVENT_DISP $f, $3, $f ; SS_ANNE_10
    EVENT_DISP $f, $3, $b ; SS_ANNE_10
    EVENT_DISP $f, $3, $7 ; SS_ANNE_10
    EVENT_DISP $f, $5, $1b ; SS_ANNE_1

SSAnne4Blocks: ; 60
    INCBIN "maps/ssanne4.blk"

SSAnne5_h: ; 0x616a2 to 0x616ae (12 bytes) (id=99)
    db $0d ; tileset
    db SS_ANNE_5_HEIGHT, SS_ANNE_5_WIDTH ; dimensions (y, x)
    dw SSAnne5Blocks, SSAnne5Texts, SSAnne5Script ; blocks, texts, scripts
    db $00 ; connections

    dw SSAnne5Object ; objects

SSAnne5Script: ; 0x616ae
    call $3c3c
    ld hl, $56d1
    ld de, $56c1
    ld a, [$d617]
    call $3160
    ld [$d617], a
    ret
; 0x616c1

INCBIN "baserom.gbc",$616c1,$6

SSAnne5Texts: ; 0x616c7
    dw SSAnne5Text1, SSAnne5Text2, SSAnne5Text3, SSAnne5Text4, SSAnne5Text5

INCBIN "baserom.gbc",$616d1,$19

SSAnne5Text1: ; 0x616ea
    TX_FAR _SSAnne5Text1
    db $50

SSAnne5Text2: ; 0x616ef
    TX_FAR _SSAnne5Text2
    db $50

SSAnne5Text3: ; 0x616f4
    TX_FAR _SSAnne5Text3
    db $50

SSAnne5Text4: ; 0x616f9
    db $08 ; asm
    ld hl, $56d1
    call LoadTrainerHeader
    jp $24d7

UnnamedText_61703: ; 0x61703
    TX_FAR _UnnamedText_61703
    db $50
; 0x61703 + 5 bytes

UnnamedText_61708: ; 0x61708
    TX_FAR _UnnamedText_61708
    db $50
; 0x61708 + 5 bytes

UnnamedText_6170d: ; 0x6170d
    TX_FAR _UnnamedText_6170d
    db $50
; 0x6170d + 5 bytes

SSAnne5Text5: ; 0x61712
    db $08 ; asm
    ld hl, $56dd
    call LoadTrainerHeader
    jp $24d7

UnnamedText_6171c: ; 0x6171c
    TX_FAR _UnnamedText_6171c
    db $50
; 0x6171c + 5 bytes

UnnamedText_61721: ; 0x61721
    TX_FAR _UnnamedText_61721
    db $50
; 0x61721 + 5 bytes

UnnamedText_61726: ; 0x61726
    TX_FAR _UnnamedText_61726
    db $50
; 0x61726 + 5 bytes

SSAnne5Object: ; 0x6172b (size=54)
    db $23 ; border tile

    db $2 ; warps
    db $6, $d, $0, SS_ANNE_3
    db $7, $d, $0, SS_ANNE_3

    db $0 ; signs

    db $5 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $2 + 4, $5 + 4, $ff, $d1, $1 ; person
    db SPRITE_SAILOR, $9 + 4, $4 + 4, $ff, $ff, $2 ; person
    db SPRITE_BLACK_HAIR_BOY_1, $b + 4, $7 + 4, $ff, $ff, $3 ; person
    db SPRITE_SAILOR, $4 + 4, $4 + 4, $ff, $d0, $44, SAILOR + $C8, $1 ; trainer
    db SPRITE_SAILOR, $8 + 4, $a + 4, $ff, $d1, $45, SAILOR + $C8, $2 ; trainer

    ; warp-to
    EVENT_DISP $a, $6, $d ; SS_ANNE_3
    EVENT_DISP $a, $7, $d ; SS_ANNE_3

SSAnne5Blocks: ; 70
    INCBIN "maps/ssanne5.blk"

SSAnne6_h: ; 0x617a7 to 0x617b3 (12 bytes) (id=100)
    db $0d ; tileset
    db SS_ANNE_6_HEIGHT, SS_ANNE_6_WIDTH ; dimensions (y, x)
    dw SSAnne6Blocks, SSAnne6Texts, SSAnne6Script ; blocks, texts, scripts
    db $00 ; connections

    dw SSAnne6Object ; objects

SSAnne6Script: ; 0x617b3
    call $3c3c
    ret
; 0x617b7

SSAnne6Texts: ; 0x617b7
    dw SSAnne6Text1, SSAnne6Text2, SSAnne6Text3, SSAnne6Text4, SSAnne6Text5, SSAnne6Text6, SSAnne6Text7

SSAnne6Text1: ; 0x617c5
    TX_FAR _SSAnne6Text1
    db $50

SSAnne6Text2: ; 0x617ca
    TX_FAR _SSAnne6Text2
    db $50

SSAnne6Text3: ; 0x617cf
    TX_FAR _SSAnne6Text3
    db $50

SSAnne6Text4: ; 0x617d4
    TX_FAR _SSAnne6Text4
    db $50

SSAnne6Text5: ; 0x617d9
    TX_FAR _SSAnne6Text5
    db $50

SSAnne6Text6: ; 0x617de
    TX_FAR _SSAnne6Text6
    db $50

SSAnne6Text7: ; 0x617e3
    db $08 ; asm
    ld hl, $5807
    call PrintText
    ldh a, [$d3]
    bit 7, a
    jr z, .asm_93eb1 ; 0x617ee
    ld hl, $580c
    jr .asm_63292 ; 0x617f3
.asm_93eb1 ; 0x617f5
    bit 4, a
    jr z, .asm_7436c ; 0x617f7
    ld hl, $5811
    jr .asm_63292 ; 0x617fc
.asm_7436c ; 0x617fe
    ld hl, $5816
.asm_63292 ; 0x61801
    call PrintText
    jp $24d7

UnnamedText_61807: ; 0x61807
    TX_FAR _UnnamedText_61807
    db $50
; 0x61807 + 5 bytes

UnnamedText_6180c: ; 0x6180c
    TX_FAR _UnnamedText_6180c
    db $50
; 0x6180c + 5 bytes

UnnamedText_61811: ; 0x61811
    TX_FAR _UnnamedText_61811
    db $50
; 0x61811 + 5 bytes

UnnamedText_61816: ; 0x61816
    TX_FAR _UnnamedText_61816
    db $50
; 0x61816 + 5 bytes

SSAnne6Object: ; 0x6181b (size=54)
    db $c ; border tile

    db $1 ; warps
    db $0, $6, $a, SS_ANNE_1

    db $0 ; signs

    db $7 ; people
    db SPRITE_COOK, $8 + 4, $1 + 4, $fe, $1, $1 ; person
    db SPRITE_COOK, $8 + 4, $5 + 4, $fe, $1, $2 ; person
    db SPRITE_COOK, $7 + 4, $9 + 4, $fe, $1, $3 ; person
    db SPRITE_COOK, $6 + 4, $d + 4, $ff, $ff, $4 ; person
    db SPRITE_COOK, $8 + 4, $d + 4, $ff, $ff, $5 ; person
    db SPRITE_COOK, $a + 4, $d + 4, $ff, $ff, $6 ; person
    db SPRITE_COOK, $d + 4, $b + 4, $ff, $d1, $7 ; person

    ; warp-to
    EVENT_DISP $7, $0, $6 ; SS_ANNE_1

SSAnne6Blocks: ; 56
    INCBIN "maps/ssanne6.blk"

SSAnne7_h: ; 0x61889 to 0x61895 (12 bytes) (id=101)
    db $0d ; tileset
    db SS_ANNE_7_HEIGHT, SS_ANNE_7_WIDTH ; dimensions (y, x)
    dw SSAnne7Blocks, SSAnne7Texts, SSAnne7Script ; blocks, texts, scripts
    db $00 ; connections

    dw SSAnne7Object ; objects

SSAnne7Script: ; 0x61895
    call $589b
    jp $3c3c
; 0x6189b

INCBIN "baserom.gbc",$6189b,$c

SSAnne7Texts: ; 0x618a7
    dw SSAnne7Text1, SSAnne7Text2, SSAnne7Text3

SSAnne7Text1: ; 0x618ad
    db $08 ; asm
    ld a, [$d803]
    bit 0, a
    jr nz, .asm_797c4 ; 0x618b3
    ld hl, $58ec
    call PrintText
    ld hl, $5927
    call PrintText
    ld bc,(HM_01 << 8) | 1
    call $3e2e
    jr nc, .asm_ccdcd ; 0x618c7
    ld hl, $592c
    call PrintText
    ld hl, $d803
    set 0, [hl]
    jr .asm_0faf5 ; 0x618d4
.asm_ccdcd ; 0x618d6
    ld hl, $5937
    call PrintText
    ld hl, $d72d
    set 5, [hl]
    jr .asm_0faf5 ; 0x618e1
.asm_797c4 ; 0x618e3
    ld hl, $5932
    call PrintText
.asm_0faf5 ; 0x618e9
    jp $24d7

INCBIN "baserom.gbc",$618ec,$61927 - $618ec

UnnamedText_61927: ; 0x61927
    TX_FAR _UnnamedText_61927
    db $50
; 0x61927 + 5 bytes

INCBIN "baserom.gbc",$6192c,$61932 - $6192c

UnnamedText_61932: ; 0x61932
    TX_FAR _UnnamedText_61932
    db $50
; 0x61932 + 5 bytes

UnnamedText_61937: ; 0x61937
    TX_FAR _UnnamedText_61937
    db $50
; 0x61937 + 5 bytes

SSAnne7Text2: ; 0x6193c
    TX_FAR _SSAnne7Text2
    db $50

SSAnne7Text3: ; 0x61941
    TX_FAR _SSAnne7Text3
    db $50

SSAnne7Object: ; 0x61946 (size=24)
    db $c ; border tile

    db $1 ; warps
    db $7, $0, $8, SS_ANNE_2

    db $2 ; signs
    db $1, $4, $2 ; SSAnne7Text2
    db $2, $1, $3 ; SSAnne7Text3

    db $1 ; people
    db SPRITE_SS_CAPTAIN, $2 + 4, $4 + 4, $ff, $d1, $1 ; person

    ; warp-to
    EVENT_DISP $3, $7, $0 ; SS_ANNE_2

SSAnne7Blocks: ; 12
    INCBIN "maps/ssanne7.blk"

SSAnne8_h: ; 0x6196a to 0x61976 (12 bytes) (id=102)
    db $0d ; tileset
    db SS_ANNE_8_HEIGHT, SS_ANNE_8_WIDTH ; dimensions (y, x)
    dw SSAnne8Blocks, SSAnne8Texts, SSAnne8Script ; blocks, texts, scripts
    db $00 ; connections

    dw SSAnne8Object ; objects

SSAnne8Script: ; 0x61976
    call $3c3c
    ld hl, $59a5
    ld de, $5989
    ld a, [$d608]
    call $3160
    ld [$d608], a
    ret
; 0x61989

INCBIN "baserom.gbc",$61989,$6

SSAnne8Texts: ; 0x6198f
    dw SSAnne8Text1, SSAnne8Text2, SSAnne8Text3, SSAnne8Text4, SSAnne8Text5, SSAnne8Text6, SSAnne8Text7, SSAnne8Text8, SSAnne8Text9, SSAnne8Text10, SSAnne8Text11

INCBIN "baserom.gbc",$619a5,$31

SSAnne8Text1: ; 0x619d6
    db $08 ; asm
    ld hl, $59a5
    call LoadTrainerHeader
    jp $24d7

SSAnne8Text2: ; 0x619e0
    db $08 ; asm
    ld hl, $59b1
    call LoadTrainerHeader
    jp $24d7

SSAnne8Text3: ; 0x619ea
    db $08 ; asm
    ld hl, $59bd
    call LoadTrainerHeader
    jp $24d7

SSAnne8Text4: ; 0x619f4
    db $08 ; asm
    ld hl, $59c9
    call LoadTrainerHeader
    jp $24d7

SSAnne8Text8: ; 0x619fe
    TX_FAR _SSAnne8Text8
    db $08 ; asm
    ld a, $65
    call $13d0
    jp $24d7

UnnamedText_61a0b: ; 0x61a0b
    TX_FAR _UnnamedText_61a0b
    db $50
; 0x61a0b + 5 bytes

UnnamedText_61a10: ; 0x61a10
    TX_FAR _UnnamedText_61a10
    db $50
; 0x61a10 + 5 bytes

UnnamedText_61a15: ; 0x61a15
    TX_FAR _UnnamedText_61a15
    db $50
; 0x61a15 + 5 bytes

UnnamedText_61a1a: ; 0x61a1a
    TX_FAR _UnnamedText_61a1a
    db $50
; 0x61a1a + 5 bytes

UnnamedText_61a1f: ; 0x61a1f
    TX_FAR _UnnamedText_61a1f
    db $50
; 0x61a1f + 5 bytes

UnnamedText_61a24: ; 0x61a24
    TX_FAR _UnnamedText_61a24
    db $50
; 0x61a24 + 5 bytes

UnnamedText_61a29: ; 0x61a29
    TX_FAR _UnnamedText_61a29
    db $50
; 0x61a29 + 5 bytes

UnnamedText_61a2e: ; 0x61a2e
    TX_FAR _UnnamedText_61a2e
    db $50
; 0x61a2e + 5 bytes

UnnamedText_61a33: ; 0x61a33
    TX_FAR _UnnamedText_61a33
    db $50
; 0x61a33 + 5 bytes

UnnamedText_61a38: ; 0x61a38
    TX_FAR _UnnamedText_61a38
    db $50
; 0x61a38 + 5 bytes

UnnamedText_61a3d: ; 0x61a3d
    TX_FAR _UnnamedText_61a3d
    db $50
; 0x61a3d + 5 bytes

UnnamedText_61a42: ; 0x61a42
    TX_FAR _UnnamedText_61a42
    db $50
; 0x61a42 + 5 bytes

SSAnne8Text5: ; 0x61a47
    TX_FAR _SSAnne8Text5
    db $50

SSAnne8Text6: ; 0x61a4c
    TX_FAR _SSAnne8Text6
    db $50

SSAnne8Text7: ; 0x61a51
    TX_FAR _SSAnne8Text7
    db $50

SSAnne8Text9: ; 0x61a56
    TX_FAR _SSAnne8Text9
    db $50

SSAnne8Text11: ; 0x61a5b
    TX_FAR _SSAnne8Text11
    db $50

SSAnne8Object: ; 0x61a60 (size=127)
    db $c ; border tile

    db $6 ; warps
    db $0, $0, $2, SS_ANNE_1
    db $0, $a, $3, SS_ANNE_1
    db $0, $14, $4, SS_ANNE_1
    db $a, $0, $5, SS_ANNE_1
    db $a, $a, $6, SS_ANNE_1
    db $a, $14, $7, SS_ANNE_1

    db $0 ; signs

    db $b ; people
    db SPRITE_GENTLEMAN, $3 + 4, $2 + 4, $ff, $d2, $41, GENTLEMAN + $C8, $1 ; trainer
    db SPRITE_GENTLEMAN, $4 + 4, $b + 4, $ff, $d1, $42, GENTLEMAN + $C8, $2 ; trainer
    db SPRITE_BUG_CATCHER, $e + 4, $b + 4, $ff, $d1, $43, YOUNGSTER + $C8, $8 ; trainer
    db SPRITE_LASS, $b + 4, $d + 4, $ff, $d2, $44, LASS + $C8, $b ; trainer
    db SPRITE_GIRL, $3 + 4, $16 + 4, $fe, $1, $5 ; person
    db SPRITE_FAT_BALD_GUY, $e + 4, $0 + 4, $ff, $ff, $6 ; person
    db SPRITE_LITTLE_GIRL, $b + 4, $2 + 4, $ff, $d0, $7 ; person
    db SPRITE_CLEFAIRY, $b + 4, $3 + 4, $ff, $d0, $8 ; person
    db SPRITE_GIRL, $d + 4, $a + 4, $ff, $d3, $9 ; person
	db SPRITE_BALL, $f + 4, $c + 4, $ff, $ff, $8a, TM_08 ; item
    db SPRITE_GENTLEMAN, $d + 4, $15 + 4, $fe, $2, $b ; person

    ; warp-to
    EVENT_DISP $c, $0, $0 ; SS_ANNE_1
    EVENT_DISP $c, $0, $a ; SS_ANNE_1
    EVENT_DISP $c, $0, $14 ; SS_ANNE_1
    EVENT_DISP $c, $a, $0 ; SS_ANNE_1
    EVENT_DISP $c, $a, $a ; SS_ANNE_1
    EVENT_DISP $c, $a, $14 ; SS_ANNE_1

SSAnne8Blocks: ; 96
    INCBIN "maps/ssanne8.blk"

SSAnne9_h: ; 0x61b3f to 0x61b4b (12 bytes) (id=103)
    db $0d ; tileset
    db SS_ANNE_9_HEIGHT, SS_ANNE_9_WIDTH ; dimensions (y, x)
    dw SSAnne9Blocks, SSAnne9Texts, SSAnne9Script ; blocks, texts, scripts
    db $00 ; connections

    dw SSAnne9Object ; objects

SSAnne9Script: ; 0x61b4b
    ld a, $1
    ld [$cf0c], a
    xor a
    ld [$cc3c], a
    ld hl, $5b84
    ld de, $5b64
    ld a, [$d609]
    call $3160
    ld [$d609], a
    ret
; 0x61b64

INCBIN "baserom.gbc",$61b64,$6

SSAnne9Texts: ; 0x61b6a
    dw SSAnne9Text1, SSAnne9Text2, SSAnne9Text3, SSAnne9Text4, SSAnne9Text5, SSAnne9Text6, SSAnne9Text7, SSAnne9Text8, SSAnne9Text9, SSAnne9Text10, SSAnne9Text11, SSAnne9Text12, SSAnne9Text13

INCBIN "baserom.gbc",$61b84,$31

SSAnne9Text1: ; 0x61bb5
    db $08 ; asm
    ld hl, $5b84
    call LoadTrainerHeader
    jp $24d7

SSAnne9Text2: ; 0x61bbf
    db $08 ; asm
    ld hl, $5b90
    call LoadTrainerHeader
    jp $24d7

SSAnne9Text3: ; 0x61bc9
    db $08 ; asm
    ld hl, $5b9c
    call LoadTrainerHeader
    jp $24d7

SSAnne9Text4: ; 0x61bd3
    db $08 ; asm
    ld hl, $5ba8
    call LoadTrainerHeader
    jp $24d7

SSAnne9Text5: ; 0x61bdd
    db $08 ; asm
    call $3719
    ld hl, $5bf2
    call PrintText
    call $3725
    ld a, $84
    call $349b
    jp $24d7

UnnamedText_61bf2: ; 0x61bf2
    TX_FAR _UnnamedText_61bf2
    db $50
; 0x61bf2 + 5 bytes

SSAnne9Text7: ; 0x61bf7
    db $08 ; asm
    ld hl, $5c01
    call PrintText
    jp $24d7

UnnamedText_61c01: ; 0x61c01
    TX_FAR _UnnamedText_61c01
    db $50
; 0x61c01 + 5 bytes

SSAnne9Text8: ; 0x61c06
    db $08 ; asm
    ld hl, $5c10
    call PrintText
    jp $24d7

UnnamedText_61c10: ; 0x61c10
    TX_FAR _UnnamedText_61c10
    db $50
; 0x61c10 + 5 bytes

SSAnne9Text10: ; 0x61c15
    db $08 ; asm
    ld hl, $5c1f
    call PrintText
    jp $24d7

UnnamedText_61c1f: ; 0x61c1f
    TX_FAR _UnnamedText_61c1f
    db $50
; 0x61c1f + 5 bytes

SSAnne9Text11: ; 0x61c24
    db $08 ; asm
    ld hl, $5c2e
    call PrintText
    jp $24d7

UnnamedText_61c2e: ; 0x61c2e
    TX_FAR _UnnamedText_61c2e
    db $50
; 0x61c2e + 5 bytes

SSAnne9Text12: ; 0x61c33
    db $08 ; asm
    ld hl, $5c3d
    call PrintText
    jp $24d7

UnnamedText_61c3d: ; 0x61c3d
    TX_FAR _UnnamedText_61c3d
    db $50
; 0x61c3d + 5 bytes

SSAnne9Text13: ; 0x61c42
    db $08 ; asm
    ld hl, $5c4c
    call PrintText
    jp $24d7

UnnamedText_61c4c: ; 0x61c4c
    TX_FAR _UnnamedText_61c4c
    db $50
; 0x61c4c + 5 bytes

UnnamedText_61c51: ; 0x61c51
    TX_FAR _UnnamedText_61c51
    db $50
; 0x61c51 + 5 bytes

UnnamedText_61c56: ; 0x61c56
    TX_FAR _UnnamedText_61c56
    db $50
; 0x61c56 + 5 bytes

UnnamedText_61c5b: ; 0x61c5b
    TX_FAR _UnnamedText_61c5b
    db $50
; 0x61c5b + 5 bytes

UnnamedText_61c60: ; 0x61c60
    TX_FAR _UnnamedText_61c60
    db $50
; 0x61c60 + 5 bytes

UnnamedText_61c65: ; 0x61c65
    TX_FAR _UnnamedText_61c65
    db $50
; 0x61c65 + 5 bytes

UnnamedText_61c6a: ; 0x61c6a
    TX_FAR _UnnamedText_61c6a
    db $50
; 0x61c6a + 5 bytes

UnnamedText_61c6f: ; 0x61c6f
    TX_FAR _UnnamedText_61c6f
    db $50
; 0x61c6f + 5 bytes

UnnamedText_61c74: ; 0x61c74
    TX_FAR _UnnamedText_61c74
    db $50
; 0x61c74 + 5 bytes

UnnamedText_61c79: ; 0x61c79
    TX_FAR _UnnamedText_61c79
    db $50
; 0x61c79 + 5 bytes

UnnamedText_61c7e: ; 0x61c7e
    TX_FAR _UnnamedText_61c7e
    db $50
; 0x61c7e + 5 bytes

UnnamedText_61c83: ; 0x61c83
    TX_FAR _UnnamedText_61c83
    db $50
; 0x61c83 + 5 bytes

UnnamedText_61c88: ; 0x61c88
    TX_FAR _UnnamedText_61c88
    db $50
; 0x61c88 + 5 bytes

SSAnne9Object: ; 0x61c8d (size=188)
    db $c ; border tile

    db $c ; warps
    db $5, $2, $0, SS_ANNE_2
    db $5, $3, $0, SS_ANNE_2
    db $5, $c, $1, SS_ANNE_2
    db $5, $d, $1, SS_ANNE_2
    db $5, $16, $2, SS_ANNE_2
    db $5, $17, $2, SS_ANNE_2
    db $f, $2, $3, SS_ANNE_2
    db $f, $3, $3, SS_ANNE_2
    db $f, $c, $4, SS_ANNE_2
    db $f, $d, $4, SS_ANNE_2
    db $f, $16, $5, SS_ANNE_2
    db $f, $17, $5, SS_ANNE_2

    db $0 ; signs

    db $d ; people
    db SPRITE_GENTLEMAN, $2 + 4, $a + 4, $ff, $d3, $41, GENTLEMAN + $C8, $3 ; trainer
    db SPRITE_FISHER2, $4 + 4, $d + 4, $ff, $d2, $42, FISHER + $C8, $1 ; trainer
    db SPRITE_GENTLEMAN, $e + 4, $0 + 4, $ff, $d3, $43, GENTLEMAN + $C8, $5 ; trainer
    db SPRITE_LASS, $b + 4, $2 + 4, $ff, $d0, $44, LASS + $C8, $c ; trainer
    db SPRITE_GENTLEMAN, $2 + 4, $1 + 4, $ff, $d0, $5 ; person
	db SPRITE_BALL, $1 + 4, $c + 4, $ff, $ff, $86, MAX_ETHER ; item
    db SPRITE_GENTLEMAN, $2 + 4, $15 + 4, $ff, $d0, $7 ; person
    db SPRITE_OLD_PERSON, $1 + 4, $16 + 4, $ff, $d0, $8 ; person
	db SPRITE_BALL, $c + 4, $0 + 4, $ff, $ff, $89, RARE_CANDY ; item
    db SPRITE_GENTLEMAN, $c + 4, $c + 4, $ff, $d0, $a ; person
    db SPRITE_YOUNG_BOY, $e + 4, $b + 4, $ff, $ff, $b ; person
    db SPRITE_BRUNETTE_GIRL, $c + 4, $16 + 4, $ff, $d2, $c ; person
    db SPRITE_FOULARD_WOMAN, $c + 4, $14 + 4, $ff, $d3, $d ; person

    ; warp-to
    EVENT_DISP $c, $5, $2 ; SS_ANNE_2
    EVENT_DISP $c, $5, $3 ; SS_ANNE_2
    EVENT_DISP $c, $5, $c ; SS_ANNE_2
    EVENT_DISP $c, $5, $d ; SS_ANNE_2
    EVENT_DISP $c, $5, $16 ; SS_ANNE_2
    EVENT_DISP $c, $5, $17 ; SS_ANNE_2
    EVENT_DISP $c, $f, $2 ; SS_ANNE_2
    EVENT_DISP $c, $f, $3 ; SS_ANNE_2
    EVENT_DISP $c, $f, $c ; SS_ANNE_2
    EVENT_DISP $c, $f, $d ; SS_ANNE_2
    EVENT_DISP $c, $f, $16 ; SS_ANNE_2
    EVENT_DISP $c, $f, $17 ; SS_ANNE_2

SSAnne10_h: ; 0x61d49 to 0x61d55 (12 bytes) (id=104)
    db $0d ; tileset
    db SS_ANNE_10_HEIGHT, SS_ANNE_10_WIDTH ; dimensions (y, x)
    dw SSAnne10Blocks, SSAnne10Texts, SSAnne10Script ; blocks, texts, scripts
    db $00 ; connections

    dw SSAnne10Object ; objects

SSAnne10Script: ; 0x61d55
    call $3c3c
    ld hl, $5d84
    ld de, $5d68
    ld a, [$d629]
    call $3160
    ld [$d629], a
    ret
; 0x61d68

INCBIN "baserom.gbc",$61d68,$6

SSAnne10Texts: ; 0x61d6e
    dw SSAnne10Text1, SSAnne10Text2, SSAnne10Text3, SSAnne10Text4, SSAnne10Text5, SSAnne10Text6, SSAnne10Text7, SSAnne10Text8, SSAnne10Text9, SSAnne10Text10, SSAnne10Text11

INCBIN "baserom.gbc",$61d84,$49

SSAnne10Text1: ; 0x61dcd
    db $08 ; asm
    ld hl, $5d84
    call LoadTrainerHeader
    jp $24d7

SSAnne10Text2: ; 0x61dd7
    db $08 ; asm
    ld hl, $5d90
    call LoadTrainerHeader
    jp $24d7

SSAnne10Text3: ; 0x61de1
    db $08 ; asm
    ld hl, $5d9c
    call LoadTrainerHeader
    jp $24d7

SSAnne10Text4: ; 0x61deb
    db $08 ; asm
    ld hl, $5da8
    call LoadTrainerHeader
    jp $24d7

SSAnne10Text5: ; 0x61df5
    db $08 ; asm
    ld hl, $5db4
    call LoadTrainerHeader
    jp $24d7

SSAnne10Text6: ; 0x61dff
    db $08 ; asm
    ld hl, $5dc0
    call LoadTrainerHeader
    jp $24d7

SSAnne10Text8: ; 0x61e09
    TX_FAR _SSAnne10Text8
    db $8 ; 0x61e0d
    ld a, $29
    call $13d0
    jp $24d7

UnnamedText_61e16: ; 0x61e16
    TX_FAR _UnnamedText_61e16
    db $50
; 0x61e16 + 5 bytes

UnnamedText_61e1b: ; 0x61e1b
    TX_FAR _UnnamedText_61e1b
    db $50
; 0x61e1b + 5 bytes

UnnamedText_61e20: ; 0x61e20
    TX_FAR _UnnamedText_61e20
    db $50
; 0x61e20 + 5 bytes

UnnamedText_61e25: ; 0x61e25
    TX_FAR _UnnamedText_61e25
    db $50
; 0x61e25 + 5 bytes

UnnamedText_61e2a: ; 0x61e2a
    TX_FAR _UnnamedText_61e2a
    db $50
; 0x61e2a + 5 bytes

UnnamedText_61e2f: ; 0x61e2f
    TX_FAR _UnnamedText_61e2f
    db $50
; 0x61e2f + 5 bytes

UnnamedText_61e34: ; 0x61e34
    TX_FAR _UnnamedText_61e34
    db $50
; 0x61e34 + 5 bytes

UnnamedText_61e39: ; 0x61e39
    TX_FAR _UnnamedText_61e39
    db $50
; 0x61e39 + 5 bytes

UnnamedText_61e3e: ; 0x61e3e
    TX_FAR _UnnamedText_61e3e
    db $50
; 0x61e3e + 5 bytes

UnnamedText_61e43: ; 0x61e43
    TX_FAR _UnnamedText_61e43
    db $50
; 0x61e43 + 5 bytes

UnnamedText_61e48: ; 0x61e48
    TX_FAR _UnnamedText_61e48
    db $50
; 0x61e48 + 5 bytes

UnnamedText_61e4d: ; 0x61e4d
    TX_FAR _UnnamedText_61e4d
    db $50
; 0x61e4d + 5 bytes

UnnamedText_61e52: ; 0x61e52
    TX_FAR _UnnamedText_61e52
    db $50
; 0x61e52 + 5 bytes

UnnamedText_61e57: ; 0x61e57
    TX_FAR _UnnamedText_61e57
    db $50
; 0x61e57 + 5 bytes

UnnamedText_61e5c: ; 0x61e5c
    TX_FAR _UnnamedText_61e5c
    db $50
; 0x61e5c + 5 bytes

UnnamedText_61e61: ; 0x61e61
    TX_FAR _UnnamedText_61e61
    db $50
; 0x61e61 + 5 bytes

UnnamedText_61e66: ; 0x61e66
    TX_FAR _UnnamedText_61e66
    db $50
; 0x61e66 + 5 bytes

UnnamedText_61e6b: ; 0x61e6b
    TX_FAR _UnnamedText_61e6b
    db $50
; 0x61e6b + 5 bytes

SSAnne10Text7: ; 0x61e70
    TX_FAR _SSAnne10Text7
    db $50

SSAnne10Object: ; 0x61e75 (size=165)
    db $c ; border tile

    db $a ; warps
    db $5, $2, $4, SS_ANNE_4
    db $5, $3, $4, SS_ANNE_4
    db $5, $c, $3, SS_ANNE_4
    db $5, $d, $3, SS_ANNE_4
    db $5, $16, $2, SS_ANNE_4
    db $5, $17, $2, SS_ANNE_4
    db $f, $2, $1, SS_ANNE_4
    db $f, $3, $1, SS_ANNE_4
    db $f, $c, $0, SS_ANNE_4
    db $f, $d, $0, SS_ANNE_4

    db $0 ; signs

    db $b ; people
    db SPRITE_SAILOR, $d + 4, $0 + 4, $ff, $d0, $41, SAILOR + $C8, $3 ; trainer
    db SPRITE_SAILOR, $b + 4, $2 + 4, $ff, $d0, $42, SAILOR + $C8, $4 ; trainer
    db SPRITE_SAILOR, $3 + 4, $c + 4, $ff, $d2, $43, SAILOR + $C8, $5 ; trainer
    db SPRITE_SAILOR, $2 + 4, $16 + 4, $ff, $d0, $44, SAILOR + $C8, $6 ; trainer
    db SPRITE_SAILOR, $2 + 4, $0 + 4, $ff, $d3, $45, SAILOR + $C8, $7 ; trainer
    db SPRITE_FISHER2, $4 + 4, $0 + 4, $ff, $d3, $46, FISHER + $C8, $2 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $d + 4, $a + 4, $ff, $d3, $7 ; person
    db SPRITE_SLOWBRO, $c + 4, $b + 4, $ff, $ff, $8 ; person
	db SPRITE_BALL, $2 + 4, $14 + 4, $ff, $ff, $89, ETHER ; item
	db SPRITE_BALL, $2 + 4, $a + 4, $ff, $ff, $8a, TM_44 ; item
	db SPRITE_BALL, $b + 4, $c + 4, $ff, $ff, $8b, MAX_POTION ; item

    ; warp-to
    EVENT_DISP $c, $5, $2 ; SS_ANNE_4
    EVENT_DISP $c, $5, $3 ; SS_ANNE_4
    EVENT_DISP $c, $5, $c ; SS_ANNE_4
    EVENT_DISP $c, $5, $d ; SS_ANNE_4
    EVENT_DISP $c, $5, $16 ; SS_ANNE_4
    EVENT_DISP $c, $5, $17 ; SS_ANNE_4
    EVENT_DISP $c, $f, $2 ; SS_ANNE_4
    EVENT_DISP $c, $f, $3 ; SS_ANNE_4
    EVENT_DISP $c, $f, $c ; SS_ANNE_4
    EVENT_DISP $c, $f, $d ; SS_ANNE_4

UndergroundPathNS_h: ; 0x61f1a to 0x61f26 (12 bytes) (id=119)
    db $0b ; tileset
    db UNDERGROUND_PATH_NS_HEIGHT, UNDERGROUND_PATH_NS_WIDTH ; dimensions (y, x)
    dw UndergroundPathNSBlocks, UndergroundPathNSTexts, UndergroundPathNSScript ; blocks, texts, scripts
    db $00 ; connections

    dw UndergroundPathNSObject ; objects

UndergroundPathNSScript: ; 0x61f26
    jp $3c3c
; 0x61f29

UndergroundPathNSTexts:

INCBIN "baserom.gbc",$61f29,$1

UndergroundPathNSObject: ; 0x61f2a (size=20)
    db $1 ; border tile

    db $2 ; warps
    db $4, $5, $2, PATH_ENTRANCE_ROUTE_5
    db $29, $2, $2, PATH_ENTRANCE_ROUTE_6

    db $0 ; signs

    db $0 ; people

    ; warp-to
    EVENT_DISP $4, $4, $5 ; PATH_ENTRANCE_ROUTE_5
    EVENT_DISP $4, $29, $2 ; PATH_ENTRANCE_ROUTE_6

UndergroundPathWE_h: ; 0x61f3e to 0x61f4a (12 bytes) (id=121)
    db $0b ; tileset
    db UNDERGROUND_PATH_WE_HEIGHT, UNDERGROUND_PATH_WE_WIDTH ; dimensions (y, x)
    dw $41f4, UndergroundPathWETexts, UndergroundPathWEScript ; blocks, texts, scripts
    db $00 ; connections

    dw UndergroundPathWEObject ; objects

UndergroundPathWEScript: ; 0x61f4a
    jp $3c3c
; 0x61f4d

UndergroundPathWETexts:
    db $50

UndergroundPathWEObject: ; 0x61f4e (size=20)
    db $1 ; border tile

    db $2 ; warps
    db $5, $2, $2, PATH_ENTRANCE_ROUTE_7
    db $2, $2f, $2, PATH_ENTRANCE_ROUTE_8

    db $0 ; signs

    db $0 ; people

    ; warp-to
    EVENT_DISP $19, $5, $2 ; PATH_ENTRANCE_ROUTE_7
    EVENT_DISP $19, $2, $2f ; PATH_ENTRANCE_ROUTE_8

DiglettsCave_h: ; 0x61f62 to 0x61f6e (12 bytes) (id=197)
    db $11 ; tileset
    db DIGLETTS_CAVE_HEIGHT, DIGLETTS_CAVE_WIDTH ; dimensions (y, x)
    dw DiglettsCaveBlocks, DiglettsCaveTexts, DiglettsCaveScript ; blocks, texts, scripts
    db $00 ; connections

    dw DiglettsCaveObject ; objects

DiglettsCaveScript: ; 0x61f6e
    jp $3c3c
; 0x61f71

DiglettsCaveTexts:
    db $50

DiglettsCaveObject: ; 0x61f72 (size=20)
    db $19 ; border tile

    db $2 ; warps
    db $5, $5, $2, DIGLETTS_CAVE_EXIT
    db $1f, $25, $2, DIGLETTS_CAVE_ENTRANCE

    db $0 ; signs

    db $0 ; people

    ; warp-to
    EVENT_DISP $14, $5, $5 ; DIGLETTS_CAVE_EXIT
    EVENT_DISP $14, $1f, $25 ; DIGLETTS_CAVE_ENTRANCE

DiglettsCaveBlocks: ; 360
    INCBIN "maps/diglettscave.blk"

SilphCo11_h: ; 0x620ee to 0x620fa (12 bytes) (id=235)
    db $10 ; tileset
    db SILPH_CO_11F_HEIGHT, SILPH_CO_11F_WIDTH ; dimensions (y, x)
    dw SilphCo11Blocks, SilphCo11Texts, SilphCo11Script ; blocks, texts, scripts
    db $00 ; connections

    dw SilphCo11Object ; objects

SilphCo11Script: ; 0x620fa
    call $6110
    call $3c3c
    ld hl, $62c3
    ld de, $61cf
    ld a, [$d659]
    call $3160
    ld [$d659], a
    ret
; 0x62110

INCBIN "baserom.gbc",$62110,$1a7

SilphCo11Texts: ; 0x622b7
    dw SilphCo11Text1, SilphCo11Text2, SilphCo11Text3, SilphCo11Text4, SilphCo11Text5, SilphCo11Text6

INCBIN "baserom.gbc",$622c3,$19

SilphCo11Text1: ; 0x622dc
    db $08 ; asm
    ld a, [$d838]
    bit 5, a
    jp nz, $6308
    ld hl, $6311
    call PrintText
    ld bc,(MASTER_BALL << 8) | 1
    call $3e2e
    jr nc, .asm_36088 ; 0x622f1
    ld hl, $6316
    call PrintText
    ld hl, $d838
    set 5, [hl]
    jr .asm_fd405 ; 0x622fe
.asm_36088 ; 0x62300
    ld hl, $6321
    call PrintText
    jr .asm_fd405 ; 0x62306
    ld hl, $631c
    call PrintText
.asm_fd405 ; 0x6230e
    jp $24d7

UnnamedText_62311: ; 0x62311
    TX_FAR _UnnamedText_62311
    db $50
; 0x62311 + 5 bytes

INCBIN "baserom.gbc",$62316,$6231c - $62316

UnnamedText_6231c: ; 0x6231c
    TX_FAR _UnnamedText_6231c
    db $50
; 0x6231c + 5 bytes

UnnamedText_62321: ; 0x62321
    TX_FAR _UnnamedText_62321
    db $50
; 0x62321 + 5 bytes

SilphCo11Text2: ; 0x62326
    TX_FAR _SilphCo11Text2
    db $50

SilphCo11Text3: ; 0x6232b
    TX_FAR _SilphCo11Text3
    db $50

UnnamedText_62330: ; 0x62330
    TX_FAR _UnnamedText_62330
    db $50
; 0x62330 + 5 bytes

SilphCo11Text6: ; 0x62335
    TX_FAR _UnnamedText_62335
    db $50
; 0x62335 + 5 bytes

SilphCo11Text4: ; 0x6233a
    db $08 ; asm
    ld hl, $62c3
    call LoadTrainerHeader
    jp $24d7

UnnamedText_62344: ; 0x62344
    TX_FAR _UnnamedText_62344
    db $50
; 0x62344 + 5 bytes

UnnamedText_62349: ; 0x62349
    TX_FAR _UnnamedText_62349
    db $50
; 0x62349 + 5 bytes

UnnamedText_6234e: ; 0x6234e
    TX_FAR _UnnamedText_6234e
    db $50
; 0x6234e + 5 bytes

SilphCo11Text5: ; 0x62353
    db $08 ; asm
    ld hl, $62cf
    call LoadTrainerHeader
    jp $24d7

UnnamedText_6235d: ; 0x6235d
    TX_FAR _UnnamedText_6235d
    db $50
; 0x6235d + 5 bytes

UnnamedText_62362: ; 0x62362
    TX_FAR _UnnamedText_62362
    db $50
; 0x62362 + 5 bytes

UnnamedText_62367: ; 0x62367
    TX_FAR _UnnamedText_62367
    db $50
; 0x62367 + 5 bytes

INCBIN "baserom.gbc",$6236c,$6237b - $6236c

UnnamedText_6237b: ; 0x6237b
    TX_FAR _UnnamedText_6237b
    db $50
; 0x6237b + 5 bytes

SilphCo11Object: ; 0x62380 (size=72)
    db $d ; border tile

    db $4 ; warps
    db $0, $9, $1, SILPH_CO_10F
    db $0, $d, $0, SILPH_CO_ELEVATOR
    db $5, $5, $9, $ff
    db $2, $3, $3, SILPH_CO_7F

    db $0 ; signs

    db $5 ; people
    db SPRITE_MR_MASTERBALL, $5 + 4, $7 + 4, $ff, $d0, $1 ; person
    db SPRITE_FOULARD_WOMAN, $5 + 4, $a + 4, $ff, $d0, $2 ; person
    db SPRITE_GIOVANNI, $9 + 4, $6 + 4, $ff, $d0, $43, GIOVANNI + $C8, $2 ; trainer
    db SPRITE_ROCKET, $10 + 4, $3 + 4, $ff, $d1, $44, ROCKET + $C8, $29 ; trainer
    db SPRITE_ROCKET, $9 + 4, $f + 4, $ff, $d1, $45, ROCKET + $C8, $28 ; trainer

    ; warp-to
    EVENT_DISP $9, $0, $9 ; SILPH_CO_10F
    EVENT_DISP $9, $0, $d ; SILPH_CO_ELEVATOR
    EVENT_DISP $9, $5, $5
    EVENT_DISP $9, $2, $3 ; SILPH_CO_7F

SilphCo11Blocks: ; 81
    INCBIN "maps/silphco11.blk"

INCBIN "baserom.gbc",$62419,$62453 - $62419

UnnamedText_62453: ; 0x62453
    TX_FAR _UnnamedText_62453
    db $50
; 0x62453 + 5 bytes

UnnamedText_62458: ; 0x62458
    TX_FAR _UnnamedText_62458
    db $50
; 0x62458 + 5 bytes

INCBIN "baserom.gbc",$6245d,$624a3 - $6245d

UnnamedText_624a3: ; 0x624a3
    TX_FAR _UnnamedText_624a3
    db $50
; 0x624a3 + 5 bytes

UnnamedText_624a8: ; 0x624a8
    TX_FAR _UnnamedText_624a8
    db $50
; 0x624a8 + 5 bytes

UnnamedText_624ad: ; 0x624ad
    TX_FAR _UnnamedText_624ad
    db $50
; 0x624ad + 5 bytes

UnnamedText_624b2: ; 0x624b2
    TX_FAR _UnnamedText_624b2
    db $50
; 0x624b2 + 5 bytes

UnnamedText_624b7: ; 0x624b7
    TX_FAR _UnnamedText_624b7
    db $50
; 0x624b7 + 5 bytes

UnnamedText_624bc: ; 0x624bc
    TX_FAR _UnnamedText_624bc
    db $50
; 0x624bc + 5 bytes

UnnamedText_624c1: ; 0x624c1
    TX_FAR _UnnamedText_624c1
    db $50
; 0x624c1 + 5 bytes

UnnamedText_624c6: ; 0x624c6
    TX_FAR _UnnamedText_624c6
    db $50
; 0x624c6 + 5 bytes

UnnamedText_624cb: ; 0x624cb
    TX_FAR _UnnamedText_624cb
    db $50
; 0x624cb + 5 bytes

UnnamedText_624d0: ; 0x624d0
    TX_FAR _UnnamedText_624d0
    db $50
; 0x624d0 + 5 bytes

UnnamedText_624d5: ; 0x624d5
    TX_FAR _UnnamedText_624d5
    db $50
; 0x624d5 + 5 bytes

UnnamedText_624da: ; 0x624da
    TX_FAR _UnnamedText_624da
    db $50
; 0x624da + 5 bytes

UnnamedText_624df: ; 0x624df
    TX_FAR _UnnamedText_624df
    db $50
; 0x624df + 5 bytes

INCBIN "baserom.gbc",$624e4,$624f8 - $624e4

UnnamedText_624f8: ; 0x624f8
    TX_FAR _UnnamedText_624f8
    db $50
; 0x624f8 + 5 bytes

UnnamedText_624fd: ; 0x624fd
    TX_FAR _UnnamedText_624fd
    db $50
; 0x624fd + 5 bytes

UnnamedText_62502: ; 0x62502
    TX_FAR _UnnamedText_62502
    db $50
; 0x62502 + 5 bytes

INCBIN "baserom.gbc",$62507,$62511 - $62507

UnnamedText_62511: ; 0x62511
    TX_FAR _UnnamedText_62511
    db $50
; 0x62511 + 5 bytes

INCBIN "baserom.gbc",$62516,$1aea

SECTION "bank19",DATA,BANK[$19]

Tset00_GFX:
    INCBIN "gfx/tilesets/00.2bpp"
Tset00_Block:
    INCBIN "gfx/blocksets/00.bst"
Tset01_GFX:
    INCBIN "gfx/tilesets/01.2bpp"
Tset01_Block:
    INCBIN "gfx/blocksets/01.bst"
Tset08_GFX:
    INCBIN "gfx/tilesets/08.2bpp"
Tset08_Block:
    INCBIN "gfx/blocksets/08.bst"
Tset13_GFX:
    INCBIN "gfx/tilesets/13.2bpp"
Tset13_Block:
    INCBIN "gfx/blocksets/13.bst"
Tset0E_GFX:
    INCBIN "gfx/tilesets/0e.2bpp"
Tset0E_Block:
    INCBIN "gfx/blocksets/0e.bst"
Tset10_GFX:
    INCBIN "gfx/tilesets/10.2bpp"
Tset10_Block:
    INCBIN "gfx/blocksets/10.bst"
Tset17_GFX:
    INCBIN "gfx/tilesets/17.2bpp"
Tset17_Block:
    INCBIN "gfx/blocksets/17.bst"

SECTION "bank1A",DATA,BANK[$1A]

DecrementPP:
; after using a move, decrement pp in battle and (if not transformed?) in party
	ld a,[de]
	cp a,STRUGGLE
	ret z
	ld hl,$D062
	ld a,[hli]
	and a,7
	ret nz
	bit 6,[hl]
	ret nz
	ld hl,$D02D ; PP of first move (in battle)
	call .DecrementPP\@

	ld a,[$D064]
	bit 3,a ; XXX transform status?
	ret nz

	ld hl,$D188 ; PP of first move (in party)
	ld a,[$CC2F] ; which mon in party is active
	ld bc,$2C
	call AddNTimes
.DecrementPP\@
	ld a,[$CC2E] ; which move (0, 1, 2, 3) did we use?
	ld c,a
	ld b,0
	add hl,bc
	dec [hl] ; Decrement PP
	ret

IF _RED
	INCBIN "gfx/red/redgreenversion.1bpp"
ENDC
IF _BLUE
	INCBIN "gfx/blue/blueversion.1bpp"
ENDC

Tset05_GFX:
    INCBIN "gfx/tilesets/05.2bpp"
Tset05_Block:
    INCBIN "gfx/blocksets/05.bst"
Tset02_GFX:
    INCBIN "gfx/tilesets/02.2bpp"
Tset02_Block:
    INCBIN "gfx/blocksets/02.bst"
Tset09_GFX:
    INCBIN "gfx/tilesets/09.2bpp"
Tset09_Block:
    INCBIN "gfx/blocksets/09.bst"
Tset03_GFX:
    INCBIN "gfx/tilesets/03.2bpp"
Tset03_Block:
    INCBIN "gfx/blocksets/03.bst"
Tset16_GFX:
    INCBIN "gfx/tilesets/16.2bpp"
Tset16_Block:
    INCBIN "gfx/blocksets/16.bst"

SECTION "bank1B",DATA,BANK[$1B]

Tset0F_GFX:
    INCBIN "gfx/tilesets/0f.2bpp"
Tset0F_Block:
    INCBIN "gfx/blocksets/0f.bst"
Tset11_GFX:
    INCBIN "gfx/tilesets/11.2bpp"
Tset11_Block:
    INCBIN "gfx/blocksets/11.bst"
Tset12_GFX:
    INCBIN "gfx/tilesets/12.2bpp"
Tset12_Block:
    INCBIN "gfx/blocksets/12.bst"
Tset0D_GFX:
    INCBIN "gfx/tilesets/0d.2bpp"
Tset0D_Block:
    INCBIN "gfx/blocksets/0d.bst"
Tset14_GFX:
    INCBIN "gfx/tilesets/14.2bpp"
Tset14_Block:
    INCBIN "gfx/blocksets/14.bst"
Tset15_GFX:
    INCBIN "gfx/tilesets/15.2bpp"
Tset15_Block:
    INCBIN "gfx/blocksets/15.bst"
Tset0B_GFX:
    INCBIN "gfx/tilesets/0b.2bpp"
Tset0B_Block:
    INCBIN "gfx/blocksets/0b.bst"

SECTION "bank1C",DATA,BANK[$1C]

INCBIN "baserom.gbc",$70000,$703fa - $70000

UnnamedText_703fa: ; 0x703fa
    TX_FAR _UnnamedText_703fa
    db $50
; 0x703fa + 5 bytes

UnnamedText_703ff: ; 0x703ff
    TX_FAR _UnnamedText_703ff
    db $50
; 0x703ff + 5 bytes

INCBIN "baserom.gbc",$70404,$70847 - $70404

UnnamedText_70847: ; 0x70847
    TX_FAR _UnnamedText_70847
    db $50
; 0x70847 + 5 bytes

UnnamedText_7084c: ; 0x7084c
    TX_FAR _UnnamedText_7084c
    db $50
; 0x7084c + 5 bytes

UnnamedText_70851: ; 0x70851
    TX_FAR _UnnamedText_70851
    db $50
; 0x70851 + 5 bytes

INCBIN "baserom.gbc",$70856,$8aa

CompressedMap: ; 5100
; you can decompress this file with the redrle program in the extras/ dir
	INCBIN "baserom.gbc",$71100,$711AB-$71100

INCBIN "baserom.gbc",$711AB,$71313-$711AB

ExternalMapEntries: ; 5313
	EMAP $2,$B,PalletTownName
	EMAP $2,$8,ViridianCityName
	EMAP $2,$3,PewterCityName
	EMAP $A,$2,CeruleanCityName
	EMAP $E,$5,LavenderTownName
	EMAP $A,$9,VermilionCityName
	EMAP $7,$5,CeladonCityName
	EMAP $8,$D,FuchsiaCityName
	EMAP $2,$F,CinnabarIslandName
	EMAP $0,$2,IndigoPlateauName
	EMAP $A,$5,SaffronCityName
	EMAP $0,$0,PalletTownName ; unused
	EMAP $2,$A,Route1Name
	EMAP $2,$6,Route2Name
	EMAP $4,$3,Route3Name
	EMAP $8,$2,Route4Name
	EMAP $A,$3,Route5Name
	EMAP $A,$8,Route6Name
	EMAP $8,$5,Route7Name
	EMAP $D,$5,Route8Name
	EMAP $D,$2,Route9Name
	EMAP $E,$4,Route10Name
	EMAP $C,$9,Route11Name
	EMAP $E,$9,Route12Name
	EMAP $D,$B,Route13Name
	EMAP $B,$C,Route14Name
	EMAP $A,$D,Route15Name
	EMAP $5,$5,Route16Name
	EMAP $4,$8,Route17Name
	EMAP $6,$D,Route18Name
	EMAP $6,$F,Route19Name
	EMAP $4,$F,Route20Name
	EMAP $2,$D,Route21Name
	EMAP $0,$8,Route22Name
	EMAP $0,$6,Route23Name
	EMAP $A,$1,Route24Name
	EMAP $B,$0,Route25Name

InternalMapEntries: ; 5382
	IMAP $29,$2,$B,PalletTownName
	IMAP $2E,$2,$8,ViridianCityName
	IMAP $33,$2,$6,Route2Name
	IMAP $34,$2,$4,ViridianForestName
	IMAP $3B,$2,$3,PewterCityName
	IMAP $3E,$6,$2,MountMoonName
	IMAP $44,$A,$2,CeruleanCityName
	IMAP $45,$5,$2,Route4Name
	IMAP $46,$A,$2,CeruleanCityName
	IMAP $49,$A,$4,Route5Name
	IMAP $4C,$A,$6,Route6Name
	IMAP $4F,$9,$5,Route7Name
	IMAP $51,$B,$5,Route8Name
	IMAP $53,$E,$3,RockTunnelName
	IMAP $54,$F,$4,PowerPlantName
	IMAP $57,$D,$9,Route11Name
	IMAP $58,$E,$7,Route12Name
	IMAP $59,$C,$0,SeaCottageName
	IMAP $5F,$A,$9,VermilionCityName
	IMAP $69,$9,$A,SSAnneName
	IMAP $6D,$0,$4,VictoryRoadName
	IMAP $77,$0,$2,PokemonLeagueName
	IMAP $78,$A,$5,UndergroundPathName
	IMAP $79,$0,$2,PokemonLeagueName
	IMAP $7A,$A,$5,UndergroundPathName
	IMAP $8D,$7,$5,CeladonCityName
	IMAP $8E,$E,$5,LavenderTownName
	IMAP $95,$F,$5,PokemonTowerName
	IMAP $98,$E,$5,LavenderTownName
	IMAP $9C,$8,$D,FuchsiaCityName
	IMAP $9D,$8,$C,SafariZoneName
	IMAP $9F,$8,$D,FuchsiaCityName
	IMAP $A3,$5,$F,SeafoamIslandsName
	IMAP $A4,$A,$9,VermilionCityName
	IMAP $A5,$8,$D,FuchsiaCityName
	IMAP $A6,$2,$F,PokemonMansionName
	IMAP $AE,$2,$F,CinnabarIslandName
	IMAP $AF,$0,$2,IndigoPlateauName
	IMAP $B8,$A,$5,SaffronCityName
	IMAP $BA,$9,$D,Route15Name
	IMAP $BD,$4,$5,Route16Name
	IMAP $BE,$E,$A,Route12Name
	IMAP $C0,$7,$D,Route18Name
	IMAP $C1,$5,$F,SeafoamIslandsName
	IMAP $C2,$0,$7,Route22Name
	IMAP $C3,$0,$4,VictoryRoadName
	IMAP $C4,$E,$7,Route12Name
	IMAP $C5,$A,$9,VermilionCityName
	IMAP $C6,$3,$4,DiglettsCaveName
	IMAP $C7,$0,$4,VictoryRoadName
	IMAP $CF,$7,$5,RocketHQName
	IMAP $D6,$A,$5,SilphCoName
	IMAP $D9,$2,$F,PokemonMansionName
	IMAP $E2,$8,$C,SafariZoneName
	IMAP $E5,$9,$1,CeruleanCaveName
	IMAP $E6,$E,$5,LavenderTownName
	IMAP $E7,$A,$2,CeruleanCityName
	IMAP $E9,$E,$3,RockTunnelName
	IMAP $ED,$A,$5,SilphCoName
	IMAP $F8,$0,$2,PokemonLeagueName
	db $FF

MapNames: ; 5473
PalletTownName:
	db "PALLET TOWN@"
ViridianCityName:
	db "VIRIDIAN CITY@"
PewterCityName:
	db "PEWTER CITY@"
CeruleanCityName:
	db "CERULEAN CITY@"
LavenderTownName:
	db "LAVENDER TOWN@"
VermilionCityName:
	db "VERMILION CITY@"
CeladonCityName:
	db "CELADON CITY@"
FuchsiaCityName:
	db "FUCHSIA CITY@"
CinnabarIslandName:
	db "CINNABAR ISLAND@"
IndigoPlateauName:
	db "INDIGO PLATEAU@"
SaffronCityName:
	db "SAFFRON CITY@"
Route1Name:
	db "ROUTE 1@"
Route2Name:
	db "ROUTE 2@"
Route3Name:
	db "ROUTE 3@"
Route4Name:
	db "ROUTE 4@"
Route5Name:
	db "ROUTE 5@"
Route6Name:
	db "ROUTE 6@"
Route7Name:
	db "ROUTE 7@"
Route8Name:
	db "ROUTE 8@"
Route9Name:
	db "ROUTE 9@"
Route10Name:
	db "ROUTE 10@"
Route11Name:
	db "ROUTE 11@"
Route12Name:
	db "ROUTE 12@"
Route13Name:
	db "ROUTE 13@"
Route14Name:
	db "ROUTE 14@"
Route15Name:
	db "ROUTE 15@"
Route16Name:
	db "ROUTE 16@"
Route17Name:
	db "ROUTE 17@"
Route18Name:
	db "ROUTE 18@"
Route19Name:
	db "SEA ROUTE 19@"
Route20Name:
	db "SEA ROUTE 20@"
Route21Name:
	db "SEA ROUTE 21@"
Route22Name:
	db "ROUTE 22@"
Route23Name:
	db "ROUTE 23@"
Route24Name:
	db "ROUTE 24@"
Route25Name:
	db "ROUTE 25@"
ViridianForestName:
	db "VIRIDIAN FOREST@"
MountMoonName:
	db "MT.MOON@"
RockTunnelName:
	db "ROCK TUNNEL@"
SeaCottageName:
	db "SEA COTTAGE@"
SSAnneName:
	db "S.S.ANNE@"
PokemonLeagueName:
	db "#MON LEAGUE@"
UndergroundPathName:
	db "UNDERGROUND PATH@"
PokemonTowerName:
	db "#MON TOWER@"
SeafoamIslandsName:
	db "SEAFOAM ISLANDS@"
VictoryRoadName:
	db "VICTORY ROAD@"
DiglettsCaveName:
	db "DIGLETT's CAVE@"
RocketHQName:
	db "ROCKET HQ@"
SilphCoName:
	db "SILPH CO.@"
PokemonMansionName:
	db $4a," MANSION@"
SafariZoneName:
	db "SAFARI ZONE@"
CeruleanCaveName:
	db "CERULEAN CAVE@"
PowerPlantName:
	db "POWER PLANT@"

INCBIN "baserom.gbc",$716BE,$71AD9-$716BE

Predef54: ; 0x71ad9
; trigger the trade offer/action specified by W_WHICHTRADE
	call $36f4
	ld hl,TradeMons
	ld a,[W_WHICHTRADE]
	ld b,a
	swap a
	sub b
	sub b
	ld c,a
	ld b,$0
	add hl,bc
	ld a,[hli]
	ld [$cd0f],a
	ld a,[hli]
	ld [$cd34],a
	ld a,[hli]
	push af
	ld de,$cd29
	ld bc,$000b
	call CopyData
	pop af
	ld l,a
	ld h,$0
	ld de,$5d64
	add hl,hl
	add hl,de
	ld a,[hli]
	ld [$cd10],a
	ld a,[hl]
	ld [$cd11],a
	ld a,[$cd0f]
	ld de,$cd13
	call Function71b6a
	ld a,[$cd34]
	ld de,$cd1e
	call Function71b6a
	ld hl,$d737
	ld a,[W_WHICHTRADE]
	ld c,a
	ld b,$2
	ld a,$10
	call Predef
	ld a,c
	and a
	ld a,$4
	ld [$cd12],a
	jr nz,.asm_99bca ; 0x71b36 $20
	xor a
	ld [$cd12],a
	call .asm_99bca
	ld a,$1
	ld [$cd12],a
	call $35ec
	ld a,[$cc26]
	and a
	jr nz,.asm_99bca ; 0x71b4b $b
	call Function71c07
	jr c,.asm_99bca ; 0x71b50 $6
	ld hl,$5d8d
	call PrintText
.asm_99bca ; 0x71b58
	ld hl,$cd12
	ld a,[hld]
	ld e,a
	ld d,$0
	ld a,[hld]
	ld l,[hl]
	ld h,a
	add hl,de
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp PrintText

Function71b6a: ; 0x71b6a
	push de
	ld [$d11e],a
	call GetMonName
	ld hl,$cd6d
	pop de
	ld bc,$b
	jp CopyData

TradeMons: ; 5B7B
; givemonster, getmonster, textstring, nickname (11 bytes), 14 bytes total
	db NIDORINO,  NIDORINA,  0,"TERRY@@@@@@"
	db ABRA,      MR_MIME,  0,"MARCEL@@@@@"
	db BUTTERFREE,BEEDRILL,  2,"CHIKUCHIKU@"
	db PONYTA,    SEEL,      0,"SAILOR@@@@@"
	db SPEAROW,   FARFETCH_D,2,"DUX@@@@@@@@"
	db SLOWBRO,   LICKITUNG, 0,"MARC@@@@@@@"
	db POLIWHIRL, JYNX,      1,"LOLA@@@@@@@"
	db RAICHU,    ELECTRODE, 1,"DORIS@@@@@@"
	db VENONAT,   TANGELA,   2,"CRINKLES@@@"
	db NIDORAN_M, NIDORAN_F, 2,"SPOT@@@@@@@"

Function71c07: ; 0x71c07
	xor a
	ld [$d07d],a
	dec a
	ld [$cfcb],a
	call $13fc
	push af
	call $5ca2
	pop af
	ld a,$1
	jp c,.asm_c4bc2
	ld a,[$cd0f]
	ld b,a
	ld a,[$cf91]
	cp b
	ld a,$2
	jr nz,.asm_c4bc2 ; 0x71c26 $75
	ld a,[$cf92]
	ld hl,$d18c
	ld bc,$002c
	call AddNTimes
	ld a,[hl]
	ld [$d127],a
	ld hl,$d737
	ld a,[W_WHICHTRADE]
	ld c,a
	ld b,$1
	ld a,$10
	call Predef
	ld hl,$5d88
	call PrintText
	ld a,[$cf92]
	push af
	ld a,[$d127]
	push af
	call $36c0
	call $5cc1
	ld a,$38
	call Predef
	pop af
	ld [$d127],a
	pop af
	ld [$cf92],a
	ld a,[$cd34]
	ld [$cf91],a
	xor a
	ld [$cc49],a
	ld [$cf95],a
	call $391f
	ld a,$80
	ld [$cc49],a
	call AddPokemonToParty
	call $5d19
	ld hl,$7d7d
	ld b,$5
	call Bankswitch
	call ClearScreen
	call $5ca2
	ld b,$3
	ld hl,$6edc
	call Bankswitch
	and a
	ld a,$3
	jr .asm_ee803 ; 0x71c9b $1
.asm_c4bc2 ; 0x71c9d
	scf
.asm_ee803 ; 0x71c9e
	ld [$cd12],a
	ret

INCBIN "baserom.gbc",$71ca2,$71d88 - $71ca2

UnnamedText_71d88: ; 0x71d88
    TX_FAR _UnnamedText_71d88
    db $50
; 0x71d88 + 5 bytes

INCBIN "baserom.gbc",$71d8d,$71d94 - $71d8d

UnnamedText_71d94: ; 0x71d94
    TX_FAR _UnnamedText_71d94
    db $50
; 0x71d94 + 5 bytes

UnnamedText_71d99: ; 0x71d99
    TX_FAR _UnnamedText_71d99
    db $50
; 0x71d99 + 5 bytes

UnnamedText_71d9e: ; 0x71d9e
    TX_FAR _UnnamedText_71d9e
    db $50
; 0x71d9e + 5 bytes

UnnamedText_71da3: ; 0x71da3
    TX_FAR _UnnamedText_71da3
    db $50
; 0x71da3 + 5 bytes

UnnamedText_71da8: ; 0x71da8
    TX_FAR _UnnamedText_71da8
    db $50
; 0x71da8 + 5 bytes

UnnamedText_71dad: ; 0x71dad
    TX_FAR _UnnamedText_71dad
    db $50
; 0x71dad + 5 bytes

UnnamedText_71db2: ; 0x71db2
    TX_FAR _UnnamedText_71db2
    db $50
; 0x71db2 + 5 bytes

UnnamedText_71db7: ; 0x71db7
    TX_FAR _UnnamedText_71db7
    db $50
; 0x71db7 + 5 bytes

UnnamedText_71dbc: ; 0x71dbc
    TX_FAR _UnnamedText_71dbc
    db $50
; 0x71dbc + 5 bytes

UnnamedText_71dc1: ; 0x71dc1
    TX_FAR _UnnamedText_71dc1
    db $50
; 0x71dc1 + 5 bytes

UnnamedText_71dc6: ; 0x71dc6
    TX_FAR _UnnamedText_71dc6
    db $50
; 0x71dc6 + 5 bytes

UnnamedText_71dcb: ; 0x71dcb
    TX_FAR _UnnamedText_71dcb
    db $50
; 0x71dcb + 5 bytes

UnnamedText_71dd0: ; 0x71dd0
    TX_FAR _UnnamedText_71dd0
    db $50
; 0x71dd0 + 5 bytes

UnnamedText_71dd5: ; 0x71dd5
    TX_FAR _UnnamedText_71dd5
    db $50
; 0x71dd5 + 5 bytes

UnnamedText_71dda: ; 0x71dda
    TX_FAR _UnnamedText_71dda
    db $50
; 0x71dda + 5 bytes

INCBIN "baserom.gbc",$71ddf,$7e9

MonsterPalettes: ; 65C8
	db PAL_MEWMON    ; MISSINGNO
	db PAL_GREENMON  ; BULBASAUR
	db PAL_GREENMON  ; IVYSAUR
	db PAL_GREENMON  ; VENUSAUR
	db PAL_REDMON    ; CHARMANDER
	db PAL_REDMON    ; CHARMELEON
	db PAL_REDMON    ; CHARIZARD
	db PAL_CYANMON   ; SQUIRTLE
	db PAL_CYANMON   ; WARTORTLE
	db PAL_CYANMON   ; BLASTOISE
	db PAL_GREENMON  ; CATERPIE
	db PAL_GREENMON  ; METAPOD
	db PAL_CYANMON   ; BUTTERFREE
	db PAL_YELLOWMON ; WEEDLE
	db PAL_YELLOWMON ; KAKUNA
	db PAL_YELLOWMON ; BEEDRILL
	db PAL_BROWNMON  ; PIDGEY
	db PAL_BROWNMON  ; PIDGEOTTO
	db PAL_BROWNMON  ; PIDGEOT
	db PAL_GREYMON   ; RATTATA
	db PAL_GREYMON   ; RATICATE
	db PAL_BROWNMON  ; SPEAROW
	db PAL_BROWNMON  ; FEAROW
	db PAL_PURPLEMON ; EKANS
	db PAL_PURPLEMON ; ARBOK
	db PAL_YELLOWMON ; PIKACHU
	db PAL_YELLOWMON ; RAICHU
	db PAL_BROWNMON  ; SANDSHREW
	db PAL_BROWNMON  ; SANDSLASH
	db PAL_BLUEMON   ; NIDORAN_F
	db PAL_BLUEMON   ; NIDORINA
	db PAL_BLUEMON   ; NIDOQUEEN
	db PAL_PURPLEMON ; NIDORAN_M
	db PAL_PURPLEMON ; NIDORINO
	db PAL_PURPLEMON ; NIDOKING
	db PAL_PINKMON   ; CLEFAIRY
	db PAL_PINKMON   ; CLEFABLE
	db PAL_REDMON    ; VULPIX
	db PAL_YELLOWMON ; NINETALES
	db PAL_PINKMON   ; JIGGLYPUFF
	db PAL_PINKMON   ; WIGGLYTUFF
	db PAL_BLUEMON   ; ZUBAT
	db PAL_BLUEMON   ; GOLBAT
	db PAL_GREENMON  ; ODDISH
	db PAL_REDMON    ; GLOOM
	db PAL_REDMON    ; VILEPLUME
	db PAL_REDMON    ; PARAS
	db PAL_REDMON    ; PARASECT
	db PAL_PURPLEMON ; VENONAT
	db PAL_PURPLEMON ; VENOMOTH
	db PAL_BROWNMON  ; DIGLETT
	db PAL_BROWNMON  ; DUGTRIO
	db PAL_YELLOWMON ; MEOWTH
	db PAL_YELLOWMON ; PERSIAN
	db PAL_YELLOWMON ; PSYDUCK
	db PAL_CYANMON   ; GOLDUCK
	db PAL_BROWNMON  ; MANKEY
	db PAL_BROWNMON  ; PRIMEAPE
	db PAL_BROWNMON  ; GROWLITHE
	db PAL_REDMON    ; ARCANINE
	db PAL_BLUEMON   ; POLIWAG
	db PAL_BLUEMON   ; POLIWHIRL
	db PAL_BLUEMON   ; POLIWRATH
	db PAL_YELLOWMON ; ABRA
	db PAL_YELLOWMON ; KADABRA
	db PAL_YELLOWMON ; ALAKAZAM
	db PAL_GREYMON   ; MACHOP
	db PAL_GREYMON   ; MACHOKE
	db PAL_GREYMON   ; MACHAMP
	db PAL_GREENMON  ; BELLSPROUT
	db PAL_GREENMON  ; WEEPINBELL
	db PAL_GREENMON  ; VICTREEBEL
	db PAL_CYANMON   ; TENTACOOL
	db PAL_CYANMON   ; TENTACRUEL
	db PAL_GREYMON   ; GEODUDE
	db PAL_GREYMON   ; GRAVELER
	db PAL_GREYMON   ; GOLEM
	db PAL_REDMON    ; PONYTA
	db PAL_REDMON    ; RAPIDASH
	db PAL_PINKMON   ; SLOWPOKE
	db PAL_PINKMON   ; SLOWBRO
	db PAL_GREYMON   ; MAGNEMITE
	db PAL_GREYMON   ; MAGNETON
	db PAL_BROWNMON  ; FARFETCH_D
	db PAL_BROWNMON  ; DODUO
	db PAL_BROWNMON  ; DODRIO
	db PAL_BLUEMON   ; SEEL
	db PAL_BLUEMON   ; DEWGONG
	db PAL_PURPLEMON ; GRIMER
	db PAL_PURPLEMON ; MUK
	db PAL_GREYMON   ; SHELLDER
	db PAL_GREYMON   ; CLOYSTER
	db PAL_PURPLEMON ; GASTLY
	db PAL_PURPLEMON ; HAUNTER
	db PAL_PURPLEMON ; GENGAR
	db PAL_GREYMON   ; ONIX
	db PAL_YELLOWMON ; DROWZEE
	db PAL_YELLOWMON ; HYPNO
	db PAL_REDMON    ; KRABBY
	db PAL_REDMON    ; KINGLER
	db PAL_YELLOWMON ; VOLTORB
	db PAL_YELLOWMON ; ELECTRODE
	db PAL_PINKMON   ; EXEGGCUTE
	db PAL_GREENMON  ; EXEGGUTOR
	db PAL_GREYMON   ; CUBONE
	db PAL_GREYMON   ; MAROWAK
	db PAL_BROWNMON  ; HITMONLEE
	db PAL_BROWNMON  ; HITMONCHAN
	db PAL_PINKMON   ; LICKITUNG
	db PAL_PURPLEMON ; KOFFING
	db PAL_PURPLEMON ; WEEZING
	db PAL_GREYMON   ; RHYHORN
	db PAL_GREYMON   ; RHYDON
	db PAL_PINKMON   ; CHANSEY
	db PAL_BLUEMON   ; TANGELA
	db PAL_BROWNMON  ; KANGASKHAN
	db PAL_CYANMON   ; HORSEA
	db PAL_CYANMON   ; SEADRA
	db PAL_REDMON    ; GOLDEEN
	db PAL_REDMON    ; SEAKING
	db PAL_REDMON    ; STARYU
	db PAL_GREYMON   ; STARMIE
	db PAL_PINKMON   ; MR_MIME
	db PAL_GREENMON  ; SCYTHER
	db PAL_MEWMON    ; JYNX
	db PAL_YELLOWMON ; ELECTABUZZ
	db PAL_REDMON    ; MAGMAR
	db PAL_BROWNMON  ; PINSIR
	db PAL_GREYMON   ; TAUROS
	db PAL_REDMON    ; MAGIKARP
	db PAL_BLUEMON   ; GYARADOS
	db PAL_CYANMON   ; LAPRAS
	db PAL_GREYMON   ; DITTO
	db PAL_GREYMON   ; EEVEE
	db PAL_CYANMON   ; VAPOREON
	db PAL_YELLOWMON ; JOLTEON
	db PAL_REDMON    ; FLAREON
	db PAL_GREYMON   ; PORYGON
	db PAL_BLUEMON   ; OMANYTE
	db PAL_BLUEMON   ; OMASTAR
	db PAL_BROWNMON  ; KABUTO
	db PAL_BROWNMON  ; KABUTOPS
	db PAL_GREYMON   ; AERODACTYL
	db PAL_PINKMON   ; SNORLAX
	db PAL_BLUEMON   ; ARTICUNO
	db PAL_YELLOWMON ; ZAPDOS
	db PAL_REDMON    ; MOLTRES
	db PAL_GREYMON   ; DRATINI
	db PAL_BLUEMON   ; DRAGONAIR
	db PAL_BROWNMON  ; DRAGONITE
	db PAL_MEWMON    ; MEWTWO
	db PAL_MEWMON    ; MEW

; palettes for overworlds, title screen, monsters
SuperPalettes: ; 6660
	RGB 31,29,31 ; PAL_ROUTE
	RGB 21,28,11
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_PALLET
	RGB 25,28,27
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_VIRIDIAN
	RGB 17,26,3
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_PEWTER
	RGB 23,25,16
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_CERULEAN
	RGB 17,20,30
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_LAVENDER
	RGB 27,20,27
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_VERMILION
	RGB 30,18,0
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_CELADON
	RGB 16,30,22
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_FUCHSIA
	RGB 31,15,22
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_CINNABAR
	RGB 26,10,6
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_INDIGO
	RGB 22,14,24
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; PAL_SAFFRON
	RGB 27,27,3
	RGB 20,26,31
	RGB 3,2,2
	RGB 31,29,31 ; XXX
	RGB 20,26,31
	RGB 17,23,10
	RGB 3,2,2
	IF _RED
		RGB 31,29,31 ; PAL_LOGO1
		RGB 30,30,17
		RGB 17,23,10
		RGB 21,0,4
	ENDC
	IF _BLUE
		RGB 31,29,31 ; PAL_LOGO1
		RGB 30,30,17
		RGB 21,0,4
		RGB 14,19,29
	ENDC
	RGB 31,29,31 ; XXX
	RGB 30,30,17
	RGB 18,18,24
	RGB 7,7,16
	RGB 31,29,31 ; PAL_LOGO2
	RGB 24,20,30
	RGB 11,20,30
	RGB 3,2,2
	RGB 31,29,31 ; PAL_MEWMON
	RGB 30,22,17
	RGB 16,14,19
	RGB 3,2,2
	RGB 31,29,31 ; PAL_BLUEMON
	RGB 18,20,27
	RGB 11,15,23
	RGB 3,2,2
	RGB 31,29,31 ; PAL_REDMON
	RGB 31,20,10
	RGB 26,10,6
	RGB 3,2,2
	RGB 31,29,31 ; PAL_CYANMON
	RGB 21,25,29
	RGB 14,19,25
	RGB 3,2,2
	RGB 31,29,31 ; PAL_PURPLEMON
	RGB 27,22,24
	RGB 21,15,23
	RGB 3,2,2
	RGB 31,29,31 ; PAL_BROWNMON
	RGB 28,20,15
	RGB 21,14,9
	RGB 3,2,2
	RGB 31,29,31 ; PAL_GREENMON
	RGB 20,26,16
	RGB 9,20,11
	RGB 3,2,2
	RGB 31,29,31 ; PAL_PINKMON
	RGB 30,22,24
	RGB 28,15,21
	RGB 3,2,2
	RGB 31,29,31 ; PAL_YELLOWMON
	RGB 31,28,14
	RGB 26,20,0
	RGB 3,2,2
	RGB 31,29,31 ; PAL_GREYMON
	RGB 26,21,22
	RGB 15,15,18
	RGB 3,2,2
	RGB 31,29,31 ; PAL_SLOTS1
	RGB 26,21,22
	RGB 27,20,6
	RGB 3,2,2
	RGB 31,29,31 ; PAL_SLOTS2
	RGB 31,31,17
	IF _RED
		RGB 25,17,21
	ENDC
	IF _BLUE
		RGB 16,19,29
	ENDC
	RGB 3,2,2
	RGB 31,29,31 ; PAL_SLOTS3
	RGB 22,31,16
	IF _RED
		RGB 25,17,21
	ENDC
	IF _BLUE
		RGB 16,19,29
	ENDC
	RGB 3,2,2
	RGB 31,29,31 ; PAL_SLOTS4
	IF _RED
		RGB 16,19,29
		RGB 25,17,21
	ENDC
	IF _BLUE
		RGB 25,17,21
		RGB 16,19,29
	ENDC
	RGB 3,2,2
	RGB 31,29,31 ; PAL_BLACK
	RGB 7,7,7
	RGB 2,3,3
	RGB 3,2,2
	RGB 31,29,31 ; PAL_GREENBAR
	RGB 30,26,15
	RGB 9,20,11
	RGB 3,2,2
	RGB 31,29,31 ; PAL_YELLOWBAR
	RGB 30,26,15
	RGB 26,20,0
	RGB 3,2,2
	RGB 31,29,31 ; PAL_REDBAR
	RGB 30,26,15
	RGB 26,10,6
	RGB 3,2,2
	RGB 31,29,31 ; PAL_BADGE
	RGB 30,22,17
	RGB 11,15,23
	RGB 3,2,2
	RGB 31,29,31 ; PAL_CAVE
	RGB 21,14,9
	RGB 18,24,22
	RGB 3,2,2
	RGB 31,29,31 ; XXX
	RGB 31,28,14
	RGB 24,20,10
	RGB 3,2,2
BorderPalettes: ; 6788

IF _RED
	INCBIN "gfx/red/sgbborder.map"
ENDC
IF _BLUE
	INCBIN "gfx/blue/sgbborder.map"
ENDC

INCBIN "baserom.gbc",$72E88,$2F88 - $2E88 ; All $00s
IF _RED
	RGB 30,29,29 ; PAL_SGB1
	RGB 25,22,25
	RGB 25,17,21
	RGB 24,14,12
ENDC
IF _BLUE
	RGB 0,0,0 ; PAL_SGB1 (the first color is not defined, but if used, turns up as 30,29,29... o_O)
	RGB 10,17,26
	RGB 5,9,20
	RGB 16,20,27
ENDC

INCBIN "baserom.gbc",$72F90,$2FA8 - $2F90 ; All $00s

IF _RED
	RGB 30,29,29 ; PAL_SGB2
	RGB 22,31,16
	RGB 27,20,6
	RGB 15,15,15
ENDC
IF _BLUE
	RGB 30,29,29 ; PAL_SGB2
	RGB 27,11,6
	RGB 5,9,20
	RGB 28,25,15
ENDC

INCBIN "baserom.gbc",$72FB0,$2FC8 - $2FB0 ; All $00s

IF _RED
	RGB 30,29,29 ; PAL_SGB3
	RGB 31,31,17
	RGB 18,21,29
	RGB 15,15,15
ENDC
IF _BLUE
	RGB 30,29,29 ; PAL_SGB3
	RGB 12,15,11
	RGB 5,9,20
	RGB 14,22,17
ENDC

INCBIN "baserom.gbc",$72FD0,$2FE8 - $2FD0 ; All $00s

IF _RED
	INCBIN "gfx/red/sgbborder.2bpp"
ENDC
IF _BLUE
	INCBIN "gfx/blue/sgbborder.2bpp"
ENDC

INCBIN "baserom.gbc",$735e8,$7361e - $735e8

UnnamedText_7361e: ; 0x7361e
    TX_FAR _UnnamedText_7361e
    db $50
; 0x7361e + 5 bytes

INCBIN "baserom.gbc",$73623,$7377d - $73623

UnnamedText_7377d: ; 0x7377d
    TX_FAR _UnnamedText_7377d
    db $50
; 0x7377d + 5 bytes

UnnamedText_73782: ; 0x73782
    TX_FAR _UnnamedText_73782
    db $50
; 0x73782 + 5 bytes

UnnamedText_73787: ; 0x73787
    TX_FAR _UnnamedText_73787
    db $50
; 0x73787 + 5 bytes

INCBIN "baserom.gbc",$7378c,$73909 - $7378c

UnnamedText_73909: ; 0x73909
    TX_FAR _UnnamedText_73909
    db $50
; 0x73909 + 5 bytes

INCBIN "baserom.gbc",$7390e,$739d4 - $7390e

UnnamedText_739d4: ; 0x739d4
    TX_FAR _UnnamedText_739d4
    db $50
; 0x739d4 + 5 bytes

INCBIN "baserom.gbc",$739d9,$627

SECTION "bank1D",DATA,BANK[$1D]

CopycatsHouseF1Blocks:
    INCBIN "maps/copycatshousef1.blk"

CinnabarMartBlocks:
PewterMartBlocks: ; 16
    INCBIN "maps/pewtermart.blk"

FuchsiaHouse1Blocks: ; 16
    INCBIN "maps/fuchsiahouse1.blk"

CinnabarPokecenterBlocks:
FuchsiaPokecenterBlocks: ; 28
    INCBIN "maps/fuchsiapokecenter.blk"

CeruleanHouse3Blocks: ; 16
    INCBIN "maps/ceruleanhouse3.blk"

INCBIN "baserom.gbc",$7405c,$6f

Func40CB: ; 40CB
	xor a
	ld [$FFBA],a
	call $3719
	call $4183

	; display the next monster from CreditsMons
	ld hl,$CD3E
	ld c,[hl] ; how many monsters have we displayed so far?
	inc [hl]
	ld b,0
	ld hl,CreditsMons
	add hl,bc ; go that far in the list of monsters and get the next one
	ld a,[hl]
	ld [$CF91],a
	ld [$D0B5],a
	ld hl,$C420
	call $1537
	call $1389
	ld hl,$980C
	call $4164
	xor a
	ld [$FFBA],a
	call $3725
	ld hl,$9800
	call $4164
	ld a,$A7
	ld [$FF4B],a
	ld hl,$9C00
	call $4164
	call $4183
	ld a,$FC
	ld [$FF47],a
	ld bc,7
.next\@
	call $4140
	dec c
	jr nz,.next\@
	ld c,$14
.next2\@
	call $4140
	ld a,[$FF4B]
	sub 8
	ld [$FF4B],a
	dec c
	jr nz,.next2\@
	xor a
	ld [$FFB0],a
	ld a,$C0
	ld [$FF47],a
	ret

CreditsMons: ; 4131
	db VENUSAUR
	db ARBOK
	db RHYHORN
	db FEAROW
	db ABRA
	db GRAVELER
	db HITMONLEE
	db TANGELA
	db STARMIE
	db GYARADOS
	db DITTO
	db OMASTAR
	db VILEPLUME
	db NIDOKING
	db PARASECT

INCBIN "baserom.gbc",$74140,$2C3 - $140

CreditsTextPointers: ; 42C3

	dw CredVersion
	dw CredTajiri
	dw CredTaOota
	dw CredMorimoto
	dw CredWatanabe
	dw CredMasuda
	dw CredNisino
	dw CredSugimori
	dw CredNishida
	dw CredMiyamoto
	dw CredKawaguchi
	dw CredIshihara
	dw CredYamauchi
	dw CredZinnai
	dw CredHishida
	dw CredSakai
	dw CredYamaguchi
	dw CredYamamoto
	dw CredTaniguchi
	dw CredNonomura
	dw CredFuziwara
	dw CredMatsusima
	dw CredTomisawa
	dw CredKawamoto
	dw CredKakei
	dw CredTsuchiya
	dw CredTaNakamura
	dw CredYuda
	dw CredMon
	dw CredDirector
	dw CredProgrammers
	dw CredCharDesign
	dw CredMusic
	dw CredSoundEffects
	dw CredGameDesign
	dw CredMonsterDesign
	dw CredGameScene
	dw CredParam
	dw CredMap
	dw CredTest
	dw CredSpecial
	dw CredProducers
	dw CredProducer
	dw CredExecutive
	dw CredTamada
	dw CredSaOota
	dw CredYoshikawa
	dw CredToOota
	dw CredUSStaff
	dw CredUSCoord
	dw CredTilden
	dw CredKawakami
	dw CredHiNakamura
	dw CredGiese
	dw CredOsborne
	dw CredTrans
	dw CredOgasawara
	dw CredIwata
	dw CredIzushi
	dw CredHarada
	dw CredMurakawa
	dw CredFukui
	dw CredClub
	dw CredPAAD

CredVersion:
IF _RED
	db "2RED VERSION STAFF@"
ENDC
IF _BLUE
	db "2BLUE VERSION STAFF@"
ENDC
CredTajiri:
	db "4SATOSHI TAJIRI@"
CredTaOota:
	db "4TAKENORI OOTA@"
CredMorimoto:
	db "3SHIGEKI MORIMOTO@"
CredWatanabe:
	db "3TETSUYA WATANABE@"
CredMasuda:
	db "4JUNICHI MASUDA@"
CredNisino:
	db "5KOHJI NISINO@"
CredSugimori:
	db "5KEN SUGIMORI@"
CredNishida:
	db "4ATSUKO NISHIDA@"
CredMiyamoto:
	db "3SHIGERU MIYAMOTO@"
CredKawaguchi:
	db "2TAKASHI KAWAGUCHI@"
CredIshihara:
	db "2TSUNEKAZU ISHIHARA@"
CredYamauchi:
	db "3HIROSHI YAMAUCHI@"
CredZinnai:
	db "3HIROYUKI ZINNAI@"
CredHishida:
	db "3TATSUYA HISHIDA@"
CredSakai:
	db "4YASUHIRO SAKAI@"
CredYamaguchi:
	db "3WATARU YAMAGUCHI@"
CredYamamoto:
	db "2KAZUYUKI YAMAMOTO@"
CredTaniguchi:
	db "2RYOHSUKE TANIGUCHI@"
CredNonomura:
	db "2FUMIHIRO NONOMURA@"
CredFuziwara:
	db "3MOTOFUMI FUZIWARA@"
CredMatsusima:
	db "3KENJI MATSUSIMA@"
CredTomisawa:
	db "3AKIHITO TOMISAWA@"
CredKawamoto:
	db "3HIROSHI KAWAMOTO@"
CredKakei:
	db "4AKIYOSHI KAKEI@"
CredTsuchiya:
	db "3KAZUKI TSUCHIYA@"
CredTaNakamura:
	db "4TAKEO NAKAMURA@"
CredYuda:
	db "4MASAMITSU YUDA@"
CredMon:
	db "7#MON@"
CredDirector:
	db "7DIRECTOR@"
CredProgrammers:
	db "5PROGRAMMERS@"
CredCharDesign:
	db "3CHARACTER DESIGN@"
CredMusic:
	db "8MUSIC@"
CredSoundEffects:
	db "4SOUND EFFECTS@"
CredGameDesign:
	db "5GAME DESIGN@"
CredMonsterDesign:
	db "4MONSTER DESIGN@"
CredGameScene:
	db "4GAME SCENARIO@"
CredParam:
	db "2PARAMETRIC DESIGN@"
CredMap:
	db "6MAP DESIGN@"
CredTest:
	db "3PRODUCT TESTING@"
CredSpecial:
	db "4SPECIAL THANKS@"
CredProducers:
	db "6PRODUCERS@"
CredProducer:
	db "6PRODUCER@"
CredExecutive:
	db "2EXECUTIVE PRODUCER@"
CredTamada:
	db "4SOUSUKE TAMADA@"
CredSaOota:
	db "5SATOSHI OOTA@"
CredYoshikawa:
	db "4RENA YOSHIKAWA@"
CredToOota:
	db "4TOMOMICHI OOTA@"
CredUSStaff:
	db "3US VERSION STAFF@"
CredUSCoord:
	db "3US COORDINATION@"
CredTilden:
	db "5GAIL TILDEN@"
CredKawakami:
	db "4NAOKO KAWAKAMI@"
CredHiNakamura:
	db "4HIRO NAKAMURA@"
CredGiese:
	db "4WILLIAM GIESE@"
CredOsborne:
	db "5SARA OSBORNE@"
CredTrans:
	db "3TEXT TRANSLATION@"
CredOgasawara:
	db "4NOB OGASAWARA@"
CredIwata:
	db "5SATORU IWATA@"
CredIzushi:
	db "3TAKEHIRO IZUSHI@"
CredHarada:
	db "3TAKAHIRO HARADA@"
CredMurakawa:
	db "3TERUKI MURAKAWA@"
CredFukui:
	db "5KOHTA FUKUI@"
CredClub:
	db "1NCL SUPER MARIO CLUB@"
CredPAAD:
	db "5PAAD TESTING@"

TheEndGfx: ; 473E
	INCBIN "gfx/theend.2bpp"

INCBIN "baserom.gbc",$747de,$74897 - $747de

ViridianGym_h: ; 0x74897 to 0x748a3 (12 bytes) (id=45)
    db $07 ; tileset
    db VIRIDIAN_GYM_HEIGHT, VIRIDIAN_GYM_WIDTH ; dimensions (y, x)
    dw ViridianGymBlocks, ViridianGymTexts, ViridianGymScript ; blocks, texts, scripts
    db $00 ; connections

    dw ViridianGymObject ; objects

ViridianGymScript: ; 0x748a3
    ld hl, Gym8CityName
    ld de, Gym8LeaderName
    call $317f
    call $3c3c
    ld hl, $4a08
    ld de, $48e1
    ld a, [$d5fb]
    call $3160
    ld [$d5fb], a
    ret
; 0x748bf

Gym8CityName:
	db "VIRIDIAN CITY@"
Gym8LeaderName:
	db "GIOVANNI@"

INCBIN "baserom.gbc",$748D6,$116

ViridianGymTexts: ; 0x749ec
    dw ViridianGymText1, ViridianGymText2, ViridianGymText3, ViridianGymText4, ViridianGymText5, ViridianGymText6, ViridianGymText7, ViridianGymText8, ViridianGymText9, ViridianGymText10, ViridianGymText11, ViridianGymText12, ViridianGymText13, ViridianGymText14

INCBIN "baserom.gbc",$74a02 + 6,$67 - 6

ViridianGymText1: ; 0x74a69
    db $08 ; asm
    ld a, [$d751]
    bit 1, a
    jr z, .asm_6de66 ; 0x74a6f
    bit 0, a
    jr nz, .asm_9fc95 ; 0x74a73
    call z, $4995
    call $30b6
    jr .asm_6dff7 ; 0x74a7b
.asm_9fc95 ; 0x74a7d
    ld a, $1
    ld [$cc3c], a
    ld hl, $4ad9
    call PrintText
    call $20ef
    ld a, $32
    ld [$cc4d], a
    ld a, $11
    call Predef
    call $2429
    call Delay3
    call $20d1
    jr .asm_6dff7 ; 0x74a9e
.asm_6de66 ; 0x74aa0
    ld hl, $4ace
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $4ad3
    ld de, $4ad3
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    ld a, $8
    ld [$d05c], a
    ld a, $3
    ld [$d5fb], a
.asm_6dff7 ; 0x74acb
    jp $24d7

UnnamedText_74ace: ; 0x74ace
    TX_FAR _UnnamedText_74ace
    db $50
; 0x74ace + 5 bytes

UnnamedText_74ad3: ; 0x74ad3
    TX_FAR _UnnamedText_74ad3
    db $0b, $50
; 0x74ad3 + 6 bytes

UnnamedText_74ad8:
	TX_FAR _UnnamedText_74ad8
	db $0d, $50

ViridianGymText12: ; 0x74adf
    TX_FAR _ViridianGymText12
    db $50
; 0x74adf + 5 bytes

ViridianGymText13: ; 0x74ae4
	TX_FAR _UnnamedText_74ae4
	db $0b

UnnamedText_74ae9:
	TX_FAR _UnnamedText_74ae9
	db $50

ViridianGymText14: ; 0x74aee
    TX_FAR _UnnamedText_74aee
    db $50
; 0x74aee + 5 bytes

ViridianGymText2: ; 0x74af3
    db $08 ; asm
    ld hl, $4a08
    call LoadTrainerHeader
    jp $24d7

UnnamedText_74afd: ; 0x74afd
    TX_FAR _UnnamedText_74afd
    db $50
; 0x74afd + 5 bytes

UnnamedText_74b02: ; 0x74b02
    TX_FAR _UnnamedText_74b02
    db $50
; 0x74b02 + 5 bytes

UnnamedText_74b07: ; 0x74b07
    TX_FAR _UnnamedText_74b07
    db $50
; 0x74b07 + 5 bytes

ViridianGymText3: ; 0x74b0c
    db $08 ; asm
    ld hl, $4a14
    call LoadTrainerHeader
    jp $24d7

UnnamedText_74b16: ; 0x74b16
    TX_FAR _UnnamedText_74b16
    db $50
; 0x74b16 + 5 bytes

UnnamedText_74b1b: ; 0x74b1b
    TX_FAR _UnnamedText_74b1b
    db $50
; 0x74b1b + 5 bytes

UnnamedText_74b20: ; 0x74b20
    TX_FAR _UnnamedText_74b20
    db $50
; 0x74b20 + 5 bytes

ViridianGymText4: ; 0x74b25
    db $08 ; asm
    ld hl, $4a20
    call LoadTrainerHeader
    jp $24d7

UnnamedText_74b2f: ; 0x74b2f
    TX_FAR _UnnamedText_74b2f
    db $50
; 0x74b2f + 5 bytes

UnnamedText_74b34: ; 0x74b34
    TX_FAR _UnnamedText_74b34
    db $50
; 0x74b34 + 5 bytes

UnnamedText_74b39: ; 0x74b39
    TX_FAR _UnnamedText_74b39
    db $50
; 0x74b39 + 5 bytes

ViridianGymText5: ; 0x74b3e
    db $08 ; asm
    ld hl, $4a2c
    call LoadTrainerHeader
    jp $24d7

UnnamedText_74b48: ; 0x74b48
    TX_FAR _UnnamedText_74b48
    db $50
; 0x74b48 + 5 bytes

UnnamedText_74b4d: ; 0x74b4d
    TX_FAR _UnnamedText_74b4d
    db $50
; 0x74b4d + 5 bytes

UnnamedText_74b52: ; 0x74b52
    TX_FAR _UnnamedText_74b52
    db $50
; 0x74b52 + 5 bytes

ViridianGymText6: ; 0x74b57
    db $08 ; asm
    ld hl, $4a38
    call LoadTrainerHeader
    jp $24d7

UnnamedText_74b61: ; 0x74b61
    TX_FAR _UnnamedText_74b61
    db $50
; 0x74b61 + 5 bytes

UnnamedText_74b66: ; 0x74b66
    TX_FAR _UnnamedText_74b66
    db $50
; 0x74b66 + 5 bytes

UnnamedText_74b6b: ; 0x74b6b
    TX_FAR _UnnamedText_74b6b
    db $50
; 0x74b6b + 5 bytes

ViridianGymText7: ; 0x74b70
    db $08 ; asm
    ld hl, $4a44
    call LoadTrainerHeader
    jp $24d7

UnnamedText_74b7a: ; 0x74b7a
    TX_FAR _UnnamedText_74b7a
    db $50
; 0x74b7a + 5 bytes

UnnamedText_74b7f: ; 0x74b7f
    TX_FAR _UnnamedText_74b7f
    db $50
; 0x74b7f + 5 bytes

UnnamedText_74b84: ; 0x74b84
    TX_FAR _UnnamedText_74b84
    db $50
; 0x74b84 + 5 bytes

ViridianGymText8: ; 0x74b89
    db $08 ; asm
    ld hl, $4a50
    call LoadTrainerHeader
    jp $24d7

UnnamedText_74b93: ; 0x74b93
    TX_FAR _UnnamedText_74b93
    db $50
; 0x74b93 + 5 bytes

UnnamedText_74b98: ; 0x74b98
    TX_FAR _UnnamedText_74b98
    db $50
; 0x74b98 + 5 bytes

UnnamedText_74b9d: ; 0x74b9d
    TX_FAR _UnnamedText_74b9d
    db $50
; 0x74b9d + 5 bytes

ViridianGymText9: ; 0x74ba2
    db $08 ; asm
    ld hl, $4a5c
    call LoadTrainerHeader
    jp $24d7

UnnamedText_74bac: ; 0x74bac
    TX_FAR _UnnamedText_74bac
    db $50
; 0x74bac + 5 bytes

UnnamedText_74bb1: ; 0x74bb1
    TX_FAR _UnnamedText_74bb1
    db $50
; 0x74bb1 + 5 bytes

UnnamedText_74bb6: ; 0x74bb6
    TX_FAR _UnnamedText_74bb6
    db $50
; 0x74bb6 + 5 bytes

ViridianGymText10: ; 0x74bbb
    db $08 ; asm
    ld a, [$d751]
    bit 1, a
    jr nz, .asm_1abd1 ; 0x74bc1
    ld hl, $4bd4
    call PrintText
    jr .asm_6064d ; 0x74bc9
.asm_1abd1 ; 0x74bcb
    ld hl, $4bd9
    call PrintText
.asm_6064d ; 0x74bd1
    jp $24d7

UnnamedText_74bd4: ; 0x74bd4
    TX_FAR _UnnamedText_74bd4
    db $50
; 0x74bd4 + 5 bytes

UnnamedText_74bd9: ; 0x74bd9
    TX_FAR _UnnamedText_74bd9
    db $50
; 0x74bd9 + 5 bytes

ViridianGymObject: ; 0x74bde (size=105)
    db $3 ; border tile

    db $2 ; warps
    db $11, $10, $4, $ff
    db $11, $11, $4, $ff

    db $0 ; signs

    db $b ; people
    db SPRITE_GIOVANNI, $1 + 4, $2 + 4, $ff, $d0, $41, GIOVANNI + $C8, $3 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $7 + 4, $c + 4, $ff, $d0, $42, COOLTRAINER_M + $C8, $9 ; trainer
    db SPRITE_HIKER, $b + 4, $b + 4, $ff, $d1, $43, BLACKBELT + $C8, $6 ; trainer
    db SPRITE_ROCKER, $7 + 4, $a + 4, $ff, $d0, $44, TAMER + $C8, $3 ; trainer
    db SPRITE_HIKER, $7 + 4, $3 + 4, $ff, $d2, $45, BLACKBELT + $C8, $7 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $5 + 4, $d + 4, $ff, $d3, $46, COOLTRAINER_M + $C8, $a ; trainer
    db SPRITE_HIKER, $1 + 4, $a + 4, $ff, $d0, $47, BLACKBELT + $C8, $8 ; trainer
    db SPRITE_ROCKER, $10 + 4, $2 + 4, $ff, $d3, $48, TAMER + $C8, $4 ; trainer
    db SPRITE_BLACK_HAIR_BOY_1, $5 + 4, $6 + 4, $ff, $d0, $49, COOLTRAINER_M + $C8, $1 ; trainer
    db SPRITE_GYM_HELPER, $f + 4, $10 + 4, $ff, $d0, $a ; person
	db SPRITE_BALL, $9 + 4, $10 + 4, $ff, $ff, $8b, REVIVE ; item

    ; warp-to
    EVENT_DISP $a, $11, $10
    EVENT_DISP $a, $11, $11

ViridianGymBlocks: ; 90
    INCBIN "maps/viridiangym.blk"

PewterMart_h: ; 0x74ca1 to 0x74cad (12 bytes) (id=56)
    db $02 ; tileset
    db PEWTER_MART_HEIGHT, PEWTER_MART_WIDTH ; dimensions (y, x)
    dw PewterMartBlocks, PewterMartTexts, PewterMartScript ; blocks, texts, scripts
    db $00 ; connections

    dw PewterMartObject ; objects

PewterMartScript: ; 0x74cad
    call $3c3c
    ld a, $1
    ld [$cf0c], a
    ret
; 0x74cb6

PewterMartTexts: ; 0x74cb6
    dw PewterMartText1, PewterMartText2, PewterMartText3

PewterMartText2: ; 0x74cbc
    db $08 ; asm
    ld hl, $4cc6
    call PrintText
    jp $24d7

UnnamedText_74cc6: ; 0x74cc6
    TX_FAR _UnnamedText_74cc6
    db $50
; 0x74cc6 + 5 bytes

PewterMartText3: ; 0x74ccb
    db $08 ; asm
    ld hl, $4cd5
    call PrintText
    jp $24d7

UnnamedText_74cd5: ; 0x74cd5
    TX_FAR _UnnamedText_74cd5
    db $50
; 0x74cd5 + 5 bytes

PewterMartObject: ; 0x74cda (size=38)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $4, $ff
    db $7, $4, $4, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_MART_GUY, $5 + 4, $0 + 4, $ff, $d3, $1 ; person
    db SPRITE_BUG_CATCHER, $3 + 4, $3 + 4, $fe, $1, $2 ; person
    db SPRITE_BLACK_HAIR_BOY_2, $5 + 4, $5 + 4, $ff, $ff, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4

UnknownDungeon1_h: ; 0x74d00 to 0x74d0c (12 bytes) (id=228)
    db $11 ; tileset
    db UNKNOWN_DUNGEON_1_HEIGHT, UNKNOWN_DUNGEON_1_WIDTH ; dimensions (y, x)
    dw UnknownDungeon1Blocks, UnknownDungeon1Texts, UnknownDungeon1Script ; blocks, texts, scripts
    db $00 ; connections

    dw UnknownDungeon1Object ; objects

UnknownDungeon1Script: ; 0x74d0c
    jp $3c3c
; 0x74d0f

UnknownDungeon1Texts: ; 0x74d0f
    dw UnknownDungeon1Text1, UnknownDungeon1Text2, UnknownDungeon1Text3

UnknownDungeon1Object: ; 0x74d15 (size=97)
    db $7d ; border tile

    db $9 ; warps
    db $11, $18, $6, $ff
    db $11, $19, $6, $ff
    db $1, $1b, $0, UNKNOWN_DUNGEON_2
    db $7, $17, $1, UNKNOWN_DUNGEON_2
    db $9, $12, $2, UNKNOWN_DUNGEON_2
    db $1, $7, $3, UNKNOWN_DUNGEON_2
    db $3, $1, $4, UNKNOWN_DUNGEON_2
    db $b, $3, $5, UNKNOWN_DUNGEON_2
    db $6, $0, $0, UNKNOWN_DUNGEON_3

    db $0 ; signs

    db $3 ; people
	db SPRITE_BALL, $d + 4, $7 + 4, $ff, $ff, $81, FULL_RESTORE ; item
	db SPRITE_BALL, $3 + 4, $13 + 4, $ff, $ff, $82, MAX_ELIXER ; item
	db SPRITE_BALL, $0 + 4, $5 + 4, $ff, $ff, $83, NUGGET ; item

    ; warp-to
    EVENT_DISP $f, $11, $18
    EVENT_DISP $f, $11, $19
    EVENT_DISP $f, $1, $1b ; UNKNOWN_DUNGEON_2
    EVENT_DISP $f, $7, $17 ; UNKNOWN_DUNGEON_2
    EVENT_DISP $f, $9, $12 ; UNKNOWN_DUNGEON_2
    EVENT_DISP $f, $1, $7 ; UNKNOWN_DUNGEON_2
    EVENT_DISP $f, $3, $1 ; UNKNOWN_DUNGEON_2
    EVENT_DISP $f, $b, $3 ; UNKNOWN_DUNGEON_2
    EVENT_DISP $f, $6, $0 ; UNKNOWN_DUNGEON_3

UnknownDungeon1Blocks: ; 135
    INCBIN "maps/unknowndungeon1.blk"

CeruleanHouse3_h: ; 0x74dfd to 0x74e09 (12 bytes) (id=230)
    db $0d ; tileset
    db CERULEAN_HOUSE_3_HEIGHT, CERULEAN_HOUSE_3_WIDTH ; dimensions (y, x)
    dw CeruleanHouse3Blocks, CeruleanHouse3Texts, CeruleanHouse3Script ; blocks, texts, scripts
    db $00 ; connections

    dw CeruleanHouse3Object ; objects

CeruleanHouse3Script: ; 0x74e09
    ld a, $1
    ld [$cf0c], a
    dec a
    ld [$cc3c], a
    ret
; 0x74e13

CeruleanHouse3Texts:
    dw CeruleanHouse3Text1

CeruleanHouse3Text1: ; 0x74e15
    db $8
    ld hl, $4e77
    call PrintText
    xor a
    ld [$cc26], a
    ld [$cc36], a
.asm_74e23
    ld hl, $4e7c
    call PrintText
    ld hl, $4e6d
    call $2a5a
    ld hl, $cf7b
    ld a, l
    ld [$cf8b], a
    ld a, h
    ld [$cf8c], a
    xor a
    ld [$cf93], a
    ld [$cc35], a
    ld a, $4
    ld [$cf94], a
    call $2be6
    jr c, .asm_74e60 ; 0x74e49 $15
    ld hl, $4e86
    ld a, [$cf91]
    sub $15
    add a
    ld d, $0
    ld e, a
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    call PrintText
    jr .asm_74e23 ; 0x74e5e $c3
.asm_74e60
    xor a
    ld [$cc36], a
    ld hl, $4e81
    call PrintText
    jp $24d7
; 0x74e6d

db $8,BOULDERBADGE,CASCADEBADGE,THUNDERBADGE,RAINBOWBADGE,SOULBADGE,MARSHBADGE,VOLCANOBADGE,EARTHBADGE,$FF

UnnamedText_74e77: ; 0x74e77
    TX_FAR _UnnamedText_74e77
    db $50
; 0x74e77 + 5 bytes

UnnamedText_74e7c: ; 0x74e7c
    TX_FAR _UnnamedText_74e7c
    db $50
; 0x74e7c + 5 bytes

UnnamedText_74e81: ; 0x74e81
    TX_FAR _UnnamedText_74e81
    db $50
; 0x74e81 + 5 bytes

INCBIN "baserom.gbc",$74e86,$74e96 - $74e86

UnnamedText_74e96: ; 0x74e96
    TX_FAR _UnnamedText_74e96
    db $50
; 0x74e96 + 5 bytes

UnnamedText_74e9b: ; 0x74e9b
    TX_FAR _UnnamedText_74e9b
    db $50
; 0x74e9b + 5 bytes

UnnamedText_74ea0: ; 0x74ea0
    TX_FAR _UnnamedText_74ea0
    db $50
; 0x74ea0 + 5 bytes

UnnamedText_74ea5: ; 0x74ea5
    TX_FAR _UnnamedText_74ea5
    db $50
; 0x74ea5 + 5 bytes

UnnamedText_74eaa: ; 0x74eaa
    TX_FAR _UnnamedText_74eaa
    db $50
; 0x74eaa + 5 bytes

UnnamedText_74eaf: ; 0x74eaf
    TX_FAR _UnnamedText_74eaf
    db $50
; 0x74eaf + 5 bytes

UnnamedText_74eb4: ; 0x74eb4
    TX_FAR _UnnamedText_74eb4
    db $50
; 0x74eb4 + 5 bytes

UnnamedText_74eb9: ; 0x74eb9
    TX_FAR _UnnamedText_74eb9
    db $50
; 0x74eb9 + 5 bytes

CeruleanHouse3Object: ; 0x74ebe (size=34)
    db $c ; border tile

    db $3 ; warps
    db $0, $2, $9, $ff
    db $7, $2, $8, $ff
    db $7, $3, $8, $ff

    db $0 ; signs

    db $1 ; people
    db SPRITE_FAT_BALD_GUY, $3 + 4, $5 + 4, $ff, $d3, $1 ; person

    ; warp-to
    EVENT_DISP $4, $0, $2
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

INCBIN "baserom.gbc",$74ee0,$B9

UnnamedText_74f99: ; 0x74f99
    TX_FAR _UnnamedText_74f99
    db $50
; 0x74f99 + 5 bytes

	db "FRESH WATER",$4E
	db "SODA POP",$4E
	db "LEMONADE",$4E
	db "CANCEL@"
	db $F0,"200",$4E
	db $F0,"300",$4E
	db $F0,"350",$4E,"@"

UnnamedText_74fd3: ; 0x74fd3
    TX_FAR _UnnamedText_74fd3
    db $50
; 0x74fd3 + 5 bytes

UnnamedText_74fd8: ; 0x74fd8
    TX_FAR _UnnamedText_74fd8
    db $50
; 0x74fd8 + 5 bytes

UnnamedText_74fdd: ; 0x74fdd
    TX_FAR _UnnamedText_74fdd
    db $50
; 0x74fdd + 5 bytes

UnnamedText_74fe2: ; 0x74fe2
    TX_FAR _UnnamedText_74fe2
    db $50
; 0x74fe2 + 5 bytes

INCBIN "baserom.gbc",$74fe7,$25

FuchsiaHouse1_h: ; 0x7500c to 0x75018 (12 bytes) (id=153)
    db $08 ; tileset
    db FUCHSIA_HOUSE_1_HEIGHT, FUCHSIA_HOUSE_1_WIDTH ; dimensions (y, x)
    dw FuchsiaHouse1Blocks, FuchsiaHouse1Texts, FuchsiaHouse1Script ; blocks, texts, scripts
    db $00 ; connections

    dw FuchsiaHouse1Object ; objects

FuchsiaHouse1Script: ; 0x75018
    call $3c3c
    ret
; 0x7501c

FuchsiaHouse1Texts: ; 0x7501c
    dw FuchsiaHouse1Text1, FuchsiaHouse1Text2, FuchsiaHouse1Text3

FuchsiaHouse1Text1: ; 0x75022
    TX_FAR _FuchsiaHouse1Text1
    db $50

FuchsiaHouse1Text2: ; 0x75027
    TX_FAR _FuchsiaHouse1Text2
    db $50

FuchsiaHouse1Text3: ; 0x7502c
    TX_FAR _FuchsiaHouse1Text3
    db $50

FuchsiaHouse1Object: ; 0x75031 (size=38)
    db $a ; border tile

    db $2 ; warps
    db $7, $2, $1, $ff
    db $7, $3, $1, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_MOM_GEISHA, $3 + 4, $2 + 4, $ff, $d3, $1 ; person
    db SPRITE_GAMBLER, $2 + 4, $7 + 4, $ff, $d1, $2 ; person
    db SPRITE_BUG_CATCHER, $5 + 4, $5 + 4, $ff, $ff, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3

FuchsiaPokecenter_h: ; 0x75057 to 0x75063 (12 bytes) (id=154)
    db $06 ; tileset
    db FUCHSIA_POKECENTER_HEIGHT, FUCHSIA_POKECENTER_WIDTH ; dimensions (y, x)
    dw FuchsiaPokecenterBlocks, FuchsiaPokecenterTexts, FuchsiaPokecenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw FuchsiaPokecenterObject ; objects

FuchsiaPokecenterScript: ; 0x75063
    call $22fa
    jp $3c3c
; 0x75069

FuchsiaPokecenterTexts:
    dw FuchsiaPokecenterText1, FuchsiaPokecenterText2, FuchsiaPokecenterText3, FuchsiaPokecenterText4

FuchsiaPokecenterText1: ; 0x75071
    db $ff

FuchsiaPokecenterText2: ; 0x75072
    TX_FAR _FuchsiaPokecenterText1
    db $50

FuchsiaPokecenterText3: ; 0x75077
    TX_FAR _FuchsiaPokecenterText3
    db $50

FuchsiaPokecenterText4: ; 0x7507c
    db $f6

FuchsiaPokecenterObject: ; 0x7507d (size=44)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $2, $ff
    db $7, $4, $2, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_ROCKER, $3 + 4, $2 + 4, $ff, $ff, $2 ; person
    db SPRITE_LASS, $5 + 4, $6 + 4, $fe, $2, $3 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

FuchsiaHouse2_h: ; 0x750a9 to 0x750b5 (12 bytes) (id=155)
    db $14 ; tileset
    db FUCHSIA_HOUSE_2_HEIGHT, FUCHSIA_HOUSE_2_WIDTH ; dimensions (y, x)
    dw FuchsiaHouse2Blocks, FuchsiaHouse2Texts, FuchsiaHouse2Script ; blocks, texts, scripts
    db $00 ; connections

    dw FuchsiaHouse2Object ; objects

FuchsiaHouse2Script: ; 0x750b5
    jp $3c3c
; 0x750b8

FuchsiaHouse2Texts: ; 0x750b8
    dw FuchsiaHouse2Text1, FuchsiaHouse2Text2, FuchsiaHouse2Text3, FuchsiaHouse2Text4, FuchsiaHouse2Text5

FuchsiaHouse2Text1: ; 0x750c2
    db $08 ; asm
    ld a, [$d78e]
    bit 0, a
    jr nz, .asm_58feb ; 0x750c8
    ld b,GOLD_TEETH
    call $3493
    jr nz, .asm_3f30f ; 0x750cf
    ld a, [$d78e]
    bit 1, a
    jr nz, .asm_60cba ; 0x750d6
    ld hl, $5135
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    ld hl, $513f
    jr nz, .asm_61238 ; 0x750e8
    ld hl, $513a
.asm_61238 ; 0x750ed
    call PrintText
    jr .asm_52039 ; 0x750f0
.asm_3f30f ; 0x750f2
    ld hl, $5144
    call PrintText
    ld a, $40
    ldh [$db], a
    ld b, $5 ; BANK(MyFunction)
    ld hl, $7f37 ; MyFunction
    call Bankswitch
    ld hl, $d78e
    set 1, [hl]
.asm_60cba ; 0x75109
    ld hl, $514e
    call PrintText
    ld bc,(HM_04 << 8) | 1
    call $3e2e
    jr nc, .asm_53b90 ; 0x75115
    ld hl, $5153
    call PrintText
    ld hl, $d78e
    set 0, [hl]
    jr .asm_52039 ; 0x75122
.asm_58feb ; 0x75124
    ld hl, $5159
    call PrintText
    jr .asm_52039 ; 0x7512a
.asm_53b90 ; 0x7512c
    ld hl, $515e
    call PrintText
.asm_52039 ; 0x75132
    jp $24d7

UnnamedText_75135: ; 0x75135
    TX_FAR _UnnamedText_75135
    db $50
; 0x75135 + 5 bytes

UnnamedText_7513a: ; 0x7513a
    TX_FAR _UnnamedText_7513a
    db $50
; 0x7513a + 5 bytes

UnnamedText_7513f: ; 0x7513f
    TX_FAR _UnnamedText_7513f
    db $50
; 0x7513f + 5 bytes

UnnamedText_75144: ; 0x75144
    TX_FAR _UnnamedText_75144
    db $0b

UnnamedText_75149: ; 0x75149
    TX_FAR _UnnamedText_75149
    db $50
; 0x75149 + 5 bytes

UnnamedText_7514e: ; 0x7514e
    TX_FAR _UnnamedText_7514e
    db $50
; 0x7514e + 5 bytes

UnnamedText_75153: ; 0x75153
    TX_FAR UnnamedText_9e5a2 ; 0x9e5a2
    db $0B, $50
; 0x75153 + 6 bytes = 0x75159

UnnamedText_75159: ; 0x75159
    TX_FAR _UnnamedText_75159
    db $50
; 0x75159 + 5 bytes

UnnamedText_7515e: ; 0x7515e
    TX_FAR _UnnamedText_7515e
    db $50
; 0x7515e + 5 bytes

FuchsiaHouse2Text5:
FuchsiaHouse2Text4: ; 0x75163
    db $08 ; asm
    ldh a, [$8c]
    cp $4
    ld hl, $517b
    jr nz, .asm_4c9a2 ; 0x7516b
    ld hl, $5176
.asm_4c9a2 ; 0x75170
    call PrintText
    jp $24d7

UnnamedText_75176: ; 0x75176
    TX_FAR _UnnamedText_75176
    db $50
; 0x75176 + 5 bytes

UnnamedText_7517b: ; 0x7517b
    TX_FAR _UnnamedText_7517b
    db $50
; 0x7517b + 5 bytes

FuchsiaHouse2Object: ; 0x75180 (size=45)
    db $17 ; border tile

    db $2 ; warps
    db $7, $4, $3, $ff
    db $7, $5, $3, $ff

    db $2 ; signs
    db $3, $4, $4 ; FuchsiaHouse2Text4
    db $3, $5, $5 ; FuchsiaHouse2Text5

    db $3 ; people
    db SPRITE_WARDEN, $3 + 4, $2 + 4, $ff, $ff, $1 ; person
	db SPRITE_BALL, $3 + 4, $8 + 4, $ff, $ff, $82, RARE_CANDY ; item
    db SPRITE_BOULDER, $4 + 4, $8 + 4, $ff, $10, $3 ; person

    ; warp-to
    EVENT_DISP $5, $7, $4
    EVENT_DISP $5, $7, $5

FuchsiaHouse2Blocks: ; 20
    INCBIN "maps/fuchsiahouse2.blk"

SafariZoneEntrance_h: ; 0x751c1 to 0x751cd (12 bytes) (id=156)
    db $0c ; tileset
    db SAFARIZONEENTRANCE_HEIGHT, SAFARIZONEENTRANCE_WIDTH ; dimensions (y, x)
    dw SafariZoneEntranceBlocks, SafariZoneEntranceTexts, SafariZoneEntranceScript ; blocks, texts, scripts
    db $00 ; connections

    dw SafariZoneEntranceObject ; objects

SafariZoneEntranceScript: ; 0x751cd
    call $3c3c
    ld hl, $51d9
    ld a, [$d61f]
    jp $3d97
; 0x751d9

SafariZoneEntranceScripts: ; 0x751d9
    dw SafariZoneEntranceScript0, SafariZoneEntranceScript1

INCBIN "baserom.gbc",$751dd,$a

SafariZoneEntranceScript0: ; 0x751e7
    ld hl, $5221
    call $34bf
    ret nc
    ld a, $3
    ld [$ff00+$8c], a
    call $2920
    ld a, $ff
    ld [$cd6b], a
    xor a
    ld [$ff00+$b4], a
    ld a, $c
    ld [$c109], a
    ld a, [$cd3d]
    cp $1
    jr z, .asm_7520f ; 0x75207 $6
    ld a, $2
    ld [$d61f], a
    ret
.asm_7520f
    ld a, $10
    ld c, $1
    call $52a3
    ld a, $f0
    ld [$cd6b], a
    ld a, $1
    ld [$d61f], a
    ret
; 0x75221

INCBIN "baserom.gbc",$75221,$75226 - $75221

SafariZoneEntranceScript1: ; 0x75226
    call $52b4
    ret nz
    xor a
    ld [$ff00+$b4], a
    ld [$cd6b], a
    call $2429
    ld a, $4
    ld [$ff00+$8c], a
    call $2920
    ld a, $ff
    ld [$cd6b], a
    ret
; 0x75240

INCBIN "baserom.gbc",$75240,$79

SafariZoneEntranceTexts: ; 0x752b9
    dw SafariZoneEntranceText1, SafariZoneEntranceText2, SafariZoneEntranceText3, SafariZoneEntranceText4, SafariZoneEntranceText5, SafariZoneEntranceText6

SafariZoneEntranceText3:
SafariZoneEntranceText1: ; 0x752c5
    TX_FAR _SafariZoneEntranceText1
    db $50

SafariZoneEntranceText4: ; 0x752ca
    TX_FAR UnnamedText_9e6e4 ; 0x9e6e4
    db $8
    ld a, $13
    ld [$d125], a
    call $30e8
    call $35ec
    ld a, [$cc26]
    and a
    jp nz, $5346
    xor a
    ld [$ff00+$9f], a
    ld a, $5
    ld [$ff00+$a0], a
    ld a, $0
    ld [$ff00+$a1], a
    call $35a6
    jr nc, .asm_752f9 ; 0x752ef $8
    ld hl, $536a
    call PrintText
    jr .asm_7534c ; 0x752f7 $53
.asm_752f9
    xor a
    ld [$cd3d], a
    ld a, $5
    ld [$cd3e], a
    ld a, $0
    ld [$cd3f], a
    ld hl, $cd3f
    ld de, $d349
    ld c, $3
    ld a, $c
    call Predef
    ld a, $13
    ld [$d125], a
    call $30e8
    ld hl, $535b
    call PrintText
    ld a, $1e
    ld [$da47], a
    ld a, $1
    ld [$d70d], a
    ld a, $f6
    ld [$d70e], a
    ld a, $40
    ld c, $3
    call $52a3
    ld hl, $d790
    set 7, [hl]
    res 6, [hl]
    ld a, $3
    ld [$d61f], a
    jr .asm_75358 ; 0x75344 $12
    ld hl, $5365
    call PrintText
.asm_7534c
    ld a, $80
    ld c, $1
    call $52a3
    ld a, $4
    ld [$d61f], a
.asm_75358
    jp $24d7
; 0x7535b

UnnamedText_7535b: ; 0x7535b
    TX_FAR UnnamedText_9e747 ; 0x9e747
    db $0B

UnnamedText_75360: ; 0x75360
    TX_FAR _UnnamedText_75360
    db $50
; 0x75360 + 5 bytes

UnnamedText_75365: ; 0x75365
    TX_FAR _UnnamedText_75365
    db $50
; 0x75365 + 5 bytes

UnnamedText_7536a: ; 0x7536a
    TX_FAR _UnnamedText_7536a
    db $50
; 0x7536a + 5 bytes

SafariZoneEntranceText5: ; 0x7536f
    TX_FAR UnnamedText_9e814 ; 0x9e814
    db $8
    call $35ec
    ld a, [$cc26]
    and a
    jr nz, .asm_7539c ; 0x7537b $1f
    ld hl, $53bb
    call PrintText
    xor a
    ld [$c109], a
    ld a, $80
    ld c, $3
    call $52a3
    ld hl, $d790
    res 6, [hl]
    res 7, [hl]
    ld a, $0
    ld [$cf0d], a
    jr .asm_753b3 ; 0x7539a $17
.asm_7539c
    ld hl, $53c0
    call PrintText
    ld a, $4
    ld [$c109], a
    ld a, $40
    ld c, $1
    call $52a3
    ld a, $5
    ld [$cf0d], a
.asm_753b3
    ld a, $6
    ld [$d61f], a
    jp $24d7
; 0x753bb

UnnamedText_753bb: ; 0x753bb
    TX_FAR _UnnamedText_753bb
    db $50
; 0x753bb + 5 bytes

UnnamedText_753c0: ; 0x753c0
    TX_FAR _UnnamedText_753c0
    db $50
; 0x753c0 + 5 bytes

SafariZoneEntranceText6: ; 0x753c5
    TX_FAR _UnnamedText_753c5
    db $50
; 0x753c5 + 5 bytes

SafariZoneEntranceText2: ; 0x753ca
    db $08 ; asm
    ld hl, $53e6
    call PrintText
    call $35ec
    ld a, [$cc26]
    and a
    ld hl, $53f0
    jr nz, .asm_278a6 ; 0x753db
    ld hl, $53eb
.asm_278a6 ; 0x753e0
    call PrintText
    jp $24d7

UnnamedText_753e6: ; 0x753e6
    TX_FAR _UnnamedText_753e6
    db $50
; 0x753e6 + 5 bytes

UnnamedText_753eb: ; 0x753eb
    TX_FAR _UnnamedText_753eb
    db $50
; 0x753eb + 5 bytes

UnnamedText_753f0: ; 0x753f0
    TX_FAR _UnnamedText_753f0
    db $50
; 0x753f0 + 5 bytes

SafariZoneEntranceObject: ; 0x753f5 (size=48)
    db $a ; border tile

    db $4 ; warps
    db $5, $3, $4, $ff
    db $5, $4, $4, $ff
    db $0, $3, $0, SAFARI_ZONE_CENTER
    db $0, $4, $1, SAFARI_ZONE_CENTER

    db $0 ; signs

    db $2 ; people
    db SPRITE_WHITE_PLAYER, $2 + 4, $6 + 4, $ff, $d2, $1 ; person
    db SPRITE_WHITE_PLAYER, $4 + 4, $1 + 4, $ff, $d3, $2 ; person

    ; warp-to
    EVENT_DISP $4, $5, $3
    EVENT_DISP $4, $5, $4
    EVENT_DISP $4, $0, $3 ; SAFARI_ZONE_CENTER
    EVENT_DISP $4, $0, $4 ; SAFARI_ZONE_CENTER

SafariZoneEntranceBlocks: ; 12
    INCBIN "maps/safarizoneentrance.blk"

FuchsiaGym_h: ; 0x75431 to 0x7543d (12 bytes) (id=157)
    db $07 ; tileset
    db FUCHSIA_GYM_HEIGHT, FUCHSIA_GYM_WIDTH ; dimensions (y, x)
    dw FuchsiaGymBlocks, FuchsiaGymTexts, FuchsiaGymScript ; blocks, texts, scripts
    db $00 ; connections

    dw FuchsiaGymObject ; objects

FuchsiaGymScript: ; 0x7543d
    call $5453
    call $3c3c
    ld hl, $54eb
    ld de, $5482
    ld a, [$d65b]
    call $3160
    ld [$d65b], a
    ret
; 0x75453

INCBIN "baserom.gbc",$75453,$12

Gym5CityName:
	db "FUCHSIA CITY@"
Gym5LeaderName:
	db "KOGA@"

INCBIN "baserom.gbc",$75477,$5E

FuchsiaGymTexts: ; 0x754d5
    dw FuchsiaGymText1, FuchsiaGymText2, FuchsiaGymText3, FuchsiaGymText4, FuchsiaGymText5, FuchsiaGymText6, FuchsiaGymText7, FuchsiaGymText8, FuchsiaGymText9, FuchsiaGymText10, FuchsiaGymText11

INCBIN "baserom.gbc",$754eb,$49

FuchsiaGymText1: ; 0x75534
    db $08 ; asm
    ld a, [$d792]
    bit 1, a
    jr z, .asm_181b6 ; 0x7553a
    bit 0, a
    jr nz, .asm_adc3b ; 0x7553e
    call z, $5497
    call $30b6
    jr .asm_e84c6 ; 0x75546
.asm_adc3b ; 0x75548
    ld hl, $558b
    call PrintText
    jr .asm_e84c6 ; 0x7554e
.asm_181b6 ; 0x75550
    ld hl, $5581
    call PrintText
    ld hl, $d72d
    set 6, [hl]
    set 7, [hl]
    ld hl, $5586
    ld de, $5586
    call $3354
    ldh a, [$8c]
    ld [$cf13], a
    call $336a
    call $32d7
    ld a, $5
    ld [$d05c], a
    xor a
    ldh [$b4], a
    ld a, $3
    ld [$d65b], a
.asm_e84c6 ; 0x7557e
    jp $24d7

UnnamedText_75581: ; 0x75581
    TX_FAR _UnnamedText_75581
    db $50
; 0x75581 + 5 bytes

UnnamedText_75586: ; 0x75586
    TX_FAR _UnnamedText_75586
    db $50
; 0x75586 + 5 bytes

UnnamedText_7558b: ; 0x7558b
    TX_FAR _UnnamedText_7558b
    db $50
; 0x7558b + 5 bytes

FuchsiaGymText9: ; 0x75590
    TX_FAR _UnnamedText_75590
    db $50
; 0x75590 + 5 bytes

FuchsiaGymText10: ; 0x75595
    TX_FAR UnnamedText_a00eb ; 0xa00eb
    db $11

UnnamedText_7559a: ; 0x7559a
    TX_FAR _UnnamedText_7559a
    db $50
; 0x7559a + 5 bytes

FuchsiaGymText11: ; 0x7559f
    TX_FAR _UnnamedText_7559f
    db $50
; 0x7559f + 5 bytes

FuchsiaGymText2: ; 0x755a4
    db $08 ; asm
    ld hl, $54eb
    call LoadTrainerHeader
    jp $24d7

UnnamedText_755ae: ; 0x755ae
    TX_FAR _UnnamedText_755ae
    db $50
; 0x755ae + 5 bytes

UnnamedText_755b3: ; 0x755b3
    TX_FAR _UnnamedText_755b3
    db $50
; 0x755b3 + 5 bytes

UnnamedText_755b8: ; 0x755b8
    TX_FAR _UnnamedText_755b8
    db $50
; 0x755b8 + 5 bytes

FuchsiaGymText3: ; 0x755bd
    db $08 ; asm
    ld hl, $54f7
    call LoadTrainerHeader
    jp $24d7

UnnamedText_755c7: ; 0x755c7
    TX_FAR _UnnamedText_755c7
    db $50
; 0x755c7 + 5 bytes

UnnamedText_755cc: ; 0x755cc
    TX_FAR _UnnamedText_755cc
    db $50
; 0x755cc + 5 bytes

UnnamedText_755d1: ; 0x755d1
    TX_FAR _UnnamedText_755d1
    db $50
; 0x755d1 + 5 bytes

FuchsiaGymText4: ; 0x755d6
    db $08 ; asm
    ld hl, $5503
    call LoadTrainerHeader
    jp $24d7

UnnamedText_755e0: ; 0x755e0
    TX_FAR _UnnamedText_755e0
    db $50
; 0x755e0 + 5 bytes

UnnamedText_755e5: ; 0x755e5
    TX_FAR _UnnamedText_755e5
    db $50
; 0x755e5 + 5 bytes

UnnamedText_755ea: ; 0x755ea
    TX_FAR _UnnamedText_755ea
    db $50
; 0x755ea + 5 bytes

FuchsiaGymText5: ; 0x755ef
    db $08 ; asm
    ld hl, $550f
    call LoadTrainerHeader
    jp $24d7

UnnamedText_755f9: ; 0x755f9
    TX_FAR _UnnamedText_755f9
    db $50
; 0x755f9 + 5 bytes

UnnamedText_755fe: ; 0x755fe
    TX_FAR _UnnamedText_755fe
    db $50
; 0x755fe + 5 bytes

UnnamedText_75603: ; 0x75603
    TX_FAR _UnnamedText_75603
    db $50
; 0x75603 + 5 bytes

FuchsiaGymText6: ; 0x75608
    db $08 ; asm
    ld hl, $551b
    call LoadTrainerHeader
    jp $24d7

UnnamedText_75612: ; 0x75612
    TX_FAR _UnnamedText_75612
    db $50
; 0x75612 + 5 bytes

UnnamedText_75617: ; 0x75617
    TX_FAR _UnnamedText_75617
    db $50
; 0x75617 + 5 bytes

UnnamedText_7561c: ; 0x7561c
    TX_FAR _UnnamedText_7561c
    db $50
; 0x7561c + 5 bytes

FuchsiaGymText7: ; 0x75621
    db $08 ; asm
    ld hl, $5527
    call LoadTrainerHeader
    jp $24d7

UnnamedText_7562b: ; 0x7562b
    TX_FAR _UnnamedText_7562b
    db $50
; 0x7562b + 5 bytes

UnnamedText_75630: ; 0x75630
    TX_FAR _UnnamedText_75630
    db $50
; 0x75630 + 5 bytes

UnnamedText_75635: ; 0x75635
    TX_FAR _UnnamedText_75635
    db $50
; 0x75635 + 5 bytes

FuchsiaGymText8: ; 0x7563a
    db $08 ; asm
    ld a, [$d792]
    bit 1, a
    ld hl, $5653
    jr nz, .asm_50671 ; 0x75643
    ld hl, $564e
.asm_50671 ; 0x75648
    call PrintText
    jp $24d7

UnnamedText_7564e: ; 0x7564e
    TX_FAR _UnnamedText_7564e
    db $50
; 0x7564e + 5 bytes

UnnamedText_75653: ; 0x75653
    TX_FAR _UnnamedText_75653
    db $50
; 0x75653 + 5 bytes

FuchsiaGymObject: ; 0x75658 (size=82)
    db $3 ; border tile

    db $2 ; warps
    db $11, $4, $5, $ff
    db $11, $5, $5, $ff

    db $0 ; signs

    db $8 ; people
    db SPRITE_BLACKBELT, $a + 4, $4 + 4, $ff, $d0, $41, KOGA + $C8, $1 ; trainer
    db SPRITE_ROCKER, $d + 4, $8 + 4, $ff, $d0, $42, JUGGLER + $C8, $7 ; trainer
    db SPRITE_ROCKER, $8 + 4, $7 + 4, $ff, $d3, $43, JUGGLER + $C8, $3 ; trainer
    db SPRITE_ROCKER, $c + 4, $1 + 4, $ff, $d0, $44, JUGGLER + $C8, $8 ; trainer
    db SPRITE_ROCKER, $5 + 4, $3 + 4, $ff, $d1, $45, TAMER + $C8, $1 ; trainer
    db SPRITE_ROCKER, $2 + 4, $8 + 4, $ff, $d0, $46, TAMER + $C8, $2 ; trainer
    db SPRITE_ROCKER, $7 + 4, $2 + 4, $ff, $d2, $47, JUGGLER + $C8, $4 ; trainer
    db SPRITE_GYM_HELPER, $f + 4, $7 + 4, $ff, $d0, $8 ; person

    ; warp-to
    EVENT_DISP $5, $11, $4
    EVENT_DISP $5, $11, $5

FuchsiaGymBlocks: ; 45
    INCBIN "maps/fuchsiagym.blk"

FuchsiaMeetingRoom_h: ; 0x756d7 to 0x756e3 (12 bytes) (id=158)
    db $14 ; tileset
    db FUCHSIAMEETINGROOM_HEIGHT, FUCHSIAMEETINGROOM_WIDTH ; dimensions (y, x)
    dw FuchsiaMeetingRoomBlocks, FuchsiaMeetingRoomTexts, FuchsiaMeetingRoomScript ; blocks, texts, scripts
    db $00 ; connections

    dw FuchsiaMeetingRoomObject ; objects

FuchsiaMeetingRoomScript: ; 0x756e3
    call $3c3c
    ret
; 0x756e7

FuchsiaMeetingRoomTexts: ; 0x756e7
    dw FuchsiaMeetingRoomText1, FuchsiaMeetingRoomText2, FuchsiaMeetingRoomText3

FuchsiaMeetingRoomText1: ; 0x756ed
    TX_FAR _FuchsiaMeetingRoomText1
    db $50

FuchsiaMeetingRoomText2: ; 0x756f2
    TX_FAR _FuchsiaMeetingRoomText2
    db $50

FuchsiaMeetingRoomText3: ; 0x756f7
    TX_FAR _FuchsiaMeetingRoomText3
    db $50

FuchsiaMeetingRoomObject: ; 0x756fc (size=38)
    db $17 ; border tile

    db $2 ; warps
    db $7, $4, $6, $ff
    db $7, $5, $6, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_WHITE_PLAYER, $1 + 4, $4 + 4, $ff, $d0, $1 ; person
    db SPRITE_WHITE_PLAYER, $2 + 4, $0 + 4, $ff, $d1, $2 ; person
    db SPRITE_WHITE_PLAYER, $1 + 4, $a + 4, $ff, $d0, $3 ; person

    ; warp-to
    EVENT_DISP $7, $7, $4
    EVENT_DISP $7, $7, $5

FuchsiaMeetingRoomBlocks: ; 28
    INCBIN "maps/fuchsiameetingroom.blk"

CinnabarGym_h: ; 0x7573e to 0x7574a (12 bytes) (id=166)
    db $16 ; tileset
    db CINNABAR_GYM_HEIGHT, CINNABAR_GYM_WIDTH ; dimensions (y, x)
    dw CinnabarGymBlocks, CinnabarGymTexts, CinnabarGymScript ; blocks, texts, scripts
    db $00 ; connections

    dw CinnabarGymObject ; objects

CinnabarGymScript: ; 0x7574a
    call $5759
    call $3c3c
    ld hl, $57a6
    ld a, [$d65e]
    jp $3d97
; 0x75759

INCBIN "baserom.gbc",$75759,$7577B - $75759

Gym7CityName:
	db "CINNABAR ISLAND@"
Gym7LeaderName:
	db "BLAINE@"

INCBIN "baserom.gbc",$75792,$757a6 - $75792

CinnabarGymScripts: ; 0x757a6
    dw CinnabarGymScript0, CinnabarGymScript1

INCBIN "baserom.gbc",$757aa,$4

CinnabarGymScript0: ; 0x757ae
    ld a, [$da38]
    and a
    ret z
    ld [$ff00+$8c], a
    cp $4
    jr nz, .asm_757c3 ; 0x757b7 $a
    ld a, $4
    ld [$d528], a
    ld de, $57d7
    jr .asm_757cb ; 0x757c1 $8
.asm_757c3
    ld de, $57da
    ld a, $1
    ld [$d528], a
.asm_757cb
    call $363a
    ld a, $1
    ld [$d65e], a
    ld [$da39], a
    ret
; 0x757d7

INCBIN "baserom.gbc",$757d7,$757dc - $757d7

CinnabarGymScript1: ; 0x757dc
    ld a, [$d730]
    bit 0, a
    ret nz
    xor a
    ld [$cd6b], a
    ld a, [$da38]
    ld [$cc55], a
    ld [$ff00+$8c], a
    jp $2920
; 0x757f1

INCBIN "baserom.gbc",$757f1,$ae

CinnabarGymTexts: ; 0x7589f
    dw CinnabarGymText1, CinnabarGymText2, CinnabarGymText3, CinnabarGymText4, CinnabarGymText5, CinnabarGymText6, CinnabarGymText7, CinnabarGymText8, CinnabarGymText9
;CinnabarGymText 10: ; 0x75925
;CinnabarGymText 11: ; 0x7592a
;CinnabarGymText 12: ; 0x75934

INCBIN "baserom.gbc",$758b1,$2e

CinnabarGymText1: ; 0x758df
    db $8
    ld a, [$d79a]
    bit 1, a
    jr z, .asm_d9332 ; 0x758e5 $16
    bit 0, a
    jr nz, .asm_3012f ; 0x758e9 $9
    call z, $5857
    call $30b6
    jp $24d7
.asm_3012f ; 0x758f4
    ld hl, $5920
    call PrintText
    jp $24d7
.asm_d9332 ; 0x758fd
    ld hl, $5914
    call PrintText
    ld hl, $5919
    ld de, $5919
    call $3354
    ld a, $7
    ld [$d05c], a
    jp $58b7
; 0x75914

UnnamedText_75914: ; 0x75914
    TX_FAR _UnnamedText_75914
    db $50
; 0x75914 + 5 bytes

UnnamedText_75919: ; 0x75919
    TX_FAR UnnamedText_a08c7
    db $11
    db $d
    db $50

UnnamedText_75920: ; 0x75920
    TX_FAR _UnnamedText_75920
    db $50
; 0x75920 + 5 bytes

UnnamedText_75925: ; 0x75925
    TX_FAR _UnnamedText_75925
    db $50
; 0x75925 + 5 bytes

UnnamedText_7592a: ; 0x7592a
    TX_FAR UnnamedText_a09a8 ; 0xa09a8
    db $0B
    TX_FAR _UnnamedText_7592f
    db $50
; 0x75934

UnnamedText_75934: ; 0x75934
    TX_FAR _UnnamedText_75934
    db $50
; 0x75934 + 5 bytes

CinnabarGymText2: ; 0x75939
    db $08 ; asm
    call $57a0
    ld a, [$d79a]
    bit 2, a
    jr nz, .asm_46bb4 ; 0x75942
    ld hl, $595f
    call PrintText
    ld hl, $5964
    ld de, $5964
    call $3354
    jp $58b7
.asm_46bb4 ; 0x75956
    ld hl, $5969
    call PrintText
    jp $24d7

UnnamedText_7595f: ; 0x7595f
    TX_FAR _UnnamedText_7595f
    db $50
; 0x7595f + 5 bytes

UnnamedText_75964: ; 0x75964
    TX_FAR _UnnamedText_75964
    db $50
; 0x75964 + 5 bytes

UnnamedText_75969: ; 0x75969
    TX_FAR _UnnamedText_75969
    db $50
; 0x75969 + 5 bytes

CinnabarGymText3: ; 0x7596e
    db $08 ; asm
    call $57a0
    ld a, [$d79a]
    bit 3, a
    jr nz, .asm_4b406 ; 0x75977
    ld hl, $5994
    call PrintText
    ld hl, $5999
    ld de, $5999
    call $3354
    jp $58b7
.asm_4b406 ; 0x7598b
    ld hl, $599e
    call PrintText
    jp $24d7

UnnamedText_75994: ; 0x75994
    TX_FAR _UnnamedText_75994
    db $50
; 0x75994 + 5 bytes

UnnamedText_75999: ; 0x75999
    TX_FAR _UnnamedText_75999
    db $50
; 0x75999 + 5 bytes

UnnamedText_7599e: ; 0x7599e
    TX_FAR _UnnamedText_7599e
    db $50
; 0x7599e + 5 bytes

CinnabarGymText4: ; 0x759a3
    db $08 ; asm
    call $57a0
    ld a, [$d79a]
    bit 4, a
    jr nz, .asm_c0673 ; 0x759ac
    ld hl, $59c9
    call PrintText
    ld hl, $59ce
    ld de, $59ce
    call $3354
    jp $58b7
.asm_c0673 ; 0x759c0
    ld hl, $59d3
    call PrintText
    jp $24d7

UnnamedText_759c9: ; 0x759c9
    TX_FAR _UnnamedText_759c9
    db $50
; 0x759c9 + 5 bytes

UnnamedText_759ce: ; 0x759ce
    TX_FAR _UnnamedText_759ce
    db $50
; 0x759ce + 5 bytes

UnnamedText_759d3: ; 0x759d3
    TX_FAR _UnnamedText_759d3
    db $50
; 0x759d3 + 5 bytes

CinnabarGymText5: ; 0x759d8
    db $08 ; asm
    call $57a0
    ld a, [$d79a]
    bit 5, a
    jr nz, .asm_5cfd7 ; 0x759e1
    ld hl, $59fe
    call PrintText
    ld hl, $5a03
    ld de, $5a03
    call $3354
    jp $58b7
.asm_5cfd7 ; 0x759f5
    ld hl, $5a08
    call PrintText
    jp $24d7

UnnamedText_759fe: ; 0x759fe
    TX_FAR _UnnamedText_759fe
    db $50
; 0x759fe + 5 bytes

UnnamedText_75a03: ; 0x75a03
    TX_FAR _UnnamedText_75a03
    db $50
; 0x75a03 + 5 bytes

UnnamedText_75a08: ; 0x75a08
    TX_FAR _UnnamedText_75a08
    db $50
; 0x75a08 + 5 bytes

CinnabarGymText6: ; 0x75a0d
    db $08 ; asm
    call $57a0
    ld a, [$d79a]
    bit 6, a
    jr nz, .asm_776b4 ; 0x75a16
    ld hl, $5a33
    call PrintText
    ld hl, $5a38
    ld de, $5a38
    call $3354
    jp $58b7
.asm_776b4 ; 0x75a2a
    ld hl, $5a3d
    call PrintText
    jp $24d7

UnnamedText_75a33: ; 0x75a33
    TX_FAR _UnnamedText_75a33
    db $50
; 0x75a33 + 5 bytes

UnnamedText_75a38: ; 0x75a38
    TX_FAR _UnnamedText_75a38
    db $50
; 0x75a38 + 5 bytes

UnnamedText_75a3d: ; 0x75a3d
    TX_FAR _UnnamedText_75a3d
    db $50
; 0x75a3d + 5 bytes

CinnabarGymText7: ; 0x75a42
    db $08 ; asm
    call $57a0
    ld a, [$d79a]
    bit 7, a
    jr nz, .asm_2f755 ; 0x75a4b
    ld hl, $5a68
    call PrintText
    ld hl, $5a6d
    ld de, $5a6d
    call $3354
    jp $58b7
.asm_2f755 ; 0x75a5f
    ld hl, $5a72
    call PrintText
    jp $24d7

UnnamedText_75a68: ; 0x75a68
    TX_FAR _UnnamedText_75a68
    db $50
; 0x75a68 + 5 bytes

UnnamedText_75a6d: ; 0x75a6d
    TX_FAR _UnnamedText_75a6d
    db $50
; 0x75a6d + 5 bytes

UnnamedText_75a72: ; 0x75a72
    TX_FAR _UnnamedText_75a72
    db $50
; 0x75a72 + 5 bytes

CinnabarGymText8: ; 0x75a77
    db $08 ; asm
    call $57a0
    ld a, [$d79b]
    bit 0, a
    jr nz, .asm_d87be ; 0x75a80
    ld hl, $5a9d
    call PrintText
    ld hl, $5aa2
    ld de, $5aa2
    call $3354
    jp $58b7
.asm_d87be ; 0x75a94
    ld hl, $5aa7
    call PrintText
    jp $24d7

UnnamedText_75a9d: ; 0x75a9d
    TX_FAR _UnnamedText_75a9d
    db $50
; 0x75a9d + 5 bytes

UnnamedText_75aa2: ; 0x75aa2
    TX_FAR _UnnamedText_75aa2
    db $50
; 0x75aa2 + 5 bytes

UnnamedText_75aa7: ; 0x75aa7
    TX_FAR _UnnamedText_75aa7
    db $50
; 0x75aa7 + 5 bytes

CinnabarGymText9: ; 0x75aac
    db $08 ; asm
    ld a, [$d79a]
    bit 1, a
    jr nz, .asm_627d9 ; 0x75ab2
    ld hl, $5ac2
    jr .asm_0b11d ; 0x75ab7
.asm_627d9 ; 0x75ab9
    ld hl, $5ac7
.asm_0b11d ; 0x75abc
    call PrintText
    jp $24d7

UnnamedText_75ac2: ; 0x75ac2
    TX_FAR _UnnamedText_75ac2
    db $50
; 0x75ac2 + 5 bytes

UnnamedText_75ac7: ; 0x75ac7
    TX_FAR _UnnamedText_75ac7
    db $50
; 0x75ac7 + 5 bytes

CinnabarGymObject: ; 0x75acc (size=90)
    db $2e ; border tile

    db $2 ; warps
    db $11, $10, $1, $ff
    db $11, $11, $1, $ff

    db $0 ; signs

    db $9 ; people
    db SPRITE_FAT_BALD_GUY, $3 + 4, $3 + 4, $ff, $d0, $41, BLAINE + $C8, $1 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $2 + 4, $11 + 4, $ff, $d0, $42, SUPER_NERD + $C8, $9 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $8 + 4, $11 + 4, $ff, $d0, $43, BURGLAR + $C8, $4 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $4 + 4, $b + 4, $ff, $d0, $44, SUPER_NERD + $C8, $a ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $8 + 4, $b + 4, $ff, $d0, $45, BURGLAR + $C8, $5 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $e + 4, $b + 4, $ff, $d0, $46, SUPER_NERD + $C8, $b ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $e + 4, $3 + 4, $ff, $d0, $47, BURGLAR + $C8, $6 ; trainer
    db SPRITE_BLACK_HAIR_BOY_2, $8 + 4, $3 + 4, $ff, $d0, $48, SUPER_NERD + $C8, $c ; trainer
    db SPRITE_GYM_HELPER, $d + 4, $10 + 4, $ff, $d0, $9 ; person

    ; warp-to
    EVENT_DISP $a, $11, $10
    EVENT_DISP $a, $11, $11

CinnabarGymBlocks: ; 90
    INCBIN "maps/cinnabargym.blk"

Lab1_h: ; 0x75b80 to 0x75b8c (12 bytes) (id=167)
    db $14 ; tileset
    db CINNABAR_LAB_1_HEIGHT, CINNABAR_LAB_1_WIDTH ; dimensions (y, x)
    dw Lab1Blocks, Lab1Texts, Lab1Script ; blocks, texts, scripts
    db $00 ; connections

    dw Lab1Object ; objects

Lab1Script: ; 0x75b8c
    call $3c3c
    ret
; 0x75b90

Lab1Texts: ; 0x75b90
    dw Lab1Text1, Lab1Text2, Lab1Text3, Lab1Text4, Lab1Text5

Lab1Text1: ; 0x75b9a
    TX_FAR _Lab1Text1
    db $50

Lab1Text2: ; 0x75b9f
    TX_FAR _Lab1Text2
    db $50

Lab1Text3: ; 0x75ba4
    TX_FAR _Lab1Text3
    db $50

Lab1Text4: ; 0x75ba9
    TX_FAR _Lab1Text4
    db $50

Lab1Text5: ; 0x75bae
    TX_FAR _Lab1Text5
    db $50

Lab1Object: ; 0x75bb3 (size=62)
    db $17 ; border tile

    db $5 ; warps
    db $7, $2, $2, $ff
    db $7, $3, $2, $ff
    db $4, $8, $0, CINNABAR_LAB_2
    db $4, $c, $0, CINNABAR_LAB_3
    db $4, $10, $0, CINNABAR_LAB_4

    db $4 ; signs
    db $2, $3, $2 ; Lab1Text2
    db $4, $9, $3 ; Lab1Text3
    db $4, $d, $4 ; Lab1Text4
    db $4, $11, $5 ; Lab1Text5

    db $1 ; people
    db SPRITE_FISHER, $3 + 4, $1 + 4, $ff, $ff, $1 ; person

    ; warp-to
    EVENT_DISP $9, $7, $2
    EVENT_DISP $9, $7, $3
    EVENT_DISP $9, $4, $8 ; CINNABAR_LAB_2
    EVENT_DISP $9, $4, $c ; CINNABAR_LAB_3
    EVENT_DISP $9, $4, $10 ; CINNABAR_LAB_4

Lab1Blocks: ; 36
    INCBIN "maps/lab1.blk"

Lab2_h: ; 0x75c15 to 0x75c21 (12 bytes) (id=168)
    db $14 ; tileset
    db CINNABAR_LAB_2_HEIGHT, CINNABAR_LAB_2_WIDTH ; dimensions (y, x)
    dw Lab2Blocks, Lab2Texts, Lab2Script ; blocks, texts, scripts
    db $00 ; connections

    dw Lab2Object ; objects

Lab2Script: ; 0x75c21
    jp $3c3c
; 0x75c24

Lab2Texts: ; 0x75c24
    dw Lab2Text1, Lab2Text2, Lab2Text3

Lab2Text1: ; 0x75c2a
    TX_FAR _Lab2Text1
    db $50

Lab2Text2: ; 0x75c2f
    db $8
    ld a, $7
    ld [W_WHICHTRADE], a
    jr asm_78552 ; 0x75c35 $6

Lab2Text3:
    db $8
    ld a, $8
    ld [W_WHICHTRADE], a
asm_78552: ; 0x75c3d
    ld a, $54
    call Predef
    jp $24d7

Lab2Object: ; 0x75c45 (size=38)
    db $17 ; border tile

    db $2 ; warps
    db $7, $2, $2, CINNABAR_LAB_1
    db $7, $3, $2, CINNABAR_LAB_1

    db $0 ; signs

    db $3 ; people
    db SPRITE_BLACK_HAIR_BOY_2, $2 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_OLD_PERSON, $4 + 4, $1 + 4, $ff, $ff, $2 ; person
    db SPRITE_FOULARD_WOMAN, $5 + 4, $5 + 4, $ff, $d1, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2 ; CINNABAR_LAB_1
    EVENT_DISP $4, $7, $3 ; CINNABAR_LAB_1

Lab2Blocks: ; 16
    INCBIN "maps/lab2.blk"

Lab3_h: ; 0x75c7b to 0x75c87 (12 bytes) (id=169)
    db $14 ; tileset
    db CINNABAR_LAB_3_HEIGHT, CINNABAR_LAB_3_WIDTH ; dimensions (y, x)
    dw Lab3Blocks, Lab3Texts, Lab3Script ; blocks, texts, scripts
    db $00 ; connections

    dw Lab3Object ; objects

Lab3Script: ; 0x75c87
    jp $3c3c
; 0x75c8a

Lab3Texts: ; 0x75c8a
    dw Lab3Text1, Lab3Text2, Lab3Text3, Lab3Text4, Lab3Text5

Lab3Text1: ; 0x75c94
    db $08 ; asm
    ld a, [$d7a1]
    bit 7, a
    jr nz, .asm_e551a ; 0x75c9a
    ld hl, $5cc8
    call PrintText
    ld bc,(TM_35 << 8) | 1
    call $3e2e
    jr nc, .asm_6c187 ; 0x75ca8
    ld hl, $5ccd
    call PrintText
    ld hl, $d7a1
    set 7, [hl]
    jr .asm_eb896 ; 0x75cb5
.asm_6c187 ; 0x75cb7
    ld hl, $5cd8
    call PrintText
    jr .asm_eb896 ; 0x75cbd
.asm_e551a ; 0x75cbf
    ld hl, $5cd3
    call PrintText
.asm_eb896 ; 0x75cc5
    jp $24d7

UnnamedText_75cc8: ; 0x75cc8
    TX_FAR _UnnamedText_75cc8
    db $50
; 0x75cc8 + 5 bytes

UnnamedText_75ccd: ; 0x75ccd
    TX_FAR UnnamedText_a0f48 ; 0xa0f48
    db $0B, $50
; 0x75cd3

UnnamedText_75cd3: ; 0x75cd3
    TX_FAR _UnnamedText_75cd3
    db $50
; 0x75cd3 + 5 bytes

UnnamedText_75cd8: ; 0x75cd8
    TX_FAR _UnnamedText_75cd8
    db $50
; 0x75cd8 + 5 bytes

Lab3Text2: ; 0x75cdd
    TX_FAR _Lab3Text2
    db $50

Lab3Text4:
Lab3Text3: ; 0x75ce2
    TX_FAR _Lab3Text3
    db $50

Lab3Text5: ; 0x75ce7
    TX_FAR _Lab3Text5
    db $50

Lab3Object: ; 0x75cec (size=41)
    db $17 ; border tile

    db $2 ; warps
    db $7, $2, $3, CINNABAR_LAB_1
    db $7, $3, $3, CINNABAR_LAB_1

    db $3 ; signs
    db $4, $0, $3 ; Lab3Text3
    db $4, $1, $4 ; Lab3Text4
    db $1, $2, $5 ; Lab3Text5

    db $2 ; people
    db SPRITE_OAK_AIDE, $2 + 4, $7 + 4, $ff, $d0, $1 ; person
    db SPRITE_OAK_AIDE, $3 + 4, $2 + 4, $fe, $2, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2 ; CINNABAR_LAB_1
    EVENT_DISP $4, $7, $3 ; CINNABAR_LAB_1

Lab3Blocks: ; 16
    INCBIN "maps/lab3.blk"

Lab4_h: ; 0x75d25 to 0x75d31 (12 bytes) (id=170)
    db $14 ; tileset
    db CINNABAR_LAB_4_HEIGHT, CINNABAR_LAB_4_WIDTH ; dimensions (y, x)
    dw Lab4Blocks, Lab4Texts, Lab4Script ; blocks, texts, scripts
    db $00 ; connections

    dw Lab4Object ; objects

Lab4Script: ; 0x75d31
    jp $3c3c
; 0x75d34

Lab4Texts:
    dw Lab4Text1, Lab4Text2

INCBIN "baserom.gbc",$75d34 + 4,$38 -4

Lab4Text1: ; 0x75d6c
    db $8
    ld a, [$d7a3]
    bit 0, a
    jr nz, .asm_75d96 ; 0x75d72 $22
    ld hl, $5dc6
    call PrintText
    call $5d38
    ld a, [$cd37]
    and a
    jr z, .asm_75d8d ; 0x75d81 $a
    ld b, $18
    ld hl, $5006
    call Bankswitch
    jr .asm_75d93 ; 0x75d8b $6
.asm_75d8d
    ld hl, $5dcb
    call PrintText
.asm_75d93
    jp $24d7
.asm_75d96
    bit 1, a
    jr z, .asm_75da2 ; 0x75d98 $8
    ld hl, $5dd0
    call PrintText
    jr .asm_75d93 ; 0x75da0 $f1
.asm_75da2
    call $5de8
    ld hl, $5dd5
    call PrintText
    ld hl, $d7a3
    set 2, [hl]
    ld a, [$d710]
    ld b, a
    ld c, $1e
    call GivePokemon
    jr nc, .asm_75d93 ; 0x75db9 $d8
    ld hl, $d7a3
    res 0, [hl]
    res 1, [hl]
    res 2, [hl]
    jr .asm_75d93 ; 0x75dc4 $cd
; 0x75dc6

UnnamedText_75dc6: ; 0x75dc6
    TX_FAR _UnnamedText_75dc6
    db $50
; 0x75dc6 + 5 bytes

UnnamedText_75dcb: ; 0x75dcb
    TX_FAR _UnnamedText_75dcb
    db $50
; 0x75dcb + 5 bytes

UnnamedText_75dd0: ; 0x75dd0
    TX_FAR _UnnamedText_75dd0
    db $50
; 0x75dd0 + 5 bytes

UnnamedText_75dd5: ; 0x75dd5
    TX_FAR _UnnamedText_75dd5
    db $50
; 0x75dd5 + 5 bytes

Lab4Text2: ; 0x75dda
    db $08 ; asm
    ld a, $3
    ld [W_WHICHTRADE], a
    ld a, $54
    call Predef
    jp $24d7

INCBIN "baserom.gbc",$75de8,$8

Lab4Object: ; 0x75df0 (size=32)
    db $17 ; border tile

    db $2 ; warps
    db $7, $2, $4, CINNABAR_LAB_1
    db $7, $3, $4, CINNABAR_LAB_1

    db $0 ; signs

    db $2 ; people
    db SPRITE_OAK_AIDE, $2 + 4, $5 + 4, $fe, $2, $1 ; person
    db SPRITE_OAK_AIDE, $6 + 4, $7 + 4, $ff, $d1, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2 ; CINNABAR_LAB_1
    EVENT_DISP $4, $7, $3 ; CINNABAR_LAB_1

Lab4Blocks: ; 16
    INCBIN "maps/lab4.blk"

CinnabarPokecenter_h: ; 0x75e20 to 0x75e2c (12 bytes) (id=171)
    db $06 ; tileset
    db CINNABAR_POKECENTER_HEIGHT, CINNABAR_POKECENTER_WIDTH ; dimensions (y, x)
    dw CinnabarPokecenterBlocks, CinnabarPokecenterTexts, CinnabarPokecenterScript ; blocks, texts, scripts
    db $00 ; connections

    dw CinnabarPokecenterObject ; objects

CinnabarPokecenterScript: ; 0x75e2c
    call $22fa
    jp $3c3c
; 0x75e32

CinnabarPokecenterTexts:
    dw CinnabarPokecenterText1, CinnabarPokecenterText2, CinnabarPokecenterText3, CinnabarPokecenterText4

CinnabarPokecenterText1:
    db $ff

CinnabarPokecenterText2: ; 0x75e3b
    TX_FAR _CinnabarPokecenterText1
    db $50

CinnabarPokecenterText3: ; 0x75e40
    TX_FAR _CinnabarPokecenterText3
    db $50

CinnabarPokecenterText4:
    db $f6

CinnabarPokecenterObject: ; 0x75e46 (size=44)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $3, $ff
    db $7, $4, $3, $ff

    db $0 ; signs

    db $4 ; people
    db SPRITE_NURSE, $1 + 4, $3 + 4, $ff, $d0, $1 ; person
    db SPRITE_LASS, $4 + 4, $9 + 4, $fe, $0, $2 ; person
    db SPRITE_GENTLEMAN, $6 + 4, $2 + 4, $ff, $ff, $3 ; person
    db SPRITE_CABLE_CLUB_WOMAN, $2 + 4, $b + 4, $ff, $d0, $4 ; person

    ; warp-to
    EVENT_DISP $7, $7, $3
    EVENT_DISP $7, $7, $4

CinnabarMart_h: ; 0x75e72 to 0x75e7e (12 bytes) (id=172)
    db $02 ; tileset
    db CINNABAR_MART_HEIGHT, CINNABAR_MART_WIDTH ; dimensions (y, x)
    dw CinnabarMartBlocks, CinnabarMartTexts, CinnabarMartScript ; blocks, texts, scripts
    db $00 ; connections

    dw CinnabarMartObject ; objects

CinnabarMartScript: ; 0x75e7e
    jp $3c3c
; 0x75e81

CinnabarMartTexts: ; 0x75e81
    dw CinnabarMartText1, CinnabarMartText2, CinnabarMartText3

CinnabarMartText2: ; 0x75e87
    TX_FAR _CinnabarMartText2
    db $50

CinnabarMartText3: ; 0x75e8c
    TX_FAR _CinnabarMartText3
    db $50

CinnabarMartObject: ; 0x75e91 (size=38)
    db $0 ; border tile

    db $2 ; warps
    db $7, $3, $4, $ff
    db $7, $4, $4, $ff

    db $0 ; signs

    db $3 ; people
    db SPRITE_MART_GUY, $5 + 4, $0 + 4, $ff, $d3, $1 ; person
    db SPRITE_ERIKA, $2 + 4, $6 + 4, $ff, $ff, $2 ; person
    db SPRITE_OAK_AIDE, $4 + 4, $3 + 4, $ff, $ff, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $7, $4

CopycatsHouseF1_h: ; 0x75eb7 to 0x75ec3 (12 bytes) (id=175)
    db $01 ; tileset
    db COPYCATS_HOUSE_1F_HEIGHT, COPYCATS_HOUSE_1F_WIDTH ; dimensions (y, x)
    dw CopycatsHouseF1Blocks, CopycatsHouseF1Texts, CopycatsHouseF1Script ; blocks, texts, scripts
    db $00 ; connections

    dw CopycatsHouseF1Object ; objects

CopycatsHouseF1Script: ; 0x75ec3
    jp $3c3c
; 0x75ec6

CopycatsHouseF1Texts: ; 0x75ec6
    dw CopycatsHouseF1Text1, CopycatsHouseF1Text2, CopycatsHouseF1Text3

CopycatsHouseF1Text1: ; 0x75ecc
    TX_FAR _CopycatsHouseF1Text1
    db $50

CopycatsHouseF1Text2: ; 0x75ed1
    TX_FAR _CopycatsHouseF1Text2
    db $50

CopycatsHouseF1Text3: ; 0x75ed6
    TX_FAR _CopycatsHouseF1Text3
    db $8
    ld a, $28
    call $13d0
    jp $24d7

CopycatsHouseF1Object: ; 0x75ee3 (size=46)
    db $a ; border tile

    db $3 ; warps
    db $7, $2, $0, $ff
    db $7, $3, $0, $ff
    db $1, $7, $0, COPYCATS_HOUSE_2F

    db $0 ; signs

    db $3 ; people
    db SPRITE_MOM_GEISHA, $2 + 4, $2 + 4, $ff, $d0, $1 ; person
    db SPRITE_FAT_BALD_GUY, $4 + 4, $5 + 4, $ff, $d2, $2 ; person
    db SPRITE_CLEFAIRY, $4 + 4, $1 + 4, $fe, $1, $3 ; person

    ; warp-to
    EVENT_DISP $4, $7, $2
    EVENT_DISP $4, $7, $3
    EVENT_DISP $4, $1, $7 ; COPYCATS_HOUSE_2F

Gary_h: ;0x75f11

db $7 ;tileset
db $4, $4 ;Height, Width
dw GaryBlocks, GaryTexts, GaryScript
db $0 ;No Connections

dw GaryObject

GaryScript: ; 0x75f1d
    call $3c3c
    ld hl, $5f31
    ld a, [$d64c]
    jp $3d97
; 0x75f29

INCBIN "baserom.gbc",$75f29,$75f31 - $75f29

GaryScripts: ; 0x75f31
    dw GaryScript0

INCBIN "baserom.gbc",$75f33,$14

GaryScript0: ; 0x75f47
    ret
; 0x75f48

INCBIN "baserom.gbc",$75f48,$18e

GaryTexts: ; 0x760d6
    dw GaryText1, GaryText2, GaryText3, GaryText4, GaryText5

GaryText1: ; 0x760e0
    db $08 ; asm
    ld a, [$d867]
    bit 1, a
    ld hl, $60f4
    jr z, .asm_17e9f ; 0x760e9
    ld hl, $6103
.asm_17e9f ; 0x760ee
    call PrintText
    jp $24d7

UnnamedText_760f4: ; 0x760f4
    TX_FAR _UnnamedText_760f4
    db $50
; 0x760f4 + 5 bytes

UnnamedText_760f9: ; 0x760f9
    TX_FAR _UnnamedText_760f9
    db $50
; 0x760f9 + 5 bytes

UnnamedText_760fe: ; 0x760fe
    TX_FAR _UnnamedText_760fe
    db $50
; 0x760fe + 5 bytes

UnnamedText_76103: ; 0x76103
    TX_FAR _UnnamedText_76103
    db $50
; 0x76103 + 5 bytes

GaryText2: ; 0x76108
    TX_FAR _GaryText2
    db $50

GaryText3: ; 0x7610d

INCBIN "baserom.gbc",$7610d,$76120 - $7610d

UnnamedText_76120: ; 0x76120
    TX_FAR _UnnamedText_76120
    db $50
; 0x76120 + 5 bytes

GaryText4: ; 0x76125
    TX_FAR _UnnamedText_76125
    db $50
; 0x76125 + 5 bytes

GaryText5: ; 0x7612a
    TX_FAR _UnnamedText_7612a
    db $50
; 0x7612a + 5 bytes

GaryObject: ; 0x7612f (size=48)
    db $3 ; border tile

    db $4 ; warps
    db $7, $3, $1, LANCES_ROOM
    db $7, $4, $2, LANCES_ROOM
    db $0, $3, $0, HALL_OF_FAME
    db $0, $4, $0, HALL_OF_FAME

    db $0 ; signs

    db $2 ; people
    db SPRITE_BLUE, $2 + 4, $4 + 4, $ff, $d0, $1 ; person
    db SPRITE_OAK, $7 + 4, $3 + 4, $ff, $d1, $2 ; person

    ; warp-to
    EVENT_DISP $4, $7, $3 ; LANCES_ROOM
    EVENT_DISP $4, $7, $4 ; LANCES_ROOM
    EVENT_DISP $4, $0, $3 ; HALL_OF_FAME
    EVENT_DISP $4, $0, $4 ; HALL_OF_FAME

GaryBlocks: ; 16
    INCBIN "maps/gary.blk"

Lorelei_h: ; 0x7616f to 0x7617b (12 bytes) (id=245)
    db $07 ; tileset
    db LORELEIS_ROOM_HEIGHT, LORELEIS_ROOM_WIDTH ; dimensions (y, x)
    dw LoreleiBlocks, LoreleiTexts, LoreleiScript ; blocks, texts, scripts
    db $00 ; connections

    dw LoreleiObject ; objects

LoreleiScript: ; 0x7617b
    call $6191
    call $3c3c
    ld hl, $6255
    ld de, $61bb
    ld a, [$d64d]
    call $3160
    ld [$d64d], a
    ret
; 0x76191

INCBIN "baserom.gbc",$76191,$c0

LoreleiTexts: ; 0x76251
    dw LoreleiText1, LoreleiText2

INCBIN "baserom.gbc",$76255,$d

LoreleiText1: ; 0x76262
    db $08 ; asm
    ld hl, $6255
    call LoadTrainerHeader
    jp $24d7

UnnamedText_7626c: ; 0x7626c
    TX_FAR _UnnamedText_7626c
    db $50
; 0x7626c + 5 bytes

UnnamedText_76271: ; 0x76271
    TX_FAR _UnnamedText_76271
    db $50
; 0x76271 + 5 bytes

UnnamedText_76276: ; 0x76276
    TX_FAR _UnnamedText_76276
    db $50
; 0x76276 + 5 bytes

LoreleiText2: ; 0x7627b
    TX_FAR _UnnamedText_7627b
    db $50
; 0x7627b + 5 bytes

LoreleiObject: ; 0x76280 (size=44)
    db $3 ; border tile

    db $4 ; warps
    db $b, $4, $2, INDIGO_PLATEAU_LOBBY
    db $b, $5, $2, INDIGO_PLATEAU_LOBBY
    db $0, $4, $0, BRUNOS_ROOM
    db $0, $5, $1, BRUNOS_ROOM

    db $0 ; signs

    db $1 ; people
    db SPRITE_LORELEI, $2 + 4, $5 + 4, $ff, $d0, $41, LORELEI + $C8, $1 ; trainer

    ; warp-to
    EVENT_DISP $5, $b, $4 ; INDIGO_PLATEAU_LOBBY
    EVENT_DISP $5, $b, $5 ; INDIGO_PLATEAU_LOBBY
    EVENT_DISP $5, $0, $4 ; BRUNOS_ROOM
    EVENT_DISP $5, $0, $5 ; BRUNOS_ROOM

LoreleiBlocks: ; 30
    INCBIN "maps/loreli.blk"

Bruno_h: ; 0x762ca to 0x762d6 (12 bytes) (id=246)
    db $07 ; tileset
    db BRUNOS_ROOM_HEIGHT, BRUNOS_ROOM_WIDTH ; dimensions (y, x)
    dw BrunoBlocks, BrunoTexts, BrunoScript ; blocks, texts, scripts
    db $00 ; connections

    dw BrunoObject ; objects

BrunoScript: ; 0x762d6
    call $62ec
    call $3c3c
    ld hl, $63ac
    ld de, $6312
    ld a, [$d64e]
    call $3160
    ld [$d64e], a
    ret
; 0x762ec

INCBIN "baserom.gbc",$762ec,$bc

BrunoTexts: ; 0x763a8
    dw BrunoText1, BrunoText2

INCBIN "baserom.gbc",$763ac,$d

BrunoText1: ; 0x763b9
    db $08 ; asm
    ld hl, $63ac
    call LoadTrainerHeader
    jp $24d7

UnnamedText_763c3: ; 0x763c3
    TX_FAR _UnnamedText_763c3
    db $50
; 0x763c3 + 5 bytes

UnnamedText_763c8: ; 0x763c8
    TX_FAR _UnnamedText_763c8
    db $50
; 0x763c8 + 5 bytes

UnnamedText_763cd: ; 0x763cd
    TX_FAR _UnnamedText_763cd
    db $50
; 0x763cd + 5 bytes

BrunoText2: ; 0x763d2
    TX_FAR _UnnamedText_763d2
    db $50
; 0x763d2 + 5 bytes

BrunoObject: ; 0x763d7 (size=44)
    db $3 ; border tile

    db $4 ; warps
    db $b, $4, $2, LORELEIS_ROOM
    db $b, $5, $3, LORELEIS_ROOM
    db $0, $4, $0, AGATHAS_ROOM
    db $0, $5, $1, AGATHAS_ROOM

    db $0 ; signs

    db $1 ; people
    db SPRITE_BRUNO, $2 + 4, $5 + 4, $ff, $d0, $41, BRUNO + $C8, $1 ; trainer

    ; warp-to
    EVENT_DISP $5, $b, $4 ; LORELEIS_ROOM
    EVENT_DISP $5, $b, $5 ; LORELEIS_ROOM
    EVENT_DISP $5, $0, $4 ; AGATHAS_ROOM
    EVENT_DISP $5, $0, $5 ; AGATHAS_ROOM

BrunoBlocks: ; 30
    INCBIN "maps/bruno.blk"

Agatha_h: ; 0x76421 to 0x7642d (12 bytes) (id=247)
    db $0f ; tileset
    db AGATHAS_ROOM_HEIGHT, AGATHAS_ROOM_WIDTH ; dimensions (y, x)
    dw AgathaBlocks, AgathaTexts, AgathaScript ; blocks, texts, scripts
    db $00 ; connections

    dw AgathaObject ; objects

AgathaScript: ; 0x7642d
    call $6443
    call $3c3c
    ld hl, $6509
    ld de, $6469
    ld a, [$d64f]
    call $3160
    ld [$d64f], a
    ret
; 0x76443

INCBIN "baserom.gbc",$76443,$c2

AgathaTexts: ; 0x76505
    dw AgathaText1, AgathaText2

INCBIN "baserom.gbc",$76509,$d

AgathaText1: ; 0x76516
    db $08 ; asm
    ld hl, $6509
    call LoadTrainerHeader
    jp $24d7

UnnamedText_76520: ; 0x76520
    TX_FAR _UnnamedText_76520
    db $50
; 0x76520 + 5 bytes

UnnamedText_76525: ; 0x76525
    TX_FAR _UnnamedText_76525
    db $50
; 0x76525 + 5 bytes

UnnamedText_7652a: ; 0x7652a
    TX_FAR _UnnamedText_7652a
    db $50
; 0x7652a + 5 bytes

AgathaText2: ; 0x7652f
    TX_FAR _UnnamedText_7652f
    db $50
; 0x7652f + 5 bytes

AgathaObject: ; 0x76534 (size=44)
    db $0 ; border tile

    db $4 ; warps
    db $b, $4, $2, BRUNOS_ROOM
    db $b, $5, $3, BRUNOS_ROOM
    db $0, $4, $0, LANCES_ROOM
    db $0, $5, $0, LANCES_ROOM

    db $0 ; signs

    db $1 ; people
    db SPRITE_AGATHA, $2 + 4, $5 + 4, $ff, $d0, $41, AGATHA + $C8, $1 ; trainer

    ; warp-to
    EVENT_DISP $5, $b, $4 ; BRUNOS_ROOM
    EVENT_DISP $5, $b, $5 ; BRUNOS_ROOM
    EVENT_DISP $5, $0, $4 ; LANCES_ROOM
    EVENT_DISP $5, $0, $5 ; LANCES_ROOM

AgathaBlocks: ; 30
    INCBIN "maps/agatha.blk"

INCBIN "baserom.gbc",$7657e,$76670 - $7657e

HallOfFameNoText:
	db "HALL OF FAME No   @"

UnnamedText_76683: ; 0x76683
    TX_FAR _UnnamedText_76683
    db $50
; 0x76683 + 5 bytes

INCBIN "baserom.gbc",$76688,$76794 - $76688

UnnamedText_76794: ; 0x76794
    TX_FAR _UnnamedText_76794
    db $50
; 0x76794 + 5 bytes

INCBIN "baserom.gbc",$76799,$76852 - $76799

UnnamedText_76852: ; 0x76852
    TX_FAR _UnnamedText_76852
    db $50
; 0x76852 + 5 bytes

INCBIN "baserom.gbc",$76857,$76880 - $76857

;I'm pretty sure that the rest of the bank is assembly and thus doesn't use any of the 0s, but I've included some to be sure

SECTION "bank1E",DATA,BANK[$1E]

INCBIN "baserom.gbc",$78000,$F1

PlayAnimation: ; 40F1
	xor a
	ld [$FF8B],a
	ld [$D08B],a
	ld a,[$D07C] ; get animation number
	dec a
	ld l,a
	ld h,0
	add hl,hl
	ld de,$607D
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
.next7\@
	ld a,[hli]
	cp a,$FF
	jr z,.AnimationOver\@
	cp a,$C0 ; is this animation for a monster onscreen?
	jr c,.next2\@
	ld c,a
	ld de,$50DA
.next4\@
	ld a,[de]
	cp c
	jr z,.next3\@
	inc de
	inc de
	inc de
	jr .next4\@
.next3\@
	ld a,[hli]
	cp a,$FF
	jr z,.next5\@
	ld [$CF07],a
	push hl
	push de
	call $586F
	call $23B1
	pop de
	pop hl
.next5\@
	push hl
	inc de
	ld a,[de]
	ld l,a
	inc de
	ld a,[de]
	ld h,a
	ld de,.next6\@
	push de
	jp [hl]
.next2\@
	ld c,a
	and a,$3F
	ld [$D086],a
	xor a
	sla c
	rla
	sla c
	rla
	ld [$D09F],a
	ld a,[hli]
	ld [$CF07],a
	ld a,[hli]
	ld c,l
	ld b,h
	ld l,a
	ld h,0
	add hl,hl
	ld de,$676D
	add hl,de
	ld a,l
	ld [$D094],a
	ld a,h
	ld [$D095],a
	ld l,c
	ld h,b
	push hl
	ld a,[rOBP0]
	push af
	ld a,[$CC79]
	ld [rOBP0],a
	call $41D2
	call $417C
	call RealPlayAnimation
	pop af
	ld [rOBP0],a
.next6\@
	pop hl
	jr .next7\@
.AnimationOver\@ ; 417B
	ret

INCBIN "baserom.gbc",$7817C,$78BDE - $7817C

IF _RED
	INCBIN "gfx/red/slotmachine2.2bpp"
ENDC
IF _BLUE
	INCBIN "gfx/blue/slotmachine2.2bpp"
ENDC

AttackAnimation: ; 4D5E
	push hl
	push de
	push bc
	push af
	call $3748
	call $4E23
	ld a,[$D07C]
	and a
	jr z,.AnimationFinished\@

	; if throwing a Poké Ball, skip the regular animation code
	cp a,TOSS_ANIM
	jr nz,.AttackAnimation\@
	ld de,.AnimationFinished\@
	push de
	jp TossBallAnimation

.AttackAnimation\@
	; check if battle animations are disabled in the options
	ld a,[$D355]
	bit 7,a
	jr nz,.AnimationsDisabled\@
	call ShareAttackAnimations
	call PlayAnimation
	jr .next4\@
.AnimationsDisabled\@
	ld c,30
	call DelayFrames
.next4\@
	call $4DBD ; reload pic and flash the pic in and out (to show damage)
.AnimationFinished\@
	call $3748
	xor a
	ld [$D096],a
	ld [$D09B],a
	ld [$D08B],a
	dec a
	ld [$CF07],a
	pop af
	pop bc
	pop de
	pop hl
	ret

ShareAttackAnimations: ; 4DA6
; some moves just reuse animations from status conditions
	ld a,[H_WHOSETURN]
	and a
	ret z

	; opponent’s turn

	ld a,[$D07C]

	cp a,AMNESIA
	ld b,CONF_ANIM
	jr z,.Replace\@

	cp a,REST
	ld b,SLP_ANIM
	ret nz

.Replace\@
	ld a,b
	ld [$D07C],a
	ret

Function4DBD: ; 4DBD
	ld a,[$CC5B]
	and a
	ret z
	dec a
	add a
	ld c,a
	ld b,0
	ld hl,Pointer4DCF
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp [hl]

Pointer4DCF: ; 4DCF
	dw $4DDB,$4DE3,$4DEB,$4DF0,$4DF6,$4DFE

INCBIN "baserom.gbc",$78DDB,$78E53-$78DDB

RealPlayAnimation: ; 4E53
	ld a,[$CF07] ; get animation # − 1
	cp a,$FF
	jr z,.Next4E60
	call $586F
	call $23B1 ; play sound effect
.Next4E60
	ld hl,$C300
	ld a,l
	ld [$D09D],a
	ld a,h
	ld [$D09C],a
	ld a,[$D097]
	ld h,a
	ld a,[$D096]
	ld l,a
	push hl
	ld c,[hl]
	ld b,0
	ld hl,PointerTable6F74
	add hl,bc
	add hl,bc
	ld a,[hli]
	ld c,a
	ld a,[hli]
	ld b,a
	pop hl
	inc hl
	push hl
	ld e,[hl]
	ld d,0
	ld hl,$7C85
	add hl,de
	add hl,de
	ld a,[hli]
	ld [$D082],a
	ld a,[hl]
	ld [$D081],a
	pop hl
	inc hl
	ld a,[hl]
	ld [$D09E],a
	call $4000
	call $4ED7
	ld a,[$D087]
	dec a
	ld [$D087],a
	ret z
	ld a,[$D097]
	ld h,a
	ld a,[$D096]
	ld l,a
	ld a,[$D08B]
	cp a,4
	ld bc,3
	jr nz,.Next4EBC
	ld bc,$FFFD
.Next4EBC
	add hl,bc
	ld a,h
	ld [$D097],a
	ld a,l
	ld [$D096],a
	jp $4E73

INCBIN "baserom.gbc",$78EC8,$7986F - $78EC8

Func586F: ; 586F
	ld hl,MoveSoundTable
	ld e,a
	ld d,0
	add hl,de
	add hl,de
	add hl,de
	ld a,[hli]
	ld b,a
	call IsCryMove
	jr nc,.NotCryMove
	ld a,[H_WHOSETURN]
	and a
	jr nz,.next\@
	ld a,[$D014] ; get number of current monster
	jr .Continue\@
.next\@
	ld a,[$CFE5]
.Continue\@
	push hl
	call $13D9
	ld b,a
	pop hl
	ld a,[$C0F1]
	add [hl]
	ld [$C0F1],a
	inc hl
	ld a,[$C0F2]
	add [hl]
	ld [$C0F2],a
	jr .done\@
.NotCryMove
	ld a,[hli]
	ld [$C0F1],a
	ld a,[hli]
	ld [$C0F2],a
.done\@
	ld a,b
	ret
IsCryMove:
; set carry if the attack animation involves playing a monster cry
	ld a,[$D07C]
	cp a,GROWL
	jr z,.CryMove
	cp a,ROAR
	jr z,.CryMove
	and a ; clear carry
	ret
.CryMove
	scf
	ret

MoveSoundTable:
	db $a0,$00,$80
	db $a2,$10,$80
	db $b3,$00,$80
	db $a1,$01,$80
	db $a3,$00,$40
	db $e9,$00,$ff
	db $a3,$10,$60
	db $a3,$20,$80
	db $a3,$00,$a0
	db $a6,$00,$80
	db $a5,$20,$40
	db $a5,$00,$80
	db $a4,$00,$a0
	db $a7,$10,$c0
	db $a7,$00,$a0
	db $a8,$00,$c0
	db $a8,$10,$a0
	db $a9,$00,$e0
	db $a7,$20,$c0
	db $aa,$00,$80
	db $b9,$00,$80
	db $ab,$01,$80
	db $b7,$00,$80
	db $ad,$f0,$40
	db $b0,$00,$80
	db $ad,$00,$80
	db $b8,$10,$80
	db $b1,$01,$a0
	db $ae,$00,$80
	db $b4,$00,$60
	db $b4,$01,$40
	db $b6,$00,$a0
	db $b0,$10,$a0
	db $b7,$00,$c0
	db $aa,$10,$60
	db $b0,$00,$a0
	db $b9,$11,$c0
	db $b0,$20,$c0
	db $b8,$00,$80
	db $b1,$00,$80
	db $b1,$20,$c0
	db $af,$00,$80
	db $db,$ff,$40
	db $b4,$00,$80
	db $a1,$00,$c0
	db $a1,$00,$40
	db $e4,$00,$80
	db $bf,$40,$60
	db $bf,$00,$80
	db $bf,$ff,$40
	db $c7,$80,$c0
	db $af,$10,$a0
	db $af,$21,$e0
	db $c5,$00,$80
	db $bb,$20,$60
	db $c7,$00,$80
	db $cc,$00,$80
	db $c2,$40,$80
	db $c5,$f0,$e0
	db $cf,$00,$80
	db $c7,$f0,$60
	db $c2,$00,$80
	db $e6,$00,$80
	db $9d,$01,$a0
	db $a9,$f0,$20
	db $ba,$01,$c0
	db $ba,$00,$80
	db $b0,$00,$e0
	db $be,$01,$60
	db $be,$20,$40
	db $bb,$00,$80
	db $bb,$40,$c0
	db $b1,$03,$60
	db $bd,$11,$e0
	db $a8,$20,$e0
	db $d2,$00,$80
	db $b2,$00,$80
	db $b2,$11,$a0
	db $b2,$01,$c0
	db $a9,$14,$c0
	db $b1,$02,$a0
	db $c5,$f0,$80
	db $c5,$20,$c0
	db $d5,$00,$20
	db $d5,$20,$80
	db $d2,$12,$60
	db $be,$00,$80
	db $aa,$01,$e0
	db $c5,$0f,$e0
	db $c5,$11,$20
	db $a6,$10,$40
	db $a5,$10,$c0
	db $aa,$00,$20
	db $d8,$00,$80
	db $e4,$11,$18
	db $9f,$20,$c0
	db $9e,$20,$c0
	db $bd,$00,$10
	db $be,$f0,$20
	db $df,$f0,$c0
	db $a7,$f0,$e0
	db $9f,$f0,$40
	db $db,$00,$80
	db $df,$80,$40
	db $df,$00,$80
	db $aa,$11,$20
	db $aa,$22,$10
	db $b1,$f1,$ff
	db $a9,$f1,$ff
	db $aa,$33,$30
	db $dd,$40,$c0
	db $a4,$20,$20
	db $a4,$f0,$10
	db $a5,$f8,$10
	db $a7,$f0,$10
	db $bd,$00,$80
	db $ae,$00,$c0
	db $dd,$c0,$ff
	db $9f,$f2,$20
	db $e1,$00,$80
	db $e1,$00,$40
	db $9f,$00,$40
	db $a7,$10,$ff
	db $c7,$20,$20
	db $dd,$00,$80
	db $c5,$1f,$20
	db $bd,$2f,$80
	db $a5,$1f,$ff
	db $ca,$1f,$60
	db $be,$1e,$20
	db $be,$1f,$18
	db $aa,$0f,$80
	db $9f,$f8,$10
	db $9e,$18,$20
	db $dd,$08,$40
	db $ad,$01,$e0
	db $a7,$09,$ff
	db $e4,$42,$01
	db $b2,$00,$ff
	db $dd,$08,$e0
	db $bb,$00,$80
	db $9f,$88,$10
	db $bd,$48,$ff
	db $9e,$ff,$ff
	db $bb,$ff,$10
	db $9e,$ff,$04
	db $b2,$01,$ff
	db $a9,$f8,$ff
	db $a2,$f0,$f0
	db $a5,$08,$10
	db $a3,$f0,$ff
	db $b0,$f0,$ff
	db $e1,$10,$ff
	db $a4,$f0,$20
	db $ca,$f0,$60
	db $b8,$12,$10
	db $e6,$f0,$20
	db $b4,$12,$ff
	db $db,$80,$04
	db $df,$f0,$10
	db $c5,$f8,$ff
	db $be,$f0,$ff
	db $a7,$01,$ff
	db $cc,$d8,$04
	db $a1,$00,$80
	db $a1,$00,$80

INCBIN "baserom.gbc",$79AAE,$79E16 - $79AAE

TossBallAnimation: ; 5E16
	ld a,[W_ISINBATTLE]
	cp a,2
	jr z,.BlockBall\@ ; if in trainer battle, play different animation
	ld a,[$D11E]
	ld b,a

	; upper nybble: how many animations (from PokeBallAnimations) to play
	; this will be 4 for successful capture, 6 for breakout
	and a,$F0
	swap a
	ld c,a

	; lower nybble: number of shakes
	; store these for later
	ld a,b
	and a,$F
	ld [$CD3D],a

	ld hl,.PokeBallAnimations
	; choose which toss animation to use
	ld a,[$CF91]
	cp a,POKE_BALL
	ld b,TOSS_ANIM
	jr z,.done\@
	cp a,GREAT_BALL
	ld b,GREATTOSS_ANIM
	jr z,.done\@
	ld b,ULTRATOSS_ANIM
.done\@
	ld a,b
.PlayNextAnimation\@
	ld [$D07C],a
	push bc
	push hl
	call PlayAnimation
	pop hl
	ld a,[hli]
	pop bc
	dec c
	jr nz,.PlayNextAnimation\@
	ret

.PokeBallAnimations: ; 5E50
; sequence of animations that make up the Poké Ball toss
	db POOF_ANIM,HIDEPIC_ANIM,$C2,POOF_ANIM,SHOWPIC_ANIM

.BlockBall\@ ; 5E55
	ld a,$C1
	ld [$D07C],a
	call PlayAnimation
	ld a,$95
	call $23B1 ; play sound effect
	ld a,BLOCKBALL_ANIM
	ld [$D07C],a
	jp PlayAnimation

INCBIN "baserom.gbc",$79E6A,$7AF74 - $79E6A

PointerTable6F74: ; 6F74
	dw $7de7
	dw $7068
	dw $708d
	dw $70ce
	dw $70df
	dw $70f0
	dw $7101
	dw $7132
	dw $7173
	dw $71b4
	dw $71e5
	dw $7216
	dw $7227
	dw $7238
	dw $7259
	dw $726a
	dw $727b
	dw $729c
	dw $72bd
	dw $72ca
	dw $72db
	dw $72fc
	dw $732d
	dw $734e
	dw $735f
	dw $7364
	dw $736d
	dw $7376
	dw $737f
	dw $7388
	dw $7391
	dw $73ab
	dw $73b4
	dw $73cd
	dw $73fe
	dw $744b
	dw $745c
	dw $7465
	dw $7496
	dw $74a7
	dw $74bc
	dw $74d5
	dw $74e6
	dw $74f7
	dw $7500
	dw $7505
	dw $7526
	dw $7547
	dw $7558
	dw $7569
	dw $756e
	dw $758b
	dw $75a8
	dw $75ad
	dw $75c6
	dw $75d7
	dw $75e8
	dw $75f9
	dw $760a
	dw $761b
	dw $7630
	dw $7649
	dw $7666
	dw $7687
	dw $76a8
	dw $76b5
	dw $76c6
	dw $76f3
	dw $7720
	dw $7731
	dw $7742
	dw $7753
	dw $7764
	dw $7775
	dw $785a
	dw $786b
	dw $787c
	dw $788d
	dw $789e
	dw $78bf
	dw $78f0
	dw $7911
	dw $7932
	dw $7943
	dw $7950
	dw $7961
	dw $796e
	dw $7987
	dw $79ac
	dw $79c9
	dw $79ce
	dw $79ff
	dw $7a10
	dw $7a31
	dw $7a5e
	dw $7a9b
	dw $7aac
	dw $7acd
	dw $7afe
	dw $7b3f
	dw $7b58
	dw $7b71
	dw $7b8a
	dw $7b93
	dw $7b98
	dw $7ba9
	dw $7bae
	dw $7bcf
	dw $7bf0
	dw $7c11
	dw $7c1a
	dw $7c2b
	dw $7c3c
	dw $77b6
	dw $77f7
	dw $7828
	dw $7849
	dw $739a
	dw $7c4d
	dw $7c6a
	dw $7c7b
	dw $7c80

INCBIN "baserom.gbc",$7B068,$7C000 - $7B068

SECTION "bank1F",DATA,BANK[$1F]

INCBIN "baserom.gbc",$7C000,$4000

SECTION "bank20",DATA,BANK[$20]

INCBIN "baserom.gbc",$80000,$80009 - $80000

_UnnamedText_526f3: ; 0x80009
    db $0, $4f
    db "The CARD KEY", $55
    db "opened the door!", $57
; 0x80009 + 32 bytes

_UnnamedText_526f8: ; 0x80029
    db $0, "Darn! It needs a", $4f
    db "CARD KEY!", $57
; 0x80029 + 28 bytes

INCBIN "baserom.gbc",$80045,$8004d - $80045

_UnnamedText_70847: ; 0x8004d
    db $0, "Not even a nibble!", $58
; 0x8004d + 20 bytes

_UnnamedText_7084c: ; 0x80061
    db $0, "Looks like there's", $4f
    db "nothing here.", $58
; 0x80061 + 33 bytes

_UnnamedText_70851: ; 0x80082
    db $0, "Oh!", $4f
    db "It's a bite!", $58
; 0x80082 + 17 bytes

_UnnamedText_24db: ; 0x80093
    db $0, "!", $57
; 0x80093 + 3 bytes

_UnnamedText_24e0: ; 0x80096
    db $0, "Ground rose up", $4f
    db "somewhere!", $57
; 0x80096 + 27 bytes

_VictoryRoad3Text10:
_VictoryRoad3Text9:
_VictoryRoad3Text8:
_VictoryRoad3Text7:
_VictoryRoad2Text13:
_VictoryRoad2Text12:
_VictoryRoad2Text11:
_SeafoamIslands1Text2:
_SeafoamIslands1Text1:
_SeafoamIslands5Text2:
_SeafoamIslands5Text1:
_SeafoamIslands4Text6:
_SeafoamIslands4Text5:
_SeafoamIslands4Text4:
_SeafoamIslands4Text3:
_SeafoamIslands4Text2:
_SeafoamIslands4Text1:
_SeafoamIslands3Text2:
_SeafoamIslands3Text1:
_SeafoamIslands2Text2:
_SeafoamIslands2Text1:
_FuchsiaHouse2Text3:
_VictoryRoad1Text7:
_VictoryRoad1Text6:
_VictoryRoad1Text5: ; 0x800b1
    db $0, "This requires", $4f
    db "STRENGTH to move!", $57

_SaffronCityText19:
_CinnabarIslandText4:
_FuchsiaCityText14:
_VermilionCityText9:
_LavenderTownText6:
_CeruleanCityText14:
_PewterCityText8:
_ViridianCityText11: ; 0x800d2
    db $0, "All your item", $4f
    db "needs fulfilled!", $55
    db "#MON MART", $57

_ViridianCityText12: ; 0x800fc
    db $0, "Heal Your #MON!", $4f
    db "#MON CENTER", $57

INCBIN "baserom.gbc",$80119,$8012a - $80119

_UnnamedText_4e2c: ; 0x8012a
    db $0, "No more room for", $4f
    db "items!", $57
; 0x8012a + 25 bytes

_UnnamedText_59091: ; 0x80143
    db $0, "Hi! Remember me?", $4f
    db "I'm PROF.OAK's", $55
    db "AIDE!", $51
    db "If you caught @"
; 0x80143 + 52 bytes

INCBIN "baserom.gbc",$80177,$801e4 - $80177

_UnnamedText_59096: ; 0x801e4
    db $0, "Let's see...", $4f
    db "Uh-oh! You have", $55
    db "caught only @"
; 0x801e4 + 42 bytes

INCBIN "baserom.gbc",$8020e,$80250 - $8020e

_UnnamedText_5909b: ; 0x80250
    db $0, "Oh. I see.", $51
    db "When you get @"
; 0x80250 + 26 bytes

INCBIN "baserom.gbc",$8026a,$8028c - $8026a

_UnnamedText_590a0: ; 0x8028c
    db $0, "Great! You have", $4f
    db "caught @"
; 0x8028c + 25 bytes

INCBIN "baserom.gbc",$802a5,$802ec - $802a5

_UnnamedText_590ab: ; 0x802ec
    db $0, "Oh! I see you", $4f
    db "don't have any", $55
    db "room for the", $55
    db "@"
; 0x802ec + 43 bytes

INCBIN "baserom.gbc",$80317,$6

_ViridianForestText1: ; 0x8031d
    db $0, "I came here with", $4f
    db "some friends!", $51
    db "They're out for", $4f
    db "#MON fights!", $57

_UnnamedText_6118a: ; 0x80359
    db $0, "Hey! You have", $4f
    db "#MON! Come on!", $55
    db "Let's battle'em!", $57
; 0x80359 + 46 bytes

_UnnamedText_6118f: ; 0x80387
    db $0, "No!", $4f
    db "CATERPIE can't", $55
    db "cut it!", $58
; 0x80387 + 27 bytes

_UnnamedText_61194: ; 0x803a2
    db $0, "Ssh! You'll scare", $4f
    db "the bugs away!", $57
; 0x803a2 + 33 bytes

_UnnamedText_61199: ; 0x803c3
    db $0, "Yo! You can't jam", $4f
    db "out if you're a", $55
    db "#MON trainer!", $57
; 0x803c3 + 47 bytes

_UnnamedText_6119e: ; 0x803f2
    db $0, "Huh?", $4f
    db "I ran out of", $55
    db "#MON!", $58
; 0x803f2 + 25 bytes

_UnnamedText_611a3: ; 0x8040b
    db $0, "Darn! I'm going", $4f
    db "to catch some", $55
    db "stronger ones!", $57
; 0x8040b + 45 bytes

_UnnamedText_611a8: ; 0x80438
    db $0, "Hey, wait up!", $4f
    db "What's the hurry?", $57
; 0x80438 + 32 bytes

_UnnamedText_611ad: ; 0x80458
    db $0, "I", $4f
    db "give! You're good", $55
    db "at this!", $58
; 0x80458 + 29 bytes

_UnnamedText_611b2: ; 0x80475
    db $0, "Sometimes, you", $4f
    db "can find stuff on", $55
    db "the ground!", $51
    db "I'm looking for", $4f
    db "the stuff I", $55
    db "dropped!", $57
; 0x80475 + 82 bytes

_ViridianForestText8: ; 0x804c7
    db $0, "I ran out of #", $4f
    db "BALLs to catch", $55
    db "#MON with!", $51
    db "You should carry", $4f
    db "extras!", $57

_ViridianForestText9: ; 0x8050a
    db $0, "TRAINER TIPS", $51
    db "If you want to", $4f
    db "avoid battles,", $55
    db "stay away from", $55
    db "grassy areas!", $57

_ViridianForestText10: ; 0x80553
    db $0, "For poison, use", $4f
    db "ANTIDOTE! Get it", $55
    db "at #MON MARTs!", $57

_ViridianForestText11: ; 0x80584
    db $0, "TRAINER TIPS", $51
    db "Contact PROF.OAK", $4f
    db "via PC to get", $55
    db "your #DEX", $55
    db "evaluated!", $57

_ViridianForestText12: ; 0x805c6
    db $0, "TRAINER TIPS", $51
    db "No stealing of", $4f
    db "#MON from", $55
    db "other trainers!", $55
    db "Catch only wild", $55
    db "#MON!", $57

_ViridianForestText13: ; 0x80613
    db $0, "TRAINER TIPS", $51
    db "Weaken #MON", $4f
    db "before attempting", $55
    db "capture!", $51
    db "When healthy,", $4f
    db "they may escape!", $57

_ViridianForestText14: ; 0x80667
    db $0, "LEAVING", $4f
    db "VIRIDIAN FOREST", $55
    db "PEWTER CITY AHEAD", $57

_UnnamedText_49a98: ; 0x80692
    db $0, "WHOA! You shocked", $4f
    db "me! Oh, you're", $55
    db "just a kid!", $57
; 0x80692 + 45 bytes

_UnnamedText_49a9d: ; 0x806bf
    db $0, "Wow!", $4f
    db "Shocked again!", $58
; 0x806bf + 21 bytes

_UnnamedText_49aa2: ; 0x806d4
    db $0, "Kids like you", $4f
    db "shouldn't be", $55
    db "here!", $57
; 0x806d4 + 33 bytes

_UnnamedText_49aa7: ; 0x806f5
    db $0, "Did you come to", $4f
    db "explore too?", $57
; 0x806f5 + 30 bytes

_UnnamedText_49aac: ; 0x80713
    db $0, "Losing", $4f
    db "stinks!", $58
; 0x80713 + 16 bytes

_UnnamedText_49ab1: ; 0x80723
    db $0, "I came down here", $4f
    db "to show off to", $55
    db "girls.", $57
; 0x80723 + 40 bytes

_UnnamedText_49ab6: ; 0x8074b
    db $0, "Wow! It's way", $4f
    db "bigger in here", $55
    db "than I thought!", $57
; 0x8074b + 45 bytes

_UnnamedText_49abb: ; 0x80778
    db $0, "Oh!", $4f
    db "I lost it!", $58
; 0x80778 + 16 bytes

_UnnamedText_49ac0: ; 0x80788
    db $0, "How do you get", $4f
    db "out of here?", $57
; 0x80788 + 29 bytes

_UnnamedText_49ac5: ; 0x807a5
    db $0, "What! Don't sneak", $4f
    db "up on me!", $57
; 0x807a5 + 28 bytes

_UnnamedText_49aca: ; 0x807c1
    db $0, "My", $4f
    db "#MON won't do!", $58
; 0x807c1 + 18 bytes

_UnnamedText_49acf: ; 0x807d3
    db $0, "I have to find", $4f
    db "stronger #MON.", $57
; 0x807d3 + 31 bytes

_UnnamedText_49ad4: ; 0x807f2
    db $0, "What? I'm waiting", $4f
    db "for my friends to", $55
    db "find me here.", $57
; 0x807f2 + 50 bytes

_UnnamedText_49ad9: ; 0x80824
    db $0, "I lost?", $58
; 0x80824 + 9 bytes

_UnnamedText_49ade: ; 0x8082d
    db $0, "I heard there are", $4f
    db "some very rare", $55
    db "fossils here.", $57
; 0x8082d + 48 bytes

_UnnamedText_49ae3: ; 0x8085d
    db $0, "Suspicious men", $4f
    db "are in the cave.", $55
    db "What about you?", $57
; 0x8085d + 49 bytes

_UnnamedText_49ae8: ; 0x8088e
    db $0, "You", $4f
    db "got me!", $58
; 0x8088e + 13 bytes

_UnnamedText_49aed: ; 0x8089b
    db $0, "I saw them! I'm", $4f
    db "sure they're from", $55
    db "TEAM ROCKET!", $57
; 0x8089b + 46 bytes

_UnnamedText_49af2: ; 0x808c9
    db $0, "Go through this", $4f
    db "cave to get to", $55
    db "CERULEAN CITY!", $57
; 0x808c9 + 47 bytes

_UnnamedText_49af7: ; 0x808f8
    db $0, "I", $4f
    db "lost.", $58
; 0x808f8 + 9 bytes

_UnnamedText_49afc: ; 0x80901
    db $0, "ZUBAT is tough!", $4f
    db "But, it can be", $55
    db "useful if you", $55
    db "catch one.", $57
; 0x80901 + 57 bytes

_MtMoon1Text14: ; 0x8093a
    db $0, "Beware! ZUBAT is", $4f
    db "a blood sucker!", $57

_UnnamedText_51a48: ; 0x8095c
    db $0, $57
; 0x8095c + 2 bytes

_UnnamedText_49f24: ; 0x8095e
    db $0, "You want the", $4f
    db "DOME FOSSIL?", $57
; 0x8095e + 27 bytes

_UnnamedText_49f64: ; 0x80979
    db $0, "You want the", $4f
    db "HELIX FOSSIL?", $57
; 0x80979 + 28 bytes

INCBIN "baserom.gbc",$80995,$809cc - $80995

_UnnamedText_49f85: ; 0x809cc
    db $0, "Hey, stop!", $51
    db "I found these", $4f
    db "fossils! They're", $55
    db "both mine!", $57
; 0x809cc + 53 bytes

_UnnamedText_49f8a: ; 0x80a01
    db $0, "OK!", $4f
    db "I'll share!", $58
; 0x80a01 + 16 bytes

_UnnamedText_49f8f: ; 0x80a11
    db $0, "We'll each take", $4f
    db "one!", $55
    db "No being greedy!", $57
; 0x80a11 + 38 bytes

_UnnamedText_49f94: ; 0x80a37
    db $0, "Far away, on", $4f
    db "CINNABAR ISLAND,", $55
    db "there's a #MON", $55
    db "LAB.", $51
    db "They do research", $4f
    db "on regenerating", $55
    db "fossils.", $57
; 0x80a37 + 92 bytes

INCBIN "baserom.gbc",$80a93,$80ab3 - $80a93

_UnnamedText_49f9f: ; 0x80ab3
    db $0, "TEAM ROCKET will", $4f
    db "find the fossils,", $55
    db "revive and sell", $55
    db "them for cash!", $57
; 0x80ab3 + 67 bytes

_UnnamedText_49fa4: ; 0x80af6
    db $0, "Urgh!", $4f
    db "Now I'm mad!", $58
; 0x80af6 + 19 bytes

_UnnamedText_49fa9: ; 0x80b09
    db $0, "You made me mad!", $4f
    db "TEAM ROCKET will", $55
    db "blacklist you!", $57
; 0x80b09 + 50 bytes

_UnnamedText_49fae: ; 0x80b3b
    db $0, "We, TEAM ROCKET,", $4f
    db "are #MON", $55
    db "gangsters!", $57
; 0x80b3b + 38 bytes

_UnnamedText_49fb3: ; 0x80b61
    db $0, "I blew", $4f
    db "it!", $58
; 0x80b61 + 12 bytes

_UnnamedText_49fb8: ; 0x80b6d
    db $0, "Darn it all! My", $4f
    db "associates won't", $55
    db "stand for this!", $57
; 0x80b6d + 49 bytes

_UnnamedText_49fbd: ; 0x80b9e
    db $0, "We're pulling a", $4f
    db "big job here!", $55
    db "Get lost, kid!", $57
; 0x80b9e + 45 bytes

_UnnamedText_49fc2: ; 0x80bcb
    db $0, "So, you", $4f
    db "are good.", $58
; 0x80bcb + 19 bytes

_UnnamedText_49fc7: ; 0x80bde
    db $0, "If you find a", $4f
    db "fossil, give it", $55
    db "to me and scram!", $57
; 0x80bde + 48 bytes

_UnnamedText_49fcc: ; 0x80c0e
    db $0, "Little kids", $4f
    db "should leave", $55
    db "grown-ups alone!", $57
; 0x80c0e + 43 bytes

_UnnamedText_49fd1: ; 0x80c39
    db $0, "I'm", $4f
    db "steamed!", $58
; 0x80c39 + 13 bytes

_UnnamedText_49fd6: ; 0x80c46
    db $0, "#MON lived", $4f
    db "here long before", $55
    db "people came.", $57
; 0x80c46 + 42 bytes

_SSAnne1Text1: ; 0x80c70
    db $0, "Bonjour!", $4f
    db "I am le waiter on", $55
    db "this ship!", $51
    db "I will be happy", $4f
    db "to serve you any-", $55
    db "thing you please!", $51
    db "Ah! Le strong", $4f
    db "silent type!", $57

_SSAnne1Text2: ; 0x80ce6
    db $0, "The passengers", $4f
    db "are restless!", $51
    db "You might be", $4f
    db "challenged by the", $55
    db "more bored ones!", $57

_SSAnne2Text1: ; 0x80d34
    db $0, "This ship, she is", $4f
    db "a luxury liner", $55
    db "for trainers!", $51
    db "At every port, we", $4f
    db "hold parties with", $55
    db "invited trainers!", $57

_UnnamedText_61500: ; 0x80d9a
    db $0, $53, ": Bonjour!", $4f
    db $52, "!", $51
    db "Imagine seeing", $4f
    db "you here!", $51
    db $52, ", were you", $4f
    db "really invited?", $51
    db "So how's your", $4f
    db "#DEX coming?", $51
    db "I already caught", $4f
    db "40 kinds, pal!", $51
    db "Different kinds", $4f
    db "are everywhere!", $51
    db "Crawl around in", $4f
    db "grassy areas!", $57
; 0x80d9a + 189 bytes

_UnnamedText_61505: ; 0x80e57
    db $0, "Humph!", $51
    db "At least you're", $4f
    db "raising your", $55
    db "#MON!", $58
; 0x80e57 + 42 bytes

_UnnamedText_6150a: ; 0x80e81
    db $0, $52, "! What are", $4f
    db "you, seasick?", $51
    db "You should shape", $4f
    db "up, pal!", $58
; 0x80e81 + 53 bytes

_UnnamedText_6150f: ; 0x80eb6
    db $0, $53, ": I heard", $4f
    db "there was a CUT", $55
    db "master on board.", $51
    db "But, he was just a", $4f
    db "seasick, old man!", $51
    db "But, CUT itself is", $4f
    db "really useful!", $51
    db "You should go see", $4f
    db "him! Smell ya!", $57
; 0x80eb6 + 149 bytes

_SSAnne3Text1: ; 0x80f4b
    db $0, "Our CAPTAIN is a", $4f
    db "sword master!", $51
    db "He even teaches", $4f
    db "CUT to #MON!", $57

_SSAnne5Text1: ; 0x80f88
    db $0, "The party's over.", $4f
    db "The ship will be", $55
    db "departing soon.", $57

_SSAnne5Text2: ; 0x80fbb
    db $0, "Scrubbing decks", $4f
    db "is hard work!", $57

_SSAnne5Text3: ; 0x80fda
    db $0, "Urf. I feel ill.", $51
    db "I stepped out to", $4f
    db "get some air.", $57

_UnnamedText_61703: ; 0x8100b
    db $0, "Hey matey!", $51
    db "Let's do a little", $4f
    db "jig!", $57
; 0x8100b + 34 bytes

_UnnamedText_61708: ; 0x8102d
    db $0, "You're", $4f
    db "impressive!", $58
; 0x8102d + 19 bytes

_UnnamedText_6170d: ; 0x81040
    db $0, "How many kinds of", $4f
    db "#MON do you", $55
    db "think there are?", $57
; 0x81040 + 48 bytes

_UnnamedText_6171c: ; 0x81070
    db $0, "Ahoy there!", $4f
    db "Are you seasick?", $57
; 0x81070 + 30 bytes

_UnnamedText_61721: ; 0x8108e
    db $0, "I was", $4f
    db "just careless!", $58
; 0x8108e + 22 bytes

_UnnamedText_61726: ; 0x810a4
    db $0, "My Pa said there", $4f
    db "are 100 kinds of", $55
    db "#MON. I think", $55
    db "there are more.", $57
; 0x810a4 + 65 bytes

_SSAnne6Text1: ; 0x810e5
    db $0, "You, mon petit!", $4f
    db "We're busy here!", $55
    db "Out of the way!", $57

_SSAnne6Text2: ; 0x81116
    db $0, "I saw an odd ball", $4f
    db "in the trash.", $57

_SSAnne6Text3: ; 0x81137
    db $0, "I'm so busy I'm", $4f
    db "getting dizzy!", $57

_SSAnne6Text4: ; 0x81155
    db $0, "Hum-de-hum-de-", $4f
    db "ho...", $51
    db "I peel spuds", $4f
    db "every day!", $55
    db "Hum-hum...", $57

_SSAnne6Text5: ; 0x8118e
    db $0, "Did you hear about", $4f
    db "SNORLAX?", $51
    db "All it does is", $4f
    db "eat and sleep!", $57

_SSAnne6Text6: ; 0x811c9
    db $0, "Snivel...Sniff...", $51
    db "I only get to", $4f
    db "peel onions...", $55
    db "Snivel...", $57

_UnnamedText_61807: ; 0x81203
    db $0, "Er-hem! Indeed I", $4f
    db "am le CHEF!", $51
    db "Le main course is", $58
; 0x81203 + 48 bytes

_UnnamedText_6180c: ; 0x81233
    db $0, "Salmon du Salad!", $51
    db "Les guests may", $4f
    db "gripe it's fish", $55
    db "again, however!", $57
; 0x81233 + 64 bytes

_UnnamedText_61811: ; 0x81273
    db $0, "Eels au Barbecue!", $51
    db "Les guests will", $4f
    db "mutiny, I fear.", $57
; 0x81273 + 51 bytes

_UnnamedText_61816: ; 0x812a6
    db $0, "Prime Beef Steak!", $51
    db "But, have I enough", $4f
    db "fillets du beef?", $57
; 0x812a6 + 55 bytes

INCBIN "baserom.gbc",$812dd,$81347 - $812dd

_UnnamedText_61927: ; 0x81347
    db $0, "CAPTAIN: Whew!", $4f
    db "Thank you! I", $55
    db "feel much better!", $51
    db "You want to see", $4f
    db "my CUT technique?", $51
    db "I could show you", $4f
    db "if I wasn't ill...", $51
    db "I know! You can", $4f
    db "have this!", $51
    db "Teach it to your", $4f
    db "#MON and you", $55
    db "can see it CUT", $55
    db "any time!", $58
; 0x81347 + 198 bytes

INCBIN "baserom.gbc",$8140d,$8141c - $8140d

_UnnamedText_61932: ; 0x8141c
    db $0, "CAPTAIN: Whew!", $51
    db "Now that I'm not", $4f
    db "sick any more, I", $55
    db "guess it's time.", $57
; 0x8141c + 65 bytes

_UnnamedText_61937: ; 0x8145d
    db $0, "Oh no! You have", $4f
    db "no room for this!", $57
; 0x8145d + 35 bytes

_SSAnne7Text2: ; 0x81480
    db $0, "Yuck! Shouldn't", $4f
    db "have looked!", $57

_SSAnne7Text3: ; 0x8149d
    db $0, "How to Conquer", $4f
    db "Seasickness...", $55
    db "The CAPTAIN's", $55
    db "reading this!", $57

_SSAnne8Text8: ; 0x814d7
    db $0, "WIGGLYTUFF: Puup", $4f
    db "pupuu!@@"

_UnnamedText_61a0b: ; 0x814f1
    db $0, "I travel alone", $4f
    db "on my journeys!", $51
    db "My #MON are my", $4f
    db "only friends!", $57
; 0x814f1 + 61 bytes

_UnnamedText_61a10: ; 0x8152e
    db $0, "My, my", $4f
    db "friends...", $58
; 0x8152e + 19 bytes

_UnnamedText_61a15: ; 0x81541
    db $0, "You should be", $4f
    db "nice to friends!", $57
; 0x81541 + 32 bytes

_UnnamedText_61a1a: ; 0x81561
    db $0, "You pup! How dare", $4f
    db "you barge in!", $57
; 0x81561 + 33 bytes

_UnnamedText_61a1f: ; 0x81582
    db $0, "Humph!", $4f
    db "You rude child!", $58
; 0x81582 + 24 bytes

_UnnamedText_61a24: ; 0x8159a
    db $0, "I wish to be left", $4f
    db "alone! Get out!", $57
; 0x8159a + 35 bytes

_UnnamedText_61a29: ; 0x815bd
    db $0, "I love #MON!", $4f
    db "Do you?", $57
; 0x815bd + 22 bytes

_UnnamedText_61a2e: ; 0x815d3
    db $0, "Wow! ", $4f
    db "You're great!", $58
; 0x815d3 + 20 bytes

_UnnamedText_61a33: ; 0x815e7
    db $0, "Let me be your", $4f
    db "friend, OK?", $51
    db "Then we can trade", $4f
    db "#MON!", $57
; 0x815e7 + 52 bytes

_UnnamedText_61a38: ; 0x8161b
    db $0, "I collected these", $4f
    db "#MON from all", $55
    db "around the world!", $57
; 0x8161b + 51 bytes

_UnnamedText_61a3d: ; 0x8164e
    db $0, "Oh no!", $4f
    db "I went around the", $55
    db "world for these!", $58
; 0x8164e + 43 bytes

_UnnamedText_61a42: ; 0x81679
    db $0, "You hurt my poor", $4f
    db "worldly #MON!", $51
    db "I demand that you", $4f
    db "heal them at a", $55
    db "#MON CENTER!", $57
; 0x81679 + 78 bytes

_SSAnne8Text5: ; 0x816c7
    db $0, "Waiter, I would", $4f
    db "like a cherry pie", $55
    db "please!", $57

_SSAnne8Text6: ; 0x816f2
    db $0, "A cruise is so", $4f
    db "elegant yet cozy!", $57

_SSAnne8Text7: ; 0x81714
    db $0, "I always travel", $4f
    db "with WIGGLYTUFF!", $57

_SSAnne8Text9: ; 0x81736
    db $0, "We are cruising", $4f
    db "around the world.", $57

_SSAnne8Text11: ; 0x81759
    db $0, "Ssh! I'm a GLOBAL", $4f
    db "POLICE agent!", $51
    db "I'm on the trail", $4f
    db "of TEAM ROCKET!", $57

_UnnamedText_61bf2: ; 0x81799
    db $0, "In all my travels", $4f
    db "I've never seen", $55
    db "any #MON sleep", $55
    db "like this one!", $51
    db "It was something", $4f
    db "like this!", $58
; 0x81799 + 92 bytes

_UnnamedText_61c01: ; 0x817f5
    db $0, "Ah yes, I have", $4f
    db "seen some #MON", $55
    db "ferry people", $55
    db "across the water!", $57
; 0x817f5 + 62 bytes

_UnnamedText_61c10: ; 0x81833
    db $0, "#MON can CUT", $4f
    db "down small bushes.", $57
; 0x81833 + 33 bytes

_UnnamedText_61c1f: ; 0x81854
    db $0, "Have you gone to", $4f
    db "the SAFARI ZONE", $55
    db "in FUCHSIA CITY?", $51
    db "It had many rare", $4f
    db "kinds of #MON!!", $57
; 0x81854 + 84 bytes

_UnnamedText_61c2e: ; 0x818a8
    db $0, "Me and my Daddy", $4f
    db "think the SAFARI", $55
    db "ZONE is awesome!", $57
; 0x818a8 + 51 bytes

_UnnamedText_61c3d: ; 0x818db
    db $0, "The CAPTAIN looked", $4f
    db "really sick and", $55
    db "pale!", $57
; 0x818db + 42 bytes

_UnnamedText_61c4c: ; 0x81905
    db $0, "I hear many people", $4f
    db "get seasick!", $57
; 0x81905 + 33 bytes

_UnnamedText_61c51: ; 0x81926
    db $0, "Competing against", $4f
    db "the young keeps", $55
    db "me youthful.", $57
; 0x81926 + 48 bytes

_UnnamedText_61c56: ; 0x81956
    db $0, "Good", $4f
    db "fight! Ah, I feel", $55
    db "young again!", $58
; 0x81956 + 37 bytes

_UnnamedText_61c5b: ; 0x8197b
    db $0, "15 years ago, I", $4f
    db "would have won!", $57
; 0x8197b + 33 bytes

_UnnamedText_61c60: ; 0x8199c
    db $0, "Check out what I", $4f
    db "fished up!", $57
; 0x8199c + 29 bytes

_UnnamedText_61c65: ; 0x819b9
    db $0, "I'm", $4f
    db "all out!", $58
; 0x819b9 + 13 bytes

_UnnamedText_61c6a: ; 0x819c6
    db $0, "Party?", $51
    db "The cruise ship's", $4f
    db "party should be", $55
    db "over by now.", $57
; 0x819c6 + 54 bytes

_UnnamedText_61c6f: ; 0x819fc
    db $0, "Which do you like,", $4f
    db "a strong or a", $55
    db "rare #MON?", $57
; 0x819fc + 45 bytes

_UnnamedText_61c74: ; 0x81a29
    db $0, "I must", $4f
    db "salute you!", $58
; 0x81a29 + 20 bytes

_UnnamedText_61c79: ; 0x81a3d
    db $0, "I prefer strong", $4f
    db "and rare #MON.", $57
; 0x81a3d + 32 bytes

_UnnamedText_61c7e: ; 0x81a5d
    db $0, "I never saw you", $4f
    db "at the party.", $57
; 0x81a5d + 31 bytes

_UnnamedText_61c83: ; 0x81a7c
    db $0, "Take", $4f
    db "it easy!", $58
; 0x81a7c + 15 bytes

_UnnamedText_61c88: ; 0x81a8b
    db $0, "Oh, I adore your", $4f
    db "strong #MON!", $57
; 0x81a8b + 31 bytes

_SSAnne10Text8: ; 0x81aaa
    db $0, "MACHOKE: Gwoh!", $4f
    db "Goggoh!@@"

_UnnamedText_61e16: ; 0x81ac3
    db $0, "You know what they", $4f
    db "say about sailors", $55
    db "and fighting!", $57
; 0x81ac3 + 52 bytes

_UnnamedText_61e1b: ; 0x81af7
    db $0, "Right!", $4f
    db "Good fight, mate!", $58
; 0x81af7 + 26 bytes

_UnnamedText_61e20: ; 0x81b11
    db $0, "Haha! Want to be", $4f
    db "a sailor, mate?", $57
; 0x81b11 + 34 bytes

_UnnamedText_61e25: ; 0x81b33
    db $0, "My sailor's pride", $4f
    db "is at stake!", $57
; 0x81b33 + 31 bytes

_UnnamedText_61e2a: ; 0x81b52
    db $0, "Your", $4f
    db "spirit sank me!", $58
; 0x81b52 + 22 bytes

_UnnamedText_61e2f: ; 0x81b68
    db $0, "Did you see the", $4f
    db "FISHING GURU in", $55
    db "VERMILION CITY?", $57
; 0x81b68 + 49 bytes

_UnnamedText_61e34: ; 0x81b99
    db $0, "Us sailors have", $4f
    db "#MON too!", $57
; 0x81b99 + 27 bytes

_UnnamedText_61e39: ; 0x81bb4
    db $0, "OK, ", $4f
    db "you're not bad.", $58
; 0x81bb4 + 21 bytes

_UnnamedText_61e3e: ; 0x81bc9
    db $0, "We caught all our", $4f
    db "#MON while", $55
    db "out at sea!", $57
; 0x81bc9 + 42 bytes

_UnnamedText_61e43: ; 0x81bf3
    db $0, "I like feisty", $4f
    db "kids like you!@"
; 0x81bf3 + 30 bytes

INCBIN "baserom.gbc",$81c11,$81c12 - $81c11

_UnnamedText_61e48: ; 0x81c12
    db $0, "Argh!", $4f
    db "Lost it!", $58
; 0x81c12 + 16 bytes

_UnnamedText_61e4d: ; 0x81c22
    db $0, "Sea #MON live", $4f
    db "in deep water.", $55
    db "You'll need a ROD!", $57
; 0x81c22 + 48 bytes

_UnnamedText_61e52: ; 0x81c52
    db $0, "Matey, you're", $4f
    db "walking the plank", $55
    db "if you lose!", $57
; 0x81c52 + 45 bytes

_UnnamedText_61e57: ; 0x81c7f
    db $0, "Argh!", $4f
    db "Beaten by a kid!", $58
; 0x81c7f + 24 bytes

_UnnamedText_61e5c: ; 0x81c97
    db $0, "Jellyfish some-", $4f
    db "times drift into", $55
    db "the ship.", $57
; 0x81c97 + 44 bytes

_UnnamedText_61e61: ; 0x81cc3
    db $0, "Hello stranger!", $4f
    db "Stop and chat!", $51
    db "All my #MON", $4f
    db "are from the sea!", $57
; 0x81cc3 + 62 bytes

_UnnamedText_61e66: ; 0x81d01
    db $0, "Darn!", $4f
    db "I let that one", $55
    db "get away!", $58
; 0x81d01 + 32 bytes

_UnnamedText_61e6b: ; 0x81d21
    db $0, "I was going to", $4f
    db "make you my", $55
    db "assistant too!", $57
; 0x81d21 + 43 bytes

_SSAnne10Text7: ; 0x81d4c
    db $0, "My buddy, MACHOKE,", $4f
    db "is super strong!", $51
    db "He has enough", $4f
    db "STRENGTH to move", $55
    db "big rocks!", $57

_UnnamedText_44a91: ; 0x81d9b
    db $0, "I heard rumors of", $4f
    db "a child prodigy!", $57
; 0x81d9b + 36 bytes

_UnnamedText_44a96: ; 0x81dbf
    db $0, "The", $4f
    db "rumors were true!", $58
; 0x81dbf + 23 bytes

_UnnamedText_44a9b: ; 0x81dd6
    db $0, "You beat GIOVANNI", $4f
    db "of TEAM ROCKET?", $57
; 0x81dd6 + 35 bytes

_UnnamedText_44aa0: ; 0x81df9
    db $0, "I'll show you just", $4f
    db "how good you are!", $57
; 0x81df9 + 37 bytes

_UnnamedText_44aa5: ; 0x81e1e
    db $0, "I'm", $4f
    db "furious!", $58
; 0x81e1e + 13 bytes

_UnnamedText_44aaa: ; 0x81e2b
    db $0, "You showed me just", $4f
    db "how good I was!", $57
; 0x81e2b + 36 bytes

_UnnamedText_44aaf: ; 0x81e4f
    db $0, "Only the chosen", $4f
    db "can pass here!", $57
; 0x81e4f + 32 bytes

_UnnamedText_44ab4: ; 0x81e6f
    db $0, "I", $4f
    db "don't believe it!", $58
; 0x81e6f + 20 bytes

_UnnamedText_44ab9: ; 0x81e83
    db $0, "All trainers here", $4f
    db "are headed to the", $55
    db "#MON LEAGUE!", $55
    db "Be careful!", $57
; 0x81e83 + 62 bytes

_UnnamedText_44abe: ; 0x81ec1
    db $0, "Trainers live to", $4f
    db "seek stronger", $55
    db "opponents!", $57
; 0x81ec1 + 43 bytes

_UnnamedText_44ac3: ; 0x81eec
    db $0, "Oh!", $4f
    db "So strong!", $58
; 0x81eec + 16 bytes

_UnnamedText_44ac8: ; 0x81efc
    db $0, "By fighting tough", $4f
    db "battles, you get", $55
    db "stronger!", $57
; 0x81efc + 46 bytes

INCBIN "baserom.gbc",$81f2a,$81f34 - $81f2a

_UnnamedText_44ca1: ; 0x81f34
    db $0, "Who are you? How", $4f
    db "did you get here?", $57
; 0x81f34 + 36 bytes

_UnnamedText_44ca6: ; 0x81f58
    db $0, "Oww!", $4f
    db "Beaten!", $58
; 0x81f58 + 14 bytes

_UnnamedText_44cab: ; 0x81f66
    db $0, "Are you dissing", $4f
    db "TEAM ROCKET?", $57
; 0x81f66 + 30 bytes

_UnnamedText_44cb0: ; 0x81f84
    db $0, "You broke into", $4f
    db "our operation?", $57
; 0x81f84 + 31 bytes

_UnnamedText_44cb5: ; 0x81fa3
    db $0, "Burnt!", $58
; 0x81fa3 + 8 bytes

_UnnamedText_44cba: ; 0x81fab
    db $0, "You're not going", $4f
    db "to get away with", $55
    db "this, brat!", $57
; 0x81fab + 46 bytes

_UnnamedText_44cbf: ; 0x81fd9
    db $0, "Intruder alert!", $57
; 0x81fd9 + 17 bytes

_UnnamedText_44cc4: ; 0x81fea
    db $0, "I", $4f
    db "can't do it!", $58
; 0x81fea + 15 bytes

_UnnamedText_44cc9: ; 0x81ff9
    db $0, "SILPH SCOPE?", $4f
    db "I don't know", $55
    db "where it is!", $57
; 0x81ff9 + 39 bytes

_UnnamedText_44cce: ; 0x82020
    db $0, "Why did you come", $4f
    db "here?", $57
; 0x82020 + 24 bytes

_UnnamedText_44cd3: ; 0x82038
    db $0, "This", $4f
    db "won't do!", $58
; 0x82038 + 15 bytes

_UnnamedText_44cd8: ; 0x82047
    db $0, "OK, I'll talk!", $4f
    db "Take the elevator", $55
    db "to see my BOSS!", $57
; 0x82047 + 49 bytes

_UnnamedText_44cdd: ; 0x82078
    db $0, "Are you lost, you", $4f
    db "little rat?", $57
; 0x82078 + 31 bytes

_UnnamedText_44ce2: ; 0x82097
    db $0, "Uh-oh, that fight", $4f
    db "opened the door!", $57
; 0x82097 + 36 bytes

_UnnamedText_450e8: ; 0x820bb
    db $0, "BOSS said you can", $4f
    db "see GHOSTs with", $55
    db "the SILPH SCOPE!", $57
; 0x820bb + 52 bytes

_UnnamedText_450ed: ; 0x820ef
    db $0, "I", $4f
    db "surrender!", $58
; 0x820ef + 14 bytes

_UnnamedText_450f2: ; 0x820fd
    db $0, "The TEAM ROCKET", $4f
    db "HQ has 4 basement", $55
    db "floors. Can you", $55
    db "reach the BOSS?", $57
; 0x820fd + 67 bytes

_UnnamedText_45325: ; 0x82140
    db $0, "Stop meddling in", $4f
    db "TEAM ROCKET's", $55
    db "affairs!", $57
; 0x82140 + 40 bytes

_UnnamedText_4532a: ; 0x82168
    db $0, "Oof!", $4f
    db "Taken down!", $58
; 0x82168 + 18 bytes

_UnnamedText_4532f: ; 0x8217a
    db $0, "SILPH SCOPE?", $4f
    db "The machine the", $55
    db "BOSS stole. It's", $55
    db "here somewhere.", $57
; 0x8217a + 62 bytes

_UnnamedText_4533e: ; 0x821b8
    db $0, "We got word from", $4f
    db "upstairs that you", $55
    db "were coming!", $57
; 0x821b8 + 49 bytes

_UnnamedText_45343: ; 0x821e9
    db $0, "What?", $4f
    db "I lost? No!", $58
; 0x821e9 + 19 bytes

_UnnamedText_45348: ; 0x821fc
    db $0, "Go ahead and go!", $4f
    db "But, you need the", $55
    db "LIFT KEY to run", $55
    db "the elevator!", $57
; 0x821fc + 66 bytes

_UnnamedText_4557a: ; 0x8223e
    db $0, "So! I must say, I", $4f
    db "am impressed you", $55
    db "got here!", $57
; 0x8223e + 46 bytes

_UnnamedText_4557f: ; 0x8226c
    db $0, "WHAT!", $4f
    db "This cannot be!", $58
; 0x8226c + 23 bytes

_UnnamedText_45584: ; 0x82283
    db $0, "I see that you", $4f
    db "raise #MON", $55
    db "with utmost care.", $51
    db "A child like you", $4f
    db "would never", $55
    db "understand what I", $55
    db "hope to achieve.", $51
    db "I shall step", $4f
    db "aside this time!", $51
    db "I hope we meet", $4f
    db "again...", $57
; 0x82283 + 163 bytes

_UnnamedText_45593: ; 0x82326
    db $0, "I know you! You", $4f
    db "ruined our plans", $55
    db "at MT.MOON!", $57
; 0x82326 + 46 bytes

_UnnamedText_45598: ; 0x82354
    db $0, "Burned", $4f
    db "again!", $58
; 0x82354 + 15 bytes

_UnnamedText_4559d: ; 0x82363
    db $0, "Do you have", $4f
    db "something against", $55
    db "TEAM ROCKET?", $57
; 0x82363 + 44 bytes

_UnnamedText_455ac: ; 0x8238f
    db $0, "How can you not", $4f
    db "see the beauty of", $55
    db "our evil?", $57
; 0x8238f + 45 bytes

_UnnamedText_455b1: ; 0x823bc
    db $0, "Ayaya!", $58
; 0x823bc + 8 bytes

_UnnamedText_455b6: ; 0x823c4
    db $0, "BOSS! I'm sorry I", $4f
    db "failed you!", $57
; 0x823c4 + 30 bytes

_UnnamedText_455c5: ; 0x823e2
    db $0, "The elevator", $4f
    db "doesn't work? Who", $55
    db "has the LIFT KEY?", $57
; 0x823e2 + 49 bytes

_UnnamedText_455ca: ; 0x82413
    db $0, "No!", $58
; 0x82413 + 5 bytes

_UnnamedText_455ec: ; 0x82418
    db $0, "Oh no! I dropped", $4f
    db "the LIFT KEY!", $57
; 0x82418 + 32 bytes

INCBIN "baserom.gbc",$82438,$1c

_UnnamedText_59ded: ; 0x82454
    db $0, "Eeek!", $4f
    db "No! Stop! Help!", $51
    db "Oh, you're not", $4f
    db "with TEAM ROCKET.", $55
    db "I thought...", $55
    db "I'm sorry. Here,", $55
    db "please take this!", $58
; 0x82454 + 102 bytes

INCBIN "baserom.gbc",$824ba,$824c9 - $824ba

_UnnamedText_59df8: ; 0x824c9
    db $0, "TM36 is", $4f
    db "SELFDESTRUCT!", $51
    db "It's powerful, but", $4f
    db "the #MON that", $55
    db "uses it faints!", $55
    db "Be careful.", $57
; 0x824c9 + 83 bytes

_UnnamedText_59dfd: ; 0x8251c
    db $0, "You don't have any", $4f
    db "room for this.", $57
; 0x8251c + 34 bytes

_UnnamedText_59e2a: ; 0x8253e
    db $0, "Help! I'm a SILPH", $4f
    db "employee.", $57
; 0x8253e + 28 bytes

_UnnamedText_59e2f: ; 0x8255a
    db $0, "How", $4f
    db "did you know I", $55
    db "was a ROCKET?", $58
; 0x8255a + 34 bytes

_UnnamedText_59e34: ; 0x8257c
    db $0, "I work for both", $4f
    db "SILPH and TEAM", $55
    db "ROCKET!", $57
; 0x8257c + 40 bytes

_UnnamedText_59e39: ; 0x825a4
    db $0, "It's off limits", $4f
    db "here! Go home!", $57
; 0x825a4 + 31 bytes

_UnnamedText_59e3e: ; 0x825c3
    db $0, "You're", $4f
    db "good.", $58
; 0x825c3 + 13 bytes

_UnnamedText_59e43: ; 0x825d0
    db $0, "Can you solve the", $4f
    db "maze in here?", $57
; 0x825d0 + 33 bytes

_UnnamedText_59e48: ; 0x825f1
    db $0, "No kids are", $4f
    db "allowed in here!", $57
; 0x825f1 + 30 bytes

_UnnamedText_59e4d: ; 0x8260f
    db $0, "Tough!", $58
; 0x8260f + 8 bytes

_UnnamedText_59e52: ; 0x82617
    db $0, "Diamond shaped", $4f
    db "tiles are", $55
    db "teleport blocks!", $51
    db "They're hi-tech", $4f
    db "transporters!", $57
; 0x82617 + 72 bytes

_UnnamedText_59e57: ; 0x8265f
    db $0, "Hey kid! What are", $4f
    db "you doing here?", $57
; 0x8265f + 35 bytes

_UnnamedText_59e5c: ; 0x82682
    db $0, "I goofed!", $58
; 0x82682 + 11 bytes

_UnnamedText_59e61: ; 0x8268d
    db $0, "SILPH CO. will", $4f
    db "be merged with", $55
    db "TEAM ROCKET!", $57
; 0x8268d + 44 bytes

_UnnamedText_59ff9: ; 0x826b9
    db $0, "I work for SILPH.", $4f
    db "What should I do?", $57
; 0x826b9 + 37 bytes

_UnnamedText_59ffe: ; 0x826de
    db $0, $52, "! You and", $4f
    db "your #MON", $55
    db "saved us!", $57
; 0x826de + 32 bytes

_UnnamedText_5a00d: ; 0x826fe
    db $0, "Quit messing with", $4f
    db "us, kid!", $57
; 0x826fe + 28 bytes

_UnnamedText_5a012: ; 0x8271a
    db $0, "I give", $4f
    db "up!", $58
; 0x8271a + 12 bytes

_UnnamedText_5a017: ; 0x82726
    db $0, "A hint? You can", $4f
    db "open doors with a", $55
    db "CARD KEY!", $57
; 0x82726 + 45 bytes

_UnnamedText_5a026: ; 0x82753
    db $0, "I support TEAM", $4f
    db "ROCKET more than", $55
    db "I support SILPH!", $57
; 0x82753 + 50 bytes

_UnnamedText_5a02b: ; 0x82785
    db $0, "You", $4f
    db "really got me!", $58
; 0x82785 + 20 bytes

_UnnamedText_5a030: ; 0x82799
    db $0, "Humph...", $51
    db "TEAM ROCKET said", $4f
    db "that if I helped", $55
    db "them, they'd let", $55
    db "me study #MON!", $57
; 0x82799 + 75 bytes

_UnnamedText_19de0: ; 0x827e4
    db $0, "Sssh! Can't you", $4f
    db "see I'm hiding?", $57
; 0x827e4 + 31 bytes

_UnnamedText_19de5: ; 0x82803
    db $0, "Huh? TEAM ROCKET", $4f
    db "is gone?", $57
; 0x82803 + 27 bytes

_UnnamedText_19df4: ; 0x8281e
    db $0, "TEAM ROCKET has", $4f
    db "taken command of", $55
    db "SILPH CO.!", $57
; 0x8281e + 45 bytes

_UnnamedText_19df9: ; 0x8284b
    db $0, "Arrgh!", $58
; 0x8284b + 8 bytes

_UnnamedText_19dfe: ; 0x82853
    db $0, "Fwahahaha!", $4f
    db "My BOSS has been", $55
    db "after this place!", $57
; 0x82853 + 47 bytes

_UnnamedText_19e0d: ; 0x82882
    db $0, "My #MON are my", $4f
    db "loyal soldiers!", $57
; 0x82882 + 32 bytes

_UnnamedText_19e12: ; 0x828a2
    db $0, "Darn!", $4f
    db "You weak #MON!", $58
; 0x828a2 + 22 bytes

_UnnamedText_19e17: ; 0x828b8
    db $0, "The doors are", $4f
    db "electronically", $55
    db "locked! A CARD", $55
    db "KEY opens them!", $57
; 0x828b8 + 61 bytes

_UnnamedText_19e26: ; 0x828f5
    db $0, "Intruder spotted!", $57
; 0x828f5 + 19 bytes

_UnnamedText_19e2b: ; 0x82908
    db $0, "Who", $4f
    db "are you?", $58
; 0x82908 + 14 bytes

_UnnamedText_19e30: ; 0x82916
    db $0, "I better tell the", $4f
    db "BOSS on 11F!", $57
; 0x82916 + 32 bytes

_UnnamedText_1a010: ; 0x82936
    db $0, "TEAM ROCKET is", $4f
    db "in an uproar over", $55
    db "some intruder.", $55
    db "That's you right?", $57
; 0x82936 + 66 bytes

_UnnamedText_1a015: ; 0x82978
    db $0, "TEAM ROCKET took", $4f
    db "off! You're our", $55
    db "hero! Thank you!", $57
; 0x82978 + 50 bytes

_UnnamedText_1a024: ; 0x829aa
    db $0, "I heard a kid was", $4f
    db "wandering around.", $57
; 0x829aa + 37 bytes

_UnnamedText_1a029: ; 0x829cf
    db $0, "Boom!", $58
; 0x829cf + 7 bytes

_UnnamedText_1a02e: ; 0x829d6
    db $0, "It's not smart", $4f
    db "to pick a fight", $55
    db "with TEAM ROCKET!", $57
; 0x829d6 + 49 bytes

_UnnamedText_1a03d: ; 0x82a07
    db $0, "We study #", $4f
    db "BALL technology", $55
    db "on this floor!", $57
; 0x82a07 + 43 bytes

_UnnamedText_1a042: ; 0x82a32
    db $0, "Dang!", $4f
    db "Blast it!", $58
; 0x82a32 + 17 bytes

_UnnamedText_1a047: ; 0x82a43
    db $0, "We worked on the", $4f
    db "ultimate #", $55
    db "BALL which would", $55
    db "catch anything!", $57
; 0x82a43 + 62 bytes

_UnnamedText_1a056: ; 0x82a81
    db $0, "Whaaat? There", $4f
    db "shouldn't be any", $55
    db "children here?", $57
; 0x82a81 + 46 bytes

SECTION "bank21",DATA,BANK[$21]

_UnnamedText_1a05b: ; 0x84000
    db $0, "Oh", $4f
    db "goodness!", $58
; 0x84000 + 14 bytes

_UnnamedText_1a060: ; 0x8400e
    db $0, "You're only on 5F.", $4f
    db "It's a long way", $55
    db "to my BOSS!", $57
; 0x8400e + 46 bytes

_UnnamedText_1a06f: ; 0x8403c
    db $0, "Show TEAM ROCKET", $4f
    db "a little respect!", $57
; 0x8403c + 36 bytes

_UnnamedText_1a074: ; 0x84060
    db $0, "Cough...", $4f
    db "Cough...", $58
; 0x84060 + 19 bytes

_UnnamedText_1a079: ; 0x84073
    db $0, "Which reminds me.", $51
    db "KOFFING evolves", $4f
    db "into WEEZING!", $57
; 0x84073 + 49 bytes

_SilphCo5Text9: ; 0x840a4
    db $0, "It's a #MON", $4f
    db "REPORT!", $51
    db "#MON LAB", $4f
    db "created PORYGON,", $55
    db "the first virtual", $55
    db "reality #MON.", $57

_SilphCo5Text10: ; 0x840f2
    db $0, "It's a #MON", $4f
    db "REPORT!", $51
    db "Over 160 #MON", $4f
    db "techniques have", $55
    db "been confirmed.", $57

_SilphCo5Text11: ; 0x84134
    db $0, "It's a #MON", $4f
    db "REPORT!", $51
    db "4 #MON evolve", $4f
    db "only when traded", $55
    db "by link-cable.", $57

_UnnamedText_1a24a: ; 0x84176
    db $0, "The ROCKETs came", $4f
    db "and took over the", $55
    db "building!", $57
; 0x84176 + 46 bytes

_UnnamedText_1a24f: ; 0x841a4
    db $0, "Well, better get", $4f
    db "back to work!", $57
; 0x841a4 + 32 bytes

_UnnamedText_1a261: ; 0x841c4
    db $0, "Oh dear, oh dear.", $4f
    db "Help me please!", $57
; 0x841c4 + 35 bytes

_UnnamedText_1a266: ; 0x841e7
    db $0, "We got engaged!", $4f
    db "Heheh!", $57
; 0x841e7 + 24 bytes

_UnnamedText_1a278: ; 0x841ff
    db $0, "Look at him! He's", $4f
    db "such a coward!", $57
; 0x841ff + 33 bytes

_UnnamedText_1a27d: ; 0x84220
    db $0, "I feel so sorry", $4f
    db "for him, I have", $55
    db "to marry him!", $57
; 0x84220 + 47 bytes

_UnnamedText_1a28f: ; 0x8424f
    db $0, "TEAM ROCKET is", $4f
    db "trying to conquer", $55
    db "the world with", $55
    db "#MON!", $57
; 0x8424f + 55 bytes

_UnnamedText_1a294: ; 0x84286
    db $0, "TEAM ROCKET ran", $4f
    db "because of you!", $57
; 0x84286 + 33 bytes

_UnnamedText_1a2a6: ; 0x842a7
    db $0, "They must have", $4f
    db "targeted SILPH", $55
    db "for our #MON", $55
    db "products.", $57
; 0x842a7 + 54 bytes

_UnnamedText_1a2ab: ; 0x842dd
    db $0, "Come work for", $4f
    db "SILPH when you", $55
    db "get older!", $57
; 0x842dd + 41 bytes

_UnnamedText_1a2ba: ; 0x84306
    db $0, "I am one of the 4", $4f
    db "ROCKET BROTHERS!", $57
; 0x84306 + 36 bytes

_UnnamedText_1a2bf: ; 0x8432a
    db $0, "Flame", $4f
    db "out!", $58
; 0x8432a + 12 bytes

_UnnamedText_1a2c4: ; 0x84336
    db $0, "No matter!", $4f
    db "My brothers will", $55
    db "avenge me!", $57
; 0x84336 + 40 bytes

_UnnamedText_1a2d3: ; 0x8435e
    db $0, "That rotten", $4f
    db "PRESIDENT!", $51
    db "He shouldn't have", $4f
    db "sent me to the", $55
    db "TIKSI BRANCH!", $57
; 0x8435e + 70 bytes

_UnnamedText_1a2d8: ; 0x843a4
    db $0, "Shoot!", $58
; 0x843a4 + 8 bytes

_UnnamedText_1a2dd: ; 0x843ac
    db $0, "TIKSI BRANCH?", $4f
    db "It's in Russian", $55
    db "no man's land!", $57
; 0x843ac + 44 bytes

_UnnamedText_1a2ec: ; 0x843d8
    db $0, "You dare betray", $4f
    db "TEAM ROCKET?", $57
; 0x843d8 + 30 bytes

_UnnamedText_1a2f1: ; 0x843f6
    db $0, "You", $4f
    db "traitor!", $58
; 0x843f6 + 14 bytes

_UnnamedText_1a2f6: ; 0x84404
    db $0, "If you stand for", $4f
    db "justice, you", $55
    db "betray evil!", $57
; 0x84404 + 44 bytes

_UnnamedText_51dd3: ; 0x84430
    db $0, "Oh! Hi! You're", $4f
    db "not a ROCKET! You", $55
    db "came to save us?", $55
    db "Why, thank you!", $51
    db "I want you to", $4f
    db "have this #MON", $55
    db "for saving us.", $58
; 0x84430 + 110 bytes

_UnnamedText_51dd8: ; 0x8449e
    db $0, "It's LAPRAS. It's", $4f
    db "very intelligent.", $51
    db "We kept it in our", $4f
    db "lab, but it will", $55
    db "be much better", $55
    db "off with you!", $51
    db "I think you will", $4f
    db "be a good trainer", $55
    db "for LAPRAS!", $51
    db "It's a good", $4f
    db "swimmer. It'll", $55
    db "give you a lift!", $57
; 0x8449e + 188 bytes

_UnnamedText_51ddd: ; 0x8455a
    db $0, "TEAM ROCKET's", $4f
    db "BOSS went to the", $55
    db "boardroom! Is our", $55
    db "PRESIDENT OK?", $57
; 0x8455a + 63 bytes

_UnnamedText_51de2: ; 0x84599
    db $0, "Saved at last!", $4f
    db "Thank you!", $57
; 0x84599 + 27 bytes

_UnnamedText_51e00: ; 0x845b4
    db $0, "TEAM ROCKET was", $4f
    db "after the MASTER", $55
    db "BALL which will", $55
    db "catch any #MON!", $57
; 0x845b4 + 66 bytes

_UnnamedText_51e05: ; 0x845f6
    db $0, "We canceled the", $4f
    db "MASTER BALL", $55
    db "project because", $55
    db "of TEAM ROCKET.", $57
; 0x845f6 + 61 bytes

_UnnamedText_51e23: ; 0x84633
    db $0, "It would be bad", $4f
    db "if TEAM ROCKET", $55
    db "took over SILPH", $55
    db "or our #MON!", $57
; 0x84633 + 61 bytes

_UnnamedText_51e28: ; 0x84670
    db $0, "Wow! You chased", $4f
    db "off TEAM ROCKET", $55
    db "all by yourself?", $57
; 0x84670 + 50 bytes

_UnnamedText_51e46: ; 0x846a2
    db $0, "You! It's really", $4f
    db "dangerous here!", $55
    db "You came to save", $55
    db "me? You can't!", $57
; 0x846a2 + 64 bytes

_UnnamedText_51e4b: ; 0x846e2
    db $0, "Safe at last!", $4f
    db "Oh thank you!", $57
; 0x846e2 + 29 bytes

_UnnamedText_51e5a: ; 0x846ff
    db $0, "Oh ho! I smell a", $4f
    db "little rat!", $57
; 0x846ff + 30 bytes

_UnnamedText_51e5f: ; 0x8471d
    db $0, "Lights", $4f
    db "out!", $58
; 0x8471d + 13 bytes

_UnnamedText_51e64: ; 0x8472a
    db $0, "You won't find my", $4f
    db "BOSS by just", $55
    db "scurrying around!", $57
; 0x8472a + 49 bytes

_UnnamedText_51e73: ; 0x8475b
    db $0, "Heheh!", $51
    db "You mistook me for", $4f
    db "a SILPH worker?", $57
; 0x8475b + 43 bytes

_UnnamedText_51e78: ; 0x84786
    db $0, "I'm", $4f
    db "done!", $58
; 0x84786 + 10 bytes

_UnnamedText_51e7d: ; 0x84790
    db $0, "Despite your age,", $4f
    db "you are a skilled", $55
    db "trainer!", $57
; 0x84790 + 46 bytes

_UnnamedText_51e8c: ; 0x847be
    db $0, "I am one of the 4", $4f
    db "ROCKET BROTHERS!", $57
; 0x847be + 36 bytes

_UnnamedText_51e91: ; 0x847e2
    db $0, "Aack!", $4f
    db "Brothers, I lost!", $58
; 0x847e2 + 25 bytes

_UnnamedText_51e96: ; 0x847fb
    db $0, "Doesn't matter.", $4f
    db "My brothers will", $55
    db "repay the favor!", $57
; 0x847fb + 50 bytes

_UnnamedText_51ea5: ; 0x8482d
    db $0, "A child intruder?", $4f
    db "That must be you!", $57
; 0x8482d + 37 bytes

_UnnamedText_51eaa: ; 0x84852
    db $0, "Fine!", $4f
    db "I lost!", $58
; 0x84852 + 15 bytes

_UnnamedText_51eaf: ; 0x84861
    db $0, "Go on home", $4f
    db "before my BOSS", $55
    db "gets ticked off!", $57
; 0x84861 + 44 bytes

_UnnamedText_51ebe: ; 0x8488d
    db $0, $53, ": What", $4f
    db "kept you ", $52, "?", $57
; 0x8488d + 21 bytes

_UnnamedText_51ec3: ; 0x848a2
    db $0, $53, ": Hahaha!", $4f
    db "I thought you'd", $55
    db "turn up if I", $55
    db "waited here!", $51
    db "I guess TEAM", $4f
    db "ROCKET slowed you", $55
    db "down! Not that I", $55
    db "care!", $51
    db "I saw you in", $4f
    db "SAFFRON, so I", $55
    db "decided to see if", $55
    db "you got better!", $57
; 0x848a2 + 168 bytes

_UnnamedText_51ec8: ; 0x8494a
    db $0, "Oh ho!", $4f
    db "So, you are ready", $55
    db "for BOSS ROCKET!", $58
; 0x8494a + 43 bytes

_UnnamedText_51ecd: ; 0x84975
    db $0, $53, ": How can", $4f
    db "I put this?", $51
    db "You're not good", $4f
    db "enough to play", $55
    db "with us big boys!", $58
; 0x84975 + 72 bytes

_UnnamedText_51ed2: ; 0x849bd
    db $0, "Well, ", $52, "!", $51
    db "I'm moving on up", $4f
    db "and ahead!", $51
    db "By checking my", $4f
    db "#DEX, I'm", $55
    db "starting to see", $55
    db "what's strong and", $55
    db "how they evolve!", $51
    db "I'm going to the", $4f
    db "#MON LEAGUE", $55
    db "to boot out the", $55
    db "ELITE FOUR!", $51
    db "I'll become the", $4f
    db "world's most", $55
    db "powerful trainer!", $51
    db $52, ", well", $4f
    db "good luck to you!", $55
    db "Don't sweat it!", $55
    db "Smell ya!", $57
; 0x849bd + 263 bytes

_UnnamedText_565be: ; 0x84ac4
    db $0, "I wonder if SILPH", $4f
    db "is finished...", $57
; 0x84ac4 + 34 bytes

_UnnamedText_565c3: ; 0x84ae6
    db $0, "Thanks for saving", $4f
    db "us!", $57
; 0x84ae6 + 23 bytes

_UnnamedText_565e6: ; 0x84afd
    db $0, "That's as far as", $4f
    db "you'll go!", $57
; 0x84afd + 27 bytes

_UnnamedText_565eb: ; 0x84b18
    db $0, "Not", $4f
    db "enough grit!", $58
; 0x84b18 + 18 bytes

_UnnamedText_565f0: ; 0x84b2a
    db $0, "If you don't turn", $4f
    db "back, I'll call", $55
    db "for backup!", $57
; 0x84b2a + 45 bytes

_UnnamedText_565f5: ; 0x84b57
    db $0, "You're causing us", $4f
    db "problems!", $57
; 0x84b57 + 28 bytes

_UnnamedText_565fa: ; 0x84b73
    db $0, "Huh?", $4f
    db "I lost?", $58
; 0x84b73 + 14 bytes

_UnnamedText_565ff: ; 0x84b81
    db $0, "So, what do you", $4f
    db "think of SILPH", $55
    db "BUILDING's maze?", $57
; 0x84b81 + 48 bytes

_UnnamedText_56604: ; 0x84bb1
    db $0, "I am one of the 4", $4f
    db "ROCKET BROTHERS!", $57
; 0x84bb1 + 36 bytes

_UnnamedText_56609: ; 0x84bd5
    db $0, "Whoo!", $4f
    db "Oh brothers!", $58
; 0x84bd5 + 20 bytes

_UnnamedText_5660e: ; 0x84be9
    db $0, "I'll leave you up", $4f
    db "to my brothers!", $57
; 0x84be9 + 34 bytes

_UnnamedText_5d8e5: ; 0x84c0b
    db $0, "You look tired!", $4f
    db "You should take a", $55
    db "quick nap!", $58
; 0x84c0b + 46 bytes

_UnnamedText_5d8ea: ; 0x84c39
    db $0, "Don't give up!", $57
; 0x84c39 + 15 bytes

_UnnamedText_5d8ef: ; 0x84c48
    db $0, "Thank you so", $4f
    db "much!", $57
; 0x84c48 + 20 bytes

_UnnamedText_5d912: ; 0x84c5c
    db $0, "Your #MON seem", $4f
    db "to adore you, kid!", $57
; 0x84c5c + 35 bytes

_UnnamedText_5d917: ; 0x84c7f
    db $0, "Ghaaah!", $58
; 0x84c7f + 9 bytes

_UnnamedText_5d91c: ; 0x84c88
    db $0, "If I had started", $4f
    db "as a trainer at", $55
    db "your age...", $57
; 0x84c88 + 46 bytes

_UnnamedText_5d921: ; 0x84cb6
    db $0, "Your #MON have", $4f
    db "weak points! I", $55
    db "can nail them!", $57
; 0x84cb6 + 46 bytes

_UnnamedText_5d926: ; 0x84ce4
    db $0, "You", $4f
    db "hammered me!", $58
; 0x84ce4 + 18 bytes

_UnnamedText_5d92b: ; 0x84cf6
    db $0, "Exploiting weak", $4f
    db "spots does work!", $55
    db "Think about", $55
    db "element types!", $57
; 0x84cf6 + 61 bytes

_UnnamedText_5d930: ; 0x84d33
    db $0, "I am one of the 4", $4f
    db "ROCKET BROTHERS!", $57
; 0x84d33 + 36 bytes

_UnnamedText_5d935: ; 0x84d57
    db $0, "Warg!", $4f
    db "Brothers, I lost!", $58
; 0x84d57 + 25 bytes

_UnnamedText_5d93a: ; 0x84d70
    db $0, "My brothers will", $4f
    db "avenge me!", $57
; 0x84d70 + 29 bytes

_UnnamedText_5a1d3: ; 0x84d8d
    db $0, "Waaaaa!", $55
    db "I'm scared!", $57
; 0x84d8d + 20 bytes

_UnnamedText_5a1d8: ; 0x84da1
    db $0, "Please keep quiet", $4f
    db "about my crying!", $57
; 0x84da1 + 36 bytes

_UnnamedText_5a1dd: ; 0x84dc5
    db $0, "Welcome to the", $4f
    db "10F! So good of", $55
    db "you to join me!", $57
; 0x84dc5 + 48 bytes

_UnnamedText_5a1e2: ; 0x84df5
    db $0, "I'm", $4f
    db "stunned!", $58
; 0x84df5 + 13 bytes

_UnnamedText_5a1e7: ; 0x84e02
    db $0, "Nice try, but the", $4f
    db "boardroom is up", $55
    db "one more floor!", $57
; 0x84e02 + 51 bytes

_UnnamedText_5a1ec: ; 0x84e35
    db $0, "Enough of your", $4f
    db "silly games!", $57
; 0x84e35 + 29 bytes

_UnnamedText_5a1f1: ; 0x84e52
    db $0, "No", $4f
    db "continues left!", $58
; 0x84e52 + 20 bytes

_UnnamedText_5a1f6: ; 0x84e66
    db $0, "Are you satisfied", $4f
    db "with beating me?", $55
    db "Then go on home!", $57
; 0x84e66 + 53 bytes

_UnnamedText_62311: ; 0x84e9b
    db $0, "PRESIDENT: Thank", $4f
    db "you for saving", $55
    db "SILPH!", $51
    db "I will never", $4f
    db "forget you saved", $55
    db "us in our moment", $55
    db "of peril!", $51
    db "I have to thank", $4f
    db "you in some way!", $51
    db "Because I am rich,", $4f
    db "I can give you", $55
    db "anything!", $51
    db "Here, maybe this", $4f
    db "will do!", $58
; 0x84e9b + 200 bytes

INCBIN "baserom.gbc",$84f63,$84f74 - $84f63

_UnnamedText_6231c: ; 0x84f74
    db $0, "PRESIDENT: You", $4f
    db "can't buy that", $55
    db "anywhere!", $51
    db "It's our secret", $4f
    db "prototype MASTER", $55
    db "BALL!", $51
    db "It will catch any", $4f
    db "#MON without", $55
    db "fail!", $51
    db "You should be", $4f
    db "quiet about using", $55
    db "it, though.", $57
; 0x84f74 + 159 bytes

_UnnamedText_62321: ; 0x85013
    db $0, "You have no", $4f
    db "room for this.", $57
; 0x85013 + 28 bytes

_SilphCo11Text2: ; 0x8502f
    db $0, "SECRETARY: Thank", $4f
    db "you for rescuing", $55
    db "all of us!", $51
    db "We admire your", $4f
    db "courage.", $57

_SilphCo11Text3: ; 0x85075
    db $0, "Ah ", $52, "!", $4f
    db "So we meet again!", $51
    db "The PRESIDENT and", $4f
    db "I are discussing", $55
    db "a vital business", $55
    db "proposition.", $51
    db "Keep your nose", $4f
    db "out of grown-up", $55
    db "matters...", $51
    db "Or, experience a", $4f
    db "world of pain!", $57

_UnnamedText_62330: ; 0x85119
    db $0, "Arrgh!!", $4f
    db "I lost again!?", $58
; 0x85119 + 24 bytes

_UnnamedText_62335: ; 0x85131
    db $0, "Blast it all!", $4f
    db "You ruined our", $55
    db "plans for SILPH!", $51
    db "But, TEAM ROCKET", $4f
    db "will never fall!", $51
    db $52, "! Never", $4f
    db "forget that all", $55
    db "#MON exist", $55
    db "for TEAM ROCKET!", $51
    db "I must go, but I", $4f
    db "shall return!", $57
; 0x85131 + 165 bytes

_UnnamedText_62344: ; 0x851d6
    db $0, "Stop right there!", $4f
    db "Don't you move!", $57
; 0x851d6 + 34 bytes



