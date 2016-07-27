INCLUDE "include/menu.inc"
INCLUDE "include/font.inc"
INCLUDE "include/util.inc"
INCLUDE "include/globals.inc"
INCLUDE "include/input.inc"
INCLUDE "include/constants.inc"

	SECTION "MenuVars", BSS 
	
MenuCursor:
DS 1 


	SECTION "MenuGraphics", HOME 
	
MenuBGMapWidth  EQU 20
MenuBGMapHeight EQU 18
MenuBGMapBank   EQU 0

MenuTilesBank EQU 0
MenuBGTileCount EQU 24 
MenuSpriteTileCount EQU 1 

Str_NewGame:
DB "NEW GAME",0

Str_Continue:
DB "CONTINUE",0

MenuBGMap::
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$00,$02,$04,$06,$08,$0A
DB $04,$06,$0C,$0E,$10,$12,$17,$17,$17,$17
DB $17,$17,$17,$17,$01,$03,$05,$07,$09,$0B
DB $05,$07,$0D,$0F,$11,$13,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17
DB $17,$17,$17,$17,$17,$17,$17,$17,$17,$17

MenuBGTiles::
DB $00,$03,$03,$1C,$0F,$30,$1F,$60
DB $3C,$43,$38,$44,$30,$48,$30,$48
DB $30,$48,$30,$48,$38,$44,$3C,$43
DB $1F,$60,$0F,$30,$07,$18,$00,$0F
DB $00,$E0,$C0,$38,$F0,$0C,$F8,$06
DB $1C,$E2,$00,$3E,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$3E,$1C,$E2
DB $FC,$02,$F8,$06,$E0,$1C,$00,$F0
DB $00,$00,$00,$00,$00,$01,$00,$01
DB $01,$02,$01,$02,$03,$04,$03,$04
DB $07,$08,$06,$09,$06,$09,$0F,$10
DB $0C,$13,$1C,$22,$1C,$22,$00,$3E
DB $00,$00,$00,$80,$80,$40,$80,$40
DB $C0,$20,$C0,$20,$E0,$10,$60,$90
DB $70,$88,$30,$48,$30,$C8,$F8,$04
DB $18,$E4,$1C,$22,$1C,$22,$00,$3E
DB $00,$00,$00,$3F,$1F,$20,$1F,$20
DB $1C,$23,$1C,$22,$1C,$23,$1F,$20
DB $1F,$20,$1F,$20,$1F,$20,$1F,$20
DB $1C,$23,$1C,$22,$1C,$22,$00,$3E
DB $00,$00,$00,$F0,$F0,$08,$F8,$04
DB $38,$C4,$38,$44,$38,$C4,$F8,$04
DB $F0,$08,$80,$70,$C0,$20,$E0,$10
DB $F0,$08,$78,$84,$38,$44,$00,$3C
DB $00,$00,$00,$3F,$1F,$20,$1F,$20
DB $00,$3F,$00,$00,$00,$00,$00,$01
DB $01,$02,$03,$04,$07,$08,$0E,$11
DB $1C,$23,$1F,$20,$1F,$20,$00,$3F
DB $00,$00,$00,$FC,$F8,$04,$F8,$04
DB $38,$C4,$38,$44,$70,$88,$E0,$10
DB $C0,$20,$80,$40,$00,$80,$00,$00
DB $00,$FC,$F8,$04,$F8,$04,$00,$FC
DB $00,$00,$00,$3C,$18,$24,$18,$24
DB $18,$24,$18,$24,$18,$24,$18,$24
DB $18,$24,$18,$24,$18,$24,$1C,$22
DB $1E,$21,$0F,$10,$07,$08,$00,$07
DB $00,$00,$00,$1E,$0C,$12,$0C,$12
DB $0C,$12,$0C,$12,$0C,$12,$0C,$12
DB $0C,$12,$0C,$12,$0C,$12,$1C,$22
DB $3C,$C2,$F8,$04,$F0,$08,$00,$F0
DB $00,$04,$00,$06,$00,$07,$00,$04
DB $00,$3C,$38,$44,$38,$44,$00,$38
DB $00,$3C,$3C,$42,$72,$8D,$76,$89
DB $66,$99,$66,$99,$3C,$42,$00,$3C
DB $00,$70,$30,$48,$38,$44,$3C,$42
DB $3C,$42,$38,$44,$30,$48,$00,$70
DB $00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00

MenuSpriteTiles::
DB $00,$70,$30,$48,$38,$44,$3C,$42
DB $3C,$42,$38,$44,$30,$48,$00,$70

	SECTION "MenuProcedures", HOME 
	
Menu_UpdateCursorSprite::
	ld a, [MenuCursor]
	cp 0 
	jp z, .cursor_0
	cp 1
	jp z, .cursor_1
	
.cursor_0 
	ld a, 96
	ld [LocalOAM], a 
	ld a, 46 
	ld [LocalOAM+1], a 
	ld a, 0 
	ld [LocalOAM+2], a
	ld a, $00
	ld [LocalOAM+3], a 
	ret 
	
.cursor_1 
	ld a, 112
	ld [LocalOAM], a 
	ld a, 46 
	ld [LocalOAM+1], a 
	ld a, 0 
	ld [LocalOAM+2], a
	ld a, $00
	ld [LocalOAM+3], a 
	ret 
	
Menu_Load::

	; Reset cursor position
	ld a, 0
	ld [MenuCursor], a 
	
	ld hl, MenuSpriteTiles
	ld b, 0 	; load sprite tiles 
	ld c,	MenuSpriteTileCount
	ld d, 0 	; Home bank
	ld e, 0 	; tile index 
	call LoadTiles
	
	ld hl, MenuBGTiles
	ld b, 1 	; load bg tiles 
	ld c, MenuBGTileCount 
	ld d, 0 	; Home bank 
	ld e, 0 	; tile index 
	call LoadTiles 
	
	call Font_LoadFull 

	ld b, MenuBGMapWidth
	ld c, MenuBGMapHeight
	push bc 
	ld hl, MenuBGMap 
	ld b, 0 	; x offset 
	ld c, 0     ; y offset 
	ld d, 0 	; rom bank 0 
	ld e, 0 	; BG map, not window 
	call LoadMap

	ld hl, Str_NewGame
	ld b, 6		; x coord
	ld c, 10	; y coord  
	ld d, 0       ; BG 
	call WriteText
	
	ld hl, Str_Continue
	ld b, 6
	ld c, 12 
	ld d, 0 
	call WriteText
	
	ret
	
Menu_Update::

; Handle input 
.check_up
	ld a, [InputsPrev]
	and BUTTON_UP
	cpl 
	ld b, a 
	ld a, [InputsHeld]
	and BUTTON_UP 
	and b 
	jp z, .check_down
	ld a, 0 
	ld [MenuCursor], a 
	
.check_down
	ld a, [InputsPrev]
	and BUTTON_DOWN 
	cpl 
	ld b, a 
	ld a, [InputsHeld]
	and BUTTON_DOWN 
	and b 
	jp z, .update_obj 
	ld a, 1 
	ld [MenuCursor], a 
	
.update_obj
	call Menu_UpdateCursorSprite
	ret 
