.include "bootstrap.asm"
.include "charset.asm"
*=$2000

.proc main_proc

;Set multicolor mode
;lda $D016
;ora #$10
;sta $D016

;Set character set
lda $D018
;set character base adress to 0x1000
;and #%11110001 
;ora #%11110101
;sta $D018

;fill screen with 0
lda #$00 ;setup zero page to point 
sta $00  ;at 0x0400. (start of screen)
lda #$04
sta $01

newloop lda #$42
ldy #$FF

loop sta ($00),y
dey
bne loop ;if y isn't zero set more

inc $01 ;increment high end zero page
lda $01
cmp #$08
bne newloop ;stop when high end reaches 8.

end
;finalloop
;jmp finalloop

.endproc
