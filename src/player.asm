; Includes
INCLUDE "include/constants.inc"
INCLUDE "include/globals.inc"
INCLUDE "include/rect.inc"
INCLUDE "include/input.inc"
INCLUDE "include/player.inc"
INCLUDE "include/level.inc"
INCLUDE "include/sound.inc"
INCLUDE "include/util.inc"
INCLUDE "tiles/player_sprite_tiles.inc"

; Constants
PLAYER_HORI_SPEED EQU $0100
GRAVITY EQU $0015
GRAVITY_HOLD EQU $0010
JUMP_SPEED EQU $FD80
PLAYER_HORI_ACCEL EQU $0020
PLAYER_MAX_HORI_SPEED EQU $0100 
PLAYER_MIN_HORI_SPEED EQU $ff00 
PLAYER_MAX_HORI_SPEED_ALLEGRO EQU $0200 
PLAYER_MIN_HORI_SPEED_ALLEGRO EQU $fe00 
PLAYER_MAX_VERT_SPEED EQU $0400
PLAYER_MIN_VERT_SPEED EQU $0 - PLAYER_MAX_VERT_SPEED

PLAYER_ANIM_AIR_PATTERN EQU 8 
PLAYER_ANIM_IDLE_PATTERN EQU 12 
PLAYER_ANIM_WALK0_PATTERN EQU 0
PLAYER_ANIM_WALK1_PATTERN EQU 4 


	SECTION "PlayerData", BSS 

PlayerRect:
DS 6 

fYVelocity:
DS 2 
fXVelocity:
DS 2 

PlayerGrounded:
DS 1 

PlayerFlipX
DS 1 

WalkAnimCounter:
DS 1 

PlayerSpritePattern:
DS 1 




	SECTION "PlayerCode", HOME 

Player_Initialize::

	ld a, 8
	ld [PlayerRect], a 					; x (integer)
	ld a, 0
	ld [PlayerRect + 1], a 				; x (fractional)
	ld a, 128				
	ld [PlayerRect + 2], a 				; y (integer)
	ld a, 0 
	ld [PlayerRect + 3], a 				; y (fractional)
	ld a, 8
	ld [PlayerRect + 4], a 				; width 
	ld a, 12 
	ld [PlayerRect + 5], a 				; height
	

	ld a, 0 
	ld [fYVelocity], a 			; (integer)
	ld [fYVelocity + 1], a 
	ld [fXVelocity], a 			; (integer)
	ld [fXVelocity + 1], a 
	
	ld a, 0 
	ld [PlayerGrounded], a 
	
	ld a, 0 
	ld [PlayerFlipX], a 
	
	ld a, 0 
	ld [WalkAnimCounter], a 
	
	ld a, PLAYER_ANIM_IDLE_PATTERN
	ld [PlayerSpritePattern], a 
	
	ret 
	

Player_Update::
	
	; prepare params for MoveRect_Integer function 
	ld bc, $0000 
	ld de, $0000  
	
.check_left			
	ld a, [InputsHeld]
	and BUTTON_LEFT
	jp z, .check_right
	ld a, [fXVelocity]
	ld h, a 
	ld a, [fXVelocity + 1]
	ld l, a 
	ld bc, $0 - PLAYER_HORI_ACCEL
	add hl, bc 		; subtract hori accel
	ld b, h 
	ld c, l 		; bc = new hori speed 
	ld a, b
	ld [fXVelocity], a 
	ld a, c 
	ld [fXVelocity + 1], a ; save new x velocity 
	ld a, %00000010 
	ld [PlayerFlipX], a 
	jp .check_grounded
	
.check_right 
	ld a, [InputsHeld]
	and BUTTON_RIGHT
	jp z, .apply_drag 
	ld a, [fXVelocity]
	ld h, a 
	ld a, [fXVelocity + 1]
	ld l, a 
	ld bc, PLAYER_HORI_ACCEL
	add hl, bc 		; bc = new hori speed 
	ld b, h 
	ld c, l 		; bc = new hori speed 
	ld a, b
	ld [fXVelocity], a 
	ld a, c 
	ld [fXVelocity + 1], a ; save new x velocity 
	ld a, 0 
	ld [PlayerFlipX], a 
	jp .check_grounded
	
.apply_drag 
	ld a, [fXVelocity]
	ld b, a 
	ld a, [fXVelocity + 1]
	ld c, a 
	
	ld a, b 
	and $80 
	jp z, .apply_drag_right
	ld hl, PLAYER_HORI_ACCEL
	add hl, bc 
	bit 7, h
	jp z, .set_vel_0
	ld b, h 
	ld c, l 
	ld a, b
	ld [fXVelocity], a 
	ld a, c 
	ld [fXVelocity + 1], a ; save new x velocity 
	jp .check_grounded
.apply_drag_right 
	ld hl, 0 - PLAYER_HORI_ACCEL
	add hl, bc 
	bit 7, h
	jp nz, .set_vel_0
	ld b, h 
	ld c, l 
	ld a, b
	ld [fXVelocity], a 
	ld a, c 
	ld [fXVelocity + 1], a ; save new x velocity 
	jp .check_grounded 
.set_vel_0
	ld bc, 0 
	ld a, b
	ld [fXVelocity], a 
	ld a, c 
	ld [fXVelocity + 1], a ; save new x velocity 
	; jp .check_grounded
	
.check_grounded	
	ld a, [PlayerGrounded]
	cp 0 
	jp z, .apply_gravity
	
	; player is marked as grounded, but check if grounded 
	; in case the player has moved off a platform 
	ld hl, PlayerRect
	ld a, [LevelColThresh]
	push bc
	push de 
	call CheckRectGrounded_Fixed
	pop de 
	pop bc 
	
	cp 1 
	jp z, .check_jump 
	ld [PlayerGrounded], a 				; save player as not grounded 
	jp .apply_gravity

.check_jump
	ld a, [InputsHeld]					; player is not grounded, so check for jump
	and BUTTON_A
	jp z, .update_player_animation 			; y-vel is already zeroed so go to move call 
	
	; Adjust veloctiy
	ld hl, JUMP_SPEED
	ld d, h
	ld e, l 							; set yvel param for move rect subroutine call 
	ld a, h
	ld [fYVelocity], a 
	ld a, l 
	ld [fYVelocity + 1], a 				; set the y velocity to the jump velocity 
	ld a, 0 
	ld [PlayerGrounded], a 				; set grounded to 0 so player cant jump again
	jp .update_player_animation 
	
.apply_gravity
	ld a, [fYVelocity]
	ld d, a 
	ld a, [fYVelocity + 1]
	ld e, a 
	ld a, [InputsHeld]
	and BUTTON_A 
	jp z, .use_default_gravity
	ld hl, GRAVITY_HOLD
	jp .add_gravity
.use_default_gravity
	ld hl, GRAVITY
.add_gravity
	add hl, de 
	ld d, h
	ld e, l 							; set resulting yvel for move rect subroutine 
	ld a, h 			
	ld [fYVelocity], a 
	ld a, l 
	ld [fYVelocity + 1], a 		; save the resulting yvel for next frame 
	
.update_player_animation
	; do not disrupt any registers besides a and hl 
	; because they have already been set with parameters meant for 
	; the move player rect routine 
	ld a, [PlayerGrounded]
	cp 0 
	jp z, .set_anim_air
	ld a, b 
	or c 
	jp z, .set_anim_idle
	ld a, [WalkAnimCounter]
	inc a 
	ld [WalkAnimCounter], a 
	bit 3, a 
	jp z, .set_anim_walk1
	ld a, PLAYER_ANIM_WALK0_PATTERN
	ld [PlayerSpritePattern], a 		; set anim pattern walk0
	jp .clamp_velocity
	
.set_anim_air 
	ld a, PLAYER_ANIM_AIR_PATTERN
	ld [PlayerSpritePattern], a 		; set anim pattern air 
	jp .clamp_velocity
.set_anim_idle
	ld a, PLAYER_ANIM_IDLE_PATTERN
	ld [PlayerSpritePattern], a 		; set anim pattern idle 
	jp .clamp_velocity
.set_anim_walk1
	ld a, PLAYER_ANIM_WALK1_PATTERN 
	ld [PlayerSpritePattern], a 		; set anim pattern walk1 

.clamp_velocity
	ld a, b 
	and $80 
	jp nz, .clamp_hori_neg
	ld a, b 
	cp (PLAYER_MAX_HORI_SPEED >> 8)
	jp c, .move_player_rect 	; nothing to clamp, move rect 
	ld bc, PLAYER_MAX_HORI_SPEED
	ld a, b 
	ld [fXVelocity], a 
	ld a, c 
	ld [fXVelocity + 1], a 	  ; save clamped xvel 
	jp .move_player_rect
.clamp_hori_neg
	ld a, b 
	cp (PLAYER_MIN_HORI_SPEED >> 8)
	jp nc, .move_player_rect
	ld bc, PLAYER_MIN_HORI_SPEED
	ld a, b 
	ld [fXVelocity], a 
	ld a, c 
	ld [fXVelocity + 1], a 	  ; save clamped xvel 
	jp .move_player_rect

.move_player_rect
	ld a, [LevelColThresh]
	ld hl, PlayerRect
	call MoveRect_Fixed
	bit BIT_COLLIDED_DOWN, a 
	jp z, .check_hit_up 
	
	; player hit something moving down, mark as grounded 
	ld a, 1 
	ld [PlayerGrounded], a 			; player collided downward so load grounded = 1 
	
	; player collided with something moving down, zero y velocity
	ld a, 0 
	ld [fYVelocity], a 
	ld [fYVelocity + 1], a 
	jp .return
	
.check_hit_up
	bit BIT_COLLIDED_UP, a 
	jp z, .return 
	
	; player collided with something moving up, zero y velocity
	ld a, 0 
	ld [fYVelocity], a 
	ld [fYVelocity + 1], a 
	
.return
	ret
	
Player_UpdateLocalOAM::


	; Update player OAM 
	ld hl, PlayerRect			
	push hl 					; param0 = rect address 
	ld hl, LocalOAM				
	push hl 					; param1 = oam address 
	ld b, 4 
	ld c, 4 
	push bc 					; param2 = rect offset x / y 
	ld b, 2  
	ld c, 2  
	push bc 					; param3 = sprite char width/height 
	ld a, [PlayerSpritePattern]
	ld b, a  
	ld c, 0 
	push bc 					; param4 = sprite pattern, sprite OBJ index 
	ld b, 0 
	ld a, [PlayerFlipX]
	ld c, a  
	push bc 					; param5 = 0, flip flags 
	call UpdateOAMFromRect_Fixed
	ret 
	
Player_SetPosition::
	ld a, b 
	ld [PlayerRect], a 
	ld a, c 
	ld [PlayerRect + 2], a 
	ret 
	
Player_LoadGraphics::
	ld b, 0 			; load sprite tiles
	ld c, 16 			; player needs 16 sprite tiles 
	ld d, PlayerSpriteTilesBank		;rom bank 
	ld e, 0 			; player sprite tiles start from index 0
	ld hl, PlayerSpriteTiles 
	call LoadTiles 
	
	ret 