		AREA q2, CODE, READWRITE
		ENTRY
		
		LDRSB 	r0,d_num 					; Loads d value
		LDRSB 	r1,a_num  					; Loads a value	
		LDRSB 	r2,b_num 					; Loads b value	
		LDRSB 	r3,c_num					; Loads c value
		LDRSB 	r4,x_num					; Loads d value	
		PUSH 	{r1,r2}					    ; Push values to stack in order b,a	
loop	POP 	{r7}						; Pop a value into r7 
		MLA		r3,r4,r7,r3					; x(^n)*poped + running sum, where n is incremented by line 13
		MOV		r8,r4						; in order to use MUL on itself we need to use a second register
		MUL		r4,r8,r4					; x(^n+1)
		CMP   	r7,r1						; if we poped value 'a' then we are done
		BEQ		check						; branch to see what value we return d or x
		B loop								; else repeat loop
check	CMP 	r0,r3						; If y is less then d store y in r0 otherwise do nothing to it
		MOVGT	r0,r3
exit	B	exit
		AREA q2, CODE, READWRITE
a_num	DCD 5         
b_num	DCD 6
c_num	DCD	7
d_num	DCD 90
x_num	DCD 3	
		ALIGN
		END