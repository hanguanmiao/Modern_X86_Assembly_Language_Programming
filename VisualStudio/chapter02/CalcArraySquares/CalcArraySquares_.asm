.model flat,c

.code
;extern "C" int CalcArraySquares_(int* y, const int* x, int n);
CalcArraySquares_ proc
push ebp
mov ebp,esp
push esi
push edi
push ebx

mov edi,[ebp+8]		;edi=y
mov esi,[ebp+12]	;esi=x
mov ecx,[ebp+16]	;ecx=n

xor eax,eax
cmp ecx,0		;check if array is valid
jle EmptyArray		
shl ecx,2
xor ebx,ebx

@@:
mov edx,[esi+ebx]
imul edx,edx
mov [edi+ebx],edx
add eax,edx
add ebx,4
cmp ebx,ecx
jl @B

EmptyArray:
pop ebx
pop edi
pop esi
pop ebp
ret

CalcArraySquares_ endp
end