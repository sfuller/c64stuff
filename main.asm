.include "bootstrap.asm"
.include "charset.asm"
*=$5000

;Setup VIC control register 2
;Turn on multicolor mode (bit 4), set to 38-column mode (as opposed to 40) (bit 3)
;Set multicolor mode
lda $D016
and #%11100111
ora #%00010000
sta $D016

;Set bitmap mode
lda $D011
ora #%00100000
sta $D011

lda #$0b
sta $D020
lda #$08
sta $D021

;Set character set
lda $D018
;set character base adress to 0x3800 (bits 1-3), and set bitmap to 0x2000 (bit 3)
and #%11110001 
ora #%00001110
sta $D018

.proc clear_screen_memory
;fill screen with 0
lda #$00 ;setup zero page to point 
sta $02  ;at 0x0400. (start of screen)
lda #$04
sta $03
lda #$00 ;setup zero page to point
sta $04  ;at 0xD800 (colors)
lda #$D8
sta $05

newloop
ldy #$00

loop 
lda #%01110101
sta ($02),y
lda #%00000000
sta ($04),y
iny
bne loop ;loop again if y hasn't reached 0 again

inc $03 ;increment high end zero page
inc $05
lda $03
cmp #$08
bne newloop ;stop when high end reaches 8.
.endproc

.proc copy_tiles_to_bitmap
;copy to bitmap
lda #$00 ;setup zero page pointer to bitmap
sta $02
lda #$20
sta $03

newloop
ldy #$00
ldx #$00
loop
lda $4000, x
sta ($02), y
inx
cpx #$08
bne skip_reset_x
ldx #$00
skip_reset_x
iny
bne loop

inc $03
lda $03
cmp #$40
bne newloop
.endproc

.proc setup_raster_interrupt
;sei ;disable maskable irqs

;lda #$7f ;disable cia interrupts
;sta $dc0d
;sta $dd0d

;lda $dc0d ;read from bits to accept any interrups that may be pending
;lda $dd0d

;lda #$01 ;turn on raster interrupt
;sta $d01a

;lda #$20 ;set raster interrupt at line 32
;sta $d012

;lda # ;turn off basic and kernal rom

.endproc

.proc do_scrolling
finalloop
jmp finalloop

lda $D016
and #%00000111
sbc #$01
bne no_reset
lda #$00
no_reset
sta $D016
jmp finalloop
.endproc

