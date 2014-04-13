;10 SYS2061
.proc basic_bootstrap
*=$07f9
.word $0801
*=$0801
.word baseend
.word 10 ;Line
.byte $9E ;SYS
.asc "20480"
.byte 0
baseend
.word 0
.endproc
