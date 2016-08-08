INCLUDE "levels/level_enemies.inc"
INCLUDE "include/constants.inc"

; Equates
SLIME_DEF_XVEL EQU $00C0 >> 3 
SLIME_XVEL_FAST EQU $0180 >> 3 
SLIME_XVEL_SLOW EQU $0050 >> 3 
SLIME_XVEL_TEST1 EQU $0160 >> 3 
SLIME_XVEL_TEST2 EQU $0120 >> 3 
SLIME_XVEL_TEST3 EQU $00D0 >> 3 
SLIME_XVEL_TEST4 EQU $0080 >> 3 
SLIME_XVEL_TEST5 EQU $0040 >> 3 
SLIME_DEF_YVEL EQU (0 - $0400) >> 3 

BIRDY_DEF_XVEL EQU $0120 >> 3 

	SECTION "LevelEnemies", DATA, BANK[1]
	
Level0Enemies:
	DB ENEMY_SLIME, 39, 15, 37, 40, SLIME_DEF_XVEL, 0, 0 
	DB ENEMY_SLIME, 47, 11, 44, 49, SLIME_XVEL_SLOW, SLIME_DEF_YVEL, SLIME_FLAG_JUMP 
	DB ENEMY_NONE
	
Level1Enemies:
	DB ENEMY_BIRDY, 25, 11, 10, 25, BIRDY_DEF_XVEL, 0, 0 
	DB ENEMY_SLIME, 1, 6, 1, 7, SLIME_DEF_XVEL, 0, 0 
	DB ENEMY_NONE
	
Level2Enemies:
	DB ENEMY_NONE
	
Level3Enemies:
	DB ENEMY_SLIME, 20, 26, 20, 60, SLIME_DEF_XVEL, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 64, 11, 64, 98, SLIME_DEF_XVEL, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST1, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST2, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST3, SLIME_DEF_YVEL, SLIME_FLAG_JUMP 
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST4, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST5, SLIME_DEF_YVEL, SLIME_FLAG_JUMP 
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST1, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST2, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST3, SLIME_DEF_YVEL, SLIME_FLAG_JUMP 
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST4, SLIME_DEF_YVEL, SLIME_FLAG_JUMP 
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST5, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST1, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST2, SLIME_DEF_YVEL, SLIME_FLAG_JUMP 
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST3, SLIME_DEF_YVEL, SLIME_FLAG_JUMP 
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST4, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST5, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST1, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST2, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_SLIME, 109, 71, 109, 116, SLIME_XVEL_TEST3, SLIME_DEF_YVEL, SLIME_FLAG_JUMP  
	DB ENEMY_NONE