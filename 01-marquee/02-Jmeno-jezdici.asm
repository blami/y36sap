.include "m169def.inc"
.org 0x1000
.include "print.inc"

.org 0
jmp start


write:
	ldi		r31, 0x04
	ldi		r30, 0xFF
	mov		r17, r20
	mov		r18, r21


c1:
	cpi		r17, 8
	brlo	next
	ldi		r17, 2
next:
 	ld		r16, Z
	call show_char
	dec		r30
	inc 	r17
	dec 	r18
	brne c1
	ret

	
delay:
	ldi 	r17, 0xFF
a2:	ldi		r18, 0x0F
	dec 	r18
	brne	a2
	ldi 	r18, 0xFF
	dec 	r17
	brne 	delay
	ret


.org 0x100
start:
	ldi r16, 0xFF
	out SPL, r16
	ldi r16, 0x04
	out SPH, r16

	call init_disp


; ulozime slovo do zasobniku
; mezera pred a po kvuli mazani displeje	
	ldi		r16, ' '
	push	r16
	ldi		r16, 'A'
	push	r16
	ldi		r16, 'H'
	push	r16
	ldi		r16, 'O'
	push	r16
	ldi		r16, 'J'
	push	r16
	ldi		r16, ' '
	push	r16

	ldi		r31, 0x01
	ldi		r30, 0x00
	
	ldi		r21, 6
	ldi		r20, 2


pis:
	call write
	inc 	r20
	cpi 	r20, 8
	brlo pis
	ldi		r20, 2
	jmp pis


	rjmp PC
