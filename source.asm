;
; source.asm
;
; Created: 26.03.2025 20:32:36
; Author : fbuesser
;


start:

ldi r16, 0b00000010
clr r0
ldi r17, 0xD8
sts 0x0034, r17
sts 0x0061 , r0 ;clock prescaler division 0 dafür: CCP setzen!!!

sts 0x0400, r16; Data direction register


senddata:
sts 0x0404, r0; output aus
rcall delay_1000 ;reset-time warten
rcall delay_1000

sts 0x0404, r16; output auf an setzen

nop
nop
nop
nop

; 1.LED
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit

rcall zero_bit
rcall zero_bit
rcall one_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit

rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall one_bit
rcall one_bit
rcall one_bit

;2. LED
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit

rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall one_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit

rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall one_bit
rcall one_bit

;3. LED
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall one_bit
rcall one_bit
rcall one_bit

rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall one_bit
rcall zero_bit

rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit


;4. LED
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall zero_bit

rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall one_bit
rcall one_bit
rcall one_bit
rcall one_bit
rcall one_bit

rcall zero_bit
rcall zero_bit
rcall zero_bit
rcall one_bit
rcall one_bit
rcall one_bit
rcall one_bit
rcall one_bit

rjmp end 


zero_bit: ;nimm an, pin ist an
;4 zyklen vom vorigen Aufruf der Routine, 2 Zyklen vom Aufruf mit rcall
;lso 6 Zyklen nichts
sts 0x0404, r0  ;nach 2 zyklen ist Pin wieder aus, 8 zyklen an also
nop 
nop 
nop 
nop 
nop 
nop 
nop 
nop 
nop 
nop 
nop 
nop 
nop 
nop 
nop  ;14 Zyklen aus
sts 0x0404, r16  ;nach 16 Zyklen wieder an
ret ;return (4 cycles)

one_bit: ;nimm an, pin ist an
;4 Zyklen vom vorigen Aufruf, 2 Zyklen vom rcall
nop 
nop 
nop 
nop 
nop 
nop 
nop 
nop 
nop  ;14 Zyklen an
sts 0x0404, r0  ;nach 2 Zyklen aus, war also 16 Zyklen an
nop 
nop 
nop 
nop 
nop 
nop  ;6 Zyklen nichts
sts 0x0404, r16  ; war also 8 Zyklen aus
ret 


delay_6: ;2 Zyklen rcall
ret ;4 zyklen

delay_24: ;2 zyklen
rcall delay_6
rcall delay_6
rcall delay_6
ret ;4 zyklen

delay_78: ;2 zyklen
rcall delay_24
rcall delay_24
rcall delay_24
ret ;4 zyklen

delay_240: ;2 zyklen
rcall delay_78
rcall delay_78
rcall delay_78
ret ; 4 zyklen

delay_1000: ;2 zyklen
rcall delay_240
rcall delay_240
rcall delay_240
rcall delay_240
rcall delay_24
rcall delay_6
nop
nop
nop
nop
ret ; 4 zyklen

end: 
rcall delay_1000
rcall delay_1000
rcall delay_1000
rcall delay_1000
rcall delay_1000
rcall delay_1000
rcall delay_1000
rcall delay_1000
rcall delay_1000
rcall delay_1000
rjmp senddata



