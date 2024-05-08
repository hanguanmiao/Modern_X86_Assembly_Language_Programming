.model flat,c

.code
;extern "C" bool CalcMeanStdev_(const double* a, int n, double* mean, double* stdev);
;0 error
;1 success

CalcMeanStdev_ proc
push ebp
mov ebp,esp
sub esp,4

xor eax,eax
mov ecx,[ebp+12]
cmp ecx,1
jle Done
dec ecx
mov [ebp-4],ecx
inc ecx

mov edx,[ebp+8]
fldz				;st(0)=0

@@:
fadd real8 ptr [edx]
add edx,8
dec ecx
jnz @B
fidiv dword ptr [ebp+12]

mov edx,[ebp+8]
mov ecx,[ebp+12]
fldz				;st(0)=0,st(1)=mean

@@:
fld real8 ptr [edx]
fsub st(0),st(2)	;x-mean
fmul st(0),st(0)
faddp
add edx,8
dec ecx
jnz @B
fidiv dword ptr [ebp-4]
fsqrt

mov eax,[ebp+20]
fstp real8 ptr [eax]
mov eax,[ebp+16]
fstp real8 ptr [eax]
mov eax,1

Done:
mov esp,ebp
pop ebp
ret
CalcMeanStdev_ endp
end