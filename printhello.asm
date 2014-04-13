;Writes uppercase hello world in the very beginning of the screen.
.proc write_hello_world

ldx #$00
loop lda message_hello,x
beq endloop
and #$3f ;correct case
sta $0400,x
inx
jmp loop
endloop
jmp endloop

message_hello
.byte "HELLO, WORLD!",0
.endproc
