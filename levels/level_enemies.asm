INCLUDE "levels/level_enemies.inc"
INCLUDE "include/constants.inc"

	SECTION "LevelEnemies", DATA, BANK[1]
	
Level0Enemies:
	DB ENEMY_SLIME, 39, 15, 37, 40
	DB ENEMY_SLIME, 47, 11, 44, 49 
	DB ENEMY_NONE
	
Level1Enemies:
	DB ENEMY_NONE
	
Level2Enemies:
	DB ENEMY_NONE
	
Level3Enemies:
	DB ENEMY_SLIME, 20, 26, 20, 60
	DB ENEMY_SLIME, 64, 11, 64, 98
	DB ENEMY_NONE