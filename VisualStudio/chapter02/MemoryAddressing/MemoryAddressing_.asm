.model flat,c


.const
FibVals	dword 0,1,1,2,3,5,8,13
		dword 21,34,55,89,144,233,377,610

NumFibVals_	 dword ($-FibVals)/sizeof(dword)
	public NumFibVals_

;extern "C" int MemoryAddressing_(int i, int* v1, int* v2, int* v3, int* v4);
;return: 0=error
;		 1=success

.code
MemoryAddressing_ proc

;function prologue
push ebp
mov ebp,esp
push ebx
push esi

;check i
xor eax,eax			; set error return
mov ecx,[ebp+8]
cmp ecx,0
jl InvalidIndex		; if i<0, jump
cmp ecx,NumFibVals_	
jge InvalidIndex	; if i>=NumFibVals_, jump

;BaseReg
mov ebx,offset FibVals	;ebx=FibVals
mov esi,[ebp+8]			;esi=i
shl	esi,2				;esi=i*4
add ebx,esi				;ebx= FibVals + i*4
mov eax,[ebx]
mov ecx,[ebp+12]		;ecx=v1
mov [ecx],eax		

;BaseReg+Disp
mov esi,[ebp+8]			;esi=i
shl esi,2				;esi=i*4
mov eax,[esi+FibVals]	
mov ecx,[ebp+16]
mov [ecx],eax

;BaseReg+IndexReg
mov ebx,offset FibVals	;ebx=FibVals
mov esi,[ebp+8]			;esi=i
shl esi,2				;esi=i*4
mov eax,[ebx+esi]
mov ecx,[ebp+20]
mov [ecx],eax

;BaseReg+IndexReg*ScaleFactor
mov ebx,offset FibVals	;ebx=FibVals
mov esi,[ebp+8]			;esi=i
mov eax,[ebx+esi*4]
mov ecx,[ebp+24]
mov [ecx],eax

mov eax,1		;set success return

InvalidIndex:
;function epilogue
pop esi
pop ebx
pop ebp
ret

MemoryAddressing_ endp
end