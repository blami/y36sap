.include "m169def.inc"

.org $0000
rjmp reset

reset:
	ldi r16,high(RAMEND)
	out sph,r16
	ldi r16,low(RAMEND)
	out spl,r16

	rcall lcd

program:
	inc r16
 	sts LCDDR0,r16	;rozsvitit
 	rcall pockej
 	clr r16
   	sts LCDDR0,r16	;zhasni
 	rcall pockej
  	rjmp program


lcd:
	ldi r16,(1<<LCDCS)|(3<<LCDMUX0)|(7<<LCDPM0)
	sts LCDCRB, r16
	ldi r16,(0<<LCDPS0)|(7<<LCDCD0)	;32kHz
	sts LCDFRR, r16
	ldi r16,(1<<LCDCC3)|(1<<LCDCC2)|(1<<LCDCC1)
	sts LCDCCR, r16
	ldi r16,(1<<LCDEN)|(1<<LCDAB)
	sts LCDCRA, r16
	ret


pockej: 
	ldi r16,4
pockej2: 
	dec r0
    brne pockej2
    dec r1
	brne pockej2
	dec r16
    brne pockej2
    ret
