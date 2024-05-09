.model flat,c

.const
r4_MinFloat	dword	0ff7fffffh
r4_MaxFloat	dword	 7f7fffffh

.code
;extern "C" bool CalcMinMax_(const float* a, int n, float* min, float* max);
; 0 error;  1 success
CalcMinMax_ proc
push ebp
mov ebp,esp

xor eax,eax
mov edx,[ebp+8]
mov ecx,[ebp+12]
test ecx,ecx
jle Done		;n<=0

fld [r4_MinFloat]
fld [r4_MaxFloat]

@@:
fld real4 ptr [edx]
fld st(0)

fcomi st(0),st(2)
fcmovnbe st(0),st(2)
fstp st(2)

fcomi st(0),st(2)
fcmovb st(0),st(2)
fstp st(2)

add edx,4
dec ecx
jnz @B

mov eax,[ebp+16]
fstp real4 ptr [eax]
mov eax,[ebp+20]
fstp real4 ptr [eax]
mov eax,1

Done:
pop ebp
ret
CalcMinMax_ endp
end