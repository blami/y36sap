; definice pro nas typ procesoru
.include "m169def.inc"
; podprogramy pro praci s displejem





	

; Zacatek programu - po resetu
.org 0
jmp start

; Zacatek programu - hlavni program
.org 0x100
.include "print.inc"


; proc. multi - r24*r25
multi:
	push	r26
	clr		r26
multi_zero:
	add		r26, r24
	dec		r25
	brne 	multi_zero
	mov 	r24, r26
	pop 	r26
	ret


; proc. tohex - r24 do '0'-'F'
tohex:
	push	r25
	ldi		r25, 10
	cp		r24, r25
	brcs	tlow
	ldi		r25, 55
	add		r24, r25
	jmp 	tohex_end
tlow:
	ldi		r25, 48
	add		r24, r25
tohex_end:
	pop		r25
	ret
	
start:
    ; Inicializace zasobniku
	ldi r16, 0xFF
	out SPL, r16
	ldi r16, 0x04
	out SPH, r16
    ; Inicializace displeje
	call init_disp


;++ ukol1
/*
	ldi		r16, 5
	ldi		r17, 10
	ldi		r18, 58

	mov 	r24, r16
	ldi		r25, 4

	call 	multi 
	mov 	r20, r24

	mov 	r24, r17
	ldi 	r25, 3
	call 	multi 
	add 	r20, r24

	
	sbc 	r20, r18
	asr 	r20
	asr 	r20
	asr 	r20
*/
;-- ukol1

;++ ukol2
	ldi 	r16, 0x0F

	mov 	r20, r16
	mov 	r21, r16

	andi 	r20, 0b00001111
	andi 	r21, 0b11110000
	lsr 	r21
	lsr 	r21
	lsr 	r21
	lsr 	r21

	
	mov 	r24, r20
	call 	tohex
	mov 	r20, r24

	mov 	r24, r21
	call 	tohex
	mov 	r21, r24


	mov		r16, r21
	ldi		r17, 2
	call	 show_char
	
	mov 	r16, r20
	ldi		r17, 3
	call 	show_char	
	


;-- ukol2

;-- ukol3
	ldi 	r16, 0xA0
	ldi 	r17, 0xFF
	ldi 	r18, 0x00
	ldi 	r19, 0x11

	ldi 	r20, 0xFF
	ldi 	r21, 0x00
	ldi		r22, 0x00
	ldi		r23, 0x01

	mov		r31, r23
	clr 	r30
	
	add		r19, r23
	adc		r18, r22
	adc 	r17, r21
	adc		r16, r20

	
;++ ukol3

/*
	; *** ZDE muzeme psat nase instrukce
	ldi r16, 'A'	; znak
	ldi r17, 2      ; pozice (zacinaji od 2)
	call show_char  ; zobraz znak

*/	; Zastavime program - nekonecna smycka
	rjmp PC

