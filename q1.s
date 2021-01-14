		AREA q1.s, CODE, READWRITE
		ENTRY 		
		
		LDR  r0,=STRING1 				; holds the string
		ADR  r1,EoS						; holds ascii value for end of string (null) = 0
		ADR  r2,STRING2                 ; holds the location at the start of the string we will build
		ADR  r5,#0                      ; using a registar as loop pointer for future convinece 	

loop    ADR  r3,[r0,r5]		         	; loading a byte for loop
		ADD  r6,r5						; making a second counter for future use
		CMP  r1,r3                      ; check for end of string	
		BEQ  finsh                      ; exit code			
		CMP  r5,#0						;checking the speacil case of starting with the word 'the' 		
		BEQ  check				
		CMP  r3, #32                  	; #32 is ascii value of a space and the first sign that we might encounter " the "
		BEQ  case		

store  	STR  r2,[r3],r5					; store the current pointer in r2
		ADD  r5,r5,#1 					; post increment r5 for functionality 
		B loop                   		; if no above conditions are met we incrment our index at start over @ loop		

case	ADD  r6,r6,#1					; when encountering a new word we increment our function pointer by one so that its moves from the space before the word to its first letter		
		B	check		

check	ADR r10,[r0,r6]					; add ascii vlaue to r10 
		SUB r10,r10,#32                 ; so that we dont run out of memory we strip 32 from the aski vlaue, 32 becuase it is the lost value we may find in strings of text
		ADD r4,r4,r10					; stores ascii's in r4
		ADD r6,r6,#1					; increment r6 by one
		SUB r7,r6,r5   					; check to see if we have counted 3 characters forward(length of the word "the")
		CMP r7,#4                       ; if we went 3 spots check vlaue
		BEQ Wvalue

Wvalue  ADD r11,#225					; ascii value of "the_" - #32 per word =225
		CMP r4,r11						; compare to the total we saved in r4
		BEQ Index						; if  equal branch to index to handle skipping of "the_"
		B store

Index   ADD r5,r5,#4					; skip the next 4 index points to skip the word "the" 
		B store		

finish  B finish
		AREA q1.s, DATA, READWRITE

STRING1 DCB "and the man said they must go" ;String1
EoS 	DCB 0x00   ;end of string1
STRING2 space 0xFF ;just allocating 255 bytes 
		END
