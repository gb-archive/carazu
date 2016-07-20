IF !DEF(SOUND_INC)
SOUND_INC SET 1 

; Equates 
FREQ_A4 EQU 1750

SWEEP_INC EQU $00
SWEEP_DEC EQU $08 

DUTY_12_5 EQU $00
DUTY_25   EQU $40
DUTY_50   EQU $80
DUTY_75   EQU $C0

MAX_VOL EQU $f0 
MIN_VOL EQU $00 
VOL_INC EQU $08 
VOL_DEC EQU $00 

WAVE_VOL_MUTE EQU $00 
WAVE_VOL_100 EQU $20 
WAVE_VOL_50 EQU $40 
WAVE_VOL_25 EQU $60

RESTART_SOUND EQU $80 
USE_COUNTER EQU $40 

; Procedures 
GLOBAL Initialize_Sound
GLOBAL PlaySound_1
GLOBAL PlaySound_2 
GLOBAL PlaySound_3 
GLOBAL PlaySound_4 

ENDC 