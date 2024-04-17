.model flat,c

;extern "C" int CalcArraySum_(const int* x, int n);

.code

CalcArraySum_ proc
push ebp
mov ebp,esp

mov edx,[ebp+8]		;edx=x
mov ecx,[ebp+12]	;ecx=n
xor eax,eax

cmp ecx,0
jle InvalidCount

@@:
add eax,[edx]
add edx,4
dec ecx
jnz @B

InvalidCount:
pop ebp
ret

CalcArraySum_ endp

end